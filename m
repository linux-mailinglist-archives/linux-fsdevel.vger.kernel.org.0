Return-Path: <linux-fsdevel+bounces-67597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFEBC44458
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 18:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249F01888869
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DD730AAD2;
	Sun,  9 Nov 2025 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6sor9YK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B62FE59C
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762709126; cv=none; b=AoTu6vBCL7wlB6eyRCCSGk7m1JBBUwOE47+gjzoQNzrBguLtq3MG1YkqAgODPIyl+FE9V0UNbPXyYQX87xQ2V4J+6e9nT4PxcRrCET/9ZuEvujv0pijg6tqESgyhp/lW/Kt9v4I8FSt2ddT+qC/oOQjyOgXPbiHYUfqxa25V9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762709126; c=relaxed/simple;
	bh=IhIkuSuF17GlsVUwGV7Fi75Nge9iJGGX57xSFdaaG2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oeeHq0jOGYWp21yxYWUyvabFlAk3vlXobfPXJrRsrtOZEYdvGUCPC9/ooPNOiLtR0se14xCueLpK72XugNI02fVZhjjGW8pfDtBEY/yp4XeZxR/Pk/q9jOLJX/ECu0CiHVF1jFe2il/sXTPaD+KwI1SpJU1ks7de8lZES8R9rRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6sor9YK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso4123820a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 09:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762709123; x=1763313923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5uUj7ITcpZj2TsML5T8Cl6HHMpcKN3nQGf9uTJBYnM=;
        b=m6sor9YK4QBFH07aM2PIDtspRSlSz7wyBNb0DkRk4NToI42oKGufWJGXbS4laM24ac
         BCKZ2OvoQBqMe6DMcy350twzMBt18tQHP96DUXB/4ZyblgTnGLMq+9yfwDbtveuI71r0
         t9Ccf2V70RCeUJnjRRR/Kn4fUtVsWfYSKAQRWiSTFo/7p140qn9hi37bxlE9egZU5k5b
         VpgMP+4cdldBEKE4RKKOcLKtW20XCAMmIoW0sJDb5yn1T9pHESbYA/8XlQwdCycSidy+
         yUqfP1ziGfjSZoU3XxOFGrsePITc3s/WENWWLbR6bPJaEinkOQQFXwkF0wzjIYceO4ga
         7YJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762709123; x=1763313923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5uUj7ITcpZj2TsML5T8Cl6HHMpcKN3nQGf9uTJBYnM=;
        b=VnGoee6niGtoaiKuvlyTCcj7w8QuCEV1kwEKNVDlTb3vYluN5TVHax2RMXixdw9mUY
         RQIBGiLO0RH8Uh7rAIjZ23uPTMZwqnXVKtCEny35NRVaREQfPXxvO7aTpQiwr3rmZ/Lk
         cW6usrVwNaLw22VhrCZey2mpqmjF4w50z4/IgkIrZtPPmkeL9I6ogDTVnnV9TyFYOegg
         Go5F/ceDiIGPBBEgcOYc9FF8gtcnmJmzNWCN6ypsbOW2W6eUS4Gq2O3398t2xy771CrD
         L35+r2If8SHof+bkmQvj+zaixxPMNHbOARmmw/a6ygqR+PJqixpoG6ajHvkEcVOhWvlc
         BrIg==
X-Forwarded-Encrypted: i=1; AJvYcCVrGV3Ic0yks4uB2w6gN9gr2oz+mv4XayoK+nmo9ZMpLxm7oelLkxRW6FBECkZpUGr5IDbaegClaj1ccLtw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Y5CHjI/HP0PeNL+zuyUvEjCn3HBWUTC4Wp6oNPA+XvMy+3g7
	wvHBuiOPTeRmzqtFazScbG2bn3lULL4jk8nz6y5uYSpA2myq25fJlCa4
X-Gm-Gg: ASbGncvlAjia47SOOmVjyTAqkNek1Eb/6vgDdEXUzyyBHpawlWXE6vk98TdYeIbd7V+
	Kmeug/CVeHhFKAEzXwwO//rD6geGdUuV6o9nrJc3KmLgPZgtRNJtgK+ol3rW2A5L0Eh5UZxn6ar
	bsiU2w484YSku5LebWL/sZcSPC0A+49DVam/vuyPqpiTI7LTjojHDafDxHX5ffytCaAH+HHiY9E
	55BU1F6Br1nGchxGUOoeYb6YUJJGCp2khxRvtxe7DmOddRUVqMPHIr8TGU+iIzf8b1UEjrqocM6
	DofzdRgbY4QPROPQaWwCwyodXHZ/xoAujNpkKNnr4zS5rljLs9vrm5rNssSJzzZNs370GAUAzGb
	iQ5kIskbw8HqcHAmSNmGbQoTog/qfD03fXLw1XQrV1EpFC9EHS9raHZbaMHVIuY4h1ftDiJuQSQ
	n8s+ysbK7p0FJ65HpkuhXuPF4xBEI3ETeNjKyEV6dCqrq2fVoIkX8y693w9zs=
X-Google-Smtp-Source: AGHT+IFWNwV3C/IaXRRnwobzv1o9PKYxfESAALRMns5L92IjMXOjd9WqLoAGQ9NI9ORRXtNCpzRCWA==
X-Received: by 2002:a05:6402:354b:b0:640:ea4b:6a87 with SMTP id 4fb4d7f45d1cf-6415e8134a5mr3660037a12.30.1762709123200;
        Sun, 09 Nov 2025 09:25:23 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813bedsm9257748a12.10.2025.11.09.09.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 09:25:22 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	jlayton@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] filelock: use a consume fence in locks_inode_context()
Date: Sun,  9 Nov 2025 18:25:15 +0100
Message-ID: <20251109172516.1317329-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Matches the idiom of storing a pointer with a release fence and safely
getting the content with a consume fence after.

Eliminates an actual fence on some archs.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

this is tiny prep for the actual change later

 include/linux/filelock.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index c2ce8ba05d06..37e1b33bd267 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -232,7 +232,10 @@ bool locks_owner_has_blockers(struct file_lock_context *flctx,
 static inline struct file_lock_context *
 locks_inode_context(const struct inode *inode)
 {
-	return smp_load_acquire(&inode->i_flctx);
+	/*
+	 * Paired with the fence in locks_get_lock_context().
+	 */
+	return READ_ONCE(inode->i_flctx);
 }
 
 #else /* !CONFIG_FILE_LOCKING */
-- 
2.48.1


