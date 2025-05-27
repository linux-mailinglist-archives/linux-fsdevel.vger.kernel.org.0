Return-Path: <linux-fsdevel+bounces-49920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD0AC5245
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 17:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8616A8A0106
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CDF27BF76;
	Tue, 27 May 2025 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xzhTJu1C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7525DAE1
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360628; cv=none; b=Z+F9zeOJjUe+xYcC6STsUdV2aMspTb2JPu5KNNqGP3v19AxJ7P8pzIkElalM6/Hg35Ma3wGxJJO0T0Dd1b4ZwSks+boKTr0XxEq3gM3zIGad522rATlDJhJbsKLltYc8o/xVGB5CxgJbDWk+Vg6DhmDSwLPEZN/lakcOcGOvDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360628; c=relaxed/simple;
	bh=fvBOC7wo2sNRkj71TeIg1Rg3qmmpT5om/ZfFNlWdBnc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LK5BL0xyajlO0cImqVdOVpv3lMJW3FsuIwB1SCVisMlgWGY5BbsC7xEXowlFQI+//NXGUqbTk3ptKVwktIyk83JlmcTIoHoB1yconEd0RSCthR2DG9Ivv7o/8V8BvayK/LsZJdccecWht9TCHgmEDRa6UBDuZDFP0Bw3GJeZCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xzhTJu1C; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d6d6d82633so9878325ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748360624; x=1748965424; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqeQdOhkH14ppIXNPXbtKnFvRT5SLIn7XArQrv8eW9k=;
        b=xzhTJu1CC4gAikHEXXsTsq35rtX2Al6R6cPYsqKbvPP5u2ZsL6bH5N1fVrJOcBNDhy
         pCrSafgKHzr2aIflpjYNnjYGC/yB0k3pbrA1yqQVKPz/g305ZqOSWghhKNQLxmeIUv60
         A64rhwoRDmCfI2oHAu1JIZkq/mbcqoN3aqrKpPUiDWkBE1yH3Y7mFACvkh8ecZGw9Lua
         H7pAvpK90M8vxEUcovM6YmTqb92bxNWX/9vys6GekR2nxHxvZbty+DSR75vlMYxhWMdw
         9RpC1VpaHEMB5lAM5/MzNg/tneGf9+dApEWPTC4QSwxW4djB66QJB3/2ljJlIoUzcDcW
         qOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748360624; x=1748965424;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uqeQdOhkH14ppIXNPXbtKnFvRT5SLIn7XArQrv8eW9k=;
        b=b7IuJQG9kBCrIBgB3XmaBFLrimO13yNF7ymDjhFcHtYTqy10vCrpJat8Gpk+71L77d
         fnPjn8VIstm0WBtvrKbCnOoI5zYw0CYlzkNR4Nl0Xqf1B1jLwPYGDG4tqNjJGiuQQ8hz
         1N16MpYcfidP8TI2vCB7NviyIrSCAclBmMtX1sJpl7NKKpF1BEODFAMPHBcdTlfeQy19
         RzbPuYlmpm+P13dk+gdle7HwtoGjxRQQK41C3+gEoN6L3XfKKLdFfZtqrf3a8N7toTQ4
         Z048TaPo2lfdnheWRDccaddTFWghuu9JRdF9aWNXUX/zjxrhfJCPJ8GqyOYF4V1tUPUW
         03GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjzX6gisNDC/UCKrBZb0W2lZvE5AibGtsFTw3Rh3XWGEmn7D9aNj1shS29oekR2TIxde6m5jFO8iixtGi1@vger.kernel.org
X-Gm-Message-State: AOJu0YxDePvqDVhmfqvIt2VOBev2zcUTHCOpAjSbCxgA42EOk6DbcMq5
	avACeS8dgBtW4CLQfe8Z3AWg4e4zzhOXs/372E4qQrpk0mrWs7DjUyhwCsRrVUO+ACY=
X-Gm-Gg: ASbGncv/BqC6764F7g9K2yvQDDQWRU+VnsQvQfQh6AwOXET8Yz1UlL2LSt+coLbLTKP
	M1m1eBeCLNSD0Rn3MvlCu+CXl/zgriCEhDRsR+m3mqwK1Ml7kxaCfP6Xu9i9594vmwqJrNefJFp
	INg2I5Zw82c54muzx7tcVDhJN6WPzeUBoqN2UJS6eYpuj7THS88WBzNT7k7eSDG7pwvrZTSri0u
	8mSQsmpT7hczaTglHTnAvNakjEeRVs33pZFvDcl04jm95SeTk8/5UOt6ZIerb9WTMmdl1lxiDG+
	9LzLEXwzP3Lc8qoTiKmKDXtvfdy2MTnbM2QDH1vrIqLlbuQ=
