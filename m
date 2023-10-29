Return-Path: <linux-fsdevel+bounces-1510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798AF7DAE45
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 21:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304BB28151C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 20:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1381C10953;
	Sun, 29 Oct 2023 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J+J7vOzD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84905D299;
	Sun, 29 Oct 2023 20:46:39 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA101B6;
	Sun, 29 Oct 2023 13:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WDmAzo9+QKCs6bidBCjOfAWnOzKWHN56xcaNm45aYsg=; b=J+J7vOzDaNH/DoU/C03vQi1p6U
	k15CryG4AE2paUu8p5lZjUWbOlxcz5JQe8Cc/D2zv03lFYH/WlYoEVsyfvwI6lzXEu/IxWMxxEkKw
	FtIXITdU3kqDpZemQ6CByzQ/e0yukkuhhFqHJCNMHEB/EJQsRKYoloizfs1pApYDOutO17togsEkm
	Y4UMaUulaI+wnfM8vi8SxoAE70jOCPuV73XJfVdOg6DNBLb0E1FbX+h47AhA8LSLrke85XHIAPQlD
	Nk4vuZ2hIrzgqtXKiFdhYN8S7czN0hrAXLeUsUwzalofIBZW6QX/TJu/fBF0CA633FjycmAL/EEqF
	V//5jVRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qxCg7-007ePd-0s;
	Sun, 29 Oct 2023 20:46:35 +0000
Date: Sun, 29 Oct 2023 20:46:35 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: ceph-devel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH] get rid of passing callbacks to ceph
 __dentry_leases_walk()
Message-ID: <20231029204635.GV800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

__dentry_leases_walk() is gets a callback and calls it for
a bunch of denties; there are exactly two callers and
we already have a flag telling them apart - lwc->dir_lease.

Seeing that indirect calls are costly these days, let's
get rid of the callback and just call the right function
directly.  Has a side benefit of saner signatures...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 854cbdd66661..30b06d171a40 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1550,10 +1550,12 @@ struct ceph_lease_walk_control {
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
@@ -1581,7 +1583,10 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
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
@@ -1638,7 +1643,7 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
 	return freed;
 }
 
-static int __dentry_lease_check(struct dentry *dentry, void *arg)
+static int __dentry_lease_check(const struct dentry *dentry)
 {
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	int ret;
@@ -1653,9 +1658,9 @@ static int __dentry_lease_check(struct dentry *dentry, void *arg)
 	return DELETE;
 }
 
-static int __dir_lease_check(struct dentry *dentry, void *arg)
+static int __dir_lease_check(const struct dentry *dentry,
+			     struct ceph_lease_walk_control *lwc)
 {
-	struct ceph_lease_walk_control *lwc = arg;
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 
 	int ret = __dir_lease_try_check(dentry);
@@ -1694,7 +1699,7 @@ int ceph_trim_dentries(struct ceph_mds_client *mdsc)
 
 	lwc.dir_lease = false;
 	lwc.nr_to_scan  = CEPH_CAPS_PER_RELEASE * 2;
-	freed = __dentry_leases_walk(mdsc, &lwc, __dentry_lease_check);
+	freed = __dentry_leases_walk(mdsc, &lwc);
 	if (!lwc.nr_to_scan) /* more invalid leases */
 		return -EAGAIN;
 
@@ -1704,7 +1709,7 @@ int ceph_trim_dentries(struct ceph_mds_client *mdsc)
 	lwc.dir_lease = true;
 	lwc.expire_dir_lease = freed < count;
 	lwc.dir_lease_ttl = mdsc->fsc->mount_options->caps_wanted_delay_max * HZ;
-	freed +=__dentry_leases_walk(mdsc, &lwc, __dir_lease_check);
+	freed +=__dentry_leases_walk(mdsc, &lwc);
 	if (!lwc.nr_to_scan) /* more to check */
 		return -EAGAIN;
 

