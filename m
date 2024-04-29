Return-Path: <linux-fsdevel+bounces-18170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA068B61A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE881F22065
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461EE13C83B;
	Mon, 29 Apr 2024 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4Biws0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466D13AD3D;
	Mon, 29 Apr 2024 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417631; cv=none; b=RSaErfgj2APTqy31qwp6X405lwu6LIl4HuMw5ePE3VwwSK7uHzFY1A+gwuQ+DHnGedgnbqr9o/qqlj6BnHTGkSRs36mW3Fpv07mmEb4avmBt/Ay0pFUgjMbJpeXtxnxtw3BTXaT/LKQzyNdQQUf0BwK3nhgNlb5nE4JqRjoyG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417631; c=relaxed/simple;
	bh=bkTdiJFGGBlH6tCXYVyOUBzvEQj2B5ZrCO6Nvtf8Xr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwz5UNn/WgNjsGz0mZJ9Cdzclt80aRm+p0mdvhnvN53A6A2le7l9Lmg1ooRVeZkZUBGjAsUxWoA5RnYCv+BdX9KDxZOaCf1cUXqCcrqTZMNDHK3YoOdw8a9W+Rl9j/7iMRQyJCKIzm/9X5815RQkjrdIzzXL/U3KT2k3tuydjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4Biws0r; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso3162243a12.2;
        Mon, 29 Apr 2024 12:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417630; x=1715022430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7PiwJE9uQmN0uws0CC+HD/WsVJUPjjolITxGR0eGWdQ=;
        b=Y4Biws0rd8uXPURjxBNM05xrah1JGl/g5E2toNmP6dku0lzGkADil8vm9WV3MBeIMH
         gHYpgWNAzsnTs5Ax5DRQKe6ExwbaEVC1WRUROk4+5HqgrOBMwRoBPlFNUzi1kYgIcmYh
         InExNI0gc6izMjJH06Vgm6+RpGUB4WP/raeIXfmOUSNsm10D5wD/+Gwlj6awp/Z7QEiD
         uhEoTMBMqP32NJypZzNon8tnArcPlRJu8XjrFgowaobG9khlzX9/q9d01vfIwb/KXdxP
         wdJBDPnh7Xw7ROG7pZisu+4JDKqjrikGiW38RGL4jDCqy6HiwYZJzZOIKV7pdG/W4bTw
         GMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417630; x=1715022430;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PiwJE9uQmN0uws0CC+HD/WsVJUPjjolITxGR0eGWdQ=;
        b=Pu9JcktP5/8CC3fKF3iyiXYctp4NId1IxGwgZ1ObZlF105Xd9LV22Q6iMsRe46msF6
         CVfOheZWgweComJYhUmN1EztXQxO0muG8dVpeyTRnHc9WHyBTvjvTguEAapJuS60wdQ6
         iLlbWCfpvxg/klkz2hpP2Dp/2iKKMQKykyR0/tuM6pQgamd+g42c5abvstnkpCxyH2o0
         HkkOYMlOSuDo42e846DVrMGVatrSK4xEn1zb/e2D+YtM3XyabQIQdca79Lu4F/yE2bns
         2Kifx6nIdCI9SfJH50tzGlw6A9yayChyvCBx6VpJqd7yVWH1jK3Cod55uBg3nMb/cOP9
         gagg==
X-Forwarded-Encrypted: i=1; AJvYcCUK84721nBucZUWI7h9WHIWqusD2iyzQfWuT1AuMaURrzjpqeIqR6TWfkguOUCMIxUohZYIExaanZOukEceu3ZbfwyjofPONhKN611wgwBSJJz5ohDhxlJ/2KSJ/e9Ri0/eZ+WAOwquMluZTg==
X-Gm-Message-State: AOJu0Yxvm5zhoYkG+ffLQdyxjiXF+InuMjkzW9vQXw2yY5VAxONMRRTG
	2AbrIC87MQqMtNkhTbJggAu7+x/ZtNKO8n9jAsl5ErDCvOIJpSO3
X-Google-Smtp-Source: AGHT+IHTYDIYUhd7xIT9MpX0t66Q+G0hrqubyFH0j3AGRIM7zO+0pTNEqaULQZkZmC4aZ0qNTe1Z3A==
X-Received: by 2002:a17:902:da88:b0:1eb:5a92:c939 with SMTP id j8-20020a170902da8800b001eb5a92c939mr707490plx.29.1714417629601;
        Mon, 29 Apr 2024 12:07:09 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b001e49428f313sm20619356plt.261.2024.04.29.12.07.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:07:09 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Steve French <stfrench@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>
Subject: [PATCH v3 05/12] cifs: drop usage of page_file_offset
Date: Tue, 30 Apr 2024 03:04:53 +0800
Message-ID: <20240429190500.30979-6-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429190500.30979-1-ryncsn@gmail.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

page_file_offset is only needed for mixed usage of page cache and
swap cache, for pure page cache usage, the caller can just use
page_offset instead.

It can't be a swap cache page here, so just drop it and convert it to
use folio.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Steve French <stfrench@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Bharath SM <bharathsm@microsoft.com>
---
 fs/smb/client/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9be37d0fe724..388343b0fceb 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -4828,7 +4828,7 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 static int cifs_read_folio(struct file *file, struct folio *folio)
 {
 	struct page *page = &folio->page;
-	loff_t offset = page_file_offset(page);
+	loff_t offset = folio_pos(folio);
 	int rc = -EACCES;
 	unsigned int xid;
 
-- 
2.44.0


