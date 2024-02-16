Return-Path: <linux-fsdevel+bounces-11798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AD5857322
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 02:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943211C2093A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650ECEAC2;
	Fri, 16 Feb 2024 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT8H4rqA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6A1B94E;
	Fri, 16 Feb 2024 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045191; cv=none; b=ksHoL72B2NznPApgB2BrBMQuQ6ROWqUWlDdUjMnFh3B02OqkSbXlqfGbjRYBcTM+LZPESGvBx0U3RVvfX2TT7Bc+8HhUjsulPdFZJTPQnoWSEdnHxfeKlcZufKz9SFHMThsGxofblT7hmYX1w1P7JVAYqSOHikNVcY4QFA4etoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045191; c=relaxed/simple;
	bh=Gz1qBCJgYa4sI0XXpDKFTnCUFtfXZhdQgo8s7WL8ISo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7h5WBIKX5g3iFv6VWyP9HtWlkn/Ft68JWNlKw5GNZicOHXhvU2qTmACubkHwzR69kFAZnNi7BpnYMCVLYAkyfQCRRkoQ54PKSHWe5PwSkXiax3POyzAaENyuSrdqd/uuu8oBU6aDxO0gTHaH7jgoBmvn0HCybzMrHwUBdr3+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT8H4rqA; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d10ad265d5so3410771fa.0;
        Thu, 15 Feb 2024 16:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708045187; x=1708649987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGeZNIWrwGCFN5tnpI3ZYrr58l8YE+botW14fPD50bA=;
        b=LT8H4rqA1aEwJRgO5a+lUSQa6JP+WEuso5NlnpLjvwB1I9bproJdtLzZ3snr7SvhD8
         KWmAEQMCKDyCh9K9l2drY5626ys5nWEs1Op7AUTGBfSKGvmA3c3mgDA89JwhfgvkhzTd
         Sj/aYqesXvnPoFFFB9e3w6me+IhIMXB/RqEVZbB1v9uL0X7Sf/3fdjiZfhBKjja1gsm0
         xqChe5rvesZo8OSK4r22Ii/sGchPGK/4AHGi0mQ0dF6YvQ4QiF7JoXrIeC7ZmFecwO+p
         H/Sve/JnTq/B0/jfWYHMQCHdX6vWRtav0QYufLBYFyEPQhhBZlL562Oc0taaD6UXBOMM
         bP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708045187; x=1708649987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGeZNIWrwGCFN5tnpI3ZYrr58l8YE+botW14fPD50bA=;
        b=bv7qPUmV1i5yt33TicO8qnEckYrj3dHx+Xt5ixOrOKaRJOOjt99mO8d+itpgch+84E
         QpOpSXFb/uwfOljLmlw06Dsw/jWI7NEBNPEj2xq3jHlG0G7F0YFrTR61hq3z4pnAnAx6
         lKSi3CXknuc3vXBrqNkv8HsuMvJGP9QVBc3lQJMHtdPPXCfj0s6pfNHFCrPy+7eOhWjH
         Qd2kPBylIMbROKc+m0RhnZmRBAUAx0BHf6f5qYzXhK/m29cxGvsiG3rS7RRAPE3m1SAh
         ajNpmpSDoqPXdEcPaQabxZab2V/EJO1wqdzhs1CGbS2fUhuOR48/K+Sn5583fJOoZ/J4
         XqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+lFBD6aSMgOqJ6wO1QgFB/HEGt3AMUqhF1xzULrzA+O9F0bYN6dxiBy6sWjGlslLAG0Rixre7BVFPG6L3195x0z9qjgOHi3yAS+U8wgJlzqogixpUkkWapOYOJpYORSZi+j1zpK48xHY=
X-Gm-Message-State: AOJu0YyTorOUf90l+tOjUnb//BrGQ9XLlXF0dyg8Vjmtkneqe1om219I
	vj6dE6a7s9iK31ynXw+oBrrVvHWXyNlUjdZs70Uelsc1ajO6aEg3/YGmrmo0fVe9WFKAixYiWOI
	ustq6wZc5NMWRTnAtXlD7N9NYzoM=
