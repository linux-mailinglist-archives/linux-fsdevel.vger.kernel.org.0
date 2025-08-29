Return-Path: <linux-fsdevel+bounces-59664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B6EB3C442
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3DE5A35CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 21:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5A2BE7AD;
	Fri, 29 Aug 2025 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="mV1k6mT2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2820B22
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502967; cv=none; b=q2A8/bnH45MMIDa0x6vLHqMnr+ARNuiTDUb+RlljURMLEc+igAA3WQP8zzR5NTqIiMvz4MNzpEKdXnhLQUc9iQuaR6Jki+iEEVQRTciOBr5YN5LxV/HGteto8zPUeafZBv5efNoEyObksMh9YaqIdAW8rWXaYP2sAWNy+ETXeX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502967; c=relaxed/simple;
	bh=hV78b/+JhSlZkaNyoJ0dw59qNlc4TBxbCEcPm5DhfUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jkb/AZToFOFguLzi0W8q/dHDT4LtOmiIYDS2pPq/otAVotOy1AtZXqgc9QQFfHmfRecIUPegq177z0jNcyINqdIQckW4hzEEj7mhnMPOhCPFj05UvueS/NIIjdZeIIIgjsya3tgQAiEcrLd0C97ymNouyzRwgKKGzUkgflWIdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=mV1k6mT2; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d71bcab6fso21636107b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1756502963; x=1757107763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rxWMp4YUoI/SPFDj6FZN1x6cHgl9fGez73Zz5i+2+aU=;
        b=mV1k6mT2kLW4yyUop4sg0oTa7WuYlKJ5udrynsGjwc/ZQ5impSCQFjW3c83Y+pgIIg
         ObjDyqV0e15koW/7QgjsgDI//brx5OIk2DfS/TJ+i2AkuBjoqdHjn6HEdJH0Wat10LaI
         NUWeP4abPsYmmEGoFuhXcDv8W20NpD6M02vfg5DOBdVRKHDnxq5J9H/u9ik9LFGrKQ+6
         N5rfJKdibDeQl1WEhUtjhCWAaVt9oDSdgXQoPdWQFAwoX9f6IpqmzF935EtVuTvDVklQ
         l9Jfn8Jj/CxuriWW6Wrrzj8Sw+n/jEzz/TQg1HIyWR6zyqYpXRTmo3w5wcxBEXdAYkh2
         yLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756502963; x=1757107763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxWMp4YUoI/SPFDj6FZN1x6cHgl9fGez73Zz5i+2+aU=;
        b=KCXnIwhvq0jyVIh9qP4uS3sMeonk9BKbqNMb/b4GNLld6VT92I9ikxl7UTu+N1YVi7
         h0MmmpaG3PYP48U/T3XfRaXysWllmj5f6Gov2msbAbP70x/TGujLxlBNlbzpXh3YtnTC
         GHXOHj+YGb1Q8O7S9T11fCkBa17l4tpNre8UCTM0/mLhEozdCdDhZw+gtnHXERZaKUnv
         ti19oNOfKlSBgPM8WLOA9wRcE8rTP4ooq4lWyIfOCX8Mf5O0PNZMws8ViAj4GRv03b88
         W4LMzzdTistZITMFHd3nkH7fAFZFvKBXHz6ZUEOMLIPv7+vwdORr7EBpUXWpCjFWZHzs
         Z/ng==
X-Forwarded-Encrypted: i=1; AJvYcCXcEb5V+3x1DZ5YxG6KQyQeF+I9hmJuvSjcxmv8g7i2FFsP9JGzzfm1U3HhgoZW+QBL46tFLVap5J3xb+YH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5jJGxznuRZoBaqIoQ9H0UnCQpiBy2na45wwmIuZASx3EyO5y
	CL570oFeJu1xNeuKYEYjX3azwdhPVB+ZiF9cGsJk+OZkDH67WE0emj6CW0i/8UCbqN0=
