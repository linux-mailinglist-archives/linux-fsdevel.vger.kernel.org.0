Return-Path: <linux-fsdevel+bounces-21353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6186890298E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 21:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AFC285AF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 19:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6914F132;
	Mon, 10 Jun 2024 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daC0VF6D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730391BC39;
	Mon, 10 Jun 2024 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049524; cv=none; b=E8TsLW//IDE+JktfbXILPEOkgaxc33yQYTR37u8rRj1C+s/i9IpS5473QDNRCPPr6eNw8psv128kDP0Ki6YRDtGSHqyDiSy1Ym4zbFkIWFCsZ5i8u70J3xrJHoIWqTiHjd2qATMUb84xCXdnlGcClaP+yOkO8O2P3TSmSY2AjeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049524; c=relaxed/simple;
	bh=+B21abGdFzSs/U82u5DKAz6F+vtQVndVQTzhHpvThvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8O3P/WJ/ZADzCryD21WfvY34BAAh9k4sjcLiwRV+B9ZsZRuzD1QWh2dznjg6iwRu2EDAPzsH/mcNpIw2vABgnKIpasEJ1qOAXaetlXS5UFVhrrpupWkT7h3u8h85IJgCaVUucI1ReZKm13gh/qyN7+vCtn2icFUy3KpQ/7hVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daC0VF6D; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so41403535e9.1;
        Mon, 10 Jun 2024 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718049521; x=1718654321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A38DVCmzrKozIgkHgFm5rejhEeJaVKj9XujqtvV7pkw=;
        b=daC0VF6DBEsK8WpqDM6HQC3w22VhsgtsOzOc1eoZdTTexoX5gW00uvMXO//Xr3Ia6F
         JLqUtPtw92SKeXHerOxXlhAd1jMmfPfQgPy7BVodt4V1pYdpWuShYVz7yVSRRRfplLiK
         ss2ziTWM+bj0e70MVf6S2L6GYWaoAK063UutMDhZ7vZt/NuYdDEwFTRSDz6RUmzfhCEt
         xCIxan6k7JRxXR2ss9eekAJIthC/ubRwv/RUjdY8JgnJbGdjGD1e5t8j2FHRUPecgS8U
         eXWLblGp9BKZI2v6Zo1c/QBR3lJx1a2kA/y8g2D3ZvJSjaFk3b9eM1+Hjmblik1bGKEE
         WSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718049521; x=1718654321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A38DVCmzrKozIgkHgFm5rejhEeJaVKj9XujqtvV7pkw=;
        b=UlmwSDbFNn0fmPbNJxoay/WGjgL9E4lgfFkjs1JUYjZBd19AIzVQMQFlA7RFjEYCPE
         cNvEdepQTELtes2Y/NlncQ7Td/li10XcCbLL0aq+ewn9nu5WHy0eeeL4Bdewe0T+0uLr
         VwJI3v/D30RAQN3e5+ILg9hVcAwh1VioUqYkI/8dYuH5JmjAjdBcoHMSL36KKDgxR7oz
         8IaGcqgUx/VzictPDPG/NaJKWEofoReBQGxDFXOjt/cO4cPmYK7EPhm8YRUKUedZzhYg
         RZrhpSAgsxV7p/+1ps4EpU6r8rh2yHvOguMH78mTaa7bjXxiVrTgjlG7H8/r2yRk/vqU
         VOyw==
X-Forwarded-Encrypted: i=1; AJvYcCU/RpbLIxtXqXw4jjcBwgWWTxJipmtSMO/5gqKn9bMt3bLqwBmrFCm8ptITvreJKMsGS8HleQANI/s/gbZvQmY62/Hf5SndORFELQtUvk+K1IbaF2grWvqeaEhOe0SktGB+CPE7+9HPEIlH+ahyAA8J6U/yktJsz2yyShgmO19Is9VpLgaIcbEu
X-Gm-Message-State: AOJu0YzRYpbdPqTZ+kc3wphbVOy2PcpkXwSYSUkuksqOB6qPiHLlBLjC
	kP7GY6XfBECAxqhwkz/fKj2HIrnqF6i2myq8+conAprhvp0PWq0L
