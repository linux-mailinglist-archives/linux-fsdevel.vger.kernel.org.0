Return-Path: <linux-fsdevel+bounces-13358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC886EF45
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 08:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C633FB250D9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 07:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B542232A;
	Sat,  2 Mar 2024 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuGZblZm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D22233B;
	Sat,  2 Mar 2024 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709365378; cv=none; b=jGE2ROM9VeyHwgD9g8PTQj4FBCe4BIoHgdQCAGJi7m+qySElU8dlLghkmpBJzGFAq1UHcAlpIoqxxZtLeGAb62Wl1b99IawSuYpLFxSaKyv6krRN9CPummptQgoFu3bNLogQH1XNQfcBVTPon9XLtQxrjwBqkqRUL3f/waPv3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709365378; c=relaxed/simple;
	bh=lN4TxJsiUeFt/fuNQPZHvw17F4IBxs8TjYTF/9YdosE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gN0xmTOMjs3JXaDCVfx6vw8PIPmdyNbbb23+gSj3if6CpypFFJl+kCIDe1L+IKYBAcXx7UODrB+Yvp8uQtB+zuJi0rAuHCQdXrGxv7HPWAa3sR/ayxP9QjW323yC7IePdxwvhh6GDfJI0mPn92RyqocxWBxicK0O+FeYtU8WkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuGZblZm; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbbc6e51d0so2037384b6e.3;
        Fri, 01 Mar 2024 23:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709365375; x=1709970175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ng/bkdiZmf26t7FmcNycgQvNgpchjoGQ4iAQnfo8mo=;
        b=kuGZblZm9EvO2cmvh36J/3PIbHKBjPveYu7avwYOsDM0eGYOUb1HYGMnQm1JMLCfBc
         sFsyn/a8ogQ9UxVhMcaR228k09/rWfEfFJNw8Ia9ZHjxLDkOJifHKQGoA8wcLuO+AfOL
         ARJxBe85VRB+31WB4pAL0p3/cYtZIREuNwSQrludIkyCR5gTqdibDAjI/9fUqnPAukO8
         sTLbwC3L4WZ9lqk8QGJwixRn4fukMqUOvYyPu/1qsJN7r1IBO30dJP/MqNAhayOuRMew
         qWvHeQbitJI7LMFUOlARhIQq7puOHWnk3MGV1JUK2jnrfOSeSAm5RF0in9x5Aq3DRTFs
         U5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709365375; x=1709970175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ng/bkdiZmf26t7FmcNycgQvNgpchjoGQ4iAQnfo8mo=;
        b=f604hjEWHFRMq+EhO6dLtMhe2faB/eYD3SAK3z1YR8MKQK6MGzgvqieIOz3ycyZpjV
         mMRItDP4Cwosn7DjDm1/6tLXp1/vIPDJ/LeqeJuoISZ+WU61DGsXGZzfr+rvfCfoQgWs
         ZPXP/TOwccxolfC9bWgZ5hxNqatTkDDTtsjzvZNgpwccjN70+Nxa+C7pZ3mAAvbH5ESv
         pOH8CQRfInuWwnJy+cipxnmuTNDAXoSodYRnPG5E0fjLIYtd4ZtqpR7gCr+vIAYeqIvg
         SlRQ/QFHbd2d28qC391OX0nzYnfgFAG1Z3tcthERm4dP64Lxh4th9OmPgtQe1JA2v+h2
         XW1w==
X-Forwarded-Encrypted: i=1; AJvYcCWr8yBnydXCxyiJ0Mhdn8MVRWzSByQakXl3ezAxNV3GBQ0GgKaQPBTMqtr0dQfZfjkcZVc1B/A+MXlYQB6lJHLoKxYnIBbjijUoUosvREYScLs3zAUMVFskSfdaPhNB9w/R7CMjKtI4dw==
X-Gm-Message-State: AOJu0Yy9T8gdCDwNeK/nqOv7ICjWPFNxWTPp2WOvzt5ZquW/2YnzcOD/
	nHZXr5kGj3zeUSQS+61qChrL3ktTcO9dk1ofGLVto9ixfnOInaEMzsdRqj9d
X-Google-Smtp-Source: AGHT+IFFRxF5/IA8cOYk9zucRjrGH6LJnL472Gl4p8hxv2v0pEQdGtAdKJuF/JsB60rnL70SP/ALcw==
X-Received: by 2002:a05:6808:639a:b0:3c1:a3df:fb6e with SMTP id ec26-20020a056808639a00b003c1a3dffb6emr3734033oib.18.1709365375491;
        Fri, 01 Mar 2024 23:42:55 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id x11-20020aa784cb000000b006e45c5d7720sm4138206pfn.93.2024.03.01.23.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:42:54 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 8/8] ext4: Adds atomic writes using fsawu
Date: Sat,  2 Mar 2024 13:12:05 +0530
Message-ID: <52a5d4d2191b289fa013f764efdfad93c8acb3c9.1709361537.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
References: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atomic write using fsawu (filesystem atomic write unit) means, a
filesystem can supports doing atomic writes as long as all of
below constraints are satisfied -
1. underlying block device HW supports atomic writes.
2. fsawu_[min|max] (fs blocksize or bigalloc cluster size), should
   be within the HW boundary range of awu_min and awu_max.

If this constraints are satisfied that a filesystem can do atomic
writes. There are no underlying filesystem layout changes required to
enable this. This patch enables this support in ext4 during mount time
if the underlying HW supports it.
We set a runtime mount flag to enable this support.

After this patch ext4 can support atomic writes with pwritev2's
RWF_ATOMIC flag with direct-io with -
1. mkfs.ext4 -b <BS=8k/16k/32k/64k> <dev_path>
(for a large pagesize system)
2. mkfs.ext4 -b <BS> -C <CS> <dev_path> (with bigalloc)

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h  | 28 ++++++++++++++++++++++++++++
 fs/ext4/super.c |  1 +
 2 files changed, 29 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index aa7fff2d6f96..529ca32b9813 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3896,6 +3896,34 @@ static inline void ext4_atomic_write_fsawu(struct super_block *sb,
 	*fsawu_max = 0;
 }
 
+/**
+ * ext4_init_atomic_write	ext4 init atomic writes using fsawu
+ * @sb				super_block
+ *
+ * Function to initialize atomic/untorn write support using fsawu.
+ * TODO: In future, when mballoc will get aligned allocations support,
+ * then we can enable atomic write support for ext4 without fsawu restrictions.
+ */
+static inline void ext4_init_atomic_write(struct super_block *sb)
+{
+	struct block_device *bdev = sb->s_bdev;
+	unsigned int fsawu_min, fsawu_max;
+
+	if (!ext4_has_feature_extents(sb))
+		return;
+
+	if (!bdev_can_atomic_write(bdev))
+		return;
+
+	ext4_atomic_write_fsawu(sb, &fsawu_min, &fsawu_max);
+	if (fsawu_min && fsawu_max) {
+		ext4_set_mount_flag(sb, EXT4_MF_ATOMIC_WRITE_FSAWU);
+		ext4_msg(sb, KERN_NOTICE,
+			 "Supports atomic writes using EXT4_MF_ATOMIC_WRITE_FSAWU, fsawu_min %u fsawu_max: %u",
+			 fsawu_min, fsawu_max);
+	}
+}
+
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0f931d0c227d..971bfd093997 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5352,6 +5352,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	mutex_init(&sbi->s_orphan_lock);
 
 	ext4_fast_commit_init(sb);
+	ext4_init_atomic_write(sb);
 
 	sb->s_root = NULL;
 
-- 
2.43.0


