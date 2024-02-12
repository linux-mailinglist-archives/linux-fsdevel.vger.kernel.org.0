Return-Path: <linux-fsdevel+bounces-11076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316EF850DB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA179B2168D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 07:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EB37462;
	Mon, 12 Feb 2024 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFx0rDZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336506FBE
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707721392; cv=none; b=aFZzy6NsNAvJJ0qrRZ1YyODpaGqP7FSdKWOYy6vzoyknOu3f1T46GQGOS8KXV3B+v6gxpMg9mgyIS8od+xxAlpXCBJwqXicAayzQOR+LHC6CDZYNaeZdIgHumn6QSG2R14/PbGyZp6T5NtCrTP5jmvE+7jyvzf6o9rIxmOJbnFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707721392; c=relaxed/simple;
	bh=BEpuuOCQcYrpnr5UnSbWZNuUg3I6QpWIvi8z7UfgmEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXKt2dPg2kJhlRwFuB9YqpuO+Wt6+QZkQJgGZPCmAeyRlEoRLMtfHXlKKwdGBqJMirDDfgUxXP80QyVomXdKIVGFRLaDV8YVifzLMMINSKzS3Noo1OKNKG/BuGGnyN0bxewJYGlfxQXVkjCM8Cx9wx2W0GfLW1ros3AchiWeWGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFx0rDZY; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-204f50f305cso2457443fac.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 23:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707721390; x=1708326190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/UdV4xbYVtpr8sZ3i6yaJWlG9BJc6nQKNoESjd6lyc=;
        b=iFx0rDZYg73E9r5yIRQl9nIxSWcMNSsTQMhMgWU/LoFeb0hcyWyYtTUMzT6XZ/rjoK
         aW9janmvU9eXmGIt/z13cEbgpL5IZKdVF+7oiPola1HrpWmzt53JeuFpWL40CFEjsWTx
         OYER9AgG+VgyCjLuT0dtogYaKYfg43iqq/oTOPoyp5T5rMQPQdp0OTbvd7NjtzlfL2EX
         PVFHkLsp/obEkCJntOU9Ay1Hr5mett/BlxWzXZcH8RihVIfR49DQSSZUHOWs64zrI+dm
         Sj5QqV3be/Z12eIN5q/XYsf5hemTXpUTIhMuY4vrnTV/KG1Mn7kXPNzesD9s3/uR9kW5
         0x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707721390; x=1708326190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/UdV4xbYVtpr8sZ3i6yaJWlG9BJc6nQKNoESjd6lyc=;
        b=OS7NPknOGFdDtuQYlnX6pb6CG37BgNTsgoL3C8tTR0mxBVJtQBz9hChfb2AliP4y/J
         pLAXm3XqsfhDfxVXro4NjjYSsem5FOcB/Om6ozXBJLi84K//UnYGNlurh9FCZ1rnx2oY
         EBR/a278QdlxwJcKh/XpaHXA6HDmhNBWdy6IN8TdkfrTs532JP/RQ1yj2uYNlJg1xZNW
         R1h7Xly9DAoaTnhzQ3L6rS0LQEkVVw6Caob636M/NOo/YfFHIyV3U85cdl+lLpTQtfMM
         Vi+aXRRE4rdpRP6QZq7vFGjQJUQDF70O48oRnUCcGGpkqevffa1+eGyg3PE71ctlsLLI
         i7cg==
X-Gm-Message-State: AOJu0YyPW5cWVFuG6EUmIfbn3nl086c4xKzim7W6XwMvKqQK3EBWhAKo
	Zpnsh10bKdwLCk9D8ApZD72kFFvVXTeSfxdT0QWbzgqB6DNC/GqMQROfpROayVphr4/c0fMsVQg
	DEyp86th1mUutjZjJULpxAOonVSQ=
X-Google-Smtp-Source: AGHT+IEie/aofATyA+I4c1Oxl/tZ1Lky5melZ5dL/EtUzinyJmyQL9mdguPdpXEe/YQyB7ZSylsutbFnNvW1shT6FYw=
X-Received: by 2002:a05:6870:c1d0:b0:21a:3288:bc09 with SMTP id
 i16-20020a056870c1d000b0021a3288bc09mr6375565oad.18.1707721390002; Sun, 11
 Feb 2024 23:03:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210100643.2207350-1-amir73il@gmail.com> <20240210232718.GG608142@ZenIV>
 <CAOQ4uxhs9y27Z5VWm=5dA-VL61-YthtNK14_-7URWs3be53QFw@mail.gmail.com> <20240211184438.GH608142@ZenIV>
In-Reply-To: <20240211184438.GH608142@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 12 Feb 2024 09:02:58 +0200
Message-ID: <CAOQ4uxhizxoZWKrcRkpC641evkFBx-oZynm1r1htWBE7hNXc-g@mail.gmail.com>
Subject: Re: [PATCH] dcache: rename d_genocide()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 8:44=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sun, Feb 11, 2024 at 10:00:03AM +0200, Amir Goldstein wrote:
>
> > > whole d_genocide() thing is quite likely to disappear, turning
> > > kill_litter_super() into an alias for kill_anon_super().
> >
> > 2-in-1, getting rid of cruelty in the human and animal kingdom ;)
>
> FWIW, "litter" in the above is in the sense of "trash", not "collection
> of animal offspring from the same birth"...

Well either way, it is not clear by this name when the function should be u=
sed.
The current documentation of when kill_litter_super() should be used is
"use it for fs that set FS_LITTER flag, oh, BTW, there is no FS_LITTER flag=
":

Documentation/filesystems/porting.rst:
---
new file_system_type method - kill_sb(superblock).  If you are converting
an existing filesystem, set it according to ->fs_flags::

        FS_REQUIRES_DEV         -       kill_block_super
        FS_LITTER               -       kill_litter_super
        neither                 -       kill_anon_super

FS_LITTER is gone - just remove it from fs_flags.
---

If you are going to make kill_litter_super() an alias of kill_anon_super()
I suggest going the extra mile and replacing the remaining 30 instances of
kill_litter_super().

If the rules become straight forward for the default ->kill_sb(),
then maybe we should even make ->kill_sb() optional and do:

diff --git a/fs/super.c b/fs/super.c
index d35e85295489..6200cac0e4f8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -458,6 +458,18 @@ static void kill_super_notify(struct super_block *sb)
        super_wake(sb, SB_DEAD);
 }

+static void kill_sb(struct super_block *s)
+{
+       struct file_system_type *fs =3D s->s_type;
+
+       if (fs->kill_sb)
+               fs->kill_sb(s);
+       else if (fs->fs_flags & FS_REQUIRES_DEV)
+               kill_block_super(s);
+       else
+               kill_anon_super(s);
+}
+
 /**
  *     deactivate_locked_super -       drop an active reference to superbl=
ock
  *     @s: superblock to deactivate
@@ -474,7 +486,7 @@ void deactivate_locked_super(struct super_block *s)
        struct file_system_type *fs =3D s->s_type;
        if (atomic_dec_and_test(&s->s_active)) {
                shrinker_free(s->s_shrink);
-               fs->kill_sb(s);
+               kill_sb(s);

                kill_super_notify(s);
 --

Thanks,
Amir.

