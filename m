Return-Path: <linux-fsdevel+bounces-63820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B9BCEBEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 01:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C31A19A56F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 23:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632AF27D780;
	Fri, 10 Oct 2025 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiYDjOjN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328727CB0A
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760138090; cv=none; b=sE3QK3t9PR0T7yFuyMwWp5CT4/o54Emd7kTnr/8V28CIo67XA8t/MI+6D7Uq5sQQNcLO7O6yzeLmflEoZQ8pr3tsQfRi4YXqdnsKE0FEhe2aYADwsNPJwhhC+5gOxQzjM0aT/+NvDkZ23cjfgS6lRDBC8LfxXLNZLjhEwkVj3x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760138090; c=relaxed/simple;
	bh=KEKKk6F6HfJdCsFCzEsEQyZzDxLvPlGovl7/35gC91w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWaPxIlLdIIVnwi7do4yv8qR1PsMzZyxnyWDm3HJY6X/caYnuoWi0hZUaODKWoM29N74ilEGaJA46OhRhHARdXnrsP5tYJKTURKqbwg5X6Hx8SVExh2nliMGhOWIpwe5H1E5V1kUq9R/kRxqSWrLrsQyiAcxf+ZmUn2x+WjmH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiYDjOjN; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-85d02580a07so312016485a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760138086; x=1760742886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LvEpU+6fERfT/zdqMwqYod3TzOdm6We4ztTem1gKU0=;
        b=OiYDjOjNkgOdfK+gdru4nuS6kRr5nh9sTTyRK+aklFK25xrdT/YHntO5/CpHpEDj9T
         ywB2fneo/qwJkXJuy9L1RNj7XBkyyDkm1+wPXi17RMRPtOdlPpj6CzsGkFBJWU0dUhXh
         zFjjBdarmy+tWwLvIctK2xra9RgDvyVeJl9X1gQZVhN2Hrqbp23CaQg5TqH1EekCAQV/
         uzH6YEobt+8oxeMoTaL9ktQzV+O8hJVP5jHWqnRIR7d6/maIXtQdE84Ss01h/xu5gZvy
         zZ7qtFpQz6y6yxojNLopRqobkGgd0m52rLrsDJ1UWzN2TbIrPhhWEoVWtCJSwFa/bjGN
         FGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760138086; x=1760742886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LvEpU+6fERfT/zdqMwqYod3TzOdm6We4ztTem1gKU0=;
        b=JP21OsXaje2UqhrzAdlKvQTIMgwv5DRNF/O2Pjda3VdRrCOQozD5kPN0geMtECYXdZ
         8C3v0crncWZwuO3ONY8/3xArwOk1q4thlTuBTUPIkWoXbXGHiOCPWbMpERl0jRSzpqOM
         7m8XYvig4LYA/91lLUGRMG8JUaoxIu6Skapycdzyx4OV3HmjhXUWtZkhRhPC+ANUIm93
         MrgcpBUsoHIjpNXYFtPI3sTbIp3U/4uV9ouYieyrn3c/MogvCFpGfV88no49Ek0C2eXg
         6Ekgn60wItAcKyic91d6QEL/j/LKqUlGz8a9eGo9kPJNhUnH1WsU7umn9EdJZWJ7rJ/P
         C4aA==
X-Forwarded-Encrypted: i=1; AJvYcCVbq+vi0iK8LEPrkkCMiMM6V4F+uvVysU5rw/adx0sPI82eUcCrT7jH27kzYsEp6tB3eyWHtOABW04kpdZk@vger.kernel.org
X-Gm-Message-State: AOJu0YwpRvDMYKdUi4gl7Jx8XTwYXDCJLJsG2EeuGX0H+jUCVwSlKAp7
	EkOl0GULsVrDBA1Y+yabsIBe+1OjrwH/eznWhboT9f7j/5BrhKLdW5mAa++PVFBg/N4DN1nHsh9
	y3D/oycsbfWMCHrr+ED5qXAAu1+gG5EE=
X-Gm-Gg: ASbGnct4U0SXrGxxdnxaF2HRcGGxu1byFjLZh+nA8byvsao74fJZyo4duHIA7yBPegE
	l6gNWk3qbAVbtdO+dTt6GpHcB4zdDuZtjDBKAHOqSB63BJp9uj3mgaWZWdaqw6x24wxp5Jwp4cK
	Ivp8Yvi8QkrWWJWwiIPrXOzmoLJa5Tt9CzwKyl67D5odijMvglPqpf2jl4stcZql5q+2c1YYGSw
	Bca6SQHq+AK8fzLJxD/oxTT8vp4n7GSp1uLWupzzY42BfaYZHZytRiBcpoMToquNSby
