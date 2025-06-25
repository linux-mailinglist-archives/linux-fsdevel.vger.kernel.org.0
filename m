Return-Path: <linux-fsdevel+bounces-52975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FADAE903E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A1D176761
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A9C2571DC;
	Wed, 25 Jun 2025 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnvyYqnF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02823C4FD;
	Wed, 25 Jun 2025 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887495; cv=none; b=TWalOkdhhYCIUc3jtSVkQv+wJL6FWlXDgEN4//I2WS/wbXkXCG8F7g7+lqtysTQkwnpq3bZOZWXdNIMyPRmcVtRFP2/RCx64eNgOzpNueB0mo+iUK0h0Wo4jQB8vFAGvOp6JOX/EPCxodi4sUo/sdPCXb51QZaHqU5Ba0UAWIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887495; c=relaxed/simple;
	bh=HH+L8pR8TiXPWL+ZCRhZNIHlxtNoS2CZmDiF2mrWlv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ic4cLNhtw66dKNmxKcIM3dcJg//9OvcAI+2mPa4SnhIhPm+58yN/sIk5emYv44q+ZKbOPLB0WLGznP+8NxkJBGiFGo/BZgC/7YAYLQmkvn04+TGdxVZyG+Lcg6cIVc1z/hMvE6Ft5zyWSMGlykoDXQ1KX8Cjd7uc/0wQdtQx9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnvyYqnF; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a6f3f88613so5327191cf.1;
        Wed, 25 Jun 2025 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750887492; x=1751492292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icS2AouUM5ZODolYe6PBP3Lq/4sYyjlXkKI8jGjPk7c=;
        b=HnvyYqnF5lKymfCUBkhk9/u6v/yGp8q6plOv2x7+p8IMBTPZ9p3qtuG534VqKBOPah
         CLfaDlyqEAUDKK81VFOpi8GthPofzYodwZYTeKPbNbU/VUQ5/AKVtoRtEJjBruch0lsX
         yoOe+PeKJ4INgBJoTvoVyMrHLPkBn0ZJs0HDSn2Kou5obQUpgWo+klL94akoHTjjIRmh
         FVBo8I9+3LTnNpaVdO1ZtqLqZSV4UWQwGe1kku0drSE/jXG3f0SAIFBKwFcaZnEhzBFS
         UVjn3BiySjEhxgCxAVdi81gQN4CtPRrJ7YM0m496C9UECVeKWT41oMO7gg34/HfD3YPr
         IQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750887492; x=1751492292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icS2AouUM5ZODolYe6PBP3Lq/4sYyjlXkKI8jGjPk7c=;
        b=cFJof8SrCcTUrex1J7Ow2w45Tj3fAJpthYn7qPFC9xbyIob7EB+lnzXff/hgLE8YPR
         3EFzRwOwrkqKd7pZGQaCDLKi/Ln49kgcQ56v9eNFmp+g7AZo9OK41JnwMgHpmdAA2Q73
         UxV6Q6K4BiFOuaaRwApeBsBq+tf+myzwhaIHj6gjgHtUCbxcZGZWo/dcVtXwfGgO5RLX
         B4SbQBksVVXLms0pNYwrGKvXlON3eGlVxcVPyPlGCK3GaLsIbZ4NtC0ydXX2RigmSQwY
         LIsRcTiP4RZXDr8LN8kVy5DYSv9nklprye5stC8v0mpOQlcVjorEflkDBAVF91d0Mour
         WaNA==
X-Forwarded-Encrypted: i=1; AJvYcCUaw7H/kJbgar1SOxzLS209u/Y+9/JwnYyLtjo/X4y/hYnOsY68HHhFxz1azl9esorjLsTrDhiKqsV5ft/I3w==@vger.kernel.org, AJvYcCVFYmmHSy2fMbfVj5Pb+qjvYCRq1rx72dHNs78kgCzFy7t/uYHXmuo2SnQpHBqWCyUoJxbdjwLpV168bhQm@vger.kernel.org, AJvYcCWc2uqKt7LkvyJympELfNBNK2n5gO21d80jUUqhkEzvp7bzp1g0Cqv3BDTQmiqWtnENwouvnzeeOz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkkrX458savcmujNOmnN06yQYbDMFgCT5YR7Sg1mWJV+5tbVg0
	2CtIu1oLrqsSS8ddkfFx6wf0YGVAUWaARn9iVBhUxmpFcGQQm4M69fPUpGr6wle1yzXaJoZAdZI
	yKobRG71hc/xQXD3+roqTBRkeeAbu8Sg=
