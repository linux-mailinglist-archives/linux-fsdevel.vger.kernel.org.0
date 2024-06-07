Return-Path: <linux-fsdevel+bounces-21174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A6B90032A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72190B227AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643E31922C4;
	Fri,  7 Jun 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="fp0aJiW/";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="The1bojn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DD0186E46;
	Fri,  7 Jun 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762573; cv=none; b=BCmQmfYLBGHMpoygOfNOh+h8my1MtzKhmagwj5hMdLzH+fEFjCHzoLCuPbQdCecNALtWUYcQ++HQhlVWX4oGyLO3GSQWyIn+xIPaA2NHUx1Flu1HIcP7g9T6YL4ySvIEsFIX2Kq5CrIOrAJHBL0VPbhw4ZyQ0A4sMFjMBW7ZkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762573; c=relaxed/simple;
	bh=YBMNvGaHXBY1iE8bR/ub81+vXUT/4Gibt/hvIi+Vp1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGEGuJGtpwC8PBtsSpiIeOEso2homK8FR3jSezWKWjk6zQNVqGopUgGfHACI8puk2aoj5X+MdcqfyBMVk/shreClflA/laVthrvo6YxwO5mJ18o1E/P/gr9p+n7AUpPHlz4jw7BWk+hY3mdu/rbc6FuTqAXVnpcG/JWE6ZFGnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=fp0aJiW/; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=The1bojn; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 4089C2111;
	Fri,  7 Jun 2024 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762096;
	bh=6p1zGEnOfUC6mKbV+PZ9lD9z8S0agv4/5/6Rd6f5BCc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fp0aJiW/xHJJxTjaEmgIfFd9RpnfHUGE6eGCNRqIRjdVy572F1x3mqoPHmInh/pFR
	 k55F3tbaJDnzmUCxNQr81KpAjFdYPNtkCBN+GfDB5jiGV3klZqFGRiRg1N0xGbdj0w
	 CuxsJ+j377cD8y2QtCJvNthCJu8JbpUlQ8PyTA2E=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 25341195;
	Fri,  7 Jun 2024 12:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762570;
	bh=6p1zGEnOfUC6mKbV+PZ9lD9z8S0agv4/5/6Rd6f5BCc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=The1bojn4lSM6xboNjP3TuFw29hQYrvbGbE8M+fvlvP2JS6Q3EJcwzlmrgKooApzd
	 HJVhKvysJiMncfCeHA7sYVFQgXe+T7oNd0BDrzVshP+bpobBql2hrm+0QgZYTfnaUO
	 As1YVQXz6lKyBsVBhigiakGK0kH5J8uGYaix7pqg=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:09 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 05/18] fs/ntfs3: Missed NI_FLAG_UPDATE_PARENT setting
Date: Fri, 7 Jun 2024 15:15:35 +0300
Message-ID: <20240607121548.18818-6-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Fixes: be71b5cba2e64 ("fs/ntfs3: Add attrib operations")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 7918ab1a3f35..0d13da5523b1 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1738,6 +1738,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 
 	attr_b->nres.total_size = cpu_to_le64(total_size);
 	inode_set_bytes(&ni->vfs_inode, total_size);
+	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
 
 	mi_b->dirty = true;
 	mark_inode_dirty(&ni->vfs_inode);
-- 
2.34.1


