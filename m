Return-Path: <linux-fsdevel+bounces-62104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E6DB84026
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12E01C817B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795D2304BBC;
	Thu, 18 Sep 2025 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uex5kZbW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A92F362B;
	Thu, 18 Sep 2025 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190368; cv=none; b=X5SZ7hSa2rcCYmtBn5Bm2x6sbpX1MNycPaJrjDJjBUy2jkE46TezzcQIDprxrelIIdAAHlqWFKPpDKJI9mNTDX0lTC+PRHz4ihWLbCxPX29jYEVxp/1dPDnCAtXk+XkAwEqrOozQrwsWiOMgOT19Qh81w5o/qEZ3q7AgMdopBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190368; c=relaxed/simple;
	bh=goaLC7wGjxRD/+pG5XJskmBTPzYWvzmUtF2h1nEQg/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rywbjuiPHr9DY1xTkrfMh46/eWQkpxjiwN4ziFMjixm8CqnxGmK3j3C1yT9TQIIQcGX2hYe4byha6M1lbKnVgfBffhBAloy6sTQ5ghbOcXecg3fjaJl1soChYV/YIqNrKjtM0mUxN7xkadjLANSqjj/QNLphbh114s8vP7eV6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uex5kZbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41E4C4CEF0;
	Thu, 18 Sep 2025 10:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190367;
	bh=goaLC7wGjxRD/+pG5XJskmBTPzYWvzmUtF2h1nEQg/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Uex5kZbWnvRfgUTtJXwl+lN1mO9VJI5+XiaOn06l0Bm5NL5Wci9PKdmKokH4gKPrS
	 yN342jr/Q0xPwGAE1QcwiZe0zQTKoXrmMDW4Q/VMBCn7Kc5P1Nt1Ba1A9FoffiXJDj
	 Ofw1lyySrtNr7v9buMFQkZjxExuQaNvMU+4W9gGonpj4hmeGZ69w58+XIh9DjJS/Dx
	 fZFyzqRj2YKO2nKOJrM2fjOLCncQiP4uF9kcJiJUFnkrFgaq908EPWk+NkqRWit7qv
	 xa4bkjZ0rxNjHOPCsDkoGAJUA/cq4diuOMXVzv5s4MVaSnBGOfy4OPzTX7qPVv2i/M
	 Jj0vYYM8N7ZvA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:56 +0200
Subject: [PATCH 11/14] uts: port to ns_ref_*() helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-11-1b0a98ee041e@kernel.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
In-Reply-To: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=brauner@kernel.org;
 h=from:subject:message-id; bh=goaLC7wGjxRD/+pG5XJskmBTPzYWvzmUtF2h1nEQg/k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvWsNiUs+dat/WWfFtqburw0bZT9uTI84vETVYNnt
 sc108tTO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSEMfwz9zMXsh8kn+mTfRy
 p0/fHj3YIHvMulbd7ui9NpHbO16GmDP890o1XMO+aVl7M6vQnUlffTddWhOx+3lB5N54Xj9vlex
 mRgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Stop accessing ns.count directly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/uts_namespace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/uts_namespace.h b/include/linux/uts_namespace.h
index c2b619bb4e57..23b4f0e1b338 100644
--- a/include/linux/uts_namespace.h
+++ b/include/linux/uts_namespace.h
@@ -25,7 +25,7 @@ static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
 
 static inline void get_uts_ns(struct uts_namespace *ns)
 {
-	refcount_inc(&ns->ns.count);
+	ns_ref_inc(ns);
 }
 
 extern struct uts_namespace *copy_utsname(unsigned long flags,
@@ -34,7 +34,7 @@ extern void free_uts_ns(struct uts_namespace *ns);
 
 static inline void put_uts_ns(struct uts_namespace *ns)
 {
-	if (refcount_dec_and_test(&ns->ns.count))
+	if (ns_ref_put(ns))
 		free_uts_ns(ns);
 }
 

-- 
2.47.3


