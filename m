Return-Path: <linux-fsdevel+bounces-14878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4182880F13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 10:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C06B2160F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BDD3BBDD;
	Wed, 20 Mar 2024 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FWevS2Wk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dkDXVszD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FWevS2Wk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dkDXVszD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3270C3BB4B
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928299; cv=none; b=Jq/0+Ur2ch9yrAXS4USEpYz/K+1nCGOXqyjgL9mnm82HqyXfsmfYalh7ArNyxnXQd3Xhy+OBvt+20uqMX+uvkCcMsLDDg0OxDF69TpOHtHttEjNhD7SOYto0Kc1DHyi6CZrJ9fNcut5IYNT76ip7ssOfkijgkUv9bqWvJgl3Y58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928299; c=relaxed/simple;
	bh=dAMUnlOJDKw1iaQALwmemb1q5e0ZcJ/+ecAmJAytugI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwnlhM4dA3rYy/ST+mP9gV4QSDxANF/wldYFpwml3tLnynaUby9FE8iHIbSnjcwRgBvS3r2YWbc9QOq1o0qEFOL16ShHWtKejhPdJkCUKXna59sd656N+VI8YSYGefF6KYzq2nFv6qlg8j9e5Vj+klFbi/ukD/C6DrFkIsi2EE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FWevS2Wk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dkDXVszD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FWevS2Wk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dkDXVszD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 145D5221D6;
	Wed, 20 Mar 2024 09:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710928295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCfoJ7aLorHSuraRtX/kquqC1RhSzyfqe6wLly2pIXQ=;
	b=FWevS2WkdhgZEMfFnubimYl3+L3ZRY3rwFGflOYfYjy+8fBL2TBCQlVH/jdJWhm/cks8LZ
	GHQijEyQ2zUcPojGFFKTQBi0qAFyGag8Z2PHHdznGUUvQMq5t79YwX55ibpPl4aCl+fEMt
	As0PGNvdQ9mwfIW/UXsjYn+NL/OSdls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710928295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCfoJ7aLorHSuraRtX/kquqC1RhSzyfqe6wLly2pIXQ=;
	b=dkDXVszDuqks3tPqr3jL7gNcQfgpKPeZU+haxqUpuzgU+SWnIscCxKGpBRGRFgeHYgoSBk
	f2OSnQ+RrZyCa/AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710928295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCfoJ7aLorHSuraRtX/kquqC1RhSzyfqe6wLly2pIXQ=;
	b=FWevS2WkdhgZEMfFnubimYl3+L3ZRY3rwFGflOYfYjy+8fBL2TBCQlVH/jdJWhm/cks8LZ
	GHQijEyQ2zUcPojGFFKTQBi0qAFyGag8Z2PHHdznGUUvQMq5t79YwX55ibpPl4aCl+fEMt
	As0PGNvdQ9mwfIW/UXsjYn+NL/OSdls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710928295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCfoJ7aLorHSuraRtX/kquqC1RhSzyfqe6wLly2pIXQ=;
	b=dkDXVszDuqks3tPqr3jL7gNcQfgpKPeZU+haxqUpuzgU+SWnIscCxKGpBRGRFgeHYgoSBk
	f2OSnQ+RrZyCa/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09C25136D6;
	Wed, 20 Mar 2024 09:51:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JdJcAqex+mVCXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 Mar 2024 09:51:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A29A8A07D6; Wed, 20 Mar 2024 10:51:34 +0100 (CET)
Date: Wed, 20 Mar 2024 10:51:34 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/10] fsnotify: lazy attach fsnotify_sb_info state to sb
Message-ID: <20240320095134.np4fps7lwfollqwu@quack3>
References: <20240317184154.1200192-1-amir73il@gmail.com>
 <20240317184154.1200192-8-amir73il@gmail.com>
 <20240320-einblick-wimmeln-8fba6416c874@brauner>
 <CAOQ4uxgDp-ug4dVGv-wGNFZUX0E93LbR5AsnLBrZfJdrB5WWxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgDp-ug4dVGv-wGNFZUX0E93LbR5AsnLBrZfJdrB5WWxg@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Wed 20-03-24 11:37:57, Amir Goldstein wrote:
