Return-Path: <linux-fsdevel+bounces-58052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0591AB286A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 21:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D27188AA76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 19:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257A9275105;
	Fri, 15 Aug 2025 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="IbYieZJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF90217F34
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287385; cv=none; b=o/G5EhFoLaPKnBqu/Dfk8gZ9jpxQ3fYnZuNXkcEAJHOFz630qewTg4yTfAFxOr6XsKQAEXLz9nHD2lhWMh1pN4q6yHDmF0zjaHxx8hfIA4djh27NrBHfSER2jhEgSD3uFx2vqnGKIxV5XobaVZ5r+a/GYJ7tJI96EaGb2iEbwFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287385; c=relaxed/simple;
	bh=bgUPviJRL1FkKnYrRFGyZhxjMwAo790fTPagyfzA5pY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OzVXdgtkhgA1M8kE3oTqfvdEL6bSgrSkTaQH6U2MI5IgAOBs3BJ4SrXCulwCjcUi1zI31pvC5vNnprdL5IkPetsyK3NxfWlvZt6S2VZtTiWnvsoa3CmO5GTPK7F+BMXuYV/ZL9cGsCijP5DFYpQ7nwojaMe+DO5cQICQUr2a/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=IbYieZJZ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e933de385f4so52035276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1755287382; x=1755892182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Es6ivSuXv03lnBunNH7ZmAAeP0d8l2i31xHZvdsyok=;
        b=IbYieZJZYsuQVRlg/O3t122FkTL9xbe5/1c4IvFLbS/UhovzZnfs4edihWJ5XHKcf2
         dDQf3nDeFAqnJOfnqXo/GrbabkavdvjEyaetUh4k/mY7DS+WSch38zo1pxnyS2FaTazn
         etjILtNXcJoQzXddAFfe7qBd15LrCbxE0DKu1la7gB//JbyB3bb0AQRXsVv56h4BP7X7
         MSJts4yV2Ap2YmXFmPB4LeWSQ45zrexYNaJ/v8ffcMX2VaheCxNVxIiAvgksBGun7xY9
         xqWcgypDX/ZuXbWkKOOEx0cB/bRZU3BRE0f2Ick7yqcw1bfADsc8wDeL6PCQOtPWITkL
         b7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755287382; x=1755892182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Es6ivSuXv03lnBunNH7ZmAAeP0d8l2i31xHZvdsyok=;
        b=IWWl7pcUpnCPp6YJbPXXlSNPCbyNUMFIJzvG6msRjRNXxWFSRmGo/SC0DaocwHtwpn
         g9nO+/WB26jSh4Rur4pYFEHVvSns4HuYXgyk1Sk3nTKkPYRCSa3gpv1z6Cc9u86u5ahn
         CzCrkhTI8B0Op3yrRvyJqJ8zMauD8e6QnFEvm+Ekxx/1xylrsSM3+HeZ+nt86TDE0XAO
         Ui1h9Doq9xQdIVARYZZTxRFTesEOnwzO+jbL7Uh67P8g9CBNJUPmo8j4z9IriYJ36qrl
         0gjszo03zAH9Cgzoyj2YjYHDuzCL8520cQlLZt1v7FKLakWTP/AJR92apiWMqXtjrRkK
         ue6w==
X-Forwarded-Encrypted: i=1; AJvYcCURVy1ToVGXA5w0VcOdN71RuLYwzWAYi/p0kT8cVCAcUul/ztdl2246nF1gvO9TdAVYlmkVduDNyEJts4Nn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8cixmiUs1WMQEaTLGKHY+vCsV5YbR645NaURLtHz70afxmNbE
	/S7SYyh3exxfYvcuaz+pA0eMOtejb//ezRuj5XjfJ6JCiO/9xoOjLsCM6HFHQrlsdEA=