X-Google-Smtp-Source: AGHT+IHbOvUsOz8/O5UpkLTizz6EQpfFPLy9AyQPltYAlmwAqpVwwLAAx5ZWZgbdJfS8M3KCkjpLdvm+yFdOL2kk3x8=
X-Received: by 2002:a2e:8186:0:b0:2d2:178a:4f96 with SMTP id
 e6-20020a2e8186000000b002d2178a4f96mr293516ljg.14.1708045187350; Thu, 15 Feb
 2024 16:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com> <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
 <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
 <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com>
 <CAH2r5mvzyxP7vHQVcT6ieP4NmXDAz2UqTT7G4yrxcVObkV_3YQ@mail.gmail.com>
 <CAKAwkKuJvFDFG7=bCYmj0jdMMhYTLUnyGDuEAubToctbNqT5CQ@mail.gmail.com>
 <CAH2r5mt9gPhUSka56yk28+nksw7=LPuS4VAMzGQyJEOfcpOc=g@mail.gmail.com>
 <CAKAwkKsm3dvM_zGtYR8VHzHyA_6hzCie3mhA4gFQKYtWx12ZXw@mail.gmail.com>
 <CAH2r5mvSsmm2WzAakAKWGJMs3C-9+z0EJ-msV0Qjkt5q9ZPBzA@mail.gmail.com> <CAH2r5mvPz2CUyKDZv_9fYGu=9L=3UiME7xaJGBbu+iF8CH8YEQ@mail.gmail.com>
In-Reply-To: <CAH2r5mvPz2CUyKDZv_9fYGu=9L=3UiME7xaJGBbu+iF8CH8YEQ@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Fri, 16 Feb 2024 06:29:34 +0530
Message-ID: <CANT5p=r=DySxfSVsm9drGvJs9cBdwF_xx7Qj3=HqQ5LQfk_5mA@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: Steve French <smfrench@gmail.com>
Cc: Matthew Ruffell <matthew.ruffell@canonical.com>, dhowells@redhat.com, 
	linux-cifs@vger.kernel.org, rdiez-2006@rd10.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 1:02=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> Minor update to patch to work around the folios/netfs data corruption.
>
> In addition to printing the warning if "wsize=3D" is specified on mount
> with a size that is not a multiple of PAGE_SIZE, it also rounds the
> wsize down to the nearest multiple of PAGE_SIZE (as it was already
> doing if the server tried to negotiate a wsize that was not a multiple
> of PAGE_SIZE).
>
> On Fri, Feb 9, 2024 at 2:25=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
> >
> > > > If the user does set their own "wsize", any value that is not a mul=
tiple of
> > > PAGE_SIZE is dangerous right?
> >
> > Yes for kernels 6.3 through 6.8-rc such a write size (ie that is not a
> > multiple of page size) can
> > be dangerous - that is why I added the warning on mount if the user
> > specifies the
> > potentially problematic wsize, since the wsize specified on mount
> > unlike the server
> > negotiated maximum write size is under the user's control.  The server
> > negotiated
> > maximum write size can't be controlled by the user, so for this
> > temporary fix we are
> > forced to round it down.   The actually bug is due to a folios/netfs
> > bug that David or
> > one of the mm experts may be able to spot (and fix) so for this
> > temporary workaround
> > I wanted to do the smaller change here so we don't have to revert it
> > later. I got close to
> > finding the actual bug (where the offset was getting reset, rounded up
> > incorrectly
> > inside one of the folios routines mentioned earlier in the thread) but
> > wanted to get something
> >
> > On Fri, Feb 9, 2024 at 2:51=E2=80=AFAM Matthew Ruffell
> > <matthew.ruffell@canonical.com> wrote:
> > >
> > > Hi Steve,
> > >
> > > Yes, I am specifying "wsize" on the mount in my example, as its a lit=
tle easier
> > > to reproduce the issue that way.
> > >
> > > If the user does set their own "wsize", any value that is not a multi=
ple of
> > > PAGE_SIZE is dangerous right? Shouldn't we prevent the user from corr=
upting
> > > their data (un)intentionally if they happen to specify a wrong value?=
 Especially