X-Gm-Gg: ASbGncu7rb6KQKV4HYBQlRid97YYjhfmedUyiUdPnlTRrG96DPMeGNI6hQf5cZfXAVR
	g4vRrysKnDtG5CbJBwATlb80Ej8an0Z9VuTX3JuobVbEZBFUcHEV6CrP9FNJ9uyh7c3PiP6LRuG
	Y54bcz/nncbt4V5OjjgXGdZWIVNDPM9jwpb047DXNAd9u8nXaBOMcB3PJAH8g3n3PpVg2nx4BYD
	ZVRLidK64FKAWvfrr0s4PEOKpBFG1WAz7bizkMHgZXwRiLJDF3RKG7+g9EJCZSA+YcmqL2idVcf
	hg2L5utYyqlNUwL3/rHjNYJxL6u2NVo3rjlJbNSy2Gy3htyeQvBSWrk0+obfacvVLi6YliMqOV3
	id1TsQ5ps4n/rwqBkJGl+KSFpDt2hj72YDUgt4Kjo
X-Google-Smtp-Source: AGHT+IE02pn+a3WHTvbWPCwPPFbpk7f3pdsrPjHknBBOH1cB2cQAaz5ypmDb+KWYVcf1Nx9T/vSuWA==
X-Received: by 2002:a05:690c:648a:b0:720:c65:eee0 with SMTP id 00721157ae682-722764052b0mr1306607b3.19.1756502962836;
        Fri, 29 Aug 2025 14:29:22 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:ae3e:85f2:13ac:70a5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721c634891csm9891787b3.20.2025.08.29.14.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 14:29:22 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [PATCH] ceph: cleanup in ceph_alloc_readdir_reply_buffer()
Date: Fri, 29 Aug 2025 14:29:00 -0700
Message-ID: <20250829212859.93312-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The Coverity Scan service has reported potential issue
in ceph_alloc_readdir_reply_buffer() [1]. If order could
be negative one, then it expects the issue in the logic:

num_entries = (PAGE_SIZE << order) / size;

Technically speaking, this logic [2] should prevent from
making the order variable negative:

if (!rinfo->dir_entries)
    return -ENOMEM;

However, the allocation logic requires some cleanup.
This patch makes sure that calculated bytes count
will never exceed ULONG_MAX before get_order()
calculation. And it adds the checking of order
variable on negative value to guarantee that second
half of the function's code will never operate by
negative value of order variable even if something
will be wrong or to be changed in the first half of
the function's logic.

[1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1198252
[2] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/mds_client.c#L2553

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/mds_client.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 0f497c39ff82..d783326d6183 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2532,6 +2532,7 @@ int ceph_alloc_readdir_reply_buffer(struct ceph_mds_request *req,
 	struct ceph_mount_options *opt = req->r_mdsc->fsc->mount_options;
 	size_t size = sizeof(struct ceph_mds_reply_dir_entry);
 	unsigned int num_entries;
+	u64 bytes_count;
 	int order;
 
 	spin_lock(&ci->i_ceph_lock);
@@ -2540,7 +2541,11 @@ int ceph_alloc_readdir_reply_buffer(struct ceph_mds_request *req,
 	num_entries = max(num_entries, 1U);
 	num_entries = min(num_entries, opt->max_readdir);
 
-	order = get_order(size * num_entries);
+	bytes_count = (u64)size * num_entries;
+	if (bytes_count > ULONG_MAX)
+		bytes_count = ULONG_MAX;
+
+	order = get_order((unsigned long)bytes_count);
 	while (order >= 0) {
 		rinfo->dir_entries = (void*)__get_free_pages(GFP_KERNEL |
 							     __GFP_NOWARN |
@@ -2550,7 +2555,7 @@ int ceph_alloc_readdir_reply_buffer(struct ceph_mds_request *req,
 			break;
 		order--;
 	}
-	if (!rinfo->dir_entries)
+	if (!rinfo->dir_entries || order < 0)
 		return -ENOMEM;
 
 	num_entries = (PAGE_SIZE << order) / size;
-- 
2.51.0


