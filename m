Return-Path: <linux-fsdevel+bounces-72326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E65DCEF0C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 18:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBF193002165
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7804E2D1F7E;
	Fri,  2 Jan 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzKNplhb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394B2BCF7F
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jan 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767374330; cv=none; b=VHoLIUP1LZH/oVVWBV/gvqBLwNvxZxI+vsNQwbPOmHmzPkl6aVYgQ3LkIHIsbA6uQMzmUK3Efd2QsPzdNYFx4W5mCsxSFfcnpMk1BY1v8WCi3qNdIM0Ho5vvxuG2RTSfj+unsUzAQmNsBvzLuVZPTdwor1vnduyUxEFwdY27+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767374330; c=relaxed/simple;
	bh=Hhrqpi3gFItMGZ61bWYM+zhsdR62JryNVUMEl+l2OTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCBs5yVFhHx+fxaao4nF7eq8UX7PkjKmJyjDdu1B38BNrnVhDa4KlGVbMG4iyFpoGYG63RCJ+gtZ4wbkaGTLR0hR+MsQrcTbqrTL8uj0iajw5doGLU1s34nBj/uTzuhEF8bZHIHLMNj+38WDC00sj6r4Bj9u2VQviM8JmZ0MAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzKNplhb; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c0f13e4424so1076669185a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jan 2026 09:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767374328; x=1767979128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5CeSnQoJUKOg0cPAS0jVbDvnQ4Eswm7h/Mu03yuAzA=;
        b=JzKNplhbCFHpoSIgeBlqXYDQOAaaqVdt0IDuU7ynWNRjk10sT8+2Muj4azeKhhRIEz
         3XYzwcyO6Dm/akWNhPArfw3rjUj5L/2Vzf8PI7mZic/JgquET/1BcBsKDBg4uY2N1ade
         yqaCGnZEAoWXipGr1XeNRg4yrRQMgtZjNK7ah8R+BixXUHZN7LOj0+3lAI6/MxCz8kU9
         Vgaa4nklgZmabs1ehUox/LApzNop09Yv4N03CdYmpuecOT8olrRJr6cZAuKtJ7c2yXaM
         L96a8n3Mpe8mON4oYWhYbpTxuSXr9dy1OhrPGxAFX6R8K9pZjDzE8JI46G5gqCxm4COw
         Lw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767374328; x=1767979128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t5CeSnQoJUKOg0cPAS0jVbDvnQ4Eswm7h/Mu03yuAzA=;
        b=VXRXIappP0TAOU9laX9HzY8FVGZBVFtfmy5oF2AnUgya4ZuyrsqndpR7yevQIwN9v+
         R2BgCXkGVLXr2lJSzqBrs4WZbmDK4T1cNesFX+bdYW9cHtJA8Y8yplu3RtdGhMNb9JqM
         xpxJGLFUeverryNj23IAtEvbQ0rV5Nlev7doLRBynY04XETH7CHuTQR0IVK1AdjSXDPg
         agU7dwlaAeLlbKz8oAqYFxfWYjsDattHnqFInMuv3lzNOe2w99E7D+NeMC8xL3iGY53L
         fk4JlCAlxaIKcSx6brNmSvvDNmk0MCSjn4QUIht5NhX8Wue/3HkPAb+UVVSVjiktvMXy
         zDWA==
X-Forwarded-Encrypted: i=1; AJvYcCXp5iYHYxIYoMW/vY2Otz/HlaNKbZQAxSE7wYbyRHqJNYNPmur1CpyyVL+4H565KDlRvvQBjYR25597B0E8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh/sfPRmbiO1nAYzA9ssSR3LWuRals2L/PBRKIqvbdLSB7Zfsc
	KfVDozgi+Q+Eka5ytMYZfoMSrvMeh9h/hQ4cjSADlCLQeWzYres9KYDJ0bSG8MoIn+iDNkxzgxP
	AvDFvAaB8k5SnWY/Pz3mkbpzP9GrlTWFVBJC5mwM=
X-Gm-Gg: AY/fxX6GwW+paPY4tANJk/8L4Rf2jr8zdgXz1OeBM50T4yQVOndJtLh0LKdg1lm/5PB
	MUQ0JRMigXh1Mw4Xr8QALmPamtYQ7fepTVGnwkzew3VOADIwtG75285sxpY4q8fPJk+sfVsUOxr
	gPJfgioUcygRSMV0miITte4xtQBS+kA5KYWxNMxuN9kQoyELolzPAdAJn4PFJV4NGLebDc5ALJB
	+eFFqz+FXz93Amwgb5QTiP1MBSvYoWDpzwzAoxbvWFvoANa+Vk+9PbuY4pg6FLZFdzz2g==
