Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4506C9936
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 02:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjC0A6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 20:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjC0A6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 20:58:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C279640C7;
        Sun, 26 Mar 2023 17:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9bdwyjERYCVoCsmHy8KLbCA56UNcg4WM5NtiDroCJUQ=; b=KosSnomXy/3gbPmJxvHVpJqNQQ
        qCtDofqgx5GpzXVZgB1AT+uX9Vj/kQYDa5GXW6/2xlF9zbMzNlLYLhy/MzdG9ffRYzLlYMd27MQoI
        W95t9eQM9JCuUhF6HSF2AyFp5vgsCn3WOLU3NVl6lj8heE+e9PGwiwZJcvjrWt0aBxLopJRQQ6ghO
        rhTKESjbP088Or9u2VkmOAmEzLBW0es4vnTpk0o7lbCvFWaZ38n2Uomc1sNMRlHtQtXxNWrtMnLAW
        FQhNPu28WNnuSlNBEmrnDbNxk+u/4cmJ3mlR52yGaqP668e3YEzI2TrClp3bFVCuOhdd0cLw1V0T5
        o6Y+48Gw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgbBv-009RMh-0L;
        Mon, 27 Mar 2023 00:58:31 +0000
Date:   Sun, 26 Mar 2023 17:58:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/31] ext4: Convert ext4_finish_bio() to use folios
Message-ID: <ZCDqN769Zsz0D6oc@infradead.org>
References: <20230126202415.1682629-5-willy@infradead.org>
 <87ttyy1bz4.fsf@doe.com>
 <ZBvG8xbGHwQ+PPQa@casper.infradead.org>
 <20230323145109.GA466457@frogsfrogsfrogs>
 <ZBxwnlKOZxHmLtdR@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBxwnlKOZxHmLtdR@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 03:30:38PM +0000, Matthew Wilcox wrote:
> I really want to see a cheaper abstraction for accessing the block device
> than BHs.  Or xfs_buf for that matter.

You literally can just use the bdev page cache using the normal page
cache helpers.  It's not quite what most of these file systems expect,
though, especially for the block size < PAGE_SIZE case.
