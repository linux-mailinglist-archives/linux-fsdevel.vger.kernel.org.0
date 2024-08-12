Return-Path: <linux-fsdevel+bounces-25619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDAC94E4F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156851C20869
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917FF13D8B6;
	Mon, 12 Aug 2024 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJEx7Rch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A070681E;
	Mon, 12 Aug 2024 02:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429868; cv=none; b=rs/oqMxh0Ee3HLdlghP5LvUa5y1o8P/4U/lhu6DBpdKm6IR6NhYvik7hmUA76o53hHJRumVpUExcmi+ebBXeBmZrU06sRtomLetwQzrpxl8jeB7p82rfNCKU3pQ1dSwttuXpC3nXddd5DWtcM5hSwcbUsS25/F4xgNOBSf2P5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429868; c=relaxed/simple;
	bh=ads9a+vJAdf3fW1daUgzeFpk3FAtZrgaeqt3aAf0isQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3Mdp6cQB16sM4isO5dxeyHZeuEoTMqXTpZJ/A6fqvF7KruI+GuyINEx8Q/N0kaacLTVOKer2IViYVQoet7mbdEPxLS+PWKvf62v/gGXj/9h8P18qRXOorfA5MmpoOOpDXVnl1Yo1WbQ6l/DSDI4TDdG46l8jPkm4Dplhb5BKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJEx7Rch; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd640a6454so28754745ad.3;
        Sun, 11 Aug 2024 19:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723429866; x=1724034666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg8K6fIsZQLFiS7Xpg/1YZlm81yjN4oHJWyrWmInMGw=;
        b=MJEx7RchUXtd2X0ZD9RP8/gt4Bt8NYNwbgrN0Jrr00AWwWhUrLiIUXB62M8pwrwPZU
         Ox7FFs0W144uXLhg4OfGJ5wVUL5JrlvFdXQz40MQa3Jv+AsIdY8nLyTgwpPnllYkhaO2
         nLgCu7kB9teV3O2tFWmyKPzq17Xj3hf2jyKm+Miqi2FBbDN6wdmeQV4H+uW8mhWFefgH
         20ZwEtLwJwrDgF/yvrD4yZJ/G2C71vHVAH4ehaduTz2vXaGgos0H+jTyuSN08HGpFbE0
         GCYXRabEW1ohmLBNTA4ZTj+/UxB1Uey8Eb4+wTGzx7xIUmFnECw20ApmTZPFayfeGw2N
         e8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723429866; x=1724034666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dg8K6fIsZQLFiS7Xpg/1YZlm81yjN4oHJWyrWmInMGw=;
        b=Fqkv7koM6sYNPm+9IRdQrDe02dtFN3uFScc3+sxX1uomkGUselcdHWmxWBHYv/FiWQ
         vRJ+vn5fMhx5ZdvA/VT0DVyiyPYK+Bu8KbyhQQ6t+yMyWkpUAzoVlOkiX1Q7rEoN7G0O
         o3mDBCUxY8utCq1Bp9DISki+7fSmrvjboX9RWylIOBo2ASkECBZaNBrrmh155K3JJ6zK
         CsBtLEwkyhsgkiwoqEdTGCyUqdJMF3px0PzQG16blfC/CZgc+St0eLxMh2psNE8jzjdS
         oZAka9fxZX6LAEMQ54VpPMDyuWy8+LiZ5nYeR9AD8VA3W0dWBEjC2591ZGiuwjPzhmcL
         Jftw==
X-Forwarded-Encrypted: i=1; AJvYcCUHz5DNPikUz6vnpm9ciVLAoqOZiRBwjbiqPbXa6qp9RQvWtg+pT8vgGEulTfwau3CVIZkiy2t7BkJ8TWdmk+MmvbkM79MBClauTVYlDXW8QNuCObJFk6ya2U8bsESZaR4pLHirc5TskSpaEDC0wdtC8YJ/kP2lZDiud8rjmAzBqoxoKvniI0+WZIZfdDv+7wesmy+ts4+2KhOjFBXr3ZtXaLROYpNa+Ee1eNa9K1kr6e8TNqVVi34eZf8NGnv43e+w23Tax5ZAhat1LWnaiN0oEA8sqmLThR3vyy4UTWKegp79ngVfacWf3wEsMxnzoTMnAqs0Uw==
X-Gm-Message-State: AOJu0YwFb/F3RVrzP1XuL5VRb6uM3LwTChVqIgAza/LRZ/us3MMplv8Q
	hmDlnXsb0Pu4apEay8/1WuccyAMfe+sIyU2LAwGCVaMXO18kjv6P
X-Google-Smtp-Source: AGHT+IGpTCkxya5k7tDP0eeWIg02IZrGkBb+Xs7WqcLI3e7hWnKKPF02puCEAAGLT4aj9e0Erpx/iw==
X-Received: by 2002:a17:902:cccf:b0:1f7:1655:825c with SMTP id d9443c01a7336-200ae5a8934mr50792845ad.36.1723429865812;
        Sun, 11 Aug 2024 19:31:05 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fed69sm27884765ad.188.2024.08.11.19.30.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2024 19:31:05 -0700 (PDT)
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
Subject: [PATCH v6 5/9] mm/util: Fix possible race condition in kstrdup()
Date: Mon, 12 Aug 2024 10:29:29 +0800
Message-Id: <20240812022933.69850-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240812022933.69850-1-laoar.shao@gmail.com>
References: <20240812022933.69850-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In kstrdup(), it is critical to ensure that the dest string is always
NUL-terminated. However, potential race condidtion can occur between a
writer and a reader.

Consider the following scenario involving task->comm:

    reader                    writer

  len = strlen(s) + 1;
                             strlcpy(tsk->comm, buf, sizeof(tsk->comm));
  memcpy(buf, s, len);

In this case, there is a race condition between the reader and the
writer. The reader calculate the length of the string `s` based on the
old value of task->comm. However, during the memcpy(), the string `s`
might be updated by the writer to a new value of task->comm.

If the new task->comm is larger than the old one, the `buf` might not be
NUL-terminated. This can lead to undefined behavior and potential
security vulnerabilities.

Let's fix it by explicitly adding a NUL-terminator.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/util.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 983baf2bd675..4542d8a800d9 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -62,8 +62,14 @@ char *kstrdup(const char *s, gfp_t gfp)
 
 	len = strlen(s) + 1;
 	buf = kmalloc_track_caller(len, gfp);
-	if (buf)
+	if (buf) {
 		memcpy(buf, s, len);
+		/* During memcpy(), the string might be updated to a new value,
+		 * which could be longer than the string when strlen() is
+		 * called. Therefore, we need to add a null termimator.
+		 */
+		buf[len - 1] = '\0';
+	}
 	return buf;
 }
 EXPORT_SYMBOL(kstrdup);
-- 
2.43.5


