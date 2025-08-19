Return-Path: <linux-fsdevel+bounces-58305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B781B2C6DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D375E1698
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE04C263C9E;
	Tue, 19 Aug 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq5pCF9k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56A2472BF;
	Tue, 19 Aug 2025 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613115; cv=none; b=MZhVvCLmZuwvg4Rfz0gyzxnmPvmAID+Jm3sJPaglT1P5Ay4bcuM3jH1PtF6eeDARbo6z5UVoOS0UMWA8Zv+bl7e2wqSxDzgy34yEHHbL4ZJo4E+31m9wQa/cUQk2NQchROmU5wYdNbsmBWDXnGpgKSGMP0r2mQyQ3duB3193DKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613115; c=relaxed/simple;
	bh=1OuqIqlTERQuQ9cRqHphXdb1JqzXADrfv4Mv57MjZbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTnXK4tFi8WGbk1MVYNOOPFO1mgczMVbWOswP+Uajiqmkw3fczhQH3vOzopjlLeac4kgGdZAtPXcwQgqvFoYW3kqNugKe5k/iAfKuzB2zKUKq2UIxsckaeAgw0usq8JjiLHEc9G0uvNhMbmNy+0s+a0EB99lLD53u8Ezrd/hs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq5pCF9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDC2C116B1;
	Tue, 19 Aug 2025 14:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755613114;
	bh=1OuqIqlTERQuQ9cRqHphXdb1JqzXADrfv4Mv57MjZbo=;
	h=From:To:Cc:Subject:Date:From;
	b=Mq5pCF9keQDmVL6n4ot8YsITjc7lTeL3B1yCQl6JXxPOxFMOgew8kSRgwQohpvtSl
	 D4kC9rar7kRFoJGaPkG9DLEkYw5dR1kj+N6GoMgo5HojaIHUMtGgbn+VPOvG06aKul
	 M1p90FDllF0+WD32372XvKbUEdLlNH5j+WjulKr8Su6PqwZG5kFMgF4H35C4+y7qEh
	 VfR8qa3XAT7gGvpiaOLkrf/c2xPjoxMmEAKMt+xxLGIs6XHNe43wv2hPsUIkx4Iz4E
	 sOG8CpOXNKFN/5sB2n/l3/aDAA6q2S41IBrm8yhMcsR/UXsl+a8sHj7viCu2/bpMrj
	 HKhCAv2rw8RWQ==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 0/3] Initial NFS client support for RWF_DONTCACHE
Date: Tue, 19 Aug 2025 07:18:29 -0700
Message-ID: <cover.1755612705.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patch set attempts to add support for the RWF_DONTCACHE
flag in preadv2() and pwritev2() on NFS filesystems.

The main issue is allowing support on 2 stage writes (i.e. unstable
WRITE followed by a COMMIT) since those don't follow the current
assumption that the 'dropbehind' flag can be fulfilled as soon as the
writeback lock is dropped.

v2:
 - Make use of the new iocb parameter for nfs_write_begin()
v3:
 - Set/clear PG_DROPBEHIND on the head of the nfs_page group
 - Simplify helper folio_end_dropbehind
v4:
 - Replace filemap_end_dropbehind_write() with folio_end_dropbehind()
 - Add a helper to replace folio_end_writeback with an equivalent that
   does not attempt to interpret the dropbehind flag
 - Keep the folio dropbehind flag set until the NFS client is ready to
   call folio_end_dropbehind.
 - Don't try to do a read-modify-write in nfs_write_begin() if the folio
   has the dropbehind flag set.

Trond Myklebust (3):
  filemap: Add a helper for filesystems implementing dropbehind
  filemap: Add a version of folio_end_writeback that ignores dropbehind
  NFS: Enable use of the RWF_DONTCACHE flag on the NFS client

 fs/nfs/file.c           |  9 +++++----
 fs/nfs/nfs4file.c       |  1 +
 fs/nfs/write.c          |  4 +++-
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 34 ++++++++++++++++++++++++++--------
 5 files changed, 37 insertions(+), 13 deletions(-)

-- 
2.50.1


