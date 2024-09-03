Return-Path: <linux-fsdevel+bounces-28425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B6096A216
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482291F2219E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8088192B70;
	Tue,  3 Sep 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H4ZFARnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC518BC36
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376640; cv=none; b=H+lOiEB+8NyDYqJRb/PBfxC95UeTIWu22Py5GaWncUMYOzJGD5B8LxH0ea+Fuc/f2ok80Yx/WjY1BNofEHAwEGzyNKv3LL41m546Y4JdACmNwJO2emNUvl0l0WWNRLL6ybkNQIwIVWEKU9l7aEBs5GguTWIGHuzpPe3IxoPxVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376640; c=relaxed/simple;
	bh=fapDmbcyv3OV3L5MVJ0ESyKv76DKH2gIdDF3OBkCKmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+rMk+IOmdObYZfOrxIa9Weupnc404tO+2a5Cf3+h8kjD8YGsTMqJE2TSzhlBbZoFiyeZBBDeEq8zhm1lzMwyAqizevat/1JbW1uidcE7pUpxV4EiR38JTQTFffikBMcwfs3wS90weFYkXH8NP2HbhRyMvH1RJktWs3CA5wPM10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H4ZFARnH; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A863E3F17E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376636;
	bh=GKlPAS/yke2oPrCeB1Al+EppMQBQKIKtDOu8hv7kn/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=H4ZFARnHvMUb3znZMjPpYmHQhTNQaF7qfl89vPcE1bVCOdNWksqhpeHu979HCgLa3
	 hhTkEBfRhJ12wtq4csPXmJx1zFFXDdNGeYXoAXhthw7rFOZ4ciXrbRYElocZmloApG
	 9JDcrIKVywSuV6ZA6YegcYEjQjNTFYB7PBB2IZtWllnSq9za9YktNuGwdqR9mvHlwR
	 shhrQ8pZJNPIi9kXLlrR+z+q3FAoYUKkMpGfWF34vLWi9IkJ0LCrd/Ec3M+zWwlDcS
	 nTaQl8LQtzTdNDmR9EB6N84SFUdhywXq0Et343T9JE9gIqrXyMA4d/WZbLLGX28j6K
	 LgDvqMzIDZMpg==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5334af2a84fso5906489e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376636; x=1725981436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKlPAS/yke2oPrCeB1Al+EppMQBQKIKtDOu8hv7kn/0=;
        b=CAOeQH/wmhCAWP1yzH9Blqn32KcqBxF5+1qZEMZS4vRBgI10BX73ToPIj0T1lcpJfw
         TMQP/ShrO+0Br0FFwVAMRRqJV2PeYAaYP9npPRbzJP+0qBQ1caQyeWyzZxeieR+6+8f1
         Y8WWjMl8RXNYu+wztm2xFK7hbArkOXo88ovZn5p6BmervLYVRe/toJwkTmEeyUxo85hb
         JzGOcrZLpmwWC98H8ijP3qOIPVTKMIeyd6159gmptWFUx2bAsOK7OA83ggPTW6kyLNzM
         dmVinJ1GYJDx+6COY1lMpdMlWA9mL14YmUgzg6nMaMw2YyA5c1ijp9F4Mq2ETJMv/UZa
         m5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpDcXeDFGcrjWBfv2xcEwWURdf/HFyuha1103kJl3WB7DGfr26Gt4I3GasdwcTtUeJKuXjd4MRFXaV3m6+@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQQk65QhmIZVLrPnY9/l4Azrt+1RpN2BFyXcETlzSdVxATwMd
	try/Dt/u+MYJ54BPl5USPXvSuhZ4EezfIsbkXtqXghpOfb2MZpfSzp5jZQzQ4dBP8D6k7YfTccQ
	p29LGZweQZzkLnwnVhcQnyNRgSu5jFxw4Tr3058t6kLgYXmGTeGFRPQilh3OOW2HdTKDA4gUY3O
	VSsDo=
X-Received: by 2002:a05:6512:238a:b0:52c:e1cd:39b7 with SMTP id 2adb3069b0e04-53546afd6d3mr9430364e87.5.1725376635828;
        Tue, 03 Sep 2024 08:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7xyi4/WNe4j3fu5EFB8IE3ilwNISUZWJq2BDcXmtXsVDh9f1cWld/tjAcEfAzJ5I9AOVJcA==
X-Received: by 2002:a05:6512:238a:b0:52c:e1cd:39b7 with SMTP id 2adb3069b0e04-53546afd6d3mr9430338e87.5.1725376635314;
        Tue, 03 Sep 2024 08:17:15 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:14 -0700 (PDT)
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
Subject: [PATCH v4 12/15] fs/fuse: handle idmappings properly in ->write_iter
Date: Tue,  3 Sep 2024 17:16:23 +0200
Message-Id: <20240903151626.264609-13-aleksandr.mikhalitsyn@canonical.com>
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
 fs/fuse/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 06ff4742ab08..dffc476f0bf2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1398,6 +1398,7 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct address_space *mapping = file->f_mapping;
 	ssize_t written = 0;
 	struct inode *inode = mapping->host;
@@ -1412,7 +1413,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			return err;
 
 		if (fc->handle_killpriv_v2 &&
-		    setattr_should_drop_suidgid(&nop_mnt_idmap,
+		    setattr_should_drop_suidgid(idmap,
 						file_inode(file))) {
 			goto writethrough;
 		}
-- 
2.34.1


