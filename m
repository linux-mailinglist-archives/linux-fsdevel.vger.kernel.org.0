Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFD262942B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 10:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKOJUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 04:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiKOJUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:20:05 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704502B7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 01:20:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 4so12658971pli.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 01:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe8wvLyeeBJubRjZd1BX3pqPmbT2kfkyQ9PG/WDicao=;
        b=VXPbYOchzFjmWKkn5Ye3sE6usQmGTAegeKA8qRS6DWMMO77XFOfwcWq0A0SpxbP7Mm
         FI8xB5XX38/h3lfi3H2LIjjzc30/pahCtVLOcTVvlb7hTgxnY0ZlvsHUBZuMCBzLOLTY
         UOcTAUGGSO+jCDC8JlVAIhlFelSn+8C6wTW2pM4DSqJ3h/lf/OaMP4ukhwd3TSV2bGIv
         L7MrzrnBjOX/35HOoAN2kRSLmcDRKDHucjvFhItWnlapxAcZrzCw27O9y7pxOtyw6iKu
         L/nXudusW1EQchlp/8ZE40sNl3kRKBMctkIJ0SfQBiaqNDAWyCS7/e35LYpkTIajTFlt
         RTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qe8wvLyeeBJubRjZd1BX3pqPmbT2kfkyQ9PG/WDicao=;
        b=HBAYOE3LqigRE3BLAD+fAcaUCjqPipPmQVdxCqgxo072Qhk0RzbCrx3TyDR5/NNQvE
         aeIm65aBtpUZMlpGakiPJdoJ5LRiNloqf7DPL//BWE2sp6ATjICS6X0r6qnbeh5/jAJP
         NfVaQgLYty0qm/M3B+exjDszxdSKXCHVpTONkAvpE7fDe6RsnBvFmk+Ku3TVGmIztUsm
         nMm2xHgHQ1xsQ6hoLF//E82l+fZ4oxFO7UFMBJ3LBZqjV0FuvdCPePDs2rnhMz62HEYK
         x4pzWT6yiExHCunpF8Y9A4QJagLg4jJBXYbhd0tp785jJNK6gA7GEXAYhZXodzUmro/9
         sTxA==
X-Gm-Message-State: ANoB5pmBoRxW6uVI5ig5aE8CQ/opeFhYnaESdON0EMrBpny/gy/4WLlg
        E+p+wBp9YArmHgfxpzMPhftv9n/fJQT3C8AtffddtA==
X-Google-Smtp-Source: AA0mqf734iwPRZTLrxH05682vZV+02EMb5JwQlRQVSnKpRpoPgD4I2wPj6N0/iHtqq1snkK4Zst80kSIESDWlg4IU6g=
X-Received: by 2002:a17:90a:73cd:b0:213:d7cc:39cb with SMTP id
 n13-20020a17090a73cd00b00213d7cc39cbmr1258696pjk.144.1668504003790; Tue, 15
 Nov 2022 01:20:03 -0800 (PST)
MIME-Version: 1.0
References: <20221114192129.zkmubc6pmruuzkc7@quack3> <20221114212155.221829-1-feldsherov@google.com>
 <fd7ebc60-811e-588a-5c55-ee540796f058@infradead.org>
In-Reply-To: <fd7ebc60-811e-588a-5c55-ee540796f058@infradead.org>
From:   Svyatoslav Feldsherov <feldsherov@google.com>
Date:   Tue, 15 Nov 2022 11:19:52 +0200
Message-ID: <CACgs1VAsvFQ+V5V8AsFN2i-azBQnD1ZdpQ+rA-NUtvLVAaNhdw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: do not update freeing inode io_list
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Lukas Czerner <lczerner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com,
        oferz@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for noticing that!
I will send a fixed patch in 8-10 hours if no other comment will arrive.

On Mon, Nov 14, 2022 at 11:25 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> Please see a small nit below.
>
> On 11/14/22 13:21, Svyatoslav Feldsherov wrote:
> > After commit cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode
> > already has I_DIRTY_INODE") writeiback_single_inode can push inode with
> > I_DIRTY_TIME set to b_dirty_time list. In case of freeing inode with
> > I_DIRTY_TIME set this can happened after deletion of inode io_list at
> > evict. Stack trace is following.
> >
> > evict
> > fat_evict_inode
> > fat_truncate_blocks
> > fat_flush_inodes
> > writeback_inode
> > sync_inode_metadata(inode, sync=0)
> > writeback_single_inode(inode, wbc) <- wbc->sync_mode == WB_SYNC_NONE
> >
> > This will lead to use after free in flusher thread.
> >
> > Similar issue can be triggered if writeback_single_inode in the
> > stack trace update inode->io_list. Add explicit check to avoid it.
> >
> > Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")
> > Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
> > Signed-off-by: Svyatoslav Feldsherov <feldsherov@google.com>
> > ---
> >  V1 -> V2:
> >  - address review comments
> >  - skip inode_cgwb_move_to_attached for freeing inode
> >
> >  fs/fs-writeback.c | 30 +++++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 443f83382b9b..c4aea096689c 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1712,18 +1712,26 @@ static int writeback_single_inode(struct inode *inode,
> >       wb = inode_to_wb_and_lock_list(inode);
> >       spin_lock(&inode->i_lock);
> >       /*
> > -      * If the inode is now fully clean, then it can be safely removed from
> > -      * its writeback list (if any).  Otherwise the flusher threads are
> > -      * responsible for the writeback lists.
> > +      * If the inode is freeing, it's io_list shoudn't be updated
>
>                                     its
>
> > +      * as it can be finally deleted at this moment.
> >        */
> > -     if (!(inode->i_state & I_DIRTY_ALL))
> > -             inode_cgwb_move_to_attached(inode, wb);
> > -     else if (!(inode->i_state & I_SYNC_QUEUED)) {
> > -             if ((inode->i_state & I_DIRTY))
> > -                     redirty_tail_locked(inode, wb);
> > -             else if (inode->i_state & I_DIRTY_TIME) {
> > -                     inode->dirtied_when = jiffies;
> > -                     inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
> > +     if (!(inode->i_state & I_FREEING)) {
> > +             /*
> > +              * If the inode is now fully clean, then it can be safely
> > +              * removed from its writeback list (if any). Otherwise the
> > +              * flusher threads are responsible for the writeback lists.
> > +              */
> > +             if (!(inode->i_state & I_DIRTY_ALL))
> > +                     inode_cgwb_move_to_attached(inode, wb);
> > +             else if (!(inode->i_state & I_SYNC_QUEUED)) {
> > +                     if ((inode->i_state & I_DIRTY))
> > +                             redirty_tail_locked(inode, wb);
> > +                     else if (inode->i_state & I_DIRTY_TIME) {
> > +                             inode->dirtied_when = jiffies;
> > +                             inode_io_list_move_locked(inode,
> > +                                                       wb,
> > +                                                       &wb->b_dirty_time);
> > +                     }
> >               }
> >       }
> >
>
> --
> ~Randy

--
Slava
