Return-Path: <linux-fsdevel+bounces-21292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853929015A8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 12:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772F11C20E0E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 10:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F563DB89;
	Sun,  9 Jun 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="gsfwPULs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQOz4ItZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow3-smtp.messagingengine.com (flow3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DFE24B5B;
	Sun,  9 Jun 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929626; cv=none; b=MlH8pasWbdjNKoMEAH0ByMjrYkFd1ywp0dhKoKwBZuQ+RVAgRAt2kp9kKfU8kcqQPqMFvJknuRfHFCdLONFf6hUM+55Wn/LooWVqUmukpc94WwLrDT3QxWvrplV1XY5Ne7DV/KN0rhWZACWSEh1Fv4vIW//j1/KQ3erTjbG12Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929626; c=relaxed/simple;
	bh=TRflIsPbASjR72yTWpx34CeYRaOCTbvPLNUnQ9bjQ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyHRtGU0UTWsa3c3klDSM7osXZp0bK5gpF8w9zmjdCDrC8VlDAtkCjbFejhVlyGV8gmJ08ujvoVmoGc2x4Xm6Fp+tUzYe90KfVqJkIf0fbWSVqIYf5gzDBRzGcE1vl8rWLCF5Mp96OqQz2rC7o6YTGWovaAE/B5P9ddr+ZP8zuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=gsfwPULs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UQOz4ItZ; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id C56CA2001CA;
	Sun,  9 Jun 2024 06:40:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 09 Jun 2024 06:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717929623;
	 x=1717933223; bh=givYjoPOL2k44qEG2AAhLIKWw+SaQbnMN2v1JiAaofI=; b=
	gsfwPULsB5vGdh2divKYeX2pT9m7EhL7B8rHXxOxGrnjOluHppy8OC6V/mJFZ6qG
	RGZcSmXNOCxb86qNZyXSSrkCYSSNJ9fnL2PcxZexz4wNzkoDLbnKrmufOi8NZbxh
	Xa98Juv3S2ziLBs3ZYQD2XnvkNKcsZhPrQUJbcXDnTANkMHzxI/6MfevpAQntzGf
	Egvm14viEkR/hpYGwq/KECjvzN29akriG+vYyD0Br1E+t63mN4IVRmEv1tM2WvvO
	P7jQi1XAUOdoJL54p8/6s6eCb8Ob+1d1gFaOITzeWyhTtj8EB1Ed5dUJgUyZHsh7
	z7FP+gbbFde7LylQsszfzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717929623; x=
	1717933223; bh=givYjoPOL2k44qEG2AAhLIKWw+SaQbnMN2v1JiAaofI=; b=U
	QOz4ItZeUl4PBUxODr3Q1h/fZXwI+Q1LDY2gPrf9FL0OOyk0CzxxbTIYafM5jirH
	3aqh0gd+G3OxbxmS5+pVaTFKGlbuY3eDMUfWnIu6I5w2hY24b2PTQOiZuVmNhkuK
	buF6oUecCbOTJvDq1E2f/kWHwXJTxc99KNz/GzlZ1n8jggHlgeJF7bmb5Cc4vtxh
	4vzpRpoH9t5M6rATh/++1ojrpJscOK2seRo2HShpcDLGqIpAOx/b+emrqla23Ope
	yPTI0OchbCaPiW9X1EfFPq2auSr8tfeQ8q2teol3k5kFk0wM016PJ/Yc6FbScqbY
	+ikf/xa1m4gqMjtItzmDw==
X-ME-Sender: <xms:l4ZlZpAnNuuxKPDr2Cd6FBTRHnbQHjA9iJqJ4vtInMEttqloUvxL3w>
    <xme:l4ZlZnhUUG5XLMuxwvF80Ztx7mxdiLYJkN9_fky8qYyIzQrHsQIGX186FBjOqQ6no
    AUWoGLH52kM3Rf3MZc>
X-ME-Received: <xmr:l4ZlZkkfGAqHkbW_x8-j2v_acbqpImowU9kXZ95ojAtc5RRkNQjTGleBF0HboqHBacD1A9zHgRg8_pAIMZjUemRvghpdz9qZz344rHcQr0Y1pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtjedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhn
    rghthhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeeiueeukeeitddvheeiveeiiedvhfeljeeiteeggedtteeiueet
    iefhudfgvddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:l4ZlZjxUkGLqs4oogIXztRVN01SaUztAQoyf4JRjSNo3W1Ff2FE5Tw>
    <xmx:l4ZlZuSJtY7q7t2kw7m88WXzlCDmeh5426CQ8jJ2JXo_CLz32Ee2BA>
    <xmx:l4ZlZmYqRTSIK4t09w7Ut9EkpHVDxBdVpRJrKxp9ntVw67oszXyFTA>
    <xmx:l4ZlZvRCMGICE2VMFlgubWMv7nGxzwWG6vWPlCu8SgaPTi-k1iZ6lQ>
    <xmx:l4ZlZsCGVIS4MEQvAhrZIJNWsOX2P9j682pJAC79bR95XH88HzCOxkbV>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Jun 2024 06:40:19 -0400 (EDT)
