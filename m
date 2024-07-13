Return-Path: <linux-fsdevel+bounces-23637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 057489306DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 20:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4071F24245
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D7413D251;
	Sat, 13 Jul 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b="cHjEbSs8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F590125B9
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jul 2024 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720894009; cv=none; b=gt+yQs08nplLJWPNfkQ03hOnOOgL/emszjFBw5VHbmov5lnEEwhYFsCsNIaVeUil1WvDuSgikbcM15ZgHIwjoVzuiQbD3J5RlHyIoqJcpYmE6qyyKEcN3xrA9WumE7JjVS/rXN1ZNN47HU/ltZ8FNZYXxJZBBbv0NDmItanCPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720894009; c=relaxed/simple;
	bh=19deBKXtIrWdyfdWO2kcSIU8veOmHLYeyK6XrCCAh6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KKj9JO0BiZ48TNtPP9f6rcgdiTr46NVEWBBKh8B6oT19tH2BeDSADGm0bDBWCrqUtDfR/QDalVqAqu4Fzho2cQ1vcLfVNzom0WwL1tvBWHJivwm+oouufLK6Tr8Pny0vVOMAu5spmqYkI1a8EtB1QEbSx63TJ9rn95JU3TCoOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in; spf=fail smtp.mailfrom=mitaoe.ac.in; dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b=cHjEbSs8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mitaoe.ac.in
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb72eb3143so21477535ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jul 2024 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mitaoe.ac.in; s=google; t=1720894006; x=1721498806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LO1qAerOan7GyDs+4V1LarTw1zHLMK4oIn44Hbh1CA=;
        b=cHjEbSs86wa2qU8lwGz/KEHRyDJ25j76c6qy6bMxwXE4BXI0etqZ1SthzzhVP4NHfg
         CnvvpOIw+xhlWVpyUxQEvowZd6pMcWdQceDYYz+y7J4Da4uO8LysoZBaoQR8NKe//ur3
         RHTztKjRbbzFjSgjAxm+dN9BYov2/leBWxy68vNs5cB53Aw74+FmTr00Cgj/BMbim85i
         cLLZj5g1syWVlHppBqilcxbrrilDGxPksAypPNES9/RsNbyUZ5OOEFPUq8VAPwYooYp1
         snoCkgCI2qD/pn1+KjneEQ+Uk1I/x6Hl+WMz3Vb6ghUD6NKemMw1vubeP5D1E3g2qNdU
         cPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720894006; x=1721498806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LO1qAerOan7GyDs+4V1LarTw1zHLMK4oIn44Hbh1CA=;
        b=ctYKi00xl0iR7aZ4zSOy+aXkF+iJvTtcZsCepGkxtFW5XEoHdUr1LjAUFLibuTlDAk
         BeC/Nz5paL8RrIOEcuet0FdjlRqKtetcH9rvhMBIac34/rkBuJmfy2395uJo2t2nGf8k
         HwfryMI2ouvb1nrvIKZr+eKOxt8nH+/3Qb/TBzrs99GBYb5eme0Ot9sOsdqxnZc2VGCb
         rWjp/OVMZZ1bg9bQwNRZAZ+d/IwUr9XbhMHitXgqyKb562pUQ03Rpd0C4fAZjRHhonfC
         QRgA3UmKWV24fd7Ynl/xv8cQsGBzNSVyUCXgAlcwx7a5Z4vGry43WiyUCyPm/lWV1WTw
         dIsA==
X-Forwarded-Encrypted: i=1; AJvYcCUCAP4G+L4+Y+vmRyOS7ChOSohmFzFjGmietHcMg9FEvZnwQX3oiMIW5Xhmh1Y3CSe7rBQtam4coAJqr1xKKdd5D09vezvN44kAG/3HBw==
X-Gm-Message-State: AOJu0YxRDFxg6j9j6BtOYNIsSR9ikHlvmX+qWbL/p08RDyoJ6VnYRQXV
	D3+HIclrzRjTHxBAOZO+ecOElA5W3DFsvTLSdqCEPim6k8iFxDFcXCvRMRQL31k=
X-Google-Smtp-Source: AGHT+IHbBTEqXXoseVN7R1U+NKeFIwiKbZeWCkN1HC46RG9dLtQrGa969U9Tio6vyZC9WTNl+Lprtw==
X-Received: by 2002:a17:902:ccc8:b0:1fc:ee5:d581 with SMTP id d9443c01a7336-1fc0ee5d71bmr26008665ad.14.1720894005721;
        Sat, 13 Jul 2024 11:06:45 -0700 (PDT)
Received: from localhost.localdomain ([152.58.19.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbc4e68sm12896455ad.119.2024.07.13.11.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 11:06:45 -0700 (PDT)
From: mohitpawar@mitaoe.ac.in
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohit0404 <mohitpawar@mitaoe.ac.in>
Subject: [PATCH 3/3] Fixed: fs: file_table_c: Missing blank line warnings
Date: Sat, 13 Jul 2024 23:36:12 +0530
Message-Id: <20240713180612.126523-1-mohitpawar@mitaoe.ac.in>
X-Mailer: git-send-email 2.34.1
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
---
 fs/file_table.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index 4f03beed4737..9950293535e4 100644
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
@@ -384,6 +385,7 @@ struct file *alloc_file_clone(struct file *base, int flags,
 				const struct file_operations *fops)
 {
 	struct file *f = alloc_file(&base->f_path, flags, fops);
+
 	if (!IS_ERR(f)) {
 		path_get(&f->f_path);
 		f->f_mapping = base->f_mapping;
-- 
2.34.1


