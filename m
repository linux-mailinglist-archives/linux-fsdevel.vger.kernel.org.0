Return-Path: <linux-fsdevel+bounces-38778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24232A0857B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255ED16814D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742082063CF;
	Fri, 10 Jan 2025 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AzujHnLl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA91E200F;
	Fri, 10 Jan 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476987; cv=none; b=DTPbHbr2g2z1vPF6uPWN3CFnZUte5qPtCJhit19WCgMOuvEv2x6kJs2rERstdX1+ODk/6GvBhuYzCyDciAvVAee+f+Zk++JCApb0erTNot+fGWnOffYJ1X2khxx/BJHd6i6JqTeg+EmKftPBS3f3a7MFYpzMxpisZffU/odvQG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476987; c=relaxed/simple;
	bh=8awRkImTYl91l1kNrYLY3TKshTKPtGZTfFFccw4m7jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=up4pjFEqAp8ED4lWYT44mqUZMxW5CZdmcWxWUiC4ROEhzrab85mX2s1Z2x2DD5guBUtfP9MFl9tzMBikr1z+Xx3GqrBc9AyReNgK/Y2mLzAa4qv0UZWAOY1Gx2qehdwXr49bXo1E6os+RQFbQaAWwwwWGtJ0r5x0Qu8h+q19tRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AzujHnLl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=a8AXKvJQ+lijUKcnn/INkIbApsK2wys4MtYXJIQl7Y4=; b=AzujHnLlVn7g9/GJ+CPZL+2Mgw
	a+jSLInYOGyPomSdjgCRHtslLhDfJXxFwkzo/8E8G3p82G0p41XfARg6OhdYcWGVOTI5cV5vYYPOI
	cguvqxO1Jt3lEql27f6ORoURKBwaRpD9ksXgfdO57XFlUE2gsmobvzE0BUWiZoIilMjj2HdAkqRAa
	/tK52Ji/zj4Hr2nwUzMlsjfqTxmgpIPMLYjWpYBgD7Tq9VKAsVEHDyxGgP+DF2PfiPtYihfgyIoIo
	zh2NgiJ1s3TeBH/cFEJEEbcwA1CPdGmxiWiLTamCqaeiPiFiBLW0ygYekBHB6mFeDLbQ+wAq+y81K
	z79iHQyA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zI-0000000HRbG-0Qp2;
	Fri, 10 Jan 2025 02:43:04 +0000
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
Subject: [PATCH 06/20] generic_ci_d_compare(): use shortname_storage
Date: Fri, 10 Jan 2025 02:42:49 +0000
Message-ID: <20250110024303.4157645-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and check the "name might be unstable" predicate
the right way.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 748ac5923154..3ad1b1b7fed6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1789,7 +1789,7 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 {
 	const struct dentry *parent;
 	const struct inode *dir;
-	char strbuf[DNAME_INLINE_LEN];
+	union shortname_store strbuf;
 	struct qstr qstr;
 
 	/*
@@ -1809,22 +1809,23 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 	if (!dir || !IS_CASEFOLDED(dir))
 		return 1;
 
+	qstr.len = len;
+	qstr.name = str;
 	/*
 	 * If the dentry name is stored in-line, then it may be concurrently
 	 * modified by a rename.  If this happens, the VFS will eventually retry
 	 * the lookup, so it doesn't matter what ->d_compare() returns.
 	 * However, it's unsafe to call utf8_strncasecmp() with an unstable
 	 * string.  Therefore, we have to copy the name into a temporary buffer.
+	 * As above, len is guaranteed to match str, so the shortname case
+	 * is exactly when str points to ->d_shortname.
 	 */
-	if (len <= DNAME_INLINE_LEN - 1) {
-		memcpy(strbuf, str, len);
-		strbuf[len] = 0;
-		str = strbuf;
+	if (qstr.name == dentry->d_shortname.string) {
+		strbuf = dentry->d_shortname; // NUL is guaranteed to be in there
+		qstr.name = strbuf.string;
 		/* prevent compiler from optimizing out the temporary buffer */
 		barrier();
 	}
-	qstr.len = len;
-	qstr.name = str;
 
 	return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
 }
-- 
2.39.5


