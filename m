Return-Path: <linux-fsdevel+bounces-35658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFC49D6C92
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 04:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF434281631
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 03:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5E6282FA;
	Sun, 24 Nov 2024 03:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXuXoRT1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8110E3;
	Sun, 24 Nov 2024 03:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732420006; cv=none; b=uBk9EWkZezBPb5e9/s6MkEgxSQB2951QrTPv938nq6TFoW4tLzg3U1VIto3vWh9pOsu40wetRkmVEGcnZL91PPm9TgTfkjGs9DGZYQH1czmtcG6F1Qavf075vsqsERNgo6fGcqxq45Z6K0umhvUf7UtjQPiVosUFXVZTnxQsmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732420006; c=relaxed/simple;
	bh=4OWydb0uad+cSg6XEwN8/7A1yX2vzbSXD+Cg2vpFN7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFkNpbr/zTcTFLKF8861CeYlvigHtdUKyrMhbmYgejEv5eOrgpVQFBM24YP67HXjdxNU+SUV/nWzjsce8j82brESLcwtY0vNCDCHGPlhoIMcv7xoUDcNMyIo2MydLUAEJhnz1T7FIst/+Yqv5oB8duIcyGBZJQ/0xBELS6WjUUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXuXoRT1; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724e14b90cfso1547523b3a.2;
        Sat, 23 Nov 2024 19:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732420004; x=1733024804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRKUntj3FsK+vGHd9SV+LXgOh6pOpY3AJO079Y2j5WQ=;
        b=FXuXoRT1GWj8lzIRvlGcGh1Sm6x+cy1HCLd24z5ZbWY+mZQGNIrF+rRU0rPbWIoWYw
         qdqGiiIhicyjB3bNdRnxMR3IpFB2LK0gqBEcCOTDzVmM49aD/JE3brcH3k7X05DIu2ZP
         +RphpHDIrrAuVPy1zsEhzBa7szp+2fuDdvHDMrNQzZ9haSx27QUQlaI7ORc5wKdP0a/K
         XtLwU6z4QyVme4+M8BXMFubMz5+fIniwy+/6H0ICFtvHRYLrhTeJeO4xsV7C8iYmhYJb
         6zBJka/mYewG1pSvS30uBL6fuNw9mQHhy5H3aQ6W5BLpwcFD2MG927yFbSzwZOCJvb67
         2UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732420004; x=1733024804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRKUntj3FsK+vGHd9SV+LXgOh6pOpY3AJO079Y2j5WQ=;
        b=i9OxDQVw1tt+aEaRbNnIlARHXhoEX4AeQjyi97tqPNS0B/75ZUbgD513MdLB6JvAAx
         691Z9XgDxA4ahrDxJ5pq0Bo29QWbjGLAY8sf71JlqEWeVN0ZLzyy/GadtReYaro1jfVG
         bC9hS1HdM4ArSDZlU4RUufgL1g2FkOxRKfc1Xcn+Y59ieBTkQFV4NdmzC+metqy3wpNh
         WNqeejLiMDuffAH64APWSDhdBJJ2jRg0+1SxelFp/oWvta0ebLpo+y09C5C0mTTa8MMG
         HEHdlrcFtJqKCRwcWv95Y1lIS/JrOwpzAJ5biL1TeKxuayh4xjGN3qhWETOrV3J8u8yL
         8swQ==
X-Forwarded-Encrypted: i=1; AJvYcCUja+DmdQrQLgy8hTahtsQNytkriH2BmgBehlXni2MWGPITANsCQavcAh2OCthnP3WIK8WMr0R0T0cnkyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFPkzStKm3ZD4+GYXxuEykz/ioN/IGvUXyE9spWgI1MUZE9Sm
	eYu/n33LIZlBEnOftofNxy8d90uLqB2eLrhUGKhYN39Gdkb0tbYX
X-Gm-Gg: ASbGncs5Fql0RpvZxAvYnHEX7U4E3/70BwAZRZONBC9MXyNHoPrXdo1li6ovi8ZKDOc
	TPGFcePTd6pGChrvW85/uJRK75O7qoLwpL4+3g/EIPSAjVTBo8gDO4Ttj8hS3eEtAvE6yUIf7oy
	//UcZ1l+8TVdYk0Hl66QfXeKHDQ5zfzKfysYLoxKqHKH1vfksv6poy46v71Fd9PabOCDejKJ0j9
	PoVV/BLJ73Q3qq8viru4BgY5CliqNNlb+TgC/ih4/+DAJRSmkWl5eibJpjUBcTkTA==
X-Google-Smtp-Source: AGHT+IGWUhyHxJw2GTBVS8wlNIoRKldDZEJ375GOA+jsgLyxqixCLrsZZxBLJKqoDI/MNjeYJ7KA9g==
X-Received: by 2002:a17:902:ce87:b0:20c:9936:f0ab with SMTP id d9443c01a7336-2129fd7044fmr113255335ad.47.1732420004120;
        Sat, 23 Nov 2024 19:46:44 -0800 (PST)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc12f22sm39789455ad.186.2024.11.23.19.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 19:46:43 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	adobriyan@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] fs: fix proc_handler for sysctl_nr_open
Date: Sun, 24 Nov 2024 11:46:36 +0800
Message-ID: <20241124034636.325337-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use proc_douintvec_minmax() instead of proc_dointvec_minmax() to handle
sysctl_nr_open, because its data type is unsigned int, not int.

Fixes: 9b80a184eaad ("fs/file: more unsigned file descriptors")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/file_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 976736be47cb..502b81f614d9 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -128,7 +128,7 @@ static struct ctl_table fs_stat_sysctls[] = {
 		.data		= &sysctl_nr_open,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_douintvec_minmax,
 		.extra1		= &sysctl_nr_open_min,
 		.extra2		= &sysctl_nr_open_max,
 	},
-- 
2.41.1


