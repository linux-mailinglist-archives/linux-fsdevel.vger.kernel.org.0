Return-Path: <linux-fsdevel+bounces-39154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB65A10B64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 16:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD0D16AA95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFEC172BA9;
	Tue, 14 Jan 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vh2q1ZPx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E48C07
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869590; cv=none; b=rALkiMUkGWGmkcZWtjs4tLSqjMxMB7tYWCUI5Ll5ZRzrEjU/1owEUd9RWhlVuq0v0jGJoOgsiBNadbXDYws4zurKNHi4L3OCMHPEMTTfHln6D8OwX6ZXPSW69pS0fFZjLqJuVqalmY5qEGR8mS68ezkpD/m4niWxQB/6lqxwsdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869590; c=relaxed/simple;
	bh=kUI7CtwkZ9COv3ocxn23ryFl2J8RzI0PrAHh3SdmBhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4OGIRHju7d9xqI+Qk1Xu7oHdnw+E3FuKUFgzNFYIUnszCuxn5gDmTful5Ji9NKsslOJSDF8hlKaqVFB7BB8FBf8UPkkphQu0fZcqIepRQWCAQxOwrht5Z5hKu1tGjgGDz4mnOU0l/HNZbX2zVGDhpS6tQoSdRCx+7qUG/iH2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vh2q1ZPx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736869587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Po7sFqkgiNpWHgnYbDTLwK+PJsUBPIEB6Kwf5vaywco=;
	b=Vh2q1ZPxdphIjX9XY/lJBeRRv4ee4AxbPRPxRBpMPTu67WtM7GVge6Eq4iY28grELtQJ7P
	ANv3QAAudXxlayktihixZnEjvM9OkRsToMHMetktEfDlTD35kv+UZkzAI2ctCamDbswxW9
	Lm9v8EDC1J/bPPsk1o2v7uV0G2zFu1c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-qp0HT-LwP4GyIaw0vvUxlg-1; Tue, 14 Jan 2025 10:46:22 -0500
X-MC-Unique: qp0HT-LwP4GyIaw0vvUxlg-1
X-Mimecast-MFC-AGG-ID: qp0HT-LwP4GyIaw0vvUxlg
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5424a89c885so3109222e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 07:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869581; x=1737474381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Po7sFqkgiNpWHgnYbDTLwK+PJsUBPIEB6Kwf5vaywco=;
        b=VPATP8h3e+k+TIlrub0lhX/EibIPjfkUF0bIHd+TmXhsbvpY0JiwKV/A60LKcZLfUE
         ZgVPXJf8KYH5iaC8JAWxWGnUzbWXnXtoQ7jwh1cqLTkX/A4hgdkvJUrMNj/HHy+rpZKE
         jwByoL8NgG6pPBqEA7xkwdtyfNKsXEijMe4R1Qywe8R7b1RcsQDCh6dHaTt9gqhpEb4S
         0wdBAXzaQNZDNRwiI4XhBoAlmyPzRzXM24cWPj0SOwM2AfVK32zUsy+zcmsfcw0A4a0f
         Ee6DpkvspIz/zsjaat2DfXkx8QskFnQy6HFyd0f5/6jq9Uynj2v/LPMWTXGaDtRCz/Fi
         12dw==
X-Forwarded-Encrypted: i=1; AJvYcCWMqErqOi5BL5vSLWxnSNxg+tw98ApUSUudFLr/xQpf3DvMgCJUBhkXONaZrB+WlIXerk5A/dXBrnUalbOJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvjxt77OkwM9v6403l/S57cxWOt0PBCxOEbTXGKLAgMvMCagGS
	V+DeSoywHvnDmuJ/lDBT01E+URlM0ZajJWxYfkCTZc/LGl8v9o5arC+CT8hVPDauE8LPRtcvrEC
	XbbRsGTyjIAYJpu2+lHiC9xOWYv/dAaCqhVPrn3dJORDVZhhDGknaMa9wmkYRBOFwEj1Wp00DdG
	Z+AQ/ZlhC/fAgRXDxOUZrqKGAZSH/NwvFMD+SgMw==
X-Gm-Gg: ASbGncuIguD9SMMZ/7VvbVjQ8Sv3J9Kg0tUeQnOhpvbQPb7VWek+SOMbgxud4dFnrSy
	iSVVGTGyt3o5HTR0SIwrN/PbBy+5IdA0se5H9UCo=
