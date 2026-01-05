Return-Path: <linux-fsdevel+bounces-72410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C345FCF5A7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 22:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC6730FD9EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 21:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477572DEA74;
	Mon,  5 Jan 2026 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8JtyCTI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101902DECDF
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647943; cv=none; b=bWIPDh6NS/vfuS5FfXc05gu6HYRQMYQLKOmCdx6vFQwOBbqEc4fI8YageGXWLDgATCKgrD4H/CZ55XHws2G2/E/9MzvIUWYldXFFpFejxt4Woz+A9DuszTeYu35u39g85B2tCFRSoTRQNYeP2N7lOB/TAkpar+xJLxu4FfjV7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647943; c=relaxed/simple;
	bh=7OhCL/hJxXrY3+WYN78M1I0TgI0OqSU05lY8vX8SPRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBdueKPtH9bPrPjOSFrFYH2x4YKUeFbURgD2bzqa5Op686UWGF3tJllMynXnQM8Wx0cSWqHSyTZhSt5haW4AvuG//A8sXzW7rXyddaMug1/JJ9iW68pZKWOsyYJ0gWkrolLwAO4Lf3UAXrOY7yd0MUdQlVHiOlaN8cFOVMAju0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8JtyCTI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0833b5aeeso4525815ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 13:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767647940; x=1768252740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5LAxK+AjnG3YzNOBaLOPsRos3hCuelykUfVzgLenNc=;
        b=J8JtyCTINDIWTwhSKmmKNZ4eK/1f97ThwCfUon3NKnRSyZHRXOioNo/kpKZmyStQ8O
         jkLf/ZYS9OMCAXrkoKsA1Qb/z3vfTGl0iouaPmdKm5aOlT6Uo5PMbLbbcbNFaQ17MNq2
         v9KPSFyCTDU21ueOLXl9+sonUn/Mb7exTc4ar70A8OnoWdbAS+cCeRyqSQ9yxZHlMFWs
         ot3LoH6C4V4YPpCqSOrU30EU+P8+18UNKzOG3F1pnaAKA6+lDRqfc/XT5Zou7UDW75zr
         jX9ObMrZRjVcgXGPSqwTrqCBgo91G9JUquq7784mOhosi1KonjmlzYQh1Z/p3X3h7atg
         KDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767647940; x=1768252740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x5LAxK+AjnG3YzNOBaLOPsRos3hCuelykUfVzgLenNc=;
        b=F8YviuPUH+qNFYCNcs57UAUIoD0fsu/4mpTn5T5YejPxLdAZZ++K69fmyRenNjX82H
         m9NLR4JxDs1iPHT+nko7g1pRtJwyBaBRYuL+t/WVH1WYTBPx7TAw9Xi/DdOD03o0LOis
         M1sckM63R8qOOKQWmFxI3n4++CrKWwoej6KmY/hEsoAQqk+SnWxmv4pqYVG5pQcWDWhN
         sTLG4YpEC9HQSJvl8vn27kXd2cDiHNoV/EXbf1wtpFB6l32tSdWJ1jO/jZzT3Fxd//yN
         XTSPYvDnimmhLztUtNTepLwpXacGJx7ISuZnjqJOkvfsypuLPo2eIyjcsmMjxevcaOTW
         e1mw==
X-Forwarded-Encrypted: i=1; AJvYcCUUGo4rpcC1NCjsJ1RKdEscmz5yoO3gCdBLTi3zSSKk00hqY/EN2hDoOODRf7Qq4/WG82LtHZBVYl6obDBP@vger.kernel.org
X-Gm-Message-State: AOJu0YzXueWNnLcmnjNu4M1uKEcncJ8BgzSatjLa/GkWOxBf0xE7FFT6
	JxM86rsEvVnoET+hgtxifk17l366BKHwAYKOr9knzQk6WHG0PA93otcDDlCUwA==
