Return-Path: <linux-fsdevel+bounces-45981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82C2A806FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 14:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93831B6829B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3016426B0A9;
	Tue,  8 Apr 2025 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j94qYsOK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83229267731;
	Tue,  8 Apr 2025 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115105; cv=none; b=bpPAJTdBtJ1T1++Z5s4LS1c+115jDdnCFapf2ybg3DwQrx12qPKkDVEg5dJt+pshb5LHOKRaDPpbQhOl/Lp37VE7p0xqGw01e+n1IFzVKO1Slf+r2rTv8CnlPM0GprAb88S9uWFHtjvRDEquZIcePR3JH2qKLdf802K7RTSLc7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115105; c=relaxed/simple;
	bh=MmSOLvM57cs66zF7GDOE16R+Jtk+WxqFDLA0BeqJifI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMAFR6pIQHUkJBVxM/gEhgtwud0DgLhwLnu/Vg1GFPVe3FcoYT03R2V6SzePZXt6R3/MhBDX91cRK37x4qk4mqzsujeV3XyYxxeOk7rqmudQ1caCQJLsGoO3tGKO7RfSNdojd3+xaBJUTs+VS6YCgI1IlwP6dUbBd+0CDrKGPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j94qYsOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76705C4CEE5;
	Tue,  8 Apr 2025 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115105;
	bh=MmSOLvM57cs66zF7GDOE16R+Jtk+WxqFDLA0BeqJifI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j94qYsOKukYDosGYTY/WNfTzBJq17QKxFd0QWekGIyDBXBpjhPyHCyOqTbQC8M9iy
	 Qi2GYaV2MsWwiPoLoS2f08uGPXGO/SeJAcvFFhZ08qV3umbVhZlNSOqqaqKe906REb
	 u9dLvatTx/InapWGjsjftHJSCyVWvwHyIunZ6fnM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 352/499] netfs: Fix netfs_unbuffered_read() to return ssize_t rather than int
Date: Tue,  8 Apr 2025 12:49:24 +0200
Message-ID: <20250408104900.007715615@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

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




