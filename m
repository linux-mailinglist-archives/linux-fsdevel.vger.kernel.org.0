Return-Path: <linux-fsdevel+bounces-76736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN4vEkMwimm3IAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:06:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F374113F1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C798B302BDE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699743F076F;
	Mon,  9 Feb 2026 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wzoT48Q7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4A41B34E
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663977; cv=none; b=SLeCQLKtFb3WX+oqpI7hMslvqtwrNsx+hjR0eUjMOvQapjaWRXYlGUlyri/1KYPIehaJhQzk4zXr6jd8KD0oh0nu8kZwFTnW6qE4UVeIl0FzGqgLN9bZWkoQ7syHj2HbyIBa6L5KM88Jc9NGCLhJmsD8NYXKg56otqHp9UJYpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663977; c=relaxed/simple;
	bh=NqG7bVpGByzbqLWbObaiJ3BzJR9rD0Wj+d/HvIRik1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eM5/tkhAqo38HxTQaxE6u6HMx8tmD2O+8kPAVCjDaFsiE4DojOKM/oBa3KrPOO0QDu0fEvAXx1QngatbdbtQvY4AYal3oNv3GzTthmBIZXPlw1y90yLweqKuUHv44TFAjq2KGnZC7h4G/qS3bDZvET1OCRd6xewjVc8RQ744C8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wzoT48Q7; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-4042a16a369so11792724fac.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 11:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770663976; x=1771268776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdr4V4HK4nTpFzygAIFcY2is0P9+eeyi+VB04pSk0Ms=;
        b=wzoT48Q7WXvmfnEojSogq6/DuFg9uMxvgnaWs4LEnaf+OJoin5NjuTJSFHnjoX1EXM
         PjQjrNEw7TDA0cEW6Nz7lTtgK+6Cn1/6Aa4F2ncfCjiqGtAo2ZD27GXmIRuSw5nEIa2p
         1fzyEwEbcMI2OKVC10nAfFfbV8O81bPR0XyoATrDhXTdGIs0vrxFpykRZBtZ8yJhvaII
         Gw1K2Ovuf30SAzNmqTbOFAR4X6aovVIbPHGxOfZBRHqHxMcMhpiVn5td+rgh9OBZYzeF
         gW6dQ73xK3r0LbGHyR+PKInVC9/VrFWQtaQBMtOeIxxaOSEkQ2ytR0YTYyPwlVklhamp
         0HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770663976; x=1771268776;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vdr4V4HK4nTpFzygAIFcY2is0P9+eeyi+VB04pSk0Ms=;
        b=icBb1LXsYlICEZTmnKSMNtxifDhgWvF7zy2nE8vbBiammgcfnKonZpI8b+yG43YewZ
         /hcQkFjHoeb6cSWYzx/5XVgpRZO+4HoIbh6jCqg28L4bYzazPsAhAaKeovq4HDBgGmUZ
         T/nndbxV9HImkGWvmJpjVWP05E8/4pGA1aQ2Ym0x8cNvLjiIHyahi6+nDQaNKHJN/77r
         +Okg3NoOa+W+5O9Tn9xg1RleEJdOHkMeENrkwuxTYmQl+IXmxfsKQqkvRkwcdBqOaUh1
         O4DmN0eSpVSpYCS4M7/Wpa2EEoDkNwDne2YfW2WP61a65m8Cv1JgfLBwE6UCjCzyhEM+
         k8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXgxtKK80rrHJXdtDV0GOX/fHwpQAVrJ8v8SiG14PgsjRhRbGr0PmvjbStKcHJMr8RfrBmyqRZYAD85Ctgi@vger.kernel.org
X-Gm-Message-State: AOJu0YwdES1KzxPXpJR4TdZrAuS6B/yEEs1Lq2/SMEFUVv7ljmDw0k0b
	mF7hFph2re3NtR7Sf8P7+1m7vlCW0nM93iB/OqP7Wy7YC6gsYpar4VYxJ+rRKLty+d2vclcGBW4
	cHKFDWg==
X-Received: from jajt22.prod.google.com ([2002:a05:6638:2056:b0:5ce:8aec:982c])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a4a:e54e:0:b0:66d:f051:e91f
 with SMTP id 006d021491bc7-66df0613260mr3273923eaf.23.1770663975878; Mon, 09
 Feb 2026 11:06:15 -0800 (PST)
Date: Mon,  9 Feb 2026 19:06:02 +0000
In-Reply-To: <20260209190605.1564597-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209190605.1564597-1-avagin@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209190605.1564597-2-avagin@google.com>
Subject: [PATCH 1/4] binfmt_elf_fdpic: fix AUXV size calculation for
 ELF_HWCAP3 and ELF_HWCAP4
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, 
	Andrei Vagin <avagin@google.com>, Mark Brown <broonie@kernel.org>, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-76736-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com,google.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F374113F1B
X-Rspamd-Action: no action

Commit 4e6e8c2b757f ("binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4") added
support for AT_HWCAP3 and AT_HWCAP4, but it missed updating the AUX
vector size calculation in create_elf_fdpic_tables() and
AT_VECTOR_SIZE_BASE in include/linux/auxvec.h.

Similar to the fix for AT_HWCAP2 in commit c6a09e342f8e ("binfmt_elf_fdpic:
fix AUXV size calculation when ELF_HWCAP2 is defined"), this omission
leads to a mismatch between the reserved space and the actual number of
AUX entries, eventually triggering a kernel BUG_ON(csp !=3D sp).

Fix this by incrementing nitems when ELF_HWCAP3 or ELF_HWCAP4 are
defined and updating AT_VECTOR_SIZE_BASE.

Cc: Mark Brown <broonie@kernel.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Fixes: 4e6e8c2b757f ("binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4")
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/binfmt_elf_fdpic.c  | 6 ++++++
 include/linux/auxvec.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 48fd2de3bca0..a3d4e6973b29 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -595,6 +595,12 @@ static int create_elf_fdpic_tables(struct linux_binprm=
 *bprm,
 #ifdef ELF_HWCAP2
 	nitems++;
 #endif
+#ifdef ELF_HWCAP3
+	nitems++;
+#endif
+#ifdef ELF_HWCAP4
+	nitems++;
+#endif
=20
 	csp =3D sp;
 	sp -=3D nitems * 2 * sizeof(unsigned long);
diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index 407f7005e6d6..8bcb9b726262 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -4,6 +4,6 @@
=20
 #include <uapi/linux/auxvec.h>
=20
-#define AT_VECTOR_SIZE_BASE 22 /* NEW_AUX_ENT entries in auxiliary table *=
/
+#define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table *=
/
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF=
} */
 #endif /* _LINUX_AUXVEC_H */
--=20
2.53.0.239.g8d8fc8a987-goog


