Return-Path: <linux-fsdevel+bounces-26356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0150895833A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 11:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B170D2829C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 09:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03A218C01C;
	Tue, 20 Aug 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFkqkvmA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F2117740;
	Tue, 20 Aug 2024 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147558; cv=none; b=XMae0Qe2Y38sHgfmoIOhpFnBnMsnCHjN8taAEHmcF+AoHAQvRdaBoyz9ToU/dOkMmNcZXLy27S5li7hchB3c7Z4mF4JQnjd6mfOjsuM1aAVFmAAebQ9TOf2RUfaEeriS+/VQTmAvrPzNHkk/FDx/Af78fZa3w0adyY3qi682DNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147558; c=relaxed/simple;
	bh=5HfN+SVxgVSpi4+a5bxf/c5ATq5crTrGcd9sdNvl2U8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mNMkPQOrhlTiPaLWknpKDjw5NwuUYXhsA5kN4HvQxbZwjv51P9X3BLIXxXWFyroYXu6BukCnoRs37xbu4zuGjGp7lobYlvoQ3pX9teKg5JYe5UX6vg3lvKG1PqexaO46L1lmsbEiAo6/Zj7J7kVPu42LMI1Lj3x539hP5BWZUM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFkqkvmA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fec34f94abso46756915ad.2;
        Tue, 20 Aug 2024 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724147556; x=1724752356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jjmjW8rP7gw35M3crfIBureq8zsjQF5WZRXE1lCMGyM=;
        b=YFkqkvmAMrL3fNW/mHJzmEkkKBzktF0Xgov2QGDiIYDkRzBlltut5ccT7zCguSH0JL
         LcK8rAxiqe+yD0IEfunSEifAdGSMjDXHYn5mllkfJUKH/WlhzOa9FgSrAqYgIfG/3Z6r
         m7J+y/CgSnvLEssp1Kn/jowYfybMEg5GrAt294naS549RhTlNirhUYtDo3oi8jM/oylz
         s/pu6Ld1SzWXI6GFgfxx8TNYEHh8n5vxkoUVqClfghya9uMspogroEePQwHSvC9CLlvf
         CIkKjeSB3S9gcfyZUPEGpesyrvzk1xXq59X2EdJZw50f/C/VuMUYbiE0m2j4+ov8fFIv
         /88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724147556; x=1724752356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjmjW8rP7gw35M3crfIBureq8zsjQF5WZRXE1lCMGyM=;
        b=YgkuC1G/nmzNISToD5mWUa/CmcNaVwzzz9hiMtX128hJsqhdLyRd1dIl9uvYU7fCzX
         wXlPODDeEYNAYtTQk7R8BijGez0+ankFcP8ODpPI0Uj5y/3mkxZNwQVg8EaeG9K8LKiv
         0R5oIeVfO8ZPygCZ+CMXKR3MGXDsmHM2IUt1ebw7OQGz60U6cHdb5SqbU3zocjoYPnXp
         NJZUx1rnmQgU1T7avWfW/PVCXxRF75Emni/gOYAYaJcl4ESZFW/N9/DZzYS/1Sfxi8GF
         7PNtoOpCtgcEkP+4D010Iilk+GtVgI2uyyxbSHYLMQpMhXIh1h2l9BM58RQytFstA8q9
         IquQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyErHuFNnDzk4+U26HOhxO/j04OlE/3gD8rCV/ErzB+Y419CSyEHkc/vHn+xF+LmCfrGQawfAD4OuCUJTO@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmGzutsqskeefPuS0SgmUjjIDrnnnwpzdee0qL/KVdtPfXloQ
	6RaTyG8q81TF/vx2HCQzCurVzsKbXoAV1IwCSnv9to3zaEXwD2tOUJ+C0V851rM=
X-Google-Smtp-Source: AGHT+IHbSrT+dVNMI17JQzi7xo2ca6yjZioPmIBHBR30gimfH6IsEObzjlDgx98j+zUgs/EFxZ0kfw==
X-Received: by 2002:a17:902:ef44:b0:202:445:3c8f with SMTP id d9443c01a7336-20204453e1cmr163248895ad.30.1724147555538;
        Tue, 20 Aug 2024 02:52:35 -0700 (PDT)
Received: from localhost ([123.113.110.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f030350csm74651915ad.22.2024.08.20.02.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:52:35 -0700 (PDT)
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
Date: Tue, 20 Aug 2024 17:52:29 +0800
Message-Id: <20240820095229.380539-1-sunjunchao2870@gmail.com>
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
 include/trace/events/writeback.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 54e353c9f919..f3e0edc1a311 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -20,7 +20,16 @@
 		{I_CLEAR,		"I_CLEAR"},		\
 		{I_SYNC,		"I_SYNC"},		\
 		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
-		{I_REFERENCED,		"I_REFERENCED"}		\
+		{I_REFERENCED,		"I_REFERENCED"},	\
+		{I_DIO_WAKEUP,	"I_DIO_WAKEUP"},	\
+		{I_LINKABLE,	"I_LINKABLE"},	\
+		{I_DIRTY_TIME,	"I_DIRTY_TIME"},	\
+		{I_WB_SWITCH,	"I_WB_SWITCH"},	\
+		{I_OVL_INUSE,	"I_OVL_INUSE"},	\
+		{I_CREATING,	"I_CREATING"},	\
+		{I_DONTCACHE,	"I_DONTCACHE"},	\
+		{I_SYNC_QUEUED,	"I_SYNC_QUEUED"},	\
+		{I_PINNING_NETFS_WB, "I_PINNING_NETFS_WB"} \
 	)
 
 /* enums need to be exported to user space */
-- 
2.39.2


