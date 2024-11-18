Return-Path: <linux-fsdevel+bounces-35108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB059D13C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 15:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3409B251D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64601A9B3F;
	Mon, 18 Nov 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOrY1pnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A81991A5;
	Mon, 18 Nov 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941510; cv=none; b=nuybXdPUH41LCphyugiF0B5jVgGisogA/JfotTGqfuOLgDlBOvNWNBdNIdyhP27OywXiMuMntuQMaAIyhI0UfKL7NmVMQY3rDfSf/tTAoG7XFG8giXC53ebRyHCVK/EAt4xVYD1dEzw01cFVuKKJe3njAl6BGJXVWqOdf7L8x4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941510; c=relaxed/simple;
	bh=wNnqMd6SoS8kS5UvIG4kuoxk28enFJPa0N656u0caPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uw0mKnA/Hktf6l9rI9iDdDcVOMfWuGzL2Bo1MaixeZ3DArWU5iYcfYK6cgmgn2uXdKt+i6iHXeqWNLAK8fTKWDL0irMlie8+CMVZNYjjr3gXN38JsAu9irZMwXxjGvUFoVToS7eXhW2vhzwnyTu1fh1+5q/gfs7xh7V6ait3VBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOrY1pnh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfaeed515bso2504820a12.1;
        Mon, 18 Nov 2024 06:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731941507; x=1732546307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0do7/GS0AB0mKftTyCdKEcg/MUUcVldvwUhJTa2fBws=;
        b=IOrY1pnhpyv5kI7iCzvxHwB+pBi5z5NZdTnt8IYT1zXqQDqduCtMyqwL87y5fEJHYf
         gKDsKzHhzSlGYTD2YQgKbtEdAHH6yxVPUUdiqB73zjy52hmS9ZHR76MxG6cxnDxwIyY7
         6hcq/1CMObQGIiVidtNzF3UKF1RstPTqgUfs9j2SdpPJiXllIiqu5ZgCvVOZ36Dqd7O/
         iII2mh/Aykk9n0tWvPHif6YxLKImP4G36ApqMkaxiFHGMjOnn6pBmDrglWEddt1JDrOE
         9j9JzwFiJT5gbz8VJcOCnP5fqyv1CL9rAOYtNTUzHBc0C/BWiY7aOWMjkDOm2EZ2mosi
         D/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941507; x=1732546307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0do7/GS0AB0mKftTyCdKEcg/MUUcVldvwUhJTa2fBws=;
        b=R/zD5rsGb5Iz+a2Y/XPnpXHwWEd6yyLauBzmxHN9uYrn6Snk62Xn7MGEG5JDXlyojv
         5+ijgtFLyvhA6hDcr31nFVV2XLvEkrB803uYOTMDVFUq5XbRVY/gzxSenP2Vd+KOx/3u
         kMTtHDyCs/m638Ok2cCgm1UetYcnklJpXIFrZ+lKN7HoM9XDMRPajIDPLHbTKgiFPFc6
         oGKVmroNjy6Bgs6NRvEPCq5z/qmgXHPa4ZYK7/jaB0EPKpu2/s9TJKM/bBXGOmWSBgRE
         V39sU5N+GYtWZm5Nz2tLuII2TjryrVZ0nNUhlRuFqMjG3RY+RvYt3LelEsrPwC2RNKHS
         soZA==
X-Forwarded-Encrypted: i=1; AJvYcCUWbH49axMfRZX/VhjxI04Z2ihUDVU80GApnD/16uyVR52thXNP3gbPR3sa/lSg7ZVe4fWN4awuf5vFg+Up@vger.kernel.org, AJvYcCXOGu5bYSIkdAqtmvKNNq57aRio93C5pnOAKFJxnq6gBtLSjn/4CWiWlsXVtZHQzqUH/h6eyhFnjT7Q93oT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Yk1YXCr4pq0+KYAjMXh2lVTjoebP6PkSI9zC31LmaAprXqzJ
	PZu0x6l8hPruKU2pPtagztnWDB7spZy9yNILMrvpsPGFRLEz9C0xhoFGTJHV6oZ+nVW7+ZsvmbB
	DNYt8gB5CAwBQu7isNumlu3XkZr8=
X-Google-Smtp-Source: AGHT+IHLFYUxP05dz64LY6QAUl7LyO9eUZ592GiYqBde0c0f2ekwEP3VpAzjjdmXIf6oeuQVIgujffpUCRbFzco8/xU=
X-Received: by 2002:a05:6402:5189:b0:5cf:cf81:c39f with SMTP id
 4fb4d7f45d1cf-5cfcf81c701mr2133768a12.19.1731941506742; Mon, 18 Nov 2024
 06:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118085357.494178-1-mjguzik@gmail.com> <20241118115359.mzzx3avongvfqaha@quack3>
 <CAGudoHHezVS1Z00N1EvC-QC5Z_R7pAbJw+B0Z1rijEN_OdFO1g@mail.gmail.com> <20241118144104.wjoxtdumjr4xaxcv@quack3>
