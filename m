Return-Path: <linux-fsdevel+bounces-78372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MaTBmXynmnoXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 14:00:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77150197BBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 14:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48BD330C29F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5713AEF23;
	Wed, 25 Feb 2026 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqOIBlVU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kX+AoH65"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34D3ACEF9
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024361; cv=none; b=VBv2sBBZ2x2lrrVFOqg8iTg1N9WQKk3j/wFP0V5UktxzeyEVh+SNkN0rUfKo01nslqKjxUXnvyOEpMrceR/S0QLePLb81tKNw+JOp/qDFHZz0djaG/U8/VxuZK+2IVXUWB/uAUrEHB4fEHsKekC5oW5vtrRu7Rj22cWyuGf2yl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024361; c=relaxed/simple;
	bh=E2dzRWH62X5awZNR6gjvhwvrtvUsaWSNYShyIxzwdjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YDGQmDtUzKYtiZ29SPE5sZ3HXVMvha8LTxVrW53x8gQkOlyobykYHuZNI+a2qnG+Ns8Co7Q6NxrOYcFwe2hv8zd5jChTYXmXmbLN9j0qnPNuOhLTeYI1vC0SBV6uAqABGeh/5MpwKnBJ8uVS9umU4IxwKDEQx/UlkL+6TYVHy60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqOIBlVU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kX+AoH65; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772024359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oi/vZ/gQMDX5xe1jLKXYQEZ+7mw1O3edlueKkQ+5r4M=;
	b=CqOIBlVUHnBLDyLl4uoI1C9zBNx6pX8DTkv7CC6Y2XsHR9GX+Q4hVx2bauO5jDt/ewH1ph
	O3VF8VMV8K98zj4RTVAFeTaRlQ/+dDHvqKS8u64mVseJcyQv8AlwDQNr/1BUWFUvzKEyGS
	GNqQ0T6/7m4VMAMYfbpQg9Ay+A/1PIg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-3dZmSvwgMa-isE76sXzU4A-1; Wed, 25 Feb 2026 07:59:16 -0500
X-MC-Unique: 3dZmSvwgMa-isE76sXzU4A-1
X-Mimecast-MFC-AGG-ID: 3dZmSvwgMa-isE76sXzU4A_1772024356
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70ab7f67fso4684161385a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 04:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772024356; x=1772629156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi/vZ/gQMDX5xe1jLKXYQEZ+7mw1O3edlueKkQ+5r4M=;
        b=kX+AoH65tnaAb5tgTgsO+mC6A5lmvYOky9tMKC7U22Zue7zuXJhoXApxkUSlc9FQ1Y
         koTUhS4QjPjBbDo/cdLebyMXgibeu22nCgbCJkw6Uzk/GttuPPyl3Bi3BAcYQhVSZIFP
         gaF4AlBLeb/dTCIlpNZgOnpX2z/J4RFAOB9K0mep8cFhVg19pIrp6inditQUfoWPsQwE
         3Sf949YJH1/8UJfhCBr6NMVWBjZL7wVwUlVW67N1FaBFPqHXq60gtQzLiIaEYgv5qdv0
         uywVHSu7ZXzCER3+7ki4DhF8qQ2sARJrQ4dj5rXTstk3QGy4MnJgZKZXmbPQ13dGSY/d
         VasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024356; x=1772629156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oi/vZ/gQMDX5xe1jLKXYQEZ+7mw1O3edlueKkQ+5r4M=;
        b=hUAjyyVDa2Br/+s5Dzfmzl1ePXV/MGqkNC9ocZpJaZXDXjzMtS6QnJttGT/u37hxgs
         bdkPtVL93RgykG4D2Kv4Vyi5s/YYuIXsQvFN/xbL7mFCJb03mpNMEPV9VyMMJ/VqhBhP
         aZm908wu9peCX3U1RU7fVLD24I6FHVbQNCk4i+kka7G2mfIWGw7UH2hTRBWDzhMPTmdz
         TuzdaU3dQpQH0cAA5rBKnMJA5dAxmKnMdD1/vzaxUwjCdjqKNF59JtFMi3Fhat6DaPOf
         kFcm9w8iOilsZ2J/uZTBefMgcNgagddLAb8twpUfyTU1xvY8+J6uiIo7EMz4jrclsId3
         E0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjFFnHszupmTF0w5gqYCQG83vmcvyeHD71Fl/VXkBN1fSH3YHJbpt3UJz/WkAcz97juLqMQHErSTmzJZWK@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz4bglHmBdOldU3xZ+68af7p4EAN3DA0dMKvgmf8kYWhQ9af9W
	8GUrFwbOgXZFK36iaSXRTAc31xCIuJIh7k5yMKKvwDO2FMHlmg4+iC487mi9MV3/CxG0aTRN4ML
	/i9dHtsqv4C5K3xTGiA5xbzNLkmtWNJ8AvL3/PziwNigbNIxF/9b/JZKf9BIHXSk9XoQ=
