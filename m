Return-Path: <linux-fsdevel+bounces-21432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89469903B7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 14:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5AF1B26B35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DEB17C216;
	Tue, 11 Jun 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKS3xns+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2C517BB23;
	Tue, 11 Jun 2024 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107600; cv=none; b=YKXT+BaA6PMCdjwlGuw4C8zZ5oUO0Q42aVQI0ZDAqJ6A3i+c5NtIQzejcZOW6bQ7nbz19I993cW+33LBwTKEXCwHd38bWd6MQGf3x4MSECg7MFChM3gJ7uCaG4JRcsPF/kRVq5GVg/km1zogYrYT9egZZPuAog75xxfj7oZsZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107600; c=relaxed/simple;
	bh=vT3LFzEeldwiztQNO1Y8xDg0UBLAPd+cr7YztvybvcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pud7H4CEvrvAdVdkWIgEs8eWbGPeEYf5Yo3/ko+Kb0z/UMrOHI2vlPkuEy4xUSCmKEYap6vaL+QHgbRghoW0lXyAxyzwTdZWA/uY5msKk+k4cii9rcbrTeAi6SUNBS7dhVQaeRN/i3rFueemzDXEryth053u/MoNhreJQ1BeQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKS3xns+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4217990f997so27001465e9.2;
        Tue, 11 Jun 2024 05:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718107598; x=1718712398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOwdG0ynICYzTSCN8/wPrqg53mKV02DaJh6W/3l/9RE=;
        b=fKS3xns+N/7rjL0pWjscGPoM7WlUOJ5lfNrEZOGIOXQ0GWPr6/chR7G3F9aRzIWYtk
         pRcVmkSQm0OR9wmo0Pme84d2myiQp3lCY223+t1Qg2aFS/eC6ksYq0LM8TCT5jCATBfs
         rtSmOhEOrVOb5g3VUxJAboPlUH9dXCDCEmTVdtFzSbebvzRRie61zcIBtgOjLaKdnycB
         g4KbRe9DWUTIWzk/KN6fYM4iUVFzfVrYPFcKyEVEsg43oNn70oYmUr5hM0pu4yerFQxb
         E5DwMnvdg0Zj+nltm+DH5sM6bbmikS2Sl18YpJb5/pWfCVfNhXjHEcWa40CM4wY6DasI
         jlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718107598; x=1718712398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOwdG0ynICYzTSCN8/wPrqg53mKV02DaJh6W/3l/9RE=;
        b=sVCI7pJAppPGFiOor9oifgaHQU+EjbSmLVeF8q4ypNM1ZjzLJLA1xxWNkd9TOiYfrR
         YCkiudKYYBpzwMHuiQVSPloWn6aGhec75jFmoN7QxbPj00kyKi/IagEzqJOxSG/dOGIc
         TIalXhyBj1qJsThQ1n8csTwdsHWFUxiD5pfbj8b3Tl5wtuGSIuLr7YjiWriICdJtcmv6
         igbT7XJMfjR6U0S51jZ8LSHvdUjBfYL+ut+CinPxjDXv/rhJkCt1qwSbluNoJdTfWw8C
         tYN66in/Hi3paJwvOvPSd0ZvGZvzz2t4vdJ7zMkyE/jvFL8z29s/pLtMrtTu1tSU2Jzf
         jinA==
X-Forwarded-Encrypted: i=1; AJvYcCV2jCyznfcRal9vfGebZMab1o+Olewjp1GA8BQsYmosku9UVhKdES3gknP0rCN4T6lPOZoyUlwiBrGD9gyGKjFquMgqigl6VUtBM282PC5gt+PwBDuROrJKymh4XKtCj4Lpdfcv92xvRal/Aw309M6JIgZ2hC5pJ8vzhPXGcnkmhLpKoAe2x/pRPnV/rIs5hes/lryLMBhQR/bN5zKfRyKXzwCzr9uH
X-Gm-Message-State: AOJu0Yy3K4D+S4sPtmRWn0vNiBMbkZP62FmXUDgtSEdbBwGOb3i9htj0
	B79MLeI7cGPSnwetSiUArJ5KvDbRNjcQ1mbWMBJgv9a9i9nR8SzWsj90RZ2O
X-Google-Smtp-Source: AGHT+IEtmY/Agm4jxas58hVUY3XHgbnfPH79M+tPQQDky2tF5cpLFO387l1IuKLpvOK9UVW4UKf51g==
X-Received: by 2002:a05:600c:a4c:b0:421:2711:cde9 with SMTP id 5b1f17b1804b1-42164a0714fmr104981655e9.22.1718107597450;
        Tue, 11 Jun 2024 05:06:37 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f141sm209315785e9.42.2024.06.11.05.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:06:36 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev,
	linux-xfs@vger.kernel.org,
	david@fromorbit.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/4] xfs: preserve i_state around inode_init_always in xfs_reinit_inode
Date: Tue, 11 Jun 2024 14:06:23 +0200
Message-ID: <20240611120626.513952-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611120626.513952-1-mjguzik@gmail.com>
References: <20240611120626.513952-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is in preparation for the routine starting to zero the field.

De facto coded by Dave Chinner, see:
https://lore.kernel.org/linux-fsdevel/ZmgtaGglOL33Wkzr@dread.disaster.area/

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/xfs/xfs_icache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 0953163a2d84..d31a2c1ac00a 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -314,6 +314,7 @@ xfs_reinit_inode(
 	dev_t			dev = inode->i_rdev;
 	kuid_t			uid = inode->i_uid;
 	kgid_t			gid = inode->i_gid;
+	unsigned long		state = inode->i_state;
 
 	error = inode_init_always(mp->m_super, inode);
 
@@ -324,6 +325,7 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
+	inode->i_state = state;
 	mapping_set_large_folios(inode->i_mapping);
 	return error;
 }
-- 
2.43.0


