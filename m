Return-Path: <linux-fsdevel+bounces-10198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABBA848A73
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F3D28520D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2583567D;
	Sun,  4 Feb 2024 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Br94/XyO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB0D6FDC;
	Sun,  4 Feb 2024 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013064; cv=none; b=QuQVn7JhECpnVputqqzF192n8N7hqDCPbXEZFmLhGkpebKFfwy0i1Pms26/Oc2g1F+GY04zkW2Z4+ZatbHV9MklwNAP82Z9w5J+1sW1AFWC0v6u2ydMQK2YBR0ietuuTRkvbOejoWooXwkI6AzfkzdRcPNXA6qa7yiDBxQhhq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013064; c=relaxed/simple;
	bh=5PEjSfqBc+iRYNChNww87Qinyt2iIPQDllUAPWBttFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KYMtZ9inaDDl3bBmfm6BIcpyq52ZKjs5llhSjELjLRVdVtBr8mwbeSO8r+b4xrSSJuvycfcC/389VcWItVVIVbfW9fGyWNGeBhwT8uPqjiDgd2u6ZgGpAqHng8tlsc7dTFHDrbx0D7KbzB87HY2Pg+WrJtIjHWexqDlgEWPWv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Br94/XyO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ug2Y34xz5+mbpB8ClVi23teq0mMkMZtGfWZr82RpmBQ=; b=Br94/XyOhQiWIXAAuSQKmxkqqO
	/vVYbOvlfvO+Jva/uJh+scC9a9TYI95TAb0K+29rPGnQ5TktMkTxLipLaFrVwlKZLfVAM70wzGpkQ
	ZmuBfZlBiBG6+A0S941L7vFGj80X3ZseYCrOjt3lIUgJxDtY52bUdKORzENqsdoX6kld2NYpVgyRl
	Wk6HrwTlb9sOWRaytkOPeRtwW1185UuBE+KYxzTEkZmgLZyIJrpr9tWqJgcMkYoJItePUdAu+BCQJ
	TH2EhCPIK0U1ugJ0MTelBO1oPeMaIEMqsJt2F1gQuKWQWHSRv5VItYqY8gizscfW42jNkWPtqAuJp
	ZWQfaGHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4i-004rCt-0y;
	Sun, 04 Feb 2024 02:17:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 03/13] affs: free affs_sb_info with kfree_rcu()
Date: Sun,  4 Feb 2024 02:17:29 +0000
Message-Id: <20240204021739.1157830-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

one of the flags in it is used by ->d_hash()/->d_compare()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/affs/affs.h  | 1 +
 fs/affs/super.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index 60685ec76d98..2e612834329a 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -105,6 +105,7 @@ struct affs_sb_info {
 	int work_queued;		/* non-zero delayed work is queued */
 	struct delayed_work sb_work;	/* superblock flush delayed work */
 	spinlock_t work_lock;		/* protects sb_work and work_queued */
+	struct rcu_head rcu;
 };
 
 #define AFFS_MOUNT_SF_INTL		0x0001 /* International filesystem. */
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 58b391446ae1..b56a95cf414a 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -640,7 +640,7 @@ static void affs_kill_sb(struct super_block *sb)
 		affs_brelse(sbi->s_root_bh);
 		kfree(sbi->s_prefix);
 		mutex_destroy(&sbi->s_bmlock);
-		kfree(sbi);
+		kfree_rcu(sbi, rcu);
 	}
 }
 
-- 
2.39.2


