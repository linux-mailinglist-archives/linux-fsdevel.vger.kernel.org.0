Return-Path: <linux-fsdevel+bounces-62572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BA8B99A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E742B19C60D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8192FE574;
	Wed, 24 Sep 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB9uPCkF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA231922F6
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714669; cv=none; b=sqJfMXE5qhgb9+CZoTz5nRYt1kdRlDxY2eXiG49aTAhnbsv+0Jx8Oi9rHyVpFO9jvAFyweHaFxp/CKZz3zWrEV5e1dwAfN1HCD7q0AFavWYidgxPa/oDQG2CyeAGJQ2HjZ7ep3eNTpirLj0cdercK1GjYXWEzEMvyb/Jg+VU2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714669; c=relaxed/simple;
	bh=sMpMTCHL318ik6vynlaPqZHJ3YUjKajXTIqWy73CgGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOwQQsPpCx5IsmLc8xfA8RrYCDRhUaoGNdcsX162b5MLq+wzpZHSdsr7hy+4lbpaOLccyDkmnfOs/qLXkXM/psfNTPatgbfGb22YqyUVAeDfEMfUTUo4Xm+pVzY9gbR+7D2/g9hnlFnb1qzctoi8umPVUTqERCxZ53OWJRu6Q7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB9uPCkF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f2e960728so4181036b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714667; x=1759319467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AdemVkqDIFv6mvv4r15R9buAsMv1Uh4QcRMWgVwjFE8=;
        b=UB9uPCkF4fyP8j2H6omASOnmrU0ySt7nAft6yqGFxp4Z9JdENnJIGGx+znRQbwMcOA
         zraG9ETmBPfU38Xih2gzHGGugvoTD6vhedpVtWLVZGT5Y/QP+kxp5u81m1mV8ALTotzt
         h9nG8I2lYrvvjIzUoOE8JyUHhV2xAWTUuIA/99Qy6PyzFaxLesE3IVSB8bTzrrr3rJhG
         1mJBFQknQeDpYM3ghNfXtyRPmKErLXi47fsMCFvM2gntbACcbxq8wzEcgX1Wg0TFZ/Tp
         tVqkSGxDK0VaCZyarPkKHsdKLZA2JIshGpceC+66mlJ3P3iwQwFet/gqRp871pI09guD
         x3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714667; x=1759319467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdemVkqDIFv6mvv4r15R9buAsMv1Uh4QcRMWgVwjFE8=;
        b=nXJRsTx/gfjj9oIwlzuyl5gLl0DuQdLafil/LWPdsp8FHSmQ2gn513A5Dz3m40Yqz1
         KaHGA84QgVoiEgeuDcWtAL+27Dk6eBgGN7Vqnlgj+OT4P+YzUz+2dy5l/KUSOzI4SEOV
         0cw5qZYu1P5vxD9YH8pJpbFl9VvCFgMY5mwCJoenNzeb/pnjdiAbfjOnLV4Hm+Z86dw9
         kt8sAIWTc2pDgHEkSeS/ZYkgL12A3rhKExGlORkddXJSd7fITNlqUy4TnBuWBrzeBsC0
         UHHTPOHZoT9T4hwmzvXH9sKeHstAJKpGRB10/CCErvCfTUOey9aTXhh/wR6PfH2fTQG5
         TauQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFgnMICJQdxFBbPCGbX9eB/QnfhFqnAIRBR8Kl9zN3HHoecmluWavIY3qc2feg+NP6FpGKoQDayQqNjEp7@vger.kernel.org
X-Gm-Message-State: AOJu0YwvMym4DlNtEDp+zYIdtFMYqKpVrRUrkMfrLWRxpThMOd5/3h74
	kvMHvr4GSrb/UUXqhXMoeRy7E40Ubk6TkV/Ab7j/MWsGEEX7EtfqGQhycao573Hr5bk=
X-Gm-Gg: ASbGncuBcmeHRlm3TeJ3JPHvthFrYPnRkbCl6H+YeFqaq1Cu2e5nlQl3+Z0t1gmoPYi
	/RoMj7gADw65tlDW7/mJdIljxEg2T3Kkwc6/FrMBaIICAPTF05FE4MxaUQ78W16gmv5HbVN47tH
	g51hI6bO7UA5IdG11X1TrubQbFgItzvxma6IMC/FIvMucBEY0lvVnzOJRlqn42Asmuzh1IFVUYW
	0A9PxOxPEhAg/VGbSP7GnsVny1KYsThGoDtwdEDbNYtkAkE6AsmHQdAgGhnrKzgmwIBdxg9EUf5
	1iK7uD8sKnI4h22ZkxOAQNuE0C4Y+1fXUycmEyj7Dm1zWLB0YSEQBlQNsc+koDwRVEJT1E+PiYs
	t3+nUZ4f63qdANqldrP2We80WsaRt7Ddg/ytS9IPVgUQqaZ1qideZFyTorvTQHyAT9KqkNyt8cS
	4HaFhjMMjQANMtXQ==
X-Google-Smtp-Source: AGHT+IHufTiK/baJS9Oy3ntOrLfKf9tdtE8l8xl6OU+bWCyFqVpTcNJMnarEK1TcF7eHmncL6YrTQQ==
X-Received: by 2002:a05:6a00:3c8b:b0:77f:2eb8:5959 with SMTP id d2e1a72fcca58-77f53aeb466mr6942136b3a.29.1758714667308;
        Wed, 24 Sep 2025 04:51:07 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:b157:e484:932e:7ded])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e0bb98790sm16151926b3a.9.2025.09.24.04.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:51:06 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Subject: [PATCH v2] nsfs: handle inode number mismatches gracefully in file handles
Date: Wed, 24 Sep 2025 17:20:58 +0530
Message-ID: <20250924115058.1262851-1-kartikey406@gmail.com>
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

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Changes in v2:
- Handle all inode number mismatches, not just zero, as suggested by Jan Kara
- Replace warning with graceful error handling for better architecture

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


