Return-Path: <linux-fsdevel+bounces-57433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F034FB21746
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 23:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6597A17E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 21:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159242E3B01;
	Mon, 11 Aug 2025 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Px1tVrwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D372E3366
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947391; cv=none; b=fFohhcEYtcDpG2mpXsBz8jEgw+nmF6BSBfR9yyMgIth7ASOsm7ThYK66Fd0HElKDjPfl5vvM0MxSSQHV2krhxVk+C3SYvlUcxSqpDd27Hzdx2dywMA3ZKXP+8aZdDzt/fWWIegl0xY/Ke+4un706Y83kazPis3443RVBPyD80IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947391; c=relaxed/simple;
	bh=jU+yBfuxy7cTU86IFeA0OqBCDPA1BVMeU2ocJMXSOZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YaTuI53844M35/Is5UhNrDFUTmUwjCOsG6Wlu7jRvH6I9jlJ8apKq9DtsK8ueQcq79MGXsEQJ04vAAapVhBg7oRs4BTrAX51qQykU/9YXhvldHWN0CDDpJmCBsjJsrlb6HJSEfSyHXJvFcppH7JWNraW8Hq0/ElMX9m4/PAmt38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Px1tVrwt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bfab12672so9672033b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754947389; x=1755552189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=05IUDOHLoU+NapT4auKPkbt3cJ61ybRHsivfAAxzoHI=;
        b=Px1tVrwtvDVNdVvKzJ2prZXhRb0BE2CoqL4iQecmdeirvTVJfoVfp1ZCsNFT13iLCM
         gfkBhEmVp/3Hne2yx8aKviM1z1Ft1ZojTvtxZ7Lkb3omkmQLFKXuXj7LQsGc5kzXRKp3
         6qy/T9hepERBk/hDr3c5k2WVleVG0yoPQnKyNKRIH3fWMG3GFhMANpoWG2l8nu/0P/z1
         r3wdrhtCNXX1vimmgivcvFs3FC+DurOqiKKY2YQoRoCyBPGqqRVcm+n6EAwCeincCdM4
         ZALYlN7Ye4QI+8uQrNEkIoT2QgYCaGcjlWfa84pbhrmOiz0i7aRVCUyogrDWpKoiquMR
         DspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754947389; x=1755552189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05IUDOHLoU+NapT4auKPkbt3cJ61ybRHsivfAAxzoHI=;
        b=O96bW8KYymG8JXaj9sGSx23EPMAMXBJb5V3rHhKkM8ZlzlC4NFLq0Ui6uJ7VELem4O
         cX9iDtltz0eUukcRKC2ENRCj/+kkWyeE3/mHRz8cnnDEwHHJibGkHsKzoYTMj3uXayxN
         sKasE6teCykqnxuMyXtteHpWyN2XNydeGXHdWmXdYQjvBXy8AL3jfkhi1lTfyainBSUn
         LSUHLaIZaXAo1RJ1FqJOktpwjLJKpgqA792F2KjhZFb4auC2x8WT2pfJmvG5ku2U9VX6
         sQi9NsLidHFPWDTkPQbapPI5Zi/TRf4YxZCTTz951XY1RLkRvUCyasLDsEjdjwTmJa2u
         UEYg==
X-Forwarded-Encrypted: i=1; AJvYcCUfb+rJ+Yxa2hEVbmVXYa2r6jT20aqpBObV+V06VGirBYau0abG9PnKatM1XQONjmJksSdRv3g6smwWyVC6@vger.kernel.org
X-Gm-Message-State: AOJu0YzwVZftXrmGIbwR5erwqBbOga9M9YdQn9+z7knBYZN588sOaZ4a
	+NLrrksUECldKur+Mor7RGWgYSc+40n1FGooX9MOzyw0+W2r6BUwTJLGZE8JAjJXyCaF+idpPqN
	e6XkDJV6Mnh5ze2nIjmtPh5+nMw==
