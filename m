Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785ED71A280
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 17:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjFAPZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjFAPYx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:24:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE8F136;
        Thu,  1 Jun 2023 08:24:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 439421FDAF;
        Thu,  1 Jun 2023 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685633090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NMMC3ehgaWslWeASfjcmQ+SuyyB+zQPCwx9GtXbqe3Y=;
        b=WjHviSuQYqQL5ww/WGZrxQ9IaSK+faKZeFG2YF8j1TneF9hscLLx1tqg0Bx8EgldewEIHi
        PBEV92dYJc9WiX/PL/Fl3kvtNUHQ7iVPTlmwqgOKI3ucMytqhW2aWsSuZSvUhP7hf/zFKn
        KNnBc370aTHSrj3tbsurPTnkkfqoXmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685633090;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NMMC3ehgaWslWeASfjcmQ+SuyyB+zQPCwx9GtXbqe3Y=;
        b=9kcmzqr/0hZ1iA49qNNzf1cUeGB4/rjsaKBaQ3EqCfnWgDiqMRyj80AFflpKW9e0YgPeZl
        nKRmR487X7h99zBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3109D139B7;
        Thu,  1 Jun 2023 15:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7FLvC0K4eGQuawAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Jun 2023 15:24:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 91EB1A0754; Thu,  1 Jun 2023 17:24:49 +0200 (CEST)
Date:   Thu, 1 Jun 2023 17:24:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 4/6] fs: Establish locking order for unrelated
 directories
Message-ID: <20230601152449.h4ur5zrfqjqygujd@quack3>
References: <20230601104525.27897-1-jack@suse.cz>
 <20230601105830.13168-4-jack@suse.cz>
 <20230601-gebracht-gesehen-c779a56b3bf3@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601-gebracht-gesehen-c779a56b3bf3@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-06-23 15:58:58, Christian Brauner wrote:
> On Thu, Jun 01, 2023 at 12:58:24PM +0200, Jan Kara wrote:
> > Currently the locking order of inode locks for directories that are not
> > in ancestor relationship is not defined because all operations that
> > needed to lock two directories like this were serialized by
> > sb->s_vfs_rename_mutex. However some filesystems need to lock two
> > subdirectories for RENAME_EXCHANGE operations and for this we need the
> > locking order established even for two tree-unrelated directories.
> > Provide a helper function lock_two_inodes() that establishes lock
> > ordering for any two inodes and use it in lock_two_directories().
> > 
> > CC: stable@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/inode.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  fs/internal.h |  2 ++
> >  fs/namei.c    |  4 ++--
> >  3 files changed, 46 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 577799b7855f..4000ab08bbc0 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1103,6 +1103,48 @@ void discard_new_inode(struct inode *inode)
> >  }
> >  EXPORT_SYMBOL(discard_new_inode);
> >  
> > +/**
> > + * lock_two_inodes - lock two inodes (may be regular files but also dirs)
> > + *
> > + * Lock any non-NULL argument. The caller must make sure that if he is passing
> > + * in two directories, one is not ancestor of the other.  Zero, one or two
> > + * objects may be locked by this function.
> > + *
> > + * @inode1: first inode to lock
> > + * @inode2: second inode to lock
> > + * @subclass1: inode lock subclass for the first lock obtained
> > + * @subclass2: inode lock subclass for the second lock obtained
> > + */
> > +void lock_two_inodes(struct inode *inode1, struct inode *inode2,
> > +		     unsigned subclass1, unsigned subclass2)
> > +{
> > +	if (!inode1 || !inode2)
> 
> I think you forgot the opening bracket...
> I can just fix this up for you though.

Oh, yes. Apparently I forgot to rerun git-format-patch after fixing up this
bit. I'm sorry for that. The patch series has survived full ext4 fstests
run on my end.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
