Return-Path: <linux-fsdevel+bounces-53899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD3BAF8866
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 09:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A106C7A409D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 07:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A425A27144B;
	Fri,  4 Jul 2025 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFjtH0J3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E607263F4A;
	Fri,  4 Jul 2025 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612588; cv=none; b=PHWdffFThYu/wTzjU+z5WO3CrsxgZLLoRAkcpH9vFt/djvq/Ba2OMd2QOq4b3ENJOHuE3QIydqevvVG7k4lP4eatCRS7YfHR/91vcKra8On3jBCFVmQqMR+nHsUS6i6XTS71m3jrNNjH98wDgsu5V7bujH/tcYq2xTTyWHOI0VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612588; c=relaxed/simple;
	bh=FAT2JYkIVleheVO+4inwuHTSq5weBsTjw+VPUDu2v5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LB/hzO9YAvKjevYXaRqTet9hzV5wM0LUzmGf09eNKgmmZsz4cfuGvZ9Kr1OX6RIjaP9l0lZBrV28bRuvDdZgzZ36JOTqdDR0RxZ1bEPdanTWU0eC1SZZP+/3J1mL5lJ05XZA72lp1d9/xCRIVDbYgQ/ZG/UB0ykw3sXus8LE9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFjtH0J3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae3b336e936so117764866b.3;
        Fri, 04 Jul 2025 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751612585; x=1752217385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaqZISU/6/J0dA6aXHHwQAgG0zenTBPemNnfGP8tRRw=;
        b=eFjtH0J3c4krziISuy1vAOyGoCktexAKoJ/sqe1zuCXOb6UbROhtg97oQM57tG67rD
         QhuQ98mEtkLjMim3BRweUEsoLKBFaXIfBRoi7l7rffOITIqevgP1bhLwGlbOnp6oOCtF
         1ZRQzKSEtQCDSNouAw4rrg3Jh37ncpml67bPZWy4Pr+Ze6sAxl+Pz8Kh+621npCChWPd
         VpvkqmS0gorb/NFaPktCJfkFn0+fBwlT2TbPMInMuFxLAuKYgVA9JlQ8eUtll6ypgfzR
         ALboO4OlNlYdQflc+W8RcG4vURCIrR+C+H2c+b5xBP0v8w00LQIYB2XVJ+LWAvT+S9zX
         E7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612585; x=1752217385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaqZISU/6/J0dA6aXHHwQAgG0zenTBPemNnfGP8tRRw=;
        b=CdkKVNeqnsYAa+bf87f9EooOItPYpFXVt5MHknpTepj1wK9Uj8TJSbeA2LgNmlwkm1
         1h8uQ1n1wd6nU+o95+CW9oTCnhixPDVlHRySoJhuiOVy8v5gYqZiC3qFhI4L48ph08Fu
         PxBah442h73ksZKzGV6y32pb68XnBYzkfcov8J2xwW/Ez7+q7FnT4W76cxaN0jNUIW4G
         zbMVJNXI0xMVJxwoHTXZGpzcSiSX/moTNzxG+IHRCg3Re2FHxIsNc9+9mWCNOmEqRNv4
         Xr1NoRXFN2/C43xUrBf5cm2B8wAmJ0txcMsVG39L4ej3dwZCiX614vGtRH9H9o870aPt
         ofFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp1pxRbiMahAmb0oqQMN+L43t7W6HjJ/rCqJrBjp454cSuv8E5TtnbLEFRvl+jAvZrCxKdMBDIPJvT@vger.kernel.org, AJvYcCVpNqlrK7a1drE+8RQbSZ9bm7BYxd4fQGWstpgKyMCgqQZu3q8xCKj6wmx2U7a0+IQNz4O9i+ZhZEq0BPHx@vger.kernel.org
X-Gm-Message-State: AOJu0YwbArURoR0LM3OMHtDuU7KAs/QAJSaY4oPtg9CZLzECWWRdXC30
	Ft9bKpvGOI+EnfyRX0pQJfdr6tI1XbhKDsPz902LVYNGu1y7s+tEWBhoQ6+Kic5HRR4+hnOUlf6
	/0WASOLndxmw0KNF15jhHzIqHZ65Na0w=
