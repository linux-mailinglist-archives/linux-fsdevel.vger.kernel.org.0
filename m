Return-Path: <linux-fsdevel+bounces-64452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B84ADBE80C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717065E09DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5FA30F80F;
	Fri, 17 Oct 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="HxtCmOtk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30460217648;
	Fri, 17 Oct 2025 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696702; cv=none; b=HGljx04T+DDUotvtVA+PL7Rh+1ZNPevfGKt4M2Xqp6jryyYN4J1B+f0ShwlLzQzbxq0py4c2py7V+G/wdVLbBajYQO8uSn/pezngW/1Hn+mYAHphl3SkGdrcH2xLiDk/GMFSmRHx9yJYJFDNNtRGt7GRx7CX/KYWGBGDCMpEHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696702; c=relaxed/simple;
	bh=pTdAzv9J9dz7yZW0VYVGUU0lqB+SuzjD7KIeaO1rqNc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zx6Z3JNNek9p3X6dQ38XdIcqpi7xPl5bZ7NjJgtHUMzzIGL8c5TsmU/xqQUhgavoTvh/pGuQuiE0dOdjxn148eRr794Qq3pf5DlMbt9LywN8iJDkdnHsTGcwZPuED8A9DT463XOb6z/4gtRH/5D7Z1xu4bfh5qqIrccial56ARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=HxtCmOtk; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 482792F4;
	Fri, 17 Oct 2025 10:14:32 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=HxtCmOtk;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 47F982421;
	Fri, 17 Oct 2025 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1760696246;
	bh=xoEGqKre08Jr7PjsmRWAbKcDgcSndGO/ryih9swplXk=;
	h=From:To:CC:Subject:Date;
	b=HxtCmOtksg3mDXqT7iObO6Vh+0VKIbp73WMhvJQkoyvvn4vS1RAzOYzkhpjiqzxZ/
	 uenaWuB9jY1jMAwi97LnE2K4yhWhncHDe46wJ4Fye9Tw6s3bI7GL5SA0Q9nRFhwZe/
	 Wg35AE1qsGjcyduiqUiNGEAK3UolOd5z7qFf5Yeg=
Received: from localhost.localdomain (172.30.20.178) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 17 Oct 2025 13:17:24 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Support timestamps prior to epoch
Date: Fri, 17 Oct 2025 12:17:15 +0200
Message-ID: <20251017101715.5793-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Before it used an unsigned 64-bit type, which prevented proper handling
of timestamps earlier than 1970-01-01. Switch to a signed 64-bit type to
support pre-epoch timestamps. The issue was caught by xfstests.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/ntfs_fs.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 630128716ea7..2649fbe16669 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -979,11 +979,12 @@ static inline __le64 kernel2nt(const struct timespec64 *ts)
  */
 static inline void nt2kernel(const __le64 tm, struct timespec64 *ts)
 {
-	u64 t = le64_to_cpu(tm) - _100ns2seconds * SecondsToStartOf1970;
+	s32 t32;
+	/* use signed 64 bit to support timestamps prior to epoch. xfstest 258. */
+	s64 t = le64_to_cpu(tm) - _100ns2seconds * SecondsToStartOf1970;
 
-	// WARNING: do_div changes its first argument(!)
-	ts->tv_nsec = do_div(t, _100ns2seconds) * 100;
-	ts->tv_sec = t;
+	ts->tv_sec = div_s64_rem(t, _100ns2seconds, &t32);
+	ts->tv_nsec = t32 * 100;
 }
 
 static inline struct ntfs_sb_info *ntfs_sb(struct super_block *sb)
-- 
2.43.0


