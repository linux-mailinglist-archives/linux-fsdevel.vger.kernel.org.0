Return-Path: <linux-fsdevel+bounces-44207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01DBA6575C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 17:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47C87AD5A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453D919048F;
	Mon, 17 Mar 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGAE9rNi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139111E52D;
	Mon, 17 Mar 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227642; cv=none; b=j/vSGUZ1VZ8ov53lcV9SSPBySMXEt3Xs9arppNPUAlergqQulWIaC7HcydHIeoFlUf7sgU+EBQGdFezxkCzA471u8AqtOlaOEMz788ZMgJmjUP3u6s0unU78HkLfYrQ/YL/qvyrirk4VxKGM3nWIisuUKfXfTNWrTduHjOmGojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227642; c=relaxed/simple;
	bh=7zHmn10IVTDlW8B/d4P9A7Nh8f8WUIeEm7WOQkird2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQFN5lfEwg1O+lNl7zlmIh1yYVi6Lhw9HDKB84HKoKoDfXUAE42kQaYFDoYHH+mYzzrF91vPs6vg1KGmoU1WpPiLxhY2UvwVolDcXR0b7QQcny7CaZg/dMNGw+qTFLW/g5lOe4YOWQ6PUe7QAlJoWHuxfBCSAxQoGynP68agMD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGAE9rNi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913b539aabso2904466f8f.2;
        Mon, 17 Mar 2025 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742227639; x=1742832439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PK3+IUatQVSUJDQmQRvrazDlRLAN/7AjZbQSB7pRDT0=;
        b=SGAE9rNiukVEslIGS+183sV367QmkCEHlfH4/PW19/0n1kIqv18zO9dxubEju/ee/J
         7QHPK3i7pczZJ+hrg4ZTTZAZaHpEgbQlXaedxSfLD79I7dxYWFV1QGPVZkhCY1YBVLM/
         nJ4/jYa3rTFDegi/9cfPNVI4iyPqqOvSyatAbwxzk6GmRsCssXmeb0LyM3R9imfV+P5T
         J1SuTzL3QVNWuWTxnhVJOqy7+BafElJjs2ylpBObI7SFQOPdhoH2q3ZAJU7gsrzD6Agl
         hXkWhzAIsqPhuPNaqBCIe340se4AMXUtX0i/DF3E/3tdCLUrc89LFjXLrmo51o0uK2nk
         JO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742227639; x=1742832439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PK3+IUatQVSUJDQmQRvrazDlRLAN/7AjZbQSB7pRDT0=;
        b=wg1sENzkapSbNw+xvW8RC/EqVy6XXOIgwyObOhdaRcde7uehHdZ4B74alo5E0owNuR
         Qk+0WyNzxWKzxM3BPQQHHJ5fF8ZhDZl/JHTaW7va1NzfLFMmAcP3bxnbON0MUHwFX13p
         bLZg1HGB9lApP6LSHdsyXjIzw7HpyjsqKqXqsqnyRAvX9S4ldPcImXaTSnSxrW/fjKd/
         Q4l0/gMMhegx0ErAldO3sp2LrgSn4FF4/kyjN9qgZPf6Q3sJRpHufEb+9OxrBAJq8uwf
         2G/Hs/v/zjoRIvUx1ksisfqnkR0/od1D6G4MoB5IK79mFacn1M0b+QFy8ZJPkmib6yNA
         EJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCVcn5/8Z9BjgTVB24gFq/4IJfishhF5VFY2xOME/zn+4vSKLvhihV65OlleKkRnPy1i7xfD5xjfYePcGXp2@vger.kernel.org, AJvYcCXzULEQ3gE1PDr11WU9OMZ/zkoteB5ZQbGEs0E5SYEfy/lbqQy7GP/m+Jbbgx+LSroLmxY0pt8nYTtBcUad@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+Dc34tNxwYhjEEmrbSxV/wGwEslXrudCJZ9l3FNm0CIqyuvc
	7cPvt4xiU8Atj51VD66sLrF9V9p+Hd3yLMF4C4Z8tX/djMtCymSHugi78g==
X-Gm-Gg: ASbGnctVG86K8s/YM73OplQnqrvGRJBgse6ioYM+4F/XBGLXlXrY3VUi6tuLammGmBT
	V+RdyMiM8GJqvsmZ3KbgZX+ZutshQgB8dUg6BoADPG+YvHRrmRn8DNUqI8YgkKeW4mi7sPboILI
	cFLBGa+oRXdWGRIwqTGQXlflBxPhV5wYpQVPi0fkWBIi/qt05Gj/2uNU9BAienHPeNUo8OqxvpP
	GZTWfvP3py0FfwYRvl323L/KWe/glfbb6jdK0Lj+ryNEyxqRNaKeVHXrC4YSKteAUkuaFe30Vym
	3KH4KkcdXdzZiTEuA9NXIg4HLXVGcnPxZJZQrhZxuvrAIJd5UIWBH6jQjlxbG08=
X-Google-Smtp-Source: AGHT+IH5fLPgN0UebBcCHFitaoOEI+SUSponpFRoCUwEInvL1TGA1BQKf5OE35cPPi+oRSHWOXRISA==
X-Received: by 2002:a5d:5f84:0:b0:391:4095:49b7 with SMTP id ffacd0b85a97d-3971f12e65amr18088795f8f.25.1742227639030;
        Mon, 17 Mar 2025 09:07:19 -0700 (PDT)
Received: from f.. (cst-prg-23-176.cust.vodafone.cz. [46.135.23.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebaf8sm15747428f8f.95.2025.03.17.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:07:18 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: drop the lock trip around I_NEW wake up in evict()
Date: Mon, 17 Mar 2025 17:07:07 +0100
Message-ID: <20250317160707.1694135-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The unhashed state check in __wait_on_freeing_inode() performed with
->i_lock held against remove_hash_inode() also holding the lock makes
another lock acquire in evict() completely spurious -- all potential
sleepers already dropped the lock before remove_hash_inode() acquired
it or they found the inode to be unhashed and aborted.

Note there is no trickery here: the usual cost of both sides taking
locks is still being paid, it just stops being paid twice.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 10121fc7b87e..4c3be44838a5 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -816,23 +816,16 @@ static void evict(struct inode *inode)
 	/*
 	 * Wake up waiters in __wait_on_freeing_inode().
 	 *
-	 * Lockless hash lookup may end up finding the inode before we removed
-	 * it above, but only lock it *after* we are done with the wakeup below.
-	 * In this case the potential waiter cannot safely block.
+	 * It is an invariant that any thread we need to wake up is already
+	 * accounted for before remove_inode_hash() acquires ->i_lock -- both
+	 * sides take the lock and sleep is aborted if the inode is found
+	 * unhashed. Thus either the sleeper wins and goes off CPU, or removal
+	 * wins and the sleeper aborts after testing with the lock.
 	 *
-	 * The inode being unhashed after the call to remove_inode_hash() is
-	 * used as an indicator whether blocking on it is safe.
+	 * This also means we don't need any fences for the call below.
 	 */
-	spin_lock(&inode->i_lock);
-	/*
-	 * Pairs with the barrier in prepare_to_wait_event() to make sure
-	 * ___wait_var_event() either sees the bit cleared or
-	 * waitqueue_active() check in wake_up_var() sees the waiter.
-	 */
-	smp_mb__after_spinlock();
 	inode_wake_up_bit(inode, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
-	spin_unlock(&inode->i_lock);
 
 	destroy_inode(inode);
 }
-- 
2.43.0


