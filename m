Return-Path: <linux-fsdevel+bounces-21588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53D59061E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 04:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B30281B3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCDF12DD83;
	Thu, 13 Jun 2024 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyblUz7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D7281721;
	Thu, 13 Jun 2024 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245904; cv=none; b=dq9+iMVt+2PzcXR7vSXohNxetD2qGgxE6EEhT3x8hCEoOJCsTm079riysHzXYiifIRcgLRZkQkzdeApIgsVtK70yynFIMSQJ5Eh3+zFvRQwYuFRgDsgfL4t8ZBkfd6dk5//FAJw2lLAEs2MHPYt/NhOTO4qYNlkbeoDwUbN4J8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245904; c=relaxed/simple;
	bh=g1/txTsR5nMIIXRnWhaYOCg4jtbwbYBXW19DaxxjazU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZjEChvjqCSvszJE5l7WrxiAqEoyYYsZAW+DdVjQMGcIxA7gmVKQ+lKVlaj8VBwXeJX6S+DaHldhcKtqRSKTp1uYfcHrlf/X8wMlwbMd8pp1jz4OOVoQdRgPWuaHnbsgi4a+PoJNg+qVXdiH7LVvu4F6JGe/qm31AYwJAncrrSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyblUz7T; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f4a5344ec7so3677485ad.1;
        Wed, 12 Jun 2024 19:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245902; x=1718850702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei/8xwKAZ1rE7ZNdSGJjlup34y97vbtFvnVfEPyjJ8Q=;
        b=MyblUz7TFxfkFWL6y2XnJ0BLQcU7m7eUORob6njDLq1udJrWHYUIUd/1A/1P0jnCi1
         mpQN5mpprj9p19GonvxCLbRjXoYkHNBLPSUWYuAEF2ELkCxPj76QSd/WLYq9NLRO8Pgy
         6SKqRNR1XeTXTuEu19xHJQyDxubZrwyDGrcfGd16nPdI3bKu9d75buaxYzusE6So6QIe
         fKAkFuiTbAlhMtdfRwgdMLuGkXzOlqQhqxnvgPDBsbZ1pbd+d5pGHPcu2frt28E0oDEh
         mLBALIU2+b0XW14DFrF8nSSxh0zUTr1wGY/KAzWQBpAKQbWUqDnjV71M5rkEkgB/mcHW
         TFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245902; x=1718850702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ei/8xwKAZ1rE7ZNdSGJjlup34y97vbtFvnVfEPyjJ8Q=;
        b=uUyakDL2cPwdZnk3tgtFvwM6xJe14C6UWpg0EtD8773/Lxvi3qJqh+u9UDsSzkcP2k
         CT5VJNkALq47oafq1wrV9jGH/Ez+8aSOUIn2VosiKsq6rZ+LNgdf7vpiFJoNTxaPBL1o
         oYEC4Cp14Ghws0Pmg1OmUiCJs9vUPzO/dROXK/2cGGsmhu+it6g4VeUdU/4uL6nF5m0T
         iOdU8hraJoMX+AwafdEhW7FrQ9AAWWYR3wvjH+rcBzk6K/cy8OebCHOpiCV/M03t9u4q
         JNMgZihLqAbOCoKhQkl1gPfZhAltp/09qwiMLtu6HfeRhd45bBaiT6lBiwCxdkj2fjiQ
         7CuA==
X-Forwarded-Encrypted: i=1; AJvYcCWKsp1/++w/IcsMZxpNJ6eei2KdaMTu6QK4y7MJs9IpHfunX1nX1brkMnIxyqaPdmNwzgm57KFo3LeGhK41vv7Q5VvS7SLHRXIIBngacG7EgSHy8u4PGAW/R5+RJsFmFdUuGNVJG9VKRmtTDm18q9iVi45NeSEzNaUx5WqJHL36hlNHDzLSX4ZAit+EjTeUaFVLS6YpeSB9jZMj9e9b/MqvfTUilAtY5fAsp7mxPVG+u/usvvqKfKl/sa1Xt/15Uvglvkt1pg7h5bHFjqoxvB/P96FR536EwtQjswrjDGvFlzZNPtPt0QjZ/0J+B1Y8pB1tRIjv4w==
X-Gm-Message-State: AOJu0Yx4BAoNEigfu+TDoH4S6G74U3rBK5t4PeUrAzmaoT6eDXzHGu+v
	gyh9P7glM4GXb8nmdaiwVWDXlvqHFwXlXQM8xauyHrlL0T4C/1sD
X-Google-Smtp-Source: AGHT+IFIaVarDVsj1gEbMfPNFvaRxIMZj6V1FUrejF3TL24xnCXwEw+tDOS2CgmUK4jtVsLBUQ40Ug==
X-Received: by 2002:a17:902:db11:b0:1f7:1d71:25aa with SMTP id d9443c01a7336-1f84dfbb4cfmr20547645ad.6.1718245901789;
        Wed, 12 Jun 2024 19:31:41 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d159sm1755695ad.289.2024.06.12.19.31.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:31:41 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 05/10] mm/util: Fix possible race condition in kstrdup()
Date: Thu, 13 Jun 2024 10:30:39 +0800
Message-Id: <20240613023044.45873-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240613023044.45873-1-laoar.shao@gmail.com>
References: <20240613023044.45873-1-laoar.shao@gmail.com>
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
 mm/util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index c9e519e6811f..3b383f790208 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -60,8 +60,10 @@ char *kstrdup(const char *s, gfp_t gfp)
 
 	len = strlen(s) + 1;
 	buf = kmalloc_track_caller(len, gfp);
-	if (buf)
+	if (buf) {
 		memcpy(buf, s, len);
+		buf[len - 1] = '\0';
+	}
 	return buf;
 }
 EXPORT_SYMBOL(kstrdup);
-- 
2.39.1