In-Reply-To: <20241118144104.wjoxtdumjr4xaxcv@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 18 Nov 2024 15:51:34 +0100
Message-ID: <CAGudoHECQkQQrcHuWkP2badRP6eXequEiBD2=VTcMfd_Tfj+rA@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: dodge strlen() in vfs_readlink() when ->i_link
 is populated
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 3:41=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 18-11-24 13:20:09, Mateusz Guzik wrote:
> > On Mon, Nov 18, 2024 at 12:53=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 18-11-24 09:53:57, Mateusz Guzik wrote:
> > > > This gives me about 1.5% speed up when issuing readlink on /initrd.=
img
> > > > on ext4.
> > > >
> > > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > > ---
> ...
> > > > I would leave something of that sort in if it was not defeating the
> > > > point of the change.
> > > >
> > > > However, I'm a little worried some crap fs *does not* fill this in
> > > > despite populating i_link.
> > > >
> > > > Perhaps it would make sense to keep the above with the patch hangin=
g out
> > > > in next and remove later?
> > > >
> > > > Anyhow, worst case, should it turn out i_size does not work there a=
re at
> > > > least two 4-byte holes which can be used to store the length (and
> > > > chances are some existing field can be converted into a union inste=
ad).
> > >
> > > I'm not sure I completely follow your proposal here...
> > >
> >
> > I am saying if the size has to be explicitly stored specifically for
> > symlinks, 2 options are:
> > - fill up one of the holes
> > - find a field which is never looked at for symlink inodes and convert
> > into a union
> >
> > I'm going to look into it.
>
> I guess there's limited enthusiasm for complexity to achieve 1.5% improve=
ment
> in readlink which is not *that* common. But I haven't seen the patch and
> other guys may have different opinions :) So we'll see.
>

I'm thinking an i_opflag "this inode has a cached symlink with size
stored in i_linklen", so I don't think there is much in way of
complexity here. Then interested filesystems could call a helper like
so:

diff --git a/mm/shmem.c b/mm/shmem.c
index 3d17753afd94..9dedf432ae13 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3870,6 +3870,7 @@ static int shmem_symlink(struct mnt_idmap
*idmap, struct inode *dir,
        int len;
        struct inode *inode;
        struct folio *folio;
+       const char *link;

        len =3D strlen(symname) + 1;
        if (len > PAGE_SIZE)
@@ -3891,12 +3892,13 @@ static int shmem_symlink(struct mnt_idmap
*idmap, struct inode *dir,

        inode->i_size =3D len-1;
        if (len <=3D SHORT_SYMLINK_LEN) {
-               inode->i_link =3D kmemdup(symname, len, GFP_KERNEL);
-               if (!inode->i_link) {
+               link=3D kmemdup(symname, len, GFP_KERNEL);
+               if (!link) {
                        error =3D -ENOMEM;
                        goto out_remove_offset;
                }
                inode->i_op =3D &shmem_short_symlink_operations;
+               inode_set_cached_link(link, len);
        } else {
                inode_nohighmem(inode);
                inode->i_mapping->a_ops =3D &shmem_aops;


This is only 1.5% because of other weird slowdowns which don't need to
be there, notably putname using atomics. If the other crap was already
fixed it would be closer to 5%.

Here comes a funny note that readlink is used to implement realpath
and vast majority of calls are for directories(!), for which the patch
is a nop.

However, actual readlinks on symlinks do happen every time you run gcc
for example:
readlink("/usr/bin/cc", "/etc/alternatives/cc", 1023) =3D 20
readlink("/etc/alternatives/cc", "/usr/bin/gcc", 1023) =3D 12
readlink("/usr/bin/gcc", "gcc-12", 1023) =3D 6
readlink("/usr/bin/gcc-12", "x86_64-linux-gnu-gcc-12", 1023) =3D 23
readlink("/usr/bin/cc", "/etc/alternatives/cc", 1023) =3D 20
readlink("/etc/alternatives/cc", "/usr/bin/gcc", 1023) =3D 12
readlink("/usr/bin/gcc", "gcc-12", 1023) =3D 6
readlink("/usr/bin/gcc-12", "x86_64-linux-gnu-gcc-12", 1023) =3D 23

that said, no, this is not earth shattering by any means but I don't
see any reason to *object* to it
--=20
Mateusz Guzik <mjguzik gmail.com>

