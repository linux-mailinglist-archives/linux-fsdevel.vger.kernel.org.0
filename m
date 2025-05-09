Return-Path: <linux-fsdevel+bounces-48609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2145AAB153F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE597BA199
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8982918EC;
	Fri,  9 May 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT4ggsUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB129189B
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797571; cv=none; b=lurV6LyJCbgXxPGb8sc9Wbuuc97+/BJhMTuAJsiIBj4FVE+qU60MQzI4lppiuCXIYz2Oz+/4x3IRll4iZWO+wcs2oj4LXBJXSi/p52kWxcZS9yGV7Nvz+LqD64+7rvMnR/42FUDK3lu9aZljLZZK1dCon5vt7cfnQbx0+ZvtP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797571; c=relaxed/simple;
	bh=RiRQe1Z0XZW5zddjoqNn6ipHsWYdZK3/5xZidQFYvfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxpWDL+OAHfrE0fyDvVHoA5NC0k5NRuX5CgsZGvAmGJwR7QhRpT0Y1QuSTVX9QIED2vwkz2W62Ep4klqugVdmjjjLE4rJSgr/AZ/G8yMG/5rLaDxiwEdvpQM0u84JQunkkOp1RUhcfWn+nPvSEtofjQVi/GxtFfi6Jvc0Sl1bE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT4ggsUc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a1fb17a9beso290255f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746797568; x=1747402368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ch0IyRGO/meNAPRaq0GR3gBnAjUOtVi/fibkVMiwGmU=;
        b=jT4ggsUcz5fQXc3SWSkLIqOSICPrrbWSjgShjthmgw0lMGw17tIPiWWfJDcQGpP5mh
         hpSpll6MKum/Y/dOH602asdv3ZyzBKAK2BmQC+J4+t7nMGXeqR0kybFFiAWFhO6U7bbW
         IzBrn5ASZ/FwAJJNEKIIjbZZzlDewFNifKKxO9j8w75xGyYL94HGSK7IzklhovmXDaf8
         jD5MyLVnvwWIqUI+Wm2oIs6QyuwATAfZj9T05HBvm8uRejJbIjdoSfKw5aDw/G5YCnWQ
         AGCBkdZi71o/KYnpANmfoW8kXzlnK0PP8m4xq3P2z1/F9MJan4tFGccZALYIKYshSzmC
         GXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797568; x=1747402368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ch0IyRGO/meNAPRaq0GR3gBnAjUOtVi/fibkVMiwGmU=;
        b=r6Z9UPtadimHjMIkAHFmF60drHtjMv8laG98WBCHepV5EEY9I+CvIAy+/VT7z+NSMU
         GXERy4oZoCZVIvtBr24xiJ2YoDiTriyNSpXRO4OkoQ9ISmvCA9ni09NXQwEoRT8Cm9Xq
         KKOeXAnJq6u4VqqZS2s5iNXKuW8cfwLwdjGSN2k4qf013H6KfeaVAuNwth7DiTm1mTh9
         Ts9w+XYSqiZur20gBH97YNqGzNTWpPOuTyAmcJeIceYzVfXGlmbHqcmtwaa8EINZuad/
         qgTBbxxt9ViqVLxGHLMSvJ31WQCbXY76Q7V0qFe67UEHDKi/fSDyuGO29M/8uJupWjUO
         uqvg==
X-Forwarded-Encrypted: i=1; AJvYcCUbQCEBIas18P46Ksm4Qc1DH6an6wvwZeoIbBipQyhGQtDS6TJE7/btMzfyv6oRV2fEgbs/b7E2hwafuXkM@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZW9ZaBtDVh4RYpy3yhgn4jKa5AVyCfqot9U8/epn8sLJEriC
	h2aMKYnSjRr33oetM5kfW7/ryWvDLs/sdqDASIh2BIsJtlhP9wZO
