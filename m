Return-Path: <linux-fsdevel+bounces-23049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C90926617
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 18:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C8B285860
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B107183086;
	Wed,  3 Jul 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXmJMfix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C521822EC;
	Wed,  3 Jul 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023860; cv=none; b=odvsvwykGpGraeZv6WjagMgBBeaoRyfstlBa29PSWpCF0g2fwe8TbD2ENiy3+uZaS0fiIWPC3Shn14Vwh63fGKLB6Ip3o/QMvwmhJ9pTAT81MbbeL8FsOl1z1KAL4hGb+lx+TCMb0Z870xlRhvrCMupdgpnWvOw9Lw3MJF19Od0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023860; c=relaxed/simple;
	bh=2Hacc46nHYFvYqe1ib5XbS062I+YR3yn+g22MnTZjt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rd3OZtXU5hKqQxkld/Z3SuK8HV6D8E19mmA+v0T7p9CDCidoBHdqM59Nrkz9vaQ852DWRlZnCJFM1mHflMUFT1M9jUk/fQ5SarRDw6Y3HCk0kclFy3M5iRQAHfqr52CM2DzuTnbSLRS2XtjxahVTKagB2j57E+kxKjWqMds51oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXmJMfix; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79c0b1eb94dso380243385a.1;
        Wed, 03 Jul 2024 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720023858; x=1720628658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LssWgT0rAbf2Zvr3wzcyKBmvblvua7M79zlMa0Rclsw=;
        b=RXmJMfixNMUk5lM2QdP0+qV6m+CqR688cnRzOflSlpj4HgvdZCJt3yNAFZphLNVKAg
         baJ78dPgtWafB52wXJwSR0gZRZD65XOlBmlhEQA7tPxW0iJrUEuzX3Lm+HHfLLuM8Cp6
         dLZAl/PW0PmhEenSXQnv87xF0KpfDTxuQurnYhg2nlOhA8oG0CE85a6PIeWKLTgqqvbn
         FNyGkzyaXINozpxi7zzIe+hbSnlIFrffrqVBcBXaVz8ru9UkDZN4Zix4emoH7mLFOO6N
         2F8tY/k0A1hPvlPZ9wD34P5zYf8R5VMDfJtuh1BB3ZBrKf6Mt3YNNWWIQRTYh5DB5NXH
         zCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023858; x=1720628658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LssWgT0rAbf2Zvr3wzcyKBmvblvua7M79zlMa0Rclsw=;
        b=I/+wOzBhOoRLMhn6lAXpWlHJGGwuW//OV5PElt714DGxYHaUYw0rrUqMro0ZjTv09/
         1zusd0BPenY5e/7ARPumVaakZxBd24nrHnTgF8bTjq32SyyYLsQRkvwRgFQpXuGUIjtb
         ifs/NV4lYX9O6ItPTkRpBNv6nQPcTVrDCxUrxHCrMJOuDOQGq9iP+0Q49ZgAlIVK68Cn
         4sGE/3BtraE5jcLkaJMVY8twKQTnmCwqSP9OjiE0VyeBNqZSAUpYLaoQCqmGBT08dWnc
         wlCJJm248mDjMnygTOwAT6E8KPfgfRMkvc6LMfbMoDPO0VrAdCpyi4qg2X3LPBgJPDzi
         Ftyw==
X-Forwarded-Encrypted: i=1; AJvYcCXxP6BicZexsIKZgHPwFfbqGWlB2OSoAtmL4FL1MhGYyddvSegSKFLNyJaUmI7hY1/fnXaf5Sie9YaPn9dLFRCY/P8qZbyKZp4hH5k8YgMfOGWNN+dW+V0ojiE0zNjXGtLYrT3uWMSKBAUJbg==
X-Gm-Message-State: AOJu0Yxz8OI9YOUYfLpbVsmnxMvu84HGrXn1zK4lP/JjeQ3YekAY4r3x
	YzTrHqVt9exA8eeH0F/J5JEl5PpZs2+/wxIbCUPXYJuudLZfnXTRVVBDnMQby31KQyNw8Xf4hEk
	yMqq/v7qkawIDyrBl4Kac/LJu6QM=
X-Google-Smtp-Source: AGHT+IFSvisVJYJa9uTwBqRJ9OsIwK0wr6BGtSTTpy/fAImCTth3S8Np7WJQfC/6zxRKPuXNVd23VUaQ7+Psd8sHNPM=
X-Received: by 2002:a05:620a:a95:b0:79d:986a:9e8e with SMTP id
 af79cd13be357-79d986aa061mr567225585a.67.1720023857744; Wed, 03 Jul 2024
 09:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703010215.2013266-1-drosen@google.com> <315aef06-794d-478f-93a3-8a2da14ec18c@fastmail.fm>
 <CAOQ4uxhYcNvQc-Y+ZZSGyX1Un8WCJuE-aeiRrgLm91HwJ48gWA@mail.gmail.com> <d98fefc9-fbb4-44b8-9050-61378176dcf1@fastmail.fm>