X-Gm-Gg: ASbGncssRTfplS++PZ4o+SJw0HU8mwtkDYGvzQROVbTsbf+/A086y89YZOdVqitx+z+
	UQ/izyqLLKxaamHJo7juVxIzHEWXuXFO0QSX0jAodffE3xHzH8Cpn8T1xbsClJPdwLlkX9oF1Mx
	sgUlXCTgEt+y43hr/XiMgDSyMI5wSBAXLUC9l67r4NEHbNMa98Sv+04Rgi3F0=
X-Google-Smtp-Source: AGHT+IFZIWsQIXMMcF1W41F7hsUCeEsozAHsACSm5zeGcSmEWqHzYmyUffMSAGUNEkq5Ztg6G/bA9j5d7XROB0GK+2g=
X-Received: by 2002:a05:622a:1915:b0:4a5:a447:679f with SMTP id
 d75a77b69052e-4a7c06d9718mr82122501cf.22.1750887492397; Wed, 25 Jun 2025
 14:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625-nr_writeback_removal-v1-1-7f2a0df70faa@suse.cz>
In-Reply-To: <20250625-nr_writeback_removal-v1-1-7f2a0df70faa@suse.cz>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 25 Jun 2025 14:38:01 -0700
X-Gm-Features: Ac12FXwlVDGHlUh4l_DXXilyT7E1Aq8TPPOR9-Jjm7VABkUY-VOx1-0jVSkO8zs
Message-ID: <CAJnrk1YcA9MBC+KQdLE7B-CspoO5=xjkAf78swP6Q6UPijJaug@mail.gmail.com>
Subject: Re: [PATCH] mm, vmstat: remove the NR_WRITEBACK_TEMP node_stat_item counter
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>, 
	Maxim Patlasov <mpatlasov@parallels.com>, Jan Kara <jack@suse.cz>, 
	"Zach O'Keefe" <zokeefe@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Jeff Layton <jlayton@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 8:51=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> The only user of the counter (FUSE) was removed in commit 0c58a97f919c
> ("fuse: remove tmp folio for writebacks and internal rb tree") so follow
> the established pattern of removing the counter and hardcoding 0 in
> meminfo output, as done recently with NR_BOUNCE. Update documentation
> for procfs, including for the value for Bounce that was missed when
> removing its counter.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> The removal of the counter is straightforward. The reason for the large
> Cc list is that there is a comment in mm/page-writeback.c function
> wb_position_ratio() that mentions NR_WRITEBACK_TEMP, and just deleting
> the sentence feels to me it could be the wrong thing to do - maybe the
> strictlimit feature itself is now obsolete? It sure does mention FUSE
> as the main reason to exist, but commit 5a53748568f79 that introduced it
> also mentions slow USB sticks as a possibile scenario. Has that
> happened? I'm not familiar enough with this so I'd rather highlight this
> and ask for input here than make "git grep NR_WRITEBACK_TEMP" return
> nothing.

My understanding is that even without the fuse use case, strictlimit
is still used for other devices via the /sys/class/bdi interface (eg
/sys/class/bdi/<bdi>/strict_limit) so I don't think the feature itself
is obsolete.

It's not clear to me whether fuse still needs strictlimit now that it
doesn't have tmp writeback pages, but it'd be great to get an answer
to this, as strictlimit currently leads to too much dirty throttling
when large folios are enabled in fuse.

> ---
>  Documentation/filesystems/proc.rst | 8 +++++---
>  drivers/base/node.c                | 2 +-
>  fs/proc/meminfo.c                  | 3 +--
>  include/linux/mmzone.h             | 1 -
>  mm/show_mem.c                      | 2 --
>  mm/vmstat.c                        | 1 -
>  6 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
> index 5236cb52e357dcd00496b26be8578e1dec0a345e..2971551b7235345c9a7ec3c84=
a87a16adcda5901 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1196,12 +1196,14 @@ SecPageTables
>                Memory consumed by secondary page tables, this currently i=
ncludes
>                KVM mmu and IOMMU allocations on x86 and arm64.
>  NFS_Unstable
> -              Always zero. Previous counted pages which had been written=
 to
