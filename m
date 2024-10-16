Return-Path: <linux-fsdevel+bounces-32109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A909A0AC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC211F26177
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAC3209F4D;
	Wed, 16 Oct 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqXLFeR5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004BE20966C
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083238; cv=none; b=rKwc7Dm0+YsHd8QsBq5+Qobqp1sbO0Qi2jzOhed0NvNLL+9tyJvSJXmlMiUGG95Ndf0rNRRVNgpopTyYJ1FkLYRnleXu7R4riTT8aGoVVLv2tZxfpz3QRr927+0GpMtlurKytvUKsJNda7DQTfnToqX5wxtTkMXW1evSsW7IQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083238; c=relaxed/simple;
	bh=JberB9FQaW9006JRnitxmiG7NJo7GIR48+9qkvupKso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNP4JwwE2Y922Rl71XpWti2B2WPdG4GaoAj2bupLSGWVYa6eqyOR7D6rB3s9+10tGLNl+DeQokEW2jFCTE677X4u5XgidHj8i/D4mYDSsB+PWNfeMKj4UFlJ/kzG7h85wCMvvwHSL0OpVy17gY00ed/q/SrTX8qOZDhHEHZqLEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqXLFeR5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b1474b1377so32334585a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729083236; x=1729688036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DqNVBnBLcYUKGgGsKMIT+a+OqsGOHkFJ2kO1T6sXPQ=;
        b=mqXLFeR5dq/k1PresJmzJa/wkZQtcAVeH5RP1IQH0ydP4hOUMr1fLYPFnrOy2sCeBf
         waWOqsuGonUz504H7YEdbmdQ/HM83HWlJCOrR+AsIJ9sAVAADtjlZhGPRWhDKsk97C7r
         hcLDn9A9VEAO4xRxfBM/XXis7yBtycoP0Sk9sQ4A50nPXxoMluL4A+bfM3mZdl1mL01M
         cKVBx83M3AjzQbAfGfeNV9QJq9oUeUVQCS2UpasiObzykSyA4X/V5Su1IOEUnkNvYMm+
         H5XMGc64oACR6cPGM3pZXYHh3vQLx97imjMl2Jl/YXcq8ovzpXzUYl35Wnz/9YepGFCW
         E/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729083236; x=1729688036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DqNVBnBLcYUKGgGsKMIT+a+OqsGOHkFJ2kO1T6sXPQ=;
        b=tjc0w9TWXQHGAsUFfA5YQK2DfVbHA1PrHSHom7CkjVwELe9TpYB+1CWHb1SpzR0oDw
         rchsQLCe+94tfm/4QNqAgmzzc3eStroEXREXRKMoqVZpbR3au9r5RgP1DaXzTiXQKwOa
         imCKcOUxZzNEtPSLLpiPs7qfDQhoTXCMIilBYwaK/YL0mqRUoyJhA8n3DFHf+aT1UOwr
         XqJei+r8xMaEKoipnRiFGB244qXf7vFPjg05lnOJtImFUwxPxI6lT1TJW25LbjUxFLBS
         u0B2i6dIJ51Awo1JHQXCthIOJUPvu2OYIUMa55kzwaevR6WDTXX2V8wiQZ0Bg90KrBkO
         otIg==
X-Forwarded-Encrypted: i=1; AJvYcCUvIgKFBqhz7fAutcwWuPVajtdLhFtFu2Acm7IyZipp0Zj4SoNc2E58SeSWUlJe0A365RmNg37ab1LEFlB6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59TyV3AoaVswXiVcQOB4OlxG7sEFurVVgmsHTl/9L1qjX6rjK
	rWNYXInhHKlIGKL3ESLeQTNbAGYXvwbRtHzmyJLML2t4pjOFcZ3UtOGJ7hOs+X2KRJt5Lk5NhY9
	5gmyHHHp/FwZ4BJRACmA42OflvD4=
X-Google-Smtp-Source: AGHT+IFlZNZ9b2fTtzrg0utIW/Yfdyw4VrLKpdJC9W9Kdj3aKxjox5fknHaN4kiBhOxyxLB4E93HLY+QuhbI7jo3dUE=
X-Received: by 2002:a05:620a:4509:b0:7b1:1352:66fb with SMTP id
 af79cd13be357-7b11a36b4f0mr2420396985a.29.1729083235793; Wed, 16 Oct 2024
 05:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
 <CAOQ4uxhjQwvJZEcuPyOg02rcDgcLfHQL-zhUGUmTf1VD8cCg4w@mail.gmail.com>
 <CAOQ4uxgjY=upKo7Ry9NxahJHhU8jV193EjsRbK80=yXd5yikYg@mail.gmail.com>
 <20241015-geehrt-kaution-c9b3f1381b6f@brauner> <CAOQ4uxj6ja4PN3=S9WxmZG0pLQOjBS-hNdwmGBzFjJ4GX64WCA@mail.gmail.com>
