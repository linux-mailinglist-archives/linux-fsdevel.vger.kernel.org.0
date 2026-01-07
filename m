Return-Path: <linux-fsdevel+bounces-72630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178A2CFE650
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 15:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01E70305220F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D56327C08;
	Wed,  7 Jan 2026 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuKhOXx6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6213016E0
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797079; cv=none; b=YMd75RTGOZdKNhGPbvU3vnU0a+vQTWCigxL0d93M9dIr/MWAKIEiq8+m2goKOy4sJI4smlrFFYwdt8uMadsVcCKl4cqhfu6taxq/mmlmsup+Lq/1e1f97GTdLGM3c+kuBQ03EMaK314/s5eKELY3i3xvH6inxHJ9xDtmxIWCrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797079; c=relaxed/simple;
	bh=fld04OkYp/YlKHz5K+PsYqvd/PBUNqaawkDoc/WRA4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVRDQCTAdl5+Z3L9CTmC1oNB0OEQzfdryNZZHyPjOMJdOM6KVHPLoh+FX0fLoBJr5czjXv2yPZiXZU8m5sUGBoT1QWJUYvMp70lVNPsiHXY0de7369wkMvX50s1jEoGQFvcgP1IUWcc+aBJ2wawQ+XK6byGgg+1TFbGtWXRxzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuKhOXx6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64d4d8b3ad7so3317676a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 06:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767797076; x=1768401876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XImTy4MomiW0MOh/xppmQfYxigfloZM+G8wDCfKyTS4=;
        b=XuKhOXx6BiClczK6YFSJ02mC3ji6Yje2BPYFpFW17QH1yrDHL9nNdt8KG+VZWIvxxr
         bglUrdoI2eNWdG3+YecWytpM0PXmPPKYD++0hlhNdVTkGM/t969tF235OlRsMxE7j6xN
         4/okNqC3NAWjXiLCwqGgGmiLu737tEXicdAdijRcQzDgYycOzoaV0PpSWP1fPwdlPeHM
         dcs3UpNR9YVe60Iwwf6PXMsN+VmVuzeXZ5Mb255mIi52YJxiZhRM/We2O9z86X5TMgLy
         lPdMr9wK7VqcUFcHYfbg4BrE9B1n+HLr/Cz9K2ej64x6SeUU7bugPeahhpsNZuDkgcGo
         2TIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767797076; x=1768401876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XImTy4MomiW0MOh/xppmQfYxigfloZM+G8wDCfKyTS4=;
        b=e4ES6g0Dxa1dGpLk7guSXtihbcSp4pMHNiweotH14obgM9hF0T9Oj+iCzgostP6Adv
         pKgefIBg6I+fiMpaQEovt3j3eJ3qlLQhrtuVWNZ4dplJMIieQ6DmAUHRIk7aFFSt2jrs
         WeYSucN7Qfo511HfNIoiD85/lCY4XZpiiFsewGnz5ekn6TGVC7Nq5IlCgBMbEO1vi48k
         xHoCvobdBLjZ78dIROYPBelSgTm4sQ+Yi9EkyVGD8OyvkzDDEoTyN7TpFrcW7KeNVqrC
         gP/hHWp40siPc3EwB6/ah9KpU4RcHMI36rPHYsFDMw/UKmnO41FM4+lcAFGKMLtcF8NO
         agNA==
X-Forwarded-Encrypted: i=1; AJvYcCUDZteUqLpWV1S5rU+/kJ3zu27Qv34e8hR7HL4b3o9/N1ex8SZDL9mlnPa2Yjk9pXDPmLUp2cGeEz2U9JeL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx42Xh9gPkBCOO3ArcvMnjR/pDxwd2iK0qkHkYhczxSPNy8bSM7
	V6gOuOfgKwIjPtRl7loU9J0ko6879I8MU0cZHUXRSr0UsZkXEQ5H/Mf1zf3ngg==
X-Gm-Gg: AY/fxX5ggTleepWgCy/NV15eZ8JZCO3NDHM5lZAssYLhw9hi09Vzylma6tcCDJ0wejW
	WPCDbDCLN+QnignXgMaqL5HgXr3j2nwT/YzoB1RwfanND9ks+/gzSgLtttAkC6tw7fT6043ylGV
	gen9NIUCIb210r9eVfyndqtX10Wtld6ndgdlbX4kSWydGcjMT9FvuL8rqIWtPI4ng+ZflWYcS2a
	nO5lrZdDwZaBmTZFn1/yIWt5gnCqufKfFgusa+LMnGDRIJC8xj/IDkA0mgprw5qLHCOYVIKnXnm
	ur9x9NmpuzXd6gymFvE3IQY2FErwBfPwYygrBfAfav6/w1IE/lsJRrrOwZAJe8HwRejMVgNGgmk
	tWQjI7Wr0ZsN1RKv2bjcLi8ZreWHxal70zBf+lL7GZTqEscZaU30xGTx7xxgaONVlUqsPNSgi9A
	I0ebhnzJ34C5E1rtY3N9XA4ySYCHVGODk+A0vewWO5A9je/H/LRJDvy8LTaZsVpO5o
