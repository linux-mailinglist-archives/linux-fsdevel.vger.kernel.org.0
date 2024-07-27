Return-Path: <linux-fsdevel+bounces-24361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A22B93DDA5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 09:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB617283BC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 07:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A827538DF9;
	Sat, 27 Jul 2024 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b="IHpEi6Zg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BFE3612D
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2024 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722064976; cv=none; b=D09vNRWvOEGFcGg59464x3x0ta7txlwLrTWZj8FwjSR71fuasLvpZgJtCYVyv+vzXlKEl5oQYuGHK2z4uIxmciIeZXc79nkDL7GZnus5cgShu6n9SqM7lsWXtLV6OPMnZKWLMeQFmF4lWNgNXDp1CeTVCCfyocsaPW7wMWLKWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722064976; c=relaxed/simple;
	bh=/oV/zbGDKKiElb8p0MX0ZIo3k5eYk2ocCAxjwwHUZdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYhuDcWovL186nHxKMFejJcfyAfEyqxqkPimWc8y8ugIV/WfObKU5ByRQU/zlAGLY1SmQ522TlRKCNn6zvTghX2nY8V7QH1MwPl92BC+GFN7+n4AHv3B3ymmYxR/gwBKJE+kiogQTpBtMM+rjGQ+cNK2fKAn3ndskNZeHE7+XJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in; spf=fail smtp.mailfrom=mitaoe.ac.in; dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b=IHpEi6Zg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mitaoe.ac.in
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb576db1c5so1124361a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2024 00:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mitaoe.ac.in; s=google; t=1722064973; x=1722669773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yTAe3Oq4Gtwe+aHW5T8I7GOgKOZZg0n4SEdM1OJIAzQ=;
        b=IHpEi6ZgvmbNP/+0k6jCsvUppCxiv6vLbjuNXX+AlDnTra2umoYSgmbc7sPytoVzNV
         0PFr1fQR2OpvzpYnc/OBdrn0DBW/Fm/bjIjyq6/aAnmPv812ml4OxmCMPcl6+zif3F8r
         bwBB13ECvEB44yNHVO9Ayy9AmWuY1R03lx8kehCzlx21DeGcl7mhkRCNpuism2NcWJtx
         i3/ea1NLsFV0Teddm7s1NRxKAOhGs8k8RFBQ3eWElMQnONjdXCwG4HywDsGPhegSfJ/z
         6obymsLmk9u6BH0RjsIZmFKrvoABc1ktqvLRPVXBSVcbNffKddAsIvjKWBjEfR3ubHKQ
         SaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722064973; x=1722669773;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTAe3Oq4Gtwe+aHW5T8I7GOgKOZZg0n4SEdM1OJIAzQ=;
        b=sNcKfNels1EedpGWYOl1lv74UHe5AMw3SRGtXsH06/EfarJ6fJxNOMTVZJd5ocqyJ0
         wYC2s7WnnwAqZUO+rqNXUZUp0I/7lYSf0MgDdcA5RfXI4J0vkYOsqMkGsTVibuxakGzC
         P1XibussZi5XZVuTMUzxbXhsdVbAP5JSlSW76WEwPTkTpm/NEYvpyk6ZeLTscmu4EtVC
         Xpmv2HktvfKw2fTCGMYxPbdTmPBuZVzc0mK6UtjBvDBAI97XWnDvarD51+bHJX5QCMZU
         VmejTiqnsd44nq4eas2BW/A98F4Mg3DcNDNmfWDv8TuNvJkqKw/14oCSV3CVT3+mhdA+
         JCWw==
X-Forwarded-Encrypted: i=1; AJvYcCWvKZJDWcmV+qHYLJfdIcLaV/Eis5fxgODEqGLEMSt2iqmi7vNIJVrxFyTYYLi4Z3Y3PFCAkF4Emn+Ro0ICYt4cyB645yYlufSDzBu33w==
X-Gm-Message-State: AOJu0Yy3FBhaEvmTLcINlkFJoc368ClokYFF454VVsdBnN82aOpx3RMs
	HDBd7llcyjLopF5y28yQuFWIQhfPJApuTVlRJVYOqKhHAdMeze4+g+rPWLyDdNc=
X-Google-Smtp-Source: AGHT+IHt10QY0pcBbWSUFi/9SgKeB4xClFMu2pDiosx+GuN7h/LiuLO82FiJUhv/WxmBCpUC+YMC+Q==
X-Received: by 2002:a17:90b:4f46:b0:2c9:aea7:614f with SMTP id 98e67ed59e1d1-2cf7e2073c2mr1868283a91.24.1722064972694;
        Sat, 27 Jul 2024 00:22:52 -0700 (PDT)
Received: from localhost.localdomain ([152.58.18.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb74e8769sm6634537a91.42.2024.07.27.00.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 00:22:52 -0700 (PDT)
From: mohitpawar@mitaoe.ac.in
To: brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohit0404 <mohitpawar@mitaoe.ac.in>
Subject: [PATCH] Fixed: fs: file_table_c: Missing blank line warnings and struct declaration improved
Date: Sat, 27 Jul 2024 12:51:34 +0530
Message-Id: <20240727072134.130962-2-mohitpawar@mitaoe.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240727072134.130962-1-mohitpawar@mitaoe.ac.in>
References: <linux-fsdevel@vger.kernel.org>
 <20240727072134.130962-1-mohitpawar@mitaoe.ac.in>
Reply-To: brauner@kernel.org jack@suse.cz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohit0404 <mohitpawar@mitaoe.ac.in>

Fixed-
	WARNING: Missing a blank line after declarations
	WARNING: Missing a blank line after declarations
	Declaration format: improved struct file declaration format

Signed-off-by: Mohit0404 <mohitpawar@mitaoe.ac.in>
---
 fs/file_table.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index ca7843dde56d..306d57623447 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -136,6 +136,7 @@ static int __init init_fs_stat_sysctls(void)
 	register_sysctl_init("fs", fs_stat_sysctls);
 	if (IS_ENABLED(CONFIG_BINFMT_MISC)) {
 		struct ctl_table_header *hdr;
+
 		hdr = register_sysctl_mount_point("fs/binfmt_misc");
 		kmemleak_not_leak(hdr);
 	}
@@ -383,7 +384,10 @@ EXPORT_SYMBOL_GPL(alloc_file_pseudo_noaccount);
 struct file *alloc_file_clone(struct file *base, int flags,
 				const struct file_operations *fops)
 {
-	struct file *f = alloc_file(&base->f_path, flags, fops);
+	struct file *f;
+
+	f = alloc_file(&base->f_path, flags, fops);
+
 	if (!IS_ERR(f)) {
 		path_get(&f->f_path);
 		f->f_mapping = base->f_mapping;
-- 
2.34.1


