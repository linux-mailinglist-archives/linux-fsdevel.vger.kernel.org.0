Return-Path: <linux-fsdevel+bounces-58673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E537FB306C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB32AB019A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CBA374404;
	Thu, 21 Aug 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RmE+irxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99838E767
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807673; cv=none; b=AL1O5tYQ6K6Zr3u1dtqV+9D5KkV0dJJfGMFN7kVNq/SmazH9Y9oA+igUn1ZUK1SdmfkoSRY8NsvO5yDrrjCUsGZTL6M+K5KWXLjHH9We+xKaVOAe9gMz36vouQWxvxMstYWdzqe99NQ4KwWLGUlUCin6W/i5AT5W1jF08ZnmpNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807673; c=relaxed/simple;
	bh=1ynNzpiuwPqZZfc4RXGfh4iGaVDz+/1Rc+r/9GR0kTY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDbAqFc5+Ggi4+6fyGGbVN/jClk5hzob6ZNkndKqkvPANJ25/mbyIz08a13Dy9MrAC5T+CrYotFekl+LCjtaBKrr27oxsQDSgifFnmPl5duQruhVEyOALv1cuAL9T3r6+1p+he06wofvt2lGFLunB9f2L8xSJt/qOP+56vMmGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RmE+irxL; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e94f19917d2so1386311276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807671; x=1756412471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7o1UME4c5fAFN/Xhsfm0V4nndfddrm872UrCQizuLdI=;
        b=RmE+irxLbr8dhHU/ye60oarMKOW3m1gPME3Wd7Ldi9qcnoXpt8r1SkMJeMJglf15U+
         1oFrhsxsO+YI+fJ+yx2xrQuMdSFROZyPo4NPa4x7eDchqOYHDxh24YwT128ODXGG6Egc
         XRAju03vaOqChD6PCt54IdhnDx40gjjAw9sIUt4H3+NRKquL+s4PnZDh0GtvsdqfEEuN
         7B6DZzuXUO3ZIJVFRXqvcb/vVb9Blafmaz1/3LBXltazJjHdjeBmAZyxNCXdntbrab6O
         GOCkxeVE9NDzklw0TwczMPWdl05mYGBGP4DERw7sTBitUGJ8SyOco+jJCe4v6AgT+NKV
         L2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807671; x=1756412471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o1UME4c5fAFN/Xhsfm0V4nndfddrm872UrCQizuLdI=;
        b=Rwlg+8o2EIaTPStILt40BAZrGtka1FVpdf5U9cIGTAd+ZVrVLi46b3iGT6+CzcmsnC
         RnZk/WItGoA/dgMiV8OksBGnVkWqyf9liRL3BvFU8LQZkLNXv1AYax/ZSp2PTj77T/3M
         bnxogZ2+EQjTGGnLXxEwCbFQWZr7En63VMm6OwqX7asUTzrsQexaIXjQYslxzQ6QgoLm
         x7i7gn+F8Sq4zW+OBu2+sfJnQtZydK7mDgJ6GOZryMGC1ORA+5yLc1oH4yu/O+FcH46o
         /ZlfxpexYp/fikb9zwhOYZl3+VNT/pvmC2SDudtTFOhkxN8xvZ0LAKtbdZH8C09N9V9i
         R4Fw==
X-Gm-Message-State: AOJu0Yy1JxWgnLxwTWxWiDAK+D1/NCf8jTUP4uN0eTTXmJzhERezKDL9
	fgxSmzhErkbjISZMxYz3M/XyJjEtz4YVvoaehT2Uzy2kW1MziiZcvhkcQPySlM3JcgaqP15BUz4
	HfHqgl36e41cs
X-Gm-Gg: ASbGncuYnS1h/1FVZ5PtM+baErLGBdQwl2GnP8tz6AWsta+HOEuKBI2AjrfDUummEAN
	j82WVqMMvMJm5Ejj8I5vWgoFqS7jvTHSIy5TQzxtAp2rSunaQ/1ELs/frYIwf5xz/02ftkJnFzI
	qUh8/oVmMFfRgYDTA7BdHvoqCrY0Nn5VfnRXXCiLSLARfPD+2luIJYsmOZ91QM11NIWplv+8bAk
	oWHKcUXThjLRghFsLIYNWG/KVfj+Epa2qh2M9/3wnfvav+bf8lRQQGYIM0Z8Unp/mtRTGHRId71
	za+Po0KCFU3Lh5erUJEGbn7g6zM6MXsU9bgGM1jNaULvhBHZHymSAbaJxKgNs/icn+wlDdErVii
	6uN+fjLDXRQEO/UXrcMTox7W1KOlYYTPikyQT8htGV1iiCSPQ1Ya/YmajE/Y=
X-Google-Smtp-Source: AGHT+IEK9Y3HGsRw84lNwHY9ub4929O/sGVc990y8WeBLhD6pl7WYhs7lL5XHgi9vuczlX82x2XgRg==
X-Received: by 2002:a05:6902:33c5:b0:e93:4b5c:d50d with SMTP id 3f1490d57ef6-e951c2a6db5mr895451276.25.1755807670806;
        Thu, 21 Aug 2025 13:21:10 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94ee7b9ec3sm2508563276.17.2025.08.21.13.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 36/50] gfs2: remove I_WILL_FREE|I_FREEING usage
Date: Thu, 21 Aug 2025 16:18:47 -0400
Message-ID: <0551f9d37b57fecb82930a3465d42ee6a55ea11e.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have the reference count to check if the inode is live, use
that instead of checking I_WILL_FREE|I_FREEING.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/gfs2/ops_fstype.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c770006f8889..2b481fdc903d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1745,17 +1745,26 @@ static void gfs2_evict_inodes(struct super_block *sb)
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
-
+again:
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) &&
-		    !need_resched()) {
+		if ((inode->i_state & I_NEW) && !need_resched()) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode)) {
+			if (need_resched()) {
+				spin_unlock(&sb->s_inode_list_lock);
+				iput(toput_inode);
+				toput_inode = NULL;
+				cond_resched();
+				goto again;
+			}
+			continue;
+		}
 		spin_unlock(&sb->s_inode_list_lock);
 
 		iput(toput_inode);
-- 
2.49.0


