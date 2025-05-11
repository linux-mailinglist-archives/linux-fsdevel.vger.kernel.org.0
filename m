Return-Path: <linux-fsdevel+bounces-48678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A9AB275E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 10:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF5E1891F4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 08:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248CC1B4247;
	Sun, 11 May 2025 08:50:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267420EB;
	Sun, 11 May 2025 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746953415; cv=none; b=E9sv1OOC7so/9iLqoMvR7k2FZwk/H06Pzrk+3EvnZq1rE3oEagDVOEiBas3riuZ5NbnhcLYEbiho29/GNVqH06M3XzIYImujYF/1qX31SJp0F9icKKkmneWkP6IHkGIupUofRKHE5hWy3phUv3tGOpho80nKYuTJOD6AGokmWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746953415; c=relaxed/simple;
	bh=YzaxZE3obfzR5X+cef2H1Ab5k+OSzZvDKAW7QTUvOV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IuRuIjlK93hmYM/e+TCzXqKgLWhjOpAFYa4uk53WJp4eVYbHJreJWh77pJdj9s9Bp8Xyyd2FmZIfijly3TCZbSYsEGYpfSyv+8o9y6orvr6pIi1uTN2HX5XRTfD80MXyWpmhMvDo/ukmoxeT1jZc22xBbXGbivlgBhlaw5gpzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f548a4ea4dso37465126d6.1;
        Sun, 11 May 2025 01:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746953412; x=1747558212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wgh9eGWwH28ncq3Sf3OtzHZE91t3F+dGv2JlFgovzRQ=;
        b=M1XkW4NfZGOzK6o0ZJa/lSv5sA3F9RjUH+6W/YE5iwo7uuZ5B1TjHaFVRPBEU2pN3T
         ZcXhpBxw6MpK0cSomhcH/PV3jAgyaK2t47P2dH0vUAzbuKNKtqy1V07p3h33Wett/u6w
         SBRhXM4kMQKychmrMnNyKdPRYqcFnrlATHbdDlAmOS5frVfwfVM55pvCZw5Rs9URBR8l
         SJazGQy+dPUNIdvtfgsgryYL3TVUSBGosCrQEPWuu1Ovtv8nKjpuWpw8rE1P9tpNAjeJ
         G4cFptHADfUOBcUGvYUrFSFVz5RKzmROsYf6XHLl5tH/LdJIqRgkniUIcVye4TSHyuR9
         mfKA==
X-Forwarded-Encrypted: i=1; AJvYcCVZMiA7QZpVTlcfddEQKzOF1ToVJShcIU0UaQieATr1HjAX+pRR2zqcrwmWB8gn3c2M86VNc0fFBfEZsHTO@vger.kernel.org, AJvYcCVvCoMPnBMsItX3nL0d4xRbajm2Cy++ngmC1rFFLiYmiwukOVJLqTB2CYn9lF+Zmvk/QKQGn2BVn4KYiiM7@vger.kernel.org
X-Gm-Message-State: AOJu0YyXD4VSD0Yjsjhd0CVobv7KLks7nN9HAbuYgYPXW/9v2URHCRNp
	U2hSR+6eB4uL2PbhYq9zBWBECFKwMXygf754zRWftQntE01QI0iOhvdhG72eRHM=
X-Gm-Gg: ASbGncu8yfQiE+J4rKGVz4PhKxSE9vjdlj36IVZ6dxL7x8JTVWuF1NFkuAmYs9gMaUw
	pwUtdMoAMDhBCtUprPAcweN6ZrTcneLSpSYx8vE1m+uaZ1sDgH1J77skM45usQWHXwlHTbyvV0+
	W2NhX+P9cRByCrTad+jIqVN2bJ6kxN05pU+Dpv8DpHPBAgUSd0808eDA3GlizWCIZF1c5UX2xiM
	ApzP28hO7ryzg5K6mgthWJsGYtjLBQ1aChlVov6v172Hw+YcN7HCeseiSaTsxMy/EVcJZY74UnN
	tWfEA/XiVDZM8uhxc7xgFRTDMpJbeu5dYuqNhmC1X58cZDfHopLyRKJI8atpIXV6SnS5LPgSAjP
	U84uKMgx7Da0=
X-Google-Smtp-Source: AGHT+IHg16bdbQEQy7TlOSP+3fWI6T7qV6TotEC80RgZwXssvRK5WwDsYGbzTLBdo9zHqbnqMsWSxg==
X-Received: by 2002:a05:6214:e4b:b0:6e6:68e3:8d84 with SMTP id 6a1803df08f44-6f6e47bdf02mr163805026d6.18.1746953412500;
        Sun, 11 May 2025 01:50:12 -0700 (PDT)
Received: from localhost.localdomain (ip171.ip-51-81-44.us. [51.81.44.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00f4e19asm369861685a.4.2025.05.11.01.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 01:50:11 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] fs: fuse: add more information to fdinfo
Date: Sun, 11 May 2025 16:49:01 +0800
Message-ID: <20250511084859.1788484-3-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit add fuse connection device id to
fdinfo of opened fuse files.

Related discussions can be found at links below.

Link: https://lore.kernel.org/all/CAOQ4uxgS3OUy9tpphAJKCQFRAn2zTERXXa0QN_KvP6ZOe2KVBw@mail.gmail.com/
Link: https://lore.kernel.org/all/CAOQ4uxgkg0uOuAWO2wOPNkMmD9wqd5wMX+gTfCT-zVHBC8CkZg@mail.gmail.com/
Link: https://lore.kernel.org/all/CAC1kPDOdDdPQVKs0C-LmgT1_MGBWbFqy4F+5TeunYBkA=xq7+Q@mail.gmail.com/
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 fs/fuse/file.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 754378dd9f715..a34fec685d3db 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3392,6 +3392,14 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
 	return ret;
 }
 
+static void fuse_file_show_fdinfo(struct seq_file *seq, struct file *f)
+{
+	struct fuse_file *ff = f->private_data;
+	struct fuse_conn *fc = ff->fm->fc;
+
+	seq_printf(seq, "fuse conn:%u\n", fc->dev);
+}
+
 static const struct file_operations fuse_file_operations = {
 	.llseek		= fuse_file_llseek,
 	.read_iter	= fuse_file_read_iter,
@@ -3411,6 +3419,9 @@ static const struct file_operations fuse_file_operations = {
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= fuse_file_show_fdinfo,
+#endif
 };
 
 static const struct address_space_operations fuse_file_aops  = {
-- 
2.43.0


