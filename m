Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E0B728EDE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 06:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjFIEUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 00:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFIEUb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:20:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889E11A1;
        Thu,  8 Jun 2023 21:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bf0Imcmrff8IiflvMMZwKHn+EPzovpKROa1e5HANUoM=; b=nue2TtmTamk9kJkszgPEGMpwte
        lhHnwHuuxogMyeD0BQGtvyzl9mYliO0ISA7i4oG4Eg26b4hQtdcmoQUUCz1Am7UpYm5S66D9LPRcN
        5/Uy48E/9SEM/MtyvLfTqnHleWvImTBEULArcgIPOro0eI0uH/g8x7xGkNc5T8q6fWD0qd8OLdc97
        ElapA2f8xr6rBQxc1qCGSsaN+zI29pxUboyrxPIpW2N4x9lZz6fqH1w//lOov0U+KiyyY8W/8QHLC
        OQ3XqldDQHaU2nU4fWrkx05LA8/dDA0VYONM/hMe7D6Vat+V5OW3FTF5aiXDBdyIfisWlNbvL2C/X
        YUBAuQVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q7Tbj-00Ba1H-02;
        Fri, 09 Jun 2023 04:20:15 +0000
Date:   Thu, 8 Jun 2023 21:20:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, djwong@kernel.org,
        dchinner@redhat.com, kbusch@kernel.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        patches@lists.linux.dev, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, corbet@lwn.net, jake@lwn.net
Subject: Re: [RFC 4/4] bdev: extend bdev inode with it's own super_block
Message-ID: <ZIKofhpTXREOR3ec@infradead.org>
References: <20230608032404.1887046-1-mcgrof@kernel.org>
 <20230608032404.1887046-5-mcgrof@kernel.org>
 <ZIHZngefNAtYtg7L@casper.infradead.org>
 <ZIHcl8epO0h3z1TO@infradead.org>
 <ZIITpjDXyupKom+N@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIITpjDXyupKom+N@bombadil.infradead.org>
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

On Thu, Jun 08, 2023 at 10:45:10AM -0700, Luis Chamberlain wrote:
> > > and then considering only two superblocks instead of having a list of
> > > all bdevs?
> > 
> > Or why the heck we would even do this to start with?
> 
> That's what I gathered you suggested at LSFMM on hallway talk.

No.  I explained you that sharing the superblock or has absolutely no
effct on the aops after you wanted to it.  I said it might be nice for
other reasons to have a sb per gendisk.

> > iomap has absolutely nothing to do with superblocks.
> > 
> > Now maybe it might make sense to have a superblock per gendisk just
> > to remove all the weird special casing for the bdev inode in the
> > writeback code.  But that's something entirely different than this
> > patch.
> 
> The goal behind this is to allow block devices to have its bdev cache
> use iomap, right now now we show-horn in the buffer-head aops if we
> have to build buffer-heads.
> 
> If this sort of approach is not desirable, let me know what alternative
> you would prefer to see, because clearly, I must not have understood
> your suggestion.

Again, every non-trivial file system right now has more than one set
of aops per superblock.  I'm not sure what problem you are trying to
solve here.