X-Google-Smtp-Source: AGHT+IEU/4C+F4HvGvxeypRAg5QWm2jwt7z1osXRzNqEuPpnBX939DQYJYagREul4kMLZRD+btxx8qCF4I0/5eT/KYs=
X-Received: by 2002:ac8:5f0e:0:b0:4cf:1eba:f30d with SMTP id
 d75a77b69052e-4e6de86ab3dmr234415191cf.23.1760138085787; Fri, 10 Oct 2025
 16:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com> <20251010150113.GC6174@frogsfrogsfrogs>
In-Reply-To: <20251010150113.GC6174@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 10 Oct 2025 16:14:34 -0700
X-Gm-Features: AS18NWB0_PLEOWPGs1r8gAmO4IaVuQ_nq0Q7wucN7XhYVDKMuw7zk6MK5hWB3Yo
Message-ID: <CAJnrk1bXvUF2=tfTxMuxFwqQ03uEMrDhDsdo33R0OaXFQk9ucw@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 8:01=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> [cc willy in case he has opinions about dynamically changing the
> pagecache order range]
>
> On Thu, Oct 09, 2025 at 11:36:30AM -0700, Joanne Koong wrote:
> > On Thu, Oct 9, 2025 at 7:17=E2=80=AFAM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> > >
> > > On Wed, 8 Oct 2025 at 22:42, Joanne Koong <joannelkoong@gmail.com> wr=
ote:
> > >
> > > > Since fuse now uses proper writeback accounting without temporary p=
ages,
> > > > strictlimiting is no longer needed. Additionally, for fuse large fo=
lio
> > > > buffered writes, strictlimiting is overly conservative and causes
> > > > suboptimal performance due to excessive IO throttling.
> > >
> > > I don't quite get this part.  Is this a fuse specific limitation of
> > > stritlimit vs. large folios?
> > >
> > > Or is it the case that other filesystems are also affected, but
> > > strictlimit is never used outside of fuse?
> >
> > It's the combination of fuse doing strictlimiting and setting the bdi
> > max ratio to 1%.
> >
> > I don't think this is fuse-specific. I ran the same fio job [1]
> > locally on xfs and with setting the bdi max ratio to 1%, saw
> > performance drops between strictlimiting off vs. on
> >
> > [1] fio --name=3Dwrite --ioengine=3Dsync --rw=3Dwrite --bs=3D256K --siz=
e=3D1G
> > --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1
>
> Er... what kind of numbers? :)
>

When I tested it earlier this week it was on a VM but testing it on an
actual machine, this is what I'm seeing:

 echo 4294967296 > /proc/sys/vm/dirty_bytes # 4GB
 echo 2147483648 > /proc/sys/vm/dirty_background_bytes # 2GB

 fio --name=3Dwrite --ioengine=3Dsync --rw=3Dwrite --bs=3D512K --size=3D2G
--numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1

default (no strictlimiting and max_ratio set to 100):
         around 1600 to 1800 MiB/s
strictlimiting on and max_ratio set to 1:
         around 1050 MiB/s


On systems with a lot of RAM where /proc/sys/vm/dirty_bytes is high
enough, we don't see the performance drop. But 4 GB seemed like a
reasonable value for /proc/sys/vm/dirty_bytes as that implies 20 GB of
RAM (as I understand it, the default /proc/sys/vm/dirty_ratio value is
usually set to 20% of system ram).

> > >
> > > > Administrators can still enable strictlimiting for specific fuse se=
rvers
> > > > via /sys/class/bdi/*/strict_limit. If needed in the future,
> > >
> > > What's the issue with doing the opposite: leaving strictlimit the
> > > default and disabling strictlimit for specific servers?
> >
> > If we do that, then we can't enable large folios for servers that use
> > the writeback cache. I don't think we can just turn on large folios if
>
> What's the limitation on strictlimit && large_folios?  Is it just the
> throttling problem because dirtying a single byte in a 2M folio charges
> the process with all 2M?  Or something else?

With strictlimiting on, the throttling threshold is a lot more
conservative. When large folios are used, a larger number of pages are
dirtied per write at once and not incrementally balanced, which causes
the logic in balance_dirty_pages() to schedule io waits, whereas small
folios don't have this issue because they incrementally balance pages
as they write them back. This thread has a lot more context:
https://lore.kernel.org/linux-fsdevel/Z1N505RCcH1dXlLZ@casper.infradead.org=
/T/#m9e3dd273aa202f9f4e12eb9c96602b5fec2d383d

The dirtying a single byte in a 2M folio should also imo be addressed,
eg through the followup to [1], but when strictlimiting is off, this
is much less of an issue since the threshold is higher.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/5qgjrq6l627byybxjs6vzouspeqj6hdrx=
2ohqbxqkkjy65mtz5@zp6pimrpeu4e/T/#med8769e865e98960b1f504375cb1c0c2c3bdea51

