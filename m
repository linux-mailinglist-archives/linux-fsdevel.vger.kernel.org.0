Return-Path: <linux-fsdevel+bounces-21434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3772D903B7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 14:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4286C1C21AB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53E17C9F6;
	Tue, 11 Jun 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCQCjnyl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EC917C7D1;
	Tue, 11 Jun 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107606; cv=none; b=jAIJK2F5YUo27vk+b/utxnWmKa+ghcPTDaicU5t52eNHjRiG8pfDDcb4SfJoYSjR5Nou0OFG4S1iQGXAviKKG4PdD5nxs7itkOPu9tERuqDVnyKnyMghR7LGeq5YvvgDwu2CPTsC+/T49+FATGd6leUojYohHAfz5L/I2bNweFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107606; c=relaxed/simple;
	bh=ufUXzSo3VNc1Yw6YK7C1iq2qUtbnpuulVMhXGED8cN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5fXSmaVTS2cHoPpcYnGV466nOXIxecAnbSGa8e6zovMva5ihx5FX5HWJnYF7P0Iv+u4mOML1LJaqVoYMMWfaIbr/HlQ1/vXNwO4QAA5KEaG7ravRkXs0lebzoeL0dyHy4FemZ0HNR8rFEbjJSScseroegcv3NLqTw4+/+fwNmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCQCjnyl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so47053405e9.1;
        Tue, 11 Jun 2024 05:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718107603; x=1718712403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osoKxcalEVuRJFuOqCaTQol01Qi45FmnGSU/HheJSwQ=;
        b=aCQCjnylq35Rb2OemlU49fJZFxwpYbpYox6QfDpAch9SeDlB4dd1EVRENdKWmtGOEj
         i3s4hhAbrtFpe5giQCIsOrrTlJRec5JaPTuhwXboCXsdf1qs6EHBS84BrC0jvn8WEBWu
         yWc9DFV6DeE5qpAL/WTay3OQos0Nxct1KFvjgsOLO/qOe3pXkx/MkjK43+EB063mX/5E
         dldtfPJBiejUa758SG/mFiZ6pwhAxNzo70JN+0OodX+6VyVBSMuINv/1xm2f5eqDZlb6
         xl2jBE3djsSHu+DonO/rv+jIN/FST7KXYvkgSEDsT/gWO6ttAXqzZTlq/N/mcnM8kLS7
         r9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718107603; x=1718712403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osoKxcalEVuRJFuOqCaTQol01Qi45FmnGSU/HheJSwQ=;
        b=O+y9aUs4GlKzrJey3Gi88LCHHGPwbxyqq+AAAxm/RVPauDy7fykS0thC7JNVwbfEu0
         5oU/3K8JUbIM9SFa5+B10AJW9iu0INsUWWW4F/nxko7iaUdo2IJV1AZL5r3igGAgdfLc
         WFjlIZG2mikElDDN6pbLZ9qqSk8kmvmT1M+Vgy/wVFzAGbcOEOmoVQRUrAZtCbcSortR
         0hlncvg3v6XczN5Dm1weP2W7w1XlqEp6eSEeYT+FT/UUmY+5qU1cyyei016p+l+wA7C4
         Sn4MQjJr+rjVA5Zrzxz5/iNTJaHggf2qUdvgxLtnpSLNjInEaDGtOC7gorRQJZjdg4x2
         eN3A==
X-Forwarded-Encrypted: i=1; AJvYcCW5Yp8+VwAtVlSBxyqLZXeL78GTeHmhxaG5sYzVchjcqne963o40qTUgM/JBEuJALBO0fhVXvFh65BLLcqkU0Zw8yJE67+x/ypdf3lCXQF/SQwHkZ6JnQza9sI48hqhmRP583yoEFq9l+i6lWjn7o5Sz3spXHZ6CzJ/1GBZrlsSWi5RV2xb5FPyBx/nmLYTn3gQJn0Z8gJ6cze9C6l44PGswHh7XYwD
X-Gm-Message-State: AOJu0YxadQ4gApvQlPEx5+st3x/oqxd5kkKOu4vcYLwwB6ZXxbghCXxc
	5qq1Td1JJqy8zdgBmBuheKbo4tFQ9JMYZJ6PGRpEGKj0KsYDK5I8EJeFGrQP
X-Google-Smtp-Source: AGHT+IHMKkF27btVhL+Q2ZakKFCmBlBzPJIwFDwowAOUBo13JONA4RymmGK8rX7jF1gvI5caCVEWBA==
X-Received: by 2002:a05:600c:314b:b0:422:6449:1307 with SMTP id 5b1f17b1804b1-422644914b4mr11136665e9.32.1718107603309;
        Tue, 11 Jun 2024 05:06:43 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f141sm209315785e9.42.2024.06.11.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:06:42 -0700 (PDT)
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
Subject: [PATCH v2 3/4] xfs: remove now spurious i_state initialization in xfs_inode_alloc
Date: Tue, 11 Jun 2024 14:06:25 +0200
Message-ID: <20240611120626.513952-4-mjguzik@gmail.com>
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

inode_init_always started setting the field to 0.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/xfs/xfs_icache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index d31a2c1ac00a..088ac200b026 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -86,9 +86,8 @@ xfs_inode_alloc(
 		return NULL;
 	}
 
-	/* VFS doesn't initialise i_mode or i_state! */
+	/* VFS doesn't initialise i_mode! */
 	VFS_I(ip)->i_mode = 0;
-	VFS_I(ip)->i_state = 0;
 	mapping_set_large_folios(VFS_I(ip)->i_mapping);
 
 	XFS_STATS_INC(mp, vn_active);
-- 
2.43.0