> On Wed, Mar 20, 2024 at 10:47 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Sun, Mar 17, 2024 at 08:41:51PM +0200, Amir Goldstein wrote:
> > > Define a container struct fsnotify_sb_info to hold per-sb state,
> > > including the reference to sb marks connector.
> > >
> > > Allocate the fsnotify_sb_info state before attaching connector to any
> > > object on the sb and free it only when killing sb.
> > >
> > > This state is going to be used for storing per priority watched objects
> > > counters.
> > >
> > > Suggested-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/notify/fsnotify.c             | 16 +++++++++++++---
> > >  fs/notify/fsnotify.h             |  9 ++++++++-
> > >  fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++++-
> > >  include/linux/fs.h               |  8 ++++----
> > >  include/linux/fsnotify_backend.h | 17 +++++++++++++++++
> > >  5 files changed, 73 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > > index 503e7c75e777..fb3f36bc6ea9 100644
> > > --- a/fs/notify/fsnotify.c
> > > +++ b/fs/notify/fsnotify.c
> > > @@ -89,11 +89,18 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
> > >
> > >  void fsnotify_sb_delete(struct super_block *sb)
> > >  {
> > > +     struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
> > > +
> > > +     /* Were any marks ever added to any object on this sb? */
> > > +     if (!sbinfo)
> > > +             return;
> > > +
> > >       fsnotify_unmount_inodes(sb);
> > >       fsnotify_clear_marks_by_sb(sb);
> > >       /* Wait for outstanding object references from connectors */
> > >       wait_var_event(fsnotify_sb_watched_objects(sb),
> > >                      !atomic_long_read(fsnotify_sb_watched_objects(sb)));
> > > +     kfree(sbinfo);
> > >  }
> > >
> > >  /*
> > > @@ -489,6 +496,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> > >  {
> > >       const struct path *path = fsnotify_data_path(data, data_type);
> > >       struct super_block *sb = fsnotify_data_sb(data, data_type);
> > > +     struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
> > >       struct fsnotify_iter_info iter_info = {};
> > >       struct mount *mnt = NULL;
> > >       struct inode *inode2 = NULL;
> > > @@ -525,7 +533,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> > >        * SRCU because we have no references to any objects and do not
> > >        * need SRCU to keep them "alive".
> > >        */
> > > -     if (!sb->s_fsnotify_marks &&
> > > +     if ((!sbinfo || !sbinfo->sb_marks) &&
> > >           (!mnt || !mnt->mnt_fsnotify_marks) &&
> > >           (!inode || !inode->i_fsnotify_marks) &&
> > >           (!inode2 || !inode2->i_fsnotify_marks))
> > > @@ -552,8 +560,10 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> > >
> > >       iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
> > >
> > > -     iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
> > > -             fsnotify_first_mark(&sb->s_fsnotify_marks);
> > > +     if (sbinfo) {
> > > +             iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
> > > +                     fsnotify_first_mark(&sbinfo->sb_marks);
> > > +     }
> > >       if (mnt) {
> > >               iter_info.marks[FSNOTIFY_ITER_TYPE_VFSMOUNT] =
> > >                       fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
> > > diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> > > index 8b73ad45cc71..378f9ec6d64b 100644
> > > --- a/fs/notify/fsnotify.h
> > > +++ b/fs/notify/fsnotify.h
> > > @@ -53,6 +53,13 @@ static inline struct super_block *fsnotify_connector_sb(
> > >       return fsnotify_object_sb(conn->obj, conn->type);
> > >  }
> > >
> > > +static inline fsnotify_connp_t *fsnotify_sb_marks(struct super_block *sb)
> > > +{
> > > +     struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
> > > +
> > > +     return sbinfo ? &sbinfo->sb_marks : NULL;
> > > +}
> > > +
> > >  /* destroy all events sitting in this groups notification queue */
> > >  extern void fsnotify_flush_notify(struct fsnotify_group *group);
> > >
> > > @@ -78,7 +85,7 @@ static inline void fsnotify_clear_marks_by_mount(struct vfsmount *mnt)
> > >  /* run the list of all marks associated with sb and destroy them */
> > >  static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
> > >  {
> > > -     fsnotify_destroy_marks(&sb->s_fsnotify_marks);
> > > +     fsnotify_destroy_marks(fsnotify_sb_marks(sb));
> > >  }
> > >
> > >  /*
> > > diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> > > index 0b703f9e6344..db053e0e218d 100644
> > > --- a/fs/notify/mark.c
> > > +++ b/fs/notify/mark.c
> > > @@ -105,7 +105,7 @@ static fsnotify_connp_t *fsnotify_object_connp(void *obj, int obj_type)
> > >       case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> > >               return &real_mount(obj)->mnt_fsnotify_marks;
> > >       case FSNOTIFY_OBJ_TYPE_SB:
> > > -             return &((struct super_block *)obj)->s_fsnotify_marks;
> > > +             return fsnotify_sb_marks(obj);
> > >       default:
> > >               return NULL;
> > >       }
> > > @@ -568,6 +568,26 @@ int fsnotify_compare_groups(struct fsnotify_group *a, struct fsnotify_group *b)
> > >       return -1;
> > >  }
> > >
> > > +static int fsnotify_attach_info_to_sb(struct super_block *sb)
> > > +{
> > > +     struct fsnotify_sb_info *sbinfo;
> > > +
> > > +     /* sb info is freed on fsnotify_sb_delete() */
> > > +     sbinfo = kzalloc(sizeof(*sbinfo), GFP_KERNEL);
> > > +     if (!sbinfo)
> > > +             return -ENOMEM;
> > > +
> > > +     /*
> > > +      * cmpxchg() provides the barrier so that callers of fsnotify_sb_info()
> > > +      * will observe an initialized structure
> > > +      */
> > > +     if (cmpxchg(&sb->s_fsnotify_info, NULL, sbinfo)) {
> > > +             /* Someone else created sbinfo for us */
> > > +             kfree(sbinfo);
> > > +     }
> >
> > Alternatively, you could consider using wait_var_event() to let
> > concurrent attachers wait for s_fsnotify_info to be initialized using a
> > sentinel value to indicate that the caller should wait. But not sure if
> > it's worth it.
> 
> Not worth it IMO. Adding watches is an extremely rare event
> in the grand picture.

Agreed. The cmpxchg() scheme has generally proven to be good enough in
similar situations and simple enough to understand...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

