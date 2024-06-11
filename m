Return-Path: <linux-fsdevel+bounces-21400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ADC9038A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785871C23746
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAECD179967;
	Tue, 11 Jun 2024 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpKEnRi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828FE171093;
	Tue, 11 Jun 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101006; cv=none; b=Tx/0DbBGzuBqLTVhvrZjeaDT3dNfOwN663f3puMSBFW7XZyHfnY+sFOzatAqHkVN512BURcAKp9ELTq0HneLqPjhkKWiqf/Q990olwpEbfXBkerL96ewzhtTss+VSRs4KyInTcvutRCGZnk3pQNWT88BI/V2vCYOn46L6wGm5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101006; c=relaxed/simple;
	bh=FcUhVZtywOK9kxMvai7/GZE1mImBUHiulyedco8utXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PbTtXo5yFp/DqWP6hERLm/HQV7uhjSDdNNgkeB9L1QuHGF9LDMseftcYoJynXiBZmy5YNR/e6cDP+2d46A/jlRjHS55Tcdnpc3r/dCJa95PyawC6GtLw6GlU05Xmu+IyL1M8yBcYsoHgmyXwHmxnjghLCCQ9NkwnE6n3bzQW7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpKEnRi3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217990f997so26316335e9.2;
        Tue, 11 Jun 2024 03:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718101003; x=1718705803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIVgHslHc8mGThRF1qcVmrN54UHgjwK8zdf0VtH82oY=;
        b=bpKEnRi3rf1Xq9qA2HpR4k0Nbbinl90mykjY2wEWJTlTZ6tQkk7kF1HSFamgI06VyX
         4e9dPd75djQP+emq5rSoIDUKeNWQRT/NmpS/LWzZZm73Y9oEwHJgujV5Od6YjT2BFLC4
         GIoTmm5fdJicJ6zFasWKBjHM2jn6HaGV2lCFc5T/xWaoC3leh+uONUiwQ9mktudaN8B6
         ghKTG86MzBlRcm0X2DNxC61wPbUpnFfPW9bqP1lKvsNdhVRcIBJg+cQgZRskaZXsfcYm
         ABKflNHAKWfiNTGz1TyaH7Q3rQArEUw2IivN8Lrabh+5V/iUfoobrI4yr7Cl3rqapzUR
         lN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718101003; x=1718705803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIVgHslHc8mGThRF1qcVmrN54UHgjwK8zdf0VtH82oY=;
        b=VVaNJZAG7iecq0L39XYVyJhRGvoq/fyaI+OMLk+05uareabRWNGrrkT7lCsP6EQhsW
         gKc8Mhykduv51rKZRF8psxGVgUf7sS7sP0JmZaGNhxrfOF7s7YqMXgGPGxhynZMxaXox
         Jn1CbnnMYikYMrPDADKdMLNvwgdWw3kU2zJXgKCn8eNazFvPKhZ7hgnE17wdqNT5kBNs
         tYYy8YKVPbPX35eFJVHf/X+dnNZ5xUZ2Inbqc00PmcqnBF6wM5bxESs9OL8tYRc+4bKG
         42T4C5j8kh+LdVZ2N28TsDPgYlXLqNy4UT8NITkkUDSAte+2kkgGGuIcNuVpGis8wLrP
         Dqjw==
X-Forwarded-Encrypted: i=1; AJvYcCVXFqG36BOEGBrcU325y136AFQii8pPfEfxHB9YNWZUG33QDyYixlpj76gQmsg0UGYgowO/CIpkyvkE0KhatfpfR6NqAqKf+N3PpQNa3RRiN1Il5MJw8esa3Kn3d6rY2VXQq7NT5pDfeq4Y8eYOEFJnOLIbp3EVwGH4Lp3U7IHPp94eJAbMOdXQ
X-Gm-Message-State: AOJu0YwR0d2rfEJ5zZBpIkqYLWkyGEPNqem1BK0RJNSL92W2BsNNqWyj
	a5QtFowMRc7kXLv9GtabsW/743cjy/tF55QFIRdDNMH7xc/nNZeK
X-Google-Smtp-Source: AGHT+IGY+tQhKFR0ODWsDOkTiMXY3X5Pqt9XtBWT52Crt4Ny8EiS1x+SsdHticwZh2BhNaGZoS/B8w==
X-Received: by 2002:a05:600c:4e8a:b0:421:7ee4:bbe8 with SMTP id 5b1f17b1804b1-4217ee4be2dmr61477055e9.19.1718101002500;
        Tue, 11 Jun 2024 03:16:42 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c1aa1desm173481275e9.11.2024.06.11.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:16:41 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	josef@toxicpanda.com,
	hch@infradead.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 0/2] rcu-based inode lookup for iget*
Date: Tue, 11 Jun 2024 12:16:30 +0200
Message-ID: <20240611101633.507101-1-mjguzik@gmail.com>
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
safe to assume all filesystems happen to cope.  Thus iget5_locked_rcu,
ilookup5_rcu and ilookup5_nowait_rcu get added, requiring manual
conversion.

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

fs rundown is as follows:
- ext4 patched implicitly
- xfs does not use the inode hash
- bcachefs is out of the picture as Kent decided to implement his own
  inode hashing based on rhashtable, for now private to his fs.

I have not looked at others.

[1] https://lore.kernel.org/all/20231206060629.2827226-1-david@fromorbit.com/

v3:
- export new routines with _GPL
- don't use the extern keyword
- add ilookup5_rcu to follow iget5_locked scheme

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


