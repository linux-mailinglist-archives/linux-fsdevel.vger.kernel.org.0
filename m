Return-Path: <linux-fsdevel+bounces-60967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15832B53BF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 20:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D16AA2ED5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A72255F3F;
	Thu, 11 Sep 2025 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="kxMjW9G9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28477223DD6
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616998; cv=none; b=KLdK6+hs6JxTkLVdc382kykpgmX9PZv5UYFHULaNW/O7zyUAkVqJ4aN+XlC9qdFh/5WT0PjbIu9gWu6GYHhsmF4Z4DyCZlIj7Oc7rhbVjtweoIxHH5cEq1R/3HmB1CUO88p5mervfaI8IxuSbM77J0BC2TVvQGvfC2E+fKmA5PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616998; c=relaxed/simple;
	bh=hTvxzK5eRPWRfPFlDepcqAzln9GI868z9klyCRJyfX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJBXx/lA4NKc299RldBDJkywWP+HEo39y8GL7cReB1KsZy4Lo8kvz0zOTPxyOusEpnoJO10CCSJFoHJV39xG4iEiCtlGe6iaWgQEqadi4YRy8Aj6QlOvoRnO8pZdYO+KOsoyIY32n061wqDjpGkhp1rf8rDi4ve1eKo3vwfSLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=kxMjW9G9; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e970599004aso715690276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757616995; x=1758221795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zaiAeYjg7LcccrfKBhuPH2GoCvPSyBTTXPMo/F9FiZY=;
        b=kxMjW9G9KLPpj3bd6/pvzeBMcbS2ej0rVNkCvwyl5tINQIDyyUyi6Fc5t3KSBgvqGN
         wSSBypOWkyKSFK3JPvgM+mqDW40PQr4xx08//H1HgWiErfGrtB720wSAKooc23ZTsiGM
         yCstzoB/C8KCNDAGRAUJ124NOvd5o+TT7hd6veKcKkbdHfvPrHNKvS1DKHS5Q9+PR1O5
         xqX/BRkmgsAJdhtxXb1LaHo7Xh1qX71QtzBXuqf3aSRbvmHEIqYBhsmKaDYqnDhKNAOz
         0cwG0sPsKKQ8ldhHceshl/gfE3zeNaPv04GbUeKwLNZdnOf+tfnK1Eq3n9WKxov6x4dy
         4iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616995; x=1758221795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaiAeYjg7LcccrfKBhuPH2GoCvPSyBTTXPMo/F9FiZY=;
        b=L3b1EJohj2P/mpYuaP5KwxlNU9HO37vLUlcgLP+pw0bJLUd3o9WEsB73Tl/wVw5oQl
         G5ecbKclYNdUc5NwZoYDzZRt2UsXDDyt8VUslRiKeuVgsfdSUvJEwzwYAQ4jAQM6HQnm
         XY1Gr/Ir7XKeNyKIvYnYLAS1AQozTPFDc1Gvtl7T19ZvzmUvAdcXlFNBR8AiOAB2qxu7
         iVoW8yAgK49Z9BVEefq0RP9wp21r9biu/MWbvB7HG/YbNLtR6b8BHH35qZQ8/SuodF+o
         UL6zORkA4d+eLsUc9Es4lz7+C1JAt3uYH8/pme3YiNrSJs3Q2K4YPfGIkS1hMgFmyb8N
         tbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0DEWxcmAdWdyadhO/R0k3o5Kp48Ypx7wy9o154SjwMz0z2ZjCTUkEr0b9YalkYjFd3pTylA/7n1QT2Mr8@vger.kernel.org
X-Gm-Message-State: AOJu0YwtcLVTHaGfsMY0hbQc+2aI0Ey2O1L/+YvJr0IwjC4wbXGNyYeX
	UzLZv5yGU/ZNaZAYLa5ZGjCoVSV62wkow3R/9qK821bEjoZ6jWKn5XOiDYyh2skiERA=
X-Gm-Gg: ASbGncvlur+ZYDCXGNu1QWOCIr+Rr8R/YsJcdpDNSwGrAg7TCxrGMwJUBVj9t0N0Mq2
	ZW2wIjtlKyD/AdXR6vWScCd9SXTlLwSv3HsxD7t5NzfDfJ9mLbTLFn07sbnQLtLrb21Z7SwoNwg
	9yPJXgMVGrBBqnB6iHLhsi3tIfFL8s9Ycm8sWOoGJys14q1eietpv0F5dNqnqS8XbWvtmxNHgXN
	CdoF9aGcRCPpRBuGYhi8joGq7qsnEB7IzxKN6jyCZDxlHtCWak5GyUgq5MNoNQzpH4ZW3LpSz8Y
	XP0DC1rT/8qoxS5Z5fQLCOKEL+NAaryFHZFZs8uwN15TIk6+VlcBRn4ngDpE9vOTr9AnnbvxX4X
	LUwMh+0YF2SdrY8onfTjRjbgV7FKAUZ36DiCaytw3
