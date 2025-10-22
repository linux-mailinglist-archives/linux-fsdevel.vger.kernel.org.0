Return-Path: <linux-fsdevel+bounces-65137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD1ABFD0EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4D0B50808B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1B72C11C3;
	Wed, 22 Oct 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEpB/PVF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95282C0282;
	Wed, 22 Oct 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149213; cv=none; b=L09T5bwoEkr4vLJK+PoHqnYwIVsbdP41sQlYX2MkBPsAerWbEkNG2SzMVg4cXBoYotAoDsGqJhkGQuyPMLTOR45BxCu+KgT1reff+S/5k4bTupxyy7+PbDWrhnIv6+KAZ4hZMh5b2eHsp+dyc83YRAT+OOPJW8jEjKz0EMmvQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149213; c=relaxed/simple;
	bh=QM8oyzyJ0QczVJ0uxGx22MIzfw44XMMyED0mCYHZDF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N76EtwJgMUXm0ob/JV2vp718F7+fhCJp8ObooQHKNL8KEKfkPq5UeVP3Ozv4flfKVhGSHetyl7nz6+QDhGEzD+UWl7we6/fEqDfQJInuFXJXjKclIjoRgYHqVwXDWOoL5w3xWh/lF2Pj/l/KU7KjShkuEebeNn9l0BSIxpcvTvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEpB/PVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B61AC4CEE7;
	Wed, 22 Oct 2025 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149213;
	bh=QM8oyzyJ0QczVJ0uxGx22MIzfw44XMMyED0mCYHZDF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gEpB/PVFOSaOpvp6ZR6yhvx1s5SZLhqFReaEmmbOrhMBrf8TM7A/NHAwomU1AdbHK
	 VzxZtjN4LxE7PlBFQ1hNGvXYbm+DnEcNERJd5Be26Zk9lYGYBXqsmjA56eHZh4gAy7
	 1OinKw/8JZpf1v750FCJ98PZn5hsIGMHQ/l1cjjQWsK2mcYA9GlwJskWBT/iGwVlMK
	 cxuIRiw67WelzJpOaEfzXhDc41/sJIjbDbSm20IyXWbyDMDrNIflhbwbllu+JcurWH
	 9mcRmZfKc0+AZoc8znBwgLDKaBj1SMQneuCBFXSPRSNYrrVhNIQiSeoIHzXthL7XBQ
	 tup10iDnrgvYw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:05:47 +0200
Subject: [PATCH v2 09/63] ns: add __ns_ref_read()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-9-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QM8oyzyJ0QczVJ0uxGx22MIzfw44XMMyED0mCYHZDF8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHjC6Pnba1Ph24mX+DdlzE1Ta7ctUHlw48+fKyJOu
 /jeJPpKdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEpJ3hr8AVC/ei+BpBu+Ni
 v2/Za4X2rdm/duk3TbmvZzmV645Y72P4KzLz/NW80qBZCqc/nDne7BLcnfrzk+c9Dc8FubyV8Z8
 1WAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Implement ns_ref_read() the same way as ns_ref_{get,put}().
No point in making that any more special or different from the other
helpers.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index f5b68b8abb54..32114d5698dc 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -143,7 +143,12 @@ static __always_inline __must_check bool __ns_ref_get(struct ns_common *ns)
 	return refcount_inc_not_zero(&ns->__ns_ref);
 }
 
-#define ns_ref_read(__ns) refcount_read(&to_ns_common((__ns))->__ns_ref)
+static __always_inline __must_check int __ns_ref_read(const struct ns_common *ns)
+{
+	return refcount_read(&ns->__ns_ref);
+}
+
+#define ns_ref_read(__ns) __ns_ref_read(to_ns_common((__ns)))
 #define ns_ref_inc(__ns) refcount_inc(&to_ns_common((__ns))->__ns_ref)
 #define ns_ref_get(__ns) __ns_ref_get(to_ns_common((__ns)))
 #define ns_ref_put(__ns) __ns_ref_put(to_ns_common((__ns)))

-- 
2.47.3


