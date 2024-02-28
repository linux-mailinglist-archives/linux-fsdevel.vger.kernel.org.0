Return-Path: <linux-fsdevel+bounces-13102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F070086B401
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 17:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909931F26244
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D2B15DBB3;
	Wed, 28 Feb 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlnBK/Gw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8315D5CD
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136142; cv=none; b=Mv8wlfWtxhZpDJUTTAorcSOjZTwsncf+rlkR7QJ9jCe+/gdwnFKTm94bEtl+HIt4CC2csADbTLyVgdqkA06DyXpsDqL0vB5WUD4tvEieqm8BqI44FXMpyDz/i1zELUCKLCa2jEp3hqz4X94XxO7Yr9u+eMsKsI3DQ5eTymYvnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136142; c=relaxed/simple;
	bh=8cqkb/NZkYtK8b/nuAyQZ4SuAHiDijCUwWScznwSvJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FSk7IucJZh1u3d3lXP37pTQP//5zCyhT5FSOguMqCMBV8AX/7wTBzfzeQ/HrYjtJbFNWZ7fleoIXN6oLmiHddGxkeZxNAcJEYmvugkXmZuSrLuA2SuQS91x0tfypW7r8IAuTJW8LwjWBupNqgXq7ZfdmB2ZzjDVjYtBoG1CWCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlnBK/Gw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709136139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WP42bm8xvL/lRAIfAu8ESZY/T+/pzLIZT0SH+0ebrAY=;
	b=FlnBK/GwAWw2QBjpP/o1u1QsInXIVlqAZi/+f2itZ5x2tbf8BOuJS/yyYtCov6UEmdp8k4
	hbfA/3XK17oCnsjydHdNLs98NCB8w/HKGWYsHvUP4w7eYybLOYSjhyyuI+6GZpt6hmZ6A4
	9qBJ9YpJ5evC7XfRdpflQzb1i9wsSsI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-4mqM8EeyM9SRCdb6WcdpHg-1; Wed, 28 Feb 2024 11:02:18 -0500
X-MC-Unique: 4mqM8EeyM9SRCdb6WcdpHg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-565870befefso2910073a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 08:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136135; x=1709740935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WP42bm8xvL/lRAIfAu8ESZY/T+/pzLIZT0SH+0ebrAY=;
        b=cLxhAmPPrdXBuIxcy1mjnMoCiwOcQty0Pf7ng2ZAH3xSM6bMU5fgUZOFj0MIT2xwkA
         AlsvxbANIiCQdV1YqRal470Xo8zMFfI7ePoH5GTRs4fcrLDGxBbBq54u9gvHsPYoelxK
         klxNCFzhyNbsLHkLfe5o+uT8y5FPDxbPufNNJjTMrBpZyDNaG9jwf3EqoZWIruKEUHwk
         aPB2AUtDUTDsEJ9iwe3qqjJ+MlGT727a4019zGKKZ1GlAmAz5zOBQzifC+M55zv2KswA
         CDSM8n00mt5q2r0ssfB97ddYlzRNaZWmMLeca9SHI9s7Qsk9wTBJXUPCr5+aSg+lzq7Q
         eiIg==
X-Gm-Message-State: AOJu0YzmKTuL114/qq0OT/tDKkWbZzCnGKWrAo5Jx15gECEGY8OVHn4w
	rMwGjgUS6bud4lOSEiSi/4XkYXVdTgd1g4ujrMEuseXBF/Yo9bCOAQqK0I+KErVJxGGxln1YABb
	YngbbDvJHPkfm2tSwKu27VkdBhySOrtZcGb6B3tLAy82BVHZZjvnWvMsvoH4QM0qRqMlKWE+fBZ
	UA2ii698OnUX3Vq2zJRq7vpEl5aOBfMyuNXP1//3ZSM4qAfrs=
X-Received: by 2002:aa7:df83:0:b0:564:73e9:a9cd with SMTP id b3-20020aa7df83000000b0056473e9a9cdmr9669408edy.31.1709136135718;
        Wed, 28 Feb 2024 08:02:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhhOZBBGievRQ2E08GYgV8+5DLLuEJUMrQs4R+hCjv9A2VRh4drqAEe5JKlOv5W337oXfK8Q==
X-Received: by 2002:aa7:df83:0:b0:564:73e9:a9cd with SMTP id b3-20020aa7df83000000b0056473e9a9cdmr9669383edy.31.1709136135345;
        Wed, 28 Feb 2024 08:02:15 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (fibhost-66-166-97.fibernet.hu. [85.66.166.97])
        by smtp.gmail.com with ESMTPSA id ij13-20020a056402158d00b00565ba75a739sm1867752edb.95.2024.02.28.08.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:02:14 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: 
Cc: linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Amir Goldstein <amir73il@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] fuse: replace remaining make_bad_inode() with fuse_make_bad()
Date: Wed, 28 Feb 2024 17:02:06 +0100
Message-ID: <20240228160213.1988854-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_do_statx() was added with the wrong helper.

Fixes: d3045530bdd2 ("fuse: implement statx")
Cc: <stable@vger.kernel.org> # v6.6
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 25c7c97f774b..ce6a38c56d54 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1214,7 +1214,7 @@ static int fuse_do_statx(struct inode *inode, struct file *file,
 	if (((sx->mask & STATX_SIZE) && !fuse_valid_size(sx->size)) ||
 	    ((sx->mask & STATX_TYPE) && (!fuse_valid_type(sx->mode) ||
 					 inode_wrong_type(inode, sx->mode)))) {
-		make_bad_inode(inode);
+		fuse_make_bad(inode);
 		return -EIO;
 	}
 
-- 
2.43.2


