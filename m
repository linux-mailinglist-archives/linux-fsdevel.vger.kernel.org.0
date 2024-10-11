Return-Path: <linux-fsdevel+bounces-31696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D118499A2F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F312F1C21148
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3310A19CD19;
	Fri, 11 Oct 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyldTcid"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A0217D2;
	Fri, 11 Oct 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647112; cv=none; b=aNgR0Vl+Bt1DEdL+RPpHwThbwC7Y1tvUb8l6mbzI7tsosPc0e5yXioRlJXjQXAguyMQ4D8OsHWorCxfMtTSHskoU4zq25DINyd0Jh8FF9NyDYNzxiGbnJ3FPID7OuPHH91bi4K/s6acgHxfVOXxLNK3Drf+ihshqmlSN74mdVa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647112; c=relaxed/simple;
	bh=1E58vcsQo4BTxJHtB+WMS22DqYsQ6EIPd0N+gjtJB6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cz15TeVwGDivgJjFuq9PeMXtEJwgA6XgeEKN4LnS8GDV0gQyJA3f+lXBogN3hWxFm2DijTBSw+BI50U/U1i/CPBLx3TNUmPPcgx+yrQyJieR2hDhF8elb4Ox+7dlqwJ2hJd78zS6OWEZ+TfgAJi0BymP8G+bZ+TR2MULpJulnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyldTcid; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b1109e80f8so134091885a.0;
        Fri, 11 Oct 2024 04:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728647109; x=1729251909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1jb/ru5Bjn1Blrcth4PCNUJS0t0xfvX9jEJ3dJXFS4=;
        b=cyldTcidf+qDDk3G1a7yZlHdBBUVzsNDYsChjyeNaFmA4Rp9FGg5Ngjt2UzOdfNDJl
         0VsX0wDZ8otkK66Sc78KhVMJ1Do+iYQk7rzjtLfPcy8t0NR9KeI2TaZ2amNVZXBDrDav
         EK+Fn3MNUPkSSe+LCibnqfRaxnXiVBC/VAzfKnsAO9VhqLq1TeTuKXB7zPpzn9Crk37s
         2/eW1e8WRgeVnNEACvbrGR6i6Fa4oxwUNDgN85YAEhHQlwblCVKhLVb4ktfFYARW4t9o
         Gi8vYlFu49dTUqIGQ9sv3ARSO8Y2a+6qOTkEIemSYKR7NCbefRfYt6a/tqpqgeefW7h3
         cUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728647109; x=1729251909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1jb/ru5Bjn1Blrcth4PCNUJS0t0xfvX9jEJ3dJXFS4=;
        b=cQFXJpfZ8RwE+0RMS6YFnFaG8HC37jcIofGOA8kCYiy3c/4WQzh3Xkz13D115mtbry
         5E/rXQuvvtnpjQtL9ScaMUaflRvZXB+hk5izo0GpcYipqdme1lUh59+WiUqEKmIJEmRh
         IXBh3wnfD0vw1EsoKU8PP3bu1oosC7ROd/js63jED5jDztB9pZXZfXaYsrJjCRZl3iEp
         6dv/Mc+OwTyDZFExidlTGA1+eNMg0mluxe0nwS4zMfVtnOBM835Aqf0uckAyAgv99Ydd
         O9afaptekLYP/hMCnxGYN2hFU+Vuy0CA/7/gDZDpl9MSUwyW2I1O4Op5pzTtxLH36FwI
         kj8g==
X-Forwarded-Encrypted: i=1; AJvYcCU06U7JhHvUgBGFNaKxHQTa1atm68mRytBY+7zfAj4pUQfIEGI3J6ZnEFn0oT+OeuFg1d+5S1jJ6wdyumzP@vger.kernel.org, AJvYcCXQqWYUn0JJjRhLbMWO92kx/5yC376/VxPxQjStPvOYk/YB+oxWJszc3ESBmOm5y66hJMyUqTvSH/D7YTKQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0qSELuAh5vAqLVw2aJntAeIJhoUefOCHNB3uSczDFcfDSWkkm
	3FRKCkj0y8gFS++6dzIhaflcYtEXXN5NQVuAeGbqr9E+Vhq43hLJ7G4gsLNSg9ZuQwEErFpzsX7
	jYQWiRYzK25ptjAZKF6akf1Rj8Vg=
X-Google-Smtp-Source: AGHT+IFyNzeb5KjHCbIrIePBptEFYE3LsiWqvEeRW3bLqPoHEY80MxzHHH2MRrAv673DCAO/NgSltJ3W2HuchUwfRlc=
X-Received: by 2002:a05:620a:2902:b0:7a9:d0ec:2d9d with SMTP id
 af79cd13be357-7b11a35f5camr339903985a.15.1728647108062; Fri, 11 Oct 2024
 04:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010112543.1609648-1-yebin@huaweicloud.com>
 <20241010112543.1609648-3-yebin@huaweicloud.com> <20241010121607.54ttcmdfmh7ywho7@quack3>
 <5A1217C0-A778-4A9A-B9D8-5F0401DC1013@redhat.com> <20241010170405.m5l4wutd4csj3v6d@quack3>
