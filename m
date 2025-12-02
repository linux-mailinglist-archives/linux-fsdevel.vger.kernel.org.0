Return-Path: <linux-fsdevel+bounces-70438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4488C9A696
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 08:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 793824E28E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868F2FD7AE;
	Tue,  2 Dec 2025 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UchE0JZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF6220F2A;
	Tue,  2 Dec 2025 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660060; cv=none; b=mui1gKPcaQP6j53Z4S8vAPmLcHbKmPM7UPt9irpyTN8gpQK266LnQZKeuri8A+veMRmCrVkZCJ3mieEGz8jh1715N8KJ/FqWZOPl5u9IPKISA0+GALKQWrdwuiJKaxFIfau3zMLhBInkI+3sT32RpcIlABQpjYzQvmr9oWiDYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660060; c=relaxed/simple;
	bh=Dlt9nWsocxHHQveNF3QmetO7kHpSln0GJPYPQ11NkUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTF222XAnR8eHP9z0/SRkxLElwhqFNOfaYJM/DwjMYscPAbSc3MCs/3w2+CdwCZ+LHUSLcPQ0oN8Otx7lnJaLpqfC0dOJRaHnHeotugEHS0vp+7WSntbPcOefNrKP2Cuhva1/1sQCOkqFjy0E0ECSuW0razvedqCNnDCcaCpdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UchE0JZg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E6qlhrwFwU3oa8B9oGRG4kgejN6hrKAl34jxR7zahjc=; b=UchE0JZgGLgTgyv6DPUBe2KqJo
	hhqjc6uWk9w8MlLvDfKBramw8Gyx/TZrxOify0vvadBvm/CJNyru5QspMnsDmUGciZBA2H1q7Yc9V
	kTOHve5qPycK4Me+RjhAFbEXyLmeUnsIYmt7HOPyBEZFtaf+VciG4L8CL4pYZUaSXBrVM0Idd6IVr
	B8xvwP0tttAU27baMt2Rv0cGoMkPrEuEGmJfvcPqzyfD8qPt+V5ZT63PvbQ0SQjCMfG4KN7/mc7lO
	773pNm0tPWKwrZncjaBla1/Nj5O0P9c3wPf/7aGpzswXOKv4TiFrFtdz1sCstwMvJR3NGIeUb0lcK
	gYEXMaRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vQKhB-00000004KqQ-2Wvr;
	Tue, 02 Dec 2025 07:21:09 +0000
Date: Tue, 2 Dec 2025 07:21:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: hide names_cache behind runtime const machinery
Message-ID: <20251202072109.GE1712166@ZenIV>
References: <20251201083226.268846-1-mjguzik@gmail.com>
 <20251201085117.GB3538@ZenIV>
 <20251202023147.GA1712166@ZenIV>
 <CAGudoHGbYvSAq=eJySxsf-AqkQ+ne_1gzuaojidA-GH+znw2hw@mail.gmail.com>
 <20251202055258.GB1712166@ZenIV>
 <CAGudoHFD6bWhp-8821Pb6cDAEnR9N8UFEj9qT7G-_v0FOS+_vg@mail.gmail.com>
 <20251202063228.GD1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202063228.GD1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 02, 2025 at 06:32:28AM +0000, Al Viro wrote:
