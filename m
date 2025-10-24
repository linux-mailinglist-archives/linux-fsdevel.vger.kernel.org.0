Return-Path: <linux-fsdevel+bounces-65449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A775AC05B9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 12:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1682A3B16B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51C3317706;
	Fri, 24 Oct 2025 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDOkSc8Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2D3128A1;
	Fri, 24 Oct 2025 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303229; cv=none; b=fJsJ2ctB5lEDZexrsc7mAsvbbpd1bfp54E+LoWTWGfM8+pME8Ixhw/gr6OckzZbhrsgrLVIJh9PS62CN2581kT5ZnflCkm+j1wdO6Qfeda1DqgK/KRlUyI6J/ni9w8BWHugUzA+QfAOPmvBVXG5I5VKJz6fL0mxQrZugWuMfki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303229; c=relaxed/simple;
	bh=QM8oyzyJ0QczVJ0uxGx22MIzfw44XMMyED0mCYHZDF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGEyXW8P6U+im6AssNYXCtD7qH+9lqh7XFeG/SSmP9kaoAysQLroCSUEPvZ3rKhjy+gVjteRt567zDozy4JHHWj9wyQSmS8+j2O4lYi+ApYTfRs22jlbb2SbSipSkD0qa4hxJXzAqod93AoLYqdQjCy3z5JiHIuB3FdFkjHZbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDOkSc8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCE2C4CEF1;
	Fri, 24 Oct 2025 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303226;
	bh=QM8oyzyJ0QczVJ0uxGx22MIzfw44XMMyED0mCYHZDF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IDOkSc8Z209ZjnA3ZzOfATDSVohe/B5WDpBEcAQXBEWWBiJNB0GB8ek38w60ZLQWA
	 C2zwPQFa6CjCrNFuv3On8PIkx5gp5QlhjH9NZwYyn9ON1lJtpFRRYG1kUQwwaYy2iS
	 o7xwCmFGtDNGYwe5Kd8ZY9q9cDJYLRQL6C9hINiwwbNbv03SsLeVm1gBiBGk+/yCXh
	 1mrsydfapfGMIT9UWe/vC//bGMptRYN5IBcoAB5cQS4on9KRMG/PLV9yZIV8gsNV0K
	 Cl0556lter5/J+DugI9VhzRqG5HVeC8Typ8byDRxZ/Rtr3+rlpYGupVQm0U5jCrCHR
	 sRtJ4bVYR3tOw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:52:38 +0200
Subject: [PATCH v3 09/70] ns: add __ns_ref_read()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-9-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmrJn7rpE1NWkeD+wul/XhdzPdctOmZx3nZPZf7Oe
 ZNm7ttQ2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRzKWMDP/bdtlHfzBsVy+5
 F6O9uFFywtrMyCPfbup/fulhWNgnacvI8NVmZcp2LZV28xsBuXnt7Rs/zH9WVPdNupvp5CKRq41
 8zAA=
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


