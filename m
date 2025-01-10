Return-Path: <linux-fsdevel+bounces-38788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF54BA08597
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C798216912A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF607207679;
	Fri, 10 Jan 2025 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A2igdCbk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAD1E32B3;
	Fri, 10 Jan 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476989; cv=none; b=drE6fo16s7vhpJr8qQSj6aSnfQ0QFM8j3LI5/AMknDXUoZ5tlTzEBZ/D8a3Y9erSrh4LGBX39mq+eaEpzOl3XrJZlFwFI+2i6Zg0EjzLqJfiLeCBBo02pBXT5WscPKHNsgPVC8cO8JD6keXINBfAPe2tU6cZQzeooX0mcuXdc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476989; c=relaxed/simple;
	bh=ux7GZf3nQJJId+2ZyGqd5F4d6/wq0h/Q3t5wus1KrEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VP8dY4k87tR/xJpbJ3yb9giu+zmOi2yIlH1ENxWHEqZDSdcikIP78P3kRyq7sy/tvthIO7YDFEfIxhG0bjA132DKFNymDQDRI8Nrb1P5AjRtCa+bGrI3AvVtMRlYs/qg/Em9hhR8eVhlD4CvTLkpflPZmsKaqTblOVU0tHRAhhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=A2igdCbk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eWMX52jd4nQnMPUijP91hwECc2+85dV+OtpJ1EZ5yzU=; b=A2igdCbkuMI1A6w9ml7Pn3xYjd
	q3rkbD1RSWJR1E52aYnRIcVawm4WhqSxtYru4PuG3oNdFmiXzuNsNR24Wdt0/CqK4uptOUm0M833E
	FX8G4xujfos9tFDGXiJJ2x4wKPtjxQOyL5lNbI60NNd6amPdZJg1R93fuZ9mhha9errAi/Hi2pLoI
	/10dmJ5K/SjjZ5KpYIfV0MMJwL3cxLv3L5i0V6fsqYyrItjeCgOCpTCPvAQ4vJlfOipLElkHQXJDQ
	sNs7+Kv9lmYtggi2Pq9h3RcY9AyLGp17bLcjzVBfdBYelm3pgvf/teqgmFAXV8GegHUXHNacdiWaB
	45obQwiQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zJ-0000000HRd1-1vaC;
	Fri, 10 Jan 2025 02:43:05 +0000
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
Subject: [PATCH 18/20] ocfs2_dentry_revalidate(): use stable parent inode and name passed by caller
Date: Fri, 10 Jan 2025 02:43:01 +0000
Message-ID: <20250110024303.4157645-18-viro@zeniv.linux.org.uk>
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

theoretically, ->d_name use in there is a UAF, but only if you are messing with
tracepoints...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ocfs2/dcache.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/ocfs2/dcache.c b/fs/ocfs2/dcache.c
index ecb1ce6301c4..1873bbbb7e5b 100644
--- a/fs/ocfs2/dcache.c
+++ b/fs/ocfs2/dcache.c
@@ -45,8 +45,7 @@ static int ocfs2_dentry_revalidate(struct inode *dir, const struct qstr *name,
 	inode = d_inode(dentry);
 	osb = OCFS2_SB(dentry->d_sb);
 
-	trace_ocfs2_dentry_revalidate(dentry, dentry->d_name.len,
-				      dentry->d_name.name);
+	trace_ocfs2_dentry_revalidate(dentry, name->len, name->name);
 
 	/* For a negative dentry -
 	 * check the generation number of the parent and compare with the
@@ -54,12 +53,8 @@ static int ocfs2_dentry_revalidate(struct inode *dir, const struct qstr *name,
 	 */
 	if (inode == NULL) {
 		unsigned long gen = (unsigned long) dentry->d_fsdata;
-		unsigned long pgen;
-		spin_lock(&dentry->d_lock);
-		pgen = OCFS2_I(d_inode(dentry->d_parent))->ip_dir_lock_gen;
-		spin_unlock(&dentry->d_lock);
-		trace_ocfs2_dentry_revalidate_negative(dentry->d_name.len,
-						       dentry->d_name.name,
+		unsigned long pgen = OCFS2_I(dir)->ip_dir_lock_gen;
+		trace_ocfs2_dentry_revalidate_negative(name->len, name->name,
 						       pgen, gen);
 		if (gen != pgen)
 			goto bail;
-- 
2.39.5


