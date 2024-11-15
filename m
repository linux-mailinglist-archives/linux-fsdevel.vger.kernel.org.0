Return-Path: <linux-fsdevel+bounces-34867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9CD9CD614
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 05:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B449B216B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 04:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A4C176AB5;
	Fri, 15 Nov 2024 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr521tE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC692F37;
	Fri, 15 Nov 2024 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731643291; cv=none; b=A+taZVpYkOQ9nM86Z8Utdsu+cn+CPuLqBO0nJrJGOBMYTBE2UxZczBjeCKSfoArJO3rBCk4rExn2rvDRHDYmfK/e2YQfb2QogUUeGnwApvAzP/T2Ran+FltdjYL9c8fnMF9zR+jpLspl5N+a+euvMlINIsEQy1MHL+MlI/cMRD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731643291; c=relaxed/simple;
	bh=SBbOMZKSEglULtzjYYUceNSTFC5l18/XBMumWX6ysKc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CCkKML3YvGldaxYP7h345mA0VGZXQEvK9wrf8DrHBj9HDkdypcS9oi3dAuWrfU8torfXKozNyCg0yD9D4dMvgGszBUHDOr9WftGS17A3DiComu5sr9+YR95epsXcHqV66FmVIGUcE48/aYnERuYvjg3xQGpQlSxMJI1xIkNv470=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr521tE5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c77459558so12609145ad.0;
        Thu, 14 Nov 2024 20:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731643289; x=1732248089; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SBbOMZKSEglULtzjYYUceNSTFC5l18/XBMumWX6ysKc=;
        b=Fr521tE52Zn0BNAVL5Luy/KWUt7NCtIRQcsdHx62QFREkZ0uD40MPH2hiuOf4Qicje
         Fn0Cd3EnWJOzlcYhaOrI1zCbN10OB9B4lBC1O/fQ+CqnzpDJH71zJTsCjXcZ5etMgUWe
         t0TQgrRX276KqWWuIJdn17y6+gE6nnAcEowmjd8lMabWFyz3aYqoQSx5wfRqOwg7cxhS
         R3xA8sAfn7Kf3CJiW2V1PYsFH0SuZefYqyQpb3X/TVjdWKRs7oh8sw9NMQY/Uszl2OGc
         VKhsZSIxovYjA1tJ0zggJ0Ijry/R6PNzSwpd5F3irGjA/AJCJhH6k1wK0VWfZkT3ov2T
         NaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731643289; x=1732248089;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBbOMZKSEglULtzjYYUceNSTFC5l18/XBMumWX6ysKc=;
        b=QcuG99s1KDdIrqbOkHh/BUMpoUxKEn4LJAM5Y0mEULNr/8xWbhVRTXpPTuidsMdgoI
         APJG4aY2guoHAHnV0j9/iNFeOwuQ9HStSMGivHR0W3AgZj4klxGvlH+shm8duF0VGg00
         zs4ey62x3V4nOytZGZOnvzce8sGuCodCd5nAc4XtlWIb0VZniLoB7iXVt5Qy999oaDRi
         G2WQuNxjkYm55olwPL4ElKScD1pJLlllE0s3MxocwbD1LNDP+pn1ORWu+ryKrIndL/cT
         P0cfynvFlWujtcxzrJ6/pmuGKTmKUhXkfz+5X56o+reyVxIOqswoSF68HDo76iVVU6RU
         HmNg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Y+5c2PIWFJpFh3ienkhIC1nmtB9ZbkGwd1JYEWmCtsMGbO0EEkiR2xXvP6US8MroWVJ71EzqVKJW9Q==@vger.kernel.org, AJvYcCUo6eAcDmUMNOsnGHZEG7ql1tjKvtLc3KSByUHY54NIuCtUnUS16O3/tusSWWA7NxZZp8M/V5EF5h/h@vger.kernel.org, AJvYcCUrbxqNWomlBfobYFFAB6gCCpTmD+4hKSyma+LGq5zARk8lPaQO9jZ380qUED3Ih+XdBOmqmdwJvUmRbw==@vger.kernel.org, AJvYcCUxJjrT2yqLR7RVq0v4mr7bcQKqK8CBOpKF1xV0lAZw58NwdlZK3/fYQjvsn+xEpIza84JR3RCOJe48xUkczA==@vger.kernel.org, AJvYcCWIxHXleLoeRk0c02jd6sqlqpvtJbmEyaIaYILVBnkPyv5wsL5XZaL5oityizjMAGFZPkV1fS+jDm6cln1W@vger.kernel.org
