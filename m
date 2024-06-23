Return-Path: <linux-fsdevel+bounces-22197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB69137C3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 07:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333781C20F6C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 05:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6885D1A291;
	Sun, 23 Jun 2024 05:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce//23Ob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1043AC1;
	Sun, 23 Jun 2024 05:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719119512; cv=none; b=ULgd/uqxHUnMZChdGTjcANuWZ/IAb/coqr2XzEL8ioMiCnviscvZpCrYaQx5bjfehdu7NccTSccM00A8nDaqipD/0PePmgopVJ8OBjpy4sZvoyyQP5xCqRk8yJKSZBzqt9SRNa5ogPnRZvxfIEQjDdnHCjdSpAhLQ/hMnIEc4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719119512; c=relaxed/simple;
	bh=/QUee5/68v1wUcGvHi4Bt89dLZeWcXxeiN6N2yNKS/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZtsFZU0zYI3tpqA6fVoTO3CDvHZ2r/dJetc8TKMCMvzGNNOrhF8fs6roF1a9glXZorKzJlfIjX8Ex7FS73qAN50npww+fzLTIeyDNBarxt+1kJYrrndgLfe+IYPTqBmsqsC1KLaWM6ROBSOf4/W6SkC5Nr8kWnVZgrmkFP3AMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ce//23Ob; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d22378c59eso1876017b6e.1;
        Sat, 22 Jun 2024 22:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719119510; x=1719724310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT5cJycHPW4bF7Awhg5sK4H0c0e9ZmnhKDoAOSL0ZBQ=;
        b=ce//23ObV5bfprXOOiGwW42aEOOldNl5WgD+t5bCTe4696AZ4b0gQEXJ6aldYXesbZ
         aWx0rH/6A22DbZnnw5d/mGaDFP4gm+d1GXVtzvx0Zcyjy0W24rlddgUuxURvAa0qn/J+
         w6LtCqJ/LzE0hvJ9zUZI1NsWvPan0hcWchQExlyH3gf8VgT9IENokTHNH7oFuI3ob3vU
         v13/SZN4cjHWcZqMsnSWEApU6H+m5m7SXV4f4lxLt7qdnNmYeL2biwu7V/kC4co+ScDm
         nhs+G9DG3YvDpR8hjzrvWXE3E6bySEkdIj9QvPmktV9kyJi5MLtu42VnsFqu09qFCWHt
         1Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719119510; x=1719724310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT5cJycHPW4bF7Awhg5sK4H0c0e9ZmnhKDoAOSL0ZBQ=;
        b=iuDjUOcnoy4pkwfW7pfOnRvm70bHjaM1mPRtiffrvMCV5K8FldR2gSPYN6dLwqtWz+
         7cDdLkRu5x6B2IX7A0rLWdLOFgphfko7cXDXkSj7q7vX2geC2d5xYmtiAHBcTF2QpGBW
         cC83vJA6mgYqf0vfzeI1SNxIVm61179W083VJVoQOiH1Vn4JcVV+k1N5eo8zpf/xUe/g
         5kL2SfX8eIVBA/ljjvzjOuNwzQj9JNfb4veUBS2xVyfC75W8frJybLXbyKAmrQvnxyxd
         sFXMrgjMrvu0jZs9KDuW+qD46y09Y2iWJuqmIl7xepyqT6vd11+5gxe1mDWqXSnAbmIW
         hzVw==
X-Forwarded-Encrypted: i=1; AJvYcCV6mIWs/9Qs2zB+m2q/KS4oW/NdN6CTKoN0l9KC/x5DAohi9oDDwuiBoOiWeDFU6i8E+c0DVXEg5HUX+cYwgon9Lx9DPguHFwE9Nzf0W1624M+S3kikhgcv+tsxkRFPsXZpqeApsf0tl+ySxA==
X-Gm-Message-State: AOJu0YzsQiH0/ets8w5PiTODTgrMicBpvN/rSHrGHHk30GkPX8C5OOQz
	76RDkzsOUwIbT8zYW6wAfQJ2bvO+WzKes3owS5sYe3Up0bLp8IuQ
