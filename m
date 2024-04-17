Return-Path: <linux-fsdevel+bounces-17164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFB78A8884
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801871C216D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FC015E1EC;
	Wed, 17 Apr 2024 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBq+XjkA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD715DBBC;
	Wed, 17 Apr 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370205; cv=none; b=qlxCv6ealdAyXzinLY6URJhSztTPLGUlAx+9BUuk56op7Nkg+kwTCEk8Cvm08tL8q4Tt4uOyB0l+xgS01ZUtDTqdYvSdVZQ5E5U6pt7vNLXNqPOklJp/SQjdj9iF3n+I7a3jR6Z8xwkzyVgnXCJmjNNGpFluZb5ouxgsLwyHSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370205; c=relaxed/simple;
	bh=lRmS0vfrkRgKu2V0vYqMI+J5yAkmvRW6Rx0XntA+fCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p41E0ihp1WrSd1yYAvH5WhdUGhuyG+2zpWnnCrA8zX0+HVyx+h+DuJ5xwHYylo685lvHDR7Tqi0j6w8lVilAOU6WcUW4bw36OCwibcAhOVj1zsqaHAPeSlFxOLaFV79DuO0SZzr1w+32mXeqnwNPpTLcR1kKtdNRg29MT78iHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBq+XjkA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed11782727so4971254b3a.1;
        Wed, 17 Apr 2024 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713370203; x=1713975003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QKsmOxPUvJ8jFqBm63ArqbRFjM5INLEtk88J9DbM67E=;
        b=PBq+XjkAZNsNqLL3kptoBsgjyTBVKvmWpyas6Rez1zBGm2ttk5bUjJu77Rt88CFXAm
         jD1he8mhheKxweCR09JezTPnXszkUdWOpuua1pJvBjq0gEMD1PW5u7Hv3tR9+VTJcFVX
         2voGQhPbKbNd5KOd6MHeZljRx9T1RrfDRa6PQV7y2elsNNYXYkmm4cSComk8UUQdtQIB
         LLhsZBiwhVUn32LgHS0qs3kNrpMAOpLIowSgNCc3rOw2co6gvPS+Jc2VD/BeiABuSWid
         Fiz88PW1GlZrukGv9DMyX1M7Nuv47zti+kXRugiBu52fhXFgyPaaYgsAYmUp+6TVN18F
         Xnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370203; x=1713975003;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKsmOxPUvJ8jFqBm63ArqbRFjM5INLEtk88J9DbM67E=;
        b=petvuo8c3apcCjWornrRO1+4u+5mkjZgtqeyTASohLvisFL9xz8mNpFNQlmbxLLNlW
         ULfdl7Qx0tlcymHjWA2+wx7XAWS+jLElF4TiZi8EVUmG4xaMlWdh37dnEph/Ddpu+eKf
         8mnlLUGH+51ZHVb+IkGpTZxjCFTxOj17xVi90xPuYgGjpCYwIIKc0T79SV1vKkApeY1d
         ADgGDJ4IZw9kfaiKReAbE41RVYsYhgbZJEAv9BKDrWQLmAkHWLzw7OkzcgLpGpfLMPuu
         lN6jZSjQi5grVRyRmWMePujSrhPNYDvbdoA3B3A8l46KIsJ+1exJh5bPpLY1gIrp8xH8
         k1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWExE4FcJJJJgfnXtoVpuiydkMSpbu18ZvEILoZropgP7DdbdP8XkYbeD80WfsX97nscZorZv1Lo7GQmqltkSrbd2xXSzYgz5gY91obWcNY3w6/4E6ep7ARdVzWUak7J4gzXLeNcI20LGyG7Q==
X-Gm-Message-State: AOJu0YyWLZqWGRokLo+JtBncIxk1MerPZIe8Or9OYt0RTBU2TAXvcBRL
	UcZl77PX7k14+2ObV6xz3pee3w4SpxBys9Tfs3X7eRFe+jRhZmjW
X-Google-Smtp-Source: AGHT+IFJeyb4K3TlyeiLY9c8kwF5soNMLS4dioE3GGli82q9k0eqDSGM6THIcyA7JEE4hz8B0VjGpg==
X-Received: by 2002:a05:6a21:8189:b0:1aa:58d9:1825 with SMTP id pd9-20020a056a21818900b001aa58d91825mr83965pzb.3.1713370203077;
        Wed, 17 Apr 2024 09:10:03 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id h189-20020a6383c6000000b005f75cf4db92sm5708366pge.82.2024.04.17.09.09.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Apr 2024 09:10:01 -0700 (PDT)
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
Subject: [PATCH 5/8] cifs: drop usage of page_file_offset
Date: Thu, 18 Apr 2024 00:08:39 +0800
Message-ID: <20240417160842.76665-6-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417160842.76665-1-ryncsn@gmail.com>
References: <20240417160842.76665-1-ryncsn@gmail.com>
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

It can't be a swap cache page here, so just drop it.

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
index 16aadce492b2..73bbd761bf32 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -4749,7 +4749,7 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 static int cifs_read_folio(struct file *file, struct folio *folio)
 {
 	struct page *page = &folio->page;
-	loff_t offset = page_file_offset(page);
+	loff_t offset = page_offset(page);
 	int rc = -EACCES;
 	unsigned int xid;
 
-- 
2.44.0


