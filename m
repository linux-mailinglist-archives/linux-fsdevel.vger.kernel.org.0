Return-Path: <linux-fsdevel+bounces-40399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1950A230F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 16:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AB518893AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323C21EBFF9;
	Thu, 30 Jan 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW+rZwmM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0E1E9B3F;
	Thu, 30 Jan 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738250412; cv=none; b=Var1toKtvx81UFy2PE+513/xFQxgo+cGjv00xDA28AGsOQ7cMYmtn+jCM24PkIyYXmeWY6rbu6T3iFjxsqBjIr7un3pdXk6nVmJ+nkb+cq2YDKiRhqHUE90zIV2W5aZB2yG6fudatEbKszkOjDtn/5kOHSdAKMSiu+59YmasYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738250412; c=relaxed/simple;
	bh=LzJikOHTQrKhiSfwSHwXbPkw3fyrXwxEDOZFzZUeWWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUxasOC6w62oMSKuB3MOufb7qdSNZTmi5D1LgWDbrC77qMHbXUOofK0hnsErO27+qI1eYfLxPPcWkYcN+Edr9MgXJYztYsU9jS6Ct4h/w1lR0YoC0AqHdVD15XUOVXsQ/F5vqvevGxc+2EfdCybIwJjWLa0b8jwM5eUbAN+mgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW+rZwmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57258C4CED2;
	Thu, 30 Jan 2025 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738250412;
	bh=LzJikOHTQrKhiSfwSHwXbPkw3fyrXwxEDOZFzZUeWWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OW+rZwmMF9dPYRDw7+8Pu8ODOo9lCCF9S9P1aYZNpd20WyCl4ax7Az98braP/Vw0r
	 cgcpXs9oQsBOlLFbMNjs1nryS9QfwQ+2xowT3uxz3DNDXH8pVse0jSm20CNEI2OYtV
	 EYd4YjIHfkEN34M9S5TWCdL4Zamtgdh3TK2zyPlOau4X2s5Hqy77ZvprC4R99AgAXJ
	 tWFfI5COyFLEf30LJbSr43O/yqmH0oWJBiKMkKwXwW2CMdAPjop15kz5QJSW+spd5+
	 C2bSTvMJsW1UCWxEb6O7eCjl1R5lmaBLMjC4qFSaWaasUo8WfI1tpZLtldN1UzfqXj
	 VgpuQv0KAiHsw==
Date: Thu, 30 Jan 2025 16:20:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, liamwisehart@meta.com, 
	shankaran@meta.com
Subject: Re: [PATCH v11 bpf-next 1/7] fs/xattr: bpf: Introduce security.bpf.
 xattr name prefix
Message-ID: <20250130-erklimmen-erstversorgung-93daf77c9dc4@brauner>
References: <20250129205957.2457655-1-song@kernel.org>
 <20250129205957.2457655-2-song@kernel.org>
 <Z5tbH13qK6rLJVUI@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5tbH13qK6rLJVUI@google.com>

On Thu, Jan 30, 2025 at 10:57:35AM +0000, Matt Bobrowski wrote:
> On Wed, Jan 29, 2025 at 12:59:51PM -0800, Song Liu wrote:
> > Introduct new xattr name prefix security.bpf., and enable reading these
> > xattrs from bpf kfuncs bpf_get_[file|dentry]_xattr().
> > 
> > As we are on it, correct the comments for return value of
> > bpf_get_[file|dentry]_xattr(), i.e. return length the xattr value on
> > success.
> 
> Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
> 
> > Signed-off-by: Song Liu <song@kernel.org>
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/bpf_fs_kfuncs.c         | 19 ++++++++++++++-----
> >  include/uapi/linux/xattr.h |  4 ++++
> >  2 files changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > index 3fe9f59ef867..8a65184c8c2c 100644
> > --- a/fs/bpf_fs_kfuncs.c
> > +++ b/fs/bpf_fs_kfuncs.c
> > @@ -93,6 +93,11 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
> >  	return len;
> >  }
> >  
> > +static bool match_security_bpf_prefix(const char *name__str)
> > +{
> > +	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
> > +}
> 
> I think this can also just be match_xattr_prefix(const char
> *name__str, const char *prefix, size_t len) such that we can do the
> same checks for aribitrary xattr prefixes i.e. XATTR_USER_PREFIX,
> XATTR_NAME_BPF_LSM.
> 
> >  /**
> >   * bpf_get_dentry_xattr - get xattr of a dentry
> >   * @dentry: dentry to get xattr from
> > @@ -101,9 +106,10 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
> >   *
> >   * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
> >   *
> > - * For security reasons, only *name__str* with prefix "user." is allowed.
> > + * For security reasons, only *name__str* with prefix "user." or
>       	  	   	    	 	     	  ^ prefixes
> 						  
> > + * "security.bpf." is allowed.
>                       ^ are
> 
> Out of curiosity, what is the security reasoning here? This isn't
> obvious to me, and I'd like to understand this better. Is it simply
> frowned upon to read arbitrary xattr values from the context of a BPF
> LSM program, or has it got something to do with the backing xattr
> handler that ends up being called once we step into __vfs_getxattr()
> and such?  Also, just so that it's clear, I don't have anything
> against this allow listing approach either, I just genuinely don't
> understand the security implications.

I've explained this at lenghts in multiple threads. The gist is various
xattrs require you to have access to properties that are carried by
objects you don't have access to (e.g., the mount) or can't guarantee
that you're in the correct context and interpreting those xattrs without
this information is either meaningless or actively wrong.

