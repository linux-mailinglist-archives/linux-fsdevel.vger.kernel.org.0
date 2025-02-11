Return-Path: <linux-fsdevel+bounces-41550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC0EA3182F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 22:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C037188209A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 21:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79122676DB;
	Tue, 11 Feb 2025 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvYlWauU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E04267706;
	Tue, 11 Feb 2025 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310494; cv=none; b=NoZ9Rj+oVsdm8sQpWHU5VSeR7hJ0JJmxE2yVxPkMsOuCZBWE9R37iTnUTBo5T5FlKHqNRGGTYdqvYBWGvUfjL5N723FJEcthKKbGvbTZxLqolkVa4JtYcfJBGKsxRjzAwp+nZl1rS9EyYiqsZ6tU7ApzzOJapROgYnBL/kzPfq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310494; c=relaxed/simple;
	bh=smFxIaIAXeeqpVCzuwHHa9+Ysar++uL50ST4BXoCjgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rmold/1ErxSe2nXQTYot0U9CDXCce1QOXZUC57YXrvWUDaQFvHX4snzbnwZaP/HS2jDzpSNg6bGwanZ8UjtHqgmAt6T5A1dDeVuqZv9Fxgbni/eHQzazf6IxjOk7UiyVxsMW2DDm7R/RN24F0YCQZar3++HvWdmw5EnvkYxrQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvYlWauU; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f9c6d147edso33531337b3.3;
        Tue, 11 Feb 2025 13:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739310491; x=1739915291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVq1XCnOjA2ULEK5C3J/qIxsMb/DbCnqqJ27wKR3a2M=;
        b=JvYlWauUdKH09yMPS4702jawNQ2iNp7tbKnvFJKWk8Rct/aPZq04Oo5aBQYqeKcP4S
         Wose/YlkaqyDUHVtuTSepQ5r6GfdQbs78oTTd46ueacwhoPio2kj0UtMKJswYpHzDWqu
         NUuu83YVBxZuHZ7GYMuej+Jwtgi4Xb9S2/dpSAu034nAphhpFv+nkKwlNEHPHxnEYQd7
         k6+KAGFo0lNkV+AIfEDsCOPOidYrNJRBzYBZfXLigNFBO1tPB7M3uM3vGVF3fjKajICJ
         AEZoztTU2XsntM/mZdQz9/jblUDNPYEyJnAD8vsGea6sBdhI59XmHkMjVDLgCQxEnGf3
         w/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739310491; x=1739915291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVq1XCnOjA2ULEK5C3J/qIxsMb/DbCnqqJ27wKR3a2M=;
        b=YVtfp3/g1AXT5t0FoBXpkNEtKROFYhm0bNe2j1zoXPVSKE2HUTSAQ2QRHguLyb3VHF
         OfGB82/KfcZXz9B1M+hBTiy+SACGx2sFa4hQRIf0IHHWRZEbTf1I7y/wxkJUgY9xzC3s
         kfGIYYDcy3S2iWtKu+51gltFEo0zpp1cHiMTuR4/H8u5zG1oBi28D6SGrSFv1seLyQtq
         anWWIDsiXNgW92D3YBi6EvcrVxmB9f3hR/zT0k7ZCR4pOaHdkF46R65jinU+h464pAto
         So5hnUDmZdsWDCyMWHSNVNIAH046ZtTEz65q7b8CnJUHD0kr+mm3uOBZ2QCPF4Zt4ku9
         CXyA==
X-Forwarded-Encrypted: i=1; AJvYcCXHdxCg9CyeDBwaaHBKPlwJ+rjXMSWDOf9xyzWjSHXvXfIYn26CP96mlYEVyRYOHi+1Im26Ypg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMAkatt2C70Xx0VukoumkqeByv+FXy3+Y9MXVFjkOaSbsRiQJG
	jwOw5AhitSWZSOeIO8M/7bjTbsLZ5sm2BzezZKSUsE31tALKWOOZ
