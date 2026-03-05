Return-Path: <linux-fsdevel+bounces-79546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLA7NI8UqmmYKwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:41:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A9D2196AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B29E31953B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6036536CDEC;
	Thu,  5 Mar 2026 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzq4+aMM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE936C9E2;
	Thu,  5 Mar 2026 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753474; cv=none; b=fBR7599YhclIsoDl0z8ezagbgzMB1ybSp6fO+Ie4RGzxN/X/Mg7nGhdxxVnybaS4KnMfKDhLSLSd7zT8+GoGIzK9xBCGzMQykg09AO0dXgFGSNl12Rc+fsR4AQE7WKwWPWD3il5ijvLXua4/pz38cghr3+uHIXlt/jkDE+yvhYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753474; c=relaxed/simple;
	bh=cEdUQUlFBerrrjll65RYnh0FxEaBJ8BqmqOAkJYC198=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mxSUD2p1dTd4bpgK5f/kbd/miXpti56W8f7OCU4qSbwhRsAK1XCAgFodYT4sClr8XO2aKTkiTXuuzMjwyoVDfR6c1CjAX90rAjWh0bAFZ7CYg5pmil3DiVhddjl0JwRHtcpNtWfji3dds9tZnKvt6QvhZ3IbnESObYE5mQfIY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzq4+aMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A699C19423;
	Thu,  5 Mar 2026 23:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753474;
	bh=cEdUQUlFBerrrjll65RYnh0FxEaBJ8BqmqOAkJYC198=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qzq4+aMMy3XptoROLLxxvWTFnkzdLo8JrA3JBoCmCLaX+SKz7xD4Cuo5T+dKJ00oW
	 nRkZuGrBhEjKyXLKFBlveAR/h5KOwVTM2rB4kZyarP04jnP9A8tj1mCAGzYhP91ypa
	 dqEVSQl9Wb+VXh9mTa7OVPkxAdnNMjMAXJfG0kuDAh2XFHUlFqIAXiDp1tOSLKqM8I
	 ZxqaX9XKImyzqwbawnuaCWpRApI0iUNbT8NBx2FUUqjgptCODVLOF24maTX18eTPMj
	 brf5ZDhE/gwCl2xKtA29sk37n0xJEQQEkqF9PRTe5/HG1UkS6DsgjGKq6E+kqjoDTI
	 qGLHzxWhdv4/Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:24 +0100
Subject: [PATCH RFC v2 21/23] nullfs: make nullfs multi-instance
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-kthread-nullfs-v2-21-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cEdUQUlFBerrrjll65RYnh0FxEaBJ8BqmqOAkJYC198=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuIq9t5TYMl60PXIZpGDnXxB/OtUimaoXYn62XXfz
 O2v4RPjjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlUdzL84eSX/CxkeOP5ubDL
 Rlluj61ulhwJMlnse+iQz9q5F/Ksihn+pz2/6drLmSzu8i7zcHmAQ/2P9wH9wTxPD4n73zm2m/k
 fKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 34A9D2196AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79546-lists,linux-fsdevel=lfdr.de];
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

Allow multiple instances of nullfs to be created. Right now we're only
going to use it for kernel-internal purposes but ultimately we can allow
userspace to use it too to e.g., safely overmount stuff.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nullfs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nullfs.c b/fs/nullfs.c
index fdbd3e5d3d71..88ba4f3fc3a2 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -40,14 +40,9 @@ static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	return 0;
 }
 
-/*
- * For now this is a single global instance. If needed we can make it
- * mountable by userspace at which point we will need to make it
- * multi-instance.
- */
 static int nullfs_fs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, nullfs_fs_fill_super);
+	return get_tree_nodev(fc, nullfs_fs_fill_super);
 }
 
 static const struct fs_context_operations nullfs_fs_context_ops = {

-- 
2.47.3


