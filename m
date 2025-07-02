Return-Path: <linux-fsdevel+bounces-53603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEF0AF0E63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7FA3BC228
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 08:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE1D23C4F7;
	Wed,  2 Jul 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwYXYLZP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F241DD529
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446043; cv=none; b=HnvzxbRVoirtVY6BImo3dbnuXwJXtWbnK59uCKI5bQAh1nLcr4u9WNmxIHzRV+P46i98XcYfa/IPfQHwiiPKCCHkox3YkGv/zTiUD264f1V0ZccaXLt/nwoBAYDa4NlrkLSFXz2KxgQqRTpIe/m64/lAZxvHsD4AfvM3Rp2hymI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446043; c=relaxed/simple;
	bh=g8uu1mvO6t5QeTuuBjGU41Qgj/tlpY0/bI8Oq9kjVLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgIZ135QiwZsfpvdTHOj5MOqiPv6dejTmaNv8mjDUdYY6FapCzgJYFSQ5nZdOSWQIo+dL7OHD7j+sWOq1ePj07VnHLTWVc+5B0LowhlJIQwA9zG+6xQiuDrODie/GurbyI/INL7Ayobev88SVV8ipzptHa227iFl9NOQK1PGXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwYXYLZP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751446040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XGPvOMHCBki+0DGVKzrQx//itzBlHUfbVgGZ8KlxIMo=;
	b=UwYXYLZPvFfCjW5LAr3PppF28+NPq8RPEatrU45WUfsp944QgFKO9K1AFXW6pm8SMHr/3S
	70LUQ43wTi4O/FGJU8evukQryU/pjCpOI3fGKIt4qjyCfP0DNXHsJQ8hw+DmWB4wADcU2b
	AguoLWVXxCYFMaw0LnNbe6epN8Mrs+Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-zQGXJn_dONqM8WTaylbbrQ-1; Wed, 02 Jul 2025 04:47:19 -0400
X-MC-Unique: zQGXJn_dONqM8WTaylbbrQ-1
X-Mimecast-MFC-AGG-ID: zQGXJn_dONqM8WTaylbbrQ_1751446038
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso1989798f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 01:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751446038; x=1752050838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGPvOMHCBki+0DGVKzrQx//itzBlHUfbVgGZ8KlxIMo=;
        b=GrGEfiZ09SzAO/PiMoMUDBbHlZKVPJA00O4u2HEtx9Flqe9SWmzJjUNCnEd1Z4FX7W
         ZUWt8lkpMuDe8FFnTt1Oc30MwsxgatIH+cjtqAaYNDOoYQMAEi7wFBHao5E/o79JwmXK
         dvxxFTjQFrM/89Ka2I/OdmOffuzrAQj82yy67EFFA9cblB+kDh50apXf4Em87SpsoU0p
         wvZV+OzdSIMVqkfSemJeX+Cl3xLD0+oBCH5e1IGxldqJ/9g3i4o8HkDlB7uQZaihqYbZ
         WWTRYSHgMU3nj9/yTW5E6bTM+cs1Twvw0vVKOFjHrlVQe6ULZFGYU1xGGxhn1JTgvUx/
         Jj9A==
X-Forwarded-Encrypted: i=1; AJvYcCWxOtxEsUoJKE3P1eJ2liCF1YU7zZgeKSKTIrdWoqvgKFSl4Jhi7NNRN9Zvz9ImFyh0dvqGGX6oOVgPtla5@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZgBXROyFochFF+Zl6TN0xAzECkhX7yepBV1C6+jnlzFYt+5i
	g76jJJYlocJ8T/QzroG5t8SnY1mFD5exY8/nvifj63IPaPbem/Pz9WzgQz+LBv3aOg4AXhxXbbw
	dDELn0VEbeRqES4YST6erJUoEsnR6yPPwieu2vwWPoML1kxnty3dAxN93EblG+w3MJA==
