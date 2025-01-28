Return-Path: <linux-fsdevel+bounces-40208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81909A20668
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 09:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC52188A4C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606641DE8A3;
	Tue, 28 Jan 2025 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20230601.gappssmtp.com header.i=@owltronix-com.20230601.gappssmtp.com header.b="qaaDxfu/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33C9C2ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053947; cv=none; b=s4B8HXOLEDZeKpdz9/tzWj3mMbtOlZIWhdON/A23BYWVMOhdKEBusjMHiW3V8SFXdUFM1zavGSFoNooIMoC+EeLV/K6TZbST42MuGHJOeiL6CkWYjxHwLpz0/1vpdJu0spl2F8hGRrQpmqH5S9hIxDWyOQEkHg/mtJTGOJia+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053947; c=relaxed/simple;
	bh=K8lMLxYfwOiPXDnUH0ZzdUsP5+IZz3pZ5gqlNQPG4ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOfXVEphxPRee0S98M9SLOGrEca2WSsyW46yDGMBkqqpKYGFmnMLQ4sAOOJGMPu/1oSSk4L7YnNXbzVo8YBu0+d9AfaqCjcjFuBc4NDzJ+V6pf95FaJX8B4WCAtvYfUKFFgsKpDmohc+h0JPXEi8sBazbZBMQ3uoT7JbAqxIfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com; spf=none smtp.mailfrom=owltronix.com; dkim=pass (2048-bit key) header.d=owltronix-com.20230601.gappssmtp.com header.i=@owltronix-com.20230601.gappssmtp.com header.b=qaaDxfu/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=owltronix.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso1070804466b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 00:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20230601.gappssmtp.com; s=20230601; t=1738053943; x=1738658743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi1PDYct20yoCac+m36vvt1TMeZnhSDK67+M1pJQBfg=;
        b=qaaDxfu/82eAZdy3JC09PfVmoCpORxGUcH7AFa+mkrU+lprO0xVpodZv8rodX+lyNZ
         2c7HJbxrd9PfkJ7YgYbe9J+csp3PnLYVp0vrtSIuApF06OEcaoFLFKAqJNttckQiKSrO
         mkSrPYy2PL59EeEHznIAQq/zAHybvKj31SH1Oaj0XUUroGYzdWMzDMHATamskjAcSJjO
         CxPLyOflncmfABNcApwblaVuKzuG0JInZwOJ1jVcMyio7NXojqsu3zLvGTlA5ZoESLzT
         Lg+5VmqccyppCsPGA9ZlH11j2C4nQOQcpYhk2cFpWAMtGaCWsR+UyJTXe3G5pZot45qo
         J0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738053943; x=1738658743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hi1PDYct20yoCac+m36vvt1TMeZnhSDK67+M1pJQBfg=;
        b=AfQmlKieCw6KrDW18sJc7kVtGYPX9gop0rSLhZ7c77ru9koIxEt6d7U3AIsEnUUV8t
         BkwVBx38EwbSLBZi8v38MTJ+V9ZLT3mA8tlxwI32zLY3gl3EG+AhgAGdoN+CVP/u1m0t
         6ZMWVXPrY13of8gvpMREQYsW3oZV38aT7dWZLwaAZQAvUfz/icotNbAbGWiHPhuXKL4y
         8dg+0A/eB7Sdzeg6l6Y/qrNZmHHWKB9mxnEoOJWecmfAY+2K6Tfe8LqX63eosByMecQt
         354ZgKfxpvdTZkq0r8g8tgt8d1o07P8Pfx6oVmXWidGNDslqBukU4YI/Mj4bc3FMPOwR
         Ec7g==
X-Forwarded-Encrypted: i=1; AJvYcCUili0xLGZhKmdE/Bu+35P961r51RQs+ztzpDTJP3tZuuvkj9l3df03oWzDcHyQBFU1A+zVNUFuTCu8SrI4@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdRW95uTZ0PHw6iO/unoHJ7u5ESz5cvAvSa1WKKIzfJ6oDm6G
	p1uFmrS6JShv6u5eSIgpyZIgc8TzdGBTdLntFks+yLOcVlseNJ+xATKGYiA4q2qfNJXEnTWpne5
	rXYvb2eaiMv8I44zDn8kLhjLiWFsietXH+KMQCuUOP+981hm9N6c=