X-Google-Smtp-Source: AGHT+IGhD8wuXRxDbQxbc6dPZBtu1qLcQXHBeiJmtKy0dLRbddKNNSDcwg+GSBc3ARQq15cEOQTE9YJKl1VCh4HB5g==
X-Received: from pfdc2.prod.google.com ([2002:aa7:8c02:0:b0:748:f98a:d97b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b85:b0:76b:fbf4:b9d8 with SMTP id d2e1a72fcca58-76c4619f85fmr17869611b3a.22.1754947388694;
 Mon, 11 Aug 2025 14:23:08 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:23:07 -0700
In-Reply-To: <cee2e489-d3c9-46d4-8d34-37c637c7bbd8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811090605.16057-2-shivankg@amd.com> <20250811090605.16057-10-shivankg@amd.com>
 <cee2e489-d3c9-46d4-8d34-37c637c7bbd8@redhat.com>
Message-ID: <diqz8qjpzh6s.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH RFC V10 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
From: Ackerley Tng <ackerleytng@google.com>
To: David Hildenbrand <david@redhat.com>, Shivank Garg <shivankg@amd.com>, seanjc@google.com, 
	vbabka@suse.cz, willy@infradead.org, akpm@linux-foundation.org, 
	shuah@kernel.org, pbonzini@redhat.com, brauner@kernel.org, 
	viro@zeniv.linux.org.uk
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, 
	bfoster@redhat.com, tabba@google.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com, 
	amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com, 
	ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

David Hildenbrand <david@redhat.com> writes:

> On 11.08.25 11:06, Shivank Garg wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>> 
>> [...snip...]
>>
>> +static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
>> +						  u64 flags)
>> +{
>> +	static const char *name = "[kvm-gmem]";
>> +	struct inode *inode;
>> +	struct file *file;
>> +	int err;
>> +
>> +	err = -ENOENT;
>
> Maybe add a comment here when the module reference will get
> dropped. And maybe we should just switch to fops_get() + fops_put?
>
> /* __fput() will take care of fops_put(). */
> if (!fops_get(&kvm_gmem_fops))
> 	goto err;
>

Sounds good! Please see attached patch. It's exactly what you suggested
except I renamed the goto target to err_fops_put:

>> +
>> +	inode = kvm_gmem_inode_make_secure_inode(name, size, flags);
>> +	if (IS_ERR(inode)) {
>> +		err = PTR_ERR(inode);
>> +		goto err_put_module;
>> +	}
>> +
>> +	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
>> +				 &kvm_gmem_fops);
>> +	if (IS_ERR(file)) {
>> +		err = PTR_ERR(file);
>> +		goto err_put_inode;
>> +	}
>> +
>> +	file->f_flags |= O_LARGEFILE;
>> +	file->private_data = priv;
>> +
>> +out:
>> +	return file;
>> +
>> +err_put_inode:
>> +	iput(inode);
>> +err_put_module:
>> +	module_put(kvm_gmem_fops.owner);
>
> fops_put(&kvm_gmem_fops);
>
> ?
>
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> -- 
> Cheers,
>
> David / dhildenb

From f2bd4499bce4db69bf34be75e009579db4329b7c Mon Sep 17 00:00:00 2001
From: Ackerley Tng <ackerleytng@google.com>
Date: Sun, 13 Jul 2025 17:43:35 +0000
Subject: [PATCH] KVM: guest_memfd: Use guest mem inodes instead of anonymous
 inodes

guest_memfd's inode represents memory the guest_memfd is
providing. guest_memfd's file represents a struct kvm's view of that
memory.

Using a custom inode allows customization of the inode teardown
process via callbacks. For example, ->evict_inode() allows
customization of the truncation process on file close, and
->destroy_inode() and ->free_inode() allow customization of the inode
freeing process.

Customizing the truncation process allows flexibility in management of
guest_memfd memory and customization of the inode freeing process
allows proper cleanup of memory metadata stored on the inode.

Memory metadata is more appropriately stored on the inode (as opposed
to the file), since the metadata is for the memory and is not unique
to a specific binding and struct kvm.

Co-developed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/uapi/linux/magic.h |   1 +
 virt/kvm/guest_memfd.c     | 129 ++++++++++++++++++++++++++++++-------
 virt/kvm/kvm_main.c        |   7 +-
 virt/kvm/kvm_mm.h          |   9 +--
 4 files changed, 119 insertions(+), 27 deletions(-)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index bb575f3ab45e5..638ca21b7a909 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -103,5 +103,6 @@
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
 #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
+#define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */

 #endif /* __LINUX_MAGIC_H__ */
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 08a6bc7d25b60..6c66a09740550 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1,12 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/anon_inodes.h>
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
+#include <linux/fs.h>
 #include <linux/kvm_host.h>
+#include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
-#include <linux/anon_inodes.h>

 #include "kvm_mm.h"

+static struct vfsmount *kvm_gmem_mnt;
+
 struct kvm_gmem {
 	struct kvm *kvm;
 	struct xarray bindings;
@@ -385,9 +389,45 @@ static struct file_operations kvm_gmem_fops = {
 	.fallocate	= kvm_gmem_fallocate,
 };

-void kvm_gmem_init(struct module *module)
+static int kvm_gmem_init_fs_context(struct fs_context *fc)
+{
+	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
+		return -ENOMEM;
+
+	fc->s_iflags |= SB_I_NOEXEC;
+	fc->s_iflags |= SB_I_NODEV;
+
+	return 0;
+}
+
+static struct file_system_type kvm_gmem_fs = {
+	.name		 = "guest_memfd",
+	.init_fs_context = kvm_gmem_init_fs_context,
+	.kill_sb	 = kill_anon_super,
+};
+
+static int kvm_gmem_init_mount(void)
+{
+	kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);
+
+	if (IS_ERR(kvm_gmem_mnt))
+		return PTR_ERR(kvm_gmem_mnt);
+
+	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
+	return 0;
+}
+
+int kvm_gmem_init(struct module *module)
 {
 	kvm_gmem_fops.owner = module;
+
+	return kvm_gmem_init_mount();
+}
+
+void kvm_gmem_exit(void)
+{
+	kern_unmount(kvm_gmem_mnt);
+	kvm_gmem_mnt = NULL;
 }

 static int kvm_gmem_migrate_folio(struct address_space *mapping,
@@ -463,11 +503,72 @@ bool __weak kvm_arch_supports_gmem_mmap(struct kvm *kvm)
 	return true;
 }

+static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
+						      loff_t size, u64 flags)
+{
+	struct inode *inode;
+
+	inode = anon_inode_make_secure_inode(kvm_gmem_mnt->mnt_sb, name, NULL);
+	if (IS_ERR(inode))
+		return inode;
+
+	inode->i_private = (void *)(unsigned long)flags;
+	inode->i_op = &kvm_gmem_iops;
+	inode->i_mapping->a_ops = &kvm_gmem_aops;
+	inode->i_mode |= S_IFREG;
+	inode->i_size = size;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+	mapping_set_inaccessible(inode->i_mapping);
+	/* Unmovable mappings are supposed to be marked unevictable as well. */
+	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+
+	return inode;
+}
+
+static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
+						  u64 flags)
+{
+	static const char *name = "[kvm-gmem]";
+	struct inode *inode;
+	struct file *file;
+	int err;
+
+	err = -ENOENT;
+	/* __fput() will take care of fops_put(). */
+	if (!fops_get(&kvm_gmem_fops))
+		goto err;
+
+	inode = kvm_gmem_inode_make_secure_inode(name, size, flags);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto err_fops_put;
+	}
+
+	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
+				 &kvm_gmem_fops);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_put_inode;
+	}
+
+	file->f_flags |= O_LARGEFILE;
+	file->private_data = priv;
+
+out:
+	return file;
+
+err_put_inode:
+	iput(inode);
+err_fops_put:
+	fops_put(&kvm_gmem_fops);
+err:
+	file = ERR_PTR(err);
+	goto out;
+}
+
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
-	const char *anon_name = "[kvm-gmem]";
 	struct kvm_gmem *gmem;
