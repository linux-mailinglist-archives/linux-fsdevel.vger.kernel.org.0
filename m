Return-Path: <linux-fsdevel+bounces-63632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9154BBC7DCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 10:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 973DA4F9000
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E9B2D47F4;
	Thu,  9 Oct 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK8TLnBV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84342D23B8
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996787; cv=none; b=VxLY5jVVv0rQ1iEatvMrmcrUVB/4X0op5dh6ehqGWNMJISN5gHUJ+OsW1hpVQZJVgp4OU8j9nDlo/B1L2Gk5nI0bd6QFxR+BhheOr2Qs0Srj0yqpY1xXbt6CG57Eq4MWvxVVfd/OSB4iiTMKHglRhbMUsAHFrOj/jkIXOF9NJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996787; c=relaxed/simple;
	bh=ASNy7RmtSltSBzEynaqDPxE2iqjwE0ZPcjj4whWJ4kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtoNtp/BCg6ie/tQyaYTMrLWtaqSk4jPrsbTFdxIDcCSDVR4Jxxdrykyt8kpnB6hV+lY9q9Q368exH4U2kykmRWwLJ1Q2+eMRHrxrVYk5j4MLmnoCSSbXyo3ZivX0RZjp4J4MxkqYKvmqhXj8E8ip+iSmQEOAfla2a+aauiTlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK8TLnBV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso105131866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996783; x=1760601583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnyVCyplzK+z1W2ORGsEbSjRDIE71IW/QrGYX9ePnTE=;
        b=QK8TLnBV8F6IPKH9b//mxMoquBU1AYrHverDd2jJnQIsgDXYysnPt+5qBsl4ki720U
         3ocIW7Jcipyxz+FB5i0HVbJvTq1bAwhiq0szN2RgKkAbWEjK59xK71mA/UXyiIHGLjks
         i8X1rXeYq/6eOyN9qk6y7SDbeKEfkeMPkSkycmy6w9cX4IbDACFodVHNf7ayS2tuQQzf
         IKbgSxng/5QEfd21nDFSwlasUSaPDixT4WIxVsZxCU8P/0dDBiGiYR4j/rTXKjR9ALI1
         mumT8GIbxFNYEvHLNz1UYKyV+o9ECQ3E/6bbvg2TYrcGqhvXosgo02hjcVjVX1duKbm9
         ES7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996783; x=1760601583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnyVCyplzK+z1W2ORGsEbSjRDIE71IW/QrGYX9ePnTE=;
        b=cgUOHTD3Ma7y+dSiUEpHOdbdBkiYmgzovcZWCRUQ8HfCWISxPID10MU1P4SS8uN2D2
         jD7XxO3RjJME2kIbG9BW2avJYZIKwAiB9L86IMDdDOUzNKLQ1XfJHDIUvY5qH/okLY1Y
         rZVf+RqG7mMa2XAvHHQQp3+h7rwnm3C08XYAs1X02V7JCH+1pog5B4L17kJZC1vWN/Rh
         CtYAoKExnET9pNlJffw7kkUg8IoT/P142guPoNMeDGpqL2V7cs7E/mzFsqNJtYDkCsME
         z+H4ugDYWAG2bxQQ74cPQsCF/qZybgllBv7Gib7WLldVZVU26+Cv019MSkqe2B3qQo09
         w2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUaf0UR/PfZ8+qtgRQ29zyUemv9n8KJ33pHgUAkx5T72r9hx70SJ1nKTsHxkNtia8avJ7w0BOq7SS0Md3Aa@vger.kernel.org
X-Gm-Message-State: AOJu0YywaMa62hAQieG+fPgDIpz5yKyThnFGTDyDKrcMgK3DGXR9hDpp
	pZMyueqAUZ0cpC4Q1yRSu7Tt1VN439/jxTUk0WR65KITX/BavgmeTBLC
X-Gm-Gg: ASbGncuVEezAbjUcuyNDV8TePlbkCbTLKihvkJqR3LgNJJSW387dkp+ah6rp3t72ZBP
	RNODJE6WMKY2GWUtyF91zQyo6ExtH0CM+p/cv5AkpVL+3FB/VqnCo/Ohl6NCYKHnAK7iMX0fLCr
	AglX0GWg/rR90sWa8UV5h/nZhn82RqU1RGbKaPltFEAVtdCzBMGpHpSpxJt6w0p/G/fAaT7bAnf
	nchSjZ5TKhr/eIZ7e2DjrPOxPnmnau4P9uTlhF6Uv+Q0fsj7IQTyXZ2Q6S2ASOQUYSK4P+uEgap
	zE8N2W2gil+zbsNm6CW4OPpEfav6RZxoycQ7VQtr9GC0RY0lEsaAo+AFcKqB2smQw8ISl2pP9Xf
	cH8pVg/D4Tseheg4jnUKam/lYVONoGpJwoQFG68sTULCIjkpEfTyvk9B12DqiFy6UdfwKei/4SX
	pW0SMmfONaNwmRk8UvbgHb33K1zPU9EYA4
X-Google-Smtp-Source: AGHT+IHSi6VF6s0uOD+PumlBjGkMUoulpOekOEwVZLQpfCJd1Jc4jSCHGMuyuANtbvnedJ6DnWPu/g==
X-Received: by 2002:a17:907:7f0e:b0:b48:44bc:44f2 with SMTP id a640c23a62f3a-b50ac8e52b0mr657263766b.43.1759996782956;
        Thu, 09 Oct 2025 00:59:42 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:42 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v7 02/14] fs: spell out fenced ->i_state accesses with explicit smp_wmb/smp_rmb
Date: Thu,  9 Oct 2025 09:59:16 +0200
Message-ID: <20251009075929.1203950-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The incomming helpers don't ship with _release/_acquire variants, for
the time being anyway.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/fs-writeback.c           | 5 +++--
 include/linux/backing-dev.h | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 2b35e80037fe..9cda19a40ca2 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -476,10 +476,11 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	switched = true;
 skip_switch:
 	/*
-	 * Paired with load_acquire in unlocked_inode_to_wb_begin() and
+	 * Paired with an acquire fence in unlocked_inode_to_wb_begin() and
 	 * ensures that the new wb is visible if they see !I_WB_SWITCH.
 	 */
-	smp_store_release(&inode->i_state, inode->i_state & ~I_WB_SWITCH);
+	smp_wmb();
+	inode->i_state &= ~I_WB_SWITCH;
 
 	xa_unlock_irq(&mapping->i_pages);
 	spin_unlock(&inode->i_lock);
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 3e64f14739dd..065cba5dc111 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -277,10 +277,11 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 	rcu_read_lock();
 
 	/*
-	 * Paired with store_release in inode_switch_wbs_work_fn() and
+	 * Paired with a release fence in inode_do_switch_wbs() and
 	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
 	 */
-	cookie->locked = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
+	cookie->locked = inode->i_state & I_WB_SWITCH;
+	smp_rmb();
 
 	if (unlikely(cookie->locked))
 		xa_lock_irqsave(&inode->i_mapping->i_pages, cookie->flags);
-- 
2.34.1


