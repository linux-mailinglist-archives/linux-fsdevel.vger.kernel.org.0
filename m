Return-Path: <linux-fsdevel+bounces-62345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CF9B8E58E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 22:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A2304E0F4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 20:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECAD296BAA;
	Sun, 21 Sep 2025 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OtBllW88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87A28DEE9
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Sep 2025 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758487482; cv=none; b=StPPsMcPCrlJi6l5X2hJVthVzG+q/UOYisnt8BDKjMgu81ShQMf8Ll4+6STl9nwDJIXwjl1LqUvocAJ+x3asGEDgDuEIVW2ix7dC/35YBU12/uCuUcQoJJK9dtd3G+TljxvVhs8ms5cOXArxGejkGz854e+ga67y7c1t5xYX0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758487482; c=relaxed/simple;
	bh=Wxk78sm4WTiUf+x56XODeSTjFI7Tre8+DrBZx8G9zJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD3BPX5nulMZ0C9vtWywxFdjZ0FMWFNUjmh+JxGoKXdzQ9nhiHTt/Qru4JiAR/VOOL+hCoVn93E7G5Wjgtjxq4T31n+mq1/z5mrHlHUjmu1xDDsAWDIvqqArN1Hbswf3Tme20uxCO15J7NpL1F4hDPrfusxa5ry95n9sIn6KqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OtBllW88; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so4143572a91.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Sep 2025 13:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758487480; x=1759092280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrp1vYn8+/NUY8DL+Z+wSSTE0867IgQjPinmMLmeavI=;
        b=OtBllW88bWT+5JkhPGe2I4Ealc/+3vv6WTMYI1NmxEUxtus19pQzylFJ/abVB+Q+Im
         Nwy4r6FNVd898GqFEkqfoxFknGjjbzfq6aYvv4059euZdYkPw4P1lM7jdZM8r82Wy83V
         L/qZZ/oAOW8T0N5Prn6DC09yvSQmnBK8RyMqyqompmrD0RKLNyda1NH34aCTcKuDe2Va
         vkxShCUOm9t4hWjLS4PvZIcrQ/w7H4Q8fdaGC38MRU6WML0KUIhGLKTAxKr0zHGfJ3wb
         YTY1Ncf0NdvU+2CKahpOZ1322UKBjUAYB9E05g4WDqIA8gmv4d1pY6iPAMEgohHdNowx
         0IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758487480; x=1759092280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrp1vYn8+/NUY8DL+Z+wSSTE0867IgQjPinmMLmeavI=;
        b=ws7rNK+VgEULKY3PeiDr7kGvNyZGPMYc45jTXbLUEnL4EyiD85Pb0//O0UBubggrUq
         KtXy1raE2HWTapRS7nX7SYzbRaivszpCuewzdzDhJVZ28mm2/tIW4Ip9VNTTRc7z8oLq
         72sdaNYaGYgAuJYDZON7Z7EAVMlJl8TKoMegfu5c6zq45+umOmvZoCK8BZUgDR/oMNwt
         ApDH3WRlVIVn3JCyeaLGzxETNxCS97WXnGAOUiEeKkYjt5F2J8HTCw+RZZ9HpvzG1//M
         rTS/h8mWPNC6YdVVt/a/YFrny/Xf9K7l49eee2xZGT3XKiSae+ERaOSyPpIHgPBcsN6d
         G+5A==
X-Gm-Message-State: AOJu0YzJ2bKr6romqozrXPhSRxI5olj3aMjxDOQP0C43QypWuYrLKECy
	3QlpuiA0wnBR3xqOxAb26z5HON6acoOpx1Ts577qRCiKcP8mz6Mu7ryJbDkNVoq5HPU3Mlo1W+m
	xesPI7HqHe3Kh5PTVWe9hhayxA+T6zNSka9cHEDAn
X-Gm-Gg: ASbGncvxcZ3nZXuJxm8jqiMVXTfDejAXiCNAaaYO33SezfWlVadB2KrJ9wjYmJS22q5
	wqFlpZQ+kDPTZQYHosLVFyrlGfDH7dcqaI/Nx0uRpwHRVQJRFUdID0t1Xf173P2W0wLEmXZrXoZ
	yScGG70iYRhVcMH5vmbD/+e+zSvDo23fdFgWyjt2JokL7p7GEid+aCyRz5UhOGysnJVQnz3cXKb
	ZjWOSw=
