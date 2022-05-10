Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4449521A4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 15:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbiEJNy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 09:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244244AbiEJNpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 09:45:38 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA953B6B;
        Tue, 10 May 2022 06:31:11 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 331CFECFC24;
        Tue, 10 May 2022 15:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1652189438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TugJz5+QCJyu8wwc9QB/DMWsWTy6bV1OohU2rFbFMaU=;
        b=Q26aLyLoQOv1wdBTulCzNKsCc1vuIFEOP58OWwUx5EOdaNe2QeMzyvXfPP6AbEnC5X6O5F
        pYqNhisYPkoyzM/PeQWEQ78xLGoSaVfpW0QnScKHKyHd5GJql9OyK+FhwqhpYHkJTrNYCc
        WeKXFEmJvwx+NVfICsvZQZCG4kFvYwg=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     akpm@linux-foundation.org, cgel.zte@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, corbet@lwn.net, xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6] mm/ksm: introduce ksm_force for each process
Date:   Tue, 10 May 2022 15:30:36 +0200
Message-ID: <5820954.lOV4Wx5bFT@natalenko.name>
In-Reply-To: <20220510122242.1380536-1-xu.xin16@zte.com.cn>
References: <20220510122242.1380536-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

On =C3=BAter=C3=BD 10. kv=C4=9Btna 2022 14:22:42 CEST cgel.zte@gmail.com wr=
ote:
> From: xu xin <xu.xin16@zte.com.cn>
>=20
> To use KSM, we have to explicitly call madvise() in application code,
> which means installed apps on OS needs to be uninstall and source code
> needs to be modified. It is inconvenient.
>=20
> In order to change this situation, We add a new proc file ksm_force
> under /proc/<pid>/ to support turning on/off KSM scanning of a
> process's mm dynamically.
>=20
> If ksm_force is set to 1, force all anonymous and 'qualified' VMAs
> of this mm to be involved in KSM scanning without explicitly calling
> madvise to mark VMA as MADV_MERGEABLE. But It is effective only when
> the klob of /sys/kernel/mm/ksm/run is set as 1.
>=20
> If ksm_force is set to 0, cancel the feature of ksm_force of this
> process (fallback to the default state) and unmerge those merged pages
> belonging to VMAs which is not madvised as MADV_MERGEABLE of this process,
> but still leave MADV_MERGEABLE areas merged.

To my best knowledge, last time a forcible KSM was discussed (see threads [=
1], [2], [3] and probably others) it was concluded that a) procfs was a hor=
rible interface for things like this one; and b) process_madvise() syscall =
was among the best suggested places to implement this (which would require =
a more tricky handling from userspace, but still).

So, what changed since that discussion?

P.S. For now I do it via dedicated syscall, but I'm not trying to upstream =
this approach.

[1] https://lore.kernel.org/lkml/2a66abd8-4103-f11b-06d1-07762667eee6@suse.=
cz/
[2] https://lore.kernel.org/all/20190515145151.GG16651@dhcp22.suse.cz/T/#u
[3] https://lore.kernel.org/lkml/20190516172452.GA2106@avx2/
[4] https://gitlab.com/post-factum/pf-kernel/-/commits/ksm-5.17/

> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Reviewed-by: wangyong <wang.yong12@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> ---
> v6:
> - modify the way of "return"
> - remove unnecessary words in Documentation/admin-guide/mm/ksm.rst
> - add additional notes to "set 0 to ksm_force" in Documentation/../ksm.rst
> and Documentation/../proc.rst
> v5:
> - fix typos in Documentation/filesystem/proc.rst
> v4:
> - fix typos in commit log
> - add interface descriptions under Documentation/
> v3:
> - fix compile error of mm/ksm.c
> v2:
> - fix a spelling error in commit log.
> - remove a redundant condition check in ksm_force_write().
> ---
>  Documentation/admin-guide/mm/ksm.rst | 19 +++++-
>  Documentation/filesystems/proc.rst   | 17 +++++
>  fs/proc/base.c                       | 93 ++++++++++++++++++++++++++++
>  include/linux/mm_types.h             |  9 +++
>  mm/ksm.c                             | 32 +++++++++-
>  5 files changed, 167 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
> index b244f0202a03..8cabc2504005 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -32,7 +32,7 @@ are swapped back in: ksmd must rediscover their identit=
y and merge again).
>  Controlling KSM with madvise
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> =20
> -KSM only operates on those areas of address space which an application
> +KSM can operates on those areas of address space which an application
>  has advised to be likely candidates for merging, by using the madvise(2)
>  system call::
> =20
> @@ -70,6 +70,23 @@ Applications should be considerate in their use of MAD=
V_MERGEABLE,
>  restricting its use to areas likely to benefit.  KSM's scans may use a l=
ot
>  of processing power: some installations will disable KSM for that reason.
> =20
> +Controlling KSM with procfs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +KSM can also operate on anonymous areas of address space of those proces=
ses's
> +knob ``/proc/<pid>/ksm_force`` is on, even if app codes doesn't call mad=
vise()
> +explicitly to advise specific areas as MADV_MERGEABLE.
> +
> +You can set ksm_force to 1 to force all anonymous and qualified VMAs of
> +this process to be involved in KSM scanning.
> +	e.g. ``echo 1 > /proc/<pid>/ksm_force``
> +
> +You can also set ksm_force to 0 to cancel that force feature of this pro=
cess
> +and unmerge those merged pages which belongs to those VMAs not marked as
> +MADV_MERGEABLE of this process. But that still leave those pages belongi=
ng to
> +VMAs marked as MADV_MERGEABLE merged (fallback to the default state).
> +	e.g. ``echo 0 > /proc/<pid>/ksm_force``
> +
>  .. _ksm_sysfs:
> =20
>  KSM daemon sysfs interface
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
> index 061744c436d9..8890b8b457a4 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -47,6 +47,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold=
=2Enet>    June 9 2009
>    3.10  /proc/<pid>/timerslack_ns - Task timerslack value
>    3.11	/proc/<pid>/patch_state - Livepatch patch operation state
>    3.12	/proc/<pid>/arch_status - Task architecture specific information
> +  3.13	/proc/<pid>/ksm_force - Setting of mandatory involvement in KSM
> =20
>    4	Configuring procfs
>    4.1	Mount options
> @@ -2176,6 +2177,22 @@ AVX512_elapsed_ms
>    the task is unlikely an AVX512 user, but depends on the workload and t=
he
>    scheduling scenario, it also could be a false negative mentioned above.
> =20
> +3.13	/proc/<pid>/ksm_force - Setting of mandatory involvement in KSM
> +-----------------------------------------------------------------------
> +When CONFIG_KSM is enabled, this file can be used to specify if this
> +process's anonymous memory can be involved in KSM scanning without app c=
odes
> +explicitly calling madvise to mark memory address as MADV_MERGEABLE.
> +
> +If writing 1 to this file, the kernel will force all anonymous and quali=
fied
> +memory to be involved in KSM scanning without explicitly calling madvise=
 to
> +mark memory address as MADV_MERGEABLE. But that is effective only when t=
he
> +klob of '/sys/kernel/mm/ksm/run' is set as 1.
> +
> +If writing 0 to this file, the mandatory KSM feature of this process's w=
ill
> +be cancelled and unmerge those merged pages which belongs to those areas=
 not
