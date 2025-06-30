Return-Path: <linux-fsdevel+bounces-53270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3715DAED29D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1FB1643EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801092036FF;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="n0OMzPXC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A391B5EB5
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251983; cv=none; b=A/TDWGY7M8fp6yYaR5xLHIOKz1gYsK5W/KvZ+rJu00BPYyEs/QZbLre++9uMx1Z1yd9BzGUyOMzSgpFrzhTGC1XJXWA8Fkua6svZmsxaPLM0Ipgwc1oIFvutb8BMbSBiLiIS1H5neNnyzFsyzRuykl/CGqFtd3VzDwf10jhH+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251983; c=relaxed/simple;
	bh=bP3mAcwwFqJvdV/kT8dBX2CwSzhZGK+YCAxLqKT8NxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEQwD5KuiJWD6I99TTnU+5t0R7xOrX8P7cCfvs+MnGr0ywLh7yocyGM8DKWu7JSdxYjso8uRg8tMmo7hfbZt74ATpuX4RFYhhgAn79sR2auU8dWgtH73TFZHclF+U45yJ9vMH5wGeO5ISgWO09KoK2VSss0t5efA4We9evMlacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=n0OMzPXC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/OhfjPgOQ3SaMUTUXqCJWon9daCoL0cDARteaxKxwsc=; b=n0OMzPXC66gKl1P3d3D11tmngK
	0Is5FwDOzslpT/tonKSOGvhXDb/CQgV6wRbwXtyrDgSo8+2tLmiNx+lnVoR/AVYDE4IdZPn4ZE3PR
	i0fUI9TELnxAvXOc0n/+0+0+9TVQugX0JPLdcik/bAwhMNKmK10bYA8ZzZE/Da1QApTSHUETOouH9
	K2vx5KWCrRDFbAnvnp7F5tkY+b+R1AT8t0kZz2w0u1W5TzGGJDt7lnvfqG1pu9LTmjb6W9pCK2MMY
	1Y/CH7bHtRlEx5Ol7PGjUaJbP4LZHeu/dDBPm4C97v2+r5w/5ku8eA8JwF05teBcCrf0333JMKtai
	fKGERVtA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4de-00000005p1b-3xH8;
	Mon, 30 Jun 2025 02:52:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 33/48] propagate_one(): separate the "what should be the master for this copy" part
Date: Mon, 30 Jun 2025 03:52:40 +0100
Message-ID: <20250630025255.1387419-33-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

When we create the first copy for a peer group, it becomes a slave of
one of the existing copies; take that logics into a separate helper -
find_master(parent, last_copy, original).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 7c832f98595c..94de8aad4da5 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -232,6 +232,31 @@ static bool need_secondary(struct mount *m, struct mountpoint *dest_mp)
 	return true;
 }
 
+static struct mount *find_master(struct mount *m,
+				struct mount *last_copy,
+				struct mount *original)
+{
+	struct mount *p;
+
+	// ascend until there's a copy for something with the same master
+	for (;;) {
+		p = m->mnt_master;
+		if (!p || IS_MNT_MARKED(p))
+			break;
+		m = p;
+	}
+	while (!peers(last_copy, original)) {
+		struct mount *parent = last_copy->mnt_parent;
+		if (parent->mnt_master == p) {
+			if (!peers(parent, m))
+				last_copy = last_copy->mnt_master;
+			break;
+		}
+		last_copy = last_copy->mnt_master;
+	}
+	return last_copy;
+}
+
 static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 {
 	struct mount *child;
@@ -240,23 +265,7 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 	if (peers(m, last_dest)) {
 		type = CL_MAKE_SHARED;
 	} else {
-		struct mount *n, *p;
-		bool done;
-		for (n = m; ; n = p) {
-			p = n->mnt_master;
-			if (!p || IS_MNT_MARKED(p))
-				break;
-		}
-		do {
-			struct mount *parent = last_source->mnt_parent;
-			if (peers(last_source, first_source))
-				break;
-			done = parent->mnt_master == p;
-			if (done && peers(n, parent))
-				break;
-			last_source = last_source->mnt_master;
-		} while (!done);
-
+		last_source = find_master(m, last_source, first_source);
 		type = CL_SLAVE;
 		/* beginning of peer group among the slaves? */
 		if (IS_MNT_SHARED(m))
-- 
2.39.5


