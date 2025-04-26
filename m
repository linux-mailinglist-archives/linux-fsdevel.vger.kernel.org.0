Return-Path: <linux-fsdevel+bounces-47431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C9EA9D693
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6261BC79E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C0718DB2B;
	Sat, 26 Apr 2025 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQKzTGR2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2461189B8B
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626222; cv=none; b=PuRnSFsjHJleDdW4buZ4iBIESrM+gjCfYVqqZUgBmmwwKlsPuKFKoi0IrtTvRoJPqF4LPvF71vZ0r9yDZxw+/08/XcI0tu9m+njwGRE2RbRl65L15ENBsxuWjNXgEIpzUNPKbWfOkl1mjv913esKe98/aoidKiDAc1pFQoltL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626222; c=relaxed/simple;
	bh=rJoZHe4EI5xe+pfh4Ctds8tm3pBpdMZiUFK5+joPAdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci9KrnVyd1Eh52XQLMG2MoE9Z+NFm5DQhpJTbrJvHlRqgSK5/n4heaAmnV+tZ+tmaKLCekwGJpP1fW6RVbe8sAXeAEfcUl/lE1UCm6YERBTRTcdDBcV1kM+ivPYbwQ9ITlMIHB8lbtPg2Uxp47PyZTVysiqcqxJBMmL20TNiXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQKzTGR2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7399838db7fso3027566b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626220; x=1746231020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQad6XLf26LWDYpgIdleFJF2L3DWXImZh/4oyEKuWK8=;
        b=MQKzTGR28PMQYwysSPsp3yDvHgbztkQ/Z1RoSqd/BY3LtxX/RefUMp3IwnTIDir6d5
         MxPmlnZnIwjBcOrz3dbxPAeGCwMeLA95dBcUjC6rBPLcsOrNMVNYU+8rFmqt2fwawp4B
         nQt0E6HuGQMpC+VL0mlRNurJDy65XcUEfq/iGoebDw5UZg7A/UNedmNSJWDKRbktZpbz
         5dKXY9lLX+Lp2zUdcdj4msx2wfu8T9uwiEPKz+vxvZqtD6NoTM6Es/qSP3t0qGY84CWV
         MoJbB9dePZYmG8Kmj3O6tv8U49u0KMRO2pGXhHgt3XC1n4CXMTERGAF62TmUt1DbMuxG
         yckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626220; x=1746231020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQad6XLf26LWDYpgIdleFJF2L3DWXImZh/4oyEKuWK8=;
        b=geBF0RgAMxbr/yqIcZs+OLPkTaXdxKXyZpEN9KeKPU/SmATqHyK3UC/tNcSg5tKNSt
         IvXreuDHOWKy3pGjt5jsu0aEmsDm68uwl58KzyVmWQtcd2+xNmUSSRQk+s7XZO0Jty0O
         1Rk/Kzi1kPZSN7F9PjpHOxi6vkAB7jAY5g/uoRk6pse1/hg8EEhrmmSRbzX4exTBZKcs
         AcDzVqmFUeuOYkNPlwrZ0gPBGRfjfL/QCo5PSjuqf2V0u22BFaYowBFtS1Gwmzk/fLaJ
         pCS+nn4Wmqt3Vjda1QHWnan/yyfJNdtab783B/c/z/xEb6LCK1eiwJmhyzdqOgU4g6Ap
         3iXA==
X-Gm-Message-State: AOJu0YzhdEkYgyFrBFLtVGymErs9RFIn50wGZzcYYVYy9MfaQcDpv4pz
	VFpTVT9Mtm/F9FpqT+flLc7FujXfLswxha3vAZ6Jp4IViey4HHTH
X-Gm-Gg: ASbGnctuodGYo+VXFb6MaJ8MStc2lmLai0n65yiSzxM+5KQN4Gvi+kdC04/rorLDAmo
	PGCPbiFHQThZ1v/m3RCxOeLSCJEuB3yOepK+LafFBogQoXa6aqY0JlPrVFGmGLEXRJdaoTc+wQ7
	XJHBlJsZEOLU0i0DhHkw1udmg+J6y5AYFZXnr2Wfhrihw2dxdETDEq7DcxbTcEBM5Xc/EfKpK/N
	kLHv3eck1+hB7sVk9irdrRzMidJ9NjBRAAiRENhC4rsMNDBZIIMdtWjSuBMuG7MqZ/xzhM/1brW
	FP80vaGd3NLzJXKnclUX68kA5hRUI5mR3L3QauuaHtETug==
X-Google-Smtp-Source: AGHT+IFYJwqPB38fWFPmlERuo4AB69bTIOi0vMtCtA44s4uQqgk/TCtgAGAfWw1cgQiPaqv1NnQ6Bg==
X-Received: by 2002:aa7:8d55:0:b0:727:39a4:30cc with SMTP id d2e1a72fcca58-73e267b8a27mr9165073b3a.1.1745626219831;
        Fri, 25 Apr 2025 17:10:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e259135b6sm3786860b3a.9.2025.04.25.17.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 17:10:19 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v5 08/11] fuse: support large folios for queued writes
Date: Fri, 25 Apr 2025 17:08:25 -0700
Message-ID: <20250426000828.3216220-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250426000828.3216220-1-joannelkoong@gmail.com>
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for queued writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0ca3b31c59f9..1d38486fae50 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1790,11 +1790,14 @@ __releases(fi->lock)
 __acquires(fi->lock)
 {
 	struct fuse_inode *fi = get_fuse_inode(wpa->inode);
+	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct fuse_write_in *inarg = &wpa->ia.write.in;
-	struct fuse_args *args = &wpa->ia.ap.args;
-	/* Currently, all folios in FUSE are one page */
-	__u64 data_size = wpa->ia.ap.num_folios * PAGE_SIZE;
-	int err;
+	struct fuse_args *args = &ap->args;
+	__u64 data_size = 0;
+	int err, i;
+
+	for (i = 0; i < ap->num_folios; i++)
+		data_size += ap->descs[i].length;
 
 	fi->writectr++;
 	if (inarg->offset + data_size <= size) {
-- 
2.47.1