In-Reply-To: <20241010170405.m5l4wutd4csj3v6d@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Oct 2024 13:44:57 +0200
Message-ID: <CAOQ4uxiR9ssLb8b6WBFhYJpDrSEvMfALx12w3sOzjB8qe_7t_g@mail.gmail.com>
Subject: Re: [PATCH 2/3] sysctl: add support for drop_caches for individual filesystem
To: Jan Kara <jack@suse.cz>, brauner@kernel.org
Cc: Benjamin Coddington <bcodding@redhat.com>, Ye Bin <yebin@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yebin10@huawei.com, zhangxiaoxu5@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 7:04=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 10-10-24 09:35:46, Benjamin Coddington wrote:
> > On 10 Oct 2024, at 8:16, Jan Kara wrote:
> >
> > > On Thu 10-10-24 19:25:42, Ye Bin wrote:
> > >> From: Ye Bin <yebin10@huawei.com>
> > >>
> > >> In order to better analyze the issue of file system uninstallation c=
aused
> > >> by kernel module opening files, it is necessary to perform dentry re=
cycling
> > >
> > > I don't quite understand the use case you mention here. Can you expla=
in it
> > > a bit more (that being said I've needed dropping caches for a particu=
lar sb
> > > myself a few times for debugging purposes so I generally agree it is =
a
> > > useful feature).
> > >
> > >> on a single file system. But now, apart from global dentry recycling=
, it is
> > >> not supported to do dentry recycling on a single file system separat=
ely.
> > >> This feature has usage scenarios in problem localization scenarios.A=
t the
> > >> same time, it also provides users with a slightly fine-grained
> > >> pagecache/entry recycling mechanism.
> > >> This patch supports the recycling of pagecache/entry for individual =
file
> > >> systems.
> > >>
> > >> Signed-off-by: Ye Bin <yebin10@huawei.com>
> > >> ---
> > >>  fs/drop_caches.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
> > >>  include/linux/mm.h |  2 ++
> > >>  kernel/sysctl.c    |  9 +++++++++
> > >>  3 files changed, 54 insertions(+)
> > >>
> > >> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> > >> index d45ef541d848..99d412cf3e52 100644
> > >> --- a/fs/drop_caches.c
> > >> +++ b/fs/drop_caches.c
> > >> @@ -77,3 +77,46 @@ int drop_caches_sysctl_handler(const struct ctl_t=
able *table, int write,
> > >>    }
> > >>    return 0;
> > >>  }
> > >> +
> > >> +int drop_fs_caches_sysctl_handler(const struct ctl_table *table, in=
t write,
> > >> +                            void *buffer, size_t *length, loff_t *p=
pos)
> > >> +{
> > >> +  unsigned int major, minor;
> > >> +  unsigned int ctl;
> > >> +  struct super_block *sb;
> > >> +  static int stfu;
> > >> +
> > >> +  if (!write)
> > >> +          return 0;
> > >> +
> > >> +  if (sscanf(buffer, "%u:%u:%u", &major, &minor, &ctl) !=3D 3)
> > >> +          return -EINVAL;
> > >
> > > I think specifying bdev major & minor number is not a great interface=
 these
> > > days. In particular for filesystems which are not bdev based such as =
NFS. I
> > > think specifying path to some file/dir in the filesystem is nicer and=
 you
> > > can easily resolve that to sb here as well.
> >
> > Slight disagreement here since NFS uses set_anon_super() and major:mino=
r
> > will work fine with it.
>
> OK, fair point, anon bdev numbers can be used. But filesystems using
> get_tree_nodev() would still be problematic.
>
> > I'd prefer it actually since it avoids this
> > interface having to do a pathwalk and make decisions about what's mount=
ed
> > where and in what namespace.
>
> I don't understand the problem here. We'd do user_path_at(AT_FDCWD, ...,
> &path) and then take path.mnt->mnt_sb. That doesn't look terribly
> complicated to me. Plus it naturally deals with issues like namespacing
> etc. although they are not a huge issue here because the functionality
> should be restricted to CAP_SYS_ADMIN anyway.
>

Both looking up bdev and looking up path from write() can make syzbot
and lockdep very upset:
https://lore.kernel.org/linux-fsdevel/00000000000098f75506153551a1@google.c=
om/

I thought Christian had a proposal for dropping cache per-sb API via fadvis=
e()
or something?

Why use sysfs API for this and not fd to reference an sb?

Thanks,
Amir.

