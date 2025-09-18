Return-Path: <linux-fsdevel+bounces-62100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90577B83FFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3910F7AF96E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2602286427;
	Thu, 18 Sep 2025 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcK18o2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE172F39CF;
	Thu, 18 Sep 2025 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190348; cv=none; b=KjuBSqJLUG3TaKgMIX1XhL/+g2aDon5RgoHls/ZMt/D8tXyYcWWm/d46zbWA0PALc9TpXYIfmFdsBqBxkoi/ufxesZuj/9rGaxkjuzdQR6iSj6sxg31Z+fEr6VuuRaqXgTVS4/qePtSK7VVNmGLfSvmAD26WK9LR49MEy4HVcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190348; c=relaxed/simple;
	bh=5NGIqPGYw+T/9FWphbn7aLdjuEXBOiEmvs9M0qqiQu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPxzPhCt0kP2MHphdEXix96BRJ9CSKakiPAr/s6ebTqEuKfepCOkHRttiIaZrHdufMbMkVawHHgJEWIv64WnmYdbO7IaoUsiho6Ds+jMRfqtpmSJ+ofa4J5Xb0CmhWmFjKY9dgh0fRdcBmSF3xS+O30ejK6uhHvXX6r5/wKy/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcK18o2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67ACC4CEF1;
	Thu, 18 Sep 2025 10:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190348;
	bh=5NGIqPGYw+T/9FWphbn7aLdjuEXBOiEmvs9M0qqiQu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NcK18o2Fu7rBhYM8IDKQIrJ491P91WuvxXo5Js10Zviv+V155UHN4af2zTORodQDE
	 tdzXM7WhpuUNxJcQYoxfqSbBajoNbAPaTP+nw7cbhFEkoBqPgM76bmpHLx870InEMs
	 1ip3OPX7uksd1hLIWjuZqjqGOcPXW86IvB6KCpxwZRS6ULXdmhbiNYfFn0tmwlvn6L
	 pavHFZuzqmauPbB9VsZGo2Zp0DBdItmpcnNXCR/neQQyGgYTs+a36ArYT/8qeAoJKo
	 nTfO7sUlpFHOkzNhjLotx9TkrukO7sR23nx3utGDrJMjlLKNhgJ1KG12XqngCNu838
	 Fr+KOLO2uPO4Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:52 +0200
Subject: [PATCH 07/14] user: port to ns_ref_*() helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-7-1b0a98ee041e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5NGIqPGYw+T/9FWphbn7aLdjuEXBOiEmvs9M0qqiQu4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvXsMtvhiapbDj0Jf11/kkuI24B1j8yGDXN0BQ+Ib
 g/Ir3S+3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR+IuMDA+v82hPCzjuMzPx
 LNMD5bDH0/cKu2wwn1p2cTe/6lbHRymMDCcXm1sJnlng6T658O+t3a8lL3Kc1jdMnphlNv30+qs
 3uTkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Stop accessing ns.count directly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/user_namespace.h | 4 ++--
 kernel/user_namespace.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index a09056ad090e..9a9aebbf96b9 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -176,7 +176,7 @@ static inline struct user_namespace *to_user_ns(struct ns_common *ns)
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
 {
 	if (ns)
-		refcount_inc(&ns->ns.count);
+		ns_ref_inc(ns);
 	return ns;
 }
 
@@ -186,7 +186,7 @@ extern void __put_user_ns(struct user_namespace *ns);
 
 static inline void put_user_ns(struct user_namespace *ns)
 {
-	if (ns && refcount_dec_and_test(&ns->ns.count))
+	if (ns && ns_ref_put(ns))
 		__put_user_ns(ns);
 }
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 32406bcab526..f9df45c46235 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -225,7 +225,7 @@ static void free_user_ns(struct work_struct *work)
 		kfree_rcu(ns, ns.ns_rcu);
 		dec_user_namespaces(ucounts);
 		ns = parent;
-	} while (refcount_dec_and_test(&parent->ns.count));
+	} while (ns_ref_put(parent));
 }
 
 void __put_user_ns(struct user_namespace *ns)

-- 
2.47.3


