Return-Path: <linux-fsdevel+bounces-46668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13662A93693
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 13:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F023B52DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 11:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E48219A68;
	Fri, 18 Apr 2025 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJwJDmPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA51A76D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744975983; cv=none; b=D24UZWbloQrDTsk63jsPz1aGrA5AdUyyYTT7hlM1eo0S4uM++L/5zco4+zVo5ALY7ssPVzxnfVzSwHeqF99LxI1Og2vPua8yDZqqnJ5kdEX+j+1WkTz3g6gdVkmzCYmYpo1UAelJyeYSJn0m1xo58GF/MUyvYHV5/yTkKwj48Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744975983; c=relaxed/simple;
	bh=WTnrGeFXBjCnzzuEOgvpCFp4CW/g62/iDIbbbUxuCR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUp+7YzwOZpTFOWzej8vqazOMAk3C529cuP2bBgS0gRJElZXZefMe0/EUnzabD+Cc6Qd6QesLrPzanoK3eZTU6MBA5z2XPaB1lKqIuJPRHYZuYXvsxCRsmWDJdlQZMa1lfsCu2pE86cMSAuPEdaVkR7ahil6WCvpADQBVvwYLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJwJDmPP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f435c9f2f9so2736747a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744975979; x=1745580779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27X7S16DYjT/LW2Ezo/SSGnQFg4j0BttjbVMhMujxUI=;
        b=TJwJDmPPenbwZicWsDqoyBIVKVXy8oKTBnzclBvp7TM670ewBeNf7sRhGRyN+e2Jxn
         QiJKzbfAwDniYmq90PH4xGtn07qNUzxJTTlQPiIDAA2wVsSaReVm7VF7XryzvxsP77B9
         AELB75lKC2c0aZISkn/z0YbOqjmjjjvU3WaQn1PsyrNDU+pM/Dq/bLcJXCKM4iwrcPQs
         Sc+U2a4oxgM/CBDaaE1V24rbGWWKeSPUnhU6Ehq8HVgoyRAPCe8QkE7dR0//1F4B3tDt
         vmjGEDRGfAhOMvFEtlSAAkS/eaO+6jjyzrWXuFnswWuUjUtnB8GcgfbufYNvPI5jun0P
         CuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744975979; x=1745580779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27X7S16DYjT/LW2Ezo/SSGnQFg4j0BttjbVMhMujxUI=;
        b=XsGFWJnpXtYu0teuC3sfehIdDRkNFgJQLYut6kFhyaGKCL9wNOgWY1u390zo6zqa71
         RLAJmtvgZLhHDWPEegGaajA0TMTP6K+Q3uD75wvYjktt4JYWDZrBO1ipUn8tamVYBlM6
         auD8nHk8eRdj1bmGm25kuzGvJ7TmKohhng9FrxpRFHxLS09sgC1RLrsYNuJd/Mb5jh+x
         c9iiJ+EbBwhXgJVHE5kFyj83qvKBCJi1qQi2p+bfvhVhGcDIfpxFohmR87rQ6b6RHbLe
         VV3Fs6rV7IRJNfx7amBUUqFztCxT2vL2cN8HCj6XEnXAp5zddjU64ijwq9qCitriHBBD
         aXKA==
X-Forwarded-Encrypted: i=1; AJvYcCWXSkbqasLbfop3fvxM2uIavCVWc9iE/aVwS5PQaj3u6P/M9cNRGZGo0T82QBofTexLdPPtA1VscIhKZRMk@vger.kernel.org
X-Gm-Message-State: AOJu0YzWC/9Bg6QLrunIoVXd6t7q8uBPExKb6u7+gQ6N2bUKtIEGektl
	+mw3/Jv5yepzwDgelopDbjUM0xovdPc6rD603E6BnvNtMOEdMvRftlSVG/AInxcaljDXBecyxTl
	1vVfShK1ww8HwCHLwNpc2quEG3O4=
X-Gm-Gg: ASbGncv6OPbwF88+xLORHFQR/tysTG2QuJv0j7S40ZXPTYrLiF/teMzpws7Tyew5kKm
	sj9hqb7CeSiRuAnQpGhsWzjYC+8dGdvrjfM3a0Kr5ivnwzVX91bqkIf6T2k3nEIeM89hmsJ9Nmh
	NPjtLo+SZcqXTyFU50McClQQ==