X-Gm-Gg: ASbGncsNPnjGFgY1CHRxBcN4kAWoUL2E/NdnmZPfM6UL02PFM8UK/K4Y7c1jHDcstHA
	YMMBIuEqK04RD1NdKlOTFZTfiL3uMMJAoaDP+rIQ3gFLK9a2b57hljuInNnLCrqoasFx8AtvJ/0
	KbmEXaXs0APXWsgAWZr+GMvcX6WtX2aXnSWCrpeCBy8WkfjiW+vngu2ouFpPPOw57QFkaAxsl2W
	bzS0slEYAQJCSnysp+/gZrexdTvYRNE4k6R0LhqLfOq1RUJ5JZLr9QbUMGXjWS2aFhWh23pyFEf
	PF5urFfixlhrKzqH9x02mLtnrf7zmy+QgHO7MG+dGQ==
X-Received: by 2002:a05:6000:4404:b0:3a4:dfc2:bb60 with SMTP id ffacd0b85a97d-3b200679d86mr862997f8f.26.1751446037759;
        Wed, 02 Jul 2025 01:47:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyJEiWrHlqXkFQrxUFEb5GHh9tMZ7D9Zr7fvg/6zlDjcdyq7cSpkw1286PNdbwkFSOxF/8sA==
X-Received: by 2002:a05:6000:4404:b0:3a4:dfc2:bb60 with SMTP id ffacd0b85a97d-3b200679d86mr862981f8f.26.1751446037266;
        Wed, 02 Jul 2025 01:47:17 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e71dfsm15141298f8f.7.2025.07.02.01.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:47:16 -0700 (PDT)
Date: Wed, 2 Jul 2025 10:47:14 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 2/6] lsm: introduce new hooks for setting/getting
 inode fsxattr
Message-ID: <znxkpxdshpsnupmlxis5qmpfmbmetndfduah3hug4haxpbzftz@nhxyahwcl5mf>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-2-c4e3bc35227b@kernel.org>
 <20250701181813.GN10009@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701181813.GN10009@frogsfrogsfrogs>

On 2025-07-01 11:18:13, Darrick J. Wong wrote:
> On Mon, Jun 30, 2025 at 06:20:12PM +0200, Andrey Albershteyn wrote:
> > Introduce new hooks for setting and getting filesystem extended
> > attributes on inode (FS_IOC_FSGETXATTR).
> > 
> > Cc: selinux@vger.kernel.org
> > Cc: Paul Moore <paul@paul-moore.com>
> > 
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> 
> I wonder, were FS_IOC_FS[GS]ETXATTR already covered by the
> security_file_ioctl hook? 

looks like

> If so, will an out of date security policy
> on a 6.17 kernel now fail to check the new file_[gs]etattr syscalls?

Yeah, probably, not sure if policies can have 'don't allow unknown'
but this is probably will need to be updated in the policy

