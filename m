Return-Path: <linux-fsdevel+bounces-32333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DACA9A3B7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 12:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7BD1F23E3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7307201106;
	Fri, 18 Oct 2024 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bX7xhte0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080671FCF73
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247289; cv=none; b=phemrARdoxwXF51J51r9Z62yCKPQ+Zl8fmv+deQ50sTcOjxo+9ms/JiPIoiQLG7/7eDNlss/b+3Ng5vQq4//qrWW9aHVkciL06+GfQpp3bA41EEGVilSWpXCCzqEWe7nysBI20Y0ayhsv3967oCRsTDAc3orid+4yN56K+97fx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247289; c=relaxed/simple;
	bh=x2GDt2t8xGxiZF0J3X6YiqT5UKSyMxpJP/dyTFIT94M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgiDbWu5Fymt5nZSRnj+1RiAOxX9aItt917S1DSwvrV2Czg8SLw8e0DlOGLC/GWQtm2s8cUjLdNahJgpsCk6XpDkJC1fpWl0A+LS6/w2jc13J02fay+6MLy2Blfp5r/0x/Ft+/DAw3m8FUwbYOx8eoLDfVxsSzn3x6yjqt54VGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bX7xhte0; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729247282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5KHT3ff6M8Nx/a1xS5GHR/zH/l+13M2qwmmTdtYZIM8=;
	b=bX7xhte0tWU2pjujPDcrlqJj4dfUrqU8DdZbf0cNur1y9XJ5SAYEsYWV1JhK0tU5r8RWZl
	p66PrsPNTQJmzjBEpo0hAtOfl3+d4vfYoy+HCPfFRn2AruJ1Y9Vo83NoLpf0/aKuwHXIIc
	HNoG+GXe2Cg6izwSP1DSbz7ATxSFO5g=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Tyler Hicks (Microsoft)" <code@tyhicks.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Yan Zhen <yanzhen@vivo.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: Fix W=1 build kernel-doc warning
Date: Fri, 18 Oct 2024 12:27:03 +0200
Message-ID: <20241018102705.92237-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Building the kernel with W=1 generates the following warning:

  fs/proc/fd.c:81: warning: This comment starts with '/**',
                   but isn't a kernel-doc comment.

Use a normal comment for the helper function proc_fdinfo_permission().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/proc/fd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 1f54a54bfb91..5e391cbca7a3 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -77,7 +77,7 @@ static int seq_fdinfo_open(struct inode *inode, struct file *file)
 	return single_open(file, seq_show, inode);
 }
 
-/**
+/*
  * Shared /proc/pid/fdinfo and /proc/pid/fdinfo/fd permission helper to ensure
  * that the current task has PTRACE_MODE_READ in addition to the normal
  * POSIX-like checks.
-- 
2.47.0


