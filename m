Return-Path: <linux-fsdevel+bounces-60011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD7B40DA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 21:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DED81B273A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE6534A335;
	Tue,  2 Sep 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="r1Pqyo+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29C21CFF6
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840148; cv=none; b=aNp3LozckNDoP0xh/9SXURn1/7oxYl6bL/r3I/mA7rhfJWlzKZnJZLgZvf/4pTqFp7wvm3Yj5GM/cHBc4bSV9j2V8twWnigu6pQchxpKZjuBXzlVTAgHbD2LESJ2mSBttz9V9Sn42tEhDMBHLuonT5o52AiB54z+6KmOyJ4+ngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840148; c=relaxed/simple;
	bh=gjGgx7UzJvuEyQuXnBwthfDf5jaQSwUQg9LipixWID0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocdvtGHpFKivnP7wJ8UbrJoCL+KEfxqtZg95fNIGYe8gua3bAHBbakwkMSwxtWV8l4yFb5/FJvBtD3GZqIX7BrF00Ns0z8rfipPyIa/d0H9t462Rodt+BPT515VsIsiPDj/FFNJk6LAJnviX3dCh6y2Dh8kwS+atbYQKi7bB480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=r1Pqyo+i; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d603acc23so47573627b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1756840145; x=1757444945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pfhTRMxc3w4sI+Ws9TMxQJGhGxzrh9QlIlnNCmqZ880=;
        b=r1Pqyo+ihikKuZBpYgFjx0h1ivqYwY8pGnqxl/yZBVBX7x2Q9x1HzR7YFSP7pcMZoS
         Fh0rNLD3tEiM4j3zYvfZnAII5LTBgCv6G8qLzbgjnBg8w0ByC+33yz+1B3BG0WBW8TQl
         zneGavQ953giy4CA8W5pKLXXhH6EixCfP0xI0qkFWYmbCgZLQSRM1HYE9EwGdASAPZzC
         SuQRB4S847noPpq6t1X3i3Pes3pnbsmx2MvUDwdxOu4JFm3BrJ7Ss8yIbJYakdXFJfr2
         biEuHz1c6crMRR/6AdgPUNaErlpLWzbbSfDpCEcRmC6L6QpVqOJHnVTZxxXEV7kLO83q
         sYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756840145; x=1757444945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfhTRMxc3w4sI+Ws9TMxQJGhGxzrh9QlIlnNCmqZ880=;
        b=Qb/vSbv6KpUDjhHqGBZTFvOZ7S2waMWt5ailpTuBbLK97TbtBfkqqzPTAgFNRQDtUf
         EZWT3YgHX+0eQz2pf2rZDE2FBbrkwFm1mzx8PBJUoywLI5ohy6kxOuImZarNYpmlI2vr
         NkTMxnkC9D4AVTJP0ICIjJW33X4cZizTozpuvEtN8vCsAKxJz2ssjxDRNKW/ffge8buB
         SXLvVXbXGaodqbTpiDmmrYD2eutaBWai1QS6AMSuEG8o5nhfQ+2ftDiyabJZMutZPpJG
         xG4Wncxba18NUVPNXNnpFIcgFEckhHcbnADx/NtWvmjS7gqs/EpRsTQR+vd3av2wHeKL
         pQOg==
X-Forwarded-Encrypted: i=1; AJvYcCWw54yoFqhTILGa2XuBmNcnHhB/Cv6SjhzCKYXZi50940NTvPKSli9rBvPbIKCShxwkqRYrwNwzmgtOkWNE@vger.kernel.org
X-Gm-Message-State: AOJu0YxHDFC98ifut73Q0NLaUsTEZFlTbBvOJ+c8lLuj0E8ASEBAIR1t
	UF50N8M4hwK7iZ7hVjOKQK1VbhML0wjpKc3iNJcwEFIKHcSgz838vWAR6qe3LdFJ2Fs=
X-Gm-Gg: ASbGncsWChJ8tQW1wnQ1bun6JDmM0n08JNHh33q3tIA4WxCT/gyto7Dw59rE01sq7hf
	9YSMRM5EJeeyS1D806H3jrpNe7Lr6hIUpVHyfSBDdyLww+vupFa3Nco/1j84oGuH27UsAlS4kwf
	bDB92YABOt2t9kSQCmUMXdOm7PahMX36c9b7YYVBXWIJDLiRe/ikwVDrWronxtCcQbFXQ2h2awe
	Vb0Cb39Nl5JqkxVo8UoHaI48qPT772peu0bcNiAscvT4d9YjFm18mjIZpJxt+X9x5U0xfl8Notw
	xMe4+cstEh0ysQZj/6uf36KND3Vgrm7t8JY8vfGZcmptr6NvkOOGD0LCu73UgnVXSr1MBynwosS
	uJGUvJU4bTShpkuUKVcGB590YG+P4xKU1UbYFcm4=
X-Google-Smtp-Source: AGHT+IGKmAkpxRyQdHljA2XIyxBhLTt0nmxyvM8eiqBA5oGrXxrshIKoAfdtOjvA5NjNy829Lp+vGQ==
X-Received: by 2002:a05:690c:f03:b0:71f:ff0c:c96a with SMTP id 00721157ae682-72276406d4bmr152569777b3.24.1756840145112;
        Tue, 02 Sep 2025 12:09:05 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:5abd:b705:e7b:f18d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8502869sm7321657b3.35.2025.09.02.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 12:09:04 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	amarkuze@redhat.com
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [PATCH v2] ceph: cleanup in ceph_alloc_readdir_reply_buffer()
Date: Tue,  2 Sep 2025 12:08:45 -0700
Message-ID: <20250902190844.125833-2-slava@dubeyko.com>
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

v2
Alex Markuze suggested to add unlikely() macro
for introduced condition checks.

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
index 0f497c39ff82..992987801753 100644
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
+	if (unlikely(bytes_count > ULONG_MAX))
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
+	if (!rinfo->dir_entries || unlikely(order < 0))
 		return -ENOMEM;
 
 	num_entries = (PAGE_SIZE << order) / size;
-- 
2.51.0


