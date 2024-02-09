Return-Path: <linux-fsdevel+bounces-11017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF984FD8B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 21:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8919A1F22551
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E02B1272CD;
	Fri,  9 Feb 2024 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0OlrThF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7654F86;
	Fri,  9 Feb 2024 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510324; cv=none; b=cxqD3HM6SUbZ/pPHkNvH4o/rLm/OSzcbo6DSGKa5uhN5O6ixfvgBFf9hvX7O76+8yr+fBSK1L4Li8iyFHT5oHlkhHUkl/Dz6gkqZ8um4tfOSBUktQp5yI7flYZTu2/hPnE7/6jNVDwyHdyvcpQAdW/KO0jNmuVnMDbfAmubStyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510324; c=relaxed/simple;
	bh=sCcPAezktbDMbjHUQleZfGQXAfWr5khO57a7d+GAdzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVP87O2I0FQZbKuqOSSUQpXtj9b7EKCAFwEcCKDJeWz6niV3JueS1UbL3QPwa7hbM6gP9GtfQuKPsb4i7XlbZDSa31tsWArQj5+oXEX6MAN7c+1Lp0bYtib1SK6O2pyo/6vEgijKoBwmjfKgf7ou/QIGl5PnZBCiBStf+fMPOIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0OlrThF; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511531f03f6so1602087e87.0;
        Fri, 09 Feb 2024 12:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707510321; x=1708115121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5A6EDNme+q77i6ZjmBPxQuGv8x2KqWecsrBUU0WJby4=;
        b=Y0OlrThFpj2R6KdxujGI5+2JuWIf6xeze5FahVeYYnJjNQ1jV2zTugrFdF/o6Gwu8j
         rk77aF0hQR7UTvQ0K6aRZFurdzrQdOEs4OO0Mhq3kjj/bzxxuzSJ+Yc2cH6KoBaZzCFo
         vlTtMchwZSeYnk3FIrA1kB0NSqlIclsgvDvK8iPF0Ia/JxlmU4eIJidvXSn6RDQWUPNg
         MfZhQpT1YOHeexgNJzvGFvQgrFt/bOvQdCBPizYUc9ll0A6/Ot80ilPXAsdRrj7Mp8bQ
         1l0d+EzNw/YGfHA/uEFFNZ9a6NhlAUVeVCaJcNrmCSE+EEXZCIK55nVQ5+j2B4vrzo98
         j/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510321; x=1708115121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5A6EDNme+q77i6ZjmBPxQuGv8x2KqWecsrBUU0WJby4=;
        b=mIcpRIv3cKlq3jvuRLWlkm4YuJmw1gqJ7DqiULpcfPH0BAlvEIssv4wd57u5TRA4pJ
         JSr8zwwLp+dWLY6X0AFdvT81EIOfdvfWe9bB+NQmSPRnjzUFmU9FPa6OwzelRQtyWf5k
         IA2EsvSdql9a1Ewl2CrHaYvUmt33XXspOYcB93FaZvtFB5zeK+WrYjbNq05MYyjsx2ed
         HgNj7Ic8N4KWPKKngZ1ye00Qypt/OppIJ786Skw8/ovTsw3a4PvFYP1ikRuWPcQUXXgG
         19eCh434uGiw0CYCKkcWmiTVR7K5+V9GtQyK80UKVLoTrmmVIkAPoOzGk0iStYLF4T9u
         gWlA==
X-Gm-Message-State: AOJu0YzUTX9qLgR+w8x26jtz7+MEQ3e6gU6Dcnrm1MpXriqOUaUldzBQ
	qtsPhTsTm320jUfKiC/SuqML0HG/0yFxxnp2WwedkTdHN8et2rvStwQvTFmu1VScqXB/MezjILv
	1EjtE/pcaFJHLqU5Yx5ipiTelBiE=
X-Google-Smtp-Source: AGHT+IGl9gJCY0cKGK/X9Ja2x/BwzGMP83bAZr+UA7oieXEJm/MXAkQ5AAKiCyq23IGqeVXPciNk8lNWYNy1kxrc9BI=
X-Received: by 2002:a19:7617:0:b0:511:60af:165b with SMTP id
 c23-20020a197617000000b0051160af165bmr67596lff.7.1707510320408; Fri, 09 Feb
 2024 12:25:20 -0800 (PST)
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
 <CAH2r5mt9gPhUSka56yk28+nksw7=LPuS4VAMzGQyJEOfcpOc=g@mail.gmail.com> <CAKAwkKsm3dvM_zGtYR8VHzHyA_6hzCie3mhA4gFQKYtWx12ZXw@mail.gmail.com>
