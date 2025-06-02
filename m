Return-Path: <linux-fsdevel+bounces-50339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10460ACB0A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E7E16FA33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1462221FCC;
	Mon,  2 Jun 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJpFQuRZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160822D4DC;
	Mon,  2 Jun 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872961; cv=none; b=m5cak7eNS6lChRaxSYm3Z9SJp732NgnY63GSWk2QLbsRnJBfIVLXf/eD/rnOHV71bSPVwhlKTuqubwWN0DZ1+t/0qaQZBu27LEDOMaVn8NvDvWAvDsaJAujYh1Cu9P5GQrptojl+IU6nfJ9rCjTEbNz1jKyHPPU61E+WT8X+2Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872961; c=relaxed/simple;
	bh=sCsTeakzmLBzU55l4qTabH3TVaofSjNDyRcERU8TUrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NS53pOXoCAUbBMHIfOtCOazuj+ilCWKLXVdOUT4ve+BQWhzs6Sv0G2kJruVUtDjsqlYH2ohBXA9MtElqHhuTnoFXqKzmktDv5QiitPbrvngjsUR9KB13w1od26uCxVxV+RhMdE+Q22d47frexf5m0NKvx+dWBV6+0jV0kXrql5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJpFQuRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4DAC4CEEB;
	Mon,  2 Jun 2025 14:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872961;
	bh=sCsTeakzmLBzU55l4qTabH3TVaofSjNDyRcERU8TUrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nJpFQuRZC9Bp7IUbrhVZ7dAy0TNpGw4Lw1NrsMVOoVShi2WImzXOcf3x47t4cDUiY
	 nQB4FqEosgWxM+ByVUeI2wxTEJANgvXgygDvbmawNq3Rekt93tI+2gmvTssdg1nRny
	 N6PTqWV8S6HfXE+pyGFWU5XoUIQiKwkxGrjYzqWBvSdYCY/vvEcxBdWAKHze/J4woR
	 kvaIG+VypIjaHPWPvDFBuVqTmLI+8CkIgesA36Yr/VnzpBSU1rQliQQnoJ7mi26Y4J
	 CONEuuzIercH/Tq9ziRAjAtOlQBHy/Ju+Rpm1bh6VIL0eX75pGzdbWdLM/jZQ6CmJx
	 C7tMeCqIPkcCA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:52 -0400
Subject: [PATCH RFC v2 09/28] filelock: lift the ban on directory leases in
 generic_setlease
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-9-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sCsTeakzmLBzU55l4qTabH3TVaofSjNDyRcERU8TUrA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7mg/CU9cxONu7wXEylEjIwRT5FCqxpjkF1j
 9V5N4aHR7WJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5gAKCRAADmhBGVaC
 FecmD/4rTaNg5RZIP6ruF+A7YjAsnEIyAaPD2SK7nfgwQ+xe9hbNyovhbDTKoeDxuYJMuLIh1nd
 RQDQLHSDLa1ZTR8TU65vxgFt0t3KtyLzDus0p+1Ht8f3vzbgt8hkP6NzObppNXBrsiOWGWDQ5va
 B2ORUcafxjFRbYYAaEApJUft6nLBbhIj3ZNcEEsn6GhB89MPHM9KfJQl3MyaAh4RQvVr0205NDr
 5ibhgUX/EOwgglZ1vUvfbwTqpdDg4PIBauu/K3APlrghSzQk89R39caolXdwkK9nAOO1mzLAb9m
 AhgRK9nKV9Hs2A2xfoCVu4x3k3zDlDjOB9hBsP/8B46DLwGU8OFaF7KhOMELAtbgD8kcvTYYkLT
 UVadauu/x9XqjW1ac+jL+/JF2PEfD9uE2p4Q1UFC7JlnvHsEwkA5XwFIawAtAakyOzjnUP7QIEP
 /QwWKBGuU4uG/ICRJLKyrXX8uNid2xUBcM5VbIJLiYOq0IkiGoc4tKZx6XeR298doDerrbqune1
 Shnw174hsiSptya4YjZwQ1NhOFtA4NO0SXXryRK80NgJcdF9yKgqloP/96fBKIZHgCZdXHZNs/V
 N5w5EwhN1Kmf/owisRyuyt+Y3W8D/LQ+AdrbZAAUlLr5iyGbv870xHLw8F9+9X4BBh6uqvEVAa4
 eUVJxGwC24fh9Hw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the addition of the try_break_lease calls in directory changing
operations, allow generic_setlease to hand them out.

Note that this also makes directory leases available to userland via
fcntl(). I don't see a real reason to prevent userland from acquiring
one, but we could reinstate the prohibition if that's preferable.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1985f38d326d938f58009e0880b45e588af6a422..82a1b528dc9dae8c1f3a81084072e649d481e8f1 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1934,7 +1934,9 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
-	if (!S_ISREG(file_inode(filp)->i_mode))
+	struct inode *inode = file_inode(filp);
+
+	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 		return -EINVAL;
 
 	switch (arg) {

-- 
2.49.0


