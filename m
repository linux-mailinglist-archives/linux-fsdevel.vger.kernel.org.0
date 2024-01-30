Return-Path: <linux-fsdevel+bounces-9571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0FA842EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29214283450
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DF17867C;
	Tue, 30 Jan 2024 21:49:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DB38DDA;
	Tue, 30 Jan 2024 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651379; cv=none; b=Sb5LjrEYg+KB9pvY07MwuQn8qG1a5gWxff02XU4Da2jMpKfysLJMu/7Xe/x+5+/xuJujc2X0zzRzW0FsR9aMAcyLDZW3+mvvUAsQbDCl+1Kq+pEnSj/9pDESISkhXW6LBjQ4AokkddH8Z/DSoM24//z7e50zGxRwmSr+ue7qnZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651379; c=relaxed/simple;
	bh=CxuIjzAuFPsuQ2mGh2GtZYv3uzrTRgT4sTYAH4YjEGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kShbQ1l8vyqAr8wffKeSDBFcw7G2VaEcdsXjoNArsEsvLiOj+8Ss+ebkS3nwOP5abBiqDWT18RfER78fb99fITFsslLL+7Z2a4hWeZDiuBDSYe1Alb0wEUc4UIcKaGzH0cE5/YOgjeWzpjn9l2RE1IxnkBL8ZpUNuEri5Q0jub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2533940a12.1;
        Tue, 30 Jan 2024 13:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651378; x=1707256178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QD+F7yRBzRHQujQndodnozYpP+7wyWwo1I/tKuhJ6A=;
        b=Hx/EPH3zZjMRe1opCvmk6WEsUp+M7U68vmeL5ddOFD+DJrgDibg0VgUOUN1b51YgGb
         7v9AKVbeARPA08DE2BC0jI/IkYEUvIeTwJdpka22IpJrFtTDMVhTNdqvSMzBKY+z37Xb
         ug0oDhw1B2knvGsL4mbfnwGqPpo/SkA+sg15RxmuxFeLKSneLGMgPn0cJDxvSwX7J8zu
         0D/39vpwFWvu192YeR6zHv01AsZPBem1i2sXBLEPwmzNFnKMShiln9fgRz3N/DlR2V51
         mScoF5T5r/wcy5Lt4K8tLFxpeQjK8N7e8TKTLkQ5vTzuZKZtr1Px38rHznXVAhlkH1mW
         kZxA==
X-Gm-Message-State: AOJu0Yy8YKR9Rcx+it87YBjFOtre47/jO3b3gm8vCyHQ2b4C7U7Kx3Lm
	PQTDPLP7U2mkOuj1L+gxBk+LnVhkM1K1bzAzJ/nzPspOY9vVXCKH
X-Google-Smtp-Source: AGHT+IH4gURjDL3Z5G5a/OCKtiv576sRPTtWCKl2beurVCfH8bZo2s0WAt98mCZO/b2/E670qCNSxQ==
X-Received: by 2002:a05:6a20:b28:b0:19c:2fb5:973f with SMTP id x40-20020a056a200b2800b0019c2fb5973fmr486899pzf.23.1706651377723;
        Tue, 30 Jan 2024 13:49:37 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:49:37 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v9 05/19] fs: Propagate write hints to the struct block_device inode
Date: Tue, 30 Jan 2024 13:48:31 -0800
Message-ID: <20240130214911.1863909-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130214911.1863909-1-bvanassche@acm.org>
References: <20240130214911.1863909-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Write hints applied with F_SET_RW_HINT on a block device affect the
block device inode only. Propagate these hints to the inode associated
with struct block_device because that is the inode used when writing
back dirty pages.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index fc73c5fae43c..cfb52c3a4577 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -319,6 +319,17 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 	inode->i_write_hint = hint;
 	inode_unlock(inode);
 
+	/*
+	 * file->f_mapping->host may differ from inode. As an example,
+	 * blkdev_open() modifies file->f_mapping.
+	 */
+	if (file->f_mapping->host != inode) {
+		inode = file->f_mapping->host;
+		inode_lock(inode);
+		inode->i_write_hint = hint;
+		inode_unlock(inode);
+	}
+
 	return 0;
 }
 