In-Reply-To: <CAKAwkKsm3dvM_zGtYR8VHzHyA_6hzCie3mhA4gFQKYtWx12ZXw@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 9 Feb 2024 14:25:08 -0600
Message-ID: <CAH2r5mvSsmm2WzAakAKWGJMs3C-9+z0EJ-msV0Qjkt5q9ZPBzA@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, rdiez-2006@rd10.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > If the user does set their own "wsize", any value that is not a multipl=
e of
> PAGE_SIZE is dangerous right?

Yes for kernels 6.3 through 6.8-rc such a write size (ie that is not a
multiple of page size) can
be dangerous - that is why I added the warning on mount if the user
specifies the
potentially problematic wsize, since the wsize specified on mount
unlike the server
negotiated maximum write size is under the user's control.  The server
negotiated
maximum write size can't be controlled by the user, so for this
temporary fix we are
forced to round it down.   The actually bug is due to a folios/netfs
bug that David or
one of the mm experts may be able to spot (and fix) so for this
temporary workaround
I wanted to do the smaller change here so we don't have to revert it
later. I got close to
finding the actual bug (where the offset was getting reset, rounded up
incorrectly
inside one of the folios routines mentioned earlier in the thread) but
wanted to get something

On Fri, Feb 9, 2024 at 2:51=E2=80=AFAM Matthew Ruffell
<matthew.ruffell@canonical.com> wrote:
>
> Hi Steve,
>
> Yes, I am specifying "wsize" on the mount in my example, as its a little =
easier
> to reproduce the issue that way.
>
> If the user does set their own "wsize", any value that is not a multiple =
of
> PAGE_SIZE is dangerous right? Shouldn't we prevent the user from corrupti=
ng
> their data (un)intentionally if they happen to specify a wrong value? Esp=
ecially
> since we know about it now. I know there haven't been any other reports i=
n the
> year or so between 6.3 and present day, so there probably isn't any users=
 out
> there actually setting their own "wsize", but it still feels bad to allow=
 users
> to expose themselves to data corruption in this form.
>
> Please consider also rounding down "wsize" set on mount command line to a=
 safe
> multiple of PAGE_SIZE. The code will only be around until David's netfsli=
b cut
> over is merged anyway.
>
> I built a distro kernel and sent it to R. Diez for testing, so hopefully =
we will
> have some testing performed against an actual SMB server that sends a dan=
gerous
> wsize during negotiation. I'll let you know how that goes, or R. Diez, yo=
u can
> tell us about how it goes here.
>
> Thanks,
> Matthew
>
> On Fri, 9 Feb 2024 at 18:38, Steve French <smfrench@gmail.com> wrote:
> >
> > Are you specifying "wsize" on the mount in your example?  The intent
> > of the patch is to warn the user using a non-recommended wsize (since
> > the user can control and fix that) but to force round_down when the
> > server sends a dangerous wsize (ie one that is not a multiple of
> > 4096).
> >
> > On Thu, Feb 8, 2024 at 3:31=E2=80=AFAM Matthew Ruffell
> > <matthew.ruffell@canonical.com> wrote:
> > >
> > > Hi Steve,
> > >
> > > I built your latest patch ontop of 6.8-rc3, but the problem still per=
sists.
> > >
> > > Looking at dmesg, I see the debug statement from the second hunk, but=
 not from
> > > the first hunk, so I don't believe that wsize was ever rounded down t=
o
> > > PAGE_SIZE.
> > >
> > > [  541.918267] Use of the less secure dialect vers=3D1.0 is not
> > > recommended unless required for access to very old servers
> > > [  541.920913] CIFS: VFS: Use of the less secure dialect vers=3D1.0 i=
s
> > > not recommended unless required for access to very old servers
> > > [  541.923533] CIFS: VFS: wsize should be a multiple of 4096 (PAGE_SI=
ZE)
> > > [  541.924755] CIFS: Attempting to mount //192.168.122.172/sambashare
> > >
> > > $ sha256sum sambashare/testdata.txt
> > > 9e573a0aa795f9cd4de4ac684a1c056dbc7d2ba5494d02e71b6225ff5f0fd866
> > > sambashare/testdata.txt
> > > $ less sambashare/testdata.txt
> > > ...
> > > 8dc8da96f7e5de0f312a2dbcc3c5c6facbfcc2fc206e29283274582ec93daa2a1496c=
a8edd49e3c1
> > > 6b^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^
> > > ...
> > >
> > > Would you be able compile and test your patch and see if we enter the=
 logic from
