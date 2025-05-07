Return-Path: <linux-fsdevel+bounces-48387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB09AAE280
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB59C5F58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E04528C2DF;
	Wed,  7 May 2025 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1HKmWDlG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92F28C013
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626556; cv=none; b=aU1gWvWYnnN9vDZUz1D+4Y9usGVWR76CwKfy4r5sv7wE77G+/ID0aronnDXD4s5ZSxR9wr2Uwd1nnF9nNPluBDUgyyqmZPxTkaRVPkPgoD7CSOf7+LXYhnvIQA6b+RS/U2rNpeVgmgHQgUF9a3XxDZd0QLjop+DK9LlzsB9qtl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626556; c=relaxed/simple;
	bh=u1WvrSapMzjyS9qZrw1hKIGsBWOqDhnGPCP10gYW6Cg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f9fTqDJlH0WNQ8rLUttBjOXjR/FG+1usXwWCkGb3ooZldeKpWVWXahTgRt6PpwNCRwIGlsEmtHOALQOBn5K9faeEsUhmIuxbYM+A4Q9l7hwUG8jNW2wOcH7Cdf9hwRRVyVsg+x78qlVH+bm/Mh/Ot6GJ3iNHlbI527tQBN+wvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1HKmWDlG; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85b3f92c866so145329339f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746626553; x=1747231353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/e69eX7rTdQU3DebRyniOro00nTR+2O7+QHGV+7EO0=;
        b=1HKmWDlGP1KCCRSjfqPmBaSpOt1CBsEgQpKoWwDUVaN0gyl6NGwfs5VjGk2xnhJis1
         u34XJvh4Bmes1tQ2KTwnZ95jhXL7aokCG9u/RMZDUjEbYop1TF22da7g6pjuqEUYczu+
         d1pz0WTYMFZA11dRGyowDn7f+X2MsYHswZku0n7nlS61uznlPqOUwe+Pm4QanMX3wy9b
         jThqhrhGorfJ6Hbrlv1L7M5XJ0kgsaSK/1P5s9ulCCu9ph7VWmGYJL4JEFTVH0QDt1wv
         t6fxZn1SVBvfebsDzwLkCRDj2bIuic/bAiM2pkQE4CwQ8nXWX0G+ijU9bSBS0x5KfXSA
         6/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626553; x=1747231353;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/e69eX7rTdQU3DebRyniOro00nTR+2O7+QHGV+7EO0=;
        b=w2Qs+4drRjyd1iHX/lqhbHFfljsFR1h4C/SzH8zGM4K23r0jN+79QPPsEZhVjrBbE/
         XkFN+9KR6zuvbGr6P9feX0wx0C8Eh7fl/uDVOAcihmuyEWvARtnRY6yo83eH7yfKSGoW
         K2ZSFPHrnSWzvQYJRlu17qVtiraIbQwbwn1BQzyVzQUZrPmDipA6T3N+JF6NIOiOe7+R
         FYrDQSd3cZ0LlA82vfBc0x+HML4yT0khXv0L4Kk/moteUnTQBIC/SgYIAd6SFz5edIlO
         YOUuFuRLf83eR/P7rUpb9LyTXrO/+SpO2TsvSEVq7nvdKoFdEq7YDbMKVgB+aLHVRDuA
         em6w==
X-Forwarded-Encrypted: i=1; AJvYcCWJT86S7vcfcp2CyTmUeppRUZR+WxSNNCWe5zZ1r2F+Qt3iIxxAfto2hLP/OY2phs9EpOokkjIo6v9ndNwK@vger.kernel.org
X-Gm-Message-State: AOJu0YyJMpp/PRg1Cel/Hv3HbfUBCVbuxhTdow4CWfpeP25rHR/8g4vZ
	evv3XRYxchokiUa9dO5OyTO+o4U/I2a7z7eZDAdPyOw7hY+n3zau5qGyD5GahjA=
X-Gm-Gg: ASbGncsiwOFneZ/vnzlXGtHqVKt8UuxUR3bbwEe6lSqhAgJoTSRd0532tehWZOIHxQ4
	zwMqdEuhhIie21I/0KZZ0f+ozzIdWwfa8GVoimKdlRYWYC4/Za1G4qoCM5C9VQQeCkLM0H/el52
	w0o0mPw7oq+g6+cnPPNjC0cdCaB7wo6I9TKQyN8nsxeBCyR50nX2B4Ypxva/JXcPQmptcQotKmt
	1y7EXXtTjryRbNzSmZqtDI0bUKR5yMRepIQOxh3UOdz3gizVaO3RJkKt4Ze1hRv7uuU0wTxSXkK
	5sQNksMNtXWz8K326rUfIsXHffKNIFY=
