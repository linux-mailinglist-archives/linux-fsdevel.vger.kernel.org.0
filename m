Return-Path: <linux-fsdevel+bounces-24397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EE993EB96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DDB1C2153E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1A80639;
	Mon, 29 Jul 2024 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHNCX+FG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966321E49E;
	Mon, 29 Jul 2024 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221189; cv=none; b=cD6vGuQj2oXBET8dSJIAIZVZr+A7YprWCS8GFUtuMsCxNI6zdUBRbWXLhaIfFdbMfdCoyzTNXf3I7HPknXwFOEWv4LNdYq2YeF9QpyOkUuSaR1n5VKlFrCenEYkvD9PmnLbVKbfXjwi3OELfTHzvHc+unzAx1bpuiwkCJeHSt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221189; c=relaxed/simple;
	bh=TGYLyUCIjyALT4hs8afmO6j0YAO8SFsfcw/1VlLlPhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6aiZsrOvjlyu9tctf34dePhQMi+ueLEyiqQVjd4U12Yb6i8hBCRMhxcG21TIIyOMzX+eIL5dpZFoHGjdLmCnf8dQM246k8423lz30/hq0J5D9KPs7AnsNfi326C3t/XSR1rf6DSkAvAgIPkcqVkOMM2kGmlsiPwAfstiH9yBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHNCX+FG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70eb73a9f14so2114994b3a.2;
        Sun, 28 Jul 2024 19:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722221187; x=1722825987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN2V+duoRLP5mjQclolxXRJl1PN7YZIwA2PLtFFVKQo=;
        b=fHNCX+FGUEkjI9tRR5OAmg2dJO/pc6ceuusNHSMVMt2bS3XFMclJy6HaM7v20A2MdP
         whp7LmQbmkrsyndlj+b34vW1UB0Pv26072ID1P7hP/7RTlTiADZvL1O4U12/uHe7GVi/
         L/oTjU7q9pM7JLFq+LQlJHjLCl8jA5nnlMMa5kV6SPcCqEtpxHXu1Z69ktDE/J/Oem0W
         2ybTtVvs3Hj0z8emxUhRs0USy8D6vbLq1BFv9jjTydEM2VrsM/TvtGACZYX/b3IgLDSN
         qa+nTr5AmtszMVNLgYT8TiHMU1/YSAYR/8i4MBN/w1rzKyEl9uf3xRDIWc5cwVR3hX5l
         5C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722221187; x=1722825987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN2V+duoRLP5mjQclolxXRJl1PN7YZIwA2PLtFFVKQo=;
        b=pjeXMwqUJnB5M8YzW/ksBd0WO3nuisazWBjLCKJahNMRWg2wfNHu2aXKtSmSA3L5JA
         +WcPFeSILBVbft9szh53iL1Mulal9XMZd/XIW+k1A+B9K+bcxutdp7NtRpslXR4JQbVS
         6pFJWvRbKM65nwayYtsM1dI6d9XaSJZtdvkDkhoOoT0rBBLdp9hsRSB4IlF0hD4MeK43
         KdBFdeq7PBWbr8hjfbGcEjRfX9FA4g23XE1XWAcQA9pvQTMUnN2SFWquJoYev7QUJCq2
         sWiXDKgrH2k7CTaGh/+zF0hk2Tq2/CV7WZ2yyNGzF6bl1DBZEE1xEyaoC3XrFG65djMs
         pBbw==
X-Forwarded-Encrypted: i=1; AJvYcCX+aKkxoKbJjxTAYTZTHvGqXiKcx153VHflK4QrXlXNzKQ7kGHXMnTZBU++MmJtZB/+t1ZHrEWdexQdLew4YZeBsC+M3esFu+xBkojP4mnmCLadzDhHzKzn9hAwIWGaIJsulJ3/tBObGl+fP99YJV5Qn4aHJrSuc9U+yavn9SsImvv3H9ZgyqyC1EWa3OCjtY4EGTOMwtC9GTZv0KGhK+zs5fENBH2sGWL0+v9YQCklJcKRYpbYXiQmxrZta9TO7nsVBxYVBZpGJVRxhqrs2/el/1E5XvRsjl2XHrH66BVX1fgEyzQPKaFBGCNh3k0ZP0Om02vzIA==
X-Gm-Message-State: AOJu0YwfyYs0cIzRhiIzHbxSbD3zCK/K/HZW7HaED85vlNFK2g51sQv4
	6MYCEGzBBXqiG+gUtfuIEApmjWkJIulF/T6oi9yZjI7blQCa0R7Y
X-Google-Smtp-Source: AGHT+IFg6cYKlkoyAPcpyLktfLarITyb9Rzi/fq7hOtiqCqd30rMJ+pCgZRrHbxyCAgQM++WsL2P3A==
X-Received: by 2002:a05:6a20:7fa6:b0:1c3:a55e:6199 with SMTP id adf61e73a8af0-1c4a14ded25mr9866605637.44.1722221186954;
        Sun, 28 Jul 2024 19:46:26 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a38sm7332247a91.10.2024.07.28.19.45.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 19:46:26 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 08/11] tsacct: Replace strncpy() with __get_task_comm()
Date: Mon, 29 Jul 2024 10:37:16 +0800
Message-Id: <20240729023719.1933-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240729023719.1933-1-laoar.shao@gmail.com>
References: <20240729023719.1933-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using __get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/tsacct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 4252f0645b9e..6b094d5d9135 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -76,7 +76,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	stats->ac_minflt = tsk->min_flt;
 	stats->ac_majflt = tsk->maj_flt;
 
-	strncpy(stats->ac_comm, tsk->comm, sizeof(stats->ac_comm));
+	__get_task_comm(stats->ac_comm, sizeof(stats->ac_comm), tsk);
 }
 
 
-- 
2.43.5


