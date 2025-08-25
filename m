Return-Path: <linux-fsdevel+bounces-58904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B45B33569
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CABD3AD700
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D242B1465B4;
	Mon, 25 Aug 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FJSeQbX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7390022A4EE
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097039; cv=none; b=ssRmtie6H7wLYyk8U2SlbItRquC2HBv7xbGFvRzpAJnIDjLY3e0lxq1SsHMJJABXs+FTNbPwnCXxjrfvCbX7s3RgC90hM0WBkl9jnmla1UjS4oMMXTD731dT15zRAgYHW1dCNVQV6V+IIwBgVX4C7crSlfHVbfH2qVNyTWcO7T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097039; c=relaxed/simple;
	bh=smPscajj0qrtYzIhMU5FhSdLhMY6rr2CfdA/9S406vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRiewKCeg/RHEz47BM5OCslxdn9/gNg3fQ2EfxI/WUsXzJdCqWeRDj6eCj09n3zsR3w+nu1HW45DT3m6Lpz2c6DD6/Y87n9OrKvdXsPl3QADhDAZuUNAtu6zYRZTmq+sIjNoHCxUblhvzP2yfxXp1/iKEOTkuMBCZEbw3biWJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FJSeQbX0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fN/hC7M/oN+/Je/I//SZeJ5lcFd55fEOpS0+QLvd+m8=; b=FJSeQbX0FWIxVH1vZbApaYuxt5
	hl/IZ2wRp4yPBsAfvl8SjmAbBoMAFB0c4zKK3WtMJ9P6mMr9tuqf65n26HmfsYk1VgWu2lnNsUGqf
	1t+uzoX5hJyS2vsPqeRKEnjwLHRW0Bome5trTI00shFO2FhV62y7pb+FJzEg3vnsnNJQCFTjbymQI
	FojwLZdJT9AhTtF/1n8q98ZZIA8/DaUGsQoB92ewKmTLPdqoaRlEi8Fwi+W5C65tfFxVz0WHGSpc/
	sZKqbFDx0gXptI8H7IjZJOWdzWhp0/WEBhfvDwMNA3d1svVuR6FVuNKTuyCB97lAPUtA3sTOJ9E7i
	Y3xxBuug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3k-00000006T8f-0ZTF;
	Mon, 25 Aug 2025 04:43:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 05/52] __is_local_mountpoint(): use guards
Date: Mon, 25 Aug 2025 05:43:08 +0100
Message-ID: <20250825044355.1541941-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

clean fit; namespace_shared due to iterating through ns->mounts.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1ae1ab8815c9..f1460ddd1486 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -906,17 +906,14 @@ bool __is_local_mountpoint(const struct dentry *dentry)
 {
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mount *mnt, *n;
-	bool is_covered = false;
 
-	down_read(&namespace_sem);
-	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node) {
-		is_covered = (mnt->mnt_mountpoint == dentry);
-		if (is_covered)
-			break;
-	}
-	up_read(&namespace_sem);
+	guard(namespace_shared)();
+
+	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node)
+		if (mnt->mnt_mountpoint == dentry)
+			return true;
 
-	return is_covered;
+	return false;
 }
 
 struct pinned_mountpoint {
-- 
2.47.2


