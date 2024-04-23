Return-Path: <linux-fsdevel+bounces-17532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D208AF4EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7362B282E1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0E4140366;
	Tue, 23 Apr 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY0iuuZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7513FD8E;
	Tue, 23 Apr 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891856; cv=none; b=EHA1ojLtTe52bCevRJN+brZVDGtn1DVXl6cT2McJFJZR9k84nLLeJ8xo66niUrDGl4xVVHnlkHdvwQaUViub8HiV8ixAKYIXnK9h4aKJxVqpqmi19BAS9TLsj6B5lX4f6htJP3nyAG9uF/2xfFABF5A80x/aEiqJ76nyVsYROB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891856; c=relaxed/simple;
	bh=A57oBviTsoYjvGYijwaaVR8klkIuYTbTGJn2TKpAIPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLRc/6WJv1Sr5fuv/IxBcfc7U9Fr4v6vQ1X57eoS89IR4frvht9gt3PYfTpbhdTl9/SIdfSd3it+qmNmYVHlm5VEcYO2v0RHOp8imJ1rP1SMKjTewiixD52bYmnmCYNNRgoYhFb+dVd1L6cVcHd2L8eIwSoTGomV9paOW8KCiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY0iuuZI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f074520c8cso5684582b3a.0;
        Tue, 23 Apr 2024 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713891854; x=1714496654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GV/G4qXk1onz2IqC3/BpNLYGtgLEbJph1C4Exu3LQ8Q=;
        b=cY0iuuZIDNefQz9fq65tOzjKVUMeMnXLAmJ4VOBkCRCd2Oc5MDZ7fiek0SJwpdnOv4
         SP0yV4SdnrTRSlIH0hpKXoIfNPFAsRCQTkThEajX1gTtQ16dmkN2KqNL6aWmSjmborrj
         HWi2Nv9+KPsiG97jwVkfEaqwNoxLnf1BpUPtGIDR8YT1JZpcYnjgjNPq+dW+e7p1oiNL
         BH/uOP9yYYoRwW9FlFBVJoCZf2eJ9vk+W9yqPjfXx9Tn94B7yuClxmPGZAbGjdj35530
         QZ2XGWtsakVZpqF/NnllGx8BXUgoyZEdClTmbjn4U9suIUOA9+Vx4Twww3YtmKsOz+uC
         1MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891854; x=1714496654;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GV/G4qXk1onz2IqC3/BpNLYGtgLEbJph1C4Exu3LQ8Q=;
        b=gXOD5n6D7uNY/sLVpPwImHINbC8Z1LHoudECkylw8RMZAJF+XNarTzx5PZJ4VG6K5e
         f8iovzxm+i/02zSf1niUhBOVqn1BOiOeT72g5guOTdpg1h4eYSR1uAKqbO1qzHYsBN6g
         /+73Cu7FTj4pXlfp5DnAUa7wzAY4oFbY2U/34IOaoYSwyYeGOv6N+PtwjAJgdKwQsdxJ
         eHvZ9PAGxQDIk2Kx0HAb/nD9bXg2XiIMBzYtB4QNMh8qxYG+E/RKKTzJRFLkWrFxvXEx
         CRJCKi6I2rhuhmvv1FD28WwancSfcGWCt2UOjYJwGu9GamCQiA7JeQ4B++cr/lVDnAPb
         uXOw==
X-Forwarded-Encrypted: i=1; AJvYcCU1sBnuewWO7bKhDrgQotuWiEwMp+ENgQS0H15X82/oSf16J7q9PNgu2L4Hye9wxPEjTFbqaBKHxgMQEpxaE6v1sKMGXREFX5/OkDxLTQ4zIzXywDXU8Xzz/fjOmAcKVJq7zON8i4ayjSyOKQ==
X-Gm-Message-State: AOJu0YzjoaCaZo7NbDoztb5rbXhdJ3dQQw7BbO3xonxhfUY9yrz8VpDw
	TO5Cb8hsrnd9xmvegPqpGqRI2EvH24MmhkgGIFDSZoBkyyPd7LcgkeQrx5iOl1cNEQ==
X-Google-Smtp-Source: AGHT+IFXnXzggSbP9Ki4cPzdCkuwcEVn65pZLG0YlEPbx8oPpQU9xrUurI5P4h73FEaKFW5G55uUNA==
X-Received: by 2002:a17:90b:3796:b0:2ad:e055:bb34 with SMTP id mz22-20020a17090b379600b002ade055bb34mr6180074pjb.3.1713891854019;
        Tue, 23 Apr 2024 10:04:14 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a881300b002a5d684a6a7sm9641148pjn.10.2024.04.23.10.04.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Apr 2024 10:04:13 -0700 (PDT)
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
Subject: [PATCH v2 5/8] cifs: drop usage of page_file_offset
Date: Wed, 24 Apr 2024 01:03:36 +0800
Message-ID: <20240423170339.54131-6-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423170339.54131-1-ryncsn@gmail.com>
References: <20240423170339.54131-1-ryncsn@gmail.com>
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
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 fs/smb/client/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 16aadce492b2..56ebc0b1444d 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -4749,7 +4749,7 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 static int cifs_read_folio(struct file *file, struct folio *folio)
 {
 	struct page *page = &folio->page;
-	loff_t offset = page_file_offset(page);
+	loff_t offset = folio_pos(folio);
 	int rc = -EACCES;
 	unsigned int xid;
 
-- 
2.44.0


