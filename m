Return-Path: <linux-fsdevel+bounces-66222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 759ABC1A31B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F16E50302D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE834D4F1;
	Wed, 29 Oct 2025 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6Z74pOa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044D933C523;
	Wed, 29 Oct 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740484; cv=none; b=O8rU4Xjz9MjN5M6qo4ncCOpwuq+QVRz91Pwt4z7HrEWg90QI1kANRYeFWPilNVBYa55A5+Gh4wRqNzUncajryBMilMPXP1IPSRn47ZJCdFrV8r7Ic/yXnSOzuONpXnvOKKfF4I3R9Sga/f9HLpF8xhkR6F97ZQy063IwmJqwjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740484; c=relaxed/simple;
	bh=QM8oyzyJ0QczVJ0uxGx22MIzfw44XMMyED0mCYHZDF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4JX2CrRzrgdSvJiHAjI61J4tgZgtSOW9fZQLBe8zg22I6WFVXaW28zelQ8uZTHTuTzTYIEdmyHrKBi8MTlXBuUtB4wp+kepUHi4cHCDDsINU1eq4bz1FHowgO0j7ee7nvYF3Y0zD0p1xVgE/LRhcXhR0bFlsP8b5GUmuAPnh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6Z74pOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26F9C4CEFD;
	Wed, 29 Oct 2025 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740483;
	bh=QM8oyzyJ0QczVJ0uxGx22MIzfw44XMMyED0mCYHZDF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t6Z74pOabQdKC5qU74fX7MuLZ9sUL/A45SgFEKxD1nRdhmPkTsz84mwb8Z2NO/co6
	 iY+rGuua1cg7qLVrjJodRJiQkOXe2hWo6n0IBPL8NmbD4R5SmL0HvRRhbq826bjxqG
	 VHFenwX8I+d3/r8neycOKTvcSYfA/TFZMOvhzBPYqaqJschux79OGXboLAYJscuf9F
	 ywjH2kBD6ZEKsc+aFrzfDaEuBgVBoT7iKOOSPdhBQ9S2MTfxWLsUxXGGLTDUrqqn59
	 606kojI9LTpwyq4oSe+DPJk73KzBIOM76Fw4rs+Ojk74eeY3+3Z6SF4MAFD7nGORNk
	 TtrgvfkY+hdkg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:22 +0100
Subject: [PATCH v4 09/72] ns: add __ns_ref_read()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-9-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfUsa51w0eQ8a03a39ysrIP/n++Rmcb79LXHV7duh
 bvZNs/FO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayzZyR4cEZDobzexhcd9hv
 PvRy3TyX3sN/Dl6TeBjOeF9u0v3NZ+YxMryI/B4pvXlxx/uVBz+1G2+N3vk+4oOo96tJC7TsWMR
 Na/gB
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