> > > since we know about it now. I know there haven't been any other repor=
ts in the
> > > year or so between 6.3 and present day, so there probably isn't any u=
sers out
> > > there actually setting their own "wsize", but it still feels bad to a=
llow users
> > > to expose themselves to data corruption in this form.
> > >
> > > Please consider also rounding down "wsize" set on mount command line =
to a safe
> > > multiple of PAGE_SIZE. The code will only be around until David's net=
fslib cut
> > > over is merged anyway.
> > >
> > > I built a distro kernel and sent it to R. Diez for testing, so hopefu=
lly we will
> > > have some testing performed against an actual SMB server that sends a=
 dangerous
> > > wsize during negotiation. I'll let you know how that goes, or R. Diez=
, you can
> > > tell us about how it goes here.
> > >
> > > Thanks,
> > > Matthew
> > >
> > > On Fri, 9 Feb 2024 at 18:38, Steve French <smfrench@gmail.com> wrote:
> > > >
> > > > Are you specifying "wsize" on the mount in your example?  The inten=
t
> > > > of the patch is to warn the user using a non-recommended wsize (sin=
ce
> > > > the user can control and fix that) but to force round_down when the
> > > > server sends a dangerous wsize (ie one that is not a multiple of
> > > > 4096).
> > > >
> > > > On Thu, Feb 8, 2024 at 3:31=E2=80=AFAM Matthew Ruffell
> > > > <matthew.ruffell@canonical.com> wrote:
> > > > >
> > > > > Hi Steve,
> > > > >
> > > > > I built your latest patch ontop of 6.8-rc3, but the problem still=
 persists.
> > > > >
> > > > > Looking at dmesg, I see the debug statement from the second hunk,=
 but not from
> > > > > the first hunk, so I don't believe that wsize was ever rounded do=
wn to
> > > > > PAGE_SIZE.
> > > > >
> > > > > [  541.918267] Use of the less secure dialect vers=3D1.0 is not
> > > > > recommended unless required for access to very old servers
> > > > > [  541.920913] CIFS: VFS: Use of the less secure dialect vers=3D1=
.0 is
> > > > > not recommended unless required for access to very old servers
> > > > > [  541.923533] CIFS: VFS: wsize should be a multiple of 4096 (PAG=
E_SIZE)
> > > > > [  541.924755] CIFS: Attempting to mount //192.168.122.172/sambas=
hare
> > > > >
> > > > > $ sha256sum sambashare/testdata.txt
> > > > > 9e573a0aa795f9cd4de4ac684a1c056dbc7d2ba5494d02e71b6225ff5f0fd866
> > > > > sambashare/testdata.txt
> > > > > $ less sambashare/testdata.txt
> > > > > ...
> > > > > 8dc8da96f7e5de0f312a2dbcc3c5c6facbfcc2fc206e29283274582ec93daa2a1=
496ca8edd49e3c1
> > > > > 6b^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^
> > > > > ...
> > > > >
> > > > > Would you be able compile and test your patch and see if we enter=
 the logic from
