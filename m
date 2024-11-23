Return-Path: <linux-fsdevel+bounces-35646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E34F9D6AB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 19:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5CF161946
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA714AD20;
	Sat, 23 Nov 2024 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWPkESJX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347B2AE90;
	Sat, 23 Nov 2024 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732385512; cv=none; b=LyXAsxz6i1fpYuHC8XwjaKAzRDLJSXZhG/VPJmt5WfyIkzJfOZwCoQRdTArlH88Hw7l9P8Bx/y7W/gPUU8JB8l69bLFuCIIgGTfpw9rcJBi2zK9NFbo1weZQBTYfnZIwgk4Jl8NUYOFSyybqvIGA4kYe8hR95hA31LVgLc4gUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732385512; c=relaxed/simple;
	bh=6Lkxdcvm3/ZmAjlL+//suKh6QLcBqL8pEISGSo1cVUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZ2JOkDo7UrmGMDQIZiAsMrBJTDE+JvONb/FNIooe9S6bsThXI7rp9406I1MWMH8KvJdR0RMFTK+i1+xdyLZKspbh0dfmL8DXVjkjXgj2oVHq0Iwpi0TrWsLAhH6XipwMkcFMWWz8LsYsyHjvukCwpUWaeJpym8bKKb4e7smIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWPkESJX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21285c1b196so31316965ad.3;
        Sat, 23 Nov 2024 10:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732385510; x=1732990310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCmWUQINcg5l3Cgf2L+6a//c0M8qj41ig28Jyltnuf4=;
        b=AWPkESJXNMlMwwViPTi7eh5BR8XNsVosYV1/KY22iBeoBK9o1pYu+xd+bV9H9TXB6W
         QUBfIXloOYK0PHIRQKcjIy9FN1jn5+4xwqqvhmzcXcS6T2IkOV+RlqZckFj39D1IG1zn
         PZV3ORBAn1s8Bo/pMJZnnNBgFbRhYa4mg1hiy9vLo9ZDdTRgmNMsYoJjAYJgzYyh0GwK
         TNHeQJbZOunJGOMEQ5a3L5w7Hq/6oqq/SttpRsUYveujxiRGI7ZFnqUv/qvDb+0hMqcm
         ezKG5ebZ//uvMdoFlWz/iHDQIEmObs/SGcLP54i8MSrV+sPlMd0KgKpntE+nNSkru0lq
         Mj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732385510; x=1732990310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCmWUQINcg5l3Cgf2L+6a//c0M8qj41ig28Jyltnuf4=;
        b=NjZPg5HdWDvHbWB529x4TywjYF2ExBeQZ+5n7nughltbH2OFk6zmADQAYSklA1kXEA
         zEP5JYj2AQt74QJCZS3co+5vPUTaLmTfoX00LVWFrRdy3IMcZXUPANHZ0fQaN7dq3q8m
         d38Ti5givI6Pi8bpCEmsya5f1/2+Zz8UpKRDTzFMdT7P2njbQp48QeLl5O9u7G2Gc00Y
         4S94xnRu9Ci+Xs+ExMnpGuS4pZzAh+F1TPJnwQYywdXrCqm8PQEk8PYyJrDsShdIF9Np
         xdZtCfWkYMbSoBUQ0pqt4DG6vXjDjEWXdQj4Rru1soDUDBaK399PpOds6NFzDGujDOoj
         kIcw==
X-Forwarded-Encrypted: i=1; AJvYcCVx1kE0fSqQWUCNHrJxDN3JMjuOmBIHCIoVD5lHZ/bhvygaayaCE0NHn5AfJSbxt5A9YaMBBBLtGkhPunqp@vger.kernel.org, AJvYcCWPzT0pZHEAjJlBpWf1P+byfQdPhcx5K8IRC/SHRnE3cnmxbjEEamKJICaDZbz2T0AfwUKkxiawXjsEmgtx@vger.kernel.org
X-Gm-Message-State: AOJu0YxmTTsAzCq2qbdI9dLzTpD32Edod2cFSHb7loCbRsZf7F30yePP
	dEtUINw/L75UB8JBbqgO1Kfa5Z8V5J6oqIPX5/vRvMLF9updeifY
X-Gm-Gg: ASbGncus+iPA4wzTeTO6kLCnIlmcW7dPpv7zjUh/vZQ+e2O/rVBhsnNtd8b6JaaIKSF
	V6060erEmjvgC2IWCgvUg90Ufl7ac/50VDwOIQnSiwUBstVdU+OYpDR7M7LOXfcXFcadC/joesa
	BzHNLkpZUMYLiHlBL5YQvwGT8AaxQ+5I332N9FljflwR/VBsPuusvfTYm0dfv37AzLXUuKnqb3R
	F1+bBocqiUdl/XHy+cmHJyO9bkUjwwxUGoVeYAomOV29x4aMqev+ceMmjRYeVm+Jw==
X-Google-Smtp-Source: AGHT+IFOmL3z7QsI/HxpFfU6TXZZCU9ZEbUdhUtFEqpEdw322/gxmm1e6D4TXoJ+iqGIuTiRKOS6sQ==
X-Received: by 2002:a17:902:e843:b0:20b:a6f5:2768 with SMTP id d9443c01a7336-2129f65c738mr109443585ad.10.1732385510490;
        Sat, 23 Nov 2024 10:11:50 -0800 (PST)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e0fca304sm3359333b3a.175.2024.11.23.10.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 10:11:50 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: alexjlzheng@gmail.com
Cc: adobriyan@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	flyingpeng@tencent.com,
	jack@suse.cz,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH 2/6] fs: make files_stat globally visible
Date: Sun, 24 Nov 2024 02:11:44 +0800
Message-ID: <20241123181144.183326-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <20241123180901.181825-1-alexjlzheng@tencent.com>
References: <20241123180901.181825-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/file_table.c    | 2 +-
 include/linux/fs.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 502b81f614d9..db3d3a9cb421 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -33,7 +33,7 @@
 #include "internal.h"
 
 /* sysctl tunables... */
-static struct files_stat_struct files_stat = {
+struct files_stat_struct files_stat = {
 	.max_files = NR_FILE
 };
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..931076faadde 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -89,6 +89,7 @@ extern void __init files_maxfiles_init(void);
 
 extern unsigned long get_max_files(void);
 extern unsigned int sysctl_nr_open;
+extern struct files_stat_struct files_stat;
 
 typedef __kernel_rwf_t rwf_t;
 
-- 
2.41.1


