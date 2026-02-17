Return-Path: <linux-fsdevel+bounces-77380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHO9NACtlGl7GQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:01:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB78514ED68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BC993015DB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184AB36EA9A;
	Tue, 17 Feb 2026 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLkPW5K1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E378928000B
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351275; cv=none; b=cs+jQAanhWa4BvgAW9p1ei6gXfJmDpf+RHUjeQAVX9yIpsuHdPtUQqXVDpOQFqv1SHyGPdhAmLyBnjXQoCheUyWj8xaUjnLHZctG/iuyacbvbFAhe7d1C/M57/jyR2Yh6kUSZrpdTz8CH51Ym4Jprs0vzfYysj6zHKLXUUiiLBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351275; c=relaxed/simple;
	bh=zFws/lBJDBflGBbsfpNrklciHMFXvn4h47ireyoBTMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ca+dM4D+jbOs/KbM/7ST2quY8hQsstAVWB1GGk0yw0vO5lQbIGQNoL5/ukZZPJzSLjiCA4DCGnm/Rsmcn3pqsbNjxup/9T0bPMRbdtnvNASs2xamGXYNYuR0MDFIh7XNLqyGn9nqktLU+5cWM4I4Fps0pR95yhdx2GJZoZbR3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLkPW5K1; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-40ee3b0ca58so38601432fac.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 10:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771351273; x=1771956073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWILvLkFP9VgHvdYSVEMstLcXKjVhz4il8XVeiAhgTI=;
        b=iLkPW5K1gzfkDTbJOg3LX8aR1U9jZEQZKGboeMuSlQh5dMFPaa5d7dCnhNkuX7OOxu
         RHpflpgF2Quz9OciM39qu8WIP13mPll2ByYdfqs79L6z/zKp47nxusBf7WvM9wuGfhLV
         Zv/s9wMETQzpYxxTi0VLq5IJyZx3pG4PZ2DzGxxPOo7s92mKTgp/jdC4oFWFlXW0422e
         vzaAHuA8bNP8okpwY95DQFdC16map2SVRoIMD+P4V/iSiuMFCOVPireKLWAdYMoRQ/3T
         lPCWhQyEItys8/gDX29Qitk3EJS4z83suSIaAI5XB/Gnutb1JRBLDDiaU8tGpdHISgbw
         CARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771351273; x=1771956073;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BWILvLkFP9VgHvdYSVEMstLcXKjVhz4il8XVeiAhgTI=;
        b=UM4/P/jINdnh9LkJ64MvQo5C9HYrPQmwiXkRQCtOkIeAuHk8Ykp8zHJo0CJvByGfed
         RwJfXZ/zUiZxN8uUgcbFvzvm6+LJdsRz+l5S7hLcR055JpzEsdCd9ijBLIu8QTvJ+irt
         9M6MqEE7wyrqI3NJF4uvUTLux66QMfmcUjz+GjfddCmQ6qM2JO2JqHItFcBxG0cLKTRs
         QAaUBE1aEe27huAA1BcZoK/F0IVOavgQTmI4eoXC83LS7MUf5CVGuy8GsS9NDCOHFQir
         dgpbTiDBxnjKcgspoDednq8FOOBfjeum0LIWtdCK9/NaYmQ/3DG5EYPcDf8T9ONpkYeA
         bkaA==
X-Forwarded-Encrypted: i=1; AJvYcCXSGsyEcCKjYFAImw2QCG5Oxwbr2xWhjj6tfEEhQLLa4VfQ+u0pCmhiQRoISwjiDBKx+Igys+ZCVG/ZT04b@vger.kernel.org
X-Gm-Message-State: AOJu0YwVh83kJr5igoDvbEXziWuZ+YlXg5n+lvD0m6MyQHdJtTd1zawF
	VOEEnJo5EEaOpfXYKE3ZMOhtYCFlL3Ho7W8OhIqYBWw/Wn5Kca6fpyuAlTdLeIhf3z8vlcCTVFO
	o9M71TQ==
X-Received: from jabko7.prod.google.com ([2002:a05:6638:8f07:b0:5ca:4c19:c2b7])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:458d:b0:663:364:674f
 with SMTP id 006d021491bc7-67858fea6bfmr4750317eaf.1.1771351272644; Tue, 17
 Feb 2026 10:01:12 -0800 (PST)
Date: Tue, 17 Feb 2026 18:01:05 +0000
In-Reply-To: <20260217180108.1420024-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217180108.1420024-1-avagin@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217180108.1420024-2-avagin@google.com>
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
	Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-77380-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com,google.com,futurfusion.io];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,futurfusion.io:email]
X-Rspamd-Queue-Id: AB78514ED68
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
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
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
2.53.0.310.g728cabbaf7-goog