> On Tue, Dec 02, 2025 at 07:18:16AM +0100, Mateusz Guzik wrote:
> 
> > The claim was not that your idea results in insurmountable churn. The
> > claim was *both* your idea and runtime const require churn on per kmem
> > cache basis. Then the question is if one is going to churn it
> > regardless, why this way over runtime const. I do think the runtime
> > thing is a little bit less churn and less work on the mm side to get
> > it going, but then the runtime thing *itself* needs productizing
> > (which I'm not signing up to do).
> 
> Umm...  runtime thing is lovely for shifts, but for pointers it's
> going to be a headache on a bunch of architectures; for something
> like dentry_hashtable it's either that or the cost of dereference,
> but for kmem_cache I'd try it - if architecture has a good way for
> "load a 64bit constant into a register staying within I$", I'd
> expect the code generated for &global_variable to be not worse than
> that, after all.
> 
> Churn is pretty much negligible in case of core kernel caches either
> way.
> 
> As for the amount of churn in mm/*...  Turns out to be fairly minor;
> kmem_cache_args allows to propagate it without any calling convention
> changes.
> 
> I'll post when I get it to reasonable shape - so far it looks easy...

OK, I'm going to grab some sleep; current (completely untested) delta
below, with conversion of mnt_cache as an example of use.

Uses of to_kmem_cache can be reduced with some use of _Generic
for kmem_cache_...alloc() and kmem_cache_free().  Even as it is,
the churn in fs/namespace.c is pretty minor...

Anyway, this is an intermediate variant:

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
diff --git a/fs/namespace.c b/fs/namespace.c
index d766e08e0736..08c7870de413 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -34,6 +34,7 @@
 #include <linux/mnt_idmapping.h>
 #include <linux/pidfs.h>
 #include <linux/nstree.h>
+#include <linux/kmem_cache_static.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -85,7 +86,7 @@ static u64 mnt_id_ctr = MNT_UNIQUE_ID_OFFSET;
 
 static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
-static struct kmem_cache *mnt_cache __ro_after_init;
+static struct kmem_cache_store mnt_cache;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
@@ -290,7 +291,8 @@ int mnt_get_count(struct mount *mnt)
 
 static struct mount *alloc_vfsmnt(const char *name)
 {
-	struct mount *mnt = kmem_cache_zalloc(mnt_cache, GFP_KERNEL);
+	struct mount *mnt = kmem_cache_zalloc(to_kmem_cache(&mnt_cache),
+					      GFP_KERNEL);
 	if (mnt) {
 		int err;
 
@@ -339,7 +341,7 @@ static struct mount *alloc_vfsmnt(const char *name)
 out_free_id:
 	mnt_free_id(mnt);
 out_free_cache:
-	kmem_cache_free(mnt_cache, mnt);
+	kmem_cache_free(to_kmem_cache(&mnt_cache), mnt);
 	return NULL;
 }
 
@@ -734,7 +736,7 @@ static void free_vfsmnt(struct mount *mnt)
 #ifdef CONFIG_SMP
 	free_percpu(mnt->mnt_pcp);
 #endif
-	kmem_cache_free(mnt_cache, mnt);
+	kmem_cache_free(to_kmem_cache(&mnt_cache), mnt);
 }
 
 static void delayed_free_vfsmnt(struct rcu_head *head)
@@ -6013,8 +6015,9 @@ void __init mnt_init(void)
 {
 	int err;
 
-	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct mount),
-			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
+	kmem_cache_setup("mnt_cache", sizeof(struct mount),
+			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
+			NULL, &mnt_cache);
 
 	mount_hashtable = alloc_large_system_hash("Mount-cache",
 				sizeof(struct hlist_head),
diff --git a/include/linux/kmem_cache_static.h b/include/linux/kmem_cache_static.h
new file mode 100644
index 000000000000..f007c3bf3e88
--- /dev/null
+++ b/include/linux/kmem_cache_static.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_KMEM_CACHE_STATIC_H
+#define __LINUX_KMEM_CACHE_STATIC_H
+
+#include <generated/kmem_cache_size.h>
+#include <linux/slab.h>
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
+
+static inline int
+kmem_cache_setup(const char *name, unsigned int size, unsigned int align,
+		 slab_flags_t flags, void (*ctor)(void *),
+		 struct kmem_cache_store *s)
+{
+	struct kmem_cache *res;
+
+	res = __kmem_cache_create_args(name, size,
+					&(struct kmem_cache_args){
+						.align	= align,
+						.ctor	= ctor,
+						.preallocated = s},
+					flags);
+	return PTR_ERR_OR_ZERO(res);
+}
+
+#endif
diff --git a/include/linux/slab.h b/include/linux/slab.h
index cf443f064a66..a016aa817139 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -266,6 +266,8 @@ struct mem_cgroup;
  */
 bool slab_is_available(void);
 
+struct kmem_cache_store;
+
 /**
  * struct kmem_cache_args - Less common arguments for kmem_cache_create()
  *
@@ -366,6 +368,7 @@ struct kmem_cache_args {
 	 * %0 means no sheaves will be created.
 	 */
 	unsigned int sheaf_capacity;
+	struct kmem_cache_store *preallocated;
 };
 
 struct kmem_cache *__kmem_cache_create_args(const char *name,
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
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 932d13ada36c..e48775475097 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -29,6 +29,7 @@
 #include <linux/memcontrol.h>
 #include <linux/stackdepot.h>
 #include <trace/events/rcu.h>
+#include <linux/kmem_cache_static.h>
 
 #include "../kernel/rcu/rcu.h"
 #include "internal.h"
@@ -224,21 +225,21 @@ static struct kmem_cache *create_cache(const char *name,
 				       struct kmem_cache_args *args,
 				       slab_flags_t flags)
 {
-	struct kmem_cache *s;
+	struct kmem_cache *s = to_kmem_cache(args->preallocated);
 	int err;
 
 	/* If a custom freelist pointer is requested make sure it's sane. */
-	err = -EINVAL;
 	if (args->use_freeptr_offset &&
 	    (args->freeptr_offset >= object_size ||
 	     !(flags & SLAB_TYPESAFE_BY_RCU) ||
 	     !IS_ALIGNED(args->freeptr_offset, __alignof__(freeptr_t))))
-		goto out;
+		return ERR_PTR(-EINVAL);
 
-	err = -ENOMEM;
-	s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
-	if (!s)
-		goto out;
+	if (!s) {
+		s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
+		if (!s)
+			return ERR_PTR(-ENOMEM);
+	}
 	err = do_kmem_cache_create(s, name, object_size, args, flags);
 	if (err)
 		goto out_free_cache;
@@ -248,8 +249,8 @@ static struct kmem_cache *create_cache(const char *name,
 	return s;
 
 out_free_cache:
-	kmem_cache_free(kmem_cache, s);
-out:
+	if (!args->preallocated)
+		kmem_cache_free(kmem_cache, s);
 	return ERR_PTR(err);
 }
 
@@ -324,7 +325,7 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 		    object_size - args->usersize < args->useroffset))
 		args->usersize = args->useroffset = 0;
 
-	if (!args->usersize && !args->sheaf_capacity)
+	if (!args->usersize && !args->sheaf_capacity && !args->preallocated)
 		s = __kmem_cache_alias(name, object_size, args->align, flags,
 				       args->ctor);
 	if (s)

