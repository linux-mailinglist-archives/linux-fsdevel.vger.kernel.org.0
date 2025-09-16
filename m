Return-Path: <linux-fsdevel+bounces-61821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EB3B5A101
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 21:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626A14600A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32952DF13C;
	Tue, 16 Sep 2025 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="CNLos0Tq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8432D5D4
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049876; cv=none; b=bzfPygOSU2LLeB4oCz+zrjselO0FQTgtV3g8hJLDnZyjuoTTT7wsShGX3mlttuB5S6lGrbScxZxYPbAgn37UV2oYttZxazcrck0gp9VgrFFOAO9BXRzwmESCO2MCAHdPC1an1I+ql1bqllBwBounPwdLaBE0PceyDOwM0H8prTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049876; c=relaxed/simple;
	bh=JQYkjz/tXf7d/SYvDSq1GiiZGTTEL+cmVmMScaES8bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vFVcEqNzzgVuTYnx9vizykkTDVLsmFHyTGiy6CRr/1nKHQv5zkKo0/9cWs+cxFs1HB8YmwaI11KxkTzczszo8wo8LsHHKAsXWAX4Z+oIj2Q8ipcPr1BLAwI+w6A9S9pCcYgo31Bxcj2vDqfv+Kj5fjvAuN15wfD5QEINGSp4EZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=CNLos0Tq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d603a269cso39245397b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 12:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1758049873; x=1758654673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3TvpNjNfXgTalwqDVj/2NqZE6nMjrCbJzcEExPw5piU=;
        b=CNLos0Tqd8a0A2r/zxol15dVnKxYCxNaH6cW/Pf/YX/c652/0/v9cMlTUxcZ2eUoKD
         0qNnfIUK4EFFedyPmhlZGO9W6Vo71iSHPBIe/Gn6RCMhXkI0pLtRbmPDgm+Pamk+u3gY
         TXofVT5u3FPPhV/Y32i9D48w/HCN3UC9FnUPyRiTbxR/EWjizamvPE0FmIH4aO4xAULR
         bvZylqJ1W7OmGGp0FHc/4kvfUZzdHcLZNE+ykxT6VATCRnKncyIF+//fxWzmQbybv6Y6
         GyETvSwcovQGE4h9Nm+19m6c4t/cfE8BAqlg4gyxQZGUb6iU8dEBgoeKgNzFmQqhY117
         hGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758049873; x=1758654673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TvpNjNfXgTalwqDVj/2NqZE6nMjrCbJzcEExPw5piU=;
        b=doi7aiqosMhjIYnRriFYCNlk6sotVH3Fqfrge5toQAsYDNuRaLIvT1XeChj9kDX9zF
         o5LsM/hcTjfHdtFcYdbR4uyl2sYY6BHImLFyrNswKqGkuI6P3WaE0SitZL24FEwIq809
         XmWbKHm9uJMk4bPMBBrgjzYlVFDInNmiF+bOah9cMstkNeeW+MzrF0Rygid2jGPV45kM
         X/OB3RBTsSrhy1Bj1skgOVJCbVmE+0h3cMCuUJqqUxkguwGb2tH8vuNPmCgi8/tQUGDS
         6dBpP7svZRtKGMim5FHFvWSFeb8RjgG69yuARHPaR0pLXLWztblfG74AQ+NVcIYoKo5d
         ngsw==
X-Forwarded-Encrypted: i=1; AJvYcCXpguxWAAEtfhAmVi02Ydpr2rXB9yXH1xLUpYRR7TDjicVJRQVJWc6c5uNk/9HHJBdDNCPaUKt43fonog/b@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsmduEII2UPefIji+mRCKkRwv7ffDJD7jt1o1GowOY89K0eEc
	w0SiPrGU1o9WXwRTRHFM1OD30xJfnc++xQrNHw7enwdw7YcKVL3brA6YhX3XsXLomNU=