X-Gm-Gg: ASbGncuGdO9nIGaJK/hIydzoSRVkvHrbdpMx+NMKq4+5tkGGK4tQYoCkrOab3UIPXWL
	JaGP8ccO3j9+dwSNK9qt0AcDWc9bdSotpeWGq6gm7rrPb8IzdpNPQgylnc9iMu9mCGq733mHP
X-Google-Smtp-Source: AGHT+IHAGnRsTwVr80LuhfGtSL3RBmru+u3FKvFsIpw7jjpy58rmVEPdwza58ZSzMeDSjBCXWVedDCMIGGLbazAG350=
X-Received: by 2002:a17:907:1c2a:b0:aac:832:9bf7 with SMTP id
 a640c23a62f3a-ab38b27be47mr3909003166b.24.1738053942699; Tue, 28 Jan 2025
 00:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123202455.11338-1-slava@dubeyko.com> <fd012640-5107-4d44-9572-4dffb2fd4665@wdc.com>
 <f44878932fd26bb273c7948710b23b0e2768852a.camel@ibm.com> <CANr-nt2+Yk5fVVjU2zs+F1ZrLZGBBy3HwNOuYOK9smDeoZV9Rg@mail.gmail.com>
 <063856b9c67289b1dd979a12c8cfe8d203786acc.camel@ibm.com>