X-Google-Smtp-Source: AGHT+IFKzirCN+Eb4LryiVuePRi35iU9q8ScKrI1anbroM0TMHPbhux4iOi4irCSUABdP/WxjlqB7w==
X-Received: by 2002:a05:6602:6d0e:b0:85b:505a:7e01 with SMTP id ca18e2360f4ac-8674727e70dmr348656939f.5.1746626544084;
        Wed, 07 May 2025 07:02:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f9fc6bb606sm642485173.18.2025.05.07.07.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:02:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <20250507120451.4000627-1-hch@lst.de>
References: <20250507120451.4000627-1-hch@lst.de>
Subject: Re: add more bio helpers v3
Message-Id: <174662654265.1844963.5765833717643625363.b4-ty@kernel.dk>
Date: Wed, 07 May 2025 08:02:22 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 07 May 2025 14:04:24 +0200, Christoph Hellwig wrote:
> this series adds more block layer helpers to remove boilerplate code when
> adding memory to a bio or to even do the entire synchronous I/O.
> 
> The main aim is to avoid having to convert to a struct page in the caller
> when adding kernel direct mapping or vmalloc memory.
> 
> Changes since v2:
>  - rebase on top of the latest block for-next branch to resolve
>    conflicts with the bonuce buffering removal
> 
> [...]

Applied, thanks!

[01/19] block: add a bio_add_virt_nofail helper
        commit: 850e210d5ad21b94b55b97d4d82b4cdeb0bb05df
[02/19] block: add a bdev_rw_virt helper
        commit: 10b1e59cdadabff16fc78eb2ca4c341b1502293c
[03/19] block: add a bio_add_max_vecs helper
        commit: 75f88659e47dc570bdebddf77d7a3cd5f0845612
[04/19] block: add a bio_add_vmalloc helpers
        commit: 8dd16f5e34693aa0aa6a4ed48427045008097e64
[05/19] block: remove the q argument from blk_rq_map_kern
        commit: af78428ed3f3eebad7be9d0463251046e9582cf6
[06/19] block: pass the operation to bio_{map,copy}_kern
        commit: fddbc51dc290f834f520ce89c00a0fce38260c16
[07/19] block: simplify bio_map_kern
        commit: 6ff54f456671415e101e671a7dfa1fe13a31bdb5
[08/19] bcache: use bio_add_virt_nofail
        commit: 23f5d69dfa993cb6d17e619fff5e623e76b9b17f
[09/19] rnbd-srv: use bio_add_virt_nofail
        commit: a216081323a1391991c9073fed2459265bfc7f5c
[10/19] gfs2: use bdev_rw_virt in gfs2_read_super
        commit: 65f8e62593e64f6991ece4f08ab9e147e62df488
[11/19] zonefs: use bdev_rw_virt in zonefs_read_super
        commit: b2f676efe601586360e5f7461f6d36981ac1e6c9
[12/19] PM: hibernate: split and simplify hib_submit_io
        commit: 0cb8c299f81591699e908d1a6ad2dba6df642e25
[13/19] dm-bufio: use bio_add_virt_nofail
        commit: 9134124ce1bac3d5228ee1b1fc7a879422ff74f6
[14/19] dm-integrity: use bio_add_virt_nofail
        commit: bd4e709b32ac932aee3b337969cbb1b57faf84bd
[15/19] xfs: simplify xfs_buf_submit_bio
        commit: 9dccf2aa6ed5fa6ee92c8d71868bf3762ae85bda
[16/19] xfs: simplify xfs_rw_bdev
        commit: d486bbecc90d86e0292071bd06322543f8f5f658
[17/19] xfs: simplify building the bio in xlog_write_iclog
        commit: 5ced480d4886b12e6a2058ac3ebd749b0ff14573
[18/19] btrfs: use bdev_rw_virt in scrub_one_super
        commit: 760aa1818b040c8ec6a1ee9cea1ea8cac0735ce3
[19/19] hfsplus: use bdev_rw_virt in hfsplus_submit_bio
        commit: 15c9d5f6235d66ebc130da9602b1cd7692bcf85d

Best regards,
-- 
Jens Axboe




