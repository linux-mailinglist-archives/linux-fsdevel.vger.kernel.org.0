Return-Path: <linux-fsdevel+bounces-17779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9980C8B22AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390731F213F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C33F149DFD;
	Thu, 25 Apr 2024 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD0ifi7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8E149C69;
	Thu, 25 Apr 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051750; cv=none; b=tbvaOUOU1zDtnlfq7ZXbJ8Ocj1urXnsvJtFmeZ3RQeFk3rXOOEyiVFwlmwIj3GK1AOq/xaqOImLhGf/Z6S6ddzdmcuKcKWMOREoUcLv5PzJlouwwk7envUvH7ayME8Q4yoVF37ZTvzvKr4ZJMWNGvfhx/vxgHps2BvIuPcS6Gpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051750; c=relaxed/simple;
	bh=SBbQ5uBIgWybFSyOTAkJzR9WjflxNiGaVNMFfYIjNQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYMV1Kzrtag3rirZGHZfPVMjGerdG6bKAxp3RBZlsWrltVKO6Ijn7PKXCa0CvAeGUK/5UyK8GXPqXcSiU9opJTcsdealH8kc082yv22yxVPYBdZt7Atngg6SxziVUTU46S3z0bBzO4uBQ7KNVhOG7pD/NcWrcitxEAnUnzo6wKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD0ifi7X; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f074520c8cso1058342b3a.0;
        Thu, 25 Apr 2024 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714051748; x=1714656548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtYU8KBry5LUbKzLE1CfVwbFUPR5tg007xGtQJRD83o=;
        b=dD0ifi7XtydVwiTs8L7tPtZOZAxhEBqliDAwClg92i9V+0o6dZoun9hEnSIYUsEFgR
         /ac/sYcQYNTxm7IkOV1LXKb1nzwRy1U9AHZm1kcqksQBXF4B5zvvi+yixujnDsAw86TH
         OTuYTiggSawEZyXmhRmE3lEACg71zpluM8NbP/K8yXNNDpPEUUNrvk+iXxqzAIxKRMgv
         4wrQtZT8vUWq0VlJIVmfjmv1hDjExA96tYqKYWmnZBhZJ/yYKZ27nSoEExYkXtarh2gJ
         x7enGvl4v3qdMivS2ia9ekwbUeGhnjmgEoGqFZBThgI+gRTSXrHQIcAMfi/w0haQ3FrF
         A/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051748; x=1714656548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtYU8KBry5LUbKzLE1CfVwbFUPR5tg007xGtQJRD83o=;
        b=qsQ7MI6FDNF0/5u3nZraoZfWieBwAiyeyY4PjLC1JrTwdMMgVeHL8Ty5WYcx4AjqIz
         0em2Wed0CDM4YAjASJr7+MHzKp8nEXkOcCwmwVgsKu97NcbtbttYyfeiqtKYOIl9HNX0
         /Xhxgm3w7F+9sumLC8l+mMg+B12aE03oMZJ34Nw7OeWy5bYcvwV0VafgBOfIu3wGx+K9
         Qs/vsTX4cHUHXu1ngkUuX6gJumhnrv5Xspp7vRBqyuuUl65y5BDi6RH2zK7HshEmA5vX
         nUXjiQwWXwH0//LlyliTxXg7e70u7TaiD4bdqM4cx0EIPP3/wBrlqLQfuW2GjOGoo7Ib
         Epyg==
X-Forwarded-Encrypted: i=1; AJvYcCWvWuIBooXI+iwAEakEXMl+HbnoqdUPep1BggriLdHfXQCmh7RsSdxWAR2QVZdWM0Tdwx6o7/BUGH9l6MLiuyLwHx3EoD55zJDn
X-Gm-Message-State: AOJu0YxMNhuBZLEcCwKgN5w5h4CpP3SSea9qUbQso9js/HezGoIttulL
	SwBRT9pN0pWZlfQiAC3XGyc1lKkTWaTOKUuREya/CGRBGY4QWOe3mTQI0OKw
X-Google-Smtp-Source: AGHT+IEzx/7ppa7QCTSV3fMLkvafSKZhzB/RhOH8VUG5n+gX/1+Ye0D5Nafl/nJBNXm8ZkrmX/4d/A==
X-Received: by 2002:a05:6a00:2388:b0:6ed:cece:8160 with SMTP id f8-20020a056a00238800b006edcece8160mr6585895pfc.31.1714051747982;
        Thu, 25 Apr 2024 06:29:07 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b006f260fb17e5sm9764518pfh.141.2024.04.25.06.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:29:07 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFCv3 1/7] ext2: Remove comment related to journal handle
Date: Thu, 25 Apr 2024 18:58:45 +0530
Message-ID: <08f3371e0c0932b5e1367ebbdd77cf61b7e4850b.1714046808.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714046808.git.ritesh.list@gmail.com>
References: <cover.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index f3d570a9302b..c4de3a94c4b2 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -615,8 +615,6 @@ static void ext2_splice_branch(struct inode *inode,
  * allocations is needed - we simply release blocks and do not touch anything
  * reachable from inode.
  *
- * `handle' can be NULL if create == 0.
- *
  * return > 0, # of blocks mapped or allocated.
  * return = 0, if plain lookup failed.
  * return < 0, error case.
-- 
2.44.0


