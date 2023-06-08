Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA61728687
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 19:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjFHRpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 13:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjFHRpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:45:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761852D42;
        Thu,  8 Jun 2023 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uOw9nsuIMZAQbvG+gbUFnhoqu4Ev0+E/KCh6w/lkQ7I=; b=etOQcvEQDEvuze42GukPA1J9A9
        rwsj/PLos8V+QhVz5PjC0nnthLA7akuroDg3cj1QqCOZ6Z8M+KSieTjpIXe6i803tFqFQnuVseyDp
        0+5ezAsmAh+nbDffqzyioYt7UStuRuvPI385zwJZcoAQY/VGQjV1nMfGmAJAAWNyl2mGJQRiQ+i5Y
        FehkG3GqhYRb4FsRFByG7rNLTX4E0/kZHUmriAMDSW3rKpTT+3DfZxEt9IrjdPQmsTmuwUoUtDLnB
        F2NH+o/jLEb69nL7vzKne7WKcWpf45TeDjmurxCl59osSLZDht3OksMCelGH7dwRwdJzUSLd6YZhI
        meFi0kUw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q7Jh8-00A4le-2l;
        Thu, 08 Jun 2023 17:45:10 +0000
Date:   Thu, 8 Jun 2023 10:45:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, djwong@kernel.org,
        dchinner@redhat.com, kbusch@kernel.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        patches@lists.linux.dev, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, corbet@lwn.net, jake@lwn.net
Subject: Re: [RFC 4/4] bdev: extend bdev inode with it's own super_block
Message-ID: <ZIITpjDXyupKom+N@bombadil.infradead.org>
References: <20230608032404.1887046-1-mcgrof@kernel.org>
 <20230608032404.1887046-5-mcgrof@kernel.org>
 <ZIHZngefNAtYtg7L@casper.infradead.org>
 <ZIHcl8epO0h3z1TO@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIHcl8epO0h3z1TO@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 08, 2023 at 06:50:15AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 08, 2023 at 02:37:34PM +0100, Matthew Wilcox wrote:
> > On Wed, Jun 07, 2023 at 08:24:04PM -0700, Luis Chamberlain wrote:
> > > We currently share a single super_block for the block device cache,
> > > each block device corresponds to one inode on that super_block. This
> > > implicates sharing one aops operation though, and in the near future
> > > we want to be able to instead support using iomap on the super_block
> > > for different block devices.
> > 
> > > -struct super_block *blockdev_superblock __read_mostly;
> > 
> > Did we consider adding
> > 
> > +struct super_block *blockdev_sb_iomap __read_mostly;
> > 
> > and then considering only two superblocks instead of having a list of
> > all bdevs?
> 
> Or why the heck we would even do this to start with?

That's what I gathered you suggested at LSFMM on hallway talk.

> iomap has absolutely nothing to do with superblocks.
> 
> Now maybe it might make sense to have a superblock per gendisk just
> to remove all the weird special casing for the bdev inode in the
> writeback code.  But that's something entirely different than this
> patch.

The goal behind this is to allow block devices to have its bdev cache
use iomap, right now now we show-horn in the buffer-head aops if we
have to build buffer-heads.

If this sort of approach is not desirable, let me know what alternative
you would prefer to see, because clearly, I must not have understood
your suggestion.

  Luis
