Return-Path: <linux-fsdevel+bounces-13111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F7886B601
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 18:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAFE1C23E20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F220159567;
	Wed, 28 Feb 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCxevNJM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC83FBA2;
	Wed, 28 Feb 2024 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141461; cv=none; b=nzmS7jRB+BvXpvVriW44VPZd/qd+n0/7w4vGfDsT+wVThVurwN3kIXoo8gpatllIDYZC2xTYZJaQY9r3R8zeQQ3X5Mv0HSwF6HGXI3QjfTiwXuCncTirzTavPq9atYKLoQnmId5QS8tqM9drxK/Gv4MkwSqPdh6xuO/BUH2OOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141461; c=relaxed/simple;
	bh=jRBtZuKeERtGAw31LmqF50r1/ss/xfk5LRp9GqVgqTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dw5ypLYHbn1+8m/tFYAgY6ugDrVc6j2dlGptMmOVrY/4Zs+EJhMlP4BmHYuFFYtQD+YWSbWBnYdqWodS3waoH0cgh8sxdauuFndYI4Yl6C4NctWW71MoA08dHjd+wsH17x4Lc8CM0LJ9FXxe2tEJn/ahHe94j8dEkSLM5HFKMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCxevNJM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e572dbbc5cso2632b3a.0;
        Wed, 28 Feb 2024 09:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709141460; x=1709746260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+1B6Wdy58qhImm+FGHcgFzCMtrDaanKZM3JrnRwFVxk=;
        b=jCxevNJMJ/N9RuuRLfLPoJJYPyiy3o0VsLUqna/C5O8rV+FfWbeyYMj8VMNoZ8TF4R
         7B05wwOWVy2dqSi7m/Mp0lwaxNVZeIn+vKhZ/7Am86wheFOB/XtXldATtpiFx9eisoyH
         jSLRlrGOaRyEEEI04jtq1Q4rDsVYbZ618OCtMf5p6FvPXOFCGFT7Vqs5/9ZkNFZOKFEO
         O6LhYGVfboxSE9an8DzJ8bwp2irzFgWZJhEB1f+ctT5a3SC6gVQ7dTu/A8fidlGCMeTC
         C73E3ufzs/NbOEpOa2wbbx41SNr8wzn5faZL8PQ4q330kOf03kFNYap9gPag1eTFX7wn
         g/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141460; x=1709746260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1B6Wdy58qhImm+FGHcgFzCMtrDaanKZM3JrnRwFVxk=;
        b=M6kWHmfoNXzHpx6jFuOxLnuVUj9df/2iDfs3Ouc6yER0TOYFG+c88jxdI05UJEBow+
         KrUnWzEUvcHhfbkf+x2tgiIPDYb4FLDQWoGMD4gr2ODm5IGt4vu1gZGKBuaFTYva7QoL
         sGwZBsL1JpiYL5sZY0AWWK0ClUGVUk+TU09ygAH32lh7WdU9Pv6uQU7UPAU7y1hOGvoV
         QVOnStXA5+TEbgja8ERIkytFET0abmkbKuP+lW4dokD+hTAcQla33uPcMmqcAnIdhct5
         LlfrUTXpGUIFIWsSda7YKAlrSZrv0HaK+1eDnj0QC5Mk8Hm4jWKS1BJ5PH2dffckG9PQ
         or8w==
X-Forwarded-Encrypted: i=1; AJvYcCUvDZzE9JgxU6frwmzPOYyqudjtXndamd9DduL+W5F9QroZ/7WywRjhwR3aEluPG7uabdDo8ORv7/cNk6W6bsunEEWCBgYSMpEMz3R82n7k/vOUAYxCiarYarIbuzQ7pW13oXcmawBErOnbYw==
X-Gm-Message-State: AOJu0Yx5L9cgLYOCB9OXETyZGzTbctehcYNJ/9DMuz2c3pF37ImRGhmh
	Xds0SMQhBJMP9whP367Z8b21xulw66gbX7ZUxAdm9jJrQLhpUE6VXuRMv2llL2A=
X-Google-Smtp-Source: AGHT+IGtKwjQRZtdEELtm6l6O1j7xB/QfF5VZb9+Z0vH6u5A3+Hde38k5FESR01Kc6cR/4jZeU8J3Q==
X-Received: by 2002:a62:f209:0:b0:6e5:3b0e:9f36 with SMTP id m9-20020a62f209000000b006e53b0e9f36mr65248pfh.3.1709141459484;
        Wed, 28 Feb 2024 09:30:59 -0800 (PST)
Received: from ubuntu-VirtualBox.. ([42.60.173.150])
        by smtp.googlemail.com with ESMTPSA id t26-20020a62d15a000000b006e56bf07483sm1369424pfl.77.2024.02.28.09.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:30:59 -0800 (PST)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: use inode_set_ctime_to_ts to set inode ctime to current time
Date: Thu, 29 Feb 2024 01:30:31 +0800
Message-Id: <20240228173031.3208743-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function inode_set_ctime_current simply retrieves the current time
and assigns it to the field __i_ctime without any alterations. Therefore,
it is possible to set ctime to now directly using inode_set_ctime_to_ts

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 91048c4c9c9e..0b1327be581a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2509,7 +2509,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 {
 	struct timespec64 now = current_time(inode);
 
-	inode_set_ctime(inode, now.tv_sec, now.tv_nsec);
+	inode_set_ctime_to_ts(inode, now);
 	return now;
 }
 EXPORT_SYMBOL(inode_set_ctime_current);
-- 
2.39.2


