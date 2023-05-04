Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA986F6F74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 17:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjEDP4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEDPz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 11:55:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8A349CF;
        Thu,  4 May 2023 08:55:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1BF7D1FD7E;
        Thu,  4 May 2023 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683215757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hs+BLfN/0kNjEK2oUqlUv453FE71ldsqaBdWU5OoWZo=;
        b=IULcFMzhZk2/u3IGIBLKjmfecbiZdNWFBMDe21BltjDT2hKk2qpnRs+9+Z2i50HzOG3uWY
        rIvlC54YVJaa5/G9wtDByFpEctWCEmOkiHzbUxK+fwxid4hJmwFcm1wS8hyRRh/O3GJAz9
        mcvGKcqtv+zjLI+tOZmzXQnOqUWkmnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683215757;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hs+BLfN/0kNjEK2oUqlUv453FE71ldsqaBdWU5OoWZo=;
        b=PJBKliX3YTxaHWg2wjYFrF5cfHLpLkaeDlTEYUJakGRbqJW16QM61U/JfUF6Fdm6xoQ6Df
        Tqs1ezMWlP87uTDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D44813444;
        Thu,  4 May 2023 15:55:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f3YpA43VU2RHMgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 04 May 2023 15:55:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5E8FFA0722; Thu,  4 May 2023 17:55:56 +0200 (CEST)
Date:   Thu, 4 May 2023 17:55:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Ilya Dryomov <idryomov@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: always respect QUEUE_FLAG_STABLE_WRITES on the block
 device
Message-ID: <20230504155556.t6byee6shgb27pw5@quack3>
References: <20230504105624.9789-1-idryomov@gmail.com>
 <20230504135515.GA17048@lst.de>
 <ZFO+R0Ud6Yx546Tc@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFO+R0Ud6Yx546Tc@casper.infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 04-05-23 15:16:39, Matthew Wilcox wrote:
> On Thu, May 04, 2023 at 03:55:15PM +0200, Christoph Hellwig wrote:
> > On Thu, May 04, 2023 at 12:56:24PM +0200, Ilya Dryomov wrote:
> > > Commit 1cb039f3dc16 ("bdi: replace BDI_CAP_STABLE_WRITES with a queue
> > > and a sb flag") introduced a regression for the raw block device use
> > > case.  Capturing QUEUE_FLAG_STABLE_WRITES flag in set_bdev_super() has
> > > the effect of respecting it only when there is a filesystem mounted on
> > > top of the block device.  If a filesystem is not mounted, block devices
> > > that do integrity checking return sporadic checksum errors.
> > 
> > With "If a file system is not mounted" you want to say "when accessing
> > a block device directly" here, right?  The two are not exclusive..
> > 
> > > Additionally, this commit made the corresponding sysfs knob writeable
> > > for debugging purposes.  However, because QUEUE_FLAG_STABLE_WRITES flag
> > > is captured when the filesystem is mounted and isn't consulted after
> > > that anywhere outside of swap code, changing it doesn't take immediate
> > > effect even though dumping the knob shows the new value.  With no way
> > > to dump SB_I_STABLE_WRITES flag, this is needlessly confusing.
> > 
> > But very much intentional.  s_bdev often is not the only device
> > in a file system, and we should never reference if from core
> > helpers.
> > 
> > So I think we should go with something like this:
> > 
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index db794399900734..aa36cc2a4530c1 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -3129,7 +3129,11 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
> >   */
> >  void folio_wait_stable(struct folio *folio)
> >  {
> > -	if (folio_inode(folio)->i_sb->s_iflags & SB_I_STABLE_WRITES)
> > +	struct inode *inode = folio_inode(folio);
> > +	struct super_block *sb = inode->i_sb;
> > +
> > +	if ((sb->s_iflags & SB_I_STABLE_WRITES) ||
> > +	    (sb_is_blkdev_sb(sb) && bdev_stable_writes(I_BDEV(inode))))
> >  		folio_wait_writeback(folio);
> >  }
> >  EXPORT_SYMBOL_GPL(folio_wait_stable);
> 
> I hate both of these patches ;-)  What we should do is add
> AS_STABLE_WRITES, have the appropriate places call
> mapping_set_stable_writes() and then folio_wait_stable() becomes
> 
> 	if (mapping_test_stable_writes(folio->mapping))
> 		folio_wait_writeback(folio);
> 
> and we remove all the dereferences (mapping->host->i_sb->s_iflags, plus
> whatever else is going on there)

For bdev address_space that's easy but what Ilya also mentioned is a
problem when 'stable_write' flag gets toggled on the device and in that
case having to propagate the flag update to all the address_space
structures is a nightmare...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
