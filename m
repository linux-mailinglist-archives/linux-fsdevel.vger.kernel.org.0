Return-Path: <linux-fsdevel+bounces-62567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEAFB999D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F83818833CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740E42FE052;
	Wed, 24 Sep 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB1Rk2bz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6105A2E7BA9
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713875; cv=none; b=n33oJMCr2Rfj5BM/ApVVAp5FD7Ano0K8tqGDq6T07rbyQtCwx43MswnSqFJll71u5rAK55uEUFhnGu2KM2e4r/sx1h64J9Dzadx2+pT+O85toWvlyzVcgpCBEVJ/mzppBJ32Hg83hs6kZ5jUDk2+dTP8R3HMSeiQmcgNdv9LU3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713875; c=relaxed/simple;
	bh=BTgYPkpXWTJ3wzKg6hY80hLuF/ObCRTOY4tFMAsjuro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ogjux1DsbUNlCjwkl/qKW1sqo2A589M0gHDbjDSTHpnl+POhYrWGfwLxGh+omdlJn6qti1/hZTGOD+4/h6F9vC+zG+PR15WkycqV/hfDJ3yasH6euho9q6+WYOJFiwufYrwS8NAKWMV6rbjoDG3xSUh2VeOxlh2v4BlVcDLrt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB1Rk2bz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3306d93e562so5996840a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 04:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758713873; x=1759318673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mRYVyzheAwZ8osfGPBBGeLi3ZyBejqOSryW/UzRDTV0=;
        b=nB1Rk2bzs2f+Gbpuzl24dZZltbI5F33Nxgde5I/FmZAgFPzlJLbOI7CPbjZJLWySKx
         7nTtWJv69ytqpNYPRxFwz0d2hNPhMp7VCOcExELioCCAD0YBbag9Kp7+MKNkv4AygdhM
         DyviLrnaGsG7+hb6sqI5uAf11+TL3EYLzZEx0yhRG5zJL+esc26j9+12lODmlRJRgqaT
         IZtbmGIk6JQFJhIMJhvJK3noeSc/x3ReTQ2BgAH4XETIdNLkkC3b1bF8M0Da8BD0O4Gr
         HD0DNRiV/iTsF+2RuhBCfCvWmgR4PHNVHWNxY8/w6mkQ9RHSRXmajPqbAObe9jj2J9f/
         5sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758713873; x=1759318673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRYVyzheAwZ8osfGPBBGeLi3ZyBejqOSryW/UzRDTV0=;
        b=w9jCbtmmFAQVFhaJ8nt1xDcqCIQkayjB+qNSi0NYvt9yIbSZ6UtPgV+0f0CICgHFwQ
         o9SX1aZQIAMv2jwzGTT+UIG2lj9ULF8DuMEEh7f+EZ9qXf0FVSIUfJ55gtK8M2fpNRbD
         EI8cYR2UqyJ/DAIY2CwXmGc3ToroF3Q3VMX1dHGQ0NQD35J6Wa8y5tfMuPp/ivq9cyrQ
         1mEFRhKKL94EdmIn4yBJtvoDXItlLd/aI9i4ydW73Tnz215HykQlOKI+QO6E2QR3ZZi5
         tvAhMtxZ9XzMNPyd8JzioOT9ANbu1w6V20IwGrDvIkFHR05+FccbbuZ34macvF+89gw1
         FeMg==
X-Forwarded-Encrypted: i=1; AJvYcCURCr0sKEqXGFtkdz1vSyKTM+x8oUuHBw8IR/7kIWsyGbgJr3mOqV9DsDqBrcWbaaucwtdXFuPBTbmLUJM6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjcd9O3L9KQebxcRpoqji6PxRRPASE0PMpsBKT+88kga84L3GB
	jmmoPj86AvRDcawRpVqPu+tdvcZ3rdhCDRtYqdxC3woGoP1nnzYWPCmV
X-Gm-Gg: ASbGncteY52GIBlsi0BuEPW7CRVT5zCXfizCKh6vLiP3ZiVhhgXfHqzCrLnXQaohnAt
	HcUx1fJ4BoH9icgQjaSKaO/KHY+MXg2h+ZYbLpVWHb6zVxnrQve6A8fHjaLIW9QCnco/Zh3/kSN
	kYlv/O5H4f+WhGdMR2OWZzqLZXqD5ndF+EcNdpdQYH+HgPf7Hl/3sY3DCqCRGBL8JxBAJB4nw0z
	bHiXWzoXBdj5BUxiEggCkfK3OuFiMyXFz/j50Cs/O6OgNaNcrt7bsuoJkVzNqLKjkwqM8XUwKRR
	9QTGhErm+/O8t465waxTEiYf2ZxgLc8r+q4Nw7qjy0eAzMu0X+teJe836vSzr6Th+qlBEy4FRGR
	6a+4kWdigCGE80352pLR4FcdBjrBONeCUTgdvNKNLQzvYhdr1yPRCzEC1ZOq0q3TcX9TLgo/zWk
	QN7gs=
X-Google-Smtp-Source: AGHT+IGmHCwTlAKe5f/2j+sj15VZ0PFrj6hvwkJrV/TiWCLkMkocBxV38Ih1VWWQnTvSw4cvbpsxbA==
X-Received: by 2002:a17:90b:3d09:b0:32e:753d:76da with SMTP id 98e67ed59e1d1-332a95e9263mr7253575a91.20.1758713873531;
        Wed, 24 Sep 2025 04:37:53 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:e599:c13c:81b7:3864])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-332a96fc922sm2462606a91.4.2025.09.24.04.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:37:52 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Subject: [PATCH v2] nsfs: handle inode number mismatches gracefully in file handles
Date: Wed, 24 Sep 2025 17:07:45 +0530
Message-ID: <20250924113745.1262174-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace VFS_WARN_ON_ONCE() with graceful error handling when file
handles contain inode numbers that don't match the actual namespace
inode. This prevents userspace from triggering kernel warnings by
providing malformed file handles to open_by_handle_at().

The issue occurs when userspace provides a file handle with valid
namespace type and ID that successfully locates a namespace, but
specifies an incorrect inode number. Previously, this would trigger
VFS_WARN_ON_ONCE() when comparing the real inode number against the
provided value.

Since file handle data is user-controllable, inode number mismatches
should be treated as invalid input rather than kernel consistency
errors. Handle this case by returning NULL to indicate the file
handle is invalid, rather than warning about what is essentially
user input validation.

Changes in v2:
- Handle all inode number mismatches, not just zero, as suggested by Jan Kara
- Replace warning with graceful error handling for better architecture

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 32cb8c835a2b..002d424d9fa6 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -490,8 +490,9 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 
 		VFS_WARN_ON_ONCE(ns->ns_id != fid->ns_id);
 		VFS_WARN_ON_ONCE(ns->ops->type != fid->ns_type);
-		VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);
-
+		/* Someone is playing games and passing invalid file handles? */
+		if (ns->inum != fid->ns_inum)
+			return NULL;
 		if (!refcount_inc_not_zero(&ns->count))
 			return NULL;
 	}
-- 
2.43.0


