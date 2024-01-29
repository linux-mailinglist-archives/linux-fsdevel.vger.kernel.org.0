Return-Path: <linux-fsdevel+bounces-9397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F80840A76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C2D1C21AD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE694155309;
	Mon, 29 Jan 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="G2yg5cKs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0FF154448
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543336; cv=none; b=RVmaSl0OQ6X13MseuGqCA/s6vj2e2kf2YIgQYl0W6RagxjHKflWghICrqUFZatrQyGTAVOPQBZsCuvqOTO5h5867pDJv1ZZKsz75MuAdYMZ/0bDHq9PUBAYSSs5uvGHO1Ibw1Hr0TMjyOUHA5VNOwvGykudAMIVb9huD91MM1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543336; c=relaxed/simple;
	bh=EbAEw347qcvSuv+fvVAAs9Is7ai41ozVeNUSnwX+BeE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oUXkF2lALj1uNgTbWBSYnBIdjsmsBJXL1jBAeRMUD1m17Nbw8KjSnq4YDZMqmxQZKaBXk8Ga3XQoGxOOZMZU4sAbKEdaerLjPzvABgJYWmsaZ9V/MDA+LeP6nkKAiWRhIDWnPfjDFUdqwK+c/OoOy22Im1YcRHCybiwq49DShcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=G2yg5cKs; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 30DBD3F184
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706543331;
	bh=vL5Zi0arUmjHrE5oSVk9nUAXH0R9Ep+8PCB8rGK6E0c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type;
	b=G2yg5cKsbsupiPxGMuaoSaDi83sXDgVKIYXy7u8W2tD+syaB/IHZXcgqsB91KekgZ
	 QB3SvlSD4PSts5o35aZiEBSnqT9jVhZ52pvDAHQU2NwHSJX8UXqJ4r4sKVVRAdVcLy
	 GSeGR5JRcWhyk6uNInEK99+LV3zCf/3GKEnfJ31cqfHn/SGRM/rD1ZJDKyZzKyskFY
	 i4EudxpiRR5NxENO9nSQLuJIec7dI3uwnUOgAi5C6cK7nwKsPt7b7mKbzCI0XGC99g
	 ZVl81V2V7knyWVVt8fiFCFyclL1TppORrrQhdKX0vCKdYX7WzGdkFYq8fzZ6E6Cpjj
	 LJusphaSLEuzA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2f1d0c3389so143372266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 07:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706543331; x=1707148131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vL5Zi0arUmjHrE5oSVk9nUAXH0R9Ep+8PCB8rGK6E0c=;
        b=tTyZv3BPwVbNx0ok0bLf2sTPm9t7saqSQoeBtSTO46nTV7Wk1y6SNiwc7JigxKCJts
         UYnE1vST6HsCn9oVZ0p2AsgJIpw53CHxRVmYxSRqLccQcLCkeWnXJx400zpzNa8Dk2KA
         as+fzYrQelSSMKm+zMMiGEdVeK1TkjBYhB2L1rpYU9dtcjNBmJ335Wo4ZaeMlYwYzcVE
         dH4sSpGL9/0JWTB7pyRPlkO76nOWbPXsDDG2hdVCszI5igFWe4uXvIaWJhxT6fiixwEe
         dUJfPCJxUqInNrd1ZREEmkLvzHUIY/uu7EwGscsYnJsNGh95t3zS0H7lT7SiB1ZHbMUO
         OEQg==
X-Gm-Message-State: AOJu0Yz7RNwdTPdQVeppxeZxWnUvv5dllVBUVELLqvRuHIeNSNruhM1A
	5gQlffhwdKbzeG/fC2Sd4hlrNjBM3BdfyUAMiakxa/T5cY3Q0Xy2iexKEjrL4gJypnuOoGdngRp
	S3izP7GOchnF5gcoX8QhkmkbeEPVd+FpMgTHqgqcRrJss2/PrF9iswQUbdSvGzIZa3/LHmBbPdu
	2qXh8=
X-Received: by 2002:a17:906:4119:b0:a35:e85a:e5ff with SMTP id j25-20020a170906411900b00a35e85ae5ffmr1249480ejk.64.1706543330882;
        Mon, 29 Jan 2024 07:48:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSWIOlchrFG7Fd3XUHaixrlXmaJYwFe+PlTLqiJxKYpJCBJ9TCc4QkWJ4pNDkTJdbt7cu1pg==
X-Received: by 2002:a17:906:4119:b0:a35:e85a:e5ff with SMTP id j25-20020a170906411900b00a35e85ae5ffmr1249470ejk.64.1706543330607;
        Mon, 29 Jan 2024 07:48:50 -0800 (PST)
Received: from amikhalitsyn ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b00a310f2b4b91sm4050907ejm.48.2024.01.29.07.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:48:50 -0800 (PST)
Date: Mon, 29 Jan 2024 16:48:49 +0100
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: Christian Brauner <brauner@kernel.org>
Cc: mszeredi@redhat.com, stgraber@stgraber.org,
 linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, Miklos
 Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Bernd
 Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/9] fs/fuse: support idmapped ->setattr op
