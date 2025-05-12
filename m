Return-Path: <linux-fsdevel+bounces-48783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BEBAB47C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 01:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9B14A0017
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 23:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F9929A33A;
	Mon, 12 May 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MblC/zM/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999829A334
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090781; cv=none; b=KEBhHQnOHbvI6yskvlo6jQhkTWn+s2U7jDvy+gBpAHyw4aiWlwUR00YAtr3IhBRVaNtDTpYOaV85+RsecYoHW1sBS/9Jl6JGXdiYAOY3oE6jjRFCscsR6bau3ckEWe9z1fjgvLFT2i0Y7JEREYQTEF4OKiVWkHwbTE2RzDMf7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090781; c=relaxed/simple;
	bh=mkuc7eyqgKmWQ45ju88OIkyNwB20fK0QVlTFy7Z0Q9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7Ygx9qCCiAqUqnN/kjYhzK1xj8Y9uy1b4PgqjWi83xfOw+J7/XzDsiNHkjeasXjLlOgHWNdCRMOBmlm0ixlilGIBaxsy7bv5VhS5RVKf6i+utdJ8GfTbIgmM5in13KG2hTjQE8+RVoRi53+Wg3e5TlpF7B1IzsII1Yw9s0f/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MblC/zM/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30a8cbddca4so5780761a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 15:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090779; x=1747695579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+J1TV9qHtfFOGsLQABAxQzL8e8wA9Rd8nAo+lCuF5o=;
        b=MblC/zM/L8Gjk2eS/86jF0ekT1ii3WT8jOajv0NaifAGcqDKf+6yftxjEXhFUYZMco
         AkcZAV1Yp4dBuF2uVzF19q/pKvcx5ywppj7MZJpYwl0xw/BbpTotckRU9/EaHF7Nten9
         FUyckfXoxl6PdvuV9AL9WqY+Q44Lf9Vc0FGjRcub4RuvCOCiR8mK4tGTH/MV5tzGcBEj
         HFdlTI5wS7IMD7+OuFmAt4shWlM4v9Adb7+95N510lRdWpkUk61GemFEYT1uOkYX0KCF
         5r6W0gYWxYuxsrHaTHFUQu2De3qsFqNn4yCaBUfvqSyiL7YsVQ7qNQ+gEDfblrpTSk7y
         VTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090779; x=1747695579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+J1TV9qHtfFOGsLQABAxQzL8e8wA9Rd8nAo+lCuF5o=;
        b=ZQoTPCRaBpuXOAZ8ijACh3zAwktMps+KOMAIP7JeNs/UIC1NXxPlQ3wGdJtM0hKuQj
         qOvvuwjPDrQAmwkAcnm8sPA31/cyr/riG5oXtnXgUmd5YvVq9jkbJT/zyK4wLfBW2sx7
         7rCsS2v2ij//pKqNfzXwj+6yqSMQ+LJ9Mx23TGvIsjWuW1hpFyBdyvzrrAIpMOFrzRVm
         Ogpj5D1FrhAMXbtnvAygBWbzH7Jk39PWLCu4j3BZMRPDywWQ9F/vHtSclhYW3oPL/agm
         vXrSzGW/tFMnv+lCtEebaPqxIX64s+CpcoCNXespKQaSzr+jvgOiyRw8EJcLGJiF64K2
         SsEw==
X-Gm-Message-State: AOJu0YzYMGAH2bPb+zXsjr5RNgAGdv7lVVagskQWjURzFwdeCnaQVLOP
	ZM1bdtBxLEVOkaBGwxT3Nau/jdz036RMtyt78XpuzkD/7hgqvMId
X-Gm-Gg: ASbGncv8sOdVk/+K6ZAWtKyl/zq01bmx9gSOmk5NAxHcw/IQoGhEgrJWfX88XR6g8WQ
	ezjJdLia+j+dUG8Ht/oEJteYQkhni90rdSRUjnZ1HDDsQKxHn4wspbmskhJM0wCHSubmPhULRNZ
	/+2I6US90GQzPsCKZJ9Jqqprm6/h0xgFAFg1btCf1W6bDAKyi5oXiUKJGc/PLYT9lhkvGixSpFh
	kYyYiih9hD+PEKCgT+xbLUAT0UA2lBjfgO8CVgvms7BGfxQfg9JcCABxuGgsGna8u+xmTeP/ZIg
	ZVF6C9HmnUDnLOF7bTMlZihNcS2yaVhD1+9VcQoVj0cwQTm8rKLSids3kg==
X-Google-Smtp-Source: AGHT+IEs8XValo7Kxr4+cQFUDv51t+PtFcz+w/QYD4V85JpkhsV4pF2YqHAYLD1+InyE53uyNk2aCQ==
X-Received: by 2002:a17:90b:1846:b0:2ff:58e1:2bb1 with SMTP id 98e67ed59e1d1-30c3d65cc2bmr19820731a91.32.1747090778894;
        Mon, 12 May 2025 15:59:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc8b13sm7235572a91.10.2025.05.12.15.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 15:59:38 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	willy@infradead.org,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v6 08/11] fuse: support large folios for queued writes
Date: Mon, 12 May 2025 15:58:37 -0700
Message-ID: <20250512225840.826249-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512225840.826249-1-joannelkoong@gmail.com>
References: <20250512225840.826249-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for queued writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8efdca3ce566..f221a45b4bad 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1789,11 +1789,14 @@ __releases(fi->lock)
 __acquires(fi->lock)
 {
 	struct fuse_inode *fi = get_fuse_inode(wpa->inode);
+	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct fuse_write_in *inarg = &wpa->ia.write.in;
-	struct fuse_args *args = &wpa->ia.ap.args;
-	/* Currently, all folios in FUSE are one page */
-	__u64 data_size = wpa->ia.ap.num_folios * PAGE_SIZE;
-	int err;
+	struct fuse_args *args = &ap->args;
+	__u64 data_size = 0;
+	int err, i;
+
+	for (i = 0; i < ap->num_folios; i++)
+		data_size += ap->descs[i].length;
 
 	fi->writectr++;
 	if (inarg->offset + data_size <= size) {
-- 
2.47.1