> > > the first hunk?
> > >
> > > I'll be happy to test a V2 tomorrow.
> > >
> > > Thanks,
> > > Matthew
> > >
> > > On Thu, 8 Feb 2024 at 03:50, Steve French <smfrench@gmail.com> wrote:
> > > >
> > > > I had attached the wrong file - reattaching the correct patch (ie t=
hat
> > > > updates the previous version to use PAGE_SIZE instead of 4096)
> > > >
> > > > On Wed, Feb 7, 2024 at 1:12=E2=80=AFAM Steve French <smfrench@gmail=
.com> wrote:
> > > > >
> > > > > Updated patch - now use PAGE_SIZE instead of hard coding to 4096.
> > > > >
> > > > > See attached
> > > > >
> > > > > On Tue, Feb 6, 2024 at 11:32=E2=80=AFPM Steve French <smfrench@gm=
ail.com> wrote:
> > > > > >
> > > > > > Attached updated patch which also adds check to make sure max w=
rite
> > > > > > size is at least 4K
> > > > > >
> > > > > > On Tue, Feb 6, 2024 at 10:58=E2=80=AFPM Steve French <smfrench@=
gmail.com> wrote:
> > > > > > >
> > > > > > > > his netfslib work looks like quite a big refactor. Is there=
 any plans to land this in 6.8? Or will this be 6.9 / later?
> > > > > > >
> > > > > > > I don't object to putting them in 6.8 if there was additional=
 review
> > > > > > > (it is quite large), but I expect there would be pushback, an=
d am
> > > > > > > concerned that David's status update did still show some TODO=
s for
> > > > > > > that patch series.  I do plan to upload his most recent set t=
o
> > > > > > > cifs-2.6.git for-next later in the week and target would be f=
or
> > > > > > > merging the patch series would be 6.9-rc1 unless major issues=
 were
> > > > > > > found in review or testing
> > > > > > >
> > > > > > > On Tue, Feb 6, 2024 at 9:42=E2=80=AFPM Matthew Ruffell
> > > > > > > <matthew.ruffell@canonical.com> wrote:
> > > > > > > >
> > > > > > > > I have bisected the issue, and found the commit that introd=
uces the problem:
> > > > > > > >
> > > > > > > > commit d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > > > > Author: David Howells <dhowells@redhat.com>
> > > > > > > > Date:   Mon Jan 24 21:13:24 2022 +0000
> > > > > > > > Subject: cifs: Change the I/O paths to use an iterator rath=
er than a page list
> > > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torva=
lds/linux.git/commit/?id=3Dd08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > > > >
> > > > > > > > $ git describe --contains d08089f649a0cfb2099c8551ac47eef0c=
c23fdf2
> > > > > > > > v6.3-rc1~136^2~7
> > > > > > > >
> > > > > > > > David, I also tried your cifs-netfs tree available here:
> > > > > > > >
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/li=
nux-fs.git/log/?h=3Dcifs-netfs
> > > > > > > >
> > > > > > > > This tree solves the issue. Specifically:
> > > > > > > >
> > > > > > > > commit 34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> > > > > > > > Author: David Howells <dhowells@redhat.com>
> > > > > > > > Date:   Fri Oct 6 18:29:59 2023 +0100
> > > > > > > > Subject: cifs: Cut over to using netfslib
> > > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/dhowe=
lls/linux-fs.git/commit/?h=3Dcifs-netfs&id=3D34efb2a814f1882ddb4a518c2e8a54=
db119fd0d8
> > > > > > > >
> > > > > > > > This netfslib work looks like quite a big refactor. Is ther=
e any plans to land this in 6.8? Or will this be 6.9 / later?
> > > > > > > >
> > > > > > > > Do you have any suggestions on how to fix this with a small=
er delta in 6.3 -> 6.8-rc3 that the stable kernels can use?
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Matthew
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
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Thanks,
> > > > >
> > > > > Steve
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



--=20
Thanks,

Steve

