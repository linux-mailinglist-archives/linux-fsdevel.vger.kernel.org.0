Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0176A72D8FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 07:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbjFMFKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 01:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjFMFKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:10:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7161709;
        Mon, 12 Jun 2023 22:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vj20tbXpuV38jFvj1hgqhnxMQ+kSjSqyn5TwKawTWBk=; b=Bx6irnXUmY6429dlIyWXQ2L8fn
        tGPFZvphk9HxxUScME8Vy1l/eTbwU4z16pw2+FKFLLTCsTLk6j7+jDyHH2Yfy/NWWTagMK78xLZ0r
        84sGsYOxU6nH6SlTXcwIBjEKD2rV9xN52E38+M3KUCArq2bnjsZgzjJgPc1mE/LFIkO/KWH7A0CMA
        fWwuKOUd/Ay9T8LRt26sPO/u6NVk7H30+92hJDwgmttHVVlFYYo0Bxf2Jq9+ZptLWBCAsdnWtRN/R
        ZdNYfV7EIrE7MqAHqHrEruZ/uhXvH6miRwE7qbPR1vHyGswGQZyniA5q0H3GoNypkjX23zBzXyf0N
        FTubOfbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8wIY-006wZr-31;
        Tue, 13 Jun 2023 05:10:30 +0000
Date:   Mon, 12 Jun 2023 22:10:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <ZIf6RrbeyZVXBRhm@infradead.org>
References: <20230612161614.10302-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612161614.10302-1-jack@suse.cz>
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

> +config BLK_DEV_WRITE_HARDENING
> +	bool "Do not allow writing to mounted devices"
> +	help
> +	When a block device is mounted, writing to its buffer cache very likely
> +	going to cause filesystem corruption. It is also rather easy to crash
> +	the kernel in this way since the filesystem has no practical way of
> +	detecting these writes to buffer cache and verifying its metadata
> +	integrity. Select this option to disallow writing to mounted devices.
> +	This should be mostly fine but some filesystems (e.g. ext4) rely on
> +	the ability of filesystem tools to write to mounted filesystems to
> +	set e.g. UUID or run fsck on the root filesystem in some setups.

I'm not sure a config option is really the right thing.

I'd much prefer a BLK_OPEN_ flag to prohibit any other writer.
Except for etN and maybe fat all file systems can set that
unconditionally.  And for those file systems that have historically
allowed writes to mounted file systems they can find a local way
to decide on when and when not to set it.

