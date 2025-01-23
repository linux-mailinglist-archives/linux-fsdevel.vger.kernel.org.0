Return-Path: <linux-fsdevel+bounces-39911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C35B3A19C73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5EE3AD88B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FE3148FF6;
	Thu, 23 Jan 2025 01:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SJAgvUs3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC01EB2E;
	Thu, 23 Jan 2025 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596808; cv=none; b=NG1myKwq6+Ugdyh4XchjRJTnEr9kiZgYoAOyUXb5H2Re7VPP43ohbbFHJtF0VFdK58fbIBxU84StkS+c5/9/rXoGv9pqE60nmxYsdmAEkRD2jI6L1Zc2/N0CZcDwXlN8iz1hrx1d4Acx+H6yY7lTXv+5FKsZG9kD6yapq4Vae18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596808; c=relaxed/simple;
	bh=cjipL1GFfa83oqYsqi4CaR1CZyDh3FOlsTUDb2/+ndQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxTs31/ISAkl3P7BweLBxooUTzuv4nRfj6GTlJMfs4VnVrAq8kQ0cBhGlh1ZPG9Jb0Zo6Fvuum8dhvntkdp1nXGAr5zUPp4KSAOiUxxQnehwu67UQjsw00O4R1R+ItCb2enoc15Jlmkhg3mYxtKdT5mAt1h9HZ7nkiUUgjtqLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SJAgvUs3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WFTtoUbcp0ZRRyHtoXjPYLRMoe7qetYd1rA2yNEqMGU=; b=SJAgvUs3SvW9cyXku2rob79bRF
	XL5e6+2WYeKhL1b0VXcW1gkXhN6/kVNjMEAtbpnRned7VjooMFfcMQziFWZIaq2hOwjnJ1BMBfIz3
	WefTNLDu3a37+g/WSSxQWtnyw8naLfYr+rHFIaHyc+cM1Ku/lijNmMTYODiuuQolOMWlpH0wDhVH9
	3xdrzasZt/7gYH+psI2r99aLfRHSWe7HPIMHRvye1vGZxGiIdgNe2R0M2GTYqkdgQ5A/PU48uV7zt
	EA+iyulyE1H6drGzvc+hYrRwwTpE7KK/bqbGkOsuyYUIUtMiYyviNervwyoAIb7B3zRe5mpJI/iNb
	FT1AEwgg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIv-00000008F30-0J32;
	Thu, 23 Jan 2025 01:46:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH v3 13/20] vfat_revalidate{,_ci}(): use stable parent inode passed by caller
Date: Thu, 23 Jan 2025 01:46:36 +0000
Message-ID: <20250123014643.1964371-13-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
References: <20250123014511.GA1962481@ZenIV>
 <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fat/namei_vfat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index f9cbd5c6f932..926c26e90ef8 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -43,14 +43,9 @@ static inline void vfat_d_version_set(struct dentry *dentry,
  * If it happened, the negative dentry isn't actually negative
  * anymore.  So, drop it.
  */
-static int vfat_revalidate_shortname(struct dentry *dentry)
+static bool vfat_revalidate_shortname(struct dentry *dentry, struct inode *dir)
 {
-	int ret = 1;
-	spin_lock(&dentry->d_lock);
-	if (!inode_eq_iversion(d_inode(dentry->d_parent), vfat_d_version(dentry)))
-		ret = 0;
-	spin_unlock(&dentry->d_lock);
-	return ret;
+	return inode_eq_iversion(dir, vfat_d_version(dentry));
 }
 
 static int vfat_revalidate(struct inode *dir, const struct qstr *name,
@@ -62,7 +57,7 @@ static int vfat_revalidate(struct inode *dir, const struct qstr *name,
 	/* This is not negative dentry. Always valid. */
 	if (d_really_is_positive(dentry))
 		return 1;
-	return vfat_revalidate_shortname(dentry);
+	return vfat_revalidate_shortname(dentry, dir);
 }
 
 static int vfat_revalidate_ci(struct inode *dir, const struct qstr *name,
@@ -99,7 +94,7 @@ static int vfat_revalidate_ci(struct inode *dir, const struct qstr *name,
 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
 		return 0;
 
-	return vfat_revalidate_shortname(dentry);
+	return vfat_revalidate_shortname(dentry, dir);
 }
 
 /* returns the length of a struct qstr, ignoring trailing dots */
-- 
2.39.5