X-Gm-Message-State: AOJu0YzEIaEW0fJ41MK2lTY5N6hErdtVpQAT8gbwSJBfT2V1O0jYj6Ox
	8m6fZgQywv80JjmMKGJGIfRBMwtEHX1FActgT0T8EwHoV5y/k8B5
X-Google-Smtp-Source: AGHT+IGIGDCtkGXvHsXcS/UCbj1fAXsOFtXspIdyEuLCS6WlpXb/8B43cROPn6gVvB1e1TRaXbciRw==
X-Received: by 2002:a17:902:ec88:b0:20c:da98:d752 with SMTP id d9443c01a7336-211d0d6fcdfmr17849335ad.16.1731643288821;
        Thu, 14 Nov 2024 20:01:28 -0800 (PST)
Received: from [10.172.23.43] ([206.237.119.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc5d7bsm3902325ad.36.2024.11.14.20.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 20:01:28 -0800 (PST)
Message-ID: <8b47ebabf12a531f2fa24a7671df5e569b82adb7.camel@gmail.com>
Subject: Re: [PATCHSET v5 0/17] Uncached buffered IO
From: Julian Sun <sunjunchao2870@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org, 
	willy@infradead.org, kirill@shutemov.name, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, bfoster@redhat.com
Date: Fri, 15 Nov 2024 12:01:23 +0800
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 08:25 -0700, Jens Axboe wrote:
> Hi,
>=20
> 5 years ago I posted patches adding support for RWF_UNCACHED, as a way
> to do buffered IO that isn't page cache persistent. The approach back
> then was to have private pages for IO, and then get rid of them once IO
> was done. But that then runs into all the issues that O_DIRECT has, in
> terms of synchronizing with the page cache.
>=20
> So here's a new approach to the same concent, but using the page cache
> as synchronization. That makes RWF_UNCACHED less special, in that it's
> just page cache IO, except it prunes the ranges once IO is completed.
>=20
> Why do this, you may ask? The tldr is that device speeds are only
> getting faster, while reclaim is not. Doing normal buffered IO can be
> very unpredictable, and suck up a lot of resources on the reclaim side.
> This leads people to use O_DIRECT as a work-around, which has its own
> set of restrictions in terms of size, offset, and length of IO. It's
> also inherently synchronous, and now you need async IO as well. While
> the latter isn't necessarily a big problem as we have good options
> available there, it also should not be a requirement when all you want
> to do is read or write some data without caching.
>=20
> Even on desktop type systems, a normal NVMe device can fill the entire
> page cache in seconds. On the big system I used for testing, there's a
> lot more RAM, but also a lot more devices. As can be seen in some of the
> results in the following patches, you can still fill RAM in seconds even
> when there's 1TB of it. Hence this problem isn't solely a "big
> hyperscaler system" issue, it's common across the board.
>=20
> Common for both reads and writes with RWF_UNCACHED is that they use the
> page cache for IO. Reads work just like a normal buffered read would,
> with the only exception being that the touched ranges will get pruned
> after data has been copied. For writes, the ranges will get writeback
> kicked off before the syscall returns, and then writeback completion
> will prune the range. Hence writes aren't synchronous, and it's easy to
> pipeline writes using RWF_UNCACHED. Folios that aren't instantiated by
> RWF_UNCACHED IO are left untouched. This means you that uncached IO
> will take advantage of the page cache for uptodate data, but not leave
> anything it instantiated/created in cache.
>=20
> File systems need to support this. The patches add support for the
> generic filemap helpers, and for iomap. Then ext4 and XFS are marked as
> supporting it. The last patch adds support for btrfs as well, lightly
> tested. The read side is already done by filemap, only the write side
> needs a bit of help. The amount of code here is really trivial, and the
> only reason the fs opt-in is necessary is to have an RWF_UNCACHED IO
> return -EOPNOTSUPP just in case the fs doesn't use either the generic
> paths or iomap. Adding "support" to other file systems should be
> trivial, most of the time just a one-liner adding FOP_UNCACHED to the
> fop_flags in the file_operations struct.
>=20
> Performance results are in patch 8 for reads and patch 10 for writes,
> with the tldr being that I see about a 65% improvement in performance
> for both, with fully predictable IO times. CPU reduction is substantial
> as well, with no kswapd activity at all for reclaim when using uncached
> IO.
>=20
> Using it from applications is trivial - just set RWF_UNCACHED for the
> read or write, using pwritev2(2) or preadv2(2). For io_uring, same
> thing, just set RWF_UNCACHED in sqe->rw_flags for a buffered read/write
> operation. And that's it.
>=20
> Patches 1..7 are just prep patches, and should have no functional
> changes at all. Patch 8 adds support for the filemap path for
> RWF_UNCACHED reads, patch 10 adds support for filemap RWF_UNCACHED
> writes, and patches 13..17 adds ext4, xfs/iomap, and btrfs support.
>=20
> Passes full xfstests and fsx overnight runs, no issues observed. That
> includes the vm running the testing also using RWF_UNCACHED on the host.
> I'll post fsstress and fsx patches for RWF_UNCACHED separately. As far
> as I'm concerned, no further work needs doing here. Once we're into
> the 6.13 merge window, I'll split up this series and aim to get it
> landed that way. There are really 4 parts to this - generic mm bits,
> ext4 bits, xfs bits, and btrfs bits.
>=20
> And git tree for the patches is here:
>=20
> https://git.kernel.dk/cgit/linux/log/?h=3Dbuffered-uncached.7
>=20
> =C2=A0fs/btrfs/bio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> =C2=A0fs/btrfs/bio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0fs/btrfs/extent_io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 ++-
> =C2=A0fs/btrfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 ++-
> =C2=A0fs/ext4/ext4.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0fs/ext4/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0fs/ext4/inline.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
> =C2=A0fs/ext4/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +++++-
> =C2=A0fs/ext4/page-io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 28 ++++----
> =C2=A0fs/iomap/buffered-io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 15 ++++-
> =C2=A0fs/xfs/xfs_aops.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
> =C2=A0fs/xfs/xfs_file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0include/linux/fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 21 +++++-
> =C2=A0include/linux/iomap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 8 ++-
> =C2=A0include/linux/page-flags.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 =
++
> =C2=A0include/linux/pagemap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 14 ++++
> =C2=A0include/trace/events/mmflags.h |=C2=A0=C2=A0 3 +-
> =C2=A0include/uapi/linux/fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 6 +-
> =C2=A0mm/filemap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 114 ++++++++++++++=
+++++++++++++++----
> =C2=A0mm/readahead.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 22 +++++--
> =C2=A0mm/swap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 2 +
> =C2=A0mm/truncate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 35 ++++++----
> =C2=A022 files changed, 271 insertions(+), 63 deletions(-)
>=20
> Since v3
> - Use foliop_is_uncached() in ext4 rather than do manual compares with
> =C2=A0 foliop_uncached.
> - Add filemap_fdatawrite_range_kick() helper and use that in
> =C2=A0 generic_write_sync() to kick off uncached writeback, rather than n=
eed
> =C2=A0 every fs adding a call to generic_uncached_write().
> - Drop generic_uncached_write() helper, not needed anymore.
> - Skip folio_unmap_invalidate() if the folio is dirty.
> - Move IOMAP_F_UNCACHED to the internal iomap flags section, and add
> =C2=A0 comment from Darrick to it as well.
> - Only kick uncached writeback in generic_write_sync() if
> =C2=A0 iocb_is_dsync() isn't true.
> - Disable RWF_UNCACHED on dax mappings. They require more extensive
> =C2=A0 invalidation, and as it isn't a likely use case, just disable it
> =C2=A0 for now.
> - Update a few commit messages
>=20

Hi,

Hello, the simplicity and performance improvement of this patch series are
really impressive, and I have no comments on it.=C2=A0

I'm just curious about its use cases=E2=80=94under which scenarios should i=
t be
used, and under which scenarios should it be avoided? I noticed that the
backing device you used for testing can provide at least 92GB/s read
performance and 115GB/s write performance. Does this mean that the higher
the performance of the backing device, the more noticeable the
optimization? How does this patch series perform on low-speed devices?

My understanding is that the performance issue this patch is trying to
address originates from the page cache being filled up, causing the current
IO to wait for write-back or reclamation, correct? From this perspective,
it seems that this would be suitable for applications that issue a large
amount of IO in a short period of time, and it might not be dependent on
the speed of the backing device?

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

