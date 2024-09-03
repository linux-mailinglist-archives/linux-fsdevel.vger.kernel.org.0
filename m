Return-Path: <linux-fsdevel+bounces-28427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A3496A21A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDD31C211D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665181974FE;
	Tue,  3 Sep 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tANZBw5B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1FE194A74
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376644; cv=none; b=RliGfm7xEVIQ74uIML0hjXGre3++/HAB5FpwpSQkMxow4UOB+NCZ8fbM05a4p9cGr0N2xfLtvrN8Os2zxhWlQPl3mSMwV7vUhfaHNJwguTo6eun9EBWMrGO78TR70Cfx9bn/0C4/dvalzMAQuRQj3mJm8xwspO7IYUtkAbnb0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376644; c=relaxed/simple;
	bh=n1q/EIb8QE/gzlW7TGaoEUxhlzstWKJksL6EQ5xdUDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GQrIRc5VvAWTX5CJc1vQjBTi+LGHyZ2vZI35aZvhxPsXt3Llym+5aCWIVCz4KHRE+lUVSb/pDnLkvy62fbJH8DQrO9tUc66Qx69vi6KflEtzgvTtNvyB5UzcuMkOiBA4OW+ceqprSfz713Hs6S4/JPX5ddSHIMd234+ur3Ffhzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tANZBw5B; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 214433FB55
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376641;
	bh=q/dJXF5eC+NKzBxw8fqNSmpQ4hPcGmLwxIIccnA2zek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=tANZBw5BR951V0tjNwoKsuCYGXFvAADclmIOKRfh4mAc9V6XqygI96+/3hwQFfqVZ
	 iWK3AP1xGmUHwSi3ubmPRlMQM9OvTXCxoujZz+k3lQrZZyRjFZZSVVN4DFqchMYsYC
	 RFifrzgq/cky5RMbsvQjz6Fd8FhGx6LHgz+BgjZ+PzEnkh3tLvi9gFi1y8EWxce/5/
	 MgKw9P30rpfXNhQkrUL/y6ZLwvhULr4q7jiWx+EsGCj6Iix1RGrVBpNOuDKQIZG6nD
	 jk8Zie9OAU0KNPlBd/DvoFqEeF3i8FabPTGLlu70NvpIxaAmUtChH6JZy28RWzxcsM
	 2zB19K9FqQYGQ==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53436749138so5964769e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376638; x=1725981438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/dJXF5eC+NKzBxw8fqNSmpQ4hPcGmLwxIIccnA2zek=;
        b=dt7bAownsI8vapmIVTcAR9otAD4Nz6x3B7T9B2wCui2/Pn5HSzsxXNppeXWn5+MKwG
         ONQJEEd5X7XJKPUi1WGdOBuTFZ8w9R6FCW5Z0DpANbkR+/E06H06HJFqGaLny5+fT0/U
         bPW2EuOl9IIfa3bi8L2fAG09cf36w+tsuEACmm6Ok3VZBgVYO99o92Pft/VxBsOj0/Uo
         OZLvHhzuyG9rwal5mNcbhxtLJbv/4n0SR2XMsQMOAsKEh3WHWxoL0VpK7ZIRdAEOyOwI
         owgQFKSrMuMl+6MYAal4cSrj1FAVw907kQAB61mkZ+949seGNYoFfUdCyVC4j+YMSFKF
         IwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1umaK3X/hIJybRIjCnW88ufthxKb5aUvMS5TrLEZyOIbFVhyI0BiVf2sEKB11sDVfAzk8uAMm56xBTdLQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgMjxzMQbbAgW9xS8OQGPRfUstzHDFKsGmpdUe7j09+rVRzJ9
	Jj+uFgfj6fwz9VwhcSGiNKKV5Nuei2fyUoQ4EfIhMaNRCaFiBhdAtGmu8Id3iGS6m10OmiPV6d7
	4FvhHvvlYcux3De0Q7tRq5RdxeiDBJ7rXycWnBSD210Kgfx6k698cJjJKPMm9eYEW98VnGxujo3
	1DAN0=
X-Received: by 2002:a05:6512:12cb:b0:52c:8979:9627 with SMTP id 2adb3069b0e04-53546afaadamr9026103e87.3.1725376638412;
        Tue, 03 Sep 2024 08:17:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGeAr4W1tnViv/aJ8AvVT1RQIyOxpEgki6TmTjrWHhDfkxMRoGBh6oqad2TrUHYX4xemgG9Q==
X-Received: by 2002:a05:6512:12cb:b0:52c:8979:9627 with SMTP id 2adb3069b0e04-53546afaadamr9026067e87.3.1725376637915;
        Tue, 03 Sep 2024 08:17:17 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:17 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/15] fs/fuse: warn if fuse_access is called when idmapped mounts are allowed
Date: Tue,  3 Sep 2024 17:16:24 +0200
Message-Id: <20240903151626.264609-14-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not possible with the current fuse code, but let's protect ourselves
from regressions in the future.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- this commit added
---
 fs/fuse/dir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d316223bd00b..dd967402bf12 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1473,6 +1473,14 @@ static int fuse_access(struct inode *inode, int mask)
 
 	BUG_ON(mask & MAY_NOT_BLOCK);
 
+	/*
+	 * We should not send FUSE_ACCESS to the userspace
+	 * when idmapped mounts are enabled as for this case
+	 * we have fc->default_permissions = 1 and access
+	 * permission checks are done on the kernel side.
+	 */
+	WARN_ON_ONCE(!(fm->sb->s_iflags & SB_I_NOIDMAP));
+
 	if (fm->fc->no_access)
 		return 0;
 
-- 
2.34.1


