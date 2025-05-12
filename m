Return-Path: <linux-fsdevel+bounces-48720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A50AB3377
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDFD179A8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB09325C832;
	Mon, 12 May 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/WNNIav"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B425B1CD;
	Mon, 12 May 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041812; cv=none; b=CsxpL/dODDMZk+tCTrq2FJA3JRSUqFeWoqZpW5FSGwlTLKYkHqnx4gLUVotOUR56JmouhIPno6dY3Q/pg0eAUrZZgMiLWCeNcHDVtyOG7TCPuEmct2lCWrONwcBS2mVp73rCmvVHrOX6qQJ/heN1NL4YKfFuvrimhjBYYZSi8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041812; c=relaxed/simple;
	bh=89sZqGuNSkvdpj6n9MXwDCPpmTPbDyYHg6keMS4GHqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5sGpnu03iJ1DN2KFNV2fZtlGUCB7ssVlRwOgpELRZTIa/YO9rzZH/bJZf14VZgYB8nZ0OQTF21vfRZARlKgc7F6VxxHUOOB8ssyaI47c3Vkd7B6wM1qGM9Z45NIF3c9gT7Ob31bMYIuKDpgzgaHjdordwM9yItbL/pk+ahxrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/WNNIav; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fc9c49c8adso3994931a12.3;
        Mon, 12 May 2025 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747041809; x=1747646609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeVC66rQDN7pvLPMFsPPWmT1oKHoJXZc3cx0+31yGWk=;
        b=E/WNNIav7ArdICItLCvfgTERbkWK/LMVX8KfOrjQHUTbCxBUVbhh7Da5DkQWPh86XI
         2z7NDyMOOBUfYhoIdICdEot0WK2t4qDfK4pIKgOqEcq5bomRs68Vh61pRacgMYcayPp+
         Whsbu/O2Jcip7M6EQSkB0EnKTWhmJCaAk1BvVFsST49HDUiQy8DXJ0FSUDAAZORCB/nH
         Tms0psGM8bjzdkdbG5fc991yiEzklsxe9l+v3SBqgw2DXc5nSxriqKlagll2Wa6GDiAT
         x1bqqsdg4Sf7s2+50pCqYI9/YqJbPsIQM5pGcCw0gvlPk9pNAq+Jbg3hT+KBHb0JOuF6
         pp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747041809; x=1747646609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeVC66rQDN7pvLPMFsPPWmT1oKHoJXZc3cx0+31yGWk=;
        b=U0r1QAAdrHrLu1DgjS5LJ3MDQrIU/7S7ZQwx5cGK+0n0ZSY9E6Jm4ffBBpbaeHamZ0
         yyU4CYrpW7Jw2k5lnByLtVkuqxzcTzIGKYJ7GsJb3xcYZz6S8PUT9AEJyD8Pdpc9eEID
         xBH9gH3HGaIu/dBfMNLyQXrJrnq43ZUTjtoi/1311QY5cZI3zqB5zC/S2nwTGlPSwEKn
         GZ6olcQfq0/huToDu4B1A2ZLcGab6wqMVZjClEbzLFu+tT4elrGuYkOwJv2GOma7tCeg
         4qK4IjxlRyUUPp5BeWrinWSyhHEvXgDV2CQtf+F/e2QowxQtoaSxzt3n4t3l9i83tLng
         cumg==
X-Forwarded-Encrypted: i=1; AJvYcCXBzBPJ9JX0EZPKbF1oLuAeU6owhZKk/JfKYhzBn3i13nzrenpnK5L3U44U3HGfvRtNhjDYPVNgQoHVMN3E@vger.kernel.org, AJvYcCXHWkNr7Y39uXF6JirO/q79MosmzmWLLDRE4WVPyZJop4DTGT+Oma7+cyxdDv+I3XB3XlCSfRsc/W734n2v@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0pQzNhrfYYrnBi3KRcowSTdk87/kh3S1hA1I6cgcV0EAPaRi
	ZvTUtZLoI2lQ+jgxQGm3thK9Yb0iMYzClSG+91xzJukIEkzC/GyBYkdKK4gwJr6tP1P3+TPWebN
	ZK+glTCRrqOh7W2hsktr2UpKAAmM=
