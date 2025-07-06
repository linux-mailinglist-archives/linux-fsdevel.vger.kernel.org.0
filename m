Return-Path: <linux-fsdevel+bounces-54026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D1CAFA2E4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 05:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 051C27A4DB2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 03:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB71922C0;
	Sun,  6 Jul 2025 03:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9Pt1wN6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FE618C31
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Jul 2025 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751773774; cv=none; b=Ao6BvfUhVYUASWkX5Cc0HWsQMDjHJoUxKvrhnB8MFdsftZ/gK7MvCVboEx5DfUfdhQ7T3wtVf9i7JR0ziFzDjpJZmIxl1YHgW7/wMwgZekpUNbCZYtO5JIYDnGs71l0IaztGMpRsvIakUlVH0Ozghv90DT24icPfwBLfuKqsT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751773774; c=relaxed/simple;
	bh=F0RMvEPVEAYUq2gpQ0Z+8hx3BdxBiuX8Ldgk8Noaelg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERFzWihX7XI3qf89lbeKIh1zaH4uRcd8bLVmKXWk7Eo/Z1t2lOo0w9wRDw2zSnkl5LPuEyxvhZvnH8DkAee1WrwTdjnPB6keAt9kXiIW6wJROllTPPwfmnjBZ8E24RScTQzj1ZRWtpB3L5mdokn0qjpBy1VRTBPAGlSaxQwIWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9Pt1wN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAFAC4CEEF
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Jul 2025 03:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751773774;
	bh=F0RMvEPVEAYUq2gpQ0Z+8hx3BdxBiuX8Ldgk8Noaelg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M9Pt1wN6PpU7XtLseq0vO35GW9pf60RkJi04EGyHp/y5ltbeeaFtMvtt2Vvtm3NWp
	 qboZ3oJOySIUe00yxqn3sjP6GUdrKBTfZNwBSP7kQ2IWMxUlkDAAGcm4a+DlBTCmj0
	 G0Pnk2JHUZfeDHlJpBsDHRurAFW2gwb4C+uF8Yty+N+8N7A7gQ/iEMvHArjDr2OtUV
	 Yvsl3qOWaCv0NlS+0FqRvHBUg2DYhrr85VjXGu+eSvEv5tf1eYKTST6TKnlZlyEfjt
	 nHCrWfV9fFg90xu1Pvyb9s/wdQpuAbE2FJqeIvZLQUyk+hlhRepdPmmu4iBWZiQpoo
	 qRrp73nT7ZWVg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae360b6249fso366201666b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Jul 2025 20:49:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz89LTs4+usLuySuO/dYnc4PCJe4FVZ69XFiYGX31rJIZJqhb2a
	WqsRgn/niz8/5j8WitOkSB8DMN2Ss54NdrNJvOLrsIMv1B1Jgmov7Dy3zyAgxO2vUuSKPMJ1pNV
	M2n51v51S/i2CkBROCTmYVznsjfWf4P8=
X-Google-Smtp-Source: AGHT+IGKuZ8BOnHtWod/wG+5bkmPe4XiMFZB2Aun7kiAFVD6KRaNjcBwR84pU0+RqunLXE2a3XtLWQW04n3ARvrWmnk=
X-Received: by 2002:a17:907:7e93:b0:ae0:aa0d:7bfa with SMTP id
 a640c23a62f3a-ae4108c81acmr314941866b.50.1751773772870; Sat, 05 Jul 2025
 20:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704194414.GR1880847@ZenIV> <CAHk-=wgurLEukSdbUPk28rW=hsVGMxE4zDOCZ3xxY3ee3oGyoQ@mail.gmail.com>
 <20250704202337.GT1880847@ZenIV> <20250705000114.GU1880847@ZenIV>
 <20250705185359.GZ1880847@ZenIV> <20250706012645.GB1880847@ZenIV>
In-Reply-To: <20250706012645.GB1880847@ZenIV>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 6 Jul 2025 12:49:21 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-8neCX1ciNpp-rXrVo97bm_tuMLotrBCM-o_RS3f84Dw@mail.gmail.com>
X-Gm-Features: Ac12FXz_326-V3hmNqrP2Oa_r1sKrR9C9nbhYH5_4s4UqsXgSPrgA34YnQGwSUE
Message-ID: <CAKYAXd-8neCX1ciNpp-rXrVo97bm_tuMLotrBCM-o_RS3f84Dw@mail.gmail.com>
Subject: Re: [PATCH] fix a mount write count leak in ksmbd_vfs_kern_path_locked()
 (was Re: [RFC] MNT_WRITE_HOLD mess)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 10:26=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> If the call of ksmbd_vfs_lock_parent() fails, we drop the parent_path
> references and return an error.  We need to drop the write access we
> just got on parent_path->mnt before we drop the mount reference - callers
> assume that ksmbd_vfs_kern_path_locked() returns with mount write
> access grabbed if and only if it has returned 0.
>
> Fixes: 864fb5d37163 "ksmbd: fix possible deadlock in smb2_open"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Applied it to #ksmbd-for-next-next.
Thank you for the patch!
> ---
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 0f3aad12e495..d3437f6644e3 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -1282,6 +1282,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *w=
ork, char *name,
>
>                 err =3D ksmbd_vfs_lock_parent(parent_path->dentry, path->=
dentry);
>                 if (err) {
> +                       mnt_drop_write(parent_path->mnt);
>                         path_put(path);
>                         path_put(parent_path);
>                 }