From: Jonathan Calmels <jcalmels@3xx0.net>
To: brauner@kernel.org,	ebiederm@xmission.com,
	Jonathan Corbet <corbet@lwn.net>,	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,	"Serge E. Hallyn" <serge@hallyn.com>,
	KP Singh <kpsingh@kernel.org>,	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,	Joel Granados <j.granados@samsung.com>,
	John Johansen <john.johansen@canonical.com>,
	David Howells <dhowells@redhat.com>,	Jarkko Sakkinen <jarkko@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>
Cc: containers@lists.linux.dev,
	Jonathan Calmels <jcalmels@3xx0.net>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/4] capabilities: Add securebit to restrict userns caps
Date: Sun,  9 Jun 2024 03:43:35 -0700
Message-ID: <20240609104355.442002-3-jcalmels@3xx0.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240609104355.442002-1-jcalmels@3xx0.net>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds a new capability security bit designed to constrain a
task’s userns capability set to its bounding set. The reason for this is
twofold:

- This serves as a quick and easy way to lock down a set of capabilities
  for a task, thus ensuring that any namespace it creates will never be
  more privileged than itself is.
- This helps userspace transition to more secure defaults by not requiring
  specific logic for the userns capability set, or libcap support.

Example:

    # capsh --secbits=$((1 << 8)) --drop=cap_sys_rawio -- \
            -c 'unshare -r grep Cap /proc/self/status'
    CapInh: 0000000000000000
    CapPrm: 000001fffffdffff
    CapEff: 000001fffffdffff
    CapBnd: 000001fffffdffff
    CapAmb: 0000000000000000
    CapUNs: 000001fffffdffff

Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
---
 include/linux/securebits.h      |  1 +
 include/uapi/linux/securebits.h | 11 ++++++++++-
 kernel/user_namespace.c         |  5 +++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/securebits.h b/include/linux/securebits.h
index 656528673983..5f9d85cd69c3 100644
--- a/include/linux/securebits.h
+++ b/include/linux/securebits.h
@@ -5,4 +5,5 @@
 #include <uapi/linux/securebits.h>
 
 #define issecure(X)		(issecure_mask(X) & current_cred_xxx(securebits))
+#define iscredsecure(cred, X)	(issecure_mask(X) & cred->securebits)
 #endif /* !_LINUX_SECUREBITS_H */
diff --git a/include/uapi/linux/securebits.h b/include/uapi/linux/securebits.h
index d6d98877ff1a..2da3f4be4531 100644
--- a/include/uapi/linux/securebits.h
+++ b/include/uapi/linux/securebits.h
@@ -52,10 +52,19 @@
 #define SECBIT_NO_CAP_AMBIENT_RAISE_LOCKED \
 			(issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE_LOCKED))
 
+/* When set, user namespace capabilities are restricted to their parent's bounding set. */
+#define SECURE_USERNS_STRICT_CAPS			8
+#define SECURE_USERNS_STRICT_CAPS_LOCKED		9  /* make bit-8 immutable */
+
+#define SECBIT_USERNS_STRICT_CAPS (issecure_mask(SECURE_USERNS_STRICT_CAPS))
+#define SECBIT_USERNS_STRICT_CAPS_LOCKED \
+			(issecure_mask(SECURE_USERNS_STRICT_CAPS_LOCKED))
+
 #define SECURE_ALL_BITS		(issecure_mask(SECURE_NOROOT) | \
 				 issecure_mask(SECURE_NO_SETUID_FIXUP) | \
 				 issecure_mask(SECURE_KEEP_CAPS) | \
-				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE))
+				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE) | \
+				 issecure_mask(SECURE_USERNS_STRICT_CAPS))
 #define SECURE_ALL_LOCKS	(SECURE_ALL_BITS << 1)
 
 #endif /* _UAPI_LINUX_SECUREBITS_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 7e624607330b..53848e2b68cd 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -10,6 +10,7 @@
 #include <linux/cred.h>
 #include <linux/securebits.h>
 #include <linux/security.h>
+#include <linux/capability.h>
 #include <linux/keyctl.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
@@ -42,6 +43,10 @@ static void dec_user_namespaces(struct ucounts *ucounts)
 
 static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
 {
+	/* Limit userns capabilities to our parent's bounding set. */
+	if (iscredsecure(cred, SECURE_USERNS_STRICT_CAPS))
+		cred->cap_userns = cap_intersect(cred->cap_userns, cred->cap_bset);
+
 	/* Start with the capabilities defined in the userns set. */
 	cred->cap_bset = cred->cap_userns;
 	cred->cap_permitted = cred->cap_userns;
-- 
2.45.2


