Return-Path: <linux-fsdevel+bounces-59259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3513B36E70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A45A4622BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11816368083;
	Tue, 26 Aug 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FMXg1hfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C46134166C
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222890; cv=none; b=JmYGy+6iNLL/DeCs2gTClZDWW9sLneWW8cUPMu7FprY6fjFiJWn1TesJevs9+MmDinriWVjsabkV+xt4rTz9VJUNp4fp+mJ56r1r6bO/OUxi+0Ec0d8Qh+eUMqz6ko3U1dv6U+AoyY2x/iEcHxfRBDF5sJnqXV8nT2YdEPU2XIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222890; c=relaxed/simple;
	bh=sYrjuPeM7K3KQcnfVGtJT+79EiV+VMuzvrHu44CUk/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXKgW0Nfc3fbIiYPyKTWEiVonwJvlk27VLi4Fn0QbbsB3413Mf1UBeZkmkNwuS1sfnmzcOgaBSVCMStk8MYwOzJ+ckGg2QKhz5gwBDJHWN8PrXN/Z/FsVayPswckQjDpYTLnIXOkfyI0EE3fD8vakVvp3Ld6xmXGQTdjhLSFnzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=FMXg1hfO; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e96e987fc92so377581276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222886; x=1756827686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/GIckRLBTNo3hmisGAgyU/jYzDZFB7c7b11ZSMovQU=;
        b=FMXg1hfO5kyhbRx15TvhAKipxc646eFXX8N09dcQ0ZrvOlDtdiOZ6QBzaLeUD8Uqh1
         KYWzUTEJYqFUsITnNmSSE3j1aIgG/elk5hEmVTUz/O79Kk5fhV8Dgn6wZT4o47/amYo8
         24mI6kBbZsr+r2ThCZMbzrdLMDZ7kAtoAV3rBSqPCmI5o5hvA8GLifnHjBRZIT2oPgFZ
         UiR6aeTruvxazjljb+zrNd1ctBDo0tRbkc9nS6nQFX4Tf0Wd1nDmujc+YPWXRj5THaAt
         PdjMydNOkgHNptcQ06eQdclHxccA11SsBPowZs7mfbzE2glCsSdGesS3oqHEcP5YsOJS
         p40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222886; x=1756827686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/GIckRLBTNo3hmisGAgyU/jYzDZFB7c7b11ZSMovQU=;
        b=ROTvCnIXMRWK+m0sViC4rxnDnMsfTXR6dMTjedfmgpxfmstVAmH87Nz9RWaCgldLGi
         8iu8VF/bMeIEtanKUbVkFGqKt5aa4QOfytciTvEc8zJ40yhyxMNgaxnQRItgXbsGWv+N
         7r4d6nndm3m+GLDcrWLFwpgzMvHMnpHS6UIFcEqlRWsd9XO8btB8gmRR9FaitacGN1oE
         /96XqOK6WU7j1uLnr2ID2Gip+Hqh+zvj/C/cGHpo12wtkU7vrrb2vgCMTxCnHw5yU4fV
         PAfJ2Et3JqucBp1ejBju1pN+hiiFwNW1266EQ+M9GLsCFqukETkf+5Uo+qbKpOSOEJ9i
         cipg==
X-Gm-Message-State: AOJu0YzXEicIcOX0FLIxdKXbqTozH/zzM8Brhx1yymJCxQDbELeEDlE3
	C5aC5iP0oY+y9yqtVxOS8x4wnTVv6nTjs/OmT0n5X4584R2BDlao1yYqQH21Vm/u64Cq0pXIzu7
	GSEC1
X-Gm-Gg: ASbGnctnK+hI1qik8n61naT1T2A11zhQ2ct8Xvo0yMaR3+PuEHMUjZHqHe+u0Ab7OT+
	QGeNCtnDJ2cBpp8OLdTI4qpOygRAP+JB5b721T+IVKja4pFKnTioyPSektvKlT9eUP7Ww1oWvYQ
	xAD/YSK8oWUDSay+sif8TE1YKT70KPhlm+7uZeFWDq2tPLwXgoUsx388xGbmOLgpc+tULywsHES
	fohq+XXKolu7Aw3eREzVYjUqjMaRyLe2mQQzdEtvHHBNPoueKNyFAnOH4g52IHFM+vDUuJFr5LG
	1PRJosEoK2LijpWL0K4+VVTMJC09bnHxBqFvFlFTOw70Vvw7mHgjJwf/+DIrC/9uYHO49pgzVd4
	5rWSG/mZWxpEV3ivoXziinKAN/J/dnglRpRnNSrcl+huMvl2TrXEVu/85V9S90QL1Z2Y03Q==
X-Google-Smtp-Source: AGHT+IHMjqIN/cv/dNqZaUqk4AIfXq7CeGQ/chI33c+CxPNO4KaD5NOoKQBN/9sJT95k5O4DzOn2ug==
X-Received: by 2002:a05:690c:6d07:b0:71e:84d6:afc4 with SMTP id 00721157ae682-71fdc2e296emr178097767b3.14.1756222886438;
        Tue, 26 Aug 2025 08:41:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7213f47d0b0sm159287b3.72.2025.08.26.08.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 26/54] fs: use igrab in insert_inode_locked
Date: Tue, 26 Aug 2025 11:39:26 -0400
Message-ID: <8e31ead748e11697fff9e4dba0ffe29f082c7c7b.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the same pattern in find_inode*. Instead of checking for
I_WILL_FREE|I_FREEING simply call igrab() and if it succeeds we're done.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 8ae9ed9605ef..d34da95a3295 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1883,11 +1883,8 @@ int insert_inode_locked(struct inode *inode)
 				continue;
 			if (old->i_sb != sb)
 				continue;
-			spin_lock(&old->i_lock);
-			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
-				spin_unlock(&old->i_lock);
+			if (!igrab(old))
 				continue;
-			}
 			break;
 		}
 		if (likely(!old)) {
@@ -1899,12 +1896,13 @@ int insert_inode_locked(struct inode *inode)
 			spin_unlock(&inode_hash_lock);
 			return 0;
 		}
+		spin_lock(&old->i_lock);
 		if (unlikely(old->i_state & I_CREATING)) {
 			spin_unlock(&old->i_lock);
 			spin_unlock(&inode_hash_lock);
+			iput(old);
 			return -EBUSY;
 		}
-		__iget(old);
 		spin_unlock(&old->i_lock);
 		spin_unlock(&inode_hash_lock);
 		wait_on_inode(old);
-- 
2.49.0