X-Gm-Gg: ASbGncugsDNv/fMPcLRqJOiwY4aPX3KsYQkS07J0r6w3w8p+ppFPQNz7HIKHziizpqW
	e4wsqoL3OejupOVO6t9zbpCdjX38y152PkYkQoNLRFHbUtTYQ+5/6+2m7h73/F4qSm8JTOsIcTl
	KCScBPgxyeB+w9hhneJbYAx0Qc6AIFCmB9L0VvPbdiJPFIz+Q3FoAR6+EFeEVKGwecggNTLQYWE
	0QdUzV1A279DvAFypOsxBdlwrv8elGen//wMw+woou61ZkDSgde44nsdUoLlSBELJ2SneZXYqbi
	YnefrKeehEdmHoj9QRP3Ps1jRHR94F39EnQDGPfeNjeFqjpFnvW+EIXtyadGsyRckmocfN+yw4m
	c1x3Tu9SHB/oCvbjR3enOZ8L9OFyBMIA5JlG34OLV
X-Google-Smtp-Source: AGHT+IHil1gr51LI7xjg/42gWZmcXvSxhtj9s8Bt65HqQdbE2moQKNAOxJBU538skxGILgfFZprkOg==
X-Received: by 2002:a05:690c:600a:b0:734:81fb:8ba0 with SMTP id 00721157ae682-73481fba2afmr75450197b3.19.1758049872579;
        Tue, 16 Sep 2025 12:11:12 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:a504:df7d:48b8:47b7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-736ad7b2aafsm9436757b3.5.2025.09.16.12.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 12:11:11 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [PATCH] ceph: fix potential overflow in parse_reply_info_dir()
Date: Tue, 16 Sep 2025 12:10:47 -0700
Message-ID: <20250916191046.400201-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The parse_reply_info_dir() logic tries to parse
a dir fragment:

struct ceph_mds_reply_dirfrag {
	__le32 frag;            /* fragment */
	__le32 auth;            /* auth mds, if this is a delegation point */
	__le32 ndist;           /* number of mds' this is replicated on */
	__le32 dist[];
} __attribute__ ((packed));

Potentially, ndist field could be corrupted or to have
invalid or malicious value. As a result, this logic
could result in overflow:

*p += sizeof(**dirfrag) + sizeof(u32) * le32_to_cpu((*dirfrag)->ndist);

Al Viro suggested the initial vision of the fix.
The suggested fix was partially reworked.

This patch adds the checking that ndist is not bigger
than (U32_MAX / sizeof(u32)) and to check that we have
enough space in memory buffer by means of ceph_decode_need().

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/mds_client.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3bc72b47fe4d..245f5fb97f2e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -283,6 +283,11 @@ static int parse_reply_info_dir(void **p, void *end,
 				struct ceph_mds_reply_dirfrag **dirfrag,
 				u64 features)
 {
+	size_t item_size = sizeof(u32);
+	size_t dirfrag_size;
+	u32 ndist;
+	u32 array_size;
+
 	if (features == (u64)-1) {
 		u8 struct_v, struct_compat;
 		u32 struct_len;
@@ -297,11 +302,16 @@ static int parse_reply_info_dir(void **p, void *end,
 		end = *p + struct_len;
 	}
 
-	ceph_decode_need(p, end, sizeof(**dirfrag), bad);
+	dirfrag_size = sizeof(**dirfrag);
+	ceph_decode_need(p, end, dirfrag_size, bad);
 	*dirfrag = *p;
-	*p += sizeof(**dirfrag) + sizeof(u32) * le32_to_cpu((*dirfrag)->ndist);
-	if (unlikely(*p > end))
+	*p += dirfrag_size;
+	ndist = le32_to_cpu((*dirfrag)->ndist);
+	if (unlikely(ndist > (U32_MAX / item_size)))
 		goto bad;
+	array_size = ndist * item_size;
+	ceph_decode_need(p, end, array_size, bad);
+	*p += array_size;
 	if (features == (u64)-1)
 		*p = end;
 	return 0;
-- 
2.51.0


