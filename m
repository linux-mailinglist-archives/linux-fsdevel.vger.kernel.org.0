Return-Path: <linux-fsdevel+bounces-78384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJOqNKAjn2mPZAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 17:30:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7334019AAA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 17:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7747530C29CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70F3C1998;
	Wed, 25 Feb 2026 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpDovYHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A0E3B961D;
	Wed, 25 Feb 2026 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036738; cv=none; b=iqUbETIUzH4zB24gKYBFw9Le4pgS9bwzFeTdCz6FOJ4WSUKcrEbUCCfxSSIUknuwRvMpV9CqrvJyiViZIQsax6wG6EnEjqxyZENWcSX5sUAfa16Iba4my/zFJNaCuHyJxILe1+tyzR//FQ2yYpW/ABG67OmAlrnLViGyPDN5b18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036738; c=relaxed/simple;
	bh=LSEBcmcy4hg777AP0yVT25Qd/Sm0XmSI6qQHjKgeZBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGtPwNFohaCNKt+JUuqV8o72V/AooPXWfAPWStXQ/jpstxjhZkFOibuq3ekU1zXndcwL+6Vp6bTOdubkL6dNgdo5hjGlxNhWWxHTScJFWJPtm6aY2H/ZizxLfQr0GTE38/dITlQ6lEN45q9FsFBCSjUV+/T13rWN4VQ2BUW/5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpDovYHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A57C19421;
	Wed, 25 Feb 2026 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772036737;
	bh=LSEBcmcy4hg777AP0yVT25Qd/Sm0XmSI6qQHjKgeZBo=;
	h=From:To:Cc:Subject:Date:From;
	b=SpDovYHlAimH6Ijko6fpz+Dn4mujtUfptFoSqSty+kOBLZirzbDT0LRqZgRIGjz8D
	 w5v3EzzFmraIbL0C/8unijxXEjf462LFJcQBj7R/6qJNl+xRhhf/eIGgHhCQUBDR8T
	 kQshnI6gsJq+2B17+S4CZDgIglCQHlGQ4d46UgKh0OhLh3BnmqfDMZxRnnsOQNzaVK
	 JmvEaGY5geUutWoOnZVReYsPkRRn90k9+NgURJS42beFQZw4PWFv46TehAqTBBWQYF
	 H52zgTBjUGyEYjYBtJyiKckK3fRtC9cITtCeoWiFUYUPfLjFEXZWkQ9+m6kjDBe6LT
	 3In0gINFnr4zQ==
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: David Howells <dhowells@redhat.com>,
	<netdev@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH net-next] net: datagram: Bypass usercopy checks for kernel iterators
Date: Wed, 25 Feb 2026 11:25:32 -0500
Message-ID: <20260225162532.30587-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78384-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7334019AAA4
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Profiling NFSD under an iozone workload showed that hardened
usercopy checks consume roughly 1.3% of CPU in the TCP receive path.
These checks validate memory regions during copies, but provide no
security benefit when both source (skb data) and destination (kernel
pages in BVEC/KVEC iterators) reside in kernel address space.

Modify simple_copy_to_iter() and crc32c_and_copy_to_iter() to call
_copy_to_iter() directly when the destination is a kernel-only
iterator, bypassing the usercopy hardening validation. User-backed
iterators (ITER_UBUF, ITER_IOVEC) continue to use copy_to_iter()
with full validation.

This benefits kernel consumers of TCP receive such as the NFS client
and server and NVMe-TCP, which use ITER_BVEC for their receive
buffers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/core/datagram.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index c285c6465923..e83cf0125008 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -490,7 +490,10 @@ static size_t crc32c_and_copy_to_iter(const void *addr, size_t bytes,
 	u32 *crcp = _crcp;
 	size_t copied;
 
-	copied = copy_to_iter(addr, bytes, i);
+	if (user_backed_iter(i))
+		copied = copy_to_iter(addr, bytes, i);
+	else
+		copied = _copy_to_iter(addr, bytes, i);
 	*crcp = crc32c(*crcp, addr, copied);
 	return copied;
 }
@@ -515,10 +518,17 @@ int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
 EXPORT_SYMBOL(skb_copy_and_crc32c_datagram_iter);
 #endif /* CONFIG_NET_CRC32C */
 
+/*
+ * Bypass usercopy hardening for kernel-only iterators: no data
+ * crosses the user/kernel boundary, so the slab whitelist check
+ * on the source buffer is unnecessary overhead.
+ */
 static size_t simple_copy_to_iter(const void *addr, size_t bytes,
 		void *data __always_unused, struct iov_iter *i)
 {
-	return copy_to_iter(addr, bytes, i);
+	if (user_backed_iter(i))
+		return copy_to_iter(addr, bytes, i);
+	return _copy_to_iter(addr, bytes, i);
 }
 
 /**
-- 
2.52.0


