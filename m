Return-Path: <linux-fsdevel+bounces-64132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BDCBD9BF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 15:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB03118A33D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 13:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44418314A9F;
	Tue, 14 Oct 2025 13:30:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DE314D0B;
	Tue, 14 Oct 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448621; cv=none; b=NFJFnxivUbRAb9oUfdqA0fINE53ErkRM3WR+mgi9gC/HgUWrMcqad3OTpk+H7f8M8SCbr8tR6pWvW00KMQJyFim9TUXPMAJRuRKJ2BVGpcW/hOuU4Ln9Wk3gOb1AsmiZ2irNMYHaIMSYh/doTr+2VxPRRC9JyBMR3bNVahMvILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448621; c=relaxed/simple;
	bh=oL4nTb9H9q0OWx0ZruoXgxTlyoCespe25xJ9ZzTsNKw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=rOIThMBUpBnEGGDK+JKU2LqMvq0fnROYv0NybbmyKgLFkpgeciHBeKx6kR7w82Y58ejbpPxliEKgMGfRrG45zoFzRLv/NasFP2CPHKEhjpTNpf/dAry9lAAyoImT/m52sh3+lq3kPK0UFlGu7BorUCYvVXTzDcoIdbevIkjS1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59EDU6ol086633;
	Tue, 14 Oct 2025 22:30:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59EDU5Vq086630
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 14 Oct 2025 22:30:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d74eef30-fed4-46a8-801e-c86e8ed2632f@I-love.SAKURA.ne.jp>
Date: Tue, 14 Oct 2025 22:30:05 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] hpfs: make check=none mount option excludable
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-kernel@vger.kernel.org,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Antoni Pokusinski <apokusinski01@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <68794b99.a70a0220.693ce.0052.GAE@google.com>
 <8a2fc775-e4f7-406d-b6dd-8b1f3cd851a3@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <8a2fc775-e4f7-406d-b6dd-8b1f3cd851a3@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp

syzbot is reporting use-after-free read problem when a crafted HPFS image
was mounted with "check=none" option.

The "check=none" option is intended for only users who want maximum speed
and use the filesystem only on trusted input. But fuzzers are for using
the filesystem on untrusted input.

Mikulas Patocka (the HPFS maintainer) thinks that there is no need to add
some middle ground where "check=none" would check some structures and won't
check others. Therefore, to make sure that fuzzers and careful users do not
by error specify "check=none" at runtime, make "check=none" being
excludable at build time.

Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
Link: https://lkml.kernel.org/r/9ca81125-1c7b-ddaf-09ea-638bc5712632@redhat.com
Tested-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/hpfs/Kconfig | 11 +++++++++++
 fs/hpfs/super.c |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/fs/hpfs/Kconfig b/fs/hpfs/Kconfig
index ac1e9318e65a..d3dfbe76be8a 100644
--- a/fs/hpfs/Kconfig
+++ b/fs/hpfs/Kconfig
@@ -15,3 +15,14 @@ config HPFS_FS
 
 	  To compile this file system support as a module, choose M here: the
 	  module will be called hpfs.  If unsure, say N.
+
+config HPFS_FS_ALLOW_NO_ERROR_CHECK_MODE
+	bool "Allow no-error-check mode for maximum speed"
+	depends on HPFS_FS
+	default n
+	help
+	  This option enables check=none mount option. If check=none is
+	  specified, users can expect maximum speed at the cost of minimum
+	  robustness. Sane users should not specify check=none option, for e.g.
+	  use-after-free bug will happen when the filesystem is corrupted or
+	  crafted.
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 8ab85e7ac91e..656b1ae01812 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -285,7 +285,9 @@ static const struct constant_table hpfs_param_case[] = {
 };
 
 static const struct constant_table hpfs_param_check[] = {
+#ifdef CONFIG_HPFS_FS_ALLOW_NO_ERROR_CHECK_MODE
 	{"none",	0},
+#endif
 	{"normal",	1},
 	{"strict",	2},
 	{}
-- 
2.47.3



