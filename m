Return-Path: <linux-fsdevel+bounces-20724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDC58D732E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 04:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BCE281960
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 02:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DB98BF3;
	Sun,  2 Jun 2024 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItFYeV9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08511859;
	Sun,  2 Jun 2024 02:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717296439; cv=none; b=ZIT8vHVGHi1UeboLtSA7UFAJvsglPSMC7IMUiJdWhINswhu2aHIdYk5MawARVlF521ENcywam3iWQG5Vv7yXHfQSnpd+zB3wlozD91WCkPbVKhzHLj3stt6FCxdna2B49Q1gNSU3Gb38EDlIi2CszhSwNjHjQvDFiEKeY3LJ/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717296439; c=relaxed/simple;
	bh=c88VhkTo2sPOlFRrPrweVXH7AtkGnW5PCWNhKi/l810=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JflzSeNzv1gCwu3QLQrUK7IhYC/G8gCDse/Du+rBfN4l3lvQfXQX15ucA2Y9qBCqZDV8dMaKqaAQB2QPNaBaTgTnMewbQyvqCwK0/p6gTDUBwAstUrowY40jtzKWJM7LTF1pwS4hqErBfTXQbFSH3m6fnMr58B+sO8sZ0Ixj2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItFYeV9i; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f8d2ec8652so1988066a34.3;
        Sat, 01 Jun 2024 19:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717296437; x=1717901237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu3o/1wkpiEjxw3AW0N2UpaOJE3SQdUz6rVg/pLPlFs=;
        b=ItFYeV9ieaE51n7dzNZlB6kO4BqgAQKRiL/8br0Y62A6z6DfUA+fRhpcRDQLsUX3vU
         qpYYs8Cy64JdtA5wulLNM0aradWFlG/v6L06xB4/4Utnrq1ecZ4qgRooXEl0I2kghZXM
         3xrTE7yWzAq4TfsjsDn+JP2vemz6LF5YugPbiS7Aznz1uaQepsJ+ly0Tn1wldWnoVSxT
         Mk2JnrUp0hmtHNY8emGIO+wPyIoK39ki8FSy3bhnnxGeyH6WZjCbOtGOMVr5uT4qibRs
         ztARHSmX9TNz5MYAFhbREhXDHpDXl68ZABIh3vDf6d1Kw+7xnvJK88Aj/kwcdH0msYbO
         4gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717296437; x=1717901237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bu3o/1wkpiEjxw3AW0N2UpaOJE3SQdUz6rVg/pLPlFs=;
        b=WWAW4lXZ0XDtBw/hMdv2H8G80gMmR0LR3sOaGxMnD7KGJnPxJVA80CVDY/didzCliW
         rYW4e9SFrkmgdEWPiEW7fP9b4BS0jdORgjdZYVHSevww2ZMbdny8XEHfLlbYh2Oy8xNL
         Ff3JMtAIbEBuCYexh2mEQgo22xiqN+RkZukHm2PYu/qkMWR+IX3Xb9Y87GHUODJg7Z1W
         Usqb24ZolUhU24oNZFeIRVi2xu37qAgNyCvprg78yg/faCuIgQr075D/7K7aQMqhz+CV
         HElS9FCWbYCKW9wRWKTnD8icqYMXkyn4iV5qgokhjUWAuLqjCOfDbKrSZWRFS5IFlJnO
         NtkA==
X-Forwarded-Encrypted: i=1; AJvYcCVriXAF4w3RiaVCNBR6yIDqxHc3RDau5/NyCVkKXTmGQZ4vcvQdAawZV9Gl4xJo8aIS50GV5/Q9DdAa9Qq3c1Gl1SMJ3+wUwOcqWhrtYuIdlSYRbC5ts5iWuUEwgLNjPzbC1dMm+9s/8db5ScxUlP/cdpU4nyzEYkIu9s8yqD3YwxPTb8AQCT5nmjbrxeuPPCFLk1/7bOtFj9SrzCu38hM+sgD4cLWqIkEPRlOClwIZoG50OEV847FLeP/QjobxUqAzA/GglmNWc2XHvDJkj1aXVSmKYlOnIEPW04gS0A==
X-Gm-Message-State: AOJu0YzYLVQl6VaUK1BeFk55sZSGBDauDybmzq3aoODxoRO/D4+luS32
	9nsFFN7SwzRkbmiS7Dy8IypZUG+8vgz6CrBn+yq0z/CBHw5i9B0/
X-Google-Smtp-Source: AGHT+IFc6pB9c2/xDQu9bENUVRyBXhBelq6v1sdhKRdECc7iHQz2zEq+tFq0IQc1xoKSQZnnKrMN/w==
X-Received: by 2002:a9d:6c07:0:b0:6f9:91c:f275 with SMTP id 46e09a7af769-6f911fba0c7mr5694846a34.38.1717296436688;
        Sat, 01 Jun 2024 19:47:16 -0700 (PDT)
Received: from localhost.localdomain ([39.144.45.187])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c353f0aef3sm3289959a12.10.2024.06.01.19.47.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2024 19:47:16 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: laoar.shao@gmail.com,
	torvalds@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH 6/6] selftests/bpf: Replace memcpy() with __get_task_comm()
Date: Sun,  2 Jun 2024 10:46:58 +0800
Message-Id: <20240602024658.25922-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240602023754.25443-1-laoar.shao@gmail.com>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
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
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykola Lysenko <mykolal@fb.com>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
index 11ee801e75e7..e5df95b56c53 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
@@ -20,7 +20,7 @@ TRACE_EVENT(bpf_testmod_test_read,
 	),
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, task);
 		__entry->off = ctx->off;
 		__entry->len = ctx->len;
 	),
-- 
2.39.1


