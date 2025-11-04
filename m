Return-Path: <linux-fsdevel+bounces-66952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A912C31113
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD5EA4F17FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE552E092D;
	Tue,  4 Nov 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1g5b/AV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8B1F1513
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260670; cv=none; b=DTIbxSn7u+aWoV47hZSSb/hD0/Qjfs50iNCQUCtiVMiB53VZ1mEHhX3KOd93HBZ9XP0uJ3Mxmqe4MWX2QFfRQ3lxMhrL3lMiU3ANPApWv1vYe90+lYFqCxyeptAfhqLr2VFwah4AwynAvvsCmujW9/9ckvBSiRvqUOqt4LPK5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260670; c=relaxed/simple;
	bh=S3L8yWcPf7Uvvhuw8kb5mV50ABXqzeKjCs/M0blRocI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2AqEXXXoxrNSVSG3BA8VGovuj1Yxs5nTMSzr/er1jkZP05Vclp64iFA/QgYOupY6aG91QrvB8A0Wfur5xRXnSo7UeYlZwSmoecXt0rlAczR4a1/KttyvBnEHcqVQzGf0C2fOt2gBOzWV6oC2muqZReoumJjBMj7IpoMz0oGZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1g5b/AV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso2790190a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 04:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260668; x=1762865468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM4LaUJGUQ26yP1YfE9/TUkYoY6eJkQufUALxNmpnUs=;
        b=a1g5b/AVw083mhh/EpgN81CSzncrNP02f45pvke2+H2d1K+ePlVS7/AdsD//K9Xnmm
         qLQtCsFfGFCsnt2Y/LqodDoEmtnTjbsPVRijPGMOzjp0GrT6jJL8sdP48Eoy9tWypLhk
         1YEXzboA7S8rYv5hW9Nmuvn7MaNVAdbpT8fGWCOGm1ABaIlRHVIxd8itcTcCtSMsoJRo
         O++Q3h3FigWAIxt9iAnB5dc4USxmpEj8iMHUnvo9xgf9XB0zI+CrA3rKO0RlNI7DVTi+
         zzTaTGet8CBRG/cJ655hUKqPe3QlZrOvO1Mi2xNKjwg7K97c9O/ir94bdqljjK0esjBv
         wxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260668; x=1762865468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AM4LaUJGUQ26yP1YfE9/TUkYoY6eJkQufUALxNmpnUs=;
        b=iQNmnhc26rNm4PdSaBRaiT8hSnYKFvixUT47RmCkERfd6kY+Ynf+jeS8/eiA3Ph6Gz
         rWXdwi1HXH+Kgn+RPtjRluix1fb9flv93yDZNykYfR9Kfir35UsKK7SPoj/EmrEJyr30
         9xI0OprxS/buIN0tKCwtu0/cnyxWQ/AeVbZ6lXUI6bRLOampm3+KzWIKFfXMilV0YUmk
         C+I1X/0ruk5xgMWxfYbEEFK15nvKu6D3D6R3Qra2yj2WrJmiIj1RekEcx6t0fKJy93eU
         5Crnet8tsKUOGJ8yxUfXxDzX7CD0jsuUe46A67/vqt+gY9QUKObUwGYjmaWPCgu94cJy
         BVFg==
X-Forwarded-Encrypted: i=1; AJvYcCUMPBaIcEisecUR5RXxix4HrtJB/vKBE7MZLIR9a0cZve7igSlGjR7wumJIbCBpngGAtItddE5Q+pcnkG8o@vger.kernel.org
X-Gm-Message-State: AOJu0YzixzTMYQZILiUFIdq82AMOKxfRoWOv1krNNuJ+micuZ8BF/XvC
	jgRoaIeVOs1aQcSzwAiB141yxBBxkHVyxd1fgRZQtzOt0AgZcmepn+CI
X-Gm-Gg: ASbGncs7zVWZAt49dPDZQPemUs0O2NMHiSydXUrqqexJfDaZQcSNkWnx+7J/lW0zi4D
	1NGlYfQ/+vMuIxfj5eHwVy3L8nvVkQLNkvuryZ6dgkWrxH3gRvLYC3u5WEB8N3Yj2UHMzwHawKx
	UEQNtr8C/MocxBOF8UPHuiyJS4vNPnHqXdy9wssq4y9kYXWHv57cVgRDCVLRlWmJ2puPNEZEJDq
	C18cQlw2a4V7UCP1MGTAWPSSIJEIL7ySnWrBfSiG3f6VjcJOnjZDo0NZey3EEbuVhP6IjAQSUA6
	stYk7bU5Y/RYlBV9iCBhUDP1nSUj8stbxaTWSis0FNMcZlEkm/2S1IoAopw9SdhcHoSWaZf+OiB
	d8o0h4US5WLWK+qMhRThXtYx2JPeqN6EBHw04F/r8nO8QcPSqNf2CAqFDuXop+Ob77z6LpShTiu
	sLzaEVz5ZFo45Ec7AJi5CSaTB5Zde7NrVUQHFyzuci00fyKmk=
X-Google-Smtp-Source: AGHT+IH3JuuEMoP9YT3zyIl/+HUSXK+p3FIZ5E5NT2awhGYYunlZYurin74ce3hTLqp46OSwVZT1sA==
X-Received: by 2002:a17:90b:3946:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-34083074e9bmr20646792a91.19.1762260667843;
        Tue, 04 Nov 2025 04:51:07 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6d026dcsm2860710b3a.70.2025.11.04.04.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:51:07 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 4/5] xfs: check the return value of sb_min_blocksize() in xfs_fs_fill_super
Date: Tue,  4 Nov 2025 20:50:09 +0800
Message-ID: <20251104125009.2111925-5-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
References: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

sb_min_blocksize() may return 0. Check its return value to avoid the
filesystem super block when sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/xfs/xfs_super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index e85a156dc17d..fbb8009f1c0f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1662,7 +1662,10 @@ xfs_fs_fill_super(
 	if (error)
 		return error;
 
-	sb_min_blocksize(sb, BBSIZE);
+	if (!sb_min_blocksize(sb, BBSIZE)) {
+		xfs_err(mp, "unable to set blocksize");
+		return -EINVAL;
+	}
 	sb->s_xattr = xfs_xattr_handlers;
 	sb->s_export_op = &xfs_export_operations;
 #ifdef CONFIG_XFS_QUOTA
-- 
2.43.0


