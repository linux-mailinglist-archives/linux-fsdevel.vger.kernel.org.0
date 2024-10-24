Return-Path: <linux-fsdevel+bounces-32805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6999AEDCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3811C2365C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C71FAF1E;
	Thu, 24 Oct 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOVc4LZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D801FC7F7
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790496; cv=none; b=Jv3W1TUo1dNcPPNOGpQlV2sEsfJ8uBYGfoT7bqF9p1wkO/EgY+lXkYA/BBMq9w7Af9aR95+hotTXhV0Z4Zt86AoSiG+wp8ZCwJrwgR25RkM5isbQ/FmzxemgIKZfpT278O83iDg83wD/gT8rMRDhf380T/00jz3Ww/opk9dU3Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790496; c=relaxed/simple;
	bh=4MEV22g4XjsggbYOYj2TugUOdvoBUWfpcLG9LT8sZss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fq2djcRbvJchRk/l4cM0YuS0o54C5br1Qg9vsTGkG2AGGV3fvNaJzLGwhtHA1jPav255vPocbiKdeIJGhDPEGSVVFv4YNcrqDNH67B1y58XmvzsGz1xQCnonpRXQDKhQYDP67l0Q5QoUpz5vP/h0D9GDjX/+NVJnQBYMCMnEsS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOVc4LZi; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e35bf59cf6so23170517b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790492; x=1730395292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fnLj/x/wj/MDATez8fu+sEbs2DKFZMz09D7xlaJo8s=;
        b=MOVc4LZihLv/ZhSiGZejVjmAeywmpBt4P8eKakHfSsdcptS9ufODn6YBevKapuM70R
         exhQi1D6VMzaVKhIovZQOKZEYS1NISTmY9NgoWyErH4zG4ARsZYZZnnrLutLvUWJtH5d
         kZAlVMtIKTt+ncUfRav+Timd1oykemZ6oAPfWB+u4Ac0jv/5qzA+7vU1dvu8hS3fU/wN
         3wsjWDVd/MbiFMP2+rna+uvKtMZd644n/eYc2jMtFPKj+uQiW5lFQq/bpYiD8E8hIKOg
         kvHV/eBjHV1iAQNcXIV+0J69GjhGQzMwBCKs9UB6hJQRebRshu6SJeKyMZ43VLKqFpTX
         /kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790492; x=1730395292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fnLj/x/wj/MDATez8fu+sEbs2DKFZMz09D7xlaJo8s=;
        b=CM3pwQxlmFRHY82XGmLsCpoyd7N+Bd1xrAB0JKBnRTMnl788eYFexnN3bMBXItQIiS
         pshhDS2PeXNTtnOKsybcXke6SG9kKgOZ7VLz+osIXW1fuUx7Py+IQYh0Ai9sLkgnNvva
         2ZibDGRydv3Nm8PQr54U7a74mDX+6T4iUbHTAV00e4UeFABYBGTV6TVkiBledduiMsWy
         PqdHz4Li7XI/2j6CZEpx6eYYGDIWfHYG5H8Zcy3Otwh365PrzUfVLN5jtT3Uh7id0Sjr
         qN05ngvWRk2jXHZphERk5lF0tFB89L4xkDNeX/zn3rxa6Uvq1JOpvdanFCGNXs/Zj8VE
         dpzA==
X-Forwarded-Encrypted: i=1; AJvYcCWz1Ym4BWsTegJDpUnbtXW1A2pG6tKQsZjzrNMsGaEzmNwRvOBms9KPlbMw6iHwXg6CktkG7XPsJ39eR42w@vger.kernel.org
X-Gm-Message-State: AOJu0YzY2J2OkmY4pPm4w7Q03zSrMBthntfyzTFSH7cqCHn0aoBFvjdw
	I4mmg0hlL3fEAU1UGnPOwVRWZJgtucEic/gm3Hv3HqX7TWrpcQHj
X-Google-Smtp-Source: AGHT+IGqwderlHoH9Rx7tTdrPq4WNv797Exhgm84fMDEBWRlJfm1DJ/z+kW+qexJadeUqsJVj91HTw==
X-Received: by 2002:a05:690c:2c8c:b0:6e5:2adf:d584 with SMTP id 00721157ae682-6e84df79fc6mr20629977b3.14.1729790492066;
        Thu, 24 Oct 2024 10:21:32 -0700 (PDT)
