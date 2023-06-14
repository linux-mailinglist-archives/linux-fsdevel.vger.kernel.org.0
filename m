Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2EF72F5B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 09:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjFNHO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 03:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243269AbjFNHOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:14:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB219B6;
        Wed, 14 Jun 2023 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QDgCx3SIIWcCISfVHe6Pr9DEXI/9X8oj+tSpv3TtUXM=; b=g6CpNO7r5p86RjmaiDHLcpFl0U
        HCQVfIYaHZJAQ54DQ3h6n+kWO6cudFQiV/fyby0dKHjr7Rv5JsBuDllFQX8iTw7jdZtDRmuDx/9cH
        UQapk3T8to19FxZY8orLPoJam2WJH8cVBwlC1st3xiV83FNeY4R9AAkrzZt4nijtxwb1rrL5wg4yc
        AXsuCboMP4lSQ49adU7hMvpJxfOyB+esBAvMXibxNDUlpoyrO8vUNWoJOGxgTnmGL7cwE6RjURwwF
        1qsAxh9svSnEgLxV/DyowHIJh9ZRA47b3RWmDWYxUyyIsdIr+C9Lcd/RyV8e00gqkyfDhFGQ5DJQQ
        5vu/65Kw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9Ki3-00AcR8-2j;
        Wed, 14 Jun 2023 07:14:27 +0000
Date:   Wed, 14 Jun 2023 00:14:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Colin Walters <walters@verbum.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Theodore Ts'o <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <ZIlo05E3HGDl4BK4@infradead.org>
References: <20230612161614.10302-1-jack@suse.cz>
 <20230612162545.frpr3oqlqydsksle@quack3>
 <2f629dc3-fe39-624f-a2fe-d29eee1d2b82@acm.org>
 <a6c355f7-8c60-4aab-8f0c-5c6310f9c2a8@betaapp.fastmail.com>
 <20230613113448.5txw46hvmdjvuoif@quack3>
 <20230614015550.GA11423@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614015550.GA11423@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 06:55:50PM -0700, Darrick J. Wong wrote:
> 
> I'd love it if filesystems actually /could/ lock down the parts of block
> devices they're using.  They could hand out write privileges to the open
> bdev fds at the same time that a block layout lease is created, and
> retract them when the lease terminates.  Areas before the fs (e.g. BIOS
> boot sector) could actually be left writable by filesystems that don't
> use that area; and anything beyond EOFS would still be writable (hello
> lvm).  Then xfs actually /could/ prevent you from blowing away mounted
> xfs filesystem.
> 
> ext4 could even still allow primary superblock writes to avoid breaking
> tune2fs, or they could detect secureboot lockdown and prohibit that.

Let's not overcomplicate things.  As said not allowing writes to
partitions through the whole block device is pretty trivial.  The
allowing to write into some areas of an otherwise fs owned device
(partition or whole) is just bogus.  We might have to support it for
extN (and maybe some other things) for legacy setups, but we really
need to add proper APIs for that and just disallow it for modern
setups instead of creating complex infrastructure to cater to this
fundamentally broken use case.