X-Google-Smtp-Source: AGHT+IHe2IrTll2ZTLGHqAOutq0YESdy8gZfreCZKFWEEtFmStrNp/az6Vx+7kBl0sAdcFnJmLsm3A==
X-Received: by 2002:a05:6e02:3183:b0:3dc:787f:2bc4 with SMTP id e9e14a558f8ab-3dc9b70fff5mr159011985ab.18.1748360624054;
        Tue, 27 May 2025 08:43:44 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4af62dsm5208667173.109.2025.05.27.08.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 08:43:43 -0700 (PDT)
Message-ID: <a61432ad-fa05-4547-ab82-8d2f74d84038@kernel.dk>
Date: Tue, 27 May 2025 09:43:42 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] iomap: don't lose folio dropbehind state for overwrites
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

DONTCACHE I/O must have the completion punted to a workqueue, just like
what is done for unwritten extents, as the completion needs task context
to perform the invalidation of the folio(s). However, if writeback is
started off filemap_fdatawrite_range() off generic_sync() and it's an
overwrite, then the DONTCACHE marking gets lost as iomap_add_to_ioend()
don't look at the folio being added and no further state is passed down
to help it know that this is a dropbehind/DONTCACHE write.

Check if the folio being added is marked as dropbehind, and set
IOMAP_IOEND_DONTCACHE if that is the case. Then XFS can factor this into
the decision making of completion context in xfs_submit_ioend().
Additionally include this ioend flag in the NOMERGE flags, to avoid
mixing it with unrelated IO.

This fixes extra page cache being instantiated when the write performed
is an overwrite, rather than newly instantiated blocks.

Fixes: b2cd5ae693a3 ("iomap: make buffered writes work with RWF_DONTCACHE")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Found this one while testing the unrelated issue of invalidation being a
bit broken before 6.15 release. We need this to ensure that overwrites
also prune correctly, just like unwritten extents currently do.

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 233abf598f65..3729391a18f3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1691,6 +1691,8 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
 	if (wpc->iomap.flags & IOMAP_F_SHARED)
 		ioend_flags |= IOMAP_IOEND_SHARED;
+	if (folio_test_dropbehind(folio))
+		ioend_flags |= IOMAP_IOEND_DONTCACHE;
 	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
 		ioend_flags |= IOMAP_IOEND_BOUNDARY;
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 26a04a783489..1b7a006402ea 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -436,6 +436,9 @@ xfs_map_blocks(
 	return 0;
 }
 
+#define IOEND_WQ_FLAGS	(IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED | \
+			 IOMAP_IOEND_DONTCACHE)
+
 static int
 xfs_submit_ioend(
 	struct iomap_writepage_ctx *wpc,
@@ -460,8 +463,7 @@ xfs_submit_ioend(
 	memalloc_nofs_restore(nofs_flag);
 
 	/* send ioends that might require a transaction to the completion wq */
-	if (xfs_ioend_is_append(ioend) ||
-	    (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED)))
+	if (xfs_ioend_is_append(ioend) || ioend->io_flags & IOEND_WQ_FLAGS)
 		ioend->io_bio.bi_end_io = xfs_end_bio;
 
 	if (status)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 68416b135151..522644d62f30 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -377,13 +377,16 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 #define IOMAP_IOEND_BOUNDARY		(1U << 2)
 /* is direct I/O */
 #define IOMAP_IOEND_DIRECT		(1U << 3)
+/* is DONTCACHE I/O */
+#define IOMAP_IOEND_DONTCACHE		(1U << 4)
 
 /*
  * Flags that if set on either ioend prevent the merge of two ioends.
  * (IOMAP_IOEND_BOUNDARY also prevents merges, but only one-way)
  */
 #define IOMAP_IOEND_NOMERGE_FLAGS \
-	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT)
+	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT | \
+	 IOMAP_IOEND_DONTCACHE)
 
 /*
  * Structure for writeback I/O completions.

-- 
Jens Axboe


