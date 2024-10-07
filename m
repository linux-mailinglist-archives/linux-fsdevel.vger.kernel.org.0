Return-Path: <linux-fsdevel+bounces-31202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B665E992FFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52611C23880
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8044D1D935E;
	Mon,  7 Oct 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nifDS4gy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E165338D;
	Mon,  7 Oct 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312632; cv=none; b=XDt+E/LkByS724rGCoT/lpN96MnWoHB+7cMb2UrmcoJwX962oP2jmJED4ysIktj1yffnMbK9XeaofyLVjcjopndMsCQZkZxgsW5Hy0kl+cflS7MDqkWJCMrHdWvPduQTCdlV51wpTe2X6O8v+O+xyym+qkXAx+bjXqE/kx8ukL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312632; c=relaxed/simple;
	bh=CSn+g/DUlfag0y0O0cUb+f8BNmi1oTrRRW24RVQtgBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DWj9alAP7oaiiYq+C7BaeGcBN9zh4hnPTiQYr0vHVPU1OK50sO/65RbhJAqID2woOj4YJkYmXK/kKPB2ZfnnEATh84dphUFgJ9DiR2Jc2k+zug/qcohX3Hgnd+fNLzMOSA4Rc8n7MZDhWPjTtKkXqlGSqYU0gfgN7pBdn5dQ4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nifDS4gy; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c3e1081804so1925680a12.3;
        Mon, 07 Oct 2024 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728312630; x=1728917430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOSaWXUvmAwO/V+X4Wf8hE6beLEX5jMwcQWbLUwGe5Q=;
        b=nifDS4gyeKs79AmgxiGRME7MQty0COix8jM5+6WOoyfMCtHd43NyyEEIEAeRmFm4y2
         kiUS/i26DyNoJYbjXHlCVUpWYj25ogaEjyOav5cbpzDkgt9T7gL0nwnzj7uXmRfXGFlu
         5u43ogfr91ssUIjhC+KIpfCSxgrC6r0gyZvB0C8SjsH92aMblBNt9tsswYFnDPXqNdk+
         366TobA3QtfHpxk7pvmRsly9MrnIGlkQCEPJTxqcsH6sMdfCwobP1LZkrLi8Z929vvlf
         16V9zkvO8QdNPfEqDT6eLYGkXphR/5O/atQjrM3IR6yrs/tEiWSM8LBYL3681wS+6oQH
         ivaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312630; x=1728917430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOSaWXUvmAwO/V+X4Wf8hE6beLEX5jMwcQWbLUwGe5Q=;
        b=mm42SKLAI6554qaSCHETYpoXKK2Z+//ZLcyYMZnr5Fe9zhcYsOxk5bxoRpXggtA0xF
         GNHz8EADrOsAH1fSF+j1b+L5uypOOYE7fuRBjV3jx7g+oAerEDkLsUb23y2SOlcp/864
         W3W9x/IfoaalpJsJ8SL++Hhbq9vn1FsLjnAPEmJ8kpaKjeTQXylpqiQBO8dhrBJJxwCb
         Wbao8aHv5MXalUtKoqCGe4w4qiE4cLTDlqs7czCgDY9W6l9UMcShlO7nixCBbh/x0BT0
         VzeWFk9M5Ifdtdd5haFIfAqvOBKA+eikxSL9LBrsN6+Ur6+qP6ON6WWmQlPHYFuHVLPL
         ch/A==