X-Google-Smtp-Source: AGHT+IEdR3Ac8gQFSwVXqdl0IfnUpkcLFublBy0AThN72jHNpEJd8BDyoZMOQh/p9jWb1l76r41Xww==
X-Received: by 2002:a17:907:3d8f:b0:b79:ff62:e994 with SMTP id a640c23a62f3a-b84451e2ef2mr267727166b.22.1767797075881;
        Wed, 07 Jan 2026 06:44:35 -0800 (PST)
Received: from f (cst-prg-7-60.cust.vodafone.cz. [46.135.7.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27bfcasm540468766b.21.2026.01.07.06.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:44:35 -0800 (PST)
Date: Wed, 7 Jan 2026 15:44:27 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jlayton@kernel.org, rostedt@goodmis.org, kernel-team@meta.com
Subject: Re: [PATCH] fs/namei: Remove redundant DCACHE_MANAGED_DENTRY check
 in __follow_mount_rcu
Message-ID: <h6gfebegbbtqdjefr52kqdvfjlnpq4euzrq25mw4mdkapa2cfq@dy73qj5go474>
References: <20260105-dcache-v1-1-f0d904b4a7c2@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105-dcache-v1-1-f0d904b4a7c2@debian.org>

On Mon, Jan 05, 2026 at 07:10:27AM -0800, Breno Leitao wrote:
> The check for DCACHE_MANAGED_DENTRY at the start of __follow_mount_rcu()
> is redundant because the only caller (handle_mounts) already verifies
> d_managed(dentry) before calling this function, so, dentry in
> __follow_mount_rcu() has always DCACHE_MANAGED_DENTRY set.
> 
> This early-out optimization never fires in practice - but it is marking
> as likely().
> 
> This was detected with branch profiling, which shows 100% misprediction
> in this likely.
> 
> Remove the whole if clause instead of removing the likely, given we
> know for sure that dentry is not DCACHE_MANAGED_DENTRY.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  fs/namei.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index bf0f66f0e9b9..774a2f5b0a10 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1623,9 +1623,6 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
>  	struct dentry *dentry = path->dentry;
>  	unsigned int flags = dentry->d_flags;
>  
> -	if (likely(!(flags & DCACHE_MANAGED_DENTRY)))
> -		return true;
> -

This makes me very uneasy.

You are seeing 100% misses on this one because you are never racing
against someone mounting and umounting on the dentry as you are doing
the lookup.

As in it is possible that by the time __follow_mount_rcu is invoked,
DCACHE_MANAGED_DENTRY is no longer set and with the check removed the
rest of the routine keeps executing.

AFAICS this turns harmless as is anyway, but I don't think that's safe
to rely on future-wise and more imporantly it is trivially avoidable.

I did not do it at the time because there are no d_ macros which operate
on already read flags and I could not be bothered to add them. In
retrospect a bad call, should have went with it and kept the open-coded
DCACHE_MANAGED_DENTRY check.

something like this:

diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e9b9..c6279f8023cf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1618,13 +1618,11 @@ EXPORT_SYMBOL(follow_down);
  * Try to skip to top of mountpoint pile in rcuwalk mode.  Fail if
  * we meet a managed dentry that would need blocking.
  */
-static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
+static bool __follow_mount_rcu(struct nameidata *nd, struct path *path, int flags)
 {
 	struct dentry *dentry = path->dentry;
-	unsigned int flags = dentry->d_flags;
 
-	if (likely(!(flags & DCACHE_MANAGED_DENTRY)))
-		return true;
+	VFS_BUG_ON(!(flags & DCACHE_MANAGED_DENTRY));
 
 	if (unlikely(nd->flags & LOOKUP_NO_XDEV))
 		return false;
@@ -1672,9 +1670,10 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 	path->dentry = dentry;
 	if (nd->flags & LOOKUP_RCU) {
 		unsigned int seq = nd->next_seq;
-		if (likely(!d_managed(dentry)))
+		unsigned int flags = READ_ONCE(dentry->d_flags);
+		if (likely(!(dentry->d_flags & DCACHE_MANAGED_DENTRY)))
 			return 0;
-		if (likely(__follow_mount_rcu(nd, path)))
+		if (likely(__follow_mount_rcu(nd, path, flags)))
 			return 0;
 		// *path and nd->next_seq might've been clobbered
 		path->mnt = nd->path.mnt;

