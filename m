Return-Path: <linux-fsdevel+bounces-58807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0228B31A2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A0D16F97E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3122E3043DB;
	Fri, 22 Aug 2025 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQonPoTE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C9302CD8;
	Fri, 22 Aug 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870339; cv=none; b=Ghq1Cd1POmu4GtRi7w24SQUv3dMFDMvfCk+/zIYnFU7s+oQeDWXvCvTVV4C3TyaukpS3HJARwiiYq3xlZPeKFrzN02QYaGErnrHOvHyapVkGo7KmeyAC7Jt/q/2FW863i+3X8zUUuplP0gZEHpWO7NnKuUFehUzJZwZPXnye8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870339; c=relaxed/simple;
	bh=9guF4nYAdpubhBEM+nGDmqAXkJV2Tmi2Jyrl1UttPyo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ov6HGoUt5rjA4lI+QyGNlbnAEFgxfGHPgOZC17BVGDziS8mEu8aCdwJE8yJ5+KNJQp9SyKN/t6G7qgizwNn6tOcfMfN3esEc1tNlJKgNvUT+iTE8u15NzmiXSO83XHjX29DLCiMg4DpBUn9A0MiTL7KVTzZtPzgYZRRkEQOo224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQonPoTE; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b49c0c5f4dfso547461a12.1;
        Fri, 22 Aug 2025 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870337; x=1756475137; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKWOYEUs0uCA6Fp6TXWX4VIxm5Onhrin5LUppg0AoHg=;
        b=aQonPoTEl7hUsfik5a9lCN9sJJwfxCPICKMXO3kjxSJ+l6xQSxPIxAco82uVlqKN7F
         6+xDg8InROAes+HibFsjYtYrARfWa/ieSnjMUtkR4BMytnK2w96Z7c39ub/8XytUgVk8
         2FOZZNjpmh+LtShx2czhQQ+HpsaD4Vpd6LlPXRXDkBG0oTWyQNnEQSnXzlMItcW03ixs
         4JyrATyKdEmZfof/E36yCr5xk9tCQK9ytjIKb770dqgegXsgUdtz0lVIJSfgWG+EU2HL
         nIY4yBFD9WKaiM1S9t6KZSnytkbe/yOlOQPT6lon/Pt7d/KKhHij5nLSAtUMljI9rdaH
         Wyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870337; x=1756475137;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKWOYEUs0uCA6Fp6TXWX4VIxm5Onhrin5LUppg0AoHg=;
        b=vMlCnLsl92d3r/PEUJYw2vLDO5AD9OUT8x/TcBZLTfCbUxY+PaRVsgpcAKYirxgFoC
         SK9t5P/RLbqmcJw3yibo/5aZq9Uu2vmKSeaVR52r9DsI65go8c45Efbxu+EYLqC5NPwr
         zo6PKiulaj4jHGEpO/sqhBqf/JXiDiYDrQymP09Rru9n0IQvQTKqeM1vtKXb+iSSd4gi
         tlgsGoB76/BoqClQRp4bCtDDk1nmhKlhSHSIwrpDSgrP1OPMq+yiqFSOx62kTGA+hg9V
         hujAhlW/uaErqYRkgVSV5AoVqAmx9Jh7kOfVwkdLxY8MQlA64jS5/aOpsJIOiAd1qExO
         fIyw==
X-Forwarded-Encrypted: i=1; AJvYcCUJg3+Y2AEUoQwxRGqwzAYfIJX1k07AexWEy7m+i/9+cWaE3csMgjS6mrCg8Ba29a0hPs5pDox0wDz1Xg==@vger.kernel.org, AJvYcCUd+p/7Trnb6DnTQaAe7FO0RTi1hIghr697cKnngh42j4KtZneQLKueiXxqn7oWu9NH6sB8vJ2mvm4pBpPH@vger.kernel.org, AJvYcCVRbxOxH5s9rh5I6nzKxgRlekP9Zyw0I39U+BQeOFF9AxUnrE8scGZbnvxXmxJne5ISyMfzv2O7ZLrXNg==@vger.kernel.org, AJvYcCWmEqk2F9OKAmwB/cLB4QaxXebPLZgnQJjREXwE/dsSyFyiADqCZtrK7jSkNy9ISbIeVoQTk9F+9zputzVbAQ==@vger.kernel.org, AJvYcCWzlBuyv3rC2GTA/Wlg283M8OZjWxVjWVCHGqL+b7jgEM5J0p4aeHpHDutb0i2EI4/D3arHAhcCL6kq@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAkNSDjB2Fx/ZlvH8nVBNriwxeLH0EQZX2o4O7MI2JDuuZUwb
	WxHXWnmzd9zuvKOp7aa2nn13JEpVJku80lnGruB7tf3Uwq8yQsIQfjU5