X-Gm-Gg: ASbGncvs5ieWB3Vk3poQgpKJz6dA+10+Sbe05z+obiPfQPLM5mVajWHX3rGDvqPNKiI
	8ZZdCvf7neI1QfMGSZol4/V4VdF1arHENadrzQ/2Yxy2sf/gLrypO9pGnY7RAbglggczc8uSmag
	uNWLMDlFAS76fontwnZRLzh0ZKWWbJeDha4CwfcyiJ9QgdKGVfYViDqEQqQF29cYGuC/Z6hKvki
	CFAVUZsCGh22q76Kn8rBbMYswxr7cyYC4tAX7ipMk3a747Bl5L02RlePy5NzntJxDq8LbBM9b1A
	jODehgcZLiBWQZRZM/TpC0nvQlAaj3aZQrfjiv9wgXfbuhSrYT5oXDrXQ6eU8XEhBqRJ2F8hK6U
	QukxDaSOgi8qZa8aAPWSXWZpbHFaXNnNFQQioxQ==
X-Google-Smtp-Source: AGHT+IEFN5oIhkTrMZunzchU0KhgTgnfBrgRSEJwVTeGdXyc03ilzn29NNQgSNWtEUA9wLGtzLnYbg==
X-Received: by 2002:a5d:59ae:0:b0:3a0:b7ee:b1c3 with SMTP id ffacd0b85a97d-3a1f64276a6mr2741032f8f.6.1746797567419;
        Fri, 09 May 2025 06:32:47 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfd6sm3232899f8f.4.2025.05.09.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:32:47 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/8] selftests/mount_settattr: remove duplicate syscall definitions
Date: Fri,  9 May 2025 15:32:36 +0200
Message-Id: <20250509133240.529330-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509133240.529330-1-amir73il@gmail.com>
References: <20250509133240.529330-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Which are already defined in wrappers.h.

For now, the syscall defintions of mount_settattr() itself
remain in the test, which is the only test to use them.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../mount_setattr/mount_setattr_test.c        | 52 -------------------
 1 file changed, 52 deletions(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 9e933925b3c2..8b378c91debf 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -107,46 +107,6 @@
 	#endif
 #endif
 
-#ifndef __NR_open_tree
-	#if defined __alpha__
-		#define __NR_open_tree 538
-	#elif defined _MIPS_SIM
-		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
-			#define __NR_open_tree 4428
-		#endif
-		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
-			#define __NR_open_tree 6428
-		#endif
-		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
-			#define __NR_open_tree 5428
-		#endif
-	#elif defined __ia64__
-		#define __NR_open_tree (428 + 1024)
-	#else
-		#define __NR_open_tree 428
-	#endif
-#endif
-
-#ifndef __NR_move_mount
-	#if defined __alpha__
-		#define __NR_move_mount 539
-	#elif defined _MIPS_SIM
-		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
-			#define __NR_move_mount 4429
-		#endif
-		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
-			#define __NR_move_mount 6429
-		#endif
-		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
-			#define __NR_move_mount 5429
-		#endif
-	#elif defined __ia64__
-		#define __NR_move_mount (428 + 1024)
-	#else
-		#define __NR_move_mount 429
-	#endif
-#endif
-
 #ifndef MOUNT_ATTR_IDMAP
 #define MOUNT_ATTR_IDMAP 0x00100000
 #endif
@@ -161,18 +121,6 @@ static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flag
 	return syscall(__NR_mount_setattr, dfd, path, flags, attr, size);
 }
 
-#ifndef OPEN_TREE_CLONE
-#define OPEN_TREE_CLONE 1
-#endif
-
-#ifndef OPEN_TREE_CLOEXEC
-#define OPEN_TREE_CLOEXEC O_CLOEXEC
-#endif
-
-#ifndef AT_RECURSIVE
-#define AT_RECURSIVE 0x8000 /* Apply to the entire subtree */
-#endif
-
 static ssize_t write_nointr(int fd, const void *buf, size_t count)
 {
 	ssize_t ret;
-- 
2.34.1