X-Gm-Gg: ATEYQzwd80E7jGcMc4U2hSyUiQSGSkwicu3c/cdx7YFmO+sgzKedEiIaumL8T0eRCvg
	ZI+VqLv636Xi+eTMyWaxw7IMUMN6Vz1cv+P+ot5T9yU2AHzFNLUL6uWwy9AzV/I/1MWigPROwGM
	z7lJtWsiGwoxhEnRtEbVJjCQ+lN6I55ejuNzYiqmEEQy8KtN3+wXCuEC67mvDi2FvbCutMVyddL
	rLrEKRq3T1hPVaqNDe1T0vCMie+hPxFeMffaToSyL+Bd39T4+6iqSVREFJDREa/h3bzI9rHN1K2
	KwCUqynKt5UJq3DaERZFsdeQyMHkELVEgQv+i3sCKmxnWdAyybom5TVHDSCLKnCUqSzV+xoGEA4
	05K4DyVUU0q4r8FFlQJmc3LxCA/gZYVRkORAGkpb5RgkG01A+jn9Z1jU=
X-Received: by 2002:a05:620a:4494:b0:8c6:e11c:5ec4 with SMTP id af79cd13be357-8cbbcfab258mr41041885a.35.1772024355569;
        Wed, 25 Feb 2026 04:59:15 -0800 (PST)
X-Received: by 2002:a05:620a:4494:b0:8c6:e11c:5ec4 with SMTP id af79cd13be357-8cbbcfab258mr41038385a.35.1772024355040;
        Wed, 25 Feb 2026 04:59:15 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046055sm1514219685a.8.2026.02.25.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:59:14 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH v1 2/4] ceph: add bounded timeout and diagnostics to wait_caps_flush()
Date: Wed, 25 Feb 2026 12:59:05 +0000
Message-Id: <20260225125907.53851-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225125907.53851-1-amarkuze@redhat.com>
References: <20260225125907.53851-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78372-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[amarkuze@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77150197BBD
X-Rspamd-Action: no action

Convert wait_caps_flush() from an unbounded wait_event() to a
bounded wait_event_timeout() with a 60-second period. If the
flush hasn't completed after each timeout, dump the pending
cap_flush list (up to 5 times) to aid debugging hung flush
scenarios.

Add a ci back-pointer to struct ceph_cap_flush so the diagnostic
dump can identify which inodes have outstanding flushes. Add
i_last_cap_flush_ack to ceph_inode_info for tracking the latest
acknowledged flush tid per inode.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/caps.c       |  7 +++++++
 fs/ceph/mds_client.c | 41 +++++++++++++++++++++++++++++++++++++++--
 fs/ceph/super.h      |  2 ++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d51454e995a8..be030fb8e864 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1648,6 +1648,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 
 		spin_lock(&mdsc->cap_dirty_lock);
 		capsnap->cap_flush.tid = ++mdsc->last_cap_flush_tid;
+		capsnap->cap_flush.ci = ci;
 		list_add_tail(&capsnap->cap_flush.g_list,
 			      &mdsc->cap_flush_list);
 		if (oldest_flush_tid == 0)
@@ -1846,6 +1847,9 @@ struct ceph_cap_flush *ceph_alloc_cap_flush(void)
 		return NULL;
 
 	cf->is_capsnap = false;
+	cf->ci = NULL;
+	cf->tid = 0;
+	cf->wake = false;
 	return cf;
 }
 
