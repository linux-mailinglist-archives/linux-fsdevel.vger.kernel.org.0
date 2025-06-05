Return-Path: <linux-fsdevel+bounces-50752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CFCACF4A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 18:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F763A880B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD04276047;
	Thu,  5 Jun 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDHKrQ5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A9272E60;
	Thu,  5 Jun 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142070; cv=none; b=qyEkCQ/uFJDZsmA2ZOgQwXiKdlLZZ5UaeMO/tV9WN7sJdzuvQ4badHxc+dNzSVmuuHI2hGuWb7SRvQi5/cRYjAxa5NWVWl7oTxVGvP7xP/8xMVdUSxWYoOySEeI5uXsosUeyvKoLlsZ5TYCboqptJzdpK9sgaASIydFZAop23fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142070; c=relaxed/simple;
	bh=3w8JkMR+dyq082xGIErStybqJdnFiDxHZZEpuJDxc3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t78ZdHSGvBxOJvjhuq1TFtxTehzF+kSEXd/YZJ9wK4ECc7lvdHv3RiguwS/y+euz5kUK0QRCtEclfoAA9ntwE5GJtUR7zoOM0ewGiBL7kkUPZtco+2mk2ugwtX+1ZX7ytORLeHG77pUSFyvCR68ECSAWZXVQUPoZ1xNAjqLZJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDHKrQ5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F4AC4CEF0;
	Thu,  5 Jun 2025 16:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749142069;
	bh=3w8JkMR+dyq082xGIErStybqJdnFiDxHZZEpuJDxc3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iDHKrQ5tePQjpI9sn8mjRk57YAtDPhlZJHvhfg6Iy0klF+8ltljpme/kPr9HYotO6
	 f2kjL3muTlj2UikuaJw8/p4eztsNuYFFjX44gdIqlNiOmLH32Q4WmbGZFu9sAw2Pd9
	 eIClFx2j337dEbMQbp1uJuNu2/Atsmu61vVysI0xRRZpUihquL35/iI0/yKf6FDzhC
	 ecbP7VUy5Is+rFOxk1sucNSGQYZPVlDykshAAhtyd+AqsuQcVMnNL/uqvEqRCQPyEh
	 JS0XdsnE4An0ESq+DhaC/rmHCWsX1xfXdmKyUbPkAZrsJ7KqnMWlXG3gz5c4AyNQuc
	 jTEruXZlao9dQ==
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a4312b4849so14307471cf.1;
        Thu, 05 Jun 2025 09:47:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxo6pW5LL7LpftHK9emUuVT4TrCeZfS4ZJNv4fa93TORM1SyZ8w4KQio6f6yZ6WyrzBnW9tL58tjeCtiy9@vger.kernel.org, AJvYcCW4qbRvc3eWD/qENrkU0xfTIZoy8bS4xwdnQd2mKGA7akYwA/Q6ZwiYcURkJjpzWnJtvTwYQtC5IOVv3WFs@vger.kernel.org, AJvYcCXkCajXHkwdPoj5udeiTJjNs06/u/uoMUXfEFUSYiGfcHD6SUeLmMJWOjgEJSp94lwFaZ+8Yf+LQsCNLyB4l7qBYyjduNdi@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTuzSnr6lWhL4ZiL8W7bxMNOS+YcEKuNcAQ81mEt98QVgMnO2
	KRq7IxRkYN5hauAQFy1kNH0Q/NALl9qzDOW+6J7FFbFMEcBdBDTcJ1Fku6Cpczci4igIJZ1OBsH
	yfyeyLQiZU3BDWT9MYhW70ggJszta49I=
X-Google-Smtp-Source: AGHT+IGiVWsRgna6YFtX3lIOZflyd/n65LzeA7u2H4Vn6CADHl7LjKAcdgMWsH2J9c3odTzb41X29luFgy3QJL3PEE0=
X-Received: by 2002:a05:6214:248d:b0:6e8:fcde:58d5 with SMTP id
 6a1803df08f44-6fb08fca70cmr1701456d6.42.1749142067979; Thu, 05 Jun 2025
 09:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603065920.3404510-1-song@kernel.org> <20250603065920.3404510-3-song@kernel.org>
 <20250603.Av6paek5saes@digikod.net> <CAPhsuW6J_hDtXZm4MH_OAz=GCpRW0NMM1EXMrJ=nqsTdpf8vcg@mail.gmail.com>
In-Reply-To: <CAPhsuW6J_hDtXZm4MH_OAz=GCpRW0NMM1EXMrJ=nqsTdpf8vcg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 5 Jun 2025 09:47:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7MtxryseFsHF2xqBFS2UWammJatjf8UxBhytgn_nA4=g@mail.gmail.com>
X-Gm-Features: AX0GCFuxvd5FPNUUEpcc72D9DOeW57RE3kAaur20E9lAgQ4Gi6GJ17dndQGcnv8
Message-ID: <CAPhsuW7MtxryseFsHF2xqBFS2UWammJatjf8UxBhytgn_nA4=g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] landlock: Use path_walk_parent()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com, m@maowtm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 12:37=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, Jun 3, 2025 at 6:46=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> >
> > Landlock tests with hostfs fail:
> >
> > ok 126 layout3_fs.hostfs.tag_inode_file
> > #  RUN           layout3_fs.hostfs.release_inodes ...
> > # fs_test.c:5555:release_inodes:Expected EACCES (13) =3D=3D test_open(T=
MP_DIR, O_RDONLY) (0)
> >
> > This specific test checks that an access to a (denied) mount point over
> > an allowed directory is indeed denied.

I just realized this only fails on hostfs. AFAICT, hostfs is only used
by um. Do we really need this to behave the same on um+hostfs?

Thanks,
Song

>
> I am having trouble understanding the test. It appears to me
> the newly mounted tmpfs on /tmp is allowed, but accesses to
> / and thus mount point /tmp is denied? What would the walk in
> is_access_to_paths_allowed look like?
>
> > It's not clear to me the origin of the issue, but it seems to be relate=
d
> > to choose_mountpoint().
> >
> > You can run these tests with `check-linux.sh build kselftest` from
> > https://github.com/landlock-lsm/landlock-test-tools
>
> How should I debug this test? printk doesn't seem to work.
>
> Thanks,
> Song