X-Google-Smtp-Source: AGHT+IEgeo84/80WeDM7c7sjg8xaKt4oy6SyUvPSUe+Ndqnyq06r2+2kq8Mt0pOCg96d/zQOrTTSyQ==
X-Received: by 2002:a05:690c:260a:b0:724:72f0:50d5 with SMTP id 00721157ae682-730626d1c5emr4440587b3.5.1757616994815;
        Thu, 11 Sep 2025 11:56:34 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:82bf:9e11:b6c8:e795])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f73353c02sm5507877b3.0.2025.09.11.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:56:34 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [PATCH] ceph: cleanup in check_new_map() method
Date: Thu, 11 Sep 2025 11:56:08 -0700
Message-ID: <20250911185607.323452-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The Coverity Scan service has reported a potential issue
in check_new_map() method [1]. The check_new_map() executes
checking of newmap->m_info on NULL in the beginning of
the method. However, it operates by newmap->m_info later
in the method without any check on NULL. Analysis of the code
flow shows that ceph_mdsmap_decode() guarantees the allocation
of m_info array. And check_new_map() never will be called
with newmap->m_info not allocated.

This patch exchanges checking of newmap->m_info on BUG_ON()
pattern because the situation of having NULL in newmap->m_info
during check_new_map() is not expecting event. Also, this patch
reworks logic of __open_export_target_sessions(),
ceph_mdsmap_get_addr(), ceph_mdsmap_get_state(), and
ceph_mdsmap_is_laggy() by checking mdsmap->m_info on NULL value.

[1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1491799

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/debugfs.c    | 11 +++++++++--
 fs/ceph/mds_client.c | 14 +++++++++-----
 fs/ceph/mdsmap.h     |  6 +++++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index fdd404fc8112..f1c49232eee0 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -37,8 +37,15 @@ static int mdsmap_show(struct seq_file *s, void *p)
 	seq_printf(s, "session_timeout %d\n", mdsmap->m_session_timeout);
 	seq_printf(s, "session_autoclose %d\n", mdsmap->m_session_autoclose);
 	for (i = 0; i < mdsmap->possible_max_rank; i++) {
-		struct ceph_entity_addr *addr = &mdsmap->m_info[i].addr;
-		int state = mdsmap->m_info[i].state;
+		struct ceph_entity_addr *addr;
+		int state;
+
+		if (unlikely(!mdsmap->m_info))
+			break;
+
+		addr = &mdsmap->m_info[i].addr;
+		state = mdsmap->m_info[i].state;
+
 		seq_printf(s, "\tmds%d\t%s\t(%s)\n", i,
 			       ceph_pr_addr(addr),
 			       ceph_mds_state_name(state));
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 0f497c39ff82..501b78f9de56 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1737,6 +1737,9 @@ static void __open_export_target_sessions(struct ceph_mds_client *mdsc,
 	if (mds >= mdsc->mdsmap->possible_max_rank)
 		return;
 
+	if (unlikely(!mdsc->mdsmap->m_info))
+		return;
+
 	mi = &mdsc->mdsmap->m_info[mds];
 	doutc(cl, "for mds%d (%d targets)\n", session->s_mds,
 	      mi->num_export_targets);
@@ -5015,11 +5018,12 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 
 	doutc(cl, "new %u old %u\n", newmap->m_epoch, oldmap->m_epoch);
 
-	if (newmap->m_info) {
-		for (i = 0; i < newmap->possible_max_rank; i++) {
-			for (j = 0; j < newmap->m_info[i].num_export_targets; j++)
-				set_bit(newmap->m_info[i].export_targets[j], targets);
-		}
+	/* ceph_mdsmap_decode() should guarantee m_info allocation */
+	BUG_ON(!newmap->m_info);
+
+	for (i = 0; i < newmap->possible_max_rank; i++) {
+		for (j = 0; j < newmap->m_info[i].num_export_targets; j++)
+			set_bit(newmap->m_info[i].export_targets[j], targets);
 	}
 
 	for (i = 0; i < oldmap->possible_max_rank && i < mdsc->max_sessions; i++) {
diff --git a/fs/ceph/mdsmap.h b/fs/ceph/mdsmap.h
index 1f2171dd01bf..12530f25a63b 100644
--- a/fs/ceph/mdsmap.h
+++ b/fs/ceph/mdsmap.h
@@ -52,6 +52,8 @@ ceph_mdsmap_get_addr(struct ceph_mdsmap *m, int w)
 {
 	if (w >= m->possible_max_rank)
 		return NULL;
+	if (unlikely(!m->m_info))
+		return NULL;
 	return &m->m_info[w].addr;
 }
 
@@ -60,12 +62,14 @@ static inline int ceph_mdsmap_get_state(struct ceph_mdsmap *m, int w)
 	BUG_ON(w < 0);
 	if (w >= m->possible_max_rank)
 		return CEPH_MDS_STATE_DNE;
+	if (unlikely(!m->m_info))
+		return CEPH_MDS_STATE_DNE;
 	return m->m_info[w].state;
 }
 
 static inline bool ceph_mdsmap_is_laggy(struct ceph_mdsmap *m, int w)
 {
-	if (w >= 0 && w < m->possible_max_rank)
+	if (w >= 0 && w < m->possible_max_rank && m->m_info)
 		return m->m_info[w].laggy;
 	return false;
 }
-- 
2.51.0


