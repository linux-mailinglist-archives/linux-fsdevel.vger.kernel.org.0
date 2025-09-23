Return-Path: <linux-fsdevel+bounces-62503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91D6B9592D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 13:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D5718A7E62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 11:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75896321F32;
	Tue, 23 Sep 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="X7XWgLE4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900A321F59;
	Tue, 23 Sep 2025 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625699; cv=none; b=E1tHDdgKSEvyPLL8h9KdIDIqvMu4o10K4W9YgwZH7ZpIvWycb007DnjhCyW/gn7f2zO+NjnrW+vbELL1YNK9X5M7l9LRpYQ26Zf7tSNGDVTyk3JtCbBH5lOrxJJv5EG9uNPy1CmoUcTCr+KA79ItjR5qvCbevn29gViEIi6fTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625699; c=relaxed/simple;
	bh=5qeN5FB8P5BaSOId1z/zwYvT0pAjQ0vFVZ9LpT3nZKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldSZCJ9SrW+KumD27LfhKBAYGBLOxENBvYDx3GGzzoHdEJKyLJoQ8YhPhwlN0ummc4hzT3b2NcuAMw/XXZ14QNgKOFffsT0AHEZfcpA8Dt356/9dGdOFZ0/znWgBQkm5pADetghGLmGy21uyYSUJW5ltJgV1M/H4a71tDjswcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=X7XWgLE4; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1758625694; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=5qeN5FB8P5BaSOId1z/zwYvT0pAjQ0vFVZ9LpT3nZKg=;
 b=X7XWgLE4DvlyeBhulkQJJ60ZpYXkvC2psZDFACpg/LTTzhP8odzLJ14/rkBF49h4EH35c
 SAzdYe83gOXGJoEB70A0p4xhBNZm/pdvcR19fj3ryh2D2fqr9zne2gLz5kV5WGioy+6MT4u
 SERNs8mQGxHWXSu3btGIUbxt11EURGXUCgHNcorV1iW4sD+e6ARbGMHyGXqk3cSQ40cRBSi
 fRLISNHAZfz4DDtWt3PSEP/mrGMkL8A4IN/SCbQMU6c9Ya7AmA23sihMQ17Z9OzgXEir0U5
 UdLxKBXbZBrUw+XrdLu81dqgjIvhv3iK9rne0JaYhFoRfLE7y5qNBpJhQAJA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id B924C5FCF4;
	Tue, 23 Sep 2025 13:08:14 +0200 (CEST)
Received: from silenos (unknown [141.24.207.96])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 9F1025FC67;
	Tue, 23 Sep 2025 13:08:14 +0200 (CEST)
From: Simon Buttgereit <simon.buttgereit@tu-ilmenau.de>
To: ceph-devel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	idryomov@gmail.com,
	xiubli@redhat.com,
	Simon Buttgereit <simon.buttgereit@tu-ilmenau.de>
Subject: [PATCH] ceph: Fix log output race condition in osd client
Date: Tue, 23 Sep 2025 13:08:09 +0200
Message-ID: <20250923110809.3610872-1-simon.buttgereit@tu-ilmenau.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OSD client logging has a problem in get_osd() and put_osd().
For one logging output refcount_read() is called twice. If recount
value changes between both calls logging output is not consistent.

This patch adds an additional variable to store the current refcount
before using it in the logging macro.

Signed-off-by: Simon Buttgereit <simon.buttgereit@tu-ilmenau.de>
---
 net/ceph/osd_client.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 6664ea73ccf8..b8d20ab1976e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1280,8 +1280,9 @@ static struct ceph_osd *create_osd(struct ceph_osd_client *osdc, int onum)
 static struct ceph_osd *get_osd(struct ceph_osd *osd)
 {
 	if (refcount_inc_not_zero(&osd->o_ref)) {
-		dout("get_osd %p %d -> %d\n", osd, refcount_read(&osd->o_ref)-1,
-		     refcount_read(&osd->o_ref));
+		unsigned int refcount = refcount_read(&osd->o_ref);
+
+		dout("get_osd %p %d -> %d\n", osd, refcount - 1, refcount);
 		return osd;
 	} else {
 		dout("get_osd %p FAIL\n", osd);
@@ -1291,8 +1292,9 @@ static struct ceph_osd *get_osd(struct ceph_osd *osd)
 
 static void put_osd(struct ceph_osd *osd)
 {
-	dout("put_osd %p %d -> %d\n", osd, refcount_read(&osd->o_ref),
-	     refcount_read(&osd->o_ref) - 1);
+	unsigned int refcount = refcount_read(&osd->o_ref);
+
+	dout("put_osd %p %d -> %d\n", osd, refcount, refcount - 1);
 	if (refcount_dec_and_test(&osd->o_ref)) {
 		osd_cleanup(osd);
 		kfree(osd);
-- 
2.51.0