-	struct inode *inode;
 	struct file *file;
 	int fd, err;

@@ -481,32 +582,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 		goto err_fd;
 	}

-	file = anon_inode_create_getfile(anon_name, &kvm_gmem_fops, gmem,
-					 O_RDWR, NULL);
+	file = kvm_gmem_inode_create_getfile(gmem, size, flags);
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
 		goto err_gmem;
 	}

-	file->f_flags |= O_LARGEFILE;
-
-	inode = file->f_inode;
-	WARN_ON(file->f_mapping != inode->i_mapping);
-
-	inode->i_private = (void *)(unsigned long)flags;
-	inode->i_op = &kvm_gmem_iops;
-	inode->i_mapping->a_ops = &kvm_gmem_aops;
-	inode->i_mode |= S_IFREG;
-	inode->i_size = size;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
-	mapping_set_inaccessible(inode->i_mapping);
-	/* Unmovable mappings are supposed to be marked unevictable as well. */
-	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
-
 	kvm_get_kvm(kvm);
 	gmem->kvm = kvm;
 	xa_init(&gmem->bindings);
-	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
+	list_add(&gmem->entry, &file_inode(file)->i_mapping->i_private_list);

 	fd_install(fd, file);
 	return fd;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 18f29ef935437..301d48d6e00d0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6489,7 +6489,9 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	if (WARN_ON_ONCE(r))
 		goto err_vfio;

-	kvm_gmem_init(module);
+	r = kvm_gmem_init(module);
+	if (r)
+		goto err_gmem;

 	r = kvm_init_virtualization();
 	if (r)
@@ -6510,6 +6512,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 err_register:
 	kvm_uninit_virtualization();
 err_virt:
+	kvm_gmem_exit();
+err_gmem:
 	kvm_vfio_ops_exit();
 err_vfio:
 	kvm_async_pf_deinit();
@@ -6541,6 +6545,7 @@ void kvm_exit(void)
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
+	kvm_gmem_exit();
 	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
 	kvm_irqfd_exit();
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 31defb08ccbab..9fcc5d5b7f8d0 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -68,17 +68,18 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 #endif /* HAVE_KVM_PFNCACHE */

 #ifdef CONFIG_KVM_GUEST_MEMFD
-void kvm_gmem_init(struct module *module);
+int kvm_gmem_init(struct module *module);
+void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, loff_t offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
-static inline void kvm_gmem_init(struct module *module)
+static inline int kvm_gmem_init(struct module *module)
 {
-
+	return 0;
 }
-
+static inline void kvm_gmem_exit(void) {};
 static inline int kvm_gmem_bind(struct kvm *kvm,
 					 struct kvm_memory_slot *slot,
 					 unsigned int fd, loff_t offset)
--
2.51.0.rc0.155.g4a0f42376b-goog

