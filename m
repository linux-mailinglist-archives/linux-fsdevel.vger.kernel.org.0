Return-Path: <linux-fsdevel+bounces-26933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA9C95D351
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBF628241E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95A18BC14;
	Fri, 23 Aug 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY9oRqvv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0B18BB82
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430462; cv=none; b=q5ys9+jfL35znZQZXLyp0yZI2VlCD5L8E1/c53omZincr33UyjSxFy90Ug2F5gqCjpiNFH/lmVE3mKCZRdxoylm4ZBzhEjmFXWNQYtfCGKhmpir/vIKD2m99dJE31D6ir1ZCwIxaRr1tFFI7Qvs80t/0/ay7ZhtXu1OIm9q6RAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430462; c=relaxed/simple;
	bh=UWKsRqn8KEexlFybvj1D8QiH7e2TeVsMe7AUmeAODaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPsDF8lM0/4uCR30LlUGc3RPfyki5g08sIWrhPW5IwqjU0Sjf1mMpQ8oS5ONOlbGXa5IOm/WVcphlMsaF03xiWWExLxACvTEqMBIOcOYfOLzTlxOsWGRc8BwtzhKP9iYPWbTBdlrokrKxhM14mmvYzofii0zEr/RR3tZqYNLhV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY9oRqvv; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1654a42cb8so2217328276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724430460; x=1725035260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOZ2xVfOWbanp17fZvu+t8asvkce+rrQYJ7+TXN5jw8=;
        b=HY9oRqvvpAJJfQZNISYOf5En9C0sqZ4H0X7mUV10r3JolDqj14rIp/gOEr7UQ3Ydm7
         crYnD4ifbxT17IVQnUgBxGsmEkIo+OLGjmjA/Ddm7pKjsjvN1rNqyZRke0M8HnfRRnTq
         432I6Q5v2DXENuWSGm9EVnfjqDPeax/wErWgN42r+kygrZ6NcvrBH/Vtd3HbiJvLNY+T
         /cNCfbRafjwr3sH1P7Vl1YU8M233ENhbmOjwGiLPNwMqDbJPm5UBkDqBsYYQmKPKkzyN
         rgPH62odbTEDs+z0Vmu8pbAnzgF7A7+AS4Vt3VIEcc53TtvC91XOgGUhHncpCPYaLt8l
         Tcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430460; x=1725035260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOZ2xVfOWbanp17fZvu+t8asvkce+rrQYJ7+TXN5jw8=;
        b=iZ15q2/XPv7dITCl5z08cM2nhkDlwZgP7vm8WJaWqztBCxaCkviE22BEqaYeC9AG6q
         VAZzSA7GDUtVw228rwJ77LQTcxuzF1MapHWBEeMIB5rglfkO7NyuoS7BLyddcjPt9zg2
         ojnyplm1oW6rYZ1N3I77GfB86KWxAfrMp/Zrz9VmQjR56onpUIJY8mPE2InFBSTNiOSV
         oXi8OaaVHdmcFoxBzXJklWk91EpPLQxnucpvWBBA8f6i7mGPAxuu0bHo1hnlYrbkKRcT
         xoYtXE4TP83lra04hoOfQ3EJMM2mV5mrXi78yVh3hkI/b7wfw2YYqW/3oZ38JTrlimjA
         eXug==
X-Forwarded-Encrypted: i=1; AJvYcCUNfBC++jBErtyNoULoAET6KV9o99+LU2zmVzmw9ca6f1Tou7zbNPvL/huXDu0Q3BW4K2LyEjK11VLH//Rv@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5TFaYiKFQKC7ulXnl2zuPNz4/b8Y0/idf8ro06P50jqtjQ9E
	bfKmIloxo/JOl8XN6glfnWK/SuUAWrIS7xqQpPw02EQJTJuc0pVJ
X-Google-Smtp-Source: AGHT+IEm6IPFK5nrK9K8lv7FcaPr2S8CvJgUJE2eCjMIuexI0mgkn5UtELmj5hw8qT45So7/SOdTMg==
X-Received: by 2002:a05:6902:1586:b0:e14:85d5:8580 with SMTP id 3f1490d57ef6-e17a864581cmr3422920276.44.1724430460321;
        Fri, 23 Aug 2024 09:27:40 -0700 (PDT)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39dc5327dsm5941247b3.127.2024.08.23.09.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:27:40 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v3 2/9] fuse: refactor finished writeback stats updates into helper function
Date: Fri, 23 Aug 2024 09:27:23 -0700
Message-ID: <20240823162730.521499-3-joannelkoong@gmail.com>
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

Move the logic for updating the bdi and page stats for a finished
writeback into a separate helper function, where it can be called from
both fuse_writepage_finish() and fuse_writepage_add() (in the case
where there is already an auxiliary write request for the page).

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/file.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 63fd5fc6872e..320fa26b23e8 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1769,19 +1769,25 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	kfree(wpa);
 }
 
+static void fuse_writepage_finish_stat(struct inode *inode, struct page *page)
+{
+	struct backing_dev_info *bdi = inode_to_bdi(inode);
+
+	dec_wb_stat(&bdi->wb, WB_WRITEBACK);
+	dec_node_page_state(page, NR_WRITEBACK_TEMP);
+	wb_writeout_inc(&bdi->wb);
+}
+
 static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 {
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = wpa->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	int i;
 
-	for (i = 0; i < ap->num_pages; i++) {
-		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		dec_node_page_state(ap->pages[i], NR_WRITEBACK_TEMP);
-		wb_writeout_inc(&bdi->wb);
-	}
+	for (i = 0; i < ap->num_pages; i++)
+		fuse_writepage_finish_stat(inode, ap->pages[i]);
+
 	wake_up(&fi->page_waitq);
 }
 
@@ -2203,11 +2209,7 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 	spin_unlock(&fi->lock);
 
 	if (tmp) {
-		struct backing_dev_info *bdi = inode_to_bdi(new_wpa->inode);
-
-		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		dec_node_page_state(new_ap->pages[0], NR_WRITEBACK_TEMP);
-		wb_writeout_inc(&bdi->wb);
+		fuse_writepage_finish_stat(new_wpa->inode, new_ap->pages[0]);
 		fuse_writepage_free(new_wpa);
 	}
 
-- 
2.43.5