X-Gm-Gg: ASbGncuaQgAz7zduzZaoQ7gJDVBRdVH+nrMZ6/gsHaXTtwCaH94Zje+X++GzyfxXnwk
	E2M2w57vRNM0KA093ois8485efTnrc0aUjnhL7FEQwqgeyCsVkn47iUDQ7DCyXGsadDMXw912vL
	MZioF/kIZaqhjpv89rZrQ3fxqApvpriEDpxP6omiqDa9RPDjrN35NSLAhHDNK4Yb6V19QQJQYdP
	rWziG1FGUtno+qVZrObhy6xlx5deskRSWR7Xnas25wl43nE8bt+1vPof3PQynPwS2YHOJ2gI+YS
	eBoctYEyx14bmyHDzV9D3VgHmCluCokSeWoBvdjq2eMX86i5M1NWFo3ami7bCr/cpuLvjjsbFOx
	TON+VYBS+KQNWEg==
X-Google-Smtp-Source: AGHT+IGWgCeQyNze15y8g6Rc5RnPSYAOGwg5TD20mIDdL4Y5P6UMgD46dIVXG0JZ8EnVWgy0ligsEw==
X-Received: by 2002:a17:903:283:b0:240:7f7d:2b57 with SMTP id d9443c01a7336-2462eeb705dmr41706525ad.28.1755870336565;
        Fri, 22 Aug 2025 06:45:36 -0700 (PDT)
Received: from dw-tp ([171.76.85.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245f38ab988sm74460305ad.124.2025.08.22.06.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:45:35 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org, hch@lst.de, martin.petersen@oracle.com, djwong@kernel.org, linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk, Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
In-Reply-To: <20250819164922.640964-1-kbusch@meta.com>
Date: Fri, 22 Aug 2025 18:57:08 +0530
Message-ID: <87a53ra3mb.fsf@gmail.com>
References: <20250819164922.640964-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Keith Busch <kbusch@meta.com> writes:

> From: Keith Busch <kbusch@kernel.org>
>
> Previous version:
>
>   https://lore.kernel.org/linux-block/20250805141123.332298-1-kbusch@meta.com/
>
> This series removes the direct io requirement that io vector lengths
> align to the logical block size.
>
> I tested this on a few raw block device types including nvme,
> virtio-blk, ahci, and loop. NVMe is the only one I tested with 4k
> logical sectors; everything else was 512.
>
> On each of those, I tested several iomap filesystems: xfs, ext4, and
> btrfs. I found it interesting that each behave a little
> differently with handling invalid vector alignments:
>
>   - XFS is the most straight forward and reports failures on invalid
>     vector conditions, same as raw blocks devices.
>
>   - EXT4 falls back to buffered io for writes but not for reads.

++linux-ext4 to get any historical context behind why the difference of
behaviour in reads v/s writes for EXT4 DIO. 


BTW - I did some basic testing of the series against block device, XFS &
EXT4 and it worked as expected (for both DIO & AIO-DIO) i.e.
1. Individial iov_len need not be aligned to the logical block size anymore.
2. Total length of iovecs should be logical block size aligned though.

i.e. this combination works with this patch series now:

    posix_memalign((void**)&aligned_buf, mem_align, 2 * BLOCK_SIZE);
    struct iovec iov[4] = {
        {.iov_base = aligned_buf, .iov_len = 500},
        {.iov_base = aligned_buf + 500, .iov_len = 1500},
        {.iov_base = aligned_buf + 2000, .iov_len = 2000},
        {.iov_base = aligned_buf + 4000, .iov_len = 4192}
    }; // 500 + 1500 + 2000 + 4192 = 8192
 

-ritesh

>
>   - BTRFS doesn't even try direct io for any unusual alignments; it
>     chooses buffered io from the start.
>
> So it has been a little slow going figuring out which results to expect
> from various tests, but I think I've got all the corner cases covered. I
> can submit the tests cases to blktests and fstests for consideration
> separately, too.
>
> I'm not 100% sure where we're at with the last patch. I think Mike
> initially indicated this was okay to remove, but I could swear I read
> something saying that might not be the case anymore. I just can't find
> the message now. Mike?
>
> Changes from v2:
>
>   Include vector lengths when validating a split. The length check is
>   only valid for r/w commands, and skipped for passthrough
>   DRV_IN/DRV_OUT commands.
>
>   Introduce a prep patch having bio_iov_iter_get_pages() take the
>   caller's desired length alignment.
>
>   Additional code comments explaing less obvious error conditions.
>
>   Added reviews on the patches that haven't changed.
>
> Keith Busch (8):
>   block: check for valid bio while splitting
>   block: add size alignment to bio_iov_iter_get_pages
>   block: align the bio after building it
>   block: simplify direct io validity check
>   iomap: simplify direct io validity check
>   block: remove bdev_iter_is_aligned
>   blk-integrity: use simpler alignment check
>   iov_iter: remove iov_iter_is_aligned
>
>  block/bio-integrity.c  |  4 +-
>  block/bio.c            | 64 ++++++++++++++++++----------
>  block/blk-map.c        |  2 +-
>  block/blk-merge.c      | 20 +++++++--
>  block/fops.c           | 13 +++---
>  fs/iomap/direct-io.c   |  6 +--
>  include/linux/bio.h    | 13 ++++--
>  include/linux/blkdev.h | 20 +++++----
>  include/linux/uio.h    |  2 -
>  lib/iov_iter.c         | 95 ------------------------------------------
>  10 files changed, 94 insertions(+), 145 deletions(-)
>
> -- 
> 2.47.3