@@ -1931,6 +1935,7 @@ static u64 __mark_caps_flushing(struct inode *inode,
 	doutc(cl, "%p %llx.%llx now !dirty\n", inode, ceph_vinop(inode));
 
 	swap(cf, ci->i_prealloc_cap_flush);
+	cf->ci = ci;
 	cf->caps = flushing;
 	cf->wake = wake;
 
@@ -3826,6 +3831,8 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 	bool wake_ci = false;
 	bool wake_mdsc = false;
 
+	ci->i_last_cap_flush_ack = flush_tid;
+
 	list_for_each_entry_safe(cf, tmp_cf, &ci->i_cap_flush_list, i_list) {
 		/* Is this the one that was flushed? */
 		if (cf->tid == flush_tid)
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 28bb27b09b40..e27f2f148dea 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -27,6 +27,8 @@
 #include <trace/events/ceph.h>
 
 #define RECONNECT_MAX_SIZE (INT_MAX - PAGE_SIZE)
+#define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
+#define CEPH_CAP_FLUSH_MAX_DUMP_COUNT 5
 
 /*
  * A cluster of MDS (metadata server) daemons is responsible for
@@ -2285,6 +2287,34 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
 	return ret;
 }
 
+static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
+{
+	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_cap_flush *cf;
+
+	pr_info_client(cl, "still waiting for cap flushes through %llu:\n",
+		       want_tid);
+	spin_lock(&mdsc->cap_dirty_lock);
+	list_for_each_entry(cf, &mdsc->cap_flush_list, g_list) {
+		if (cf->tid > want_tid)
+			break;
+		if (!cf->ci) {
+			pr_info_client(cl,
+				       "(null ci) %s tid=%llu wake=%d%s\n",
+				       ceph_cap_string(cf->caps), cf->tid,
+				       cf->wake,
+				       cf->is_capsnap ? " is_capsnap" : "");
+			continue;
+		}
+		pr_info_client(cl, "%llx:%llx %s %llu %llu %d%s\n",
+			       ceph_vinop(&cf->ci->netfs.inode),
+			       ceph_cap_string(cf->caps), cf->tid,
+			       cf->ci->i_last_cap_flush_ack, cf->wake,
+			       cf->is_capsnap ? " is_capsnap" : "");
+	}
+	spin_unlock(&mdsc->cap_dirty_lock);
+}
+
 /*
  * flush all dirty inode data to disk.
  *
@@ -2294,11 +2324,18 @@ static void wait_caps_flush(struct ceph_mds_client *mdsc,
 			    u64 want_flush_tid)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	int i = 0;
+	long ret;
 
 	doutc(cl, "want %llu\n", want_flush_tid);
 
-	wait_event(mdsc->cap_flushing_wq,
-		   check_caps_flush(mdsc, want_flush_tid));
+	do {
+		ret = wait_event_timeout(mdsc->cap_flushing_wq,
+			   check_caps_flush(mdsc, want_flush_tid),
+			   CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC * HZ);
+		if (ret == 0 && i++ < CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
+			dump_cap_flushes(mdsc, want_flush_tid);
+	} while (ret == 0);
 
 	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 69a71848240f..9e80c816aa7a 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -238,6 +238,7 @@ struct ceph_cap_flush {
 	bool is_capsnap; /* true means capsnap */
 	struct list_head g_list; // global
 	struct list_head i_list; // per inode
+	struct ceph_inode_info *ci;
 };
 
 /*
@@ -443,6 +444,7 @@ struct ceph_inode_info {
 	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 or
 						    dirty|flushing caps */
 	unsigned i_snap_caps;           /* cap bits for snapped files */
+	u64 i_last_cap_flush_ack;		/* latest cap flush_ack tid for this inode */
 
 	unsigned long i_last_rd;
 	unsigned long i_last_wr;
-- 
2.34.1


