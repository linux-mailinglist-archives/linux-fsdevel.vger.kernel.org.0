Return-Path: <linux-fsdevel+bounces-28437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ACC96A404
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 18:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301BB28709C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDEE189B88;
	Tue,  3 Sep 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1tD2r3Ex";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8wnYF0FF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1tD2r3Ex";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8wnYF0FF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE661DFCB;
	Tue,  3 Sep 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380157; cv=none; b=omTxmasT0xr6GdRSzhhHDGmdYpDT3fb+aReinZqusZH9GXcoFsza+zq2No1AxBgNYzoM1ta2GhJWR9me6n2iZvufk5kfZHu7sKTEzg7aZVFFABw7/rF7s8BG3RgLxnVeaoW9ztZiP7Wqj1sWqZnB9cmqZS1reBZaUo/7TFS7EV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380157; c=relaxed/simple;
	bh=gjBGzM6fvXyE/aEihJdgERDYx8u+etraR4T2uBhsYss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJC+F+mdjP/unp8AQe9NY2tNbrZicnfA+hG0f+vtPOKWGi0yBjlA3NEJS/Vq0CwkIkPaZ3+646hbrYFbsLTFkWf+HtAvAJx3rfbLboSfN33/koX5s/XEAicMo1reSwA2WI0kQGDj55POgWbXyawEU8bI06Oa9N9C6601W05bfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1tD2r3Ex; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8wnYF0FF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1tD2r3Ex; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8wnYF0FF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B71B921A43;
	Tue,  3 Sep 2024 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725380153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXur40dr6oJg+rkmyFjm1pAR/rLEyXQXabzhNZLheUg=;
	b=1tD2r3ExVY87qinoFJQz9t9WbudP5EuPQNvH+UOy61VmsEn7rapqaCdQ48hGOHIvKqPZtN
	iGWsllBF24upTmYJ21drPLputS5oC0F7vf9tscwwQignHrO8j5ZshLJ2JyxqFMmQSMlBP9
	fGO9owstxV6lwDp6iYRxLWK3dSeWaeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725380153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXur40dr6oJg+rkmyFjm1pAR/rLEyXQXabzhNZLheUg=;
	b=8wnYF0FFNltu1jN/0MLW2VO/+Bcy2ICUE3C0ZNKKIF80/ikgPviplk2983UdkrnDB20Rr3
	tbeDtgEzhlambhBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1tD2r3Ex;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8wnYF0FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725380153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXur40dr6oJg+rkmyFjm1pAR/rLEyXQXabzhNZLheUg=;
	b=1tD2r3ExVY87qinoFJQz9t9WbudP5EuPQNvH+UOy61VmsEn7rapqaCdQ48hGOHIvKqPZtN
	iGWsllBF24upTmYJ21drPLputS5oC0F7vf9tscwwQignHrO8j5ZshLJ2JyxqFMmQSMlBP9
	fGO9owstxV6lwDp6iYRxLWK3dSeWaeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725380153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXur40dr6oJg+rkmyFjm1pAR/rLEyXQXabzhNZLheUg=;
	b=8wnYF0FFNltu1jN/0MLW2VO/+Bcy2ICUE3C0ZNKKIF80/ikgPviplk2983UdkrnDB20Rr3
	tbeDtgEzhlambhBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7615013A52;
	Tue,  3 Sep 2024 16:15:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aY3OFjk212ZdfQAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 03 Sep 2024 16:15:53 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  krisman@kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 6/8] tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs
 dirs
In-Reply-To: <20240902225511.757831-7-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Mon, 2 Sep 2024 19:55:08 -0300")
References: <20240902225511.757831-1-andrealmeid@igalia.com>
	<20240902225511.757831-7-andrealmeid@igalia.com>