X-Gm-Gg: AY/fxX73NWjEPA8BOSQgEN1SIpTb+HdUH4aAgFoU81EuL0lnAtGCFAfUsYeZrqS2NBc
	irWXBxwZQiJYK4TM1XXFF7xwLhXoryWiYniEsxpiuIy1NiKilyEY+cnONJXWoO/RJl5vHHMZ7Pz
	zRMVPQgw2db6uXFCoZrn9KNQRux/I8q6bnUNzUDZiYyAvy1rM3VX7auXBGHJ/4SR5evwlpYq9ab
	v+c5es8qDpUAysUWxHFWUXojZ2+UlK67TRalFXlj5em2uZuzrNiRdz4DLeqo4xwVxbrRYl/LZZV
	JLh0jRBITun/xI4JlkgTwSBfzKTcxEa1MshlXLViYafh0phTJGplhwxBugMSWA4Lz6pANSvYjBA
	FR29P8QTU7AETs0xHAJJdwJ+22VWR1jNC3ItS60NMTlWyjcKXWjkeOUFR5c7LHFyVQfjtRfKRGX
	PeoycL2ureNDpq7Ed0
X-Google-Smtp-Source: AGHT+IHHnbvfuO02O2T8eWP+vcVOcuSJ7Y6r/Zmdy3IOsvMBodteHhpEqVwKxEJiZnOh/YXs6iICfw==
X-Received: by 2002:a17:903:2f92:b0:2a0:d629:9035 with SMTP id d9443c01a7336-2a3e2d758c7mr8216695ad.3.1767647940296;
        Mon, 05 Jan 2026 13:19:00 -0800 (PST)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc8dd2sm1526925ad.82.2026.01.05.13.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:18:59 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	miklos@szeredi.hu,
	linux-mm@kvack.org,
	athul.krishna.kr@protonmail.com,
	j.neuschaefer@gmx.net,
	carnil@debian.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v3 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()
Date: Mon,  5 Jan 2026 13:17:27 -0800
Message-ID: <20260105211737.4105620-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260105211737.4105620-1-joannelkoong@gmail.com>
References: <20260105211737.4105620-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Above the while() loop in wait_sb_inodes(), we document that we must
wait for all pages under writeback for data integrity. Consequently, if
a mapping, like fuse, traditionally does not have data integrity
semantics, there is no need to wait at all; we can simply skip these
inodes.

This restores fuse back to prior behavior where syncs are no-ops. This
fixes a user regression where if a system is running a faulty fuse
server that does not reply to issued write requests, this causes
wait_sb_inodes() to wait forever.

Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
Reported-by: J. Neuschäfer <j.neuschaefer@gmx.net>
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
Tested-by: J. Neuschäfer <j.neuschaefer@gmx.net>
---
 fs/fs-writeback.c       |  7 ++++++-
 fs/fuse/file.c          |  4 +++-
 include/linux/pagemap.h | 11 +++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6800886c4d10..baa2f2141146 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2750,8 +2750,13 @@ static void wait_sb_inodes(struct super_block *sb)
 		 * The mapping can appear untagged while still on-list since we
 		 * do not have the mapping lock. Skip it here, wb completion
 		 * will remove it.
+		 *
+		 * If the mapping does not have data integrity semantics,
+		 * there's no need to wait for the writeout to complete, as the
+		 * mapping cannot guarantee that data is persistently stored.
 		 */
-		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
+		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
+		    mapping_no_data_integrity(mapping))
 			continue;
 
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..3b2a171e652f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3200,8 +3200,10 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
-	if (fc->writeback_cache)
+	if (fc->writeback_cache) {
 		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
+		mapping_set_no_data_integrity(&inode->i_data);
+	}
 
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9..ec442af3f886 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,6 +210,7 @@ enum mapping_flags {
 	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
 	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
 				   account usage to user cgroups */
+	AS_NO_DATA_INTEGRITY = 11, /* no data integrity guarantees */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -345,6 +346,16 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
 	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
+static inline void mapping_set_no_data_integrity(struct address_space *mapping)
+{
+	set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
+}
+
+static inline bool mapping_no_data_integrity(const struct address_space *mapping)
+{
+	return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
 {
 	return mapping->gfp_mask;
-- 
2.47.3


