Return-Path: <linux-fsdevel+bounces-59441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C552B38B07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 22:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCF43AD9DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E492F39BD;
	Wed, 27 Aug 2025 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X/2NIHA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411802D3220;
	Wed, 27 Aug 2025 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756327066; cv=none; b=tfDl6hLvMOGwjK6+ePb8gDn7HRxqSwJx6Ueb+1vex6TjAeng1nFlOLsFAZgjor3e3+1RT5oN9Z8uec4STG8GaLHJ6RqGHcx3BJGb9bSeGk8Sm9d1ueskMQR8itOfGRd/EaELyWG6hWQFm4RG5RzZ4bx6RJJXUkcIfr43u/aUvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756327066; c=relaxed/simple;
	bh=7AmZiN2smU+gwIEOHsqoUJ9PRQrK2WNsjJB6SdskA0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzNc10WmjYUwJ1zdB1NuBGbDrRVIYRA+9Yhebbn5qGkoubVbPsY7QwnUOOVgRbDeaOweUux6r75CaEDMpE+VY7p4zI+x3w94KaL9wo7KjjlWWkcNzTY1wiVLudMD9R92WEov1Y7bRkXXkC0RtoPV9r9geG/xCVJKk3ybK0ksIO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X/2NIHA+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wZyx7QTDejNp5Lx9hmwKjKcPMV0r7m+t7KQuiDG/eZM=; b=X/2NIHA+idvHlpmmxhYCSHdK/Y
	Ip1FbvaxaKR7cgEeq5jjV+M2wkYytXYY9cKb4N0+qfXPKIsXCg8lgWEMttytXPVCmKrYpZr69Q/R6
	eaCiHqKlokxCivUXR1YxE5Waac5/qU/Ig18N00FC8CevQCkQBUCoYV7JNx3PUagmJ6esAgK6KP9iq
	fkxotaz738hk7cwHIcKp7ZHEPZ5ttz3TvzzQXFHGwjkBupHlNq5oxrQpuyBDul6JTuyUpx/1jikNd
	aReRi0Ot6Sw7eKtcfWbQXhv1Fj/PkJ5DeH8mXr8sGFqZLRT6gped+6w2c2ODy42uRpxix08mr1TsZ
	mdtOe8mQ==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1urMte-002bm5-PL; Wed, 27 Aug 2025 22:37:30 +0200
Message-ID: <5934fe16-32e7-425a-b4ee-cdcb77dd751a@igalia.com>
Date: Wed, 27 Aug 2025 17:37:26 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled
 layers
To: Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-9-8b6e9e604fa2@igalia.com>
 <CAOQ4uxhWE=5_+DBx7OJ94NVCZXztxf1d4sxyMuakDGKUmbNyTg@mail.gmail.com>
 <62e60933-1c43-40c2-a166-91dd27b0e581@igalia.com>
 <CAOQ4uxjgp20vQuMO4GoMxva_8yR+kcW3EJxDuB=T-8KtvDr4kg@mail.gmail.com>
 <6235a4c0-2b28-4dd6-8f18-4c1f98015de6@igalia.com>
 <CAOQ4uxgMdeiPt1v4s07fZkGbs5+3sJw5VgcFu33_zH1dZtrSsg@mail.gmail.com>
 <18704e8c-c734-43f3-bc7c-b8be345e1bf5@igalia.com>
 <CAOQ4uxj551a7cvjpcYEyTLtsEXw9OxHtTc-VSm170J5pWtwoUQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxj551a7cvjpcYEyTLtsEXw9OxHtTc-VSm170J5pWtwoUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 27/08/2025 15:06, Amir Goldstein escreveu:

[...]

> 
> The reason is this:
> 
> static struct dentry *ext4_lookup(...
> {
> ...
>          if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
>                  /* Eventually we want to call d_add_ci(dentry, NULL)
>                   * for negative dentries in the encoding case as
>                   * well.  For now, prevent the negative dentry
>                   * from being cached.
>                   */
>                  return NULL;
>          }
> 
>          return d_splice_alias(inode, dentry);
> }
> 
> Neil,
> 
> Apparently, the assumption that
> ovl_lookup_temp() => ovl_lookup_upper() => lookup_one()
> returns a hashed dentry is not always true.
> 
> It may be always true for all the filesystems that are currently
> supported as an overlayfs
> upper layer fs (?), but it does not look like you can count on this
> for the wider vfs effort
> and we should try to come up with a solution for ovl_parent_lock()
> that will allow enabling
> casefolding on overlayfs layers.
> 
> This patch seems to work. WDYT?
> 
> Thanks,
> Amir.
> 

Thank you for the fix!

> commit 5dfcd10378038637648f3f422e3d5097eb6faa5f
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Wed Aug 27 19:55:26 2025 +0200
> 
>      ovl: adapt ovl_parent_lock() to casefolded directories
> 
>      e8bd877fb76bb9f3 ("ovl: fix possible double unlink") added a sanity

Just to make checkpatch happy, this should be

Commit e8bd877fb76b ("ovl: fix possible double unlink") added a sanity

>      check of !d_unhashed(child) to try to verify that child dentry was not
>      unlinked while parent dir was unlocked.
> 
>      This "was not unlink" check has a false positive result in the case of
>      casefolded parent dir, because in that case, ovl_create_temp() returns
>      an unhashed dentry.
> 
>      Change the "was not unlinked" check to use cant_mount(child).
>      cant_mount(child) means that child was unlinked while we have been
>      holding a reference to child, so it could not have become negative.
> 
>      This fixes the error in ovl_parent_lock() in ovl_check_rename_whiteout()
>      after ovl_create_temp() and allows mount of overlayfs with casefolding
>      enabled layers.
> 
>      Reported-by: André Almeida <andrealmeid@igalia.com>
>      Link: https://lore.kernel.org/r/18704e8c-c734-43f3-bc7c-b8be345e1bf5@igalia.com/

I think the correct chain here is:

Reported-by: André Almeida <andrealmeid@igalia.com>
Closes: 
https://lore.kernel.org/r/18704e8c-c734-43f3-bc7c-b8be345e1bf5@igalia.com/
Fixes: e8bd877fb76b ("ovl: fix possible double unlink")

>      Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 

Reviewed-by: André Almeida <andrealmeid@igalia.com>

> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index bec4a39d1b97c..bffbb59776720 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1551,9 +1551,23 @@ void ovl_copyattr(struct inode *inode)
> 
>   int ovl_parent_lock(struct dentry *parent, struct dentry *child)
>   {
> +       bool is_unlinked;
> +
>          inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> -       if (!child ||
> -           (!d_unhashed(child) && child->d_parent == parent))
> +       if (!child)
> +               return 0;
> +
> +       /*
> +        * After re-acquiring parent dir lock, verify that child was not moved
> +        * to another parent and that it was not unlinked. cant_mount() means
> +        * that child was unlinked while parent was unlocked. Since we are
> +        * holding a reference to child, it could not have become negative.
> +        * d_unhashed(child) is not a strong enough indication for unlinked,
> +        * because with casefolded parent dir, ovl_create_temp() returns an
> +        * unhashed dentry.
> +        */
> +       is_unlinked = cant_mount(child) || WARN_ON_ONCE(d_is_negative(child));
> +       if (!is_unlinked && child->d_parent == parent)
>                  return 0;
> 
>          inode_unlock(parent->d_inode);