X-Google-Smtp-Source: AGHT+IGnkv2J9jT2ewWs/C5naQYApfAEe/3OeTIkIKfra3WnN958rumKElq8w0HQ9/th3kXzzmjWPQ==
X-Received: by 2002:a05:6808:1491:b0:3d2:4820:5ec3 with SMTP id 5614622812f47-3d54589c290mr1810468b6e.0.1719119510285;
        Sat, 22 Jun 2024 22:11:50 -0700 (PDT)
Received: from carrot.. (i114-180-52-104.s42.a014.ap.plala.or.jp. [114.180.52.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512d3034sm4042844b3a.170.2024.06.22.22.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 22:11:49 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs <linux-nilfs@vger.kernel.org>,
	syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	LKML <linux-kernel@vger.kernel.org>,
	hdanton@sina.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	willy@infradead.org
Subject: [PATCH 2/3] nilfs2: add missing check for inode numbers on directory entries
Date: Sun, 23 Jun 2024 14:11:34 +0900
Message-Id: <20240623051135.4180-3-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623051135.4180-1-konishi.ryusuke@gmail.com>
References: <000000000000fe2d22061af9206f@google.com>
 <20240623051135.4180-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported that mounting and unmounting a specific pattern of
corrupted nilfs2 filesystem images causes a use-after-free of metadata
file inodes, which triggers a kernel bug in lru_add_fn().

As Jan Kara pointed out, this is because the link count of a metadata
file gets corrupted to 0, and nilfs_evict_inode(), which is called
from iput(), tries to delete that inode (ifile inode in this case).

The inconsistency occurs because directories containing the inode
numbers of these metadata files that should not be visible in the
namespace are read without checking.

Fix this issue by treating the inode numbers of these internal files
as errors in the sanity check helper when reading directory
folios/pages.

Also thanks to Hillf Danton and Matthew Wilcox for their initial
mm-layer analysis.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d79afb004be235636ee8
Reported-by: Jan Kara <jack@suse.cz>
Closes: https://lkml.kernel.org/r/20240617075758.wewhukbrjod5fp5o@quack3
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/dir.c   | 6 ++++++
 fs/nilfs2/nilfs.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 52e50b1b7f22..dddfa604491a 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -135,6 +135,9 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 			goto Enamelen;
 		if (((offs + rec_len - 1) ^ offs) & ~(chunk_size-1))
 			goto Espan;
+		if (unlikely(p->inode &&
+			     NILFS_PRIVATE_INODE(le64_to_cpu(p->inode))))
+			goto Einumber;
 	}
 	if (offs != limit)
 		goto Eend;
@@ -160,6 +163,9 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 	goto bad_entry;
 Espan:
 	error = "directory entry across blocks";
+	goto bad_entry;
+Einumber:
+	error = "disallowed inode number";
 bad_entry:
 	nilfs_error(sb,
 		    "bad entry in directory #%lu: %s - offset=%lu, inode=%lu, rec_len=%zd, name_len=%d",
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 7e39e277c77f..4017f7856440 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -121,6 +121,11 @@ enum {
 	((ino) >= NILFS_FIRST_INO(sb) ||				\
 	 ((ino) < NILFS_USER_INO && (NILFS_SYS_INO_BITS & BIT(ino))))
 
+#define NILFS_PRIVATE_INODE(ino) ({					\
+	ino_t __ino = (ino);						\
+	((__ino) < NILFS_USER_INO && (__ino) != NILFS_ROOT_INO &&	\
+	 (__ino) != NILFS_SKETCH_INO); })
+
 /**
  * struct nilfs_transaction_info: context information for synchronization
  * @ti_magic: Magic number
-- 
2.34.1