X-Forwarded-Encrypted: i=1; AJvYcCU3uAAevuR1YryBavybchPU0BG1RZgu+FNtTroMt2GNe8dUrL5xWskpFEgAcAWkArfYqW9TtkD+rpsGHqhHDw==@vger.kernel.org, AJvYcCVhnueL3W9b17N2DRFsJrNwUeCQ+tYilgRhXxm5MJAX+06PvQuZU/5u/rihRMB10g4gIZ+JvMJ/@vger.kernel.org, AJvYcCW6vNYi2/RDqG92P4ENpXi5XEjiTjNdMvyPACAf1CWbFRNJt91MbjlDqk5BzvZBXWchwylS@vger.kernel.org, AJvYcCWRfK32qB3z8W8SSHp6IryhD0+E5isc4+eQM8dXK4yJ7SUpfPiYSKNjI+eXwx74bCUq6cmU4TXuu/e3/f4DkrmaNhCp@vger.kernel.org, AJvYcCXD/DMfREcdWUKOxqXGV9eDnIrG16y3cwjWivF1hITY/G/b1uuUwI4qlXB9ufV0l/1+p1K+5BgazA==@vger.kernel.org, AJvYcCXE3PkoHjKhhMW7wnKOWitLTnpTLTSMzl9YAeGc8nE8hQsAkC9b028ZKqhV5tQUIAzTWcGtvA==@vger.kernel.org, AJvYcCXOkcJgeTCyrUnFAdIG7ie8sdYbnXaBmNjJ5q4BC8u5eKJ4kpqsYSGEhDPn5XT1zNhKQev0rbq9CKW9DVFcEVR9tDZQeQI/@vger.kernel.org
X-Gm-Message-State: AOJu0YxIY2cgnrWahllZof2nO2jPbjxGQ6hUTAzY0zyOuh2LTbvoCvcH
	2gHhSqpRWWskm1/7Z91DZRtyg58yjLI5Fkt4bEkOtSIZOrOfU9cJ
X-Google-Smtp-Source: AGHT+IHqOdUcOlcgWNq7VMpvl6yahiIrnpFyiw3ojJd2mp7haZXT77OIrOQnvCwSUS5AAO7Cn/LNdA==
X-Received: by 2002:a05:6a20:9d91:b0:1c8:a5ba:d2ba with SMTP id adf61e73a8af0-1d6dfa44e04mr19075009637.22.1728312629925;
        Mon, 07 Oct 2024 07:50:29 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7cf82sm4466432b3a.200.2024.10.07.07.50.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:50:29 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	keescook@chromium.org,
	alx@kernel.org,
	justinstitt@google.com,
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
	Yafang Shao <laoar.shao@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v9 5/7] mm/util: Fix possible race condition in kstrdup()
Date: Mon,  7 Oct 2024 22:49:09 +0800
Message-Id: <20241007144911.27693-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241007144911.27693-1-laoar.shao@gmail.com>
References: <20241007144911.27693-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In kstrdup(), it is critical to ensure that the dest string is always
NUL-terminated. However, potential race condition can occur between a
writer and a reader.

Consider the following scenario involving task->comm:

    reader                    writer

  len = strlen(s) + 1;
                             strlcpy(tsk->comm, buf, sizeof(tsk->comm));
  memcpy(buf, s, len);

In this case, there is a race condition between the reader and the
writer. The reader calculates the length of the string `s` based on the
old value of task->comm. However, during the memcpy(), the string `s`
might be updated by the writer to a new value of task->comm.

If the new task->comm is larger than the old one, the `buf` might not be
NUL-terminated. This can lead to undefined behavior and potential
security vulnerabilities.

Let's fix it by explicitly adding a NUL terminator after the memcpy. It
is worth noting that memcpy() is not atomic, so the new string can be
shorter when memcpy() already copied past the new NUL.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alejandro Colomar <alx@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 mm/util.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 4f1275023eb7..858a9a2f57e7 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -62,8 +62,15 @@ char *kstrdup(const char *s, gfp_t gfp)
 
 	len = strlen(s) + 1;
 	buf = kmalloc_track_caller(len, gfp);
-	if (buf)
+	if (buf) {
 		memcpy(buf, s, len);
+		/*
+		 * During memcpy(), the string might be updated to a new value,
+		 * which could be longer than the string when strlen() is
+		 * called. Therefore, we need to add a NUL terminator.
+		 */
+		buf[len - 1] = '\0';
+	}
 	return buf;
 }
 EXPORT_SYMBOL(kstrdup);
-- 
2.43.5


