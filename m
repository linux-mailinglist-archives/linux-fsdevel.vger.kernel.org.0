Return-Path: <linux-fsdevel+bounces-77276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AgtDMwck2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:34:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD92143D88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2C8B303AF36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7230E83A;
	Mon, 16 Feb 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpeBzW5m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253B202F70;
	Mon, 16 Feb 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248742; cv=none; b=omnHEjpUSPDjCpryoZRXCRhKLSQ+WbaAG2tHwQUzlMqksWZ4N4L05bX0pvntFB8tzLWf4rdX9KnomqmmL2BZRvQ5RUkRJgM2kc3QI7rt+dtNDgIWmcWYG6e0myfaKctfagl/ABXMwf+Jy1uu5GNAVvLHja8uhqW6ekXVPOf94PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248742; c=relaxed/simple;
	bh=GQODvPKfpe1TuAASNlfZOpKx+opiPpT2Vm9Zk2O6rrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJkoR4vwagPSl62cI9KAFSSW3lDeG6VQQSNjrZMS+ZEPE5q2yM2Xqfiots6CZ0Fft2r10QQzFqsxRZ3ZAMy61TQTRKwJ99i5noghEoCQ/pL1gXHLPintMtS+3DUBvWXQ+HKrUBGiPApv0bCn/0aTwCBxajNCF9fGfQ6kKtvJigA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpeBzW5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1D2C19423;
	Mon, 16 Feb 2026 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248741;
	bh=GQODvPKfpe1TuAASNlfZOpKx+opiPpT2Vm9Zk2O6rrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LpeBzW5mKUxVFtLej99Vdf/DLsg/Lz5wVffdIB06ucKJPM75RkE2zw6eu2gjLAXY2
	 el/H2qkyx1qaloadnIfPom8wn/ga6OBtW96Kv80BBigoWZAesiZnp3CaXK5yO1AZdU
	 OPX9Xd/XtjLC1QmeBSXIZmPE9mhstsztwVmmhHQGEoFGOQ0V9kguWN4aILDUDeOb88
	 EkJJN7eIrl4ryh405XEph+QaqlOLsNFbrzrvZN28wgbc2mL43EzhIvvPbiC75ijZbf
	 h6at3a+Jt1uSrnUQFUHnP/J3xlPzVLSj0LZrGXC4SfyZ1+k0pOlk2cvdjPTR0Ms4dg
	 X9H6BjBtmKm2w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:31:57 +0100
Subject: [PATCH 01/14] xattr: add rcu_head and rhash_head to struct
 simple_xattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-xattr-socket-v1-1-c2efa4f74cb7@kernel.org>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
In-Reply-To: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
 linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2838; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GQODvPKfpe1TuAASNlfZOpKx+opiPpT2Vm9Zk2O6rrw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlomTaIl83Gt+OeTiNWF1CbMFL08cD3PetfQlJ0PZx
 WbTawUuHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxPMrwz1Ci5rhPAFOf3LKl
 78uOf5myJuvMsYUScicmG/244j11URIjw3++OjWV4xdd132cI+jgbPpzp/iMCku2ZWmmKV6996u
 YWQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77276-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDD92143D88
X-Rspamd-Action: no action

In preparation for converting simple_xattrs from rbtree to rhashtable,
add rhash_head and rcu_head members to struct simple_xattr. The
rhashtable implementation will use rhash_head for hash table linkage
and RCU-based lockless reads, requiring that replaced or removed xattr
entries be freed via call_rcu() rather than immediately.

Add simple_xattr_free_rcu() which schedules RCU-deferred freeing of an
xattr entry.  This will be used by callers of simple_xattr_set() once
they switch to the rhashtable-based xattr store.

No functional changes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xattr.c            | 23 +++++++++++++++++++++++
 include/linux/xattr.h |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 3e49e612e1ba..9cbb1917bcb2 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1197,6 +1197,29 @@ void simple_xattr_free(struct simple_xattr *xattr)
 	kvfree(xattr);
 }
 
+static void simple_xattr_rcu_free(struct rcu_head *head)
+{
+	struct simple_xattr *xattr;
+
+	xattr = container_of(head, struct simple_xattr, rcu);
+	simple_xattr_free(xattr);
+}
+
+/**
+ * simple_xattr_free_rcu - free an xattr object after an RCU grace period
+ * @xattr: the xattr object
+ *
+ * Schedule RCU-deferred freeing of an xattr entry. This is used by
+ * rhashtable-based callers of simple_xattr_set() that replace or remove
+ * an existing entry while concurrent RCU readers may still be accessing
+ * it.
+ */
+void simple_xattr_free_rcu(struct simple_xattr *xattr)
+{
+	if (xattr)
+		call_rcu(&xattr->rcu, simple_xattr_rcu_free);
+}
+
 /**
  * simple_xattr_alloc - allocate new xattr object
  * @value: value of the xattr object
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 64e9afe7d647..1328f2bfd2ce 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/rhashtable-types.h>
 #include <linux/user_namespace.h>
 #include <uapi/linux/xattr.h>
 
@@ -112,6 +113,8 @@ struct simple_xattrs {
 
 struct simple_xattr {
 	struct rb_node rb_node;
+	struct rhash_head hash_node;
+	struct rcu_head rcu;
 	char *name;
 	size_t size;
 	char value[];
@@ -122,6 +125,7 @@ void simple_xattrs_free(struct simple_xattrs *xattrs, size_t *freed_space);
 size_t simple_xattr_space(const char *name, size_t size);
 struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
 void simple_xattr_free(struct simple_xattr *xattr);
+void simple_xattr_free_rcu(struct simple_xattr *xattr);
 int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 		     void *buffer, size_t size);
 struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,

-- 
2.47.3