X-Gm-Gg: ASbGncv8LpY//Mft82lczCne7W5wklHdBdnXXt3w9CIasEjGdNgakvivZqJAI/KtU5i
	hls2n5zdm2rEEcwaDiHGhMONXeRXXYreRc0H3C/73ACk44dLTLBLzdPc8NBzhee/C52HX3oa/xf
	ZqA12Ofy8kaWOzi7APp/iMnXe8Xjmok8rO
X-Google-Smtp-Source: AGHT+IFgfcOzZ/ZrpapltWUFPPSovtg1lPh2QGS5fNadobB3/uric5qh0Sh0mvSJJEez27Ujl1s3Ouq3Wn1auVG3r9k=
X-Received: by 2002:a17:907:9729:b0:ad2:54c5:42ef with SMTP id
 a640c23a62f3a-ad254c545cemr274632466b.5.1747041808134; Mon, 12 May 2025
 02:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
 <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
 <CAC1kPDPWag5oaZH62YbF8c=g7dK2_AbFfYMK7EzgcegDHL829Q@mail.gmail.com> <CAJfpegu59imrvXSbkPYOSkn0k_FrE6nAK1JYWO2Gg==Ozk9KSg@mail.gmail.com>
In-Reply-To: <CAJfpegu59imrvXSbkPYOSkn0k_FrE6nAK1JYWO2Gg==Ozk9KSg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 12 May 2025 11:23:15 +0200
X-Gm-Features: AX0GCFso4tMDxIW78HKWY_HNHtLI9t31XfP6g-OaXqjofsiOCFHpDFG1Yc6uBKg
Message-ID: <CAOQ4uxgM+oJxp0Od=i=Twj9EN2v2+rFByEKabZybic=6gA0QgA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 10:27=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Sun, 11 May 2025 at 11:56, Chen Linxuan <chenlinxuan@uniontech.com> wr=
ote:
>
> > I noticed that the current extended attribute names already use the
> > namespace.value format.
> > Perhaps we could reuse this naming scheme and extend it to support
> > features like nested namespaces.
>
> Right.  Here's a link to an old and long thread about this:
>
>    https://lore.kernel.org/all/YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com=
/#r
>

The way I see it is, generic vs. specialized have pros and cons
There is no clear winner.
Therefore, investing time on the getxattr() direction without consensus
with vfs maintainer is not wise IMO.

> >
> > For instance, in a situation like this:
> >
> > A fixed file 0 in an io_uring is a FUSE fd.
> > This FUSE fd belongs to FUSE connection 64.
> > This FUSE fd has a backing file.
> > This backing file is actually provided by mnt_id=3D36.
> >
> > Running getfattr -m '-' /proc/path/to/the/io_uring/fd could return
> > something like:
> >
> > io_uring.fixed_files.0.fuse.conn=3D"64"
> > io_uring.fixed_files.0.fuse.backing_file.mnt_id=3D"36"
> > io_uring.fixed_files.0.fuse.backing_file.path=3D"/path/to/real/file"
>
> Yeah, except listxattr wouldn't be able to properly work in such
> cases: it lacks support for hierarchy.
>
> The proposed solution was something like making getxattr on the
> "directory" return a listing of child object names.
>
> I.e. getxattr("/proc/123/fd/12", "io_uring.fixed_files.") would return
> the list of instantiated fixed file slots, etc...

The problem I see with this scheme is that it is not generic enough.
If lsof is to support displaying fuse backing files, then it needs to
know specifically about those magic xattrs.

Because lsof only displays information about open files, I think
it would be better to come up with a standard tag in fdinfo for lsof
to recognize, for example:

hidden_file: /path/to/hidden/file
hidden_files_list: /path/to/connections/N/backing_files

and then conform to the same fdinfo standard from fuse_dev_fd,
io_uring_fd, unix_socket_fd.

Making an interface more hierarchic than hidden_files_list:
is useless because lsof traverses all fds anyway to filter by
name pattern and I am very sceptical of anyone trying to
push for an API get_open_fds_by_name_pattern()...

Thanks,
Amir.

