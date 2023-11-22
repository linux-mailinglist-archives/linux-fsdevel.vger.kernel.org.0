Return-Path: <linux-fsdevel+bounces-3356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056BC7F410C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E581C20938
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B873C093;
	Wed, 22 Nov 2023 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2xzfo28"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090672D63;
	Wed, 22 Nov 2023 01:02:26 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1efad296d42so3735574fac.2;
        Wed, 22 Nov 2023 01:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700643744; x=1701248544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tokSOc0TdXG/uQLa497JlHnMMxnPUsueInaFp+BfTKw=;
        b=k2xzfo28Mxy8PUVjU9Gv5HTAmzX8GnuLY0oxHRB+2ffTZSiuc/71Hn1Jpkz+HoVUBi
         Jhp0z7TJjxnkDMASb0Lunk0CKTzQnHHucjA/ZmU4ZPFvGZTZYx6D4Yf1nGRQ5B9LxQEW
         5YnKb+AYZeknpKqiJ+mrMBif1l5cM8F2t43/tsXne4WeC1qX7LinGEctVEgPGH0DEEHx
         VUWVf8X6Y+J1t30iJ4hII3KCMg/DI+6K5gEytAU/kyhNtvqdzfWNNnSMdje9wMw7tfLW
         30o0sVIXSLYtafGk0zK01jIrqV3NB+hhnxZikBVq8qbBfNh45oMVhP3o/xsMdkI3HU30
         ouUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700643744; x=1701248544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tokSOc0TdXG/uQLa497JlHnMMxnPUsueInaFp+BfTKw=;
        b=L6bI3heJ+ykCMlmreZchiB7+zxWo3ejKv7ScuOitAk/cIJTjZFPtenvpvS9LXNvhfg
         Mzf/Oul6vf7LyOKwICXbtz5jq0CvYKrM+jYuP+vCBj8XhnSqWnbeCvMfG/j4DSeC4Qae
         FFC/+901PtF2jp1phCpABcRg+/Y22IIQCJfDQIMPbntCgA/xQMcwEWenBe5T69K3i+y5
         Ak0Ohn8KJgBIkC9523sD2d0Y2jBIB/bWXzTcnNusMNne6peCQqkV/jyEdxysSnzN7ubh
         uK7CZ8OoJKsARNc3qBE/Hxq8jc//KJhSn8y0EtQtlApwZPLDGq/o2W7xZGkzjp6GBs/p
         +MAw==
X-Gm-Message-State: AOJu0YyIY8g/atqYQCZdXva9XnAlSqYuBr/nplK7clZ2lw0SQqUw+CbB
	yP5ZzG/9ceTLmSZXhdueA40o1PurE6Q=
X-Google-Smtp-Source: AGHT+IF4/GDkzqf7eP9RITDd0K2bsZIS05m1/VSNnpZwu2ZRS46hpqUAw98QTN5aaYBEqLeTckyt1w==
X-Received: by 2002:a05:6870:9b0c:b0:1f5:b5ca:435e with SMTP id hq12-20020a0568709b0c00b001f5b5ca435emr1917525oab.52.1700643743997;
        Wed, 22 Nov 2023 01:02:23 -0800 (PST)
Received: from dw-tp.c4p-in.ibmmobiledemo.com ([129.41.58.16])
        by smtp.gmail.com with ESMTPSA id o9-20020a62cd09000000b006c8b14f3f0asm9717646pfg.117.2023.11.22.01.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:02:23 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2] ext2: Fix ki_pos update for DIO buffered-io fallback case
Date: Wed, 22 Nov 2023 14:32:15 +0530
Message-ID: <d595bee9f2475ed0e8a2e7fb94f7afc2c6ffc36a.1700643443.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit "filemap: update ki_pos in generic_perform_write", made updating
of ki_pos into common code in generic_perform_write() function.
This also causes generic/091 to fail.
This happened due to an in-flight collision with:
fb5de4358e1a ("ext2: Move direct-io to use iomap"). I have chosen fixes tag
based on which commit got landed later to upstream kernel.

Fixes: 182c25e9c157 ("filemap: update ki_pos in generic_perform_write")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 1039e5bf90af..4ddc36f4dbd4 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -258,7 +258,6 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out_unlock;
 		}
 
-		iocb->ki_pos += status;
 		ret += status;
 		endbyte = pos + status - 1;
 		ret2 = filemap_write_and_wait_range(inode->i_mapping, pos,
-- 
2.41.0


