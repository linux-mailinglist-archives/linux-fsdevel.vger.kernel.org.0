Return-Path: <linux-fsdevel+bounces-63446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A983BBBCDC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 01:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644C83AD1A2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Oct 2025 23:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C71E1E1E;
	Sun,  5 Oct 2025 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/2M55xr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49A34BA3E
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Oct 2025 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759706135; cv=none; b=ImqyoxMWiYYcisnokIAyCQmWOVMU0FYnHSN//pE8F99RQMg9f9kppnnUhO87a+4sVWJIB6XlKFrP2THSoFUT2J+80F5WtOH12MmPvzt3kytJIJH/RLnfxIfO37dlKEsIRDP85cD93QFsHQNtXOqkZzHVXxMQj1x7LwY1fGS5cto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759706135; c=relaxed/simple;
	bh=fybNiBAefFTh//jSRU2sf0Ny8KCLWtk1ph7b062OZqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGv6uqEedMRmFcMmtrQ3MtEHw2YQEGeBC6UnLX7WPGv+3KTAZmspko8dICocHAX/MmKPzjslCTvNJVBGn7hv+8aMHUCDq+6JmsXHlw7Nx4Yz1+BG3JB2CW94McvdX49lepp4/DboriGzdEX0+MdTBIaLrQr6mbvtx3EhrANOIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/2M55xr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so40510685e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Oct 2025 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759706132; x=1760310932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZVLKUfxISrsNrnwMvWMj0ZRjTubuXUM3Dffz3zRah8=;
        b=N/2M55xroM1u/eI1YLJLxLzvNfaoPyUk03HUDeaUbmX2GzfN/UDduSpOaD4e7CMH2O
         fsrcK2N5kZrdXKuCd04emIeCbJ0gVEWdWieln+QGisIvgGcTyE+02ghAJPP8NEp0uiOL
         df2iuoD66DOAhoxLSGkw16wVERTxy9xHarxXuFYDSRHIlgc2daiC53O3fwETY44gSENU
         R3otJ5srvh2uKoE3SAIisLz0Yl1zP6UfTVzk9ql8sOyHyHjJvu9FS0j5k50eDaP6J6pC
         8DmMotN6BOh+UBgwCHnvwz5AdQY45D3m+Kf+Jlq0f5TIirioB6iAnx5UjfBqHKVwwC+P
         YEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759706132; x=1760310932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZVLKUfxISrsNrnwMvWMj0ZRjTubuXUM3Dffz3zRah8=;
        b=coXPAirG4WiPMo+V6D4z2eAQChCfLumuC3x8HilRcPqNAlzCUOY6F5CDmq7Q6K5MpQ
         51HX788iXXcCSrpsq9p4dD6tfvoIJh29IXq4hOLBf7wB/GqcQX6rAiCEZU/E0LaM4nXP
         N2jTMQwmtVVTwK0BMqiJwfd9xacNgE4/cO5fnFMGkx7KTLdnK3R45FM3DHXNMCu3aL+V
         TRyPN6BT0PMHylH+OqeZbSQoflKF8jQ4j0lpCbsTzJdrU/iCXAgOXciTL00R+jQookML
         4sgUEB6IYsULJTV1c3DA27FEEZVqmGc20V/+uARrjyue02N6IuceJBwxYZm7LcKwFjbA
         uhag==
X-Forwarded-Encrypted: i=1; AJvYcCWfoLOUCkt3CZmszWWHJpRiIDV201GLWfGVisg/cBktnQ30NXBfGtfJ6OA/BCbWxUMwlE5etONIATo6RVbA@vger.kernel.org
X-Gm-Message-State: AOJu0YyhwWNKen5bVS1WZugj1ZcA7s5b4UwC6fhe9prh/IIPc/45eUdb
	KDmGMxlyhL7Gk6KM6zkEmJKEqGWMg8mfDBIEbOqsFCm1vDH5cNyTWSFv
