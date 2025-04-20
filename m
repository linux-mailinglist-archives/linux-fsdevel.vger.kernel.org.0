Return-Path: <linux-fsdevel+bounces-46804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E396FA9524A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F98172F5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975883A14;
	Mon, 21 Apr 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNVOq8ww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410416DCE1
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244029; cv=none; b=FpV3pCcDtRuMiRri8NCkWT1xi0XToM/H1zARLRHN8Zh0Y7XOZE1q1RM3etQ92J7IxbGSr2E2vzh5VhscLUT39hb4dGUlP3wFph4HAPatkvKVAD9WSGMl6OFB0lQLTa+0ax+MM/p9JPwWXzWvQmOHSKeuHX68XP9PYyjiFBCXoDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244029; c=relaxed/simple;
	bh=iIc3T2r1zz8BHPKUThZuVqrU1Ry8vjD2RAxbyNccc9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0qzb6XPcHotQoGMzCLL4yfQVY+S8XWcZFXMTbXMfFgdc4ufqQ5LdtAJZl45UQy8kPNsff5kVmw2l0GBIxEzRB9Qd67JZR8kcnfXzKvSGpviD+Qw1he1ICbvnIL0qEr2cmPH578Ma1ZpnkHui1XHHZPJD+wuNxjz0iZ0rKYW3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNVOq8ww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745244027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8RPH2BbnVIKvlMK3RpIg2tk/VLMraIy5hL155khQMg=;
	b=eNVOq8wwW4zX8ETDkcZ3uWIrIEtNo1KlB6EezwK5UZw6bn9DbggWQnOjEK+uGqSfYAK600
	EdwnrYVSKVQWo3MizOhpAVRGGF89q5a5GqOt2jGRNb0J2mcsWsdRofFxjHbdfx+ruRS+Pf
	jBGLqUXTr55x5p/5hZHN+AID9YDF3bM=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-4abDY6kzNAiOfRKgaYoC2A-1; Mon, 21 Apr 2025 10:00:24 -0400
X-MC-Unique: 4abDY6kzNAiOfRKgaYoC2A-1
X-Mimecast-MFC-AGG-ID: 4abDY6kzNAiOfRKgaYoC2A_1745244023
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d81bc8ebc8so37353285ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 07:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745244023; x=1745848823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8RPH2BbnVIKvlMK3RpIg2tk/VLMraIy5hL155khQMg=;
        b=aOROsiuhubuqCZVCNL55OFMGPZ0/d3ucAetrP1jrT+M9gBFkZWfDAlR8gkwPNywjif
         wqBN5fw3pQTGnN3KxnDyo4PgACuNqT7OfLkn5TU7S0p8/mN3KFI+u+PQyYvqwRMQCU0P
         qMyiTuV6EHgSvsUzBgCOKyfIJXk9rjdDVm/NgCJF7X2Ji2Fkhl7tQ7LBUUMpU4wiATUF
         e6annqrJogJ0mIzRVhKaiGVTo56eUqcZeY0/zuRdeY5GllLKx/n+pzHXTJ/0yH8UOIpm
         Rwo0ppwSK90t0Of+UJty8ha3csBcvlH/i/IsooPV4VFGAhlUkUGUXZNSWzpYHL/p4f+k
         nz+g==
X-Gm-Message-State: AOJu0YxUVGvgImVH+YFNNWavcsyjVsvGdW3w6c2ohusc84AOau590ezb
	nsHlf5jdh1c8d9nL1iTpt4X5+4SA3fU+WEgIwIQHDzaD2/yhDVYfsr3/Wd80h5YnQeDPIub6xyu
	Su8lZUTOlkLFv1v49rDJq9S/PNlZ8WLGk4Z+zXiYI4b8Khd4oXKpWohO2JVwcST0=
X-Gm-Gg: ASbGncuwYPsWqJgPdcf5eiBcb693yYZOPSO5/HE8d/bxwKkzuIIfzdRjoI1mdIsf2S/
	17j1U8Jr2AKLcogNaOOsK4DdQRuLwDXJmeMMa6obxRtwyX2im56HaEqBlcDQZOT3BnNdPu4lbVa
	4BHO4BrIHixdzsB6Fg6ueYhB/mNYR7M0CTcYw8CvhfrZs64ofR/IAe4ed3QbSbNSZFszSYJ2p+l
	X7q9PP+XYjYAtem8GLC/YSqF5WAGDTjk2RZknZo7yjS6VshbV6PCVWbxn7vUj0M8tWDrBwUuv+u
	kvMcKBYr4TbxCog=
X-Received: by 2002:a05:6e02:b25:b0:3d3:fbae:3978 with SMTP id e9e14a558f8ab-3d88eda88b8mr86556945ab.9.1745244023226;
        Mon, 21 Apr 2025 07:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcXmrBchySvZeSIYUTpP1KYEqxDrs6gjM3LNVXs/Ogo5wfzDIS3o/QfmWlwEs86V44NRmD+Q==
X-Received: by 2002:a05:6e02:b25:b0:3d3:fbae:3978 with SMTP id e9e14a558f8ab-3d88eda88b8mr86556535ab.9.1745244022616;
        Mon, 21 Apr 2025 07:00:22 -0700 (PDT)
Received: from fedora.. ([65.128.104.55])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3839336sm1788866173.73.2025.04.21.07.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:00:22 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	lihongbo22@huawei.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 6/7] f2fs: introduce fs_context_operation structure
Date: Sun, 20 Apr 2025 10:25:05 -0500
Message-ID: <20250420154647.1233033-7-sandeen@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250420154647.1233033-1-sandeen@redhat.com>
References: <20250420154647.1233033-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongbo Li <lihongbo22@huawei.com>

The handle_mount_opt() helper is used to parse mount parameters,
and so we can rename this function to f2fs_parse_param() and set
it as .param_param in fs_context_operations.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
[sandeen: forward port]
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/f2fs/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 818db1e9549b..21042a02459f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -705,7 +705,7 @@ static int f2fs_set_zstd_level(struct f2fs_fs_context *ctx, const char *str)
 #endif
 #endif
 
-static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
+static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct f2fs_fs_context *ctx = fc->fs_private;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -1171,7 +1171,7 @@ static int parse_options(struct fs_context *fc, char *options)
 			param.key = key;
 			param.size = v_len;
 
-			ret = handle_mount_opt(fc, &param);
+			ret = f2fs_parse_param(fc, &param);
 			kfree(param.string);
 			if (ret < 0)
 				return ret;
@@ -5273,6 +5273,10 @@ static struct dentry *f2fs_mount(struct file_system_type *fs_type, int flags,
 	return mount_bdev(fs_type, flags, dev_name, data, f2fs_fill_super);
 }
 
+static const struct fs_context_operations f2fs_context_ops = {
+	.parse_param	= f2fs_parse_param,
+};
+
 static void kill_f2fs_super(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-- 
2.47.0


