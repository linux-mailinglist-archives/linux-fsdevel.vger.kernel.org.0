Return-Path: <linux-fsdevel+bounces-26355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A284A95832C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 11:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5F81F247EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FCF18C352;
	Tue, 20 Aug 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGls2WAE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342D18B462;
	Tue, 20 Aug 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147371; cv=none; b=uuj5oZSi8ZJMu+s7+l6GEXauRIm2EgBBfJFjtqUyjWMr5PJuwQ08YIh5BSei98Db4GSjNTXPKp+qDNGxeH3ZPUHLpoVEfiyP2DIH6FVF0dEb2fjNVL8m2w2obP0knDwToY5/dTL/3PO4UipjnkhgCckHKV2/YA223rQG5txAPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147371; c=relaxed/simple;
	bh=8VZjNFrNswWpOmns2LxJtRv26FRpYGO9OKZ3n8H2CPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Hu/Te23q1rDrOELbQd62Cj49RFnHrRqh3N8yxGTVQDILnH0p3xbnWLeqnEXF3F707Bqq5KZmoBZItVhOoPtnkMJ3nmL4JBm/xnCaRWENbefLG3GCcSAZmPEsZzsPI03KuBLq4XWvwjMu69MQX6p0NZ5pTzBGpgaDmFs7abHE56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGls2WAE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3105682a12.2;
        Tue, 20 Aug 2024 02:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724147369; x=1724752169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oksjuiJ+Fd+IdFBbr4NtZxm8Q/7F80HnKwwrINvO5XE=;
        b=AGls2WAEpBJMY9jdxa3M0+xi7CPJQ+OsrrdWeXZfm1OzMvxwPCxYVyS2zJ1T9qCssH
         nT6WRzVcBQz0edcW59S5M/lhMnyNXiY3nxHd52ixvkmKOK0tlmZkqBSN3TPkmOMEANn0
         S68EiDd0mH+vAhTEyAweXKSDj3KyqfJGHFJJD8LxYnurtVhp6hvlhzth+0yZv5oXrb6e
         J1AznvH5wYKxC9aiFmh2rPoo0erD7ViJgwn/D+k47Quqs00TkHYBhCSNz8qn6OJPiQaC
         KyURn70xLEzDZvivjdXOSIyBys6/BQRVyhsGDyUN1DFclI9oNfrphNEhVREcTu7m1LKR
         YiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724147369; x=1724752169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oksjuiJ+Fd+IdFBbr4NtZxm8Q/7F80HnKwwrINvO5XE=;
        b=a8vFba6D61BcIybN0ctQha2QPJGWVujqTQEd/qVLp4GYLpIiJNlvWf9JrgRM7KrfLI
         AFW8UEhPI3SG+Jmf6oepcUpL+VN+es3JGB/nFoQebjn4VTj5bHitA3NJO5EQ9Y30EN63
         4aASQCerW1pwxIfRed3iUR4ZVQT9vQEqMuHOpnX/Eu/mjiliyYRLPx4UqeTPaYjYsALH
         wveZmWtJEFyp0DuKAxRKv7VhSEYuW1PBaceWiUEfdTCJoFuZ2YQN1yydWC9/fRUlp7Go
         8I7UFkE7XLmPPFJezoiiTdJxbLyGYoBseqKttTLcpMq9W+vK54Cp1q6LggjvW8N41FFq
         VLiw==
X-Forwarded-Encrypted: i=1; AJvYcCXeLVr4lzNh6AhtBMTlVvAb6RHkR4w6kB/9Oay1r5rFUAUYZhbsQjK4Q26kqBPPjOHy2RbpN2NsQxG6m0S8@vger.kernel.org
X-Gm-Message-State: AOJu0YyFkse+tIwhuFi1TFB0gl2Ub0LzC40nKGmNIyIRzM6EzVpm3Kgg
	t8RrT9sw/HinJmBb7kTI9oSy3NzYpqJR4njOJp/4Cc5LkWn3+7mYlaZbb4xa
X-Google-Smtp-Source: AGHT+IG6/xe5UEm9QVs9Mz3JJM4sk29hmdtHxRZZ8AE5ozJ2XFTkdo3vxJzfrSjyoo4BEk4H3aeoaQ==
X-Received: by 2002:a05:6a20:6f05:b0:1c2:8c32:1392 with SMTP id adf61e73a8af0-1c904f91cf4mr14693271637.22.1724147368677;
        Tue, 20 Aug 2024 02:49:28 -0700 (PDT)
Received: from localhost ([123.113.110.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d427efec73sm5014596a91.48.2024.08.20.02.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:49:28 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] writeback: Refine the show_inode_state() macro definition
Date: Tue, 20 Aug 2024 17:49:22 +0800
Message-Id: <20240820094922.375996-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, the show_inode_state() macro only prints
part of the state of inode->i_state. Let’s improve it
to display more of its state.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 include/trace/events/writeback.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 54e353c9f919..a2c2bb1cddd7 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -21,6 +21,15 @@
 		{I_SYNC,		"I_SYNC"},		\
 		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
 		{I_REFERENCED,		"I_REFERENCED"}		\
+		{I_DIO_WAKEUP,	"I_DIO_WAKEUP"}	\
+		{I_LINKABLE,	"I_LINKABLE"}	\
+		{I_DIRTY_TIME,	"I_DIRTY_TIME"}	\
+		{I_WB_SWITCH,	"I_WB_SWITCH"}	\
+		{I_OVL_INUSE,	"I_OVL_INUSE"}	\
+		{I_CREATING,	"I_CREATING"}	\
+		{I_DONTCACHE,	"I_DONTCACHE"}	\
+		{I_SYNC_QUEUED,	"I_SYNC_QUEUED"}	\
+		{I_PINNING_NETFS_WB, "I_PINNING_NETFS_WB"} \
 	)
 
 /* enums need to be exported to user space */
-- 
2.39.2


