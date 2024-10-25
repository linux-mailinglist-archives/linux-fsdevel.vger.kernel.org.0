Return-Path: <linux-fsdevel+bounces-32846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AB79AF85F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 05:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E361C203AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2429518E772;
	Fri, 25 Oct 2024 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGkqBSfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41418C002;
	Fri, 25 Oct 2024 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827982; cv=none; b=jU/WLku2A3ByKQtA8jTK2r+LZNcTRlBZKOv8D+RlRhHbiA/3GzOQKBmT4G4MIlFYo/wCQWZ+LHdUqjipVYTl/18ag7LP8sXKV7R5rvKvFJzO5VWAn5r1O+peo9WWx4BCdx+hpPOn7hITgBI0BILBUF0gQXZeEuZ4DuSt+dvWzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827982; c=relaxed/simple;
	bh=Q3hxmOKe82lS5vX342pUSY/mMSr9097HfbfclBSB2OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY/7lZvOfcpAI2xGn6CnsW3ZLeb34UROevXNEx4F7qxXvfLEVuVnsZvLnW+OiHO/IjUUr+sAz9xVHb9cMeiNEw6yyh+B5g6EKrE4iK+7ANPjz4Qesv17LvWXIyAcNNOdONgh11shZmgtmpDP+uonipLpnW9KOPyVZkNAqWIDgG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGkqBSfK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso1857320a91.1;
        Thu, 24 Oct 2024 20:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827979; x=1730432779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKwoVnXKo4H7aU7EFii2WWb3tQsQ8MP2woOEWaoMknQ=;
        b=XGkqBSfKH0tCsncfEvIDwwdKKngL5WCnuGvrclrNl0b6OrZjtZgtO5fe34yECQE80Z
         Rzm1pGVeeXedUVK8tYEaioyLmjcqpbDZRHFCpfmTKOZj93KrGFbih4L9wYfaCuC2SeAN
         7epnm17tpBvkrmKcOHG+OF5QpVdXGmmHTrdAXwwSA9sfZ8apu1ixeMYB1vF4aN43497f
         Tlu/7xk1rV++2csAqXkvMLW3JYxq5q4usgdQ80dP+AKgcI+8tkNTI0DEgwJTttmgFtz+
         onzqyY8QBbQpEcT2dfxagBQRGPjGKG8nXj8PkT7u/mVkj2SEJmvOo+oHCJSGoNfrtPhw
         xXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827979; x=1730432779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKwoVnXKo4H7aU7EFii2WWb3tQsQ8MP2woOEWaoMknQ=;
        b=gzH0dMTOzOuE/DvmFXEm0nj0pQCK5Kk/huRBgHdLWDc2xczb/I7N0fi5mEtyLLqJ67
         CgXbhKDh02TcqLSLstHXiW98NjHU/dmYEsSV5ZHSKCF+P+vt7EKHWBDnnnf4NM/JmXwz
         lOabFGw9e7UmhqpaQhHnUD+cv16JSd25rZSiC56Skl4MA/va2DGRBBpCitpGaJvyt5xQ
         D5KpD6+wZhFK0XSuQBliMW0M8WeElY0TEoqvTymxuR7z6aMRJoeKK2Mm9uJ9HK7X/OT2
         MZVu6jw27/DI3eZMPQZb75hFS8MEO7stdpI13Rt7pxYm1Q/oK//GlTTNFovrir4ew58S
         xxnA==
X-Forwarded-Encrypted: i=1; AJvYcCVNdl3qfFgQJ7ULhwRWYIUg6qDsHGZg9hWvIQntySeo1DJ8h10bGQEqS+jR+YakKrVG0bNg2dT66xuIsOr5@vger.kernel.org, AJvYcCW2dpKXksM0T0A0UL+FumX0Mu1B7L66BGd8wA/pBHx+wNKjNO7ssxyJhsb9DxTV9skQcnZuf5K8ErjSCnth@vger.kernel.org, AJvYcCWlJutMMBINFqDHsgglFy4ohKKM72nyfg4F1bSiCO9+jix8J8kxF7TOFVw7reHfAwUccYXiJOcBh5qe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vuyEFk1mjpzev8QBqI3p/2yE5hrd0VVylbysNBaFtNOJYZUl
	ouS0YYSVZ5Vy2QC9UlPAzGlkZnVgUNNMRWCr1gmuk2DQRZ8RdEc9NXet0A==
X-Google-Smtp-Source: AGHT+IGfwm+lE3tGHnzqEpua6Rp6W0zNi1Ts7IPa81Fl2Mn9wcJO3JSxDkNBrHaYeL2o2l/KFD6JAw==
X-Received: by 2002:a17:90b:4b46:b0:2e2:c744:2eea with SMTP id 98e67ed59e1d1-2e77e640bdemr6447296a91.13.1729827979024;
        Thu, 24 Oct 2024 20:46:19 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5df40265fsm3463176a91.0.2024.10.24.20.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:46:18 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 3/6] ext4: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Fri, 25 Oct 2024 09:15:52 +0530
Message-ID: <921ffd8731b666b8510e56dd1981a995f57873e0.1729825985.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729825985.git.ritesh.list@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FS needs to add the fmode capability in order to support atomic writes
during file open (refer kiocb_set_rw_flags()). Let's check if inode can
support atomic writes then enable FMODE_CAN_ATOMIC_WRITE.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h | 7 +++++++
 fs/ext4/file.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a41e56c2c628..78475ff14aa2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3863,6 +3863,13 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 				  loff_t pos, unsigned len,
 				  get_block_t *get_block);
+
+static inline bool ext4_inode_can_atomicwrite(struct inode *inode)
+{
+	return  ext4_test_mount_flag(inode->i_sb, EXT4_MF_ATOMIC_WRITE) &&
+			S_ISREG(inode->i_mode);
+}
+
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index b06c5d34bbd2..f9516121a036 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -898,6 +898,9 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 			return ret;
 	}
 
+	if (ext4_inode_can_atomicwrite(inode))
+		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+
 	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
 	return dquot_file_open(inode, filp);
 }
-- 
2.46.0


