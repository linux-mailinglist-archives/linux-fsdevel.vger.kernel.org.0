Return-Path: <linux-fsdevel+bounces-31793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8712299B16C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 09:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D49D1F22AD0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 07:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA113B7BC;
	Sat, 12 Oct 2024 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgZ/g0tu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6C10940;
	Sat, 12 Oct 2024 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728716961; cv=none; b=UnTvuJUKi2B0j4E2WDfsVFYWT63wVmmCkrqnEoJFtb02duB47V8MDHMpsEP6xNqd1j6TM3bpBK0BUAvu9bhKH1mX4OSyvECJy+CZb5nPt8cdjo3GR66vcGhfySjtcBHbjJofsv91Daq0uIv4AKOerV/2mgz061if2LP7fZohZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728716961; c=relaxed/simple;
	bh=n/+IHlvyrFv43hNppw6NeAufbfPHhTMVSRJ/cJt+RDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCpZlfr631AtRttvMNff6xDYTI5I1D/gx4Ijn+jbyeqGKPTTFfyr3JXy07c8jyXAm5zwidoPx3/j5mPlPCQHvW/PtLujBRck2g3h0kXDgxmGkwiIK7z+JVEHD3OIdwWLRxQY9RQL0/ZUintF7C5YD3wQj8+GoiKTaGsqwNzjRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgZ/g0tu; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7afc658810fso239994485a.3;
        Sat, 12 Oct 2024 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728716959; x=1729321759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypi/Dg1wLPrnyeTGvBf3rX1Xz7l1FKvNt4NNG762eZI=;
        b=ZgZ/g0tu77g5WRHpTPCKRb66xwdHw2F2GvDzVgEZL04j7el7KuZ9A0Goa6jNzbpobX
         CpJTgca5RbBnnL1RrpMTa4wx5PRoklsEP3TkBNxUtCyD2Woe6JbmMdVVE0LGzB7CGWeQ
         6nMTQ+T53Yhk/RuY8mkwLodMXrEm7FlGPAVBcXjeW60agmq66Mq8b5ZDaaZLMCxKSUbn
         YjQ/FAtxDZsql3i7fdEH2xCJyYlNx7nZW+dOxGf9fLihikETE2tv4NfvtyoKGLfIFq3I
         5/9MJbTH1SIyxCv7cQbfYRad1vyXXYWWcxlnq16fLAgih7/E50mgHLmFLYJBKaJVBA5S
         EEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728716959; x=1729321759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypi/Dg1wLPrnyeTGvBf3rX1Xz7l1FKvNt4NNG762eZI=;
        b=UVkkGq3yMNpTSjo1/ethtjpPMwg1dQnnKAorEFO33WxKfznHwabn4xMRcYJ5XW8r5E
         dig7Fjrm8HhUJyrRemHlzqwDx1Zzw0sbAa++c6QtQV9sDZOZ8cYSbSBw9+MIUlraDncj
         WyMof8uyhcRBqRQHnqZTX7cWetZh8R9yI05GSla8295zxygkzSThL3Dd8MxMuU74KBAX
         VEaszMOG0lELCKubA5PH1r3Ifpx47iZfQL/9NCH8ZceFsuZfln+8GXRlHhVv1Z+PY8r8
         IeFY/W6PhEqGJNgDeCADEgPd3Z6+9WxgVT6/qlI8ImfYNVtWSkZxcgb3VzHJE/89E/Q6
         mXYA==
X-Forwarded-Encrypted: i=1; AJvYcCUu8voMtM+Fgj85ou+NLncZM8tnsVOtIngpGypi90tpNhWaXfEKepsF2/XAVAIvWhdGw9rBefS/6hrTnF+TTsMqBe7UR1bE@vger.kernel.org, AJvYcCWn/d8iZXhK5Z+RtxuGXoG9B4/rTMhuXNSf4YcsZr1M5MgJ/wj4PB0DXalnoKFxtPVXpo8qPWgL1BhcT3IG@vger.kernel.org, AJvYcCXCSvQ/9cA0M9SIa9P1zsViOXo/N08TTkSSwug8OeHZXKkwnRDjFwttQcuxbVo37t4J9n6Fh7GJAD1dTeDO@vger.kernel.org
X-Gm-Message-State: AOJu0YymobmIFNjGTyjmtFVax9CAJTpu87zT/V1tJobZjO8RtIyFD0u4
	KaJiUESenj25oy+Whn2cJ/awKMq/Y5t0FjwJYi0ii/EqQeAv1oObAwcWn29Ko0xeJncjvx3z66P
	95GVrmdla2KtlVLOp3f1Szfaq2eY=
