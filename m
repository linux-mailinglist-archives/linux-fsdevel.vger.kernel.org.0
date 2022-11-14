Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F017628934
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 20:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiKNTVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 14:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiKNTVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:21:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA29121260;
        Mon, 14 Nov 2022 11:21:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 326572035B;
        Mon, 14 Nov 2022 19:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668453690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C3HKNfIulCdNS1yQDFyfWz7VJTvWWLP9//PNa+endtE=;
        b=RbiaIxhg1yFpl8RL+Gw8VX/OPzc611xquNEAigt4T2+XihdOyMj/wTWECiWmCa2c8nfX67
        ggL2he6j8+mGt0BDWbtRXxa2Tg4QKDNIXS1fbWQUiROKSAVUDCwGOp1NEsVQsJmEGa8q9D
        BXTPmBj5Sth7Za+gSKGfNTslApbZGys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668453690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C3HKNfIulCdNS1yQDFyfWz7VJTvWWLP9//PNa+endtE=;
        b=/7+SXQH37A3xGS+F+/m2/T2qHxVAJKRRVUYXvJiFGnIKXac0Z/pAjP9L9lzOPGKksGdzvn
        aDzix1l1y8WX6JAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2431B13A92;
        Mon, 14 Nov 2022 19:21:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6sbMCDqVcmNLFAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Nov 2022 19:21:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9B345A0709; Mon, 14 Nov 2022 20:21:29 +0100 (CET)
Date:   Mon, 14 Nov 2022 20:21:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Svyatoslav Feldsherov <feldsherov@google.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Lukas Czerner <lczerner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com,
        oferz@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: do not push freeing inode to b_dirty_time list
Message-ID: <20221114192129.zkmubc6pmruuzkc7@quack3>
References: <20221113152439.2821942-1-feldsherov@google.com>
 <20221114104653.sosohdhkxry6xkuc@quack3>
 <CACgs1VBy6Mww_iOgtY7Brryi_ofbrAO1yud8zyBer59hhSAUGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACgs1VBy6Mww_iOgtY7Brryi_ofbrAO1yud8zyBer59hhSAUGg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 14-11-22 19:43:54, Svyatoslav Feldsherov wrote:
> Thank you for looking into this!
> 
> On Mon, Nov 14, 2022 at 12:46 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sun 13-11-22 17:24:39, Svyatoslav Feldsherov wrote:
> > > After commit cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode
> > > already has I_DIRTY_INODE") writeiback_single_inode can push inode with
> > > I_DIRTY_TIME set to b_dirty_time list. In case of freeing inode with
> > > I_DIRTY_TIME set this can happened after deletion of inode io_list at
> > > evict. Stack trace is following.
> > >
> > > evict
> > > fat_evict_inode
> > > fat_truncate_blocks
> > > fat_flush_inodes
> > > writeback_inode
> > > sync_inode_metadata
> > > writeback_single_inode
> > >
> > > This will lead to use after free in flusher thread.
> > >
> > > Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")
> > > Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
> > > Signed-off-by: Svyatoslav Feldsherov <feldsherov@google.com>
> >
> > Thanks for the analysis! I was scratching my head over this syzbot report
> > for a while and it didn't occur to me somebody could be calling
> > writeback_single_inode() from the .evict callback.
> >
> > Also what contributes to the problem is that FAT calls
> > sync_inode_metadata(inode, 0) so it is not marking this final flush as data
> > integrity sync and so we happily leave the I_DIRTY_TIME bit set.
> >
> > > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > > index 443f83382b9b..31c93cbdb3fe 100644
> > > --- a/fs/fs-writeback.c
> > > +++ b/fs/fs-writeback.c
> > > @@ -1718,7 +1718,7 @@ static int writeback_single_inode(struct inode *inode,
> > >        */
> > >       if (!(inode->i_state & I_DIRTY_ALL))
> > >               inode_cgwb_move_to_attached(inode, wb);
> > > -     else if (!(inode->i_state & I_SYNC_QUEUED)) {
> > > +     else if (!(inode->i_state & (I_SYNC_QUEUED | I_FREEING))) {
> > >               if ((inode->i_state & I_DIRTY))
> > >                       redirty_tail_locked(inode, wb);
> > >               else if (inode->i_state & I_DIRTY_TIME) {
> >
> > So even calling inode_cgwb_move_to_attached() is not safe when I_FREEING is
> > already set. So I belive the I_FREEING bit check needs to be before this
> > whole if block.
> 
> Agree, let me move the I_FREEING check before this if block.
> The commit I am fixing didn't change this codepath, so I suspect there is an
> implicit invariant which keeps inode_cgwb_move_to_attached call safe.
> But I am 100% in favor of making I_FREEING check explicitly.

Actually, as I've looked into fat_evict_inode() I don't see anything making
that safe except for the fact that it may be more difficult for syzbot to
excercise the per-memcg writeback path...

> > I also think we should add some assertions into i_io_list handling
> > functions to complain if I_FREEING bit is set to catch these problems
> > earlier which means to be also more careful in __mark_inode_dirty(). But
> > this is for a separate cleanup.
> 
> Sounds reasonable. Will look into that afterwards.

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