X-Google-Smtp-Source: AGHT+IGMNKC0zMwgi+n3r94F+4qlxnvROc9P10qwHAgdsaVeWwI1aQnzyAhr56SmTApa8nE4HP/gzTOnG7k2WJzNATo=
X-Received: by 2002:a05:622a:1c09:b0:4ee:1f5b:73bc with SMTP id
 d75a77b69052e-4f4abda9e33mr603046741cf.66.1767374327723; Fri, 02 Jan 2026
 09:18:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQrcFyO7tlFF0TyD@lorien.valinor.li> <aSl-iAefeJJfjPJB@probook>
 <aSoBsX5MZXYCq2qZ@eldamar.lan> <176227232774.2636.13973205036417925311.reportbug@probook>
 <aSxCcapas1biHwBk@probook> <aT7JRqhUvZvfUQlV@eldamar.lan> <CAJnrk1Ygu_erR0W2wTOdYzVhm2ZowWDdULQbXpp2AZR1Y=jkJA@mail.gmail.com>
 <aVe_SgcXz5CKa92B@eldamar.lan>
In-Reply-To: <aVe_SgcXz5CKa92B@eldamar.lan>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 2 Jan 2026 09:18:36 -0800
X-Gm-Features: AQt7F2puOVoKSTs-Uo0vmr5-U_ubTmjtZg4tW4a0m9waCowhp5pR4_Ys3EmNrWA
Message-ID: <CAJnrk1b4wxJXgAzNs9xsrMkDmRqhNBO1PDWeRwd5+ObOOhQZRQ@mail.gmail.com>
Subject: Re: [regression] 0c58a97f919c ("fuse: remove tmp folio for writebacks
 and internal rb tree") results in suspend-to-RAM hang on AMD Ryzen 5 5625U on
 test scenario involving podman containers, x2go and openjdk workload
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>, 
	1120058@bugs.debian.org, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 6:21=E2=80=AFAM Salvatore Bonaccorso <carnil@debian.=
org> wrote:
>
> Hi Joanne,
>
> On Mon, Dec 15, 2025 at 06:37:42AM +0800, Joanne Koong wrote:
> > On Sun, Dec 14, 2025 at 10:27=E2=80=AFPM Salvatore Bonaccorso <carnil@d=
ebian.org> wrote:
> > >
> > > Hi Joanne,
> > >
> > > In Debian J. Neusch=C3=A4fer reported an issue where after 0c58a97f91=
9c
> > > ("fuse: remove tmp folio for writebacks and internal rb tree") a
> > > specific, but admittely not very minimal workload, involving podman
> > > contains, x2goserver and a openjdk application restults in
> > > suspend-to-ram hang.
> > >
> > > The report is at https://bugs.debian.org/1120058 and information on
> > > bisection and the test setup follows:
> > >
> > > On Sun, Nov 30, 2025 at 02:11:13PM +0100, J. Neusch=C3=A4fer wrote:
> > > > On Fri, Nov 28, 2025 at 09:10:25PM +0100, Salvatore Bonaccorso wrot=
e:
> > > > > Control: found -1 6.17.8-1
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Fri, Nov 28, 2025 at 11:50:48AM +0100, J. Neusch=C3=A4fer wrot=
e:
> > > > > > On Wed, Nov 05, 2025 at 06:09:43AM +0100, Salvatore Bonaccorso =
wrote:
> > > > [...]
> > > > > > I can reproduce the bug fairly reliably on 6.16/17 by running a=
 specific
> > > > > > podman container plus x2go (not entirely sure which parts of th=
is is
> > > > > > necessary).
> > > > >
> > > > > Okay if you have a very reliable way to reproduce it, would you b=
e
> > > > > open to make "your hands bit dirty" and do some bisecting on the
> > > > > issue?
> > > >
> > > > Thank you for your detailed instructions! I've already started and =
completed
> > > > the git bisect run in the meantime. I had to restart a few times du=
e to
> > > > mistakes, but I was able to identify the following upstream commit =
as the
> > > > commit that introduced the issue:
> > > >
> > > > https://git.kernel.org/linus/0c58a97f919c24fe4245015f4375a39ff05665=
b6
> > > >
> > > >     fuse: remove tmp folio for writebacks and internal rb tree
> > > >
> > > > The relevant commit history is as follows:
> > > >
> > > >   *   2619a6d413f4c3 Merge tag 'fuse-update-6.16' of git://git.kern=
el.org/pub/scm/linux/kernel/git/mszeredi/fuse  <-- bad
> > > >   |\
> > > >   | * dabb9039102879 fuse: increase readdir buffer size
> > > >   | * 467e245d47e666 readdir: supply dir_context.count as readdir b=
uffer size hint
> > > >   | * c31f91c6af96a5 fuse: don't allow signals to interrupt getdent=
s copying
> > > >   | * f3cb8bd908c72e fuse: support large folios for writeback
> > > >   | * 906354c87f4917 fuse: support large folios for readahead
> > > >   | * ff7c3ee4842d87 fuse: support large folios for queued writes
> > > >   | * c91440c89fbd9d fuse: support large folios for stores
> > > >   | * cacc0645bcad3e fuse: support large folios for symlinks
> > > >   | * 351a24eb48209b fuse: support large folios for folio reads
> > > >   | * d60a6015e1a284 fuse: support large folios for writethrough wr=
ites
> > > >   | * 63c69ad3d18a80 fuse: refactor fuse_fill_write_pages()
> > > >   | * 3568a956932621 fuse: support large folios for retrieves
> > > >   | * 394244b24fdd09 fuse: support copying large folios
> > > >   | * f09222980d7751 fs: fuse: add dev id to /dev/fuse fdinfo
> > > >   | * 18ee43c398af0b docs: filesystems: add fuse-passthrough.rst
> > > >   | * 767c4b82715ad3 MAINTAINERS: update filter of FUSE documentati=
on
> > > >   | * 69efbff69f89c9 fuse: fix race between concurrent setattrs fro=
m multiple nodes
> > > >   | * 0c58a97f919c24 fuse: remove tmp folio for writebacks and inte=
rnal rb tree              <-- first bad commit
> > > >   | * 0c4f8ed498cea1 mm: skip folio reclaim in legacy memcg context=
s for deadlockable mappings
> > > >   | * 4fea593e625cd5 fuse: optimize over-io-uring request expiratio=
n check
> > > >   | * 03a3617f92c2a7 fuse: use boolean bit-fields in struct fuse_co=
py_state
> > > >   | * a5c4983bb90759 fuse: Convert 'write' to a bit-field in struct=
 fuse_copy_state
> > > >   | * 2396356a945bb0 fuse: add more control over cache invalidation=
 behaviour
> > > >   | * faa794dd2e17e7 fuse: Move prefaulting out of hot write path
> > > >   | * 0486b1832dc386 fuse: change 'unsigned' to 'unsigned int'
> > > >   *   0fb34422b5c223 Merge tag 'vfs-6.16-rc1.netfs' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/vfs/vfs   <-- good
> > > >
> > > > The first and last commits shown are merge commits done by Linus To=
rvalds. The
> > > > fuse-update branch was based on v6.15-rc1, under which I can't run =
my test due
> > > > to an unrelated bug, so I ended up merging in 0fb34422b5c223 to tes=
t the
> > > > commits within the fuse-update branch. e.g.:
> > > >
> > > >   git reset --hard 394244b24fdd09 && git merge 0fb34422b5c223 && ma=
ke clean && make
> > > >
> > > >
> > > > I have also verified that the issue still happens on v6.18-rc7 but =
I wasn't
> > > > able to revert 0c58a97f919 on top of this release, because a trivia=
l revert
> > > > is not possible.
> > > >
> > > > My test case consists of a few parts:
> > > >
> > > >  - A podman container based on the "debian:13" image (which points =
to
> > > >    docker.io/library/debian via /etc/containers/registries.conf.d/s=
hortnames.conf),
> > > >    where I installed x2goserver and a openjdk-21-based application;=
 It runs the
> > > >    OpenSSH server and port 22 is exposed as localhost:2001
> > > >  - x2goclient to start a desktop session in the container
> > > >
> > > > Source code: https://codeberg.org/neuschaefer/re-workspace
> > > >
> > > > I suspect, but haven't verified, that the X server in the container=
 somehow
> > > > uses the FUSE-emulated filesystem in the container to create a file=
 that is
> > > > used with mmap (perhaps to create shared pages as frame buffers).
> > > >
> > > >
> > > > Raw bisect notes:
> > > >
> > > > good:
> > > > - v6.12.48+deb13-amd64
> > > > - v6.12.59
> > > > - v6.12
> > > > - v6.14
> > > > - v6.15-1304-g14418ddcc2c205
> > > > - v6.15-10380-gec71f661a572
> > > > - v6.15-10888-gb509c16e1d7cba
> > > > - v6.15-rc7-357-g8e86e73626527e
> > > > - v6.15-10933-g4c3b7df7844340
> > > > - v6.15-10954-gd00a83477e7a8f
> > > > - v6.15-rc7-366-g438e22801b1958 (CONFIG_X86_5LEVEL=3Dy)
> > > > - v6.15-rc4-126-g07212d16adc7a0
> > > > - v6.15-10958-gdf7b9b4f6bfeb1    <-- first parent, 5LEVEL doesn't e=
xist
> > > > - v6.15-rc4-00127-g4d62121ce9b5
> > > > - v6.15-rc7-375-g61374cc145f4a5  <-- second parent, `X86_5LEVEL=3Dy=
`
> > > > - v6.15-rc7-375-g61374cc145f4a5  <-- second parent, `X86_5LEVEL=3Dn=
`
> > > > - v6.15-11061-g7f9039c524a351: "first bad", actually good. merge of=
 df7b9b4f6bfeb1 61374cc145f4a5
> > > > - v6.15-11093-g0fb34422b5c223
> > > > - v6.15-rc1-7-g0c4f8ed498cea1 + merge =3D v6.15-11101-gaec20ffad330=
68
> > > >
> > > > testing:
> > > > - v6.18-rc7 + revert: doesn't apply
> > > >
> > > > weird (ssh doesn't work):
> > > > - v6.15-rc1-1-g0486b1832dc386
> > > > - v6.15-rc1-10-g767c4b82715ad3
> > > > - v6.15-rc1-13-g394244b24fdd09: folio stuff
> > > > - v6.15-rc1-22-gf3cb8bd908c72e
> > > > - v6.15-rc1-23-gc31f91c6af96a5
> > > > - next-20251128
> > > >
> > > > bad:
> > > > - v6.15-rc1-8-g0c58a97f919c24 + merge =3D v6.15-11102-gdfc4869c8ef1=
f0  first bad commit
> > > > - v6.15-rc1-9-g69efbff69f89c9 + merge =3D v6.15-11103-ga7b103c57680=
ce
> > > > - v6.15-rc1-11-g18ee43c398af0b + merge =3D v6.15-11105-g4ad0d4fa619=
74c
> > > > - v6.15-rc1-13-g394244b24fdd09 + merge =3D v6.15-11107-g37da056b3b8=
73b
> > > > - v6.15-11119-g2619a6d413f4c3: merge of 0fb34422b5c223 (last good) =
dabb9039102879 (fuse branch)
> > > > - v6.15-11165-gfd1f8473503e5b: confirmed bad
> > > > - v6.15-11401-g69352bd52b2667
> > > > - v6.15-12422-g2c7e4a2663a1ab
> > > > - regulator-fix-v6.16-rc2-372-g5c00eca95a9a20
> > > > - v6.16.12
> > > > - v6.16.12 again
> > > > - v6.16.12+deb14+1-amd64
> > > > - v6.18-rc7
> > >
> > > Would that ring some bells to you which make this tackable?
> >
> > Hi Salvatore,
> >
> > This looks like the same issue reported in this thread [1]. The lockup
> > occurs when there's a faulty fuse server on the system that doesn't
> > complete a write request. Prior to commit 0c58a97f919c24 ("fuse:
> > remove tmp folio for writebacks and internal rb tree"), syncs on fuse
> > filesystems were effectively no-ops. This patch upstream [2] reverts
> > the behavior back to that. I'll send v2 of that patch and work on
> > getting it merged as soon as possible.
>
> Do you know did that felt trough the cracks or is it just delayed
> because of vacation/holiday times?

Hi Salvatore,

Ideally it'd be good to have Miklos's sign-off on the patch [1], which
I think is what Andrew is waiting for to merge it into his tree. I'll
follow up and ask. Maybe that's not a hard blocker since someone from
fuse (Bernd) has given their Reviewed-by for it.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-mm/20251215030043.1431306-1-joannelkoong@=
gmail.com/

>
> Regards,
> Salvatore

