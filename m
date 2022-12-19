Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAEB650A48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 11:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiLSKmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Dec 2022 05:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiLSKmk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:42:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7516BDAE;
        Mon, 19 Dec 2022 02:42:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 317FC3740A;
        Mon, 19 Dec 2022 10:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671446558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6F18xC5FZQcGDk8y37OvpM2HmoLNG/J4BK4wInmkOts=;
        b=oLXnHFXvFEyTiw8Kbtq0Ty/QXxP5X+nVgqHvSaQCDFk2SV3kLlLlzVTZsueq5CkZcloP8C
        FRARtjzq7A3W4HGOxqOLIMqPDonkgua74/U1mqkREjHSHf/zbtXnTmp7VDddnJUGv+qs8D
        Z+148cZB9v+wvb/3+jGjsfQW7x10M8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671446558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6F18xC5FZQcGDk8y37OvpM2HmoLNG/J4BK4wInmkOts=;
        b=/OLwzC/ByqDhxjtpma9tNPb0uAk05vcnxrf5j91Q51d6iLI3ytVpVD8cz/0yYnu8nmBpvZ
        XrUks6ySKO7UozBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FD6313498;
        Mon, 19 Dec 2022 10:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0nOtBx5AoGOnPwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Dec 2022 10:42:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 86F42A0732; Mon, 19 Dec 2022 11:42:37 +0100 (CET)
Date:   Mon, 19 Dec 2022 11:42:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, reiserfs-devel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 2/8] reiserfs: use kmap_local_folio() in
 _get_block_create_0()
Message-ID: <20221219104237.l6cormdkqu6pgk3s@quack3>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-3-willy@infradead.org>
 <Y5343RPkHRdIkR9a@iweiny-mobl>
 <Y54TYOqbPuKlfiHk@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y54TYOqbPuKlfiHk@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 17-12-22 19:07:12, Matthew Wilcox wrote:
> On Sat, Dec 17, 2022 at 09:14:05AM -0800, Ira Weiny wrote:
> > On Fri, Dec 16, 2022 at 08:53:41PM +0000, Matthew Wilcox (Oracle) wrote:
> > > Switch from the deprecated kmap() to kmap_local_folio().  For the
> > > kunmap_local(), I subtract off 'chars' to prevent the possibility that
> > > p has wrapped into the next page.
> > 
> > Thanks for tackling this one.  I think the conversion is mostly safe because I
> > don't see any reason the mapping is passed to another thread.
> > 
> > But comments like this make me leary:
> > 
> >          "But, this means the item might move if kmap schedules"
> > 
> > What does that mean?  That seems to imply there is something wrong with the
> > base code separate from the kmapping.
> 
> I should probably have deleted that comment.  I'm pretty sure what it
> refers to is that we don't hold a lock that prevents the item from
> moving.  When ReiserFS was written, we didn't have CONFIG_PREEMPT, so 
> if kmap() scheduled, that was a point at which the item could move.
> I don't think I introduced any additional brokenness by converting
> from kmap() to kmap_local().  Maybe I'm wrong and somebody who
> understands ReiserFS can explain.

I think you've got it mostly right. Reiserfs comes from the times of the
Big Kernel Lock which reiserfs was using to protect all its data
structures. And that lock was automagically released when we scheduled. So
when kmap scheduled, the lock preventing item from moving got dropped and
we could have a problem. These days BKL in reiserfs got replaced by the
reiserfs_write_lock() / reiserfs_write_unlock() magic which mostly behaves
as a standard mutex so this is not a concern anymore.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
