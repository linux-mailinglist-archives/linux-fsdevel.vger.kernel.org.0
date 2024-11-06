Return-Path: <linux-fsdevel+bounces-33786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB39BF01A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 15:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B5028582B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD95201256;
	Wed,  6 Nov 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20230601.gappssmtp.com header.i=@owltronix-com.20230601.gappssmtp.com header.b="K0ELk7ZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC3F20127C
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903200; cv=none; b=RikdCvqY7wnCDvLoHJqrQML21K4MwOd01Bxf7KEJjSS3WipAst2juclm5jsmcHcK5BnfbkhX0g5CzhvH3f3oFqV9qs3nALZOOoasgPfqxS8+hEAtT2Oq/N01Xo6xQSN7NY2wRdaUz8Pwv/2clT2P5q6B2aCzLL/3nahE3dMhhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903200; c=relaxed/simple;
	bh=ipqB5GhZfhZeP6+Fw73KMpW7vTqNOHY4wT9od9XDnNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HU7TLHq9E8OtSEuzZig3797UoF/AxVhraWLERVKKq1y+6kvvCTRS4uww0NhkETcNfLTOnCaz4z9orz7V7XB6T3Mzn4zLQPUDO3TdBY+IdaUPoNwbn+/T+6lDA2VNnE/AXodLFf9Uy303Ar3M4CtOYDagQeChis/pMclulnU1T5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com; spf=none smtp.mailfrom=owltronix.com; dkim=pass (2048-bit key) header.d=owltronix-com.20230601.gappssmtp.com header.i=@owltronix-com.20230601.gappssmtp.com header.b=K0ELk7ZO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=owltronix.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a850270e2so1129367866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Nov 2024 06:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20230601.gappssmtp.com; s=20230601; t=1730903197; x=1731507997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipqB5GhZfhZeP6+Fw73KMpW7vTqNOHY4wT9od9XDnNU=;
        b=K0ELk7ZOqojBpwfYYFVtlhrgVqwWO9F5XOz+slzrpH7whuThi5sFINpU1Uz2YObfRL
         RdopoaQbBe9AIueM/xK9qkRcpHa4xbkp9sQ1ZgrPkDzzmE6dLuYVXBoLaa6zn4ZF0Por
         aMkFouowSW3zErpN1orbPemdy6YLrb8rvl6H36Mru773Dx3Alieh0RZkjYs3iM53nH21
         8dKWaSlRjYHBC2QXhw1BILFPGFrs3nbW/kufRc7QIZUFCc7FI/o1OFoXFUAe2c9bWdp/
         qg5rqdNPPloEYVDahsor2ScfawUvljWuiK9BhvMKOazWXD1ys8NY8ELcl7iP6fOW5snV
         Y5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730903197; x=1731507997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipqB5GhZfhZeP6+Fw73KMpW7vTqNOHY4wT9od9XDnNU=;
        b=PBNhEZglGDwddAXcYEhY/moIpxslxtb1Ql8JpdW9UjXKg345L+UJ/9AxglLVaXBtyS
         ubSXvL4R761+bqkEL9u/SskqCG1v2mbQ7WYWia5CaLj3PbuI9RALgxWtUt+eWTMtPiIb
         Kd3quOfyp/t9uke3ltbRqfO3N7wUV6WlOEBxU5ssWsWdGDYrZfTDcCK2f/csh1xWdjas
         nIBWTqEXjpuC4lNmQ3fUj3VHJ3pw+3wZn4VZKGiHrs0icBTMiEBWWl7Czn80zYDVsG2v
         bpVoyLLhbDfp5bo57VPsUwLSYgpvyNRJQG1m9W40QOfaduB/Mhm71Z4yLLXg73XICWjY
         XGrw==
X-Forwarded-Encrypted: i=1; AJvYcCWs29rGEl9tCLquSGUSYT+paw5OWUD3NMuK64/j6k/8S8ju675e1GB+Kn9jKJzHT47o0B+afwct0JuVzvlJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwFiWFiFwZthLVoMmeC0HvLZpA9ztdQiyjDFdOKm4iqm/CR6eep
	mPB3X1ICj32M/L8z8EA27qPpdE86L7Nv8aaVAGboLefjMwMMWiEpY3reErT8ovYUZqYrUsmHx+J
	s9mEUiNisMpF9GXWLLjLDr6KwTgerOK7rR7mE/g==
