Return-Path: <linux-fsdevel+bounces-49182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BCBAB902D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1987F3A0374
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DF3296D2E;
	Thu, 15 May 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5rVBFVO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B00425A339;
	Thu, 15 May 2025 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338679; cv=none; b=S6SjRm1eN47kqN24x5kzLudAeZc3hvB+/aYkVv3d1sbnaREgzx2W0zDGXCGbM8Lrq1j19uVhCY1MyItSXxp/8ZcUkVsOgJWLXFWHw+vaCEkqeAGEk8Hrz483ST5BnvgPciSIkjgUHoG6Erqhac0Hy84/HusGhYTDI30V8z/GOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338679; c=relaxed/simple;
	bh=uP6tMGm9xi2j9pTznEkV9HDsT09jYV8jDGqz6ACeva0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wuuq6vZoD0P2i3o3ZXX1TVGnqdkFWamHJpGqMfDYMkqkJ5wVU8Hx9F3Cw6Y/t9VeReWTGUbTf5DOwksWh28/XRUyHYA+1Z6pR0kIQd2qisfn0QuoBKqUxSmKmKnHAsQxwfzfx5tle9cciJ7k+TilL9N5J2qRJe/JSlKwf6yUsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5rVBFVO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742596d8b95so1867865b3a.1;
        Thu, 15 May 2025 12:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747338675; x=1747943475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaNnp133QjePu0G+LkhstF0zTD9c9q+M1LCVIv6hFLM=;
        b=Q5rVBFVOSHgf93KiRYgwzzV4Y8V3MWSmO9y1re8cETRxbzGFD5ZxJfpUf+4l2XSscq
         YxRJLx4MJgnq23xCeiwJYQl32aJYgt5bWE5SgEMyaDA9ZSM/B5Rji9Eo+D79kQPCXVCZ
         QMhQxMs6PenVi/r9YrqKLLMAFOyJ0EH3d2FBWvZ6jVoELoxyzN0vzX62aggMCs+4GU68
         ++gVtYf9wLUjGCVKA4/g/jNxWeCO16UOArpy126fdnIHyXEjil//2yTHc/GNkCPNrM0u
         lRUa2omgtmu4w6EydA/XvGDcmY8ehoYu5mhLatst223UpYQ31UwDj3baltJrnJiFWCVc
         knPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747338675; x=1747943475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaNnp133QjePu0G+LkhstF0zTD9c9q+M1LCVIv6hFLM=;
        b=CWefICWltlyrzyfNeLsj+aZwhXosbEng+v3dIVz8LYqTCkSKIglML9rtQx0EUMoNVn
         Ai+qABj9Mx3AWL1wbv38rVHOn8y31uApOIGRTs4e4QwoW5eWOLZOQswMsQvpYjBt/zQ8
         x7D56i88qoVmhK98pxjZfWtry4wHAsfCQDKsUbY7xVHnhmpULEroZcHltz9gj9lL9J3l
         G8LgsFgHJVvCyykWwVszn4jXDfnqg37V6c8TYTNwBSMtv7A2GIcqxRMfcmTYdsDt4ZSL
         yg8GBpv3WafHMFxAFwQaWAJeeigzV3+nfmRo7wAx8AlYrUv9t6d+uX0EwFjXNXNwlqWn
         5ecw==
X-Forwarded-Encrypted: i=1; AJvYcCWqmeEeQzd8fG67arcafitC37nfrtNgubSWgmgCb1HLX9wvmqPAbSJpdafXI41s8o5rGUAYLbWgwVnB8q5Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzNOm8DzLJBCEfQ5hPfCGHMQf9xmoJq8nbbhw8AikbMwD3dcxdN
	G9mfoEaQOw6aBm4/8ZLAXEm9Er3u244MsOUJjBumpzLKFSnGlE3kpTdE98yxUg==
X-Gm-Gg: ASbGnctmJun2ZMxoXRr0xC16hQ3Yyp8MNWspyJjrmsQ1Wul6JLTQQkR9izH3mKtBvcW
	+JLCA/nhsLRya6XmxTKnAR+bEBPTbFyZeAwQXeHFACcSuAYvl75mwUP1ZLzuZbFPCejhVz0oTiC
	DpGgWKbEqxfNzN6DgbaylGamVvd6hUNBTCwW4F+LS/xA+Ta+6Wch9Ri/MGxiIG74QulKPiAsPz5
	onQBCOCVV1FoMdRLIOvp1ir9pYhCUM1InHtBrOXkaJD1MZobSOlrdHuCNgBoNBPXGG4BT/IOaR2
	7Vzs3+CJMThaVfojPTjXohNaWmNl7jxt9+sOuoFc+G/xVvY=
X-Google-Smtp-Source: AGHT+IEPWoduBKTY9lQof1EwsEpf8N2mgPEw/Ebceng8TKjBxC5tAWsVwaxLIyZa6L7gyoqaO83Hew==
X-Received: by 2002:a05:6a21:9101:b0:215:d565:3026 with SMTP id adf61e73a8af0-21621924720mr798325637.20.1747338675538;
        Thu, 15 May 2025 12:51:15 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a9893sm280463a12.72.2025.05.15.12.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:51:15 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 2/7] ext4: Check if inode uses extents in ext4_inode_can_atomic_write()
Date: Fri, 16 May 2025 01:20:50 +0530
Message-ID: <86bb502c979398a736ab371d8f35f6866a477f6c.1747337952.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747337952.git.ritesh.list@gmail.com>
References: <cover.1747337952.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EXT4 only supports doing atomic write on inodes which uses extents, so
add a check in ext4_inode_can_atomic_write() which gets called during
open.

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5a20e9cd7184..c0240f6f6491 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3847,7 +3847,9 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 static inline bool ext4_inode_can_atomic_write(struct inode *inode)
 {
 
-	return S_ISREG(inode->i_mode) && EXT4_SB(inode->i_sb)->s_awu_min > 0;
+	return S_ISREG(inode->i_mode) &&
+		ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
+		EXT4_SB(inode->i_sb)->s_awu_min > 0;
 }
 
 extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
-- 
2.49.0