> > > > > the first hunk?
> > > > >
> > > > > I'll be happy to test a V2 tomorrow.
> > > > >
> > > > > Thanks,
> > > > > Matthew
> > > > >
> > > > > On Thu, 8 Feb 2024 at 03:50, Steve French <smfrench@gmail.com> wr=
ote:
> > > > > >
> > > > > > I had attached the wrong file - reattaching the correct patch (=
ie that
> > > > > > updates the previous version to use PAGE_SIZE instead of 4096)
> > > > > >
> > > > > > On Wed, Feb 7, 2024 at 1:12=E2=80=AFAM Steve French <smfrench@g=
mail.com> wrote:
> > > > > > >
> > > > > > > Updated patch - now use PAGE_SIZE instead of hard coding to 4=
096.
> > > > > > >
> > > > > > > See attached
> > > > > > >
> > > > > > > On Tue, Feb 6, 2024 at 11:32=E2=80=AFPM Steve French <smfrenc=
h@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Attached updated patch which also adds check to make sure m=
ax write
> > > > > > > > size is at least 4K
> > > > > > > >
> > > > > > > > On Tue, Feb 6, 2024 at 10:58=E2=80=AFPM Steve French <smfre=
nch@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > > his netfslib work looks like quite a big refactor. Is t=
here any plans to land this in 6.8? Or will this be 6.9 / later?
> > > > > > > > >
> > > > > > > > > I don't object to putting them in 6.8 if there was additi=
onal review
> > > > > > > > > (it is quite large), but I expect there would be pushback=
, and am
> > > > > > > > > concerned that David's status update did still show some =
TODOs for
> > > > > > > > > that patch series.  I do plan to upload his most recent s=
et to
> > > > > > > > > cifs-2.6.git for-next later in the week and target would =
be for
> > > > > > > > > merging the patch series would be 6.9-rc1 unless major is=
sues were
> > > > > > > > > found in review or testing
> > > > > > > > >
> > > > > > > > > On Tue, Feb 6, 2024 at 9:42=E2=80=AFPM Matthew Ruffell
> > > > > > > > > <matthew.ruffell@canonical.com> wrote:
> > > > > > > > > >
> > > > > > > > > > I have bisected the issue, and found the commit that in=
troduces the problem:
> > > > > > > > > >
> > > > > > > > > > commit d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > > > > > > Author: David Howells <dhowells@redhat.com>
> > > > > > > > > > Date:   Mon Jan 24 21:13:24 2022 +0000
> > > > > > > > > > Subject: cifs: Change the I/O paths to use an iterator =
rather than a page list
> > > > > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/t=
orvalds/linux.git/commit/?id=3Dd08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > > > > > >
> > > > > > > > > > $ git describe --contains d08089f649a0cfb2099c8551ac47e=
ef0cc23fdf2
> > > > > > > > > > v6.3-rc1~136^2~7
> > > > > > > > > >
> > > > > > > > > > David, I also tried your cifs-netfs tree available here=
:
> > > > > > > > > >
> > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowell=
s/linux-fs.git/log/?h=3Dcifs-netfs
> > > > > > > > > >
> > > > > > > > > > This tree solves the issue. Specifically:
> > > > > > > > > >
> > > > > > > > > > commit 34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> > > > > > > > > > Author: David Howells <dhowells@redhat.com>
> > > > > > > > > > Date:   Fri Oct 6 18:29:59 2023 +0100
> > > > > > > > > > Subject: cifs: Cut over to using netfslib
> > > > > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/d=
howells/linux-fs.git/commit/?h=3Dcifs-netfs&id=3D34efb2a814f1882ddb4a518c2e=
8a54db119fd0d8
> > > > > > > > > >
> > > > > > > > > > This netfslib work looks like quite a big refactor. Is =
there any plans to land this in 6.8? Or will this be 6.9 / later?
> > > > > > > > > >
> > > > > > > > > > Do you have any suggestions on how to fix this with a s=
maller delta in 6.3 -> 6.8-rc3 that the stable kernels can use?
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Matthew
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Thanks,
> > > > > > > > >
> > > > > > > > > Steve
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > Steve
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Thanks,
> > > > > > >
> > > > > > > Steve
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Thanks,
> > > > > >
> > > > > > Steve
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > >
> > > > Steve
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Thanks,
>
> Steve

Minor comments.
In smb3_fs_context_parse_param, we don't strictly need to use
round_down twice. We could use a modulo operation for the check.
Also, there's an unnecessary change in fs_context.h though.
Other than that, the patch looks good to me. RB

--=20
Regards,
Shyam

