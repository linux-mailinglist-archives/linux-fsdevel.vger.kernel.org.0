Return-Path: <linux-fsdevel+bounces-46650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2691A92F8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 03:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018A98A860C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 01:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C7263C7B;
	Fri, 18 Apr 2025 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="nx/mo3SO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from buffalo.ash.relay.mailchannels.net (buffalo.ash.relay.mailchannels.net [23.83.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CD25E820;
	Fri, 18 Apr 2025 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941584; cv=pass; b=ib8CNCrlIxiMvu5RHJW5xGTFa9yKxS82uJIVyc1jUV+BHqUuSb4D46xhUSpDjtlQRNssD6ghThAXgJ6bw7jK9SQnd3egQFXvh8IPWuJXSXHAeDS++7iqv+JgJIdgSfCcvbw6mTZukjicjNZmF5B4XYN3z5tuRzkw+/DRlyCyb4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941584; c=relaxed/simple;
	bh=LKBtEzqeMV0deJd58dXfl0HHlLeK50qj83WOVY2Gmss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fWFy2uonqPqj+27im7AvJlswGod9+MRfu4GEN4x4UoZSl4I2A0T0bL6eTxluezHpfk/06RvkIOliAVRgCef13vcPZX3EbLm1vvaLIIccDyrx12EVhG0+nlun2RtL4elEfkw0NEoSFj+vRF0d3pcjmX1IgqouOKLJOF3TG5AvCYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=nx/mo3SO; arc=pass smtp.client-ip=23.83.222.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 03C881616BF;
	Fri, 18 Apr 2025 01:59:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a285.dreamhost.com (trex-2.trex.outbound.svc.cluster.local [100.109.34.158])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 88823161851;
	Fri, 18 Apr 2025 01:59:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744941573; a=rsa-sha256;
	cv=none;
	b=ExVDzOjZKaeTR8gi/JVqBKPXvusbaA01+0Dq+DY/xcUap0/1/UyUs5471j7xFj4nKn+jQZ
	WkvRfiF4eu1L3RCtwAgOm3MDc3RQRU7KIXtClHTLrfhTYKaucxDiED7OrzqDlTOxhx0hKE
	Z4l73BstflY+Pr+uOlAf1902AviNBzzoy67aN3H4Thfz/9zyKFaDv1wfVzajHL8pO33F5F
	dR3WWT+kusVkKzrP4NP0U1AlWiC1X9/+80f1/0ivt1Tom52xDc5MT90illPKNZurBSQDAi
	+Dt+GXOboeUMsMSxX5D1a9AFZprQfYgCHXx7i7jPdOmv+7ygGTmMJ7j+/dAUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744941573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=DqkM8F2/SD65YUArF5AEfZBkQPAmA5Kpq2ps1+aBLBg=;
	b=ttI+pUBBLI8/74dzbadbHMFHT8RjK8SA+ZN/+4HGFxFl1J3E2PNxEQ8BTyeASp0z68+9JA
	2sC/JaOo5TklHn/ThEvrkuk/xpY2qeOmfB3TZ94u7pbi/r6zxdtH+6tZEAyyp1TsKsAgUv
	zRNWkE2bXmkIz4v/4va3RoPpJdr2JHXn1j1PopFOAFCcHL2Gmg45m1GIHTurG/lsKMlpn1
	zOLB95p1GHGbthCM2R/inPypBoIhneY6kCfsaEatQcmJeGmJza6OkqdKXAWkT2VJRvBCJs
	SfLzvTFIFp5ZPMklUP1ZaLcHo+bGRFnKWe6DaWuKIEkawW8DtT+siUOmqfZV6A==
ARC-Authentication-Results: i=1;
	rspamd-7bd9ff6c58-xxcc2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tart-Cure: 78d4b7ca06ee9704_1744941573854_4064517488
X-MC-Loop-Signature: 1744941573854:2683204789
X-MC-Ingress-Time: 1744941573853
Received: from pdx1-sub0-mail-a285.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.34.158 (trex/7.0.3);
	Fri, 18 Apr 2025 01:59:33 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a285.dreamhost.com (Postfix) with ESMTPSA id 4Zdych55ZXz88;
	Thu, 17 Apr 2025 18:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744941573;
	bh=DqkM8F2/SD65YUArF5AEfZBkQPAmA5Kpq2ps1+aBLBg=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=nx/mo3SOhBiSbQ4UbuEYiS03sw0BaL+D0WKNtxjiKYjS2MvTtvSitRBkfahKZdRRs
	 x/Y2e8kXo25aJKgbRgGu6DqNjWfDajmOoVMhHFcPKO7u34YC8T8uqsLI36M60cg86E
	 kGySmz+gBWgJij0b+t2x5Ayccq1HVMWcStHj1ntwx+/b9Vhqx4nmqfgz4fOXfxM/M9
	 xAXwFu6q1cP39hysdv+M6OpMJJYqNY3KsCVbvpRTWcvn9B39f5KeAcYuugX2Zk6msR
	 xfc14iFdi57r4VCG/CuU0Hy24JKxIdR5h3HLUWXI3upEfw1J8D8uuFeemIQgfXdW6n
	 +pCosi9hOrgHA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	brauner@kernel.org
Cc: mcgrof@kernel.org,
	willy@infradead.org,
	hare@suse.de,
	djwong@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v2 0/7] fs/buffer: split pagecache lookups into atomic or blocking
Date: Thu, 17 Apr 2025 18:59:14 -0700
Message-Id: <20250418015921.132400-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from v1: rebased on top of vfs.fixes (Christian).

This is a respin of the series[0] to address the sleep in atomic scenarios for
noref migration with large folios, introduced in:

      3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")

The main difference is that it removes the first patch and moves the fix (reducing
the i_private_lock critical region in the migration path) to the final patch, which
also introduces the new BH_Migrate flag. It also simplifies the locking scheme in
patch 1 to avoid folio trylocking in the atomic lookup cases. So essentially blocking
users will take the folio lock and hence wait for migration, and otherwise nonblocking
callers will bail the lookup if a noref migration is on-going. Blocking callers
will also benefit from potential performance gains by reducing contention on the
spinlock for bdev mappings.

Applies against latest vfs.fixes. Please consider for Linus' tree.

Patch 1: carves a path for callers that can block to take the folio lock.
Patch 2: adds sleeping flavors to pagecache lookups, no users.
Patches 3-6: converts to the new call, where possible.
Patch 7: does the actual sleep in atomic fix.

Thanks!

[0] https://lore.kernel.org/all/20250410014945.2140781-1-mcgrof@kernel.org/

Davidlohr Bueso (7):
  fs/buffer: split locking for pagecache lookups
  fs/buffer: introduce sleeping flavors for pagecache lookups
  fs/buffer: use sleeping version of __find_get_block()
  fs/ocfs2: use sleeping version of __find_get_block()
  fs/jbd2: use sleeping version of __find_get_block()
  fs/ext4: use sleeping version of sb_find_get_block()
  mm/migrate: fix sleep in atomic for large folios and buffer heads

 fs/buffer.c                 | 73 +++++++++++++++++++++++++++----------
 fs/ext4/ialloc.c            |  3 +-
 fs/ext4/mballoc.c           |  3 +-
 fs/jbd2/revoke.c            | 15 +++++---
 fs/ocfs2/journal.c          |  2 +-
 include/linux/buffer_head.h |  9 +++++
 mm/migrate.c                |  8 ++--
 7 files changed, 82 insertions(+), 31 deletions(-)

--
2.39.5


