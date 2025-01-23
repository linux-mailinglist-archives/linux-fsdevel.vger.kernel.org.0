Return-Path: <linux-fsdevel+bounces-39903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943E6A19C59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7333AD254
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1805F5733A;
	Thu, 23 Jan 2025 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VvrFElcq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB481B960;
	Thu, 23 Jan 2025 01:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596807; cv=none; b=pEhBa3eZTM+gVormSjfiMrvUmgA8CMKXRMyZGHvGtxPbEqi3d6jJm4jlgurI3oUWKTCmjvfFwMIhXE0uKX33ekP1JNklRm/rKdKcRmxQ2bQ+uBTAzHxjfthSDcyNz46Ni6XCTuIN7q6lrz9u74v6Xip6rRsrbnjBqalKBPyaZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596807; c=relaxed/simple;
	bh=hNjWBL2KmS9FdATL1no+Yj5BX9FCAVCPi4dtX2UnMnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ti1i2nb1dYOPd1BZ5Ir61IFrBsGPKNmZWQoL90w5ziiXTNOLsywfy0JzauNViHLVX5PXSR8afUvPrP6yao/sFO1phpFbMEjx/i/OVSCr9KJ3/Kj1UjApV1Z6owPzAO1Yc8NWL8tjqJ2mXhE+5XECeeRdrqrRop1FHUuy40QBl8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VvrFElcq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=H9Wm1UK6tHASZaQMCTJwWKu9NefN/le7+GAalYPesP8=; b=VvrFElcqx+AAp6YuImouxJ0Rbq
	uUD0kqsDpIh2y6DyXjo+jQ/qmlCsOLuhDrY94FGMlAsHppwRyErMXnCdUd6lSQcIB2/ZpROV/WWFq
	HsaJmSDoWuJlhFiHhwNmJyfbcbPU9SMnSymW1Ta7q5NGdLbQEr+t2Tjjs+mvVnbqXIP0BK5EmUWu2
	+zvInRXYUx10uF3doze+9SLS3W2ssqOKlfCx+D3N0wUZnrs9HSDVuF7RJQCK/pSiGn4+RS355g7jF
	f3elyhfcSZH+nhm8dkVTC675UNdqEVx1LIoDSAEG4ZvIt3c31pdzqI5dkoN2n6kEcFl4Ffzvd+paO
	50lt/XEQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIt-00000008F1w-47za;
	Thu, 23 Jan 2025 01:46:44 +0000
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
Subject: [PATCH v3 06/20] generic_ci_d_compare(): use shortname_storage
Date: Thu, 23 Jan 2025 01:46:29 +0000
Message-ID: <20250123014643.1964371-6-viro@zeniv.linux.org.uk>
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

... and check the "name might be unstable" predicate
the right way.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
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