X-Google-Smtp-Source: AGHT+IG3JYTfBGf9abnh5e61xwfLmIgrY2uMsu5WtatU44POcZFPBjqylFOv0aOl1OtG+HoQIFGV3gw18RWCfUcZMU8=
X-Received: by 2002:a05:620a:2415:b0:7a9:b3a0:84a7 with SMTP id
 af79cd13be357-7b11a34309cmr831986985a.12.1728716959013; Sat, 12 Oct 2024
 00:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011203722.3749850-1-song@kernel.org> <a083e273353d7bc5742ab0030e5ff1f5@paul-moore.com>
In-Reply-To: <a083e273353d7bc5742ab0030e5ff1f5@paul-moore.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 12 Oct 2024 09:09:07 +0200
Message-ID: <CAOQ4uxhg8zEZ4iOpUigv1paHMXvZNCFv_qTNfg-1CcehjE+7oA@mail.gmail.com>
Subject: Re: [PATCH] fsnotify, lsm: Separate fsnotify_open_perm() and security_file_open()
To: Paul Moore <paul@paul-moore.com>
Cc: Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, jmorris@namei.org, 
	serge@hallyn.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:42=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Oct 11, 2024 Song Liu <song@kernel.org> wrote:
> >
> > Currently, fsnotify_open_perm() is called from security_file_open(). Th=
is
> > is not right for CONFIG_SECURITY=3Dn and CONFIG_FSNOTIFY=3Dy case, as
> > security_file_open() in this combination will be a no-op and not call
> > fsnotify_open_perm(). Fix this by calling fsnotify_open_perm() directly=
.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> > PS: I didn't included a Fixes tag. This issue was probably introduced 1=
5
> > years ago in [1]. If we want to back port this to stable, we will need
> > another version for older kernel because of [2].
> >
> > [1] c4ec54b40d33 ("fsnotify: new fsnotify hooks and events types for ac=
cess decisions")
> > [2] 36e28c42187c ("fsnotify: split fsnotify_perm() into two hooks")
> > ---
> >  fs/open.c           | 4 ++++
> >  security/security.c | 9 +--------
> >  2 files changed, 5 insertions(+), 8 deletions(-)

Nice cleanup, but please finish off the coupling of lsm/fsnotify altogether=
.
I would either change the title to "decouple fsnotify from lsm" or
submit an additional patch with that title.

diff --git a/fs/notify/fanotify/Kconfig b/fs/notify/fanotify/Kconfig
index a511f9d8677b..0e36aaf379b7 100644
--- a/fs/notify/fanotify/Kconfig
+++ b/fs/notify/fanotify/Kconfig
@@ -15,7 +15,6 @@ config FANOTIFY
 config FANOTIFY_ACCESS_PERMISSIONS
        bool "fanotify permissions checking"
        depends on FANOTIFY
-       depends on SECURITY
        default n
        help
           Say Y here is you want fanotify listeners to be able to
make permissions
diff --git a/security/security.c b/security/security.c
index 6875eb4a59fc..8d238ffdeb4a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
-#include <linux/fsnotify.h>
 #include <linux/mman.h>
 #include <linux/mount.h>
 #include <linux/personality.h>

>
> This looks fine to me, if we can get an ACK from the VFS folks I can
> merge this into the lsm/stable-6.12 tree and send it to Linus, or the
> VFS folks can do it if they prefer (my ACK is below just in case).

My preference would be to take this via the vfs or fsnotify tree.

>
> As far as stable prior to v6.8 is concerned, once this hits Linus'
> tree you can submit an adjusted backport for the older kernels to the
> stable team.

Please do NOT submit an adjustable backport.
Instead please include the following tags for the decoupling patch:

Depends-on: 36e28c42187c fsnotify: split fsnotify_perm() into two hooks
Depends-on: d9e5d31084b0 fsnotify: optionally pass access range in
file permission hooks

>
> Acked-by: Paul Moore <paul@paul-moore.com>
>

Thanks,
Amir.

