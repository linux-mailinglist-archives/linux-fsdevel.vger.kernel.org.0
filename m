Return-Path: <linux-fsdevel+bounces-70434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07883C9A3A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 07:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18AED4E338B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 06:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80AD3016F0;
	Tue,  2 Dec 2025 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fDRcJ4E2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C830146B;
	Tue,  2 Dec 2025 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764656415; cv=none; b=SuZkbiqI1tyglM+ty+GYF8GdOdN//MNSa34ud356NFV3iWnVmRxE0qEeDacX92WJQ/ZViYjs4qZqF+rRT3ADjhOFy12EKswC82JXsXgIJksgbhZGrENG32RggtY4ZkDN8Iwo1xk2ZpEB0NKtnBj4VMofZPkmeyYsJhnkGe6XVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764656415; c=relaxed/simple;
	bh=K4ZA7hnYTzlxkF0vBFLe9QmybewTVS/+DvDD547FUwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXqHMp4/zVVIXL0ntykM3013Rok3TNhV2+xZVWuflbgF9oRGGn79S6tnhbT4HYl7dbWG48jndpk2GIQFEJer9gwn5VlYya+QtZ6kaC7zTDEWKJoQZ1ngjQeje77X+3yuMSMfhc8s1ZIuxe+QHoUsiHuU6Oaw0I/YDYV7aY/Maqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fDRcJ4E2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=56/x0+28mTg9Bv11b8Qp76qX+UumE/Mr3qU1abSynZo=; b=fDRcJ4E29dJMSDX3oHOiNb2LS7
	EFzpUoivEB6cCUHipZ4NcyKs0+k+Ykr58+1ds4C10Dbq3We7Pjv9Xm9VyECxhZGfjk3DBkJLgDOIN
	01Fb7kT3tQMuAY5SQPkjWodfnaBDDBfyZCjQklhtKyj+GVYdglpUoPGIDzTUm4F8GdA33ImxhIeyk
	GxxDXzW47idHt/97E8ate8mnHouHmhnDD0E+i95/4fA9KylnorJy1DLF8cdsx9cKrcVt+3v9gNrlo
	aF4vCGUt0ovht69wg5pbSzsKpJJctSkE8cuOQTyF5UTClePoYRky5BwCqy3QuOGo+4hHezpnnhkoi
	CtyS5vcg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vQJkP-00000003167-1s0g;
	Tue, 02 Dec 2025 06:20:25 +0000
Date: Tue, 2 Dec 2025 06:20:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: hide names_cache behind runtime const machinery
Message-ID: <20251202062025.GC1712166@ZenIV>
References: <20251201083226.268846-1-mjguzik@gmail.com>
 <20251201085117.GB3538@ZenIV>
 <20251202023147.GA1712166@ZenIV>
 <CAGudoHGbYvSAq=eJySxsf-AqkQ+ne_1gzuaojidA-GH+znw2hw@mail.gmail.com>
 <20251202055258.GB1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202055258.GB1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 02, 2025 at 05:52:58AM +0000, Al Viro wrote:

> The delicate part is headers, indeed - we don't want to expose struct kmem_cache guts
> anywhere outside of mm/*, and not the entire mm/* either.  But that's not hard to
> deal with - see include/generate/bounds.h, include/generate/rq-offsets.h, etc.
> Exact same technics can be used to get sizeof(struct kmem_cache) calculated and
> put into generated header.  Then we get something like struct kmem_cache_store with
> the right size and alignment, and _that_ would be what the variables would be.
> With static inline struct kmem_cache *to_kmem_cache(struct kmem_cache_store *)
> returning a cast and e.g.
> 
> static inline void free_filename(struct __filename *p)
> {
>         kmem_cache_free(to_kmem_cache(&names_cache), p);
> }
> 
> as an example of use.
> 
> Anyway, for now I've applied your patch pretty much as-is; conversion of the
> sort described above can be done afterwards just fine.
> 

FWIW, the Kbuild side of that would be like this - not a lot of magic there:

diff --git a/Kbuild b/Kbuild
index 13324b4bbe23..eb985a6614eb 100644
--- a/Kbuild
+++ b/Kbuild
@@ -45,13 +45,24 @@ kernel/sched/rq-offsets.s: $(offsets-file)
 $(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
 	$(call filechk,offsets,__RQ_OFFSETS_H__)
 
+# generate kmem_cache_size.h
+
+kmem_cache_size-file := include/generated/kmem_cache_size.h
+
+targets += mm/kmem_cache_size.s
+
+mm/kmem_cache_size.s: $(rq-offsets-file)
+
+$(kmem_cache_size-file): mm/kmem_cache_size.s FORCE
+	$(call filechk,offsets,__KMEM_CACHE_SIZE_H__)
+
 # Check for missing system calls
 
 quiet_cmd_syscalls = CALL    $<
       cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags)
 
 PHONY += missing-syscalls
-missing-syscalls: scripts/checksyscalls.sh $(rq-offsets-file)
+missing-syscalls: scripts/checksyscalls.sh $(kmem_cache_size-file)
 	$(call cmd,syscalls)
 
 # Check the manual modification of atomic headers
diff --git a/include/linux/kmem_cache_store.h b/include/linux/kmem_cache_store.h
new file mode 100644
index 000000000000..4bd21480d3cf
--- /dev/null
+++ b/include/linux/kmem_cache_store.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_KMEM_CACHE_STORE_H
+#define __LINUX_KMEM_CACHE_STORE_H
+
+#include <generated/kmem_cache_size.h>
+
+/* same size and alignment as struct kmem_cache */
+struct kmem_cache_store {
+	unsigned char opaque[KMEM_CACHE_SIZE];
+} __attribute__((__aligned__(KMEM_CACHE_ALIGN)));
+
+struct kmem_cache;
+
+static inline struct kmem_cache *to_kmem_cache(struct kmem_cache_store *p)
+{
+	return (struct kmem_cache *)p;
+}
+#endif
diff --git a/mm/kmem_cache_size.c b/mm/kmem_cache_size.c
new file mode 100644
index 000000000000..52395b225aa1
--- /dev/null
+++ b/mm/kmem_cache_size.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generate definitions needed by the preprocessor.
+ * This code generates raw asm output which is post-processed
+ * to extract and format the required data.
+ */
+
+#define __GENERATING_KMEM_CACHE_SIZE_H
+/* Include headers that define the enum constants of interest */
+#include <linux/kbuild.h>
+#include "slab.h"
+
+int main(void)
+{
+	/* The enum constants to put into include/generated/bounds.h */
+	DEFINE(KMEM_CACHE_SIZE, sizeof(struct kmem_cache));
+	DEFINE(KMEM_CACHE_ALIGN, __alignof(struct kmem_cache));
+	/* End of constants */
+
+	return 0;
+}