Message-Id: <20240129164849.f3f194a800d88fd26a373203@canonical.com>
In-Reply-To: <20240120-zeitmanagement-abbezahlen-8a3e2b5de72a@brauner>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
	<20240108120824.122178-7-aleksandr.mikhalitsyn@canonical.com>
	<20240120-zeitmanagement-abbezahlen-8a3e2b5de72a@brauner>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jan 2024 16:23:38 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Mon, Jan 08, 2024 at 01:08:21PM +0100, Alexander Mikhalitsyn wrote:
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Seth Forshee <sforshee@kernel.org>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Bernd Schubert <bschubert@ddn.com>
> > Cc: <linux-fsdevel@vger.kernel.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > ---
> >  fs/fuse/dir.c    | 32 +++++++++++++++++++++-----------
> >  fs/fuse/file.c   |  2 +-
> >  fs/fuse/fuse_i.h |  4 ++--
> >  3 files changed, 24 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index f7c2c54f7122..5fbb7100ad1c 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -1739,17 +1739,27 @@ static bool update_mtime(unsigned ivalid, bool trust_local_mtime)
> >  	return true;
> >  }
> >  
> > -static void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
> > -			   struct fuse_setattr_in *arg, bool trust_local_cmtime)
> > +static void iattr_to_fattr(struct mnt_idmap *idmap, struct fuse_conn *fc,
> > +			   struct iattr *iattr, struct fuse_setattr_in *arg,
> > +			   bool trust_local_cmtime)
> >  {
> >  	unsigned ivalid = iattr->ia_valid;
> >  
> >  	if (ivalid & ATTR_MODE)
> >  		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
> > -	if (ivalid & ATTR_UID)
> > -		arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
> > -	if (ivalid & ATTR_GID)
> > -		arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
> > +
> > +	if (ivalid & ATTR_UID) {
> > +		kuid_t fsuid = from_vfsuid(idmap, fc->user_ns, iattr->ia_vfsuid);
> > +		arg->valid |= FATTR_UID;
> > +		arg->uid = from_kuid(fc->user_ns, fsuid);
> > +	}
> > +
> > +	if (ivalid & ATTR_GID) {
> > +		kgid_t fsgid = from_vfsgid(idmap, fc->user_ns, iattr->ia_vfsgid);
> > +		arg->valid |= FATTR_GID;
> > +		arg->gid = from_kgid(fc->user_ns, fsgid);
> > +	}
> > +
> >  	if (ivalid & ATTR_SIZE)
> >  		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
> >  	if (ivalid & ATTR_ATIME) {
> > @@ -1869,8 +1879,8 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
> >   * vmtruncate() doesn't allow for this case, so do the rlimit checking
> >   * and the actual truncation by hand.
> >   */
> > -int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
> > -		    struct file *file)
> > +int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > +		    struct iattr *attr, struct file *file)
> >  {
> >  	struct inode *inode = d_inode(dentry);
> >  	struct fuse_mount *fm = get_fuse_mount(inode);
> > @@ -1890,7 +1900,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
> >  	if (!fc->default_permissions)
> >  		attr->ia_valid |= ATTR_FORCE;
> >  
> > -	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
> > +	err = setattr_prepare(idmap, dentry, attr);
> >  	if (err)
> >  		return err;
> >  
> > @@ -1949,7 +1959,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
> >  
> >  	memset(&inarg, 0, sizeof(inarg));
> >  	memset(&outarg, 0, sizeof(outarg));
> > -	iattr_to_fattr(fc, attr, &inarg, trust_local_cmtime);
> > +	iattr_to_fattr(idmap, fc, attr, &inarg, trust_local_cmtime);
> >  	if (file) {
> >  		struct fuse_file *ff = file->private_data;
> >  		inarg.valid |= FATTR_FH;
> > @@ -2084,7 +2094,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
> >  	if (!attr->ia_valid)
> >  		return 0;
> >  
> > -	ret = fuse_do_setattr(entry, attr, file);
> > +	ret = fuse_do_setattr(idmap, entry, attr, file);
> >  	if (!ret) {
> >  		/*
> >  		 * If filesystem supports acls it may have updated acl xattrs in
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index a660f1f21540..e0fe5497a548 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -2870,7 +2870,7 @@ static void fuse_do_truncate(struct file *file)
> >  	attr.ia_file = file;
> >  	attr.ia_valid |= ATTR_FILE;
> >  
> > -	fuse_do_setattr(file_dentry(file), &attr, file);
> > +	fuse_do_setattr(&nop_mnt_idmap, file_dentry(file), &attr, file);
> 
> Same as for the other patch. Please leave a comment in the commit
> message that briefly explains why it's ok to pass &nop_mnt_idmap here.
> It'll help us later. :)

Sure, will be fixed in -v2 ;-)

Explanation here is that in this specific case attr.ia_valid = ATTR_SIZE | ATTR_FILE,
which but we only need an idmapping for ATTR_UID | ATTR_GID.

From the other side, having struct file pointer means that getting an idmapping as easy as file_mnt_idmap(file),
and probably it's easier to pass an idmapping in this specific case rather than skipping it for a valid reasons.
What do you think about this?

Kind regards,
Alex