> +marked as MADV_MERGEABLE of this process, but leave those pages belongin=
g to
> +areas marked as MADV_MERGEABLE merged (fallback to the default state).
> +
>  Chapter 4: Configuring procfs
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> =20
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 8dfa36a99c74..d60f7342f79e 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -96,6 +96,7 @@
>  #include <linux/time_namespace.h>
>  #include <linux/resctrl.h>
>  #include <linux/cn_proc.h>
> +#include <linux/ksm.h>
>  #include <trace/events/oom.h>
>  #include "internal.h"
>  #include "fd.h"
> @@ -3168,6 +3169,96 @@ static int proc_pid_ksm_merging_pages(struct seq_f=
ile *m, struct pid_namespace *
> =20
>  	return 0;
>  }
> +
> +static ssize_t ksm_force_read(struct file *file, char __user *buf, size_=
t count,
> +				loff_t *ppos)
> +{
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +	char buffer[PROC_NUMBUF];
> +	ssize_t len;
> +	int ret;
> +
> +	task =3D get_proc_task(file_inode(file));
> +	if (!task)
> +		return -ESRCH;
> +
> +	mm =3D get_task_mm(task);
> +	ret =3D 0;
> +	if (mm) {
> +		len =3D snprintf(buffer, sizeof(buffer), "%d\n", mm->ksm_force);
> +		ret =3D  simple_read_from_buffer(buf, count, ppos, buffer, len);
> +		mmput(mm);
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t ksm_force_write(struct file *file, const char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +	char buffer[PROC_NUMBUF];
> +	int force;
> +	int err =3D 0;
> +
> +	memset(buffer, 0, sizeof(buffer));
> +	if (count > sizeof(buffer) - 1)
> +		count =3D sizeof(buffer) - 1;
> +	if (copy_from_user(buffer, buf, count))
> +		return -EFAULT;
> +
> +	err =3D kstrtoint(strstrip(buffer), 0, &force);
> +	if (err)
> +		return err;
> +
> +	if (force !=3D 0 && force !=3D 1)
> +		return -EINVAL;
> +
> +	task =3D get_proc_task(file_inode(file));
> +	if (!task)
> +		return -ESRCH;
> +
> +	mm =3D get_task_mm(task);
> +	if (!mm)
> +		goto out_put_task;
> +
> +	if (mm->ksm_force !=3D force) {
> +		if (mmap_write_lock_killable(mm)) {
> +			err =3D -EINTR;
> +			goto out_mmput;
> +		}
> +
> +		if (force =3D=3D 0)
> +			mm->ksm_force =3D force;
> +		else {
> +			/*
> +			 * Force anonymous pages of this mm to be involved in KSM merging
> +			 * without explicitly calling madvise.
> +			 */
> +			if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
> +				err =3D __ksm_enter(mm);
> +			if (!err)
> +				mm->ksm_force =3D force;
> +		}
> +
> +		mmap_write_unlock(mm);
> +	}
> +
> +out_mmput:
> +	mmput(mm);
> +out_put_task:
> +	put_task_struct(task);
> +
> +	return err < 0 ? err : count;
> +}
> +
> +static const struct file_operations proc_pid_ksm_force_operations =3D {
> +	.read		=3D ksm_force_read,
> +	.write		=3D ksm_force_write,
> +	.llseek		=3D generic_file_llseek,
> +};
>  #endif /* CONFIG_KSM */
> =20
>  #ifdef CONFIG_STACKLEAK_METRICS
> @@ -3303,6 +3394,7 @@ static const struct pid_entry tgid_base_stuff[] =3D=
 {
>  #endif
>  #ifdef CONFIG_KSM
>  	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
> +	REG("ksm_force", S_IRUSR|S_IWUSR, proc_pid_ksm_force_operations),
>  #endif
>  };
> =20
> @@ -3639,6 +3731,7 @@ static const struct pid_entry tid_base_stuff[] =3D {
>  #endif
>  #ifdef CONFIG_KSM
>  	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
> +	REG("ksm_force", S_IRUSR|S_IWUSR, proc_pid_ksm_force_operations),
>  #endif
>  };
> =20
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b34ff2cdbc4f..1b1592c2f5cf 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -661,6 +661,15 @@ struct mm_struct {
>  		 * merging.
>  		 */
>  		unsigned long ksm_merging_pages;
> +		/*
> +		 * If true, force anonymous pages of this mm to be involved in KSM
> +		 * merging without explicitly calling madvise. It is effctive only
> +		 * when the klob of '/sys/kernel/mm/ksm/run' is set as 1. If false,
> +		 * cancel the feature of ksm_force of this process and unmerge
> +		 * those merged pages which is not madvised as MERGEABLE of this
> +		 * process, but leave MERGEABLE areas merged.
> +		 */
> +		bool ksm_force;
>  #endif
>  	} __randomize_layout;
> =20
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 38360285497a..c9f672dcc72e 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -334,6 +334,34 @@ static void __init ksm_slab_free(void)
>  	mm_slot_cache =3D NULL;
>  }
> =20
> +/* Check if vma is qualified for ksmd scanning */
> +static bool ksm_vma_check(struct vm_area_struct *vma)
> +{
> +	unsigned long vm_flags =3D vma->vm_flags;
> +
> +	if (!(vma->vm_flags & VM_MERGEABLE) && !(vma->vm_mm->ksm_force))
> +		return false;
> +
> +	if (vm_flags & (VM_SHARED	| VM_MAYSHARE	|
> +			VM_PFNMAP	| VM_IO | VM_DONTEXPAND |
> +			VM_HUGETLB	| VM_MIXEDMAP))
> +		return false;       /* just ignore this vma*/
> +
> +	if (vma_is_dax(vma))
> +		return false;
> +
> +#ifdef VM_SAO
> +	if (vm_flags & VM_SAO)
> +		return false;
> +#endif
> +#ifdef VM_SPARC_ADI
> +	if (vm_flags & VM_SPARC_ADI)
> +		return false;
> +#endif
> +
> +	return true;
> +}
> +
>  static __always_inline bool is_stable_node_chain(struct stable_node *cha=
in)
>  {
>  	return chain->rmap_hlist_len =3D=3D STABLE_NODE_CHAIN;
> @@ -523,7 +551,7 @@ static struct vm_area_struct *find_mergeable_vma(stru=
ct mm_struct *mm,
>  	if (ksm_test_exit(mm))
>  		return NULL;
>  	vma =3D vma_lookup(mm, addr);
> -	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
> +	if (!vma || !ksm_vma_check(vma) || !vma->anon_vma)
>  		return NULL;
>  	return vma;
>  }
> @@ -2297,7 +2325,7 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
>  		vma =3D find_vma(mm, ksm_scan.address);
> =20
>  	for (; vma; vma =3D vma->vm_next) {
> -		if (!(vma->vm_flags & VM_MERGEABLE))
> +		if (!ksm_vma_check(vma))
>  			continue;
>  		if (ksm_scan.address < vma->vm_start)
>  			ksm_scan.address =3D vma->vm_start;
>=20


=2D-=20
Oleksandr Natalenko (post-factum)


