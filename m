Return-Path: <linux-fsdevel+bounces-79531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A0NEMQSqmkGKwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:33:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9734621950D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AADE630528B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03641368291;
	Thu,  5 Mar 2026 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQQIgiGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA131459FA;
	Thu,  5 Mar 2026 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753436; cv=none; b=WIqe8OGZiGa0vvGoVUjwG4mHoSDvP2wzwTxfelVZixIcGEYoLkQWKrPD/ZrFa5F1+brN0shykmQSpRHKk+3+Ns6phPSOnunu00fJ8czX/BW+ax0Nu1d/I+qPS/PvAdWyTcCOCP9ceYyCGZTaNABeGtuv7mnftzh2/1DrBDqzGU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753436; c=relaxed/simple;
	bh=mTnIonLZYMjXHvkplxKLW57Mj6daBEBoDy+9bwPX4hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AgzxpVlt97hamqugxw3sBu73miKc72NQdEPmSQLU8CNpAhL7goZvwHD9nrGuv0iGdDvxbc/9dJE/gMMZTy4OBjfa9fOe+tfk2m545MxXYH7FkLmjAn7Vn2PXEPJfMqn7bqFlo+iro+GZ871swu6BSQiRcx/8To0qfAIM2bUijm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQQIgiGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F927C19423;
	Thu,  5 Mar 2026 23:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753436;
	bh=mTnIonLZYMjXHvkplxKLW57Mj6daBEBoDy+9bwPX4hU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uQQIgiGP+4KPGYq7C7y6G/gliGx1mtDkiMChTpymclR689L/QwD+oIBBarKzFi1W9
	 f9pncDpq+uu6s3tKyaZVcVVQ0fvlqx6gBj8jvCvLvZqw6D3coRSeOrQZprnFVRzWll
	 lwQ7+x+gwm6fmnYFbl85sczKOlW8cRNFRFI5YXxbZ3Q+hBkDxxNtrL7KUStrY8pQzO
	 23vDoSpZ1MX+GSwfJZpHVRxhtO05pC5u96QckujXHhEn81oQLgrtcEQaxWu5ydhZpO
	 Ujh46CL4Vz2E9/xN+FnVtylo0k1Zoa7NfMnJKi/N4ZTecU9ELTplV2Esg0apefwY5b
	 67e9ALnZe+6eQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:09 +0100
Subject: [PATCH RFC v2 06/23] scsi: target: use scoped_with_init_fs() for
 APTPL metadata
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-work-kthread-nullfs-v2-6-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mTnIonLZYMjXHvkplxKLW57Mj6daBEBoDy+9bwPX4hU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuKsmjqjXar5znadQiOzaRcErlx47xt+0uTcXxcdo
 TXhCWdsOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyj5fhn03l9ZyZj5z278p6
 Xan3RivySPWrc/2MuXaLlkbFB2zy/MXwz3jaFbnbXiK1Fafma97s6/qg2qOvnfhxb7q/NV9DEec
 hHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 9734621950D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79531-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use scoped_with_init_fs() to temporarily override current->fs for
the filp_open() call in __core_scsi3_write_aptpl_to_file() so the
path lookup happens in init's filesystem context.

__core_scsi3_write_aptpl_to_file() ← core_scsi3_update_and_write_aptpl()
← PR command handlers ← target_queued_submit_work() ← kworker

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/target/target_core_pr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index f88e63aefcd8..2a030f119b24 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -18,6 +18,7 @@
 #include <linux/file.h>
 #include <linux/fcntl.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <scsi/scsi_proto.h>
 #include <linux/unaligned.h>
 
@@ -1969,7 +1970,8 @@ static int __core_scsi3_write_aptpl_to_file(
 	if (!path)
 		return -ENOMEM;
 
-	file = filp_open(path, flags, 0600);
+	scoped_with_init_fs()
+		file = filp_open(path, flags, 0600);
 	if (IS_ERR(file)) {
 		pr_err("filp_open(%s) for APTPL metadata"
 			" failed\n", path);

-- 
2.47.3