X-Received: by 2002:a05:6512:2395:b0:542:62e6:4517 with SMTP id 2adb3069b0e04-542845a6e4amr9119542e87.12.1736869580870;
        Tue, 14 Jan 2025 07:46:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX+fhtb56T2Rw9G3WQOoy+tQ06Xt8/tniSED3WskgU41w/L1OqJZex71LoSnemXhht/EINT4HHtclNivAaN2Y=
X-Received: by 2002:a05:6512:2395:b0:542:62e6:4517 with SMTP id
 2adb3069b0e04-542845a6e4amr9119528e87.12.1736869580392; Tue, 14 Jan 2025
 07:46:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110174034304QOb8eDoqtFkp3_t8mqnqc@zte.com.cn>
In-Reply-To: <20250110174034304QOb8eDoqtFkp3_t8mqnqc@zte.com.cn>
From: Mario Casquero <mcasquer@redhat.com>
Date: Tue, 14 Jan 2025 16:46:08 +0100
X-Gm-Features: AbW1kvY1Q6s4-03Ic3hBYPuGXV99wbPD42iHvf9Tw3ShFrSa5uqs9q-bXf_bX2c
Message-ID: <CAMXpfWtCROG-CyJWR1qM4k12dpRhKY92g3Mn74nokV_V-U+-cg@mail.gmail.com>
Subject: Re: [PATCH v5] ksm: add ksm involvement information for each process
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	wang.yaxin@zte.com.cn, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch has been successfully tested. After starting the KSM and
obtaining the PID of a process, e.g. qemu-kvm PID, now the new items
can be checked.

echo 1 > /sys/kernel/mm/ksm/run
pid=3D$(pgrep -f "qemu-kvm")
cat /proc/$pid/ksm_stat
ksm_rmap_items 70692
ksm_zero_pages 0
ksm_merging_pages 4211
ksm_process_profit 12723968
ksm_merge_any: no
ksm_mergeable: yes

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Fri, Jan 10, 2025 at 10:52=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> From: xu xin <xu.xin16@zte.com.cn>
>
> In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
> KSM_mergeable and KSM_merge_any. It helps administrators to
> better know the system's KSM behavior at process level.
>
> ksm_merge_any: yes/no
>         whether the process'mm is added by prctl() into the candidate lis=
t
>         of KSM or not, and fully enabled at process level.
>
> ksm_mergeable: yes/no
>     whether any VMAs of the process'mm are currently applicable to KSM.
>
> Purpose
> =3D=3D=3D=3D=3D=3D=3D
> These two items are just to improve the observability of KSM at process
> level, so that users can know if a certain process has enable KSM.
>
> For example, if without these two items, when we look at
> /proc/<pid>/ksm_stat and there's no merging pages found, We are not sure
> whether it is because KSM was not enabled or because KSM did not
> successfully merge any pages.
>
> Althrough "mg" in /proc/<pid>/smaps indicate VM_MERGEABLE, it's opaque
> and not very obvious for non professionals.
>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
> ---
> Changelog v4 -> v5:
> 1. Update the documentation.
> 2. Correct a comment sentence and add purpose statment in commit message.
> ---
>  Documentation/filesystems/proc.rst | 66 ++++++++++++++++++++++++++++++++=
++++++
>  fs/proc/base.c                     | 11 +++++++
>  include/linux/ksm.h                |  1 +
>  mm/ksm.c                           | 19 +++++++++++
>  4 files changed, 97 insertions(+)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
> index 6a882c57a7e7..916f83203de0 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -48,6 +48,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold=
.net>    June 9 2009
>    3.11 /proc/<pid>/patch_state - Livepatch patch operation state
>    3.12 /proc/<pid>/arch_status - Task architecture specific information
>    3.13  /proc/<pid>/fd - List of symlinks to open files
> +  3.14  /proc/<pid/ksm_stat - Information about the process' ksm status.
>
>    4    Configuring procfs
>    4.1  Mount options
> @@ -2232,6 +2233,71 @@ The number of open files for the process is stored=
 in 'size' member
