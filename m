Return-Path: <linux-fsdevel+bounces-27531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C08962215
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41B128653D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 08:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BF115B11F;
	Wed, 28 Aug 2024 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJntjivo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50070148856;
	Wed, 28 Aug 2024 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724832847; cv=none; b=ASbwOROPD4p+1TXfvD/rRZ/vg/9ep8chVFsRR5vQZ6McGdHYkLuIbanlUHhPSlqnezzPEVjzPr4Jl1jTW+RMwm6yHBl4H8IRj2TG2DZpLxhrLjNkcD6ADrzHiGlyU56d31vCK9SkjcME0muJ26VXMoDKRTIhOBepDVYJ1CJrEew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724832847; c=relaxed/simple;
	bh=u+15Wmg/awFuvqsrkEEJpaAqEHNDFhA3tLRjd3jBU1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Aut5+v5ngVGV0a6o0ZGDFPJXFxlmGoceVtg6pY2E2tZn2mt4Ym1xicrdXw55FEGtLfd3XSq1FUYOWrrg04ULzb8/teTkScZvtC8tBEoRv3bR02PiWLLnn7z4M2DpF+09zekohEQfra3rzm1OUxnfGfVixLceufpn90/6fA1GCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJntjivo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2021c08b95cso2865175ad.0;
        Wed, 28 Aug 2024 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724832845; x=1725437645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4aN7PGugLjV9gcqgPc/7dtQp82+dGaPMgEqJk1q8y1E=;
        b=HJntjivodZ0AT1Q8vn1FQhzuE3QtiFpTi2KUrpg4GGcEz2kameq/iJsaCFX0T0Vz/X
         ND1qCd0VGUgrbSvkSl8X2XnQWNAfrV1a3SL91v7OmgRMQGnlzDIJmrDdtN66to+Kkopp
         mQmgEDt4tOMf/qBEeq27b6/9+wFefYoasZ6kDHMorUQ0prWarllMRj9lUrmHPZ1TWm1K
         OXb8PcemR/rhgz2bWyEH3TbbQRO6wKU68A0c4rxXMbfteTHT9M08bbl+jtN9qDIwH7fI
         tptIMvXB4fsFjZwsPwrt3nt7MlklNjVyyI1Rf0s2ZTQx5nRTq0I6yf0GaMmZ0wAU7OtD
         qqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724832845; x=1725437645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4aN7PGugLjV9gcqgPc/7dtQp82+dGaPMgEqJk1q8y1E=;
        b=JHBPs0Nfj1TRKNZW+hH0LIkjvMR/8G3hjH591YB25HbfxHEoTN5hVDlKJLG4iDheCs
         WsTQfTJYR++Vsn116h4kCrGf41qXhX12pVVTaD3FVo1Z01o5BXOUuvDo1FPGbYd5rkAq
         dKWJ5/r8P+/w3gLTYA0mGmNyYKgj8f+Qyxjn1j/PcaRAbb9lI8oT2JMNOeUevsIFrPHX
         Qt8odCYbTkvhA3TE4vGPs4XUvzpo68sSaaIBnMzkstBGUyz8N7OPX+wY8GdoQnXpuI4G
         FYsvHUaPTRifpTtIqDTZLMJ8sdiyIFSKbU7XcvDnETCBmuGVsagCkUW6hSJU1+z1pg28
         8jfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvPSPmlUf3CnQrdS9LoeFmiDmPEtohycJ0f9ieWU+xphtqdPGhVVcPBSArwVvghQ0ZroBrj4e2CjBmaDkf@vger.kernel.org
X-Gm-Message-State: AOJu0Yznck6yM5k0AoGFRbNQwMKGohdnli80pw1rxQtcAyW62+JCEFc2
	KE3P1LyzYiq8k+6RbCJ8w9sCBA3SP/6a2GmNRIlTdsvuWgdFXtvjl42fgQ==
X-Google-Smtp-Source: AGHT+IHwo80Dn2DTmqGdQ82k48C9V3gmkN/d31ZqMyvXswOCK4/ArZwv4n0cJHT7bcRuGQ+3Naa0Sw==
X-Received: by 2002:a17:902:c94c:b0:1fd:6ca4:f987 with SMTP id d9443c01a7336-204f9bcea59mr25338385ad.15.1724832844933;
        Wed, 28 Aug 2024 01:14:04 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fc70f0sm94092065ad.299.2024.08.28.01.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 01:14:04 -0700 (PDT)
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
Subject: [PATCH v2] writeback: Refine the show_inode_state() macro definition
Date: Wed, 28 Aug 2024 16:13:59 +0800
Message-Id: <20240828081359.62429-1-sunjunchao2870@gmail.com>
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
 include/trace/events/writeback.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 54e353c9f919..a261e86e61fa 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -20,7 +20,15 @@
 		{I_CLEAR,		"I_CLEAR"},		\
 		{I_SYNC,		"I_SYNC"},		\
 		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
-		{I_REFERENCED,		"I_REFERENCED"}		\
+		{I_REFERENCED,		"I_REFERENCED"},	\
+		{I_LINKABLE,		"I_LINKABLE"},		\
+		{I_WB_SWITCH,		"I_WB_SWITCH"},		\
+		{I_OVL_INUSE,		"I_OVL_INUSE"},		\
+		{I_CREATING,		"I_CREATING"},		\
+		{I_DONTCACHE,		"I_DONTCACHE"},		\
+		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
+		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
+		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"}	\
 	)
 
 /* enums need to be exported to user space */
-- 
2.39.2