X-Gm-Gg: ASbGncvBJ64zSg59Lp6A0NyDM8QhZkQCojKO/ioh02PNp8JmrQ663r0gz1o12k1WxGg
	G3ql9Ll1oV3rNhg1UPSMlARizx6R+mzlZyNyOryafUZBAkKsoNRLA1QWoH+GLn6dIZHrCzrItN/
	6iGJkWBlphtJAyUHiyWTmHubx65Qu9LNHTpoASlnZ6PcTQ1eVovUyr9Fn19+JEhvrXm1tS7csWr
	vcon/rC1rYeK+Ar
X-Google-Smtp-Source: AGHT+IFH2+aa5C0AYTaAo7ldMEn47RrhFOI48HXYOTWtH8oGOiUW5l/So1Lz10mwcD0zFkQkk89KO90EiAPC2WiMYa4=
X-Received: by 2002:a17:907:728e:b0:ae0:a813:1bc0 with SMTP id
 a640c23a62f3a-ae3fe78f7aemr85654066b.53.1751612584190; Fri, 04 Jul 2025
 00:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com> <20250529203708.9afe27783b218ad2d2babb0c@linux-foundation.org>
 <CALYkqXqs+mw3sqJg5X2K4wn8uo8dnr4uU0jcnnSTbKK9F4AiBA@mail.gmail.com>
 <20250702184312.GC9991@frogsfrogsfrogs> <20250703130500.GA23864@lst.de>
In-Reply-To: <20250703130500.GA23864@lst.de>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Fri, 4 Jul 2025 12:32:51 +0530
X-Gm-Features: Ac12FXwZOjAgWNZaCPF5YBUk5PhxDjzykQsiKelmwtL0Fjc6XgS6xeUIPE87xdw
Message-ID: <CALYkqXqE1dJj7Arqu_Zi4J5mTVhzJQt=kzwjS9QaY5VaFcV3Lg@mail.gmail.com>
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, chao@kernel.org, 
	viro@zeniv.linux.org.uk, Christian Brauner <brauner@kernel.org>, jack@suse.cz, 
	miklos@szeredi.hu, agruenba@redhat.com, Trond Myklebust <trondmy@kernel.org>, 
	anna@kernel.org, Matthew Wilcox <willy@infradead.org>, mcgrof@kernel.org, clm@meta.com, 
	david@fromorbit.com, amir73il@gmail.com, Jens Axboe <axboe@kernel.dk>, 
	ritesh.list@gmail.com, dave@stgolabs.net, p.raghav@samsung.com, 
	da.gomez@samsung.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 6:35=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Wed, Jul 02, 2025 at 11:43:12AM -0700, Darrick J. Wong wrote:
> > > On a spinning disk, random IO bandwidth remains unchanged, while sequ=
ential
> > > IO performance declines. However, setting nr_wb_ctx =3D 1 via configu=
rable
> > > writeback(planned in next version) eliminates the decline.
> > >
> > > echo 1 > /sys/class/bdi/8:16/nwritebacks
> > >
> > > We can fetch the device queue's rotational property and allocate BDI =
with
> > > nr_wb_ctx =3D 1 for rotational disks. Hope this is a viable solution =
for
> > > spinning disks?
> >
> > Sounds good to me, spinning rust isn't known for iops.
> >
> > Though: What about a raid0 of spinning rust?  Do you see the same
> > declines for sequential IO?
>
> Well, even for a raid0 multiple I/O streams will degrade performance
> on a disk.  Of course many real life workloads will have multiple
> I/O streams anyway.
>
> I think the important part is to have:
>
>  a) sane defaults
>  b) an easy way for the file system and/or user to override the default
>
> For a) a single thread for rotational is a good default.  For file system
> that driver multiple spindles independently or do compression multiple
> threads might still make sense.
>
> For b) one big issue is that right now the whole writeback handling is
> per-bdi and not per superblock.  So maybe the first step needs to be
> to move the writeback to the superblock instead of bdi?

bdi is tied to the underlying block device, and helps for device
bandwidth specific throttling, dirty ratelimiting etc. Making it per
superblock will need duplicating the device specific throttling, ratelimiti=
ng
to superblock, which will be difficult.

> If someone
> uses partitions and multiple file systems on spinning rusts these
> days reducing the number of writeback threads isn't really going to
> save their day either.
>

in this case with single wb thread multiple partitions/filesystems use the
same bdi, we fall back to base case, will that not help ?

