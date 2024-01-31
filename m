Return-Path: <linux-fsdevel+bounces-9640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B25843F1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625371F31155
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 12:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB90478690;
	Wed, 31 Jan 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gpwVmNbX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2F67866C;
	Wed, 31 Jan 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702675; cv=none; b=JIzOX3o3nCHpjoLz3iKxi+JjQMiBT+nqBOUgFOk0HyP1GrDYtm8SsITkjClxIqp6uCQ1/6Lht2U0Kf7lBT42jIy+ubp9u/Sbw9w4lVMpLbD81dzGfN7djhsiztZ3znQw1si1bBQXEhiQtlAPfy48Ve8N0zdL1Kr24FpnlS5awEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702675; c=relaxed/simple;
	bh=F+KoyRFtfnsgTzITPD6Uvzz6cJDqE0m6fF2NfXjS3LQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=u39f1ODfm94IvorN4Uq4vQ9PUgW2fCDwIcHp9XrOkyVDqGTkBRsUTlaOqNsRc3SW/m3wZamR0yTz2wfOL3mlvTUIFRvCRifpAwnz4UZDF1wMIo9t++cb6J1zrwojoy+j/paBrQ5pmwHQ5NqpDRf8G5Ze4mqVL3iRbsKeqm/HjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gpwVmNbX; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706702669; bh=OcZp1rMol08Z2WnpIQmEJuPhzfQf6La7Ry56I2aCSsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gpwVmNbXAfM4HjLrVX8m0DwgrXVHwxM1nuqcFibTpkSFKbMMwGlHoYCrKkE/+jvSn
	 ln7ROO//5hE+V/MnBzbemmx3MnkH4qqvNsXL5QAUeXtOCENFHRnJ11mrtQpGcaPf9T
	 Cgacs6g7BLoSDldyPbpUeVICnlTULcYCDq+5hflQ=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 11AB34D7; Wed, 31 Jan 2024 20:04:26 +0800
X-QQ-mid: xmsmtpt1706702666trpq83rx5
Message-ID: <tencent_7F29369E974036964A3E742F778567CC3C09@qq.com>
X-QQ-XMAILINFO: OLnGMPzD2sDV+bM4O4JxdQZTGtdlH6EIv/Y5bpK8lXUeNSaV2P4W7A21k+tGbI
	 D0jyWTusET0jyeMDp7cTfzxJYtNw1itwcDjWUkA9cwwuVJV/bguC4oyCbPTOK+lYM8ye5Dj8vv29
	 aOitfrB3wHibIKHCTOD/MMOHfNmJNq5nIXGi0/BMGKG/9itEWu61AFaRFm8b49Vnc7RCin7rPbE0
	 UXyjVoHSLMGIfpaHcn4H76GYPxGvM0yDphIkhJK1j+iOytFU9L/RDZx35ZS3HE9DEoUonWUDlZHi
	 AIt5TdCRdNft9MSJ3/1QV4dpTjs2hQxqBTYTb6keYJDMWnTsh94mPqLfkd/0XwLGL4k5eCxY+uXy
	 S3urh/tbk6bg3kW5BPY30kVFLo+Arfn5ntNqyQMCJfP/V7coJkjPsbdV2ExrwApaXTgfVbmbzGTe
	 xMb4ZIWH2lb14UO07bkI4LjDq31NeMfxAGFck/F9HCx4QguPY0lbWZ3iCIBHgq3LS+cnKbaJdmrH
	 XyVIvas5fJEa937Kt/jexRVHb3+2fWkaA7jTODK40+BdCxwJZdfljDgzIpqtOhK95rIqMLkfLbsE
	 vYH/vmb6RvP4UZ0zqXr4zZtzuD0+vM1kso+eW4MlZHgRc2Hm/BPli4+fnfCO+BId8uQyb5WnOPJG
	 1XgHgqpjQWFRTlhHi1Pf/zBR9pRy+lXgE53/gdYD/BQxD8+QgAIRQG7cBih+8l0mSAd4YkJaR/O7
	 NFNcdJlInV+vmI5Db7+dxJYjdeLpTBEmX1gNk25yFI58KE1Z3GYKlVOVu6GYFbfflpcTfDTl9pwr
	 gwakJY7xSvCvivCWNiLwlUK0vrLQN3QQfJzr9fJKcYgdNtC6LBBdZ7icRbA3CKDQRA6znu9Dd82M
	 3PVfUXwpNO+UeLvB1UpzMZAL0jZ3cjk43u6A+89xem9QkjrVTajx5XJEX3eIiHhn4xRu/xTLkK2D
	 xD8CM7D3qMqAjsXIQqwQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca,
	chandan.babu@oracle.com,
	jack@suse.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: [PATCH] jbd2: user-memory-access in jbd2__journal_start
Date: Wed, 31 Jan 2024 20:04:27 +0800
X-OQ-MSGID: <20240131120426.1278044-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000d6e06d06102ae80b@google.com>
References: <000000000000d6e06d06102ae80b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before reusing the handle, it is necessary to confirm that the transaction is 
ready.

Reported-and-tested-by: syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jbd2/transaction.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cb0b8d6fc0c6..702312cd5392 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -493,6 +493,9 @@ handle_t *jbd2__journal_start(journal_t *journal, int nblocks, int rsv_blocks,
 		return ERR_PTR(-EROFS);
 
 	if (handle) {
+		if (handle->saved_alloc_context & ~PF_MEMALLOC_NOFS)
+			return ERR_PTR(-EBUSY);
+
 		J_ASSERT(handle->h_transaction->t_journal == journal);
 		handle->h_ref++;
 		return handle;
-- 
2.43.0