X-Gm-Gg: ASbGncsBC/f+w3Bhd/RR1+IcUFE3zljU2BTSdn5h4RMRDnVkHvuUxR93WRuDXoUyTC2
	2lckwX90xVjRtgskebw5CaqP5nng0wEPwWY2IHBYSeC0/5Ebv/bXCtiqD4DlYKPiOn1FzrQYkre
	Xso9I0wFcRmkHL3CtuVDFj2hHG9ovtGUAXb6AZuRAtYp+vIE4RXbKEidYpo1omtrOXE+l3zU0Pj
	Yl62Gwn8NPgZxt+xPAqHXvWWfSdlJfnDZ5WmXKl9xrpCFywEmHMBbrny+WB+ctrxYYOHQQVtaY/
	AMRlIseHWflZT6JV/uUdMlRUL52zvRgp/wcwbj/4IDZy8ckm/b9C7Qw0Qn8x7iMxWyP8Pi0ZLNB
	7mBoWNd0j+XrVsJpVfLyj9rdbxUf9TBM35g==
X-Google-Smtp-Source: AGHT+IFBHWGyTuB79ZFJGNhLniWM0JOCSOmtxfSb3U7HR62LhQ7mYUJq9nmY206FEdtDRSAqEAduXA==
X-Received: by 2002:a05:690c:f88:b0:714:268:a9f8 with SMTP id 00721157ae682-71e6ddd9804mr44320597b3.27.1755287382080;
        Fri, 15 Aug 2025 12:49:42 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9e71:cb28:f221:ff9e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6deb7c03sm5971867b3.27.2025.08.15.12.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 12:49:41 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: clear offset and space out of valid records in b-tree node
Date: Fri, 15 Aug 2025 12:49:19 -0700
Message-Id: <20250815194918.38165-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, hfs_brec_remove() executes moving records
towards the location of deleted record and it updates
offsets of moved records. However, the hfs_brec_remove()
logic ignores the "mess" of b-tree node's free space and
it doesn't touch the offsets out of records number.
Potentially, it could confuse fsck or driver logic or
to be a reason of potential corruption cases.

This patch reworks the logic of hfs_brec_remove()
by means of clearing freed space of b-tree node
after the records moving. And it clear the last
offset that keeping old location of free space
because now the offset before this one is keeping
the actual offset to the free space after the record
deletion.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/brec.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 896396554bcc..b01db1fae147 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -179,6 +179,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	struct hfs_btree *tree;
 	struct hfs_bnode *node, *parent;
 	int end_off, rec_off, data_off, size;
+	int src, dst, len;
 
 	tree = fd->tree;
 	node = fd->bnode;
@@ -208,10 +209,14 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	}
 	hfs_bnode_write_u16(node, offsetof(struct hfs_bnode_desc, num_recs), node->num_recs);
 
-	if (rec_off == end_off)
-		goto skip;
 	size = fd->keylength + fd->entrylength;
 
+	if (rec_off == end_off) {
+		src = fd->keyoffset;
+		hfs_bnode_clear(node, src, size);
+		goto skip;
+	}
+
 	do {
 		data_off = hfs_bnode_read_u16(node, rec_off);
 		hfs_bnode_write_u16(node, rec_off + 2, data_off - size);
@@ -219,9 +224,23 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	} while (rec_off >= end_off);
 
 	/* fill hole */
-	hfs_bnode_move(node, fd->keyoffset, fd->keyoffset + size,
-		       data_off - fd->keyoffset - size);
+	dst = fd->keyoffset;
+	src = fd->keyoffset + size;
+	len = data_off - src;
+
+	hfs_bnode_move(node, dst, src, len);
+
+	src = dst + len;
+	len = data_off - src;
+
+	hfs_bnode_clear(node, src, len);
+
 skip:
+	/*
+	 * Remove the obsolete offset to free space.
+	 */
+	hfs_bnode_write_u16(node, end_off, 0);
+
 	hfs_bnode_dump(node);
 	if (!fd->record)
 		hfs_brec_update_parent(fd);
-- 
2.43.0


