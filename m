Return-Path: <linux-fsdevel+bounces-40957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED82EA29937
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852D5167ADE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233871FF1A0;
	Wed,  5 Feb 2025 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJgGpnJD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71271FDA8A;
	Wed,  5 Feb 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780774; cv=none; b=TNYPmZn9qCq+bV2J4c2Go6yD8qGKVol7fHNCgur8abBt4b+OK9CswTAFKcUbKPuWoZzLr0d3+6gYErJcZDsmsN7JwIRwIv5zydFPhuJDEBHGRvtNeK53yBxu2Ruxd68qG3+m16Xqg1MhQQupY9fWW9/AQ0E5YTLfRrosnubXXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780774; c=relaxed/simple;
	bh=bRUlejGEGlOKYyMLYwvpf5XPGRxNpG6/HZPz4M6+sv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPXMmwAwPI8nlE9b5HjBu8s/3fAXCyIvcPcPBZAt+9ZKy4eKrQzOLTBKktSkprh2XkyPe1DR+k45GAemnE3tNDc3Oj6G6q40OXkI/Ph/Wjz6sdDD8qq6gnuW2gK/I2kDQZ7kGB3kRt38ohGmB9V0UWhtUVstuemj4rt6lx4++fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJgGpnJD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso25848466b.0;
        Wed, 05 Feb 2025 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738780771; x=1739385571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovbDDbSveRTy+fPQhM6VfIqm+xZzW5GRhorVK9U3W4w=;
        b=gJgGpnJDZqe7JTH1CC012jPpL/UPtgeqqWv2EZs7wDr1JGx3+Or8zf6vkJsHPgF2WC
         0XnL9tZRS4CICVE0qEJltKzkN7B6Zdc1sHsJG6JpGaFPFalBJDqUVnsm5RQM1SOUDRv6
         cpxuYJfvIX7TnXI6Wfq+9nM9UfC85RwozmUD4iMXjjtWGwyz8Gd7PuHqpESBB+/LD51J
         IJRPOMwQp4odjjTxrBbelMybZNvzqnP5CuIsR3IeoGfnJvN8iWBiL8KmfTwRpjubQwua
         RCHhzzlk9Xa9T8Sk9btQ2td1/flhZ5PExQ9ELkpArOHFGXf9uoRGzU9ox3PqOgfCdoWS
         AykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738780771; x=1739385571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovbDDbSveRTy+fPQhM6VfIqm+xZzW5GRhorVK9U3W4w=;
        b=Y9u5i9AGhxD1TWq6LEZBtqyHMALulcPmKVpQnjEZGk/kQD7PV10pORDqDl7qEST8Ed
         h7ITv+W5l4sHfzvKN3jprIsO+YG3fYleQdY8vfOC/vuByFlZ1q5xxKpRO2CFsaGTGF4L
         PvKBzBAvdRccI6YMETB2RAC8J9ATNNQBXSP6OBsSy1ZH/0ClL1w9KTobUFjiZ8TKG6gZ
         3wRA0Ey11aUk2Z5WGLIpcS3UMjrLmzEONQLf8FlLCUyuPEvlHaa8a/eCizmYioDZTEUc
         2CM/ec3USw5IEdhPktCevMF53Lc/HmZh544EEw3gHiFag+ENvOGQulq+XifyQImPbJ7A
         xQWw==
X-Forwarded-Encrypted: i=1; AJvYcCVWYbm4h1iw6GF5hN17iJqQMKMmpWP/IIdLmeC5AUwe9XK3l3ihuTtCnWJjPZAGbliRdWEheFFv0E3bZHV4@vger.kernel.org, AJvYcCX7WmnmgpVZ+9Xiph//Y9FZv677O9I7g/Rr1k27WXz4kYB7Qp2ypc8b+0L3tz0rmZk72Pk0hWoO7wN1F0SV@vger.kernel.org
X-Gm-Message-State: AOJu0YytdjpppgNqK7WT4E4SOsDS9uYebXf1FkTXx5kty605y9KYKtfb
	IorRnEYSBU+7/jxmsdykbj9Ilc3qQBmKO8tv31Uhm1Wrpz3tq6HA
X-Gm-Gg: ASbGncsUPBSd31Ue0sAaTDF1TLxIxnwAzdtUJ8KW+bjP9+WycHGdD52rhNsD7KpVgrz
	jYuC4uoDi6YlzI5rnCUDvgUUkYl4XMxpqQZu4yablaZdGmPkle2CwrStfS7Bh7/oi2q/IFXYmAl
	KhLrWX1fZ8VNf/bq4dqeu+1vhDHv8VVLP8iixEZU1AZEwQ4TaRVAHTmylkwBpZhq/ZVV9w0vdkY
	EPRHX7J9kEZeg8HSUfn3n88FXQp5iSA3ziIZDO4jZq6TYmKldzXrYhjUpN5yLPZtxD3vd1RI2sE
	ONAlwsXgw4P44zf0S9+UQ+EQ2WzmauY=
X-Google-Smtp-Source: AGHT+IH/lAQ4JmIsLg5Kneevr+mz6fuQbFZKOYpWgrG6mPJh95LtMdgqJ2RE4t6pClscQQmyFv9WsQ==
X-Received: by 2002:a17:907:8690:b0:aa6:88c6:9449 with SMTP id a640c23a62f3a-ab75e239328mr337003766b.19.1738780771030;
        Wed, 05 Feb 2025 10:39:31 -0800 (PST)
Received: from f.. (cst-prg-95-94.cust.vodafone.cz. [46.135.95.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47d0fa3sm1134082266b.47.2025.02.05.10.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:39:30 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/3] vfs: catch invalid modes in may_open
Date: Wed,  5 Feb 2025 19:38:38 +0100
Message-ID: <20250205183839.395081-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205183839.395081-1-mjguzik@gmail.com>
References: <20250205183839.395081-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 3ab9440c5b93..c2822fd94a8a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3415,6 +3415,8 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
 		if ((acc_mode & MAY_EXEC) && path_noexec(path))
 			return -EACCES;
 		break;
+	default:
+		VFS_BUG_ON_INODE(0, inode);
 	}
 
 	error = inode_permission(idmap, inode, MAY_OPEN | acc_mode);
-- 
2.43.0


