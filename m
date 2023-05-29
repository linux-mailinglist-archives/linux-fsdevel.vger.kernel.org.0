Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD54714D30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 17:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjE2PiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 11:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjE2PiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 11:38:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9FBF0;
        Mon, 29 May 2023 08:37:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A13CB1F8B0;
        Mon, 29 May 2023 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685374674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5x//7WihZJHP1ybBvKd6Troh9+7buiiSd3Ne59BgSEw=;
        b=fSpO7ae3VdnMdXRDt9Y0DgiDJbH0T7K3W5P4bBRjL+L/BxE+bLD+2Csqqs4Aw9c6ncV85s
        //0FCpp9/c45UE4B1CzxbNvvJkhIf+47hE8Zdcfv1+N31NNgr2rY+PEBH/9d3SQVwoD+2I
        JS1f4SwRyENJ/I6HnI4mWulU1S2DJZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685374674;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5x//7WihZJHP1ybBvKd6Troh9+7buiiSd3Ne59BgSEw=;
        b=lf3ZWecKucEDCJ60SKDHz/Mb7QuqwTjJgxmnrSoFrZFJtwpPVPzhebfnSEeyqO4LZ5J5MO
        gnAzWelT/f/35kCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81ACD13466;
        Mon, 29 May 2023 15:37:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nRcSH9LGdGQmSAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 29 May 2023 15:37:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E43C8A0717; Mon, 29 May 2023 14:42:08 +0200 (CEST)
Date:   Mon, 29 May 2023 14:42:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/6] fs: Restrict lock_two_nondirectories() to
 non-directory inodes
Message-ID: <20230529124208.2oou7jt3iitwxk4v@quack3>
References: <20230525100654.15069-1-jack@suse.cz>
 <20230525101624.15814-6-jack@suse.cz>
 <CAOQ4uxhL0w+yqg2u_xW6r4J_gJX=_zoZjo3vh0ONqAbgxm2VTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhL0w+yqg2u_xW6r4J_gJX=_zoZjo3vh0ONqAbgxm2VTA@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 26-05-23 15:13:06, Amir Goldstein wrote:
> On Thu, May 25, 2023 at 1:17 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Currently lock_two_nondirectories() is skipping any passed directories.
> > After vfs_rename() uses lock_two_inodes(), all the remaining four users
> > of this function pass only regular files to it. So drop the somewhat
> > unusual "skip directory" logic and instead warn if anybody passes
> > directory to it. This also allows us to use lock_two_inodes() in
> > lock_two_nondirectories() to concentrate the lock ordering logic in less
> > places.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/inode.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 2015fa50d34a..accf5125a049 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1140,7 +1140,7 @@ void lock_two_inodes(struct inode *inode1, struct inode *inode2,
> >  /**
> >   * lock_two_nondirectories - take two i_mutexes on non-directory objects
> >   *
> > - * Lock any non-NULL argument that is not a directory.
> > + * Lock any non-NULL argument. Passed objects must not be directories.
> >   * Zero, one or two objects may be locked by this function.
> >   *
> >   * @inode1: first inode to lock
> > @@ -1148,13 +1148,9 @@ void lock_two_inodes(struct inode *inode1, struct inode *inode2,
> >   */
> >  void lock_two_nondirectories(struct inode *inode1, struct inode *inode2)
> >  {
> > -       if (inode1 > inode2)
> > -               swap(inode1, inode2);
> > -
> > -       if (inode1 && !S_ISDIR(inode1->i_mode))
> > -               inode_lock(inode1);
> > -       if (inode2 && !S_ISDIR(inode2->i_mode) && inode2 != inode1)
> > -               inode_lock_nested(inode2, I_MUTEX_NONDIR2);
> > +       WARN_ON_ONCE(S_ISDIR(inode1->i_mode));
> > +       WARN_ON_ONCE(S_ISDIR(inode2->i_mode));
> > +       lock_two_inodes(inode1, inode2, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
> >  }
> >  EXPORT_SYMBOL(lock_two_nondirectories);
> >
> 
> Need the same treatment to unlock_two_nondirectories() because now if
> someone does pass a directory they will get a warning but also a leaked lock.

Yes, probably that is good defensive programming. I'll update the patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
