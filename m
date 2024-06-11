Return-Path: <linux-fsdevel+bounces-21456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB190428F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 19:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34D01C221E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E86558AA7;
	Tue, 11 Jun 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jss80Oh4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4445948;
	Tue, 11 Jun 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127636; cv=none; b=OtJKNONc6JVeC1sHCR//c+C6UwR6xs9aVMbw87T5UYw+g/tH6wR96itBjM7IA63ti67xWQSWvVM0sEC3JF0gFPKd3XqsbVDWAcwG69zTAptgt5th7oYaIYiipZ8pX6+Ck61a7sEWYdRbgmOVnhJtSluQD1JAkTUvVcBfQDnA4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127636; c=relaxed/simple;
	bh=hy0G9epWXDKCaCY0Upw52ePQXUvJJEtIwYGUMPEBuio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oUDRjMTnGdrGp31oQ7qx9aOdqYL7prZtBn4TNDgXc4xsOE3wYwpvlwT0ODABlBdu4qoUnHuqYgkHi7F0YdPt+rhEyZvlJcjsuRk+3aopopkK0vgTLg+2X2XV9pkWSeJVCtP3zD0csBHpULmQNIzo6GudEnVrySXr4JAjxs6U24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jss80Oh4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42165f6645fso11523155e9.2;
        Tue, 11 Jun 2024 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718127633; x=1718732433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2jtscPaj1s5RfDyKqr1Qb7Lh4VydRrL5+CNXWVwjXQ=;
        b=jss80Oh4ar8c6ifkIlcyuVN0OQesAbwWWm/CJQtONweXNZ2H3FTAU69d61clQqXoPI
         7FznvzJE6bIIcCRDFk0lISGUg1kl61kB5fBRSlW28HpA5bzoLb+wWio2ppXVkVYcgMU+
         MWsnYfIAg8Qmsphct1ObVYcEU7sZWeq6o7zOBD8nHK3dFkGMxGlK/PO6kJaofYrYLr81
         P43ZSD00g6vQTls/0rmWJWncUOR5kM58ZxgeVj3GwmAFk7eFRwhf98CuF2NNwS/uiu1t
         k4xy3gCPz9xkDT5F/4ZT70ktpLOnHdb4b0ffLaEkaPiVbgfHvsjCuJRuoUl7jgeXtW+q
         rBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718127633; x=1718732433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2jtscPaj1s5RfDyKqr1Qb7Lh4VydRrL5+CNXWVwjXQ=;
        b=m9eIwYd8RE2eU/WMb2KFAPA99BIBLDjg1RwLM66PBJuQYK80GgjaM12o+GfckjQLQ9
         69Zbpfegp3TxinBSceNqVE4nnIgMDIUp4BvQe1pmLt0tH+L9/OvwWyqO+XlSfJoqOk1A
         GDMKn3RDDNFy86Bng68mD5LQ55uY4shWZ7FIPuwvNlR6XYa9JwkL9YShcwnudb//U8cQ
         D0g2gnKEvJq6SVmMksdLfZzfCNj3/yAs7DR8gdieXNPpPRmON9LAt1TZ7uad29A0C4K0
         DScdNB56IOjV+66gpawzwWOzzmBrAOHaFnsaDaIuQmoR0qxsoeAP5jMMCOlhCTAvg+K0
         G7hA==
X-Forwarded-Encrypted: i=1; AJvYcCW7EwaacVF6zuNJTTnLSi+Cna5BT6mjAYpRqAfSabYZbzcpUNnkx+T4VlXhs4tbIePZGleHbyK11IdSBTo4tJgTt1Ezdz2gbGWHtO6DmsVchLwIzWK/5X25hrSoBlwwVeqQLGEtldtqBrk7qU4iyYu8se+BSyCJnKC98E+e1KAk1zf8wRCekYtY
X-Gm-Message-State: AOJu0YwBjme5jTAttrKcI651yGgNPWxaT6FLx7fWv1ej+Ti1vrJmOFGY
	uwQ86zTorJTQkGuQsCXPnwoX8XqQrsqlS/nIElOv9zcq81dNwJch
X-Google-Smtp-Source: AGHT+IG2KjEUTAFMQXwtUY+IRSQMPDXj2Mbd0IGeuliD4OJO5OiISRZysMdmipTrV+NDZCjJvP69/w==
X-Received: by 2002:a05:600c:35c8:b0:421:81b8:139a with SMTP id 5b1f17b1804b1-42181b813a0mr63599075e9.12.1718127633270;
        Tue, 11 Jun 2024 10:40:33 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421be4f0a06sm87232435e9.21.2024.06.11.10.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:40:32 -0700 (PDT)
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
Subject: [PATCH v4 0/2] rcu-based inode lookup for iget*
Date: Tue, 11 Jun 2024 19:38:21 +0200
Message-ID: <20240611173824.535995-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I revamped the commit message for patch 1, explicitly spelling out a
bunch of things and adding bpftrace output. Please read it.

There was some massaging of lines in the include/linux/fs.h header
files. If you don't like it I would appreciate if you adjusted it
however you see fit on your own.

This adjusts the state to what was suggested by Christian.

Specific results:

ext4 (needed mkfs.ext4 -N 24000000):
before:	3.77s user 890.90s system 1939% cpu 46.118 total
after:  3.24s user 397.73s system 1858% cpu 21.581 total (-53%)

btrfs (s/iget5_locked/iget5_locked_rcu in fs/btrfs/inode.c):
before: 3.54s user 892.30s system 1966% cpu 45.549 total
after:  3.28s user 738.66s system 1955% cpu 37.932 total (-16.7%)

btrfs bottlenecks itself on its own locks here.

Benchmark info in the commit message to the first patch.

fs rundown is as follows:
- ext4 patched implicitly
- xfs does not use the inode hash
- bcachefs is out of the picture as Kent decided to implement his own
  inode hashing based on rhashtable, for now private to his fs.
- btrfs handled in the patchset

I have not looked at others.

v4:
- only provide iget5_locked_rcu
- add a btrfs ack

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