X-Google-Smtp-Source: AGHT+IEVw3U8sYRK/C7wfqLU+ku2U7WsTYzdIzvHy9pLENP/iSFSYiZal+HNCVKScNi5GocYPIEwDw==
X-Received: by 2002:a05:600c:35c6:b0:421:7f4d:5240 with SMTP id 5b1f17b1804b1-4217f4d56bemr47540665e9.24.1718049520492;
        Mon, 10 Jun 2024 12:58:40 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e97dsm151766105e9.5.2024.06.10.12.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:58:39 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	josef@toxicpanda.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 0/2] rcu-based inode lookup for iget*
Date: Mon, 10 Jun 2024 21:58:26 +0200
Message-ID: <20240610195828.474370-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I think the appropriate blurb which needs to land here also needs to be
in the commit message for the first patch, so here it is copy pasted
with some modifications at the end:

[quote]
Instantiating a new inode normally takes the global inode hash lock
twice:
1. once to check if it happens to already be present
2. once to add it to the hash

The back-to-back lock/unlock pattern is known to degrade performance
significantly, which is further exacerbated if the hash is heavily
populated (long chains to walk, extending hold time). Arguably hash
sizing and hashing algo need to be revisited, but that's beyond the
scope of this patch.

A long term fix would introduce finer-grained locking. An attempt was
made several times, most recently in [1], but the effort appears
stalled.

A simpler idea which solves majority of the problem and which may be
good enough for the time being is to use RCU for the initial lookup.
Basic RCU support is already present in the hash. This being a temporary
measure I tried to keep the change as small as possible.

iget_locked consumers (notably ext4) get away without any changes
because inode comparison method is built-in.

iget5_locked and ilookup5_nowait consumers pass a custom callback. Since
removal of locking adds more problems (inode can be changing) it's not
safe to assume all filesystems happen to cope.  Thus iget5_locked_rcu
and ilookup5_nowait_rcu get added, requiring manual conversion.

In order to reduce code duplication find_inode and find_inode_fast grow
an argument indicating whether inode hash lock is held, which is passed
down should sleeping be necessary. They always rcu_read_lock, which is
redundant but harmless. Doing it conditionally reduces readability for
no real gain that I can see. RCU-alike restrictions were already put on
callbacks due to the hash spinlock being held.

There is a real cache-busting workload scanning millions of files in
parallel (it's a backup server thing), where the initial lookup is
guaranteed to fail resulting in the 2 lock acquires.

Implemented below is a synthehic benchmark which provides the same
behavior. [I shall note the workload is not running on Linux, instead it
was causing trouble elsewhere. Benchmark below was used while addressing
said problems and was found to adequately represent the real workload.]

Total real time fluctuates by 1-2s.

With 20 threads each walking a dedicated 1000 dirs * 1000 files
directory tree to stat(2) on a 32 core + 24GB RAM vm:
[/quote]

Specific results:

ext4 (needed mkfs.ext4 -N 24000000):
before:	3.77s user 890.90s system 1939% cpu 46.118 total
after:  3.24s user 397.73s system 1858% cpu 21.581 total (-53%)

btrfs (s/iget5_locked/iget5_locked_rcu in fs/btrfs/inode.c):
before: 3.54s user 892.30s system 1966% cpu 45.549 total
after:  3.28s user 738.66s system 1955% cpu 37.932 total (-16.7%)

btrfs bottlenecks itself on its own locks here.

Benchmark can be found here: https://people.freebsd.org/~mjg/fstree.tgz

Previously I indicated I wanted to patch bcachefs, but I ran into bugs
with memory reclaim. To my understanding addressing them is a WIP. More
importantly though I brought up the patch with Kent, we had a little
back and forth. We both agree the entire inode hash situation needs
significant changes, but neither is signing up. :] Bottom line though is
that his fs is probably going to get a local rhashtable, so that fs is
out of the picture as far as this patch goes.

[1] https://lore.kernel.org/all/20231206060629.2827226-1-david@fromorbit.com/

v2:
- add argument lists to new routines
- assert the inode hash lock is not held as applicable
- real btrfs patch included

Mateusz Guzik (2):
  vfs: add rcu-based find_inode variants for iget ops
  btrfs: use iget5_locked_rcu

 fs/btrfs/inode.c   |   2 +-
 fs/inode.c         | 119 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/fs.h |  10 +++-
 3 files changed, 112 insertions(+), 19 deletions(-)

-- 
2.43.0


