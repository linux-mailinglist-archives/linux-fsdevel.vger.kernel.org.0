Return-Path: <linux-fsdevel+bounces-37390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B619D9F1912
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F885188ECB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE51F0E3B;
	Fri, 13 Dec 2024 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFP6VYEK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133D1F03D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128603; cv=none; b=T6E4mwzhIw+8ah1a/ceUrGMFlliLEFpPhtmVgb9KnenN2K/YFvjvDIgdJbDWV/0DnAuvYI8txdjtquwlyPgavbAw1La8unqcem/c/5XzaHeyk84k4ObfnFchH4XuuKyLzGS9PqQw9Lhje2pvGFEGZU8z5R3nRFI9wz9exXlAzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128603; c=relaxed/simple;
	bh=4RHUZlPXsmuNDwULpNnYMJp1ZfhKI4sVd5OiHTgbyh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nS+7zRmhOgVTxm6YazqNfjReCoALQsZT+QVmuRGIHAbUkRvUP8q6i9LJ9rGuI6BiXuIpEnL+IdeETrM6H/qGdL9L0ZjUxwkaekTc8nCPHJFBcwiha0hEbFJOVjfgJPVSAnSNPZjlIt2NCuBeC/E6gbd0+G/laHXFsjrIhQjP4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFP6VYEK; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ef7640e484so25247927b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128601; x=1734733401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63LnTO7AfAjpGcQ2L5G8qf3TiWglZpVrBL35IcqMmV0=;
        b=KFP6VYEKDKtniLreac0ZuVY8cOKxaUf0zpKdIMfRrEq7U5JhmWQMsfgwMDlgBTNYy0
         P7Jlztnvz7QE9maaxBpllpGmaDHQD7z+tKupEWRtq+AEVlzbtrI/yKxOdlsax46xzh9Q
         4nQtp+tTJVlDHSUYzDqmVG4giW1PSMD0FFy0n/Gk1cwHAZWfPM0PL79wN7iA63apuvPF
         ijZSubB2M+0DEfKznJuKG7HHgFcCsoNZjC++jvVYjJ8cY0vgjrhyrKU/7KjG0LTcvY0W
         9vDSt5FUVeqqDRWeAsK2FHPX58DBVOvgyYY3sDVB8onLQzdNaG8T1eCQAdnk7ahlpyc9
         k0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128601; x=1734733401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63LnTO7AfAjpGcQ2L5G8qf3TiWglZpVrBL35IcqMmV0=;
        b=WI2VhIF7ig5XL4Wsk85bNyqz3BhxFXqjrr2F+HmC7OYNHYiD37FpIzyn41Zs+n6jdK
         jToBwaL+DXAcB6T6LIwBgvjMvsrjJC5b2usSS/fTI3yWbKmeFOwkfupaiGC8KLvbDSDZ
         P1gdmCYQVR+KHe8Rl1UCzu8Gs7XRU1WOAJBQtIXbasOEOKCP7UxXT5r2A/jGQeodJPrs
         zAEEzWAmMZuufAiZfxCJPZPJNpk+o11pP3lmnQyUTIv0ikzkD11FIqvI1cdHDOA3TDNF
         cNMzG359OMkIbjDWpLSGXM2Rb2jWNQU/cYIW+2iZnvE7+oYlQUTPzovab5r8vcXLuJRp
         otKg==
X-Forwarded-Encrypted: i=1; AJvYcCWQcvkjXAy2ebj+sidQSzBGTX9Y6so2vf9Dyd3VC9duzx8pdhe2MdsJwybcBqeHA2Mx+D+vFoWg31XFwY1D@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18WEoVEgTepS9gjOBDXDGBsqzdyleFDDL52gQ9copDDM2Yxo2
	27sAXPPDcA6Cn41z1jRMXjY12A7DBFxTG01yfCAYlQ2Tr9RI1rgazpqHsQ==
X-Gm-Gg: ASbGnctYhKo6UZB8n9xtanAGf685qVC04ldsbMv747ZVhthkgfS3fFg/D36HcN2eW0K
	pW7RG6Ej7M/1Sd30nByhyj4gkRqUd6icuAl+JIbsiY3ZB7zL18D2lj/U9WOhwlbIGsOHmwhUr6m
	FNfJpZc7/LUCT/crKNRkCorZb7pJsCCrSAsNuCpH8rfh1BfZj2clXYFESawpRWnLs4iz2Zn8WFy
	B5/FXQxzIaHZMOGOPeCBQtLoRpfBMGE/AMQ8NEIgsD/CFRKdMYNt8+l1jZKWyw3ofOMJzQaxhMp
	VHBO0ima00bnVag=
X-Google-Smtp-Source: AGHT+IH3vQ+ZIGEicps04/POExuN3AIVahHBkPAfv9OHg5LP50Hw3n2exUOVu4IiFzTdTZoNy6INEQ==
X-Received: by 2002:a05:690c:48c1:b0:6ef:993a:29b4 with SMTP id 00721157ae682-6f2798e22femr42678857b3.0.1734128600865;
        Fri, 13 Dec 2024 14:23:20 -0800 (PST)
Received: from localhost (fwdproxy-nha-005.fbsv.net. [2a03:2880:25ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f2890c86b2sm1202017b3.87.2024.12.13.14.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:20 -0800 (PST)
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
Subject: [PATCH v3 11/12] fuse: support large folios for writeback
Date: Fri, 13 Dec 2024 14:18:17 -0800
Message-ID: <20241213221818.322371-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221818.322371-1-joannelkoong@gmail.com>
References: <20241213221818.322371-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for writeback.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bbc862c1b3fa..6a7141e73606 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2014,7 +2014,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 	folio_get(folio);
 	ap->folios[folio_index] = folio;
 	ap->descs[folio_index].offset = 0;
-	ap->descs[folio_index].length = PAGE_SIZE;
+	ap->descs[folio_index].length = folio_size(folio);
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 	node_stat_add_folio(folio, NR_WRITEBACK);
@@ -2089,6 +2089,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	struct inode *inode;
 	unsigned int max_folios;
+	unsigned int nr_pages;
 };
 
 static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
@@ -2136,15 +2137,15 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 	WARN_ON(!ap->num_folios);
 
 	/* Reached max pages */
-	if (ap->num_folios == fc->max_pages)
+	if (data->nr_pages + folio_nr_pages(folio) > fc->max_pages)
 		return true;
 
 	/* Reached max write bytes */
-	if ((ap->num_folios + 1) * PAGE_SIZE > fc->max_write)
+	if ((data->nr_pages * PAGE_SIZE) + folio_size(folio) > fc->max_write)
 		return true;
 
 	/* Discontinuity */
-	if (ap->folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
+	if (folio_next_index(ap->folios[ap->num_folios - 1]) != folio_index(folio))
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2175,6 +2176,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
+		data->nr_pages = 0;
 	}
 
 	if (data->wpa == NULL) {
@@ -2189,6 +2191,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	folio_start_writeback(folio);
 
 	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios);
+	data->nr_pages += folio_nr_pages(folio);
 
 	err = 0;
 	ap->num_folios++;
@@ -2219,6 +2222,7 @@ static int fuse_writepages(struct address_space *mapping,
 	data.inode = inode;
 	data.wpa = NULL;
 	data.ff = NULL;
+	data.nr_pages = 0;
 
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
-- 
2.43.5