Received: from localhost (fwdproxy-nha-012.fbsv.net. [2a03:2880:25ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a4d3aesm20603327b3.37.2024.10.24.10.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:31 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 07/13] fuse: convert writes (non-writeback) to use folios
Date: Thu, 24 Oct 2024 10:18:03 -0700
Message-ID: <20241024171809.3142801-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241024171809.3142801-1-joannelkoong@gmail.com>
References: <20241024171809.3142801-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert non-writeback write requests to use folios instead of pages.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c   | 33 ++++++++++++++++++---------------
 fs/fuse/fuse_i.h |  2 +-
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ece1c0319e35..b3d5b7b5da52 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1197,8 +1197,8 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	bool short_write;
 	int err;
 
-	for (i = 0; i < ap->num_pages; i++)
-		fuse_wait_on_page_writeback(inode, ap->pages[i]->index);
+	for (i = 0; i < ap->num_folios; i++)
+		fuse_wait_on_folio_writeback(inode, ap->folios[i]);
 
 	fuse_write_args_fill(ia, ff, pos, count);
 	ia->write.in.flags = fuse_write_flags(iocb);
@@ -1210,10 +1210,10 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 		err = -EIO;
 
 	short_write = ia->write.out.size < count;
-	offset = ap->descs[0].offset;
+	offset = ap->folio_descs[0].offset;
 	count = ia->write.out.size;
-	for (i = 0; i < ap->num_pages; i++) {
-		struct folio *folio = page_folio(ap->pages[i]);
+	for (i = 0; i < ap->num_folios; i++) {
+		struct folio *folio = ap->folios[i];
 
 		if (err) {
 			folio_clear_uptodate(folio);
@@ -1227,7 +1227,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 			}
 			offset = 0;
 		}
-		if (ia->write.page_locked && (i == ap->num_pages - 1))
+		if (ia->write.folio_locked && (i == ap->num_folios - 1))
 			folio_unlock(folio);
 		folio_put(folio);
 	}
@@ -1243,11 +1243,12 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
 	unsigned offset = pos & (PAGE_SIZE - 1);
+	unsigned int nr_pages = 0;
 	size_t count = 0;
 	int err;
 
 	ap->args.in_pages = true;
-	ap->descs[0].offset = offset;
+	ap->folio_descs[0].offset = offset;
 
 	do {
 		size_t tmp;
@@ -1283,9 +1284,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		}
 
 		err = 0;
-		ap->pages[ap->num_pages] = &folio->page;
-		ap->descs[ap->num_pages].length = tmp;
-		ap->num_pages++;
+		ap->folios[ap->num_folios] = folio;
+		ap->folio_descs[ap->num_folios].length = tmp;
+		ap->num_folios++;
+		nr_pages++;
 
 		count += tmp;
 		pos += tmp;
@@ -1300,13 +1302,13 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (folio_test_uptodate(folio)) {
 			folio_unlock(folio);
 		} else {
-			ia->write.page_locked = true;
+			ia->write.folio_locked = true;
 			break;
 		}
 		if (!fc->big_writes)
 			break;
 	} while (iov_iter_count(ii) && count < fc->max_write &&
-		 ap->num_pages < max_pages && offset == 0);
+		 nr_pages < max_pages && offset == 0);
 
 	return count > 0 ? count : err;
 }
@@ -1340,8 +1342,9 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 		unsigned int nr_pages = fuse_wr_pages(pos, iov_iter_count(ii),
 						      fc->max_pages);
 
-		ap->pages = fuse_pages_alloc(nr_pages, GFP_KERNEL, &ap->descs);
-		if (!ap->pages) {
+		ap->uses_folios = true;
+		ap->folios = fuse_folios_alloc(nr_pages, GFP_KERNEL, &ap->folio_descs);
+		if (!ap->folios) {
 			err = -ENOMEM;
 			break;
 		}
@@ -1363,7 +1366,7 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 					err = -EIO;
 			}
 		}
-		kfree(ap->pages);
+		kfree(ap->folios);
 	} while (!err && iov_iter_count(ii));
 
 	fuse_write_update_attr(inode, pos, res);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b6877064c071..201b08562b6b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1096,7 +1096,7 @@ struct fuse_io_args {
 		struct {
 			struct fuse_write_in in;
 			struct fuse_write_out out;
-			bool page_locked;
+			bool folio_locked;
 		} write;
 	};
 	struct fuse_args_pages ap;
-- 
2.43.5


