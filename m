Return-Path: <linux-fsdevel+bounces-47172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2267DA9A298
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6646F7AAD80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1463C1E7640;
	Thu, 24 Apr 2025 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cQ44cNcI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D984FAD;
	Thu, 24 Apr 2025 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477468; cv=none; b=uk2ARcr7GXGzt44mL/TXk5MOCpnAXEHa00hoa8d06Z4ZQ8wht2syCuOS7SGsXHJ3oIJFxBDsAHHx2JqJeIuziW6dZUAqaUjZ4NsfIslqUyMZMzfmoGJq1OpkSH/MJI+q+O5YwkCPd6XJVHvi5/bIdEnperdsKf34EXXSUr//IHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477468; c=relaxed/simple;
	bh=YUqFaolK70tIHze1raSHxQx+MPArt1jaLflfVUTlO30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aKOxbKkiTfYytXpEx2hyHjZ4kwzDA7ImYYKrjdeaJ4Yht30H0vr3+EgohoVH56RwVP/0lGK2wGntVHLOVixYRcYaT0u6A8NRsoxO8u2lVZa34KzUfMO/Rpn1sYVjaoVysxeFcdsyxwhuR4E7UTvmQ1uW/P90TE5hvpZ4Nm1SND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cQ44cNcI; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1745477439;
	bh=mYBn+g5OVFQvnrqXuqJ2ckhmMkHq01v5baNBySf9l+c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=cQ44cNcIi0gikJNhh+h6NswImRKzy6jRCZc0GQPKe8phWppwmzSNay4b87JFZtM8a
	 gGdIzjrNQSk67RZwoydCiAeY5m4pZpx5qCgwF+pfeyQK4Rhk9xycCzuJd9gjcS321b
	 Cjn5eQ8o6UQYvU6nQnBJ9IQ3E3yPkPgbsuZ/TOwg=
X-QQ-mid: zesmtpsz6t1745477398td90f47ac
X-QQ-Originating-IP: JNaxm3TXiwarxAdKo0WTzxy7CGkqoS9/BuXUfdnuaho=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Apr 2025 14:49:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17841742583809714878
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] fs/locks: optimize locks_remove_posix
Date: Thu, 24 Apr 2025 14:48:32 +0800
Message-Id: <20250424064832.347177-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MgQY1K25Ph0mG5SsRP/buSuG0EKL3kCyJosiUgNr7W7XQVi2S3sIbBdV
	L90dilNLyUXYWKD+DWlcRn9X7qadqhtFjMtFmdmyCIR42k+AHlcgxHWlOwwBVQSYMj/apHS
	mAjIHOYX7JkbRkxF/dh6EjR+oPvs7u+JcInmRq95DwNE/exyapVZn3dNlvcE5dCxIO0s0vS
	+eDwiY8aFrqvi07Ow+EnATaTFEM4eftnDK1g+w+t2qtyietJxjagdTl0A5b5BCqbmGA5a7k
	dm4GaH4Gu4LpctfvkvUwBEPsRpLp3ZFlOeM6OaHYAXRIC699TEHgg1ThRg7A0y8KBT2DMPo
	4YieVxYCRvjo5wfkX3CsXW4R/2RAdyrPJ6lMRkvcg9tU7tx+jrJyCzOIEP3UGe6YSSwEvQ8
	6Ddzbz4FaTJ6PEWoqDGQ9paheoI+sVTdnMQCXVixH07hndqnSikejEwkQlXTE/Wqmg3sHXV
	woWG9RgsF/f9ouhPMB2EwEcXgR7sUj+iqXDylcKnQieO6lGy6ymQFYlYBX7XRnTYi4ML+rc
	8DMzXuYig4iS87u+A4dOPOVm1JMjmawurP5YoHyxkYSCUEVsOvCHjxA48/HODNYdOuauRjo
	oxXyERCDw3jY8iT1wqUhzV34wbraf0ceh02A0qJXgHRZn3xJgmrNY7cHaYWFOjx5/wQDbEG
	4tMVfx2eeDx+03EndwjrdrHjFBU+aCTzjPShKc9RNipibuzeJjOVT/6EALM4WRDe1OKp3OE
	fNv4sRmwBDDMwUSgD2weWWbiUokaG02SnuKnyJkJ1rXWX/3wZnoae1XABd0jUL40jWIFTfb
	FyUjDkw1DuhiuMI+42uTSgg8DBjjtDCfwjVpPAbNqdDNkgWHt/2WZxcExTUzufm72qVm1Gv
	s4RWRCGXU2U4rGr0pOIJBcFKZ5wa0+tETs+SK6JX1A63ckxUXpfElHuTmvhTHgybs/BLVr3
	3dOldcJOrAmBi97wVE5Krgg3qjz3DLr1alh/tTtiTfBcqXFRGkPDkbrlbvBj2Nr6YquFuai
	3tLoQhj1gr2F8I4wFX9n+ko2UWm1wjMXEKKc9KEav5KgreSeSHOQNsAz1edPY=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Found by reading the gdb disassemble func,
remove the three lines in the hot path,
and locks_init_lock init them by memset0:
lock.fl_start = 0;
lock.fl_ops = NULL;
lock.fl_lmops = NULL;

Tested in unixbench syscall mircobench mark,
and perf locks_remove_posix from 1.32% to 1%.
Improve the syscall bench from 1858 to 1873.
call path:
99.08% main
- 17.07% __close
...
- 4.85% __arm64_sys_close
- 2.74% filp_flush
- 1.00$ locks_remove_posix

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/locks.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 44715c43460a1..14b6ee5e82ed4 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2554,13 +2554,10 @@ void locks_remove_posix(struct file *filp, fl_owner_t owner)
 	locks_init_lock(&lock);
 	lock.fl_type = F_UNLCK;
 	lock.fl_flags = FL_POSIX | FL_CLOSE;
-	lock.fl_start = 0;
 	lock.fl_end = OFFSET_MAX;
 	lock.fl_owner = owner;
 	lock.fl_pid = current->tgid;
 	lock.fl_file = filp;
-	lock.fl_ops = NULL;
-	lock.fl_lmops = NULL;
 
 	error = vfs_lock_file(filp, F_SETLK, &lock, NULL);
 
-- 
2.20.1


