Return-Path: <linux-fsdevel+bounces-29660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE7497BDD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960AB1F241E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B600818C936;
	Wed, 18 Sep 2024 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNDqNtCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF418C029;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668769; cv=none; b=SAbPZMXr203WCldLiGMsG5pzrOG8sMdJNQG2qA2g/BPy1AJ0u6dqubuEfrRSErwpAYxlrtNUCLjOXaWOC2n/BRIRcejbEjl3qnL5AepU5VbE/AobN2tJSg9SJq/MKV+j2LT+z8Ct+3o3TArxiKFgTjoiufqv/coUnBbFu2bisVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668769; c=relaxed/simple;
	bh=dEreoO87IPzkF5bkVO2hVE7fN0Lx5g86NkFxXF0VqJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWyD6gXqMyW/yCKpJA1M2MwVjWg28oM1ilnvk3knVNeFC3trQXdFqvf12rQHZKbIXvIsx8G7UWyTlub2bLae3ID3MW4Mj5HEVeuJfSC2fyFig5jqFXeoAdmSdfmQDC+I18iZdAu4wKyHg17mNF+tQ11ChhbQ6dA/9f2aG4RnmKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNDqNtCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F388C4CED2;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668769;
	bh=dEreoO87IPzkF5bkVO2hVE7fN0Lx5g86NkFxXF0VqJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CNDqNtCbMrFhikwPSr4duGD/JaPM6lLVD0X+KUz0WdRb/IvT5CTW0mQy5v8sFd+52
	 PIo2UKa1NjfUjrb4TVr015iemYwACFepMySFO4lWoQ8Ske/ctr8dqvSOhkcQ6iVY5w
	 DdKcQbhz+AzNmk+HqNhEfzCnv5aj+msAsLc60lyp93HKx6gA2LDRartOVCckIYw4/5
	 wiyUNoMHbfAlgLl8G4D9BXhopMgvjNK5TzgQkv19Xq88zAhnaTt7Dl4Sgvf0XXP4qg
	 IqEdIUDAfj4unHUrGMxVM5suC+3OZh3GO61ileOdXzz/+6eg3HeSd4lGdY/HwZCz7k
	 0KT7FRlzces0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C0ACCD1BA;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:12:23 +0800
Subject: [PATCH v5.4-v4.19 4/6] fs: new helper vfs_empty_path()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-5-4-y-v1-4-8a771c9bbe5f@gmail.com>
References: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=EYzTtx4WfUuets9SJVOnFqg05Micjvp+v1D6XppGYQY=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t/da9VVbzSOdM+CPOCM6K9MndKp6pQ7ppFDv
 SrJFJsLFQ+JAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurf3QAKCRCwMePKe/7Z
 bh5QD/9Fx/EnoLO4EloMc7UpLPmUwiStv+abbyt9H8hvmayjroYdsUtm6QwKmdZV6COGzLuhQIR
 7z/UX5cfkwadDwS3HTRcW6v+e3+06bWfVHL2IvAbtvS8N7VwVRq4QpTiouuYpWsZ36WUSYQxyLC
 ybnDWhCIfBbGnnhRzmzfkqL49tjAHeWlIKOSRydPgRyXPl3RHdikWhh2NQFVSiDv/xrJPyIGNo6
 NW4ZHdS4QrU1TS88vGAJZlLRDALikj/13voqcme4A/gHC6RquqxPU1wU4neVZ6X2rzhuWCwG8eQ
 DswVi8ZzDc1fuFjyYr7x/XF4tbeaXD1IdH9vMmjc0otVm2QpNwE4tHI0UQfju8iKpQP6fLVSzST
 4mvl3uiikVzjiChkVT5BPTGrY8QxzB9rz3A9oNjo+fF7xhQCdzVCyjL2Nl0BOZS1t3OksNcwVoz
 655/H0Q09sAacgZIQQH2vHCZoaNIqMHoH7Iyio4iNZN6eUpKXQkUFITCH+TpWh2R00utdXMhU5w
 dizCwz/5uwaCcDgvFHS9pdwb2sXLMIbGFpkr9/xDmQR8KxfgUpTXv9/j9aJFrLTM22T26eX+san
 FmEgQX0AVXExKPNKFHAZpEx2obP6++aA1iluQEwfrBfg/U43oP5m6naHlGvVJp0f/RtEe3ytBEf
 S4FnwM+yQkLHwIw==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Christian Brauner <brauner@kernel.org>

commit 1bc6d44 upstream.

Make it possible to quickly check whether AT_EMPTY_PATH is valid.
Note, after some discussion we decided to also allow NULL to be passed
instead of requiring the empty string.

Signed-off-by: Christian Brauner <brauner@kernel.org>

Cc: <stable@vger.kernel.org> # 4.19.x-5.4.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/stat.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index 526fa0801cad..3ae958308e48 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -150,6 +150,23 @@ int vfs_statx_fd(unsigned int fd, struct kstat *stat,
 }
 EXPORT_SYMBOL(vfs_statx_fd);
 
+static inline bool vfs_empty_path(int dfd, const char __user *path)
+{
+	char c;
+
+	if (dfd < 0)
+		return false;
+
+	/* We now allow NULL to be used for empty path. */
+	if (!path)
+		return true;
+
+	if (unlikely(get_user(c, path)))
+		return false;
+
+	return !c;
+}
+
 /**
  * vfs_statx - Get basic and extra attributes by filename
  * @dfd: A file descriptor representing the base dir for a relative filename

-- 
2.43.0