X-Google-Smtp-Source: AGHT+IEgwzx2e+QsgQJxBA2Ct7E+PXkO+TM2webM4UiPcmvhRotO0DA2Hd8OHEOP6jOOW1+lwrn40MJ3mLqEi4Xdiqg=
X-Received: by 2002:a17:907:9622:b0:aca:df11:c53c with SMTP id
 a640c23a62f3a-acb74dbb5admr210684566b.43.1744975979257; Fri, 18 Apr 2025
 04:32:59 -0700 (PDT)
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
 <CAOQ4uxiwGTg=FeO6iiLEwtsP9eTudw-rsLD_0u3NtG8rz5chFg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiwGTg=FeO6iiLEwtsP9eTudw-rsLD_0u3NtG8rz5chFg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 18 Apr 2025 13:32:48 +0200
X-Gm-Features: ATxdqUGV8yWLv2kq_q7MXkpjUzh-Q3ZHWEcnWjLSHuE2R97cZyLSX9a3qYb89Xg
Message-ID: <CAOQ4uxgwfQNM=cRBJ0BJ-UtZ1R=v3uuFrOfLxWCr5c0WA_Nh3w@mail.gmail.com>
Subject: Re: fanotify sb/mount watch inside userns (Was: [PATCH RFC] :
 fhandle: relax open_by_handle_at() permission checks)
To: Lennart Poettering <lennart@poettering.net>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	containers@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 2:53=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
...
> > > > Christian,
> > > >
> > > > Follow up question:
> > > > Now that open_by_handle_at(2) is supported from non-root userns,
> > > > What about this old patch [1] to allow sb/mount watches from non-ro=
ot userns?
> > > >
> > > >
...
> >
> > My question is whether this is useful, because there are still a few
> > limitations.
> > I will start with what is possible with this patch:
> > 1. Watch an entire tmpfs filesystem that was mounted inside userns
> > 2. Watch an entire overlayfs filesystem that was mounted [*] inside use=
rns
> > 3. Watch an entire mount [**] of any [***] filesystem that was
> > idmapped mounted into userns
> >
> > Now the the fine prints:
> > [*] Overlayfs sb/mount CAN be watched, but decoding file handle in
> > events to path
> >      only works if overlayfs is mounted with mount option
> > nfs_export=3Don, which conflicts
> >      with mount option metacopy=3Don, which is often used in containers
> > (e.g. podman)
> > [**] Watching a mount is only possible with the legacy set of fanotify =
events
> >      (i.e. open,close,access,modify) so this is less useful for
> > directory tree change tracking
> > [***] Watching an idmapped mount has the same limitations as watching
> > an sb/mount
> >      in the root userns, namely, filesystem needs to have a non zero
> > fsid (so not FUSE)
> >      and filesystem needs to have a uniform fsid (so not btrfs
> > subvolume), although
> >      with some stretch, I could make watching an idmapped mount of
> > btrfs subvol work.
> >
> > No support for watching btrfs subvol and overlayfs with metacopy=3Don,
> > reduces the attractiveness for containers, but perhaps there are still =
use cases
> > where watching an idmapped mount or userns private tmpfs are useful?
> >
> > To try out this patch inside your favorite container/userns, you can bu=
ild
> > fsnotifywait with a patch to support watching inside userns [2].
> > It's actually only the one lines O_DIRECTORY patch that is needed for t=
he
> > basic tmpfs userns mount case.
> >
> > Jan,
> >
> > If we do not get any buy-in from potential consumers now, do you think =
that
> > we should go through with the patch and advertise the new supported use=
 cases,
> > so that users may come later on?
> >

Hi guys,

The fine print section in the above "is it useful" question is quite comple=
x.
Maybe that explains why I got no response ;)

I can now ask another flavor of the question:

Is it useful to allow FAN_MARK_MNTNS watches from non-root userns?

Just to make sure that I get it right, the unique mntid that is reported wi=
th
mount attach/detach events is not namespaced right?

Anyway, this functionality has become a priority for me, so I will
work on adapting the old patch [3] to mntns marks and post v2.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_userns/
[2] https://github.com/amir73il/inotify-tools/commits/fanotify_userns/
[3] https://lore.kernel.org/linux-fsdevel/20230416060722.1912831-1-amir73il=
@gmail.com/