X-Google-Smtp-Source: AGHT+IGTNjawymGmZtRv6kzFPFouB6jfAmX0w1MWjwjaaSmC15ADSV9RR263VUeTaevgARYiFWCXry3+rk2bBInzbBw=
X-Received: by 2002:a17:907:2dac:b0:a99:6791:5449 with SMTP id
 a640c23a62f3a-a9e6587df7fmr2121988466b.52.1730903196776; Wed, 06 Nov 2024
 06:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com>
 <20241030154556.GA4449@lst.de> <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com>
 <20241030155052.GA4984@lst.de> <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com>
 <20241030165708.GA11009@lst.de> <ZyK0GS33Qhkx3AW-@kbusch-mbp.dhcp.thefacebook.com>
 <CANr-nt35zoSijRXYr+ommmWGfq0+Ye0tf3SfHfwi0cfpvwB0pg@mail.gmail.com>
 <ZyOO4PojaVIdmlOA@kbusch-mbp.dhcp.thefacebook.com> <CANr-nt30gQzFFsnJt9Tzs1kRDWSj=2w0iTC1qYfu+7JwpszwQQ@mail.gmail.com>
 <ZyTqZ3UR39VTHSA2@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZyTqZ3UR39VTHSA2@kbusch-mbp.dhcp.thefacebook.com>
From: Hans Holmberg <hans@owltronix.com>
Date: Wed, 6 Nov 2024 15:26:25 +0100
Message-ID: <CANr-nt0stXUn38EawwQPa+fGmgvHE7Ch8LH7tGyNp5NPpm1m0w@mail.gmail.com>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, 
	javier.gonz@samsung.com, bvanassche@acm.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 3:49=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Fri, Nov 01, 2024 at 08:16:30AM +0100, Hans Holmberg wrote:
> > On Thu, Oct 31, 2024 at 3:06=E2=80=AFPM Keith Busch <kbusch@kernel.org>=
 wrote:
> > > On Thu, Oct 31, 2024 at 09:19:51AM +0100, Hans Holmberg wrote:
> > > > No. The meta data IO is just 0.1% of all writes, so that we use a
> > > > separate device for that in the benchmark really does not matter.
> > >
> > > It's very little spatially, but they overwrite differently than other
> > > data, creating many small holes in large erase blocks.
> >
> > I don't really get how this could influence anything significantly.(If =
at all).
>
> Fill your filesystem to near capacity, then continue using it for a few
> months. While the filesystem will report some available space, there
> may not be many good blocks available to erase. Maybe.

For *this* benchmark workload, the metadata io is such a tiny fraction
so I doubt the impact on wa could be measured.
I completely agree it's a good idea to separate metadata from data
blocks in general. It is actually a good reason for letting the file
system control write stream allocation for all blocks :)

> > I believe it would be worthwhile to prototype active fdp data
> > placement in xfs and evaluate it. Happy to help out with that.
>
> When are we allowed to conclude evaluation? We have benefits my
> customers want on well tested kernels, and wish to proceed now.

Christoph has now wired up prototype support for FDP on top of the
xfs-rt-zoned work + this patch set, and I have had time to look over
it and started doing some testing on HW.
In addition to the FDP support, metadata can also be stored on the
same block device as the data.

Now that all placement handles are available, we can use the full data
separation capabilities of the underlying storage, so that's good.
We can map out the placement handles to different write streams much
like we assign open zones for zoned storage and this opens up for
supporting data placement heuristics for a wider range use cases (not
just the RocksDB use case discussed here).

The big pieces that are missing from the FDP plumbing as I see it is
the ability to read reclaim unit size and syncing up the remaining
capacity of the placement units with the file system allocation
groups, but I guess that can be added later.

I've started benchmarking on the hardware I have at hand, iterating on
a good workload configuration. It will take some time to get to some
robust write amp measurements since the drives are very big and
require a painfully long warmup time.