In-Reply-To: <063856b9c67289b1dd979a12c8cfe8d203786acc.camel@ibm.com>
From: Hans Holmberg <hans@owltronix.com>
Date: Tue, 28 Jan 2025 09:45:30 +0100
X-Gm-Features: AWEUYZkCjn7l1RjVmW25YZJ8K7woj0q0aPOGpEvKeH8Ngm4K4rQxLrNq_zx5pTo
Message-ID: <CANr-nt2bbienm=L48uEgjmuLqMnFBXUfHVZfEo3VBFwUsutE6A@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce generalized data temperature estimation framework
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 9:59=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Mon, 2025-01-27 at 15:19 +0100, Hans Holmberg wrote:
> > On Fri, Jan 24, 2025 at 10:03=E2=80=AFPM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > >
> > > On Fri, 2025-01-24 at 08:19 +0000, Johannes Thumshirn wrote:
> > > > On 23.01.25 21:30, Viacheslav Dubeyko wrote:
> > > > > [PROBLEM DECLARATION]
> > > > > Efficient data placement policy is a Holy Grail for data
> > > > > storage and file system engineers. Achieving this goal is
> > > > > equally important and really hard. Multiple data storage
> > > > > and file system technologies have been invented to manage
> > > > > the data placement policy (for example, COW, ZNS, FDP, etc).
> > > > > But these technologies still require the hints related to
> > > > > nature of data from application side.
> > > > >
> > > > > [DATA "TEMPERATURE" CONCEPT]
> > > > > One of the widely used and intuitively clear idea of data
> > > > > nature definition is data "temperature" (cold, warm,
> > > > > hot data). However, data "temperature" is as intuitively
> > > > > sound as illusive definition of data nature. Generally
> > > > > speaking, thermodynamics defines temperature as a way
> > > > > to estimate the average kinetic energy of vibrating
> > > > > atoms in a substance. But we cannot see a direct analogy
> > > > > between data "temperature" and temperature in physics
> > > > > because data is not something that has kinetic energy.
> > > > >
> > > > > [WHAT IS GENERALIZED DATA "TEMPERATURE" ESTIMATION]
> > > > > We usually imply that if some data is updated more
> > > > > frequently, then such data is more hot than other one.
> > > > > But, it is possible to see several problems here:
> > > > > (1) How can we estimate the data "hotness" in
> > > > > quantitative way? (2) We can state that data is "hot"
> > > > > after some number of updates. It means that this
> > > > > definition implies state of the data in the past.
> > > > > Will this data continue to be "hot" in the future?
> > > > > Generally speaking, the crucial problem is how to define
> > > > > the data nature or data "temperature" in the future.
> > > > > Because, this knowledge is the fundamental basis for
> > > > > elaboration an efficient data placement policy.
> > > > > Generalized data "temperature" estimation framework
> > > > > suggests the way to define a future state of the data
> > > > > and the basis for quantitative measurement of data
> > > > > "temperature".
> > > > >
> > > > > [ARCHITECTURE OF FRAMEWORK]
> > > > > Usually, file system has a page cache for every inode. And
> > > > > initially memory pages become dirty in page cache. Finally,
> > > > > dirty pages will be sent to storage device. Technically
> > > > > speaking, the number of dirty pages in a particular page
> > > > > cache is the quantitative measurement of current "hotness"
> > > > > of a file. But number of dirty pages is still not stable
> > > > > basis for quantitative measurement of data "temperature".
> > > > > It is possible to suggest of using the total number of
> > > > > logical blocks in a file as a unit of one degree of data
> > > > > "temperature". As a result, if the whole file was updated
> > > > > several times, then "temperature" of the file has been
> > > > > increased for several degrees. And if the file is under
> > > > > continous updates, then the file "temperature" is growing.
> > > > >
> > > > > We need to keep not only current number of dirty pages,
> > > > > but also the number of updated pages in the near past
> > > > > for accumulating the total "temperature" of a file.
> > > > > Generally speaking, total number of updated pages in the
> > > > > nearest past defines the aggregated "temperature" of file.
> > > > > And number of dirty pages defines the delta of
> > > > > "temperature" growth for current update operation.
> > > > > This approach defines the mechanism of "temperature" growth.
> > > > >
> > > > > But if we have no more updates for the file, then
> > > > > "temperature" needs to decrease. Starting and ending
> > > > > timestamps of update operation can work as a basis for
> > > > > decreasing "temperature" of a file. If we know the number
> > > > > of updated logical blocks of the file, then we can divide
> > > > > the duration of update operation on number of updated
> > > > > logical blocks. As a result, this is the way to define
> > > > > a time duration per one logical block. By means of
> > > > > multiplying this value (time duration per one logical
> > > > > block) on total number of logical blocks in file, we
> > > > > can calculate the time duration of "temperature"
> > > > > decreasing for one degree. Finally, the operation of
> > > > > division the time range (between end of last update
> > > > > operation and begin of new update operation) on
> > > > > the time duration of "temperature" decreasing for
> > > > > one degree provides the way to define how many
> > > > > degrees should be subtracted from current "temperature"
> > > > > of the file.
> > > > >
> > > > > [HOW TO USE THE APPROACH]
> > > > > The lifetime of data "temperature" value for a file
> > > > > can be explained by steps: (1) iget() method sets
> > > > > the data "temperature" object; (2) folio_account_dirtied()
> > > > > method accounts the number of dirty memory pages and
> > > > > tries to estimate the current temperature of the file;
> > > > > (3) folio_clear_dirty_for_io() decrease number of dirty
> > > > > memory pages and increases number of updated pages;
> > > > > (4) folio_account_dirtied() also decreases file's
> > > > > "temperature" if updates hasn't happened some time;
> > > > > (5) file system can get file's temperature and
> > > > > to share the hint with block layer; (6) inode
> > > > > eviction method removes and free the data "temperature"
> > > > > object.
> > > >
> > > > I don't want to pour gasoline on old flame wars, but what is the
> > > > advantage of this auto-magic data temperature framework vs the exis=
ting
> > > > framework?
> > > >
> > >
> > > There is no magic in this framework. :) It's simple and compact frame=
work.
> > >
> > > >  'enum rw_hint' has temperature in the range of none, short,
> > > > medium, long and extreme (what ever that means), can be set by an
> > > > application via an fcntl() and is plumbed down all the way to the b=
io
> > > > level by most FSes that care.
> > >
> > > I see your point. But the 'enum rw_hint' defines qualitative grades a=
gain:
> > >
> > > enum rw_hint {
> > >         WRITE_LIFE_NOT_SET      =3D RWH_WRITE_LIFE_NOT_SET,
> > >         WRITE_LIFE_NONE         =3D RWH_WRITE_LIFE_NONE,
> > >         WRITE_LIFE_SHORT        =3D RWH_WRITE_LIFE_SHORT,  <-- HOT da=
ta
> > >         WRITE_LIFE_MEDIUM       =3D RWH_WRITE_LIFE_MEDIUM, <-- WARM d=
ata
> > >         WRITE_LIFE_LONG         =3D RWH_WRITE_LIFE_LONG,   <-- COLD d=
ata
> > >         WRITE_LIFE_EXTREME      =3D RWH_WRITE_LIFE_EXTREME,
> > > } __packed;
> > >
> > > First of all, again, it's hard to compare the hotness of different fi=
les
> > > on such qualitative basis. Secondly, who decides what is hotness of a=
 particular
