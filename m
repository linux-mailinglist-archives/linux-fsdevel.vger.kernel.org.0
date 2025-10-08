Return-Path: <linux-fsdevel+bounces-63617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D0BC69A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 22:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4AC24E47E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 20:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10D2980A8;
	Wed,  8 Oct 2025 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+AAkj0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE41E7C12
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956143; cv=none; b=qh4wPFJx0O/QFwdTvzq6pGxGTdVSAM3PuC9PlKxqcyHpR4SQZdoPMWMmYI/nrQhzZQUOzoyB8IpNnb8Ec2GY78hJc/q1omSeTQ+gk8bFZ9CKQaof6ggGUe1OaRr2KBC0OpTBh4Lkissz+PY8F0uwkbCz/W4aWrPWCQclHhcqmRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956143; c=relaxed/simple;
	bh=JGEyx3q2kq2UF4LFDn5mm3OmGWpYK56Y+kCJklupT3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nu34akydFMRy437q7SnmGRF7tU5oChWTFg3b9w+7IvNyQKmgtFkvtRAYhQVnldBNqx5TAakme8Lx+Z6U53j9jbnpXz68IzIC4Woo0XkZ9BSLcHKzYwDRD7xXJuDqGAjufWHpddv79xgO4Af+10LoV7rWVWqOnfKUfEdpqkqIR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+AAkj0K; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-28a5b8b12a1so2505315ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 13:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759956142; x=1760560942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DcM0JzIRcpUhIuY+vjSSe4MI6JxoQ0XpYKoqwvWcj44=;
        b=I+AAkj0KP5133hQrs6qRS4mP41N3EaYlCF04qAxP/LJESFe5BFB2CZQMPVKvgYHVPb
         G9iSnBiGcz12v0EE93iHtx9BkXFR08TByZEjcMjDbxIkUELoOO3Cth7EhLeoCcTAcwwq
         N064YSeYK5QlR/+Ad6rabuQIHYyf6yYIq4K9PIaqxDPQB+8ubjBlGHAxehVXip+3hSHO
         mn0RHdxWfkncTF1EmhgqsvYw+iNPI2yVzF1Hx7i2wFBiDcDZ+P92zi8IQPIeEI2XfDWY
         zc3QPZUajksBuX32wylZQe24+fjKbbY+ww667hzOXLvPAye7R49vaqs/GS3ni0BLPJPK
         qNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759956142; x=1760560942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcM0JzIRcpUhIuY+vjSSe4MI6JxoQ0XpYKoqwvWcj44=;
        b=jyMyvjtLkjvDJwYvHCIdfagYY8BOdlM/cMp+0n7EIe5F82qAQdVLR8x+L5dHxIBOvK
         Q4WjE+lrPwCOBk+j3UV3L8hL1ZSD/dV5zqPIzpiIHHiuEGo/HYxmnbkbiIuRSwz3QHfc
         UGZ92rj7WYPiBP00DaSRKc6OGFWdyZwwhnV0X7CDvMnZO+BVt9YL7EQgfLzqS0J1kILA
         ZMjGwnTfm5aIke5yUZXQPRvcLvan95wXhH6P/SOXaVfceNT/NPAooaisNTNsizrbmJ+q
         oITRDGaGteyE4DxZPUIjCNMB8258TaEAiI91HWxpJZGWqxVJBxWR37pqN7kE8NZNjnWL
         uetA==
X-Forwarded-Encrypted: i=1; AJvYcCWSjNufvtANY9kMEN1gRbLCJTiy9uo7TqTOFrCKipOoeDlSQvyQMvoMHFMAajk+SAC5Jhg4OvvNBCD62a6X@vger.kernel.org
X-Gm-Message-State: AOJu0YwwnGdP0Fx2Aes5nSE8LyLaCeDRQjsH5gj1sTgD0DIXcKA2Czfs
	Z7jXQfqrL8LdtGy6AfOKEHhcNmjUXafOAR5fUgSOAmAHyI9Kx1aFqgv6fpqPGA==
X-Gm-Gg: ASbGncsP+8RPr63TEGabplg9e+qbHXnBqF2Ogtm0iO/0O31k3EWBMM5tSBfveUy5hv1
	ZpaBRDoaBgWu+dTNxoz2QiYRwAKPkE2WZw5Ur4/OPTAbxB//EQxY+fGW8kAAtILw3eYG5Blcu7G
	MBhQFkOpg6gbxwgozvjCwphqkiFwEBRYYi2mSi2d1EuD40rkK4Q+jUiN3qhT0PTnHdsAVlTKC2y
	8+T0D0v9PP+JZz4CZBOnDZiD/HIXaXCMyUfPM5JpMQ9dmGafHOIhvUALBpG0n/zIAj5WgJWyxLT
	CijL9atvQwQa30lldM2FME4KUnvBcMtSA4hU+MinWCZLTUOtto3S7wiPysqJp2j/Y5RPLKt4eWk
	793m6pxzez+ftEVfNyd46Q5LYEb6fbHRZwFrI9Fu7RGhECImkssoDDUgWyPjDBa7OBhs3woIbgQ
	==
X-Google-Smtp-Source: AGHT+IGuAsyvjci1j/6nCrTKJm3MZ9MNM+Ir8MsxosjV0un3MgS4GIo2E6ZLg88Ut6gnuZtPeQXwNA==
X-Received: by 2002:a17:903:8c8:b0:264:a34c:c7f with SMTP id d9443c01a7336-290273568famr69650665ad.7.1759956141637;
        Wed, 08 Oct 2025 13:42:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034deaa54sm6450465ad.5.2025.10.08.13.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:42:21 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: kernel-team@meta.com
Subject: [PATCH] fuse: disable default bdi strictlimiting
Date: Wed,  8 Oct 2025 13:41:33 -0700
Message-ID: <20251008204133.2781356-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5a53748568f7 ("mm/page-writeback.c: add strictlimit feature")
enabled strictlimiting by default on all fuse bdis to address the lack
of writeback accounting for temporary writeback pages.

Commit 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal
rb tree") eliminated the use of temporary writeback pages and commit
494d2f508883 ("fuse: use default writeback accounting") switched fuse to
use the standard writeback accounting logic provided by the mm layer.

Since fuse now uses proper writeback accounting without temporary pages,
strictlimiting is no longer needed. Additionally, for fuse large folio
buffered writes, strictlimiting is overly conservative and causes
suboptimal performance due to excessive IO throttling.

Administrators can still enable strictlimiting for specific fuse servers
via /sys/class/bdi/*/strict_limit. If needed in the future,
strictlimiting for all unprivileged fuse servers could be enabled
through a sysctl.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6fcfa15da868..87cb2c2bbc7b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1591,8 +1591,6 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	if (err)
 		return err;
 
-	sb->s_bdi->capabilities |= BDI_CAP_STRICTLIMIT;
-
 	/*
 	 * For a single fuse filesystem use max 1% of dirty +
 	 * writeback threshold.
-- 
2.47.3


