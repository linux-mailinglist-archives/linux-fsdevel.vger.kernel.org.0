Return-Path: <linux-fsdevel+bounces-79265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBbyOqEMp2kDcgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:30:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0931F3CEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 248073024BEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBC04DA55A;
	Tue,  3 Mar 2026 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th/TgfP5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C604DB548;
	Tue,  3 Mar 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555376; cv=none; b=VvP9W+sMog3LNLiyq+Vo8xklC6zPLmSv7mva8HPdca9Qj+qd0RbJ3dIwD33ppvT0ZxJ8AD+5X6pywvP3ORQGh7U1QvqprwyQIAfO0C0qsQDYXJz8dkFPAvUBzm/RNEAaKYv33RYmXrBnVwZOY+tbgm7MlPohDjhmYFjJW8D5pdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555376; c=relaxed/simple;
	bh=Jlf/CDGD5yIDkoTypuod0BzSNkr8OFY+HKUT/RBMY14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQRDsFSlijA1xHI8I5GdYeacK2T5IGtnt9UZy3F1AwZCWZYpxWf5v+BL3ublJDoFsXjBTddyPURVIEamrR13wk4RqLtrW7TBt/ylVHuHRtaczgaA8HOnsveWeCoCdhv4uCJfkrJCCnCuh8xgZ6wL8wqg7VD+w5esTz3eTO4vEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th/TgfP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527BCC19422;
	Tue,  3 Mar 2026 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555376;
	bh=Jlf/CDGD5yIDkoTypuod0BzSNkr8OFY+HKUT/RBMY14=;
	h=From:To:Cc:Subject:Date:From;
	b=th/TgfP5pwZHJdNABACCxsBVK+HNuEgHSkq++QR74Tu6wTFdRI5h6NTwJm8PjQyea
	 VZqtRFGiQlOJxDwuW4tLwBRccza1l7m2X3AycUxP+aW0AGnQ9ibZTtSCAVXCBDWBZO
	 NDBMkWcAnmSj+K8fHbCQ2/bD7VC5NRDcZiA2MscUX33iQO+9oA4R8O185+l4arImCR
	 6Ea0dzZ+Vie27+8YUrCxSE2G6OLsk+UB2bBkvM4HpA2v6cSE00OIzsYELQoJlUhSTJ
	 EaMwPWv/lPwE0LmrpnwJ3MZg+UWtVDBtygFv/xMdg58enSK1JtbYMsoksbgYhC4XBw
	 D8Ww3zNJz9KQw==
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-hardening@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	<netdev@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] iov: Bypass usercopy hardening for kernel iterators
Date: Tue,  3 Mar 2026 11:29:32 -0500
Message-ID: <20260303162932.22910-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C0931F3CEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79265-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Profiling NFSD under an iozone workload showed that hardened
usercopy checks consume roughly 1.3% of CPU in the TCP receive
path. The runtime check in check_object_size() validates that
copy buffers reside in expected slab regions, which is
meaningful when data crosses the user/kernel boundary but adds
no value when both source and destination are kernel addresses.

Split check_copy_size() so that copy_to_iter() can bypass the
runtime check_object_size() call for kernel-only iterators
(ITER_BVEC, ITER_KVEC). Existing callers of check_copy_size()
are unaffected; user-backed iterators still receive the full
usercopy validation.

This benefits all kernel consumers of copy_to_iter(), including
the TCP receive path used by the NFS client and server,
NVMe-TCP, and any other subsystem that uses ITER_BVEC or
ITER_KVEC receive buffers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/ucopysize.h | 10 +++++++++-
 include/linux/uio.h       |  9 +++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/ucopysize.h b/include/linux/ucopysize.h
index 41c2d9720466..b3eacb4869a8 100644
--- a/include/linux/ucopysize.h
+++ b/include/linux/ucopysize.h
@@ -42,7 +42,7 @@ static inline void copy_overflow(int size, unsigned long count)
 }
 
 static __always_inline __must_check bool
-check_copy_size(const void *addr, size_t bytes, bool is_source)
+check_copy_size_nosec(const void *addr, size_t bytes, bool is_source)
 {
 	int sz = __builtin_object_size(addr, 0);
 	if (unlikely(sz >= 0 && sz < bytes)) {
@@ -56,6 +56,14 @@ check_copy_size(const void *addr, size_t bytes, bool is_source)
 	}
 	if (WARN_ON_ONCE(bytes > INT_MAX))
 		return false;
+	return true;
+}
+
+static __always_inline __must_check bool
+check_copy_size(const void *addr, size_t bytes, bool is_source)
+{
+	if (!check_copy_size_nosec(addr, bytes, is_source))
+		return false;
 	check_object_size(addr, bytes, is_source);
 	return true;
 }
diff --git a/include/linux/uio.h b/include/linux/uio.h
index a9bc5b3067e3..f860529abfbe 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -216,8 +216,13 @@ size_t copy_page_to_iter_nofault(struct page *page, unsigned offset,
 static __always_inline __must_check
 size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (check_copy_size(addr, bytes, true))
-		return _copy_to_iter(addr, bytes, i);
+	if (user_backed_iter(i)) {
+		if (check_copy_size(addr, bytes, true))
+			return _copy_to_iter(addr, bytes, i);
+	} else {
+		if (check_copy_size_nosec(addr, bytes, true))
+			return _copy_to_iter(addr, bytes, i);
+	}
 	return 0;
 }
 
-- 
2.53.0