> 
> Though AFAICT the future of managing these "extra" file attributes is
> the system call so it's probably appropriate to have an explicit
> callout to LSMs.
> 
> Acked-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  fs/file_attr.c                | 19 ++++++++++++++++---
> >  include/linux/lsm_hook_defs.h |  2 ++
> >  include/linux/security.h      | 16 ++++++++++++++++
> >  security/security.c           | 30 ++++++++++++++++++++++++++++++
> >  4 files changed, 64 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/file_attr.c b/fs/file_attr.c
> > index 2910b7047721..be62d97cc444 100644
> > --- a/fs/file_attr.c
> > +++ b/fs/file_attr.c
> > @@ -76,10 +76,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
> >  int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> >  {
> >  	struct inode *inode = d_inode(dentry);
> > +	int error;
> >  
> >  	if (!inode->i_op->fileattr_get)
> >  		return -ENOIOCTLCMD;
> >  
> > +	error = security_inode_file_getattr(dentry, fa);
> > +	if (error)
> > +		return error;
> > +
> >  	return inode->i_op->fileattr_get(dentry, fa);
> >  }
> >  EXPORT_SYMBOL(vfs_fileattr_get);
> > @@ -242,12 +247,20 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
> >  		} else {
> >  			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
> >  		}
> > +
> >  		err = fileattr_set_prepare(inode, &old_ma, fa);
> > -		if (!err)
> > -			err = inode->i_op->fileattr_set(idmap, dentry, fa);
> > +		if (err)
> > +			goto out;
> > +		err = security_inode_file_setattr(dentry, fa);
> > +		if (err)
> > +			goto out;
> > +		err = inode->i_op->fileattr_set(idmap, dentry, fa);
> > +		if (err)
> > +			goto out;
> >  	}
> > +
> > +out:
> >  	inode_unlock(inode);
> > -
> >  	return err;
> >  }
> >  EXPORT_SYMBOL(vfs_fileattr_set);
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index bf3bbac4e02a..9600a4350e79 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -157,6 +157,8 @@ LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
> >  	 struct dentry *dentry, const char *name)
> >  LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
> >  	 const char *name)
> > +LSM_HOOK(int, 0, inode_file_setattr, struct dentry *dentry, struct fileattr *fa)
> > +LSM_HOOK(int, 0, inode_file_getattr, struct dentry *dentry, struct fileattr *fa)
> >  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
> >  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
> >  LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index dba349629229..9ed0d0e0c81f 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -451,6 +451,10 @@ int security_inode_listxattr(struct dentry *dentry);
> >  int security_inode_removexattr(struct mnt_idmap *idmap,
> >  			       struct dentry *dentry, const char *name);
> >  void security_inode_post_removexattr(struct dentry *dentry, const char *name);
> > +int security_inode_file_setattr(struct dentry *dentry,
> > +			      struct fileattr *fa);
> > +int security_inode_file_getattr(struct dentry *dentry,
> > +			      struct fileattr *fa);
> >  int security_inode_need_killpriv(struct dentry *dentry);
> >  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
> >  int security_inode_getsecurity(struct mnt_idmap *idmap,
> > @@ -1052,6 +1056,18 @@ static inline void security_inode_post_removexattr(struct dentry *dentry,
> >  						   const char *name)
> >  { }
> >  
> > +static inline int security_inode_file_setattr(struct dentry *dentry,
> > +					      struct fileattr *fa)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline int security_inode_file_getattr(struct dentry *dentry,
> > +					      struct fileattr *fa)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline int security_inode_need_killpriv(struct dentry *dentry)
> >  {
> >  	return cap_inode_need_killpriv(dentry);
> > diff --git a/security/security.c b/security/security.c
> > index 596d41818577..711b4de40b8d 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2622,6 +2622,36 @@ void security_inode_post_removexattr(struct dentry *dentry, const char *name)
> >  	call_void_hook(inode_post_removexattr, dentry, name);
> >  }
> >  
> > +/**
> > + * security_inode_file_setattr() - check if setting fsxattr is allowed
> > + * @dentry: file to set filesystem extended attributes on
> > + * @fa: extended attributes to set on the inode
> > + *
> > + * Called when file_setattr() syscall or FS_IOC_FSSETXATTR ioctl() is called on
> > + * inode
> > + *
> > + * Return: Returns 0 if permission is granted.
> > + */
> > +int security_inode_file_setattr(struct dentry *dentry, struct fileattr *fa)
> > +{
> > +	return call_int_hook(inode_file_setattr, dentry, fa);
> > +}
> > +
> > +/**
> > + * security_inode_file_getattr() - check if retrieving fsxattr is allowed
> > + * @dentry: file to retrieve filesystem extended attributes from
> > + * @fa: extended attributes to get
> > + *
> > + * Called when file_getattr() syscall or FS_IOC_FSGETXATTR ioctl() is called on
> > + * inode
> > + *
> > + * Return: Returns 0 if permission is granted.
> > + */
> > +int security_inode_file_getattr(struct dentry *dentry, struct fileattr *fa)
> > +{
> > +	return call_int_hook(inode_file_getattr, dentry, fa);
> > +}
> > +
> >  /**
> >   * security_inode_need_killpriv() - Check if security_inode_killpriv() required
> >   * @dentry: associated dentry
> > 
> > -- 
> > 2.47.2
> > 
> > 
> 

-- 
- Andrey


