Return-Path: <linux-fsdevel+bounces-6564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8836881981F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A41B258DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F191173B;
	Wed, 20 Dec 2023 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ntsXw42X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3CD26F;
	Wed, 20 Dec 2023 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rj9TGYuRdibOR7FYQDjRe7HB2Vri7EPQAdMUow3lNHE=; b=ntsXw42XDZ3kMNcRk5CfgaO4L+
	NG38q/EwzDjOiGkCPoOK+j7zqJ3OYMaHjJGmD1Ja3PBhnjKZHoArOlcntsazcvh8kxza2lWCqEv49
	Tk5zKKIXx/soa5utaFom6E6qgaIBe/LzgweBN5vVbkya/h9ZBXBtINPv8QAWiVgkPUtXF7/naKoKP
	CbFTiD5I8vRFJo1gFL/xWv4GAtHc9hqk1HsrDyO/5S7bMzUOD4+YifdBUeiz5DTyeUngSPZfKWcl5
	x4PH890iWv10+hDzvQldcxo+8IXRlDyxYt2ad5fnwbw4Zjb4mgt//bOKsST255l4bZV3/zoBzHz7L
	RVMmehoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFp93-00HJS2-2T;
	Wed, 20 Dec 2023 05:29:25 +0000
Date: Wed, 20 Dec 2023 05:29:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org
Subject: [PATCH 17/22] get rid of passing callbacks to ceph
 __dentry_leases_walk()
Message-ID: <20231220052925.GP1674809@ZenIV>
References: <20231220051348.GY1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220051348.GY1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

__dentry_leases_walk() is gets a callback and calls it for
a bunch of denties; there are exactly two callers and
we already have a flag telling them apart - lwc->dir_lease.

Seeing that indirect calls are costly these days, let's
get rid of the callback and just call the right function
directly.  Has a side benefit of saner signatures...

Signed-off-by Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/dir.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 91709934c8b1..768158743750 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1593,10 +1593,12 @@ struct ceph_lease_walk_control {
 	unsigned long dir_lease_ttl;
 };
 
+static int __dir_lease_check(const struct dentry *, struct ceph_lease_walk_control *);
+static int __dentry_lease_check(const struct dentry *);
+
 static unsigned long
 __dentry_leases_walk(struct ceph_mds_client *mdsc,
-		     struct ceph_lease_walk_control *lwc,
-		     int (*check)(struct dentry*, void*))
+		     struct ceph_lease_walk_control *lwc)
 {
 	struct ceph_dentry_info *di, *tmp;
 	struct dentry *dentry, *last = NULL;
@@ -1624,7 +1626,10 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
 			goto next;
 		}
 
-		ret = check(dentry, lwc);
+		if (lwc->dir_lease)
+			ret = __dir_lease_check(dentry, lwc);
+		else
+			ret = __dentry_lease_check(dentry);
 		if (ret & TOUCH) {
 			/* move it into tail of dir lease list */
 			__dentry_dir_lease_touch(mdsc, di);
@@ -1681,7 +1686,7 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
 	return freed;
 }
 
-static int __dentry_lease_check(struct dentry *dentry, void *arg)
+static int __dentry_lease_check(const struct dentry *dentry)
 {
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	int ret;
@@ -1696,9 +1701,9 @@ static int __dentry_lease_check(struct dentry *dentry, void *arg)
 	return DELETE;
 }
 
-static int __dir_lease_check(struct dentry *dentry, void *arg)
+static int __dir_lease_check(const struct dentry *dentry,
+			     struct ceph_lease_walk_control *lwc)
 {
-	struct ceph_lease_walk_control *lwc = arg;
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 
 	int ret = __dir_lease_try_check(dentry);
@@ -1737,7 +1742,7 @@ int ceph_trim_dentries(struct ceph_mds_client *mdsc)
 
 	lwc.dir_lease = false;
 	lwc.nr_to_scan  = CEPH_CAPS_PER_RELEASE * 2;
-	freed = __dentry_leases_walk(mdsc, &lwc, __dentry_lease_check);
+	freed = __dentry_leases_walk(mdsc, &lwc);
 	if (!lwc.nr_to_scan) /* more invalid leases */
 		return -EAGAIN;
 
@@ -1747,7 +1752,7 @@ int ceph_trim_dentries(struct ceph_mds_client *mdsc)
 	lwc.dir_lease = true;
 	lwc.expire_dir_lease = freed < count;
 	lwc.dir_lease_ttl = mdsc->fsc->mount_options->caps_wanted_delay_max * HZ;
-	freed +=__dentry_leases_walk(mdsc, &lwc, __dir_lease_check);
+	freed +=__dentry_leases_walk(mdsc, &lwc);
 	if (!lwc.nr_to_scan) /* more to check */
 		return -EAGAIN;
 
-- 
2.39.2


