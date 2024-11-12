Return-Path: <linux-fsdevel+bounces-34537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012119C61E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872251F24940
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D4219C8C;
	Tue, 12 Nov 2024 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="CvjabDkU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9733B20898E;
	Tue, 12 Nov 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441348; cv=none; b=jdNk8zqzyQ9oc7PSv23JPZ5awWuumjTP4yndSi8aIaA5gvW47/2nzQyE9j0tRCObm7Ddazps8Pli99R1Qa5j7Zi1NJt8mlW/zOBRFov4SPw3JeHUph+/Jt+kuud8ylAYmIwMVlzabCL5YibFgoNiIOQpZ3AHtbXouL0GZU18/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441348; c=relaxed/simple;
	bh=c94xZUz5BVRzxe1+uUbcC3auFTeo4NkaFnXe7tuvETA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UXvLcUx++nHWX661IHTRZ3BksKvQZtqwapdt1LdohmOk2Zayu2QTUyq/VZUIg/GHLkMKG7509Mg0Zxlz7wl072NXdRwvdE9X3dLJyc29ZUy+aLP7a1DZyuAv2a7S7Cv+/q4icY9iCUaz+aKSywQoqn+4ya05wKP1vnu5Q9wt8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=CvjabDkU; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 03D693FA6A;
	Tue, 12 Nov 2024 19:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1731441334;
	bh=c94xZUz5BVRzxe1+uUbcC3auFTeo4NkaFnXe7tuvETA=;
	h=From:Date:Subject:To:Cc;
	b=CvjabDkUJUSSXOJExrmb9n9jBWbldd3zbnbE9fOlnTjyQwUZCmqg0TUWhnljH/jH5
	 CcPFuMlQTtrFxrcpE6B/sP5SsTJXWIaKQWLYknOW3VBEXE+ES6/Z6nugx+eK8q15J7
	 K0LiHQZFuXYs635KqwUosvSHPxw/lcwFZrWLln45qW+hxK232vdZOFUcrp/QQrYxhQ
	 VJeqgt36Ge5gSb6vYokcL9Q9bPcNj9mYvjhhx82H8NldKKR/X8Gj21XI7sGBBtSJ8o
	 hmhEr4yzK73oc6tpjRpFH1XuPjKwyZxNG0r+Vsbr29YmWbLZbqKzIXFugT1CRrt1rb
	 cYRj70mJJn26A==
From: Asahi Lina <lina@asahilina.net>
Date: Wed, 13 Nov 2024 04:55:32 +0900
Subject: [PATCH] fuse: dax: No-op writepages callback
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-dax-no-writeback-v1-1-ee2c3a8d9f84@asahilina.net>
X-B4-Tracking: v=1; b=H4sIALOyM2cC/x3MQQqAIBBA0avErBtoUqS6SrRQm2oILDQqiO6et
 HyL/x9IHIUTdMUDkU9JsoUMKgvwiw0zo4zZUFe1JiKFo70xbHhFOdhZv6ImNs4p0zbOQ872yJP
 c/7If3vcDv70xw2IAAAA=
X-Change-ID: 20241113-dax-no-writeback-41e6bb3698bc
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, Sergio Lopez Pascual <slp@redhat.com>, 
 asahi@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731441333; l=2006;
 i=lina@asahilina.net; s=20240902; h=from:subject:message-id;
 bh=c94xZUz5BVRzxe1+uUbcC3auFTeo4NkaFnXe7tuvETA=;
 b=RITMZ3OffyOGQq+meVQPdwN87olVlNUBbNxkxDcqPQQ/ROTA+RYl1EH63EH5poTnKOMEOUEBi
 mvNOmc+uGmjD2yAbLq0Or+s4ebqCvcJ14c21zu/Ww52zWMgLazBtDyC
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=tpv7cWfUnHNw5jwf6h4t0gGgglt3/xcwlfs0+A/uUu8=

When using FUSE DAX with virtiofs, cache coherency is managed by the
host. Disk persistence is handled via fsync() and friends, which are
passed directly via the FUSE layer to the host. Therefore, there's no
need to do dax_writeback_mapping_range(). All that ends up doing is a
cache flush operation, which is not caught by KVM and doesn't do much,
since the host and guest are already cache-coherent.

Since dax_writeback_mapping_range() checks that the inode block size is
equal to PAGE_SIZE, this fixes a spurious WARN when virtiofs is used
with a mismatched guest PAGE_SIZE and virtiofs backing FS block size
(this happens, for example, when it's a tmpfs and the host and guest
have a different PAGE_SIZE). FUSE DAX does not require any particular FS
block size, since it always performs DAX mappings in aligned 2MiB
blocks.

See discussion in [1].

[1] https://lore.kernel.org/lkml/20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net/T/#u

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 fs/fuse/dax.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d170bb3091ac35a33d2b9dc38330b00948..15cf7bb20b5ebf15451190dac2fcc2e841148e6c 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -777,11 +777,8 @@ ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static int fuse_dax_writepages(struct address_space *mapping,
 			       struct writeback_control *wbc)
 {
-
-	struct inode *inode = mapping->host;
-	struct fuse_conn *fc = get_fuse_conn(inode);
-
-	return dax_writeback_mapping_range(mapping, fc->dax->dev, wbc);
+	/* nothing to flush, fuse cache coherency is managed by the host */
+	return 0;
 }
 
 static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf, unsigned int order,

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241113-dax-no-writeback-41e6bb3698bc

Cheers,
~~ Lina