X-Gm-Gg: ASbGncuYwVuEYbbCL0kGR0jGqWnzSTjB1Z3pzBNST83321iaiAj0gSZ7sVyxKQ2U/SP
	eJNMnPSwJbPkyoB6Ss1qB6fAUg4eiooF+/jjvV+X+sq+i6BEYi7B8nSM1wY5PjUZkcW8PzFR9gR
	tqG+j9lxBOYsE8k0zK/FIoUdaiqNHG29tGHqRYjldqBvKlrgOXI6KrROLwdWdnK54i3Ge92A0mO
	a2/uRfH2iwlh1sEdcaZjZASsdDhKczTr2/mQHx5PxtKNkWSnmxEqttftazMJlCguj03NKzIno9R
	3Tj1lE2hLVXe
X-Google-Smtp-Source: AGHT+IEo7IxtRR6PzGm/SfI5sQJxiyKa44TtElTnQMf54sThW551Y7HVQNixqBFpbcUds98lboCRkA==
X-Received: by 2002:a05:690c:3687:b0:6f9:aecf:ab34 with SMTP id 00721157ae682-6fb1f2d5ad0mr12862547b3.38.1739310491552;
        Tue, 11 Feb 2025 13:48:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99ff6a605sm23287767b3.80.2025.02.11.13.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 13:48:11 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	vbabka@suse.cz,
	bernd.schubert@fastmail.fm,
	christian@heusel.eu,
	grawity@gmail.com,
	willy@infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] fuse: revert back to __readahead_folio() for readahead
Date: Tue, 11 Feb 2025 13:47:50 -0800
Message-ID: <20250211214750.1527026-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In 3eab9d7bc2f4 ("fuse: convert readahead to use folios"), the logic
was converted to using the new folio readahead code, which drops the
reference on the folio once it is locked, using an inferred reference
on the folio. Previously we held a reference on the folio for the
entire duration of the readpages call.

This is fine, however for the case for splice pipe responses where we
will remove the old folio and splice in the new folio (see
fuse_try_move_page()), we assume that there is a reference held on the
folio for ap->folios, which is no longer the case.

To fix this, revert back to __readahead_folio() which allows us to hold
the reference on the folio for the duration of readpages until either we
drop the reference ourselves in fuse_readpages_end() or the reference is
dropped after it's replaced in the page cache in the splice case.
This will fix the UAF bug that was reported.

Link: https://lore.kernel.org/linux-fsdevel/2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu/
Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
Reported-by: Christian Heusel <christian@heusel.eu>
Closes: https://lore.kernel.org/all/2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu/
Closes: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/110
Reported-by: Mantas Mikulėnas <grawity@gmail.com>
Closes: https://lore.kernel.org/all/34feb867-09e2-46e4-aa31-d9660a806d1a@gmail.com/
Closes: https://bugzilla.opensuse.org/show_bug.cgi?id=1236660
Cc: <stable@vger.kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/dev.c  |  6 ++++++
 fs/fuse/file.c | 13 +++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3c03aac480a4..de9e25e7dd2d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -933,6 +933,12 @@ static int fuse_check_folio(struct folio *folio)
 	return 0;
 }
 
+/*
+ * Attempt to steal a page from the splice() pipe and move it into the
+ * pagecache. If successful, the pointer in @pagep will be updated. The
+ * folio that was originally in @pagep will lose a reference and the new
+ * folio returned in @pagep will carry a reference.
+ */
 static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 {
 	int err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7d92a5479998..d63e56fd3dd2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		fuse_invalidate_atime(inode);
 	}
 
-	for (i = 0; i < ap->num_folios; i++)
+	for (i = 0; i < ap->num_folios; i++) {
 		folio_end_read(ap->folios[i], !err);
+		folio_put(ap->folios[i]);
+	}
 	if (ia->ff)
 		fuse_file_put(ia->ff, false);
 
@@ -1048,7 +1050,14 @@ static void fuse_readahead(struct readahead_control *rac)
 		ap = &ia->ap;
 
 		while (ap->num_folios < cur_pages) {
-			folio = readahead_folio(rac);
+			/*
+			 * This returns a folio with a ref held on it.
+			 * The ref needs to be held until the request is
+			 * completed, since the splice case (see
+			 * fuse_try_move_page()) drops the ref after it's
+			 * replaced in the page cache.
+			 */
+			folio = __readahead_folio(rac);
 			ap->folios[ap->num_folios] = folio;
 			ap->descs[ap->num_folios].length = folio_size(folio);
 			ap->num_folios++;
-- 
2.43.5