In-Reply-To: <d98fefc9-fbb4-44b8-9050-61378176dcf1@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 3 Jul 2024 19:24:06 +0300
Message-ID: <CAOQ4uxjHe6m1LUxTzrmOSFnbF=yZRuL0180V0gFH8qJTfcsNeQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Fuse Passthrough cache issues
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Daniel Rosenberg <drosen@google.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 7:09=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 7/3/24 16:41, Amir Goldstein wrote:
> > On Wed, Jul 3, 2024 at 4:27=E2=80=AFPM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >>
> >>
> >> On 7/3/24 03:02, Daniel Rosenberg wrote:
> >>> I've been attempting to recreate Android's usage of Fuse Passthrough =
with the
> >>> version now merged in the kernel, and I've run into a couple issues. =
The first
> >>> one was pretty straightforward, and I've included a patch, although I=
'm not
> >>> convinced that it should be conditional, and it may need to do more t=
o ensure
> >>> that the cache is up to date.
> >>>
> >>> If your fuse daemon is running with writeback cache enabled, writes w=
ith
> >>> passthrough files will cause problems. Fuse will invalidate attribute=
s on
> >>> write, but because it's in writeback cache mode, it will ignore the r=
equested
> >>> attributes when the daemon provides them. The kernel is the source of=
 truth in
> >>> this case, and should update the cached values during the passthrough=
 write.
> >>
> >> Could you explain why you want to have the combination passthrough and
> >> writeback cache?
> >>
> >> I think Amirs intention was to have passthrough and cache writes
> >> conflicting, see fuse_file_passthrough_open() and
> >> fuse_file_cached_io_open().
> >
> > Yes, this was an explicit design requirement from Miklos [1].
> > I also have use cases to handle some read/writes from server
> > and the compromise was that for the first version these cases should
> > use FOPEN_DIRECT_IO, which does not conflict with FOPEN_PASSTHROUGH.
> >
> > I guess this is not good enough for Android applications opening photos
> > that need the FUSE readahead cache for performance?
> >
> > In that case, a future BPF filter can decide whether to send the IO dir=
ect
> > to server or to backing inode.
> >
> > Or a future backing inode mapping API could map part of the file to
> > backing inode
> > and the metadata portion will not be mapped to backing inode will fall =
back to
> > direct IO to server.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/CAJfpegtWdGVm9iHgVyXfY2mnR98X=
J=3D6HtpaA+W83vvQea5PycQ@mail.gmail.com/
> >
> >>
> >> Also in <libfuse>/example/passthrough_hp.cc in sfs_init():
> >>
> >>     /* Passthrough and writeback cache are conflicting modes */
> >>
> >>
> >>
> >> With that I wonder if either fc->writeback_cache should be ignored whe=
n
> >> a file is opened in passthrough mode, or if fuse_file_io_open() should
> >> ignore FOPEN_PASSTHROUGH when fc->writeback_cache is set. Either of bo=
th
> >> would result in the opposite of what you are trying to achieve - which
> >> is why I think it is important to understand what is your actual goal.
> >>
> >
> > Is there no standard way for FUSE client to tell the server that the
> > INIT response is invalid?
>
> Problem is that at FUSE_INIT time it is already mounted. process_init_rep=
ly()
> can set an error state, but fuse_get_req*() will just result in ECONNREFU=
SED.*
>
> >
> > Anyway, we already ignore  FUSE_PASSTHROUGH in INIT response
> > for several cases, so this could be another case.
> > Then FOPEN_PASSTHROUGH will fail with EIO (not be ignored).
>
> So basically this?
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 573550e7bbe1..36c6dcd47a53 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1327,7 +1327,8 @@ static void process_init_reply(struct fuse_mount *f=
m, struct fuse_args *args,
>                         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) &&
>                             (flags & FUSE_PASSTHROUGH) &&
>                             arg->max_stack_depth > 0 &&
> -                           arg->max_stack_depth <=3D FILESYSTEM_MAX_STAC=
K_DEPTH) {
> +                           arg->max_stack_depth <=3D FILESYSTEM_MAX_STAC=
K_DEPTH &&
> +                           !(flags & FUSE_WRITEBACK_CACHE)) {
>                                 fc->passthrough =3D 1;
>                                 fc->max_stack_depth =3D arg->max_stack_de=
pth;
>                                 fm->sb->s_stack_depth =3D arg->max_stack_=
depth;
>
>

Yap.
Maybe add something to the comment, because the comment is
about max_stack_depth and someone may assume that it also refers
to FUSE_WRITEBACK_CACHE somehow.

Thanks,
Amir.

