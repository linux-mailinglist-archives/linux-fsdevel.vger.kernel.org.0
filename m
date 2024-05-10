Return-Path: <linux-fsdevel+bounces-19272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E578C23E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F10328286E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482316D9A1;
	Fri, 10 May 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeADq1sJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3B16F0E5;
	Fri, 10 May 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341795; cv=none; b=CmSvlK8saG1/hMuBE8Ayf+DmFiAJvRZS92lILqS+Ne8yOdEGm4IbyiTuyGif4qGhMnccl4mIj9e768wtylRHB/qddCHtBkVbFWdXlaso+JcitlbUYwvdjG2NFYQ1wJx77YEwF/zDjU4RX0lQI3XFOXKS5QJHIfIfk9mquAw9Q/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341795; c=relaxed/simple;
	bh=ku8t2GgilDn0tasewSdg0prSSx3qEczJXd6flM0DvOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb13GjZzu0SJMANwWccWe7IXLWj9PYXZVt2antRhC0MJvKpby0WGUvHiOmLbMRT1LfXmWLjwkd9Ga6m4gkiRM+A5XIOCFtc0gfu0N/mB8WmzhED3dUQX0XApjwvBW8Y5E9cLc6NfDP641J4EzsrtlURhmjTV8TPMunV1KwHUQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeADq1sJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e651a9f3ffso12280735ad.1;
        Fri, 10 May 2024 04:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341794; x=1715946594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R7lhdO5v0hVN0l2qTLtMelKVtmq+aBFR854K3Ld5uQo=;
        b=IeADq1sJD9vGYIb0awDEs3HywevfGQFJAEO/WNxXMgkEAvcljbBRK3Kgi/gtq2clMn
         fUGSS4/zRKF8tzlEhpVeWXU0B/u9Vfp/5Vs/ufAE+jPs0cEBAEVW7/Fr2F12jKr4PxOR
         9vGSbz5vbvUyosvJ1nN5sql7xMiF4tkNCFJQdLmAkCjB6bCMq5gM3zbvEUfBkBm3T3Vs
         4GbRsAd0aefRrst42XBlKcQ0PnXYLqBh6ju2XMKYCBhAvP1kioWaP7Hr5jGF0bnemWrn
         1RTzDo+1VKjYK1j7edhqipKYJdPST1RHw7hYfE96NjRSElom6YOrQtWTk9UxTDzkdSVz
         C/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341794; x=1715946594;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7lhdO5v0hVN0l2qTLtMelKVtmq+aBFR854K3Ld5uQo=;
        b=PfSK8D02zJicnsUaePzuII8ulkbciL/V2W6bfvMxouXS3LWO2g0cuCCV1qbMdQbJGK
         Zh3cEjZ7E5CYB+qvKfbtQprhot1VdIc5URgGq4TIKuViM596SAtaz88/BgQxxT1CvJsy
         K1yKiSnG8t7PPfDlF4qaNwuRQPRZyclzgI3uLeJ7VT30zhj7mXVBya/RSjb/Qd1+NHIY
         6PKPX6me73myTL1HFpMYLGqNWVj6wVYZYsC8pBFzxuZNaYoRp3uH5jv2kQLi0p4k4PYO
         HQfYO31YaOXXYYpiSQAfnQUtcbAuGRuwYDsPhgMGxOnc7lSmAghMTuejI+WwRvgGnyGF
         rw4w==
X-Forwarded-Encrypted: i=1; AJvYcCWd3LMdNn2wPsOWpMisWHVna33d9SY11xKpE/DK3U4GYsvhptpvy6pJjdMiKFFvHHswEKoZ9zlCz5gyps7q3O4iMBMqg6Yl3PNh4fqOt1yIiwgn/GnE8cQhZRacGnFGPPhvkO0kaHQAEhKkeg==
X-Gm-Message-State: AOJu0YyK6heI0Un9o8PtfbuNjCvHlxaox4ZszyASfRcR+reQEQn67492
	Lh/3/ZbjJ9+TdsMCTJNT85fhB6GeTRgvrqkaBSnHwzGS+ayyvJL5
X-Google-Smtp-Source: AGHT+IFE2MX7TpHnes9SKnTNrFmEbBsmeG5v6bapWIi2SW3d+oyDfBCDoaA4IMTDGi9eLDl7rTjLlw==
X-Received: by 2002:a17:902:d506:b0:1e4:24cc:e021 with SMTP id d9443c01a7336-1ef44050595mr28789215ad.50.1715341793856;
        Fri, 10 May 2024 04:49:53 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.49.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:49:53 -0700 (PDT)
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
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v5 01/12] f2fs: drop usage of page_index
Date: Fri, 10 May 2024 19:47:36 +0800
Message-ID: <20240510114747.21548-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510114747.21548-1-ryncsn@gmail.com>
References: <20240510114747.21548-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

page_index is needed for mixed usage of page cache and swap cache,
for pure page cache usage, the caller can just use page->index instead.

It can't be a swap cache page here, so just drop it.

[ This commit will not be needed once f2fs converted
  f2fs_mpage_readpages() to use folio]

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 961e6ff77c72..c0e1459702e6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2057,7 +2057,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	sector_t block_nr;
 	int ret = 0;
 
-	block_in_file = (sector_t)page_index(page);
+	block_in_file = (sector_t)page->index;
 	last_block = block_in_file + nr_pages;
 	last_block_in_file = bytes_to_blks(inode,
 			f2fs_readpage_limit(inode) + blocksize - 1);
-- 
2.45.0


