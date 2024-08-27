Return-Path: <linux-fsdevel+bounces-27370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D835E960B0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 14:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172381C22774
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50DE1BF816;
	Tue, 27 Aug 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="JgL/ulg/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A771BAED5
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762959; cv=none; b=KDinO6tdMpvY3wdwKKMrs57Bnemv3UMwV1ieKkviXLkU4bny3vqq5FxSc5Qi/Z2cYxuxc3PMfi3nOvkdCCrCJ42KinFd8MvRWvn222R6CT4AETG4j/DP26C/Hp7gSUSHilLZZDLLp483SMiTMM6cFpDsCSml7ulzi5WyCDehUQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762959; c=relaxed/simple;
	bh=wscF2ITDjL+zA0jES7wvT52POg2jmCcdiSKrj3iQL20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRq0Sk9svHzGt3WzFjKiK9YnwCwGzQV+RmW3OEBp3HktXDSaTMg778FyxU3cxEPTbjyWVmt1wBrZ+7dtpXMkkgUM56+kcegmemdPQYZXyzkgvv3kyrOy6Ugr82TcQpL2jcJC9AaCtVvE6Hb1KkdslDjF4q/bhgpbROCeVxJ6sfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=JgL/ulg/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42b964d7526so2438525e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724762956; x=1725367756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7tHPmr1c4+0oZPwNoAX8qZLaMbelgh9RbQRLc/3HQo=;
        b=JgL/ulg/2Z2Mj2WEr+h+Wz37L/IJdeSH5F+gfayj1E9o+9nnAnu2mm2qkJvxzhFeKn
         w14SAHwowv0zBNN2wAHuLSMTXnHc6j7kNdK77SZ20/RQR11xohOiPV4agD+M4HnCEUiz
         qFVLHguerMHYQJv1hzA+kBEP/KYjgs/u4Q29ckrgxXCCF4059prR/oxzkc1kPBu6+0G4
         qR3cDjiA8Yib3YSxxJYKCt2wNiZxSMF9acHwMow3YbPtYaSr6STb2PnOYn9jELphGpoC
         vwTvr2gUdtVea+9NUh6yhA2upFlVWNnE15tmMZMH9ZZHq0YjnurbC9J773rzU2CPIwxa
         2rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724762956; x=1725367756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7tHPmr1c4+0oZPwNoAX8qZLaMbelgh9RbQRLc/3HQo=;
        b=fO2gO3xmggd3cUY7bPYARBVGLgjbuwH9Z4m9MIKytsy6DWR99/+lsQaZ7Pm7jfoqCB
         uTJ0H/LLZk0t6lPX+w72ivR8DtEeQ/vT/OgYlSObj8c93WzqUIlGyM0ZuEwZBj3WvteN
         wjwlKX1frYWoxGaETEkCrq5g7WhIh4TYGtFTFMq7vOnMrRb73myGDguVe9h7dmT2r/3C
         AHYpNCoLs3bKxctpskbaC7WJ8jnejyj4+9k3u4U8YMb7XR4oX0WVwqdk71En8uxXLhwk
         HgdByA9BJ10hsn7AJVF1iRq53pakiXwy+1Buc2SKjD/TX4PG1YVo/sH8hgi0/1MXV7FC
         P8Vg==
X-Gm-Message-State: AOJu0YxWiZREFsokQDW/VX8rIjhQjIOh0IV9DQdtl80yVl+m09+gERDK
	uUWvcZSYccQovBStmfc0FVN6xtAnRhSdwpThewRMYPdm/1fMoCMO8GP9FIv6fFU=
X-Google-Smtp-Source: AGHT+IH/VZhYdTzKRXtBrAVvHca6e6ly//DPo9FBNebV2MpbS/nxnzOZskjXpyL/QDH+VENRiMxe/Q==
X-Received: by 2002:a05:600c:3c99:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-42acc8dd868mr60882815e9.2.1724762955347;
        Tue, 27 Aug 2024 05:49:15 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac516252asm184042295e9.26.2024.08.27.05.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:49:15 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dsterba@suse.com,
	gustavoars@kernel.org,
	kees@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] affs: Replace one-element array with flexible-array member
Date: Tue, 27 Aug 2024 14:48:40 +0200
Message-ID: <20240827124839.81288-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated one-element array with a modern flexible-array
member in the struct affs_root_head.

Add a comment that most struct members are not used, but kept as
documentation.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/affs/amigaffs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
index 1b973a669d23..da3217ab6adb 100644
--- a/fs/affs/amigaffs.h
+++ b/fs/affs/amigaffs.h
@@ -49,12 +49,13 @@ struct affs_short_date {
 
 struct affs_root_head {
 	__be32 ptype;
+	/* The following fields are not used, but kept as documentation. */
 	__be32 spare1;
 	__be32 spare2;
 	__be32 hash_size;
 	__be32 spare3;
 	__be32 checksum;
-	__be32 hashtable[1];
+	__be32 hashtable[];
 };
 
 struct affs_root_tail {
-- 
2.46.0