> > > data? People can only guess or assume the nature of data based on
> > > experience in the past. But workloads are changing and evolving
> > > continuously and in real-time manner. Technically speaking, applicati=
on can
> > > try to estimate the hotness of data, but, again, file system can rece=
ive
> > > requests from multiple threads and multiple applications. So, applica=
tion
> > > can guess about real nature of data too. Especially, nobody would lik=
e
> > > to implement dedicated logic in application for data hotness estimati=
on.
> > >
> > > This framework is inode based and it tries to estimate file's
> > > "temperature" on quantitative basis. Advantages of this framework:
> > > (1) we don't need to guess about data hotness, temperature will be
> > > calculated quantitatively; (2) quantitative basis gives opportunity
> > > for fair comparison of different files' temperature; (3) file's tempe=
rature
> > > will change with workload(s) changing in real-time; (4) file's
> > > temperature will be correctly accounted under the load from multiple
> > > applications. I believe these are advantages of the suggested framewo=
rk.
> > >
> >
> > While I think the general idea(using file-overwrite-rates as a
> > parameter when doing data placement) could be useful, it could not
> > replace the user space hinting we already have.
> >
> > Applications(e.g. RocksDB) doing sequential writes to files that are
> > immutable until deleted(no overwrites) would not benefit. We need user
> > space help to estimate data lifetime for those workloads and the
> > relative write lifetime hints are useful for that.
> >
>
> I don't see any competition or conflict here. Suggested approach and user=
-space
> hinting could be complementary techniques. If user-space logic would like=
 to use
> a special data placement policy, then it can share hints in its own way. =
But,
> potentially, suggested approach of temperature calculation can be used to=
 check
> the effectiveness of the user-space hinting, and, maybe, correcting it. S=
o, I
> don't see any conflict here.

I don't see a conflict here either, my point is just that this
framework cannot replace the user hints.

>
> > So what I am asking myself is if this framework is added, who would
> > benefit? Without any benchmark results it's a bit hard to tell :)
> >
>
> Which benefits would you like to see? I assume we would like: (1) prolong=
 device
> lifetime, (2) improve performance, (3) decrease GC burden. Do you mean th=
ese
> benefits?

Yep, decreased write amplification essentially.

>
> As far as I can see, different file systems can use temperature in differ=
ent
> way. And this is slightly complicates the benchmarking. So, how can we de=
fine
> the effectiveness here and how can we measure it? Do you have a vision he=
re? I
> am happy to make more benchmarking.
>
> My point is that the calculated file's temperature gives the quantitative=
 way to
> distribute even user data among several temperature groups ("baskets"). A=
nd
> these baskets/segments/anything-else gives the way to properly group data=
. File
> systems can employ the temperature in various ways, but it can definitely=
 helps
> to elaborate proper data placement policy. As a result, GC burden can be
> decreased, performance can be improved, and lifetime device can be prolon=
g. So,
> how can we benchmark these points? And which approaches make sense to com=
pare?
>

To start off, it would be nice to demonstrate that write amplification
decreases for some workload when the temperature is taken into
account. It would be great if the workload would be an actual
application workload or a synthetic one mimicking some real-world-like
use case.
Run the same workload twice, measure write amplification and compare result=
s.

What user workloads do you see benefiting from this framework? Which would =
not?

> > Also, is there a good reason for only supporting buffered io? Direct
> > IO could benefit in the same way, right?
> >
>
> I think that Direct IO could benefit too. The question here how to accoun=
t dirty
> memory pages and updated memory pages. Currently, I am using
> folio_account_dirtied() and folio_clear_dirty_for_io() to implement the
> calculation the temperature. As far as I can see, Direct IO requires anot=
her
> methods of doing this. The rest logic can be the same.

It's probably a good idea to cover direct IO as well then as this is
intended to be a generalized framework.

