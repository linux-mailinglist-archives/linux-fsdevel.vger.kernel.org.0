Return-Path: <linux-fsdevel+bounces-45042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBB8A70953
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 19:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EDD171E5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729A21F3D54;
	Tue, 25 Mar 2025 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYcWVURq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8C1F3B94;
	Tue, 25 Mar 2025 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928155; cv=none; b=GkDb70itGq13rOji/cdxE7WDLLAKcJjisbunV0luWbKdcFCbW/2a1yiY0A1EAmI/SY9mj3kh4VQgQ1crNzEk4kXLjijTFeRTavKRncbpKKEq34uoiNr0T8CXpt2HewqvJCn7XEHdV2o+i68JGqhTcKYnnxWCU1ytQLWUU2fMMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928155; c=relaxed/simple;
	bh=70LDVfYt6ryFikxs5Zc6nLO59eM2YSuiLbb1gCwwUno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H5Mw9cg5WTs2CP3p+Oty8WIoGPIv2yeNKAYcT642FnmJ/OB1wCDKCuj6kiOGzJG6tg0C0pwUzQ/NW6prJal4Tsk1sxXdxKteYNLgIzPcNhQW1eU3VlLDqK6ubzFvgnzAe6W0z43pNLoBsbTvthTgwERF/eyPrCZurGK9OIjkv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYcWVURq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46D3C4CEF4;
	Tue, 25 Mar 2025 18:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742928155;
	bh=70LDVfYt6ryFikxs5Zc6nLO59eM2YSuiLbb1gCwwUno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYcWVURqIwaCtmAZiE0YLRzuHlbY2G2BDsGQ4QuYHEgBc9/XAgVVSEOYgSb7f4A8z
	 aXidqYOIhn4eUKEOs9cHVaDOq1JnC3Kp41qibpxafbvUn+w5MK56x/NtQehTJIMlBz
	 /FBuFxMQELgAj8pxJQ8vJmZ4G0++oyIBsWh1ol60tlTVgw1CYFOs7rrVCj5yXDScdY
	 3OXbo+psyWBcW9cydHw4fzotq1jvBa5IMlTzJFCvxoVFSPNLkQ6X7o8vJ0zbMI8x5p
	 aMLiqayLwMi1N9Vg7Mt+AqsWWvyIOcf13G1mCww0WAyHzS6OIRum9K5H5hwmlN3+jJ
	 EXIbTJVp0X3Aw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netfs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 7/7] netfs: Fix netfs_unbuffered_read() to return ssize_t rather than int
Date: Tue, 25 Mar 2025 14:42:15 -0400
Message-Id: <20250325184215.2152123-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325184215.2152123-1-sashal@kernel.org>
References: <20250325184215.2152123-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.8
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 07c574eb53d4cc9aa7b985bc8bfcb302e5dc4694 ]

Fix netfs_unbuffered_read() to return an ssize_t rather than an int as
netfs_wait_for_read() returns ssize_t and this gets implicitly truncated.

Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20250314164201.1993231-5-dhowells@redhat.com
Acked-by: "Paulo Alcantara (Red Hat)" <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/direct_read.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index b1a66a6e6bc2d..917b7edc34ef5 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -108,9 +108,9 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
  * Perform a read to an application buffer, bypassing the pagecache and the
  * local disk cache.
  */
-static int netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
+static ssize_t netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
 {
-	int ret;
+	ssize_t ret;
 
 	_enter("R=%x %llx-%llx",
 	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
@@ -149,7 +149,7 @@ static int netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
 	}
 
 out:
-	_leave(" = %d", ret);
+	_leave(" = %zd", ret);
 	return ret;
 }
 
-- 
2.39.5


