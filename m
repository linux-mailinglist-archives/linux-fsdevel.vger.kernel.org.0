Return-Path: <linux-fsdevel+bounces-79548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOQICrgSqmkGKwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:33:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA4219506
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E542303A3CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5E736EA84;
	Thu,  5 Mar 2026 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arNEtzTW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7743736E47C;
	Thu,  5 Mar 2026 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753479; cv=none; b=AUq/70oTwS+qCg/JGcs84Jkf9IpHpVc2oqg+dRimP3Xh3lXNyOcgRrUg3GRw/lEcQwmnyX9J6wl+xJcYW1mUr7zy/V5lJkjAwioWLgxOpB78/xGjhm0NvHlV9Nkrd2VHNEAZCDfhdbKqrlXZ3mRhbrTzVzStDyljgXmSBiAQH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753479; c=relaxed/simple;
	bh=7s8+VRxkVOYhZ/0V/yWyXtD+NXc+CLa2t/HYS4SO890=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZKqul1RJavAmvmSLBntUT/b5P9Lh03HW6Jp3sSSNZQaWBJhHT6cz2psQn2xpiwlL7FDOWCGQOCdHd+FkMGEjSX0hq4qgTTw+NFgahf1P0TWI4/WySVAufiA4sH3d6fKhpytECJ0378kq/bxGJaZIhyqu4WISlJgcwXfnjZJyqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arNEtzTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605F6C116C6;
	Thu,  5 Mar 2026 23:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753479;
	bh=7s8+VRxkVOYhZ/0V/yWyXtD+NXc+CLa2t/HYS4SO890=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=arNEtzTW8xel+h6UkihMZ3oOj5qkVkY1dkfcq/ZUMlJvN3j7m/hgFlQU9Ho9UI7OA
	 OEJSgP0mQMY2+52yPprsEWPyrx8jklP0uknlg6+m9ibadIp9mFrJJT2zoEZd+Hutoa
	 SaC7g1+S6gs/NMUaXym2W03FnFHHCXav6LmWdyGQy2Zk5UX24NHkzjWmHDOPQbK8XN
	 OJXNLoOBXhmMVqV0IyZIY7SOdecN6NuOnzQTGi5oMNTWv/1QOMgSsGnuNm5EGQBcHg
	 fH3YEODvGDy6t42wShlPlUtJAOw1B1Igl0mpu2SPSvWtxz3rlApbRZi26r9gqduQq4
	 y8GChCVjtQX0A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:26 +0100
Subject: [PATCH RFC v2 23/23] fs: stop rewriting kthread fs structs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-kthread-nullfs-v2-23-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=634; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7s8+VRxkVOYhZ/0V/yWyXtD+NXc+CLa2t/HYS4SO890=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuL69TOJ6a1+dZyH5Kwp+3zXad+2UU65+Ii5Nf/v+
 YLdDe+mdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk9iojw1SOjX3mOaWlmb/i
 Uz7lr1H8dV3Q9tSpN+fn8zb6TWz+t5mR4be55u/IOSu90p1NTlx2LN5X78Bw/tnFZTM7rN3Zv3N
 2sQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 06FA4219506
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79548-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Now that we isolated kthreads filesystem state completely from userspace
stop rewriting their state.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index c1afa7513e34..74fcee814be3 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -61,6 +61,9 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p) {
+		if (p->flags & PF_KTHREAD)
+			continue;
+
 		task_lock(p);
 		fs = p->fs;
 		if (fs) {

-- 
2.47.3