In-Reply-To: <CAOQ4uxj6ja4PN3=S9WxmZG0pLQOjBS-hNdwmGBzFjJ4GX64WCA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Oct 2024 14:53:44 +0200
Message-ID: <CAOQ4uxiwGTg=FeO6iiLEwtsP9eTudw-rsLD_0u3NtG8rz5chFg@mail.gmail.com>
Subject: Re: fanotify sb/mount watch inside userns (Was: [PATCH RFC] :
 fhandle: relax open_by_handle_at() permission checks)
To: Lennart Poettering <lennart@poettering.net>, Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, containers@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[cc the correct containers list]

On Wed, Oct 16, 2024 at 2:45=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Oct 15, 2024 at 4:01=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Sun, Oct 13, 2024 at 06:34:18PM +0200, Amir Goldstein wrote:
> > > On Fri, May 24, 2024 at 2:35=E2=80=AFPM Amir Goldstein <amir73il@gmai=
l.com> wrote:
> > > >
> > > > On Fri, May 24, 2024 at 1:19=E2=80=AFPM Christian Brauner <brauner@=
kernel.org> wrote:
> > > > >
> > > > > A current limitation of open_by_handle_at() is that it's currentl=
y not possible
> > > > > to use it from within containers at all because we require CAP_DA=
C_READ_SEARCH
> > > > > in the initial namespace. That's unfortunate because there are sc=
enarios where
> > > > > using open_by_handle_at() from within containers.
> > > > >
> > > > > Two examples:
> > > > >
> > > > > (1) cgroupfs allows to encode cgroups to file handles and reopen =
them with
> > > > >     open_by_handle_at().
> > > > > (2) Fanotify allows placing filesystem watches they currently are=
n't usable in
> > > > >     containers because the returned file handles cannot be used.
> > > > >
> > >
> > > Christian,
> > >
> > > Follow up question:
> > > Now that open_by_handle_at(2) is supported from non-root userns,
> > > What about this old patch to allow sb/mount watches from non-root use=
rns?
> > > https://lore.kernel.org/linux-fsdevel/20230416060722.1912831-1-amir73=
il@gmail.com/
> > >
> > > Is it useful for any of your use cases?
> > > Should I push it forward?
> >
> > Dammit, I answered that message already yesterday but somehow it didn't
> > get sent or lost in some other way.
> >
> > I personally don't have a use-case for it but the systemd folks might
> > and it would be best to just rope them in.
>
> Lennart,
>
> I must have asked this question before, but enough time has passed so
> I am going to ask it again.
>
> Now that Christian has added support for open_by_handle_at(2) by non-root
> userns admin, it is a very low hanging fruit to support fanotify sb/mount
> watches inside userns with this simple patch [1], that was last posted in=
 2011.
>
> My question is whether this is useful, because there are still a few
> limitations.
> I will start with what is possible with this patch:
> 1. Watch an entire tmpfs filesystem that was mounted inside userns
> 2. Watch an entire overlayfs filesystem that was mounted [*] inside usern=
s
> 3. Watch an entire mount [**] of any [***] filesystem that was
> idmapped mounted into userns
>
> Now the the fine prints:
> [*] Overlayfs sb/mount CAN be watched, but decoding file handle in
> events to path
>      only works if overlayfs is mounted with mount option
> nfs_export=3Don, which conflicts
>      with mount option metacopy=3Don, which is often used in containers
> (e.g. podman)
> [**] Watching a mount is only possible with the legacy set of fanotify ev=
ents
>      (i.e. open,close,access,modify) so this is less useful for
> directory tree change tracking
> [***] Watching an idmapped mount has the same limitations as watching
> an sb/mount
>      in the root userns, namely, filesystem needs to have a non zero
> fsid (so not FUSE)
>      and filesystem needs to have a uniform fsid (so not btrfs
> subvolume), although
>      with some stretch, I could make watching an idmapped mount of
> btrfs subvol work.
>
> No support for watching btrfs subvol and overlayfs with metacopy=3Don,
> reduces the attractiveness for containers, but perhaps there are still us=
e cases
> where watching an idmapped mount or userns private tmpfs are useful?
>
> To try out this patch inside your favorite container/userns, you can buil=
d
> fsnotifywait with a patch to support watching inside userns [2].
> It's actually only the one lines O_DIRECTORY patch that is needed for the
> basic tmpfs userns mount case.
>
> Jan,
>
> If we do not get any buy-in from potential consumers now, do you think th=
at
> we should go through with the patch and advertise the new supported use c=
ases,
> so that users may come later on?
>
> Thanks,
> Amir.
>
> [1] https://github.com/amir73il/linux/commits/fanotify_userns/
> [2] https://github.com/amir73il/inotify-tools/commits/fanotify_userns/

