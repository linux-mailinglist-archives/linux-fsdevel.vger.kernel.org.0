Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469406F8105
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 12:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjEEKtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 06:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjEEKtI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 06:49:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D388F4;
        Fri,  5 May 2023 03:49:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C45F1F8C1;
        Fri,  5 May 2023 10:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683283745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XbyxKS0XVSbntMZRS7J/xfGZnAu0J6KaI4py7lxlOio=;
        b=pWQqIpLR5XTtiUEC6LYXykGJJkoqkbvackC0HRSM1h3uxZqW6FgW6PLD6sCe4SLJ2rkCzZ
        TaXMcgUZn7sLUoncyKoEunmPvi3y5IxIvT447P+1Za23OfvZ3tXia8PBKMtfCFS96EgYc+
        FCSPCuXGLeiHiUT7ocQ3nmZogtvzdLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683283745;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XbyxKS0XVSbntMZRS7J/xfGZnAu0J6KaI4py7lxlOio=;
        b=+h8135oZgzMg52mRmcDCnaa52Uir/Rmj30Oa7s+58C2sEKwS3DdGycTxFaiqE5sG+xqt4E
        9zkXQIppTHDgCdDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E20A13488;
        Fri,  5 May 2023 10:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4rokDyHfVGSmBAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 05 May 2023 10:49:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BA638A0729; Fri,  5 May 2023 12:49:04 +0200 (CEST)
Date:   Fri, 5 May 2023 12:49:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: always respect QUEUE_FLAG_STABLE_WRITES on the block
 device
Message-ID: <20230505104904.2zr4escdxvoekr2k@quack3>
References: <20230504105624.9789-1-idryomov@gmail.com>
 <20230504135515.GA17048@lst.de>
 <ZFO+R0Ud6Yx546Tc@casper.infradead.org>
 <20230504155556.t6byee6shgb27pw5@quack3>
 <ZFPacOW6XMq+o4YU@casper.infradead.org>
 <20230504230736.GA2651828@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504230736.GA2651828@dread.disaster.area>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 05-05-23 09:07:36, Dave Chinner wrote:
> On Thu, May 04, 2023 at 05:16:48PM +0100, Matthew Wilcox wrote:
> > On Thu, May 04, 2023 at 05:55:56PM +0200, Jan Kara wrote:
> > > For bdev address_space that's easy but what Ilya also mentioned is a
> > > problem when 'stable_write' flag gets toggled on the device and in that
> > > case having to propagate the flag update to all the address_space
> > > structures is a nightmare...
> > 
> > We have a number of flags which don't take effect when modified on a
> > block device with a mounted filesystem on it.  For example, modifying
> > the readahead settings do not change existing files, only new ones.
> > Since this flag is only modifiable for debugging purposes, I think I'm
> > OK with it not affecting already-mounted filesystems.  It feels like a
> > decision that reasonable people could disagree on, though.
> 
> I think an address space flag makes sense, because then we don't
> even have to care about the special bdev sb/inode thing -
> folio->mapping will already point at the bdev mapping and so do the
> right thing.
> 
> That is, if the bdev changes stable_write state, it can toggle the
> AS_STABLE_WRITE flag on it's inode->i_mapping straight away and all
> the folios and files pointing to the bdev mapping will change
> behaviour immediately.  Everything else retains the same behaviour
> we have now - the stable_write state is persistent on the superblock
> until the filesystem mount is cycled.

Yeah, I'm fine with this behavior. I just wasn't sure whether Ilya didn't
need the sysfs change to be visible in the filesystem so that was why I
pointed that out. But apparently he doesn't need it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
