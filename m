Return-Path: <linux-fsdevel+bounces-19575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A6F8C73B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 11:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E744284251
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 09:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA9514389A;
	Thu, 16 May 2024 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="lm26UlGB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5bgLvXi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F277143C6F;
	Thu, 16 May 2024 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851303; cv=none; b=DDqvDiSU/YZZVBhuxZvu20GFW7CPEVx40QJyQ3i9KgywhgsXkgT+nE9AV48xy1633tgYvjMzUJdnTCtL9SX5zGKEOtMhVXLfIM+1cOkv8zlBETfoMAIYZmHchCNDDFQ5tl6Gdob49si8hq3AUeblY+6Wpm3kAgI1RUq0MkhlAE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851303; c=relaxed/simple;
	bh=1H97K6DDCaTu5wDYD3cSAAS1gqyXZ1uuZ0c3//v/g1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JehMs0DYc8kelipPuJ6NRaWZEBLG+qxIiFyt/lC5EkZQc+A+Z11oGrfPqKNadFVfSp1PqE1iUOHmkPDDBs8wY2WU9qDaU/qf3JCRC+kyUhgzLmsk4C8mJahApeCO8kilvfUDn7+M+C+a8cViWl2BXFdK0OGuEgMdTO+nHQDEAdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=lm26UlGB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S5bgLvXi; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id AF4252005EF;
	Thu, 16 May 2024 05:21:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 16 May 2024 05:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1715851299; x=
	1715854899; bh=YH9uRR3GuhjkujujI5PhznoSSSyCvnA2D5Rmli2gZ7Q=; b=l
	m26UlGBhBiCx888VFeVOM8jT9aNAxyzXZPXIUO/EXzIcak0AEL4Ao4UTtM4YeKQ4
	BzT7attEDfga4PAJ4Oy15kdsKCXPgNMkkAkbkKJY7xhIw9x3/P55xamNgkRh8HPu
	Ad0D5hPdRsXzSayLcDAPMQQEOqJ+BkuXQncl4VNRIjWEMVoSZNqPTGS7QkRbuNwi
	cDhPRwRGVm63IzReLKAOqG3imG2kzMXgt1TReNdm4K6QN3MUG+vxAvVKneVv1jTu
	1ZzKJeelfeSp3psKfiSc1K2guqgFc+ziuIXtrRRM6DriPB7QyB7xbIVclO+x4tlP
	jbmohhCBuk6emLZy0X2AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=i76614979.fm3; t=
	1715851299; x=1715854899; bh=YH9uRR3GuhjkujujI5PhznoSSSyCvnA2D5R
	mli2gZ7Q=; b=S5bgLvXiwr8TAV15qprOcH4koPv7SPeHXu36AOyjHHLxnv2ppzZ
	WZIKwVa3RPUA2hT7LPVf/sOPyig+bJCudix5scNQyZRrSTnd6xszvqi4oI1R1hjb
	D13WkecJLif7pkUMzbZ2dfYguGFOSmvs+NJwn/gpabQSOgLBdPhw0fl/JCF3Qnee
	xote0eSdwlQpN7UAf81k1XOtv5ErXRS9bRz1JX5aY9qiqSL+yleuZIPJiKbcJTqC
	XAMZFgjnadXCgtKZ+dUeUUF8aMQysNQqvT9dij0lu/Fq/Q6a6W7/25Gm25/lrX3k
	Iqz4PQXLQWsy2ZdB7IcTrrbnKauNEqUMPng==
X-ME-Sender: <xms:I9BFZkGc7_yK7jvCoL_ebntmvFiXvwtx4fksxHZQVAQa8KlFRnFJyw>
    <xme:I9BFZtUJSqokIiySAM_9bMj1tYtmBtXji5SeZQ6jcQy8iVmeMso1815Kl0vXTgyOu
    RcLbg10rk6BD6iLx-k>
X-ME-Received: <xmr:I9BFZuLlF8Tzxd3qmB_uIevMKQxd_hYkLi_TUpN0KXu5fI6-kaCYrK36V4uCUQtbnFWmAnG9zHoNX5dhc0Taiv0fovJyTVYOhKl_XpAue8Gwbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgr
    thhhrghnucevrghlmhgvlhhsuceojhgtrghlmhgvlhhsseefgiigtddrnhgvtheqnecugg
    ftrfgrthhtvghrnheptdejhfelheejfeeutdekgeevueetkedtgfelkeejgfffhefgveet
    teffueegvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhgtrghlmhgvlhhsseefgiigtddrnhgvth
X-ME-Proxy: <xmx:I9BFZmFZ8SNcAY_AZaIvZuwNPjGuUQaE4nxedyWRmrlI3I8lgP4_Sg>
    <xmx:I9BFZqX4v-M2rzmIJwYSZFxt30D3C269724SYzsaAZFHhGOR8g7XTg>
    <xmx:I9BFZpO4I0G4XVqvRJwqPPvoBXOFy4Jwko9uLHdpx1MkmDGQJLjgXw>
    <xmx:I9BFZh06K-hKvAfraDg57OQAbs8WXCZStl0jgvdTj3ekHmQ0eGimxA>
    <xmx:I9BFZjWsUzCQQQ6S1L6lHCPF9qEzj685mXM0N_lX7jMI-bNRL-9c4jId>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 05:21:37 -0400 (EDT)
From: Jonathan Calmels <jcalmels@3xx0.net>
To: brauner@kernel.org,
	ebiederm@xmission.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: containers@lists.linux.dev,
	Jonathan Calmels <jcalmels@3xx0.net>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: [PATCH 3/3] capabilities: add cap userns sysctl mask
