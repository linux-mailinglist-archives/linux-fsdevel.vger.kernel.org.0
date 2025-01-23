Return-Path: <linux-fsdevel+bounces-39896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA23CA19C36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE531887C47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FA83596B;
	Thu, 23 Jan 2025 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC26jmta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0289035959
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595696; cv=none; b=OI63xJAlzRzTq9DHsco3chmhlhRq7ccG7FiJJlo5iB3MD6zyGbRI469YKhJXr20SzExCPRYc58KZJBdgVrcnniGufVvxnmIwmazoSwHlTkMcsA9hMWVM4kUSvoH9IzFCNpnbUU7WF5Uph9YkXWe71nFMq5AuI8oS0cwfmXzabZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595696; c=relaxed/simple;
	bh=YppN6EpQPqzebsgsTU9ih5N6Sj1iqHcjLOl8HDupkDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CI9HkxQruKErHS55QwO4MM6T5agqTPKqupCtMyEIw1b4tLKti1pjHu24HtbxidytXghhsU/pNiWArYZn2FGT0xH2NVvyEvWtn2FUhz3/8fPcsgGJXXLoNKkQd9gjxgNoNGh1TFI4E2UdJ/RCLgGsVKNg/n410rBYnaf5JMWDVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC26jmta; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e3a26de697fso573118276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 17:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737595694; x=1738200494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVEwBq2psPdFr56uT9dP0HbI4MOFGq/OoRMc6b8lH3s=;
        b=EC26jmta2pxe7RTkjc4OId/BFVUprAGF8DxjbPBrV8hvc8td9gvWvJKEYejcA7UeY5
         aKth1QAhn5TXp737v/MPcd3WV1cVT8DcBbp/iEsUCas4b9NdCb2M5pmwFxrg/iPUZNdj
         Py/06/KBaCyteWU7G6lOZQvqatrcN0nrVYF9DC2iXjXn3nrZVUREFR2WyozIZ7SOAevJ
         Z+vVhnlR/LTp1wE2BsmiazknORdeqPoduQSTw6bMYPPI1oGp3liSJLMaxjyNpRJLvKir
         t0FwUrAZTtVeEXY11U/hBg2UxpagHRQFgPmG8+jNLHe6Lzk2vaI1IJIH9CdTa3H0YMtP
         0JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737595694; x=1738200494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVEwBq2psPdFr56uT9dP0HbI4MOFGq/OoRMc6b8lH3s=;
        b=QaRsK6kF90Fe0WBWKlGp6wAd7Gd0klGSfH0SeCZoS3xfW2Mh7ksiH9lSPu3HLmSwg3
         VY/WfBQ1CsUF7Ja0kUCx2MURO/Nf7qydVS4kPHasscGp/K1jPkKWHk6Iu96mSnUSC+0J
         GCKAEdqyM4Xvtp/D8ArjQAJzVL/xvrHfN0siZ6u+EEnPT0onag1OmQYdbdEDIPbxXVrj
         +xs+V2hgQCFrS4+JTnxl2C8U+C8urvYCeyaY6vAwHrauPj2fJqEc9ov9seWPmPx5Tf8x
         ldGvd6qlqNEEZMWA4V+9cIgW9/2wd+mydWW5kMM9X0O4f+QPaO0Alsp4c+BnmYqzIJYD
         QkiA==
X-Forwarded-Encrypted: i=1; AJvYcCWoYhBPhGpp2xUQk5rgTDHstBGa228CXj+46CQsQuHgP8umKVxdKXNb6qtAXgBY1Up7rvmwh8Vo9WUTORHI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1VQrAHqECMBmVRAcXFPgum2s4KC0Rrrj5H1HqC/4VjsFWt3sI
	8RdfFOtlkcIj/TU3+CcIksfb1fbbvZ3DyCWzN8rbRul3AD7UmDpJ
X-Gm-Gg: ASbGncvBHFOAxZ5V7TwB8Ri/nkgkTbqu3JFQ3pHIOewkpQjKB4P5yu2hMK8TJ90K4dY
	4WYM+0swRoHOrCVxOcQFYHorPzsjpX5clHHaprUIp/tWSM+Pw86OUOlxWULARlhf6nx+rD52Tpd
	RXZOc2MnQlZLS3aj4EHs3sCb2cLTeOKZmbzUrv3cL7YDbXTm9h/LloQ4l/l5/kZTXNpRncTGWeC
	uUd7MHoJnRFUPJjy2MqLqHWSOHurTxvNVvxGDhYYBarj34JogEiFZiCeYjuDsogQDur2cGQ5dnA
	o8o=
X-Google-Smtp-Source: AGHT+IEZI/3EYSxsqLiphu8pyEF/NweTMnHaqBHbO2P3T4QI1I3B2B5NRGx4CTToInXL+gqwW13jPw==
X-Received: by 2002:a05:690c:6812:b0:6ef:e39f:bb1 with SMTP id 00721157ae682-6f6eb905af5mr199947457b3.27.1737595693897;
        Wed, 22 Jan 2025 17:28:13 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e66d1110sm22180667b3.86.2025.01.22.17.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 17:28:13 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 07/10] fuse: support large folios for stores
Date: Wed, 22 Jan 2025 17:24:45 -0800
Message-ID: <20250123012448.2479372-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250123012448.2479372-1-joannelkoong@gmail.com>
References: <20250123012448.2479372-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for stores.
Also change variable naming from "this_num" to "nr_bytes".

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/dev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ded2caa4078d..500224921336 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1657,18 +1657,23 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	num = outarg.size;
 	while (num) {
 		struct folio *folio;
-		unsigned int this_num;
+		unsigned int folio_offset;
+		unsigned int nr_bytes;
+		unsigned int nr_pages;
 
 		folio = filemap_grab_folio(mapping, index);
 		err = PTR_ERR(folio);
 		if (IS_ERR(folio))
 			goto out_iput;
 
-		this_num = min_t(unsigned, num, folio_size(folio) - offset);
-		err = fuse_copy_folio(cs, &folio, offset, this_num, 0);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
+		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+		err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
-		    (this_num == folio_size(folio) || file_size == end)) {
-			folio_zero_segment(folio, this_num, folio_size(folio));
+		    (nr_bytes == folio_size(folio) || file_size == end)) {
+			folio_zero_segment(folio, nr_bytes, folio_size(folio));
 			folio_mark_uptodate(folio);
 		}
 		folio_unlock(folio);
@@ -1677,9 +1682,9 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (err)
 			goto out_iput;
 
-		num -= this_num;
+		num -= nr_bytes;
 		offset = 0;
-		index++;
+		index += nr_pages;
 	}
 
 	err = 0;
-- 
2.43.5