> +              Always zero. Previously counted pages which had been writt=
en to
>                the server, but has not been committed to stable storage.
>  Bounce
> -              Memory used for block device "bounce buffers"
> +              Always zero. Previously memory used for block device
> +              "bounce buffers".
>  WritebackTmp
> -              Memory used by FUSE for temporary writeback buffers
> +              Always zero. Previously memory used by FUSE for temporary
> +              writeback buffers.
>  CommitLimit
>                Based on the overcommit ratio ('vm.overcommit_ratio'),
>                this is the total amount of  memory currently available to
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 6d66382dae6533a0c8481f72ad67c35021e331d3..e434cb260e6182468e0d617b5=
59134c6fbe128f4 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -500,7 +500,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>                              nid, K(node_page_state(pgdat, NR_SECONDARY_P=
AGETABLE)),
>                              nid, 0UL,
>                              nid, 0UL,
> -                            nid, K(node_page_state(pgdat, NR_WRITEBACK_T=
EMP)),
> +                            nid, 0UL,
>                              nid, K(sreclaimable +
>                                     node_page_state(pgdat, NR_KERNEL_MISC=
_RECLAIMABLE)),
>                              nid, K(sreclaimable + sunreclaimable),
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index bc2bc60c36ccc1dab8913913056f5ff20b448490..a458f1e112fdbc63019239a79=
ce39c5576b5f963 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -121,8 +121,7 @@ static int meminfo_proc_show(struct seq_file *m, void=
 *v)
>
>         show_val_kb(m, "NFS_Unstable:   ", 0);
>         show_val_kb(m, "Bounce:         ", 0);
> -       show_val_kb(m, "WritebackTmp:   ",
> -                   global_node_page_state(NR_WRITEBACK_TEMP));
> +       show_val_kb(m, "WritebackTmp:   ", 0);
>         show_val_kb(m, "CommitLimit:    ", vm_commit_limit());
>         show_val_kb(m, "Committed_AS:   ", committed);
>         seq_printf(m, "VmallocTotal:   %8lu kB\n",
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 1d1bb2b7f40d25b430932c9ef9096d97bf1c29de..0c5da9141983b795018c0aa24=
57b065507416564 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -206,7 +206,6 @@ enum node_stat_item {
>         NR_FILE_PAGES,
>         NR_FILE_DIRTY,
>         NR_WRITEBACK,
> -       NR_WRITEBACK_TEMP,      /* Writeback using temporary buffers */
>         NR_SHMEM,               /* shmem pages (included tmpfs/GEM pages)=
 */
>         NR_SHMEM_THPS,
>         NR_SHMEM_PMDMAPPED,
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index 0cf8bf5d832d6b339b4c9a6c7b8b3ab41683bcfe..41999e94a56d623726ea92f3f=
38785e8b218afe5 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -246,7 +246,6 @@ static void show_free_areas(unsigned int filter, node=
mask_t *nodemask, int max_z
>                         " shmem_pmdmapped:%lukB"
>                         " anon_thp:%lukB"
>  #endif
> -                       " writeback_tmp:%lukB"
>                         " kernel_stack:%lukB"
>  #ifdef CONFIG_SHADOW_CALL_STACK
>                         " shadow_call_stack:%lukB"
> @@ -273,7 +272,6 @@ static void show_free_areas(unsigned int filter, node=
mask_t *nodemask, int max_z
>                         K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
>                         K(node_page_state(pgdat, NR_ANON_THPS)),
>  #endif
> -                       K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
>                         node_page_state(pgdat, NR_KERNEL_STACK_KB),
>  #ifdef CONFIG_SHADOW_CALL_STACK
>                         node_page_state(pgdat, NR_KERNEL_SCS_KB),
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index c3114b8826e4c3b6969fd4af4b0cd32173c42d7b..e0fcd9057f344170b2dc5c82b=
eafea4ec18359bb 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1251,7 +1251,6 @@ const char * const vmstat_text[] =3D {
>         [I(NR_FILE_PAGES)]                      =3D "nr_file_pages",
>         [I(NR_FILE_DIRTY)]                      =3D "nr_dirty",
>         [I(NR_WRITEBACK)]                       =3D "nr_writeback",
> -       [I(NR_WRITEBACK_TEMP)]                  =3D "nr_writeback_temp",
>         [I(NR_SHMEM)]                           =3D "nr_shmem",
>         [I(NR_SHMEM_THPS)]                      =3D "nr_shmem_hugepages",
>         [I(NR_SHMEM_PMDMAPPED)]                 =3D "nr_shmem_pmdmapped",
>
> ---
> base-commit: 4216fd45fc9156da0ee33fcb25cc0a5265049e32
> change-id: 20250625-nr_writeback_removal-4eca139cf09a
>
> Best regards,
> --
> Vlastimil Babka <vbabka@suse.cz>
>

