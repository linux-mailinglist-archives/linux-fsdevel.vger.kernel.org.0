Return-Path: <linux-fsdevel+bounces-29746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324FA97D561
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E75283017
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DDB14EC44;
	Fri, 20 Sep 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnX0Pxif"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1DD14D431;
	Fri, 20 Sep 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726835339; cv=none; b=gPodiOqLG+ZSwmGFrfkCfeoHTJQPJlfWERn72HLXzg2KaL3GXtballJd4s9ooLGjsmhMz9fV0oSxRMB87o3I0skE28Sy3yUjZg+Z379d+1P32EF1llzP6H3e3022l5VJNYt7UBCFBHerdsPp5luSIhaPvfxi6iLQf/uhv/RE7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726835339; c=relaxed/simple;
	bh=0C0JZ+UA1yEmAscOepDgdd0S8z61bIz8VYuFtd0ruwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QjQaKGx1AQPKrAj+D7XQQqu0FPQ8sa5a9b0Yyikvmu3gMML0AB1TcBdse9gqGxcNuwnut21nCGAjAmno66jMeJL/v2sFJGJ9ZYDrsPRXze/nzQsQZXuRA2CGIakcmOKKZpxGFMo6DA0XIjucHRjF80YQWcFovOzbzmN7AidttsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnX0Pxif; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20543fdb7acso17105255ad.1;
        Fri, 20 Sep 2024 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726835337; x=1727440137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCZKrYRGnZp8/QINcXPzi68Vv44RMSIFUQB1DI3ntCg=;
        b=BnX0Pxifj4nbaWLt1eawX2QKIFfhuShP8nJaYSp7CvxeM2dBxnAco2ZMApS37cnWME
         eCwZ8ktw9iSKaqFXya87fDfl0QTR6hZTiv77gy+EtCRRIl/zAlA/ABNdg4bTDP3/nDCP
         EbjVK6PDWP/fxKfM75T8c25H+jnwuocopyz7P1+wfsnaUsPPE/kqb28JbdqdEYWv5KOt
         7g/x9LHyHtfhi2l9kolD+7cTo8n8ZzBFVHsEHSFgXmDoKFvYQifM/Kg0Vy/b36tU01V3
         tT5kuucSvmjetKQ5HagXGn3I3oG122vgCxYdaXgXzQZ3qGlPc0f8BBd39LIVGm4ESWGD
         +d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726835337; x=1727440137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCZKrYRGnZp8/QINcXPzi68Vv44RMSIFUQB1DI3ntCg=;
        b=s3EozwC+jMp8VyDq5votHzmMbpwm9BHcCLtdj3M4MvvBBQKYMjj+9HacHADnlb9aF7
         +hz9eEljKkdRHlGSzgP/IgFIs3ZgZkQh7DkG4//4Lvhjd74BZqf/L5wEWa2DclKELZmO
         WdvejntPOhQIsco1Sro91xjcW8GvMx0cKDUqtcxFMGGCiplVtIDNEGfBzHWmvAGrvBUG
         nZ7t8exAuQzDctcapmvHztM4v3CTej0JOZ7tH0S5Vg57lw73iDCOcogqU0A9dU3wcKhH
         XyUSwtw6VGNhkSy2MHbjstda4zz99ufzKHpL4HVXxBF5RJBNun55KTkHkRWW8YApLhGz
         faxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/dws4uGdpm4GdvqoCO2VvWDT7pd9a4Ox0Kv62qjVo458u61pyLgCXI8SXr104UugZ5O7JqoMWcM=@vger.kernel.org, AJvYcCXoUTez4chZmq6HPt4yfWULOQg7y5oPa7wpJkEXGiOkSBZuHBhq64kb3FbSBy0VeBB7gJ1ix6He@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8KgjIqc/Bt19Xnm+CPhzY9NkQkLxtk+Maf17phAT3ohhllXN
	p1R9P4BF4mquawCAuIvlcQ6D04V63HmG3GUQm0blqvFvsAq4H/TH5dQxJuJM
X-Google-Smtp-Source: AGHT+IHqMFAI985wyoekDNDZQueMgwrmOzQZ85fJmKSimElHry5xjKW/lB/SBfH3if+HeiadiPo2Fw==
X-Received: by 2002:a17:903:1112:b0:205:6a4c:9a20 with SMTP id d9443c01a7336-208d83d67a2mr36018675ad.34.1726835336592;
        Fri, 20 Sep 2024 05:28:56 -0700 (PDT)
Received: from localhost ([38.207.141.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794603792sm94758945ad.106.2024.09.20.05.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:28:56 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	stable@vger.kernel.org,
	Julian Sun <sunjunchao2870@gmail.com>,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/3] vfs: Fix implicit conversion problem when testing overflow case
Date: Fri, 20 Sep 2024 20:28:51 +0800
Message-Id: <20240920122851.215641-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The overflow check in generic_copy_file_checks() and generic_remap_checks()
is now broken because the result of the addition is implicitly converted to
an unsigned type, which disrupts the comparison with signed numbers.
This caused the kernel to not return EOVERFLOW in copy_file_range()
call with len is set to 0xffffffffa003e45bul.

Use the check_add_overflow() macro to fix this issue.

Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
Fixes: 1383a7ed6749 ("vfs: check file ranges before cloning files")
Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
Inspired-by: Dave Chinner <david@fromorbit.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/read_write.c  | 5 +++--
 fs/remap_range.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 070a7c33b9dd..5211246edc2e 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1509,7 +1509,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
 	uint64_t count = *req_count;
-	loff_t size_in;
+	loff_t size_in, tmp;
 	int ret;
 
 	ret = generic_file_rw_checks(file_in, file_out);
@@ -1544,7 +1544,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 		return -ETXTBSY;
 
 	/* Ensure offsets don't wrap. */
-	if (pos_in + count < pos_in || pos_out + count < pos_out)
+	if (check_add_overflow(pos_in, count, &tmp) ||
+	    check_add_overflow(pos_out, count, &tmp))
 		return -EOVERFLOW;
 
 	/* Shorten the copy to EOF */
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 28246dfc8485..6fdeb3c8cb70 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -36,7 +36,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 	struct inode *inode_out = file_out->f_mapping->host;
 	uint64_t count = *req_count;
 	uint64_t bcount;
-	loff_t size_in, size_out;
+	loff_t size_in, size_out, tmp;
 	loff_t bs = inode_out->i_sb->s_blocksize;
 	int ret;
 
@@ -45,7 +45,8 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 		return -EINVAL;
 
 	/* Ensure offsets don't wrap. */
-	if (pos_in + count < pos_in || pos_out + count < pos_out)
+	if (check_add_overflow(pos_in, count, &tmp) ||
+	    check_add_overflow(pos_out, count, &tmp))
 		return -EINVAL;
 
 	size_in = i_size_read(inode_in);
-- 
2.39.2


