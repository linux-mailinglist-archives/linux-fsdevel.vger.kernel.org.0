Return-Path: <linux-fsdevel+bounces-24513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBD993FFB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 22:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6035A282D10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E446F18D4D5;
	Mon, 29 Jul 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TAN57LSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C716DEDA;
	Mon, 29 Jul 2024 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285831; cv=none; b=tZXcUNNCMYmLLUEjINoCP1CxLtyOkL5yTotQxfzcVms+hV0tJMSMO+yTvvkwHeHPleQa2Xn1Ra8d1iiUKf9bKD/HorDN6RCSl6irxNKGn04c0HgXzXMhYNd6OklCWGIOdvs2nv5jSiZNqwFhAeHo0ZDJJV4EbB57ng4pRpyIN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285831; c=relaxed/simple;
	bh=qZXkT1m6kcK7yZXSMPzw5QiS2oUJ7uAmwCFZNL/ZQwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pEqU6OXAOrqSv1efpUYohj1ow5fjiYsCxasdwcuLbVLwde8dBlUYdOj5Q46knL1p+Z11DhGy/WnBzOadZhAMkGfgQLTm0SF+EHFf4ZiiMcSZOLOhEkJCcVdkVO3Y0G+PnJVeCQfegk67rJQvA6x4UmloB0ZtlbZN+GY+bsutyck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TAN57LSb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722285818;
	bh=qZXkT1m6kcK7yZXSMPzw5QiS2oUJ7uAmwCFZNL/ZQwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TAN57LSb24MSSTuw/+AQnemeLldOcxXfpH8wQCnzQwDOOJTH4YZfKfOHRBfB3Eahs
	 OMKklB3As9UZsnU886s/yKG7aTPgMqZ/Yh/W5TrqXxiJgLt/CVs5ow46CVDRn5wYLJ
	 tD6NRhKA8WZp2c8ZZQ+MYKpFFLJfQ8ZSEvfOynhk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 29 Jul 2024 22:43:33 +0200
Subject: [PATCH 4/5] sysctl: make internal ctl_tables const
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240729-sysctl-const-api-v1-4-ca628c7a942c@weissschuh.net>
References: <20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net>
In-Reply-To: <20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722285818; l=1106;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qZXkT1m6kcK7yZXSMPzw5QiS2oUJ7uAmwCFZNL/ZQwc=;
 b=LdQo1qto1d9jseDguzEBJD+8pNzCLgH7Su6S6XVBOzUVXTKdyotcY4uMr2iFMoaglir/9clog
 j3nxiIXB96UAyeTsjjAw+xLhp4lmp4dJ/xLcV6KfnGqe89Z7Bzc4Pj3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Now that the sysctl core can handle registration of
"const struct ctl_table" constify the sysctl internal tables.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 01e006cc1163..c6cf21436d6c 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -30,7 +30,7 @@ static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
 /* Support for permanently empty directories */
-static struct ctl_table sysctl_mount_point[] = { };
+static const struct ctl_table sysctl_mount_point[] = { };
 
 /**
  * register_sysctl_mount_point() - registers a sysctl mount point
@@ -62,7 +62,7 @@ void proc_sys_poll_notify(struct ctl_table_poll *poll)
 	wake_up_interruptible(&poll->wait);
 }
 
-static struct ctl_table root_table[] = {
+static const struct ctl_table root_table[] = {
 	{
 		.procname = "",
 		.mode = S_IFDIR|S_IRUGO|S_IXUGO,

-- 
2.45.2


