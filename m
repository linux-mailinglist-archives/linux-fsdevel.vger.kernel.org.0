Return-Path: <linux-fsdevel+bounces-26939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C94895D358
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4E61C22F96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB82D18EFF4;
	Fri, 23 Aug 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNn2Hq9B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133418E35F
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430470; cv=none; b=JIpqjniuK9C24Abcu+8ER6JwENtZRET5Cf7VRxvRUyRfOiYwajWsWqBjNpVTrHt9YUeHk29c7e1BZXKJINl0HyYOuOBYJA4hDPFr3xJxwvkDXMl3xfi3WONJh83PvFZMNQlem2zEMt8hN9cxdLqPZvAw6B0GZhYxEonFnzllkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430470; c=relaxed/simple;
	bh=82eYQz6sfyzy/Ia5s7CuFQJu0fKMz2l5LMKTvCenvhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaBkd8je3WIil50YUu3qbmw/vZwBdUG6vTSl/IqMi+7qjGhCmV1AJiyA7RiA7QPM74XDwq4DgCjFPuVZ8/DVMazBeAV9JRsriUu0hgZS+qOvKYSB99B1xIztGwQAU3SCBf2frQTqweQ8riruJAQIQ46Qc2fiun/agyWmxj5YvTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNn2Hq9B; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b99988b6ceso23441467b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724430468; x=1725035268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPPFzN7yYaPQyq6TUhQbGJPQE9oLj4GQdoaKu6JHvz8=;
        b=UNn2Hq9BcQ6meO8+uSanvaUbN8fhMSgTjV1hWo0wDM8yBuEZUnmwSoDwSQlYb5RQsq
         D9AmPpWfuLz8WMcP0mD8f0eH0LfOeqZT/xblJFL37OnhmM0IFR5dPE0/esu77u9qolKD
         48tNtqlqOIQSYngD6x9LyweTlB1WdpFK9hq869JKYSSC6HM8ZtcOp60R+tAQBaBpP7cR
         F8qTf+yCS+5Ez0fVt0YNVwOuLM2VNwWEucMx0lpaohS95+5+TYro9soTeuhTaOjELVKJ
         ejvtzlAcVTRowclllS7LZmAlSDhuR8hQ94+4GWHm5bopQfwRgGPwT3VW0YL5+n9zhIQj
         +KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430468; x=1725035268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPPFzN7yYaPQyq6TUhQbGJPQE9oLj4GQdoaKu6JHvz8=;
        b=HlnnX1yLark48UBbRtAez1tD/DBgRihWidiNBYSQ3AHSEA3ZHqAwOGrB/yUPR0+gLg
         Gup5AURaOdwlezbinJL5spYjQyRlS5q02+88aV6m1N8fYvtjuv9LU3XeuxB4jAeIvgPV
         y3lv1oOGvT24GelbCSOyglYEydK5pwFJM9+sqpjCrZ/pkO1ah1LbEpea10EB0YKmWivC
         O3AnuRPO19XLAAshCH1flC9KPTZoGqqySsH5HeJSnHZ+SI6meK7+N0oP+ONA4ytoWYs+
         PjhN1UT82AxNRR7QCSqLVRyRFmBQNW//VhIlFJDiicPs9l6TwoCp2Sb0YJe3pnD1M5Gp
         0feA==
X-Forwarded-Encrypted: i=1; AJvYcCXS1DwZzGscNcwDmSyYzJtjS1I5i0CBUN8kiJADU5C18IN2f+evFMf5e76cncp4w2Y/pBqFPt7lL8Ip9YZ2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03AzLXlf90i/UOFsOSopdZTohKHfcUVP8oi7SDCOkOHndH9GO
	Pt8jj79I/mynFy9FRno5YU8Gsbcb209BGbJc5NNIZx66QMvkM8VU
X-Google-Smtp-Source: AGHT+IETIeMkCLjHGvZrv2SPjsTSeQvY2a9vf5E7YJ6a5bqCKnarAi6jF1vPhPJklznZ72s5wKrF3A==
X-Received: by 2002:a05:690c:3806:b0:6a9:4fdd:94e5 with SMTP id 00721157ae682-6c62557b877mr35733757b3.13.1724430467720;
        Fri, 23 Aug 2024 09:27:47 -0700 (PDT)
Received: from localhost (fwdproxy-nha-003.fbsv.net. [2a03:2880:25ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c399cb4f82sm5997117b3.1.2024.08.23.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:27:47 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v3 8/9] fuse: move fuse file initialization to wpa allocation time
Date: Fri, 23 Aug 2024 09:27:29 -0700
Message-ID: <20240823162730.521499-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823162730.521499-1-joannelkoong@gmail.com>
References: <20240823162730.521499-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this change, wpa->ia.ff is initialized with an acquired reference
on the fuse file right before it submits the writeback request. If there
are auxiliary writebacks, then the initialization and reference
acquisition needs to also be set before we submit the auxiliary writeback
request.

To make the logic simpler and to pave the way for a subsequent
refactoring of fuse_writepages_fill() and fuse_writepage_locked(), this
change initializes and acquires wpa->ia.ff when the wpa is allocated.

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3d84cbb1a2d9..2348baf2521c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1762,8 +1762,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	for (i = 0; i < ap->num_pages; i++)
 		__free_page(ap->pages[i]);
 
-	if (wpa->ia.ff)
-		fuse_file_put(wpa->ia.ff, false);
+	fuse_file_put(wpa->ia.ff, false);
 
 	kfree(ap->pages);
 	kfree(wpa);
@@ -1936,7 +1935,6 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 
 		wpa->next = next->next;
 		next->next = NULL;
-		next->ia.ff = fuse_file_get(wpa->ia.ff);
 		tree_insert(&fi->writepages, next);
 
 		/*
@@ -2155,7 +2153,6 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 	int num_pages = wpa->ia.ap.num_pages;
 	int i;
 
-	wpa->ia.ff = fuse_file_get(data->ff);
 	spin_lock(&fi->lock);
 	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
 	fuse_flush_writepages(inode);
@@ -2300,6 +2297,7 @@ static int fuse_writepages_fill(struct folio *folio,
 		ap = &wpa->ia.ap;
 		fuse_write_args_fill(&wpa->ia, data->ff, folio_pos(folio), 0);
 		wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
+		wpa->ia.ff = fuse_file_get(data->ff);
 		wpa->next = NULL;
 		ap->args.in_pages = true;
 		ap->args.end = fuse_writepage_end;
-- 
2.43.5