Date: Thu, 16 May 2024 02:22:05 -0700
Message-ID: <20240516092213.6799-4-jcalmels@3xx0.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240516092213.6799-1-jcalmels@3xx0.net>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a new system-wide userns capability mask designed to mask
off capabilities in user namespaces.

This mask is controlled through a sysctl and can be set early in the boot
process or on the kernel command line to exclude known capabilities from
ever being gained in namespaces. Once set, it can be further restricted to
exert dynamic policies on the system (e.g. ward off a potential exploit).

Changing this mask requires privileges over CAP_SYS_ADMIN and CAP_SETPCAP
in the initial user namespace.

Example:

    # sysctl -qw kernel.cap_userns_mask=0x1fffffdffff && \
      unshare -r grep Cap /proc/self/status
    CapInh: 0000000000000000
    CapPrm: 000001fffffdffff
    CapEff: 000001fffffdffff
    CapBnd: 000001fffffdffff
    CapAmb: 0000000000000000
    CapUNs: 000001fffffdffff

Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
---
 include/linux/user_namespace.h |  7 ++++
 kernel/sysctl.c                | 10 ++++++
 kernel/user_namespace.c        | 66 ++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6030a8235617..e3478bd54ee5 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_USER_NAMESPACE_H
 #define _LINUX_USER_NAMESPACE_H
 
+#include <linux/capability.h>
 #include <linux/kref.h>
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
@@ -14,6 +15,12 @@
 #define UID_GID_MAP_MAX_BASE_EXTENTS 5
 #define UID_GID_MAP_MAX_EXTENTS 340
 
+#ifdef CONFIG_SYSCTL
+extern kernel_cap_t cap_userns_mask;
+int proc_cap_userns_handler(struct ctl_table *table, int write,
+			    void *buffer, size_t *lenp, loff_t *ppos);
+#endif
+
 struct uid_gid_extent {
 	u32 first;
 	u32 lower_first;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 81cc974913bb..1546eebd6aea 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -62,6 +62,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/mount.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/user_namespace.h>
 #include <linux/pid.h>
 
 #include "../lib/kstrtox.h"
@@ -1846,6 +1847,15 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec,
 	},
+#ifdef CONFIG_USER_NS
+	{
+		.procname	= "cap_userns_mask",
+		.data		= &cap_userns_mask,
+		.maxlen		= sizeof(kernel_cap_t),
+		.mode		= 0644,
+		.proc_handler	= proc_cap_userns_handler,
+	},
+#endif
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 	{
 		.procname       = "unknown_nmi_panic",
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 53848e2b68cd..e0cf606e9140 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -26,6 +26,66 @@
 static struct kmem_cache *user_ns_cachep __ro_after_init;
 static DEFINE_MUTEX(userns_state_mutex);
 
+#ifdef CONFIG_SYSCTL
+static DEFINE_SPINLOCK(cap_userns_lock);
+kernel_cap_t cap_userns_mask = CAP_FULL_SET;
+
+int proc_cap_userns_handler(struct ctl_table *table, int write,
+			    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table t;
+	unsigned long mask_array[2];
+	kernel_cap_t new_mask, *mask;
+	int err;
+
+	if (write && (!capable(CAP_SETPCAP) ||
+		      !capable(CAP_SYS_ADMIN)))
+		return -EPERM;
+
+	/*
+	 * convert from the global kernel_cap_t to the ulong array to print to
+	 * userspace if this is a read.
+	 *
+	 * capabilities are exposed as one 64-bit value or two 32-bit values
+	 * depending on the architecture
+	 */
+	mask = table->data;
+	spin_lock(&cap_userns_lock);
+	mask_array[0] = (unsigned long) mask->val;
+#if BITS_PER_LONG != 64
+	mask_array[1] = mask->val >> BITS_PER_LONG;
+#endif
+	spin_unlock(&cap_userns_lock);
+
+	t = *table;
+	t.data = &mask_array;
+
+	/*
+	 * actually read or write and array of ulongs from userspace.  Remember
+	 * these are least significant bits first
+	 */
+	err = proc_doulongvec_minmax(&t, write, buffer, lenp, ppos);
+	if (err < 0)
+		return err;
+
+	new_mask.val = mask_array[0];
+#if BITS_PER_LONG != 64
+	new_mask.val += (u64)mask_array[1] << BITS_PER_LONG;
+#endif
+
+	/*
+	 * Drop everything not in the new_mask (but don't add things)
+	 */
+	if (write) {
+		spin_lock(&cap_userns_lock);
+		*mask = cap_intersect(*mask, new_mask);
+		spin_unlock(&cap_userns_lock);
+	}
+
+	return 0;
+}
+#endif
+
 static bool new_idmap_permitted(const struct file *file,
 				struct user_namespace *ns, int cap_setid,
 				struct uid_gid_map *map);
@@ -46,6 +106,12 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
 	/* Limit userns capabilities to our parent's bounding set. */
 	if (iscredsecure(cred, SECURE_USERNS_STRICT_CAPS))
 		cred->cap_userns = cap_intersect(cred->cap_userns, cred->cap_bset);
+#ifdef CONFIG_SYSCTL
+	/* Mask off userns capabilities that are not permitted by the system-wide mask. */
+	spin_lock(&cap_userns_lock);
+	cred->cap_userns = cap_intersect(cred->cap_userns, cap_userns_mask);
+	spin_unlock(&cap_userns_lock);
+#endif
 
 	/* Start with the capabilities defined in the userns set. */
 	cred->cap_bset = cred->cap_userns;
-- 
2.45.0