>  of stat() output for /proc/<pid>/fd for fast access.
>  -------------------------------------------------------
>
> +3.14 /proc/<pid/ksm_stat - Information about the process' ksm status
> +--------------------------------------------------------------------
> +When CONFIG_KSM is enabled, each process has this file which displays
> +the information of ksm merging status.
> +
> +Example
> +~~~~~~~
> +
> +::
> +
> +    / # cat /proc/self/ksm_stat
> +    ksm_rmap_items 0
> +    ksm_zero_pages 0
> +    ksm_merging_pages 0
> +    ksm_process_profit 0
> +    ksm_merge_any: no
> +    ksm_mergeable: no
> +
> +Description
> +~~~~~~~~~~~
> +
> +ksm_rmap_items
> +^^^^^^^^^^^^^^
> +
> +The number of ksm_rmap_item structure in use. The structure of
> +ksm_rmap_item is to store the reverse mapping information for virtual
> +addresses. KSM will generate a ksm_rmap_item for each ksm-scanned page
> +of the process.
> +
> +ksm_zero_pages
> +^^^^^^^^^^^^^^
> +
> +When /sys/kernel/mm/ksm/use_zero_pages is enabled, it represent how many
> +empty pages are merged with kernel zero pages by KSM.
> +
> +ksm_merging_pages
> +^^^^^^^^^^^^^^^^^
> +
> +It represents how many pages of this process are involved in KSM merging
> +(not including ksm_zero_pages). It is the same with what
> +/proc/<pid>/ksm_merging_pages shows.
> +
> +ksm_process_profit
> +^^^^^^^^^^^^^^^^^^
> +
> +The profit that KSM brings (Saved bytes). KSM can save memory by merging
> +identical pages, but also can consume additional memory, because it need=
s
> +to generate a number of rmap_items to save each scanned page's brief rma=
p
> +information. Some of these pages may be merged, but some may not be able=
d
> +to be merged after being checked several times, which are unprofitable
> +memory consumed.
> +
> +ksm_merge_any
> +^^^^^^^^^^^^^
> +
> +It specifies whether the process'mm is added by prctl() into the candida=
te list
> +of KSM or not, and KSM scanning is fully enabled at process level.
> +
> +ksm_mergeable
> +^^^^^^^^^^^^^
> +
> +It specifies whether any VMAs of the process'mm are currently applicable=
 to KSM.
> +
> +More information about KSM can be found at Documentation/admin-guide/mm/=
ksm.rst.
> +
>
>  Chapter 4: Configuring procfs
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 0edf14a9840e..a50b222a5917 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3269,6 +3269,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, st=
ruct pid_namespace *ns,
>                                 struct pid *pid, struct task_struct *task=
)
>  {
>         struct mm_struct *mm;
> +       int ret =3D 0;
>
>         mm =3D get_task_mm(task);
>         if (mm) {
> @@ -3276,6 +3277,16 @@ static int proc_pid_ksm_stat(struct seq_file *m, s=
truct pid_namespace *ns,
>                 seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(m=
m));
>                 seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_=
pages);
>                 seq_printf(m, "ksm_process_profit %ld\n", ksm_process_pro=
fit(mm));
> +               seq_printf(m, "ksm_merge_any: %s\n",
> +                               test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? =
"yes" : "no");
> +               ret =3D mmap_read_lock_killable(mm);
> +               if (ret) {
> +                       mmput(mm);
> +                       return ret;
> +               }
> +               seq_printf(m, "ksm_mergeable: %s\n",
> +                               ksm_process_mergeable(mm) ? "yes" : "no")=
;
> +               mmap_read_unlock(mm);
>                 mmput(mm);
>         }
>
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 6a53ac4885bb..d73095b5cd96 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -93,6 +93,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct f=
olio *folio);
>  void collect_procs_ksm(const struct folio *folio, const struct page *pag=
e,
>                 struct list_head *to_kill, int force_early);
>  long ksm_process_profit(struct mm_struct *);
> +bool ksm_process_mergeable(struct mm_struct *mm);
>
>  #else  /* !CONFIG_KSM */
>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 7ac59cde626c..be2eb1778225 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -3263,6 +3263,25 @@ static void wait_while_offlining(void)
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>
>  #ifdef CONFIG_PROC_FS
> +/*
> + * The process is mergeable only if any VMA is currently
> + * applicable to KSM.
> + *
> + * The mmap lock must be held in read mode.
> + */
> +bool ksm_process_mergeable(struct mm_struct *mm)
> +{
> +       struct vm_area_struct *vma;
> +
> +       mmap_assert_locked(mm);
> +       VMA_ITERATOR(vmi, mm, 0);
> +       for_each_vma(vmi, vma)
> +               if (vma->vm_flags & VM_MERGEABLE)
> +                       return true;
> +
> +       return false;
> +}
> +
>  long ksm_process_profit(struct mm_struct *mm)
>  {
>         return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PA=
GE_SIZE -
> --
> 2.15.2
>