X-Google-Smtp-Source: AGHT+IHAbyCRLo/SSuvdFEQRy5JpOpl0NDRXzF/3drghYuhCInE4K6vDNKt06XHhxx3gZXaSMmGzjnpjA/kIMwyAfV0=
X-Received: by 2002:a17:90b:3c06:b0:32d:17ce:49d5 with SMTP id
 98e67ed59e1d1-33098245d63mr11380894a91.23.1758487480037; Sun, 21 Sep 2025
 13:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920074156.GK39973@ZenIV> <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-31-viro@zeniv.linux.org.uk>
In-Reply-To: <20250920074759.3564072-31-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 21 Sep 2025 16:44:28 -0400
X-Gm-Features: AS18NWAIN9lhY1WlDGBZGFYNywlyC9vJx6yZK1w_BS23ADZS6YvZADa5RlquZNs
Message-ID: <CAHC9VhTRsQtncKx4bkbkSqVXpZyQLHbvKkcaVO-ss21Fq36r+Q@mail.gmail.com>
Subject: Re: [PATCH 31/39] convert selinuxfs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, borntraeger@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 3:48=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> Tree has invariant part + two subtrees that get replaced upon each
> policy load.  Invariant parts stay for the lifetime of filesystem,
> these two subdirs - from policy load to policy load (serialized
> on lock_rename(root, ...)).
>
> All object creations are via d_alloc_name()+d_add() inside selinuxfs,
> all removals are via simple_recursive_removal().
>
> Turn those d_add() into d_make_persistent()+dput() and that's mostly it.
> Don't bother to store the dentry of /policy_capabilities - it belongs
> to invariant part of tree and we only use it to populate that directory,
> so there's no reason to keep it around afterwards.

Minor comment on that below, as well as a comment style nitpick, but
overall no major concerns from me.

Acked-by: Paul Moore <paul@paul-moore.com>

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/selinux/selinuxfs.c | 52 +++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 22 deletions(-)

...

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 9aa1d03ab612..dc1bb49664f2 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1966,10 +1973,11 @@ static struct dentry *sel_make_swapover_dir(struc=
t super_block *sb,
>         /* directory inodes start off with i_nlink =3D=3D 2 (for "." entr=
y) */
>         inc_nlink(inode);
>         inode_lock(sb->s_root->d_inode);
> -       d_add(dentry, inode);
> +       d_make_persistent(dentry, inode);
>         inc_nlink(sb->s_root->d_inode);
>         inode_unlock(sb->s_root->d_inode);
> -       return dentry;
> +       dput(dentry);
> +       return dentry;  // borrowed
>  }

Prefer C style comments on their own line:

  dput(dentry);
  /* borrowed dentry */
  return dentry;

> @@ -2079,15 +2088,14 @@ static int sel_fill_super(struct super_block *sb,=
 struct fs_context *fc)
>                 goto err;
>         }
>
> -       fsi->policycap_dir =3D sel_make_dir(sb->s_root, POLICYCAP_DIR_NAM=
E,
> +       dentry =3D sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
>                                           &fsi->last_ino);

I'd probably keep fsi->policycap_dir in this patch simply to limit the
scope of this patch to just the DCACHE_PERSISTENT related changes, but
I'm not going to make a big fuss about that.

> -       if (IS_ERR(fsi->policycap_dir)) {
> -               ret =3D PTR_ERR(fsi->policycap_dir);
> -               fsi->policycap_dir =3D NULL;
> +       if (IS_ERR(dentry)) {
> +               ret =3D PTR_ERR(dentry);
>                 goto err;
>         }
>
> -       ret =3D sel_make_policycap(fsi);
> +       ret =3D sel_make_policycap(fsi, dentry);
>         if (ret) {
>                 pr_err("SELinux: failed to load policy capabilities\n");
>                 goto err;

--=20
paul-moore.com