Date: Tue, 03 Sep 2024 12:15:52 -0400
Message-ID: <87jzfshfwn.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B71B921A43
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,mailhost.krisman.be:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Enable setting flag FS_CASEFOLD_FL for tmpfs directories, when tmpfs is
> mounted with casefold support. A special check is need for this flag,
> since it can't be set for non-empty directories.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  include/linux/shmem_fs.h |  6 +++---
>  mm/shmem.c               | 40 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 1d06b1e5408a..8367ca2b99d9 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -42,10 +42,10 @@ struct shmem_inode_info {
>  	struct inode		vfs_inode;
>  };
>=20=20
> -#define SHMEM_FL_USER_VISIBLE		FS_FL_USER_VISIBLE
> +#define SHMEM_FL_USER_VISIBLE		(FS_FL_USER_VISIBLE | FS_CASEFOLD_FL)
>  #define SHMEM_FL_USER_MODIFIABLE \
> -	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | FS_NOATIME_FL)
> -#define SHMEM_FL_INHERITED		(FS_NODUMP_FL | FS_NOATIME_FL)
> +	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | FS_NOATIME_FL | FS_CAS=
EFOLD_FL)
> +#define SHMEM_FL_INHERITED		(FS_NODUMP_FL | FS_NOATIME_FL | FS_CASEFOLD_=
FL)
>=20=20
>  struct shmem_quota_limits {
>  	qsize_t usrquota_bhardlimit; /* Default user quota block hard limit */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0f918010bc54..9a0fc7636629 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2617,9 +2617,26 @@ static int shmem_initxattrs(struct inode *, const =
struct xattr *, void *);
>   * chattr's fsflags are unrelated to extended attributes,
>   * but tmpfs has chosen to enable them under the same config option.
>   */
> -static void shmem_set_inode_flags(struct inode *inode, unsigned int fsfl=
ags)
> +static int shmem_set_inode_flags(struct inode *inode, unsigned int fsfla=
gs, struct dentry *dentry)
>  {
> -	unsigned int i_flags =3D 0;
> +	unsigned int i_flags =3D 0, old =3D inode->i_flags;
> +	struct super_block *sb =3D inode->i_sb;
> +
> +	if (fsflags & FS_CASEFOLD_FL) {
> +		if (!sb->s_encoding)
> +			return -EOPNOTSUPP;
> +
> +		if (!S_ISDIR(inode->i_mode))
> +			return -ENOTDIR;
> +
> +		if (dentry && !simple_empty(dentry))
> +			return -ENOTEMPTY;
> +
> +		i_flags |=3D S_CASEFOLD;
> +	} else if (old & S_CASEFOLD) {
> +		if (dentry && !simple_empty(dentry))
> +			return -ENOTEMPTY;

We don't want to fail if a directory already has the S_CASEFOLD
flag and we are not flipping it in the current operation.  Something like:

if ((fsflags ^ old) & S_CASEFOLD) {
	if (!sb->s_encoding)
		return -EOPNOTSUPP;

	if (!S_ISDIR(inode->i_mode))
		return -ENOTDIR;

	if (dentry && !simple_empty(dentry))
		return -ENOTEMPTY;
        i_flags |=3D fsflags & S_CASEFOLD;
}

>
>  	if (fsflags & FS_NOATIME_FL)
>  		i_flags |=3D S_NOATIME;
> @@ -2630,10 +2647,12 @@ static void shmem_set_inode_flags(struct inode *i=
node, unsigned int fsflags)
>  	/*
>  	 * But FS_NODUMP_FL does not require any action in i_flags.
>  	 */
> -	inode_set_flags(inode, i_flags, S_NOATIME | S_APPEND | S_IMMUTABLE);
> +	inode_set_flags(inode, i_flags, S_NOATIME | S_APPEND | S_IMMUTABLE | S_=
CASEFOLD);
> +
> +	return 0;
>  }
>  #else
> -static void shmem_set_inode_flags(struct inode *inode, unsigned int fsfl=
ags)
> +static void shmem_set_inode_flags(struct inode *inode, unsigned int fsfl=
ags, struct dentry *dentry)
>  {
>  }
>  #define shmem_initxattrs NULL
> @@ -2680,7 +2699,7 @@ static struct inode *__shmem_get_inode(struct mnt_i=
dmap *idmap,
>  	info->fsflags =3D (dir =3D=3D NULL) ? 0 :
>  		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
>  	if (info->fsflags)
> -		shmem_set_inode_flags(inode, info->fsflags);
> +		shmem_set_inode_flags(inode, info->fsflags, NULL);
>  	INIT_LIST_HEAD(&info->shrinklist);
>  	INIT_LIST_HEAD(&info->swaplist);
>  	simple_xattrs_init(&info->xattrs);
> @@ -3790,16 +3809,23 @@ static int shmem_fileattr_set(struct mnt_idmap *i=
dmap,
>  {
>  	struct inode *inode =3D d_inode(dentry);
>  	struct shmem_inode_info *info =3D SHMEM_I(inode);
> +	int ret, flags;
>=20=20
>  	if (fileattr_has_fsx(fa))
>  		return -EOPNOTSUPP;
>  	if (fa->flags & ~SHMEM_FL_USER_MODIFIABLE)
>  		return -EOPNOTSUPP;
>=20=20
> -	info->fsflags =3D (info->fsflags & ~SHMEM_FL_USER_MODIFIABLE) |
> +	flags =3D (info->fsflags & ~SHMEM_FL_USER_MODIFIABLE) |
>  		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
>=20=20
> -	shmem_set_inode_flags(inode, info->fsflags);
> +	ret =3D shmem_set_inode_flags(inode, flags, dentry);
> +
> +	if (ret)
> +		return ret;
> +
> +	info->fsflags =3D flags;
> +
>  	inode_set_ctime_current(inode);
>  	inode_inc_iversion(inode);
>  	return 0;

--=20
Gabriel Krisman Bertazi