X-Gm-Gg: ASbGncsQma+fydRywOyU1h2RlAUk/aDmTOsilZjzMUEQKvXlCAiLtM8GNaElCYL2cL7
	/tWoV1ItQkuDtl2CnKN+7dOAlTAi94uJWT9TqdgdnyxhdjzgP7fD7fDDH8MLtrETDRZumYibVuI
	QRZEVsi5KBNK1LPf5wOVdWnI6kR8kIOdgN2rBJB0po8eZ3bn3CKPLJFDEMm+c1i/3Es2lQb4+YR
	usFfI2neEfN1ELNW+m7qgQKp/K3H53WRfsY92QV8DYUFOjzVDEq27TPI2ZpPaiafs3Pq7KOTXUL
	V8pSNf3c5tcEeD03CbToIkUIUpjxRYtSsDCnGO2qFnSTbE1tYC94PRRxhfdmWrJDfvXyk5Lx8MO
	TrKUfLSDcra7J5jx1mbl7SRSw5LHKNzjplKNmkXA3gDhYUbBsfHfmMQC7YqSUJ4drSqTluaaJEG
	QCxTtTLrFkAmeTKRH8kOHBfJRFujWz7Hqg
X-Google-Smtp-Source: AGHT+IEO23zbV1o6Dod3OnepyrZ499l60l15zhzyFc5iTDUQFeRUVPj+KaAJtZN9R8sEfUGcnJfl7Q==
X-Received: by 2002:a05:600c:34ce:b0:46e:4ac4:b7b8 with SMTP id 5b1f17b1804b1-46e7114e923mr68621845e9.25.1759706131907;
        Sun, 05 Oct 2025 16:15:31 -0700 (PDT)
Received: from f.. (cst-prg-79-205.cust.vodafone.cz. [46.135.79.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9780sm17920640f8f.29.2025.10.05.16.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 16:15:31 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: add missing fences to I_NEW handling
Date: Mon,  6 Oct 2025 01:15:26 +0200
Message-ID: <20251005231526.708061-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suppose there are 2 CPUs racing inode hash lookup func (say ilookup5())
and unlock_new_inode().

In principle the latter can clear the I_NEW flag before prior stores
into the inode were made visible.

The former can in turn observe I_NEW is cleared and proceed to use the
inode, while possibly reading from not-yet-published areas.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I don't think this is a serious bug in the sense I doubt anyone ever ran
into it, but this is an issue on paper.

I'm doing some changes in the area and I figured I'll get this bit out
of the way.

 fs/dcache.c               | 4 ++++
 fs/inode.c                | 8 ++++++++
 include/linux/writeback.h | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index a067fa0a965a..806d6a665124 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1981,6 +1981,10 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	spin_lock(&inode->i_lock);
 	__d_instantiate(entry, inode);
 	WARN_ON(!(inode->i_state & I_NEW));
+	/*
+	 * Pairs with smp_rmb in wait_on_inode().
+	 */
+	smp_wmb();
 	inode->i_state &= ~I_NEW & ~I_CREATING;
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
diff --git a/fs/inode.c b/fs/inode.c
index ec9339024ac3..842ee973c8b6 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1181,6 +1181,10 @@ void unlock_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
+	/*
+	 * Pairs with smp_rmb in wait_on_inode().
+	 */
+	smp_wmb();
 	inode->i_state &= ~I_NEW & ~I_CREATING;
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
@@ -1198,6 +1202,10 @@ void discard_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
+	/*
+	 * Pairs with smp_rmb in wait_on_inode().
+	 */
+	smp_wmb();
 	inode->i_state &= ~I_NEW;
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 22dd4adc5667..e1e1231a6830 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -194,6 +194,10 @@ static inline void wait_on_inode(struct inode *inode)
 {
 	wait_var_event(inode_state_wait_address(inode, __I_NEW),
 		       !(READ_ONCE(inode->i_state) & I_NEW));
+	/*
+	 * Pairs with routines clearing I_NEW.
+	 */
+	smp_rmb();
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-- 
2.34.1


