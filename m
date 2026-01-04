Return-Path: <linux-fsdevel+bounces-72365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F08ECF1386
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 19:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B755300E7B1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9A5288C26;
	Sun,  4 Jan 2026 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS2Q0IVc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B83A26E6F0
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jan 2026 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552268; cv=none; b=TFS1ShF8h8SYRf0bVeCMWb77/J+flijIZthdFfFuEja7lUSxa7WIeAnTjlS0US9BNVKGwFH+4HOl9oPfeDHtKDacA7vRLkuF1ZiRqW+WbOWYs/h2MoQ0km+2Iun6DEKNKaZNkVAFtN0OmsEicUZCl8IeQbY9+lrZ5Saoih/rfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552268; c=relaxed/simple;
	bh=aXHrPbVk55wUDS0cKNhqT2+IHruxnpWg181ytScV9uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfMpXwYMaVs6f8fb6mJdgXVEOz53qer5Wj8ulCf+i+3Wm4KBVzUKg997DhaT/dFtWp/ANk0mAB6i8EhRG89s3+Gm2OkrD6ZnVEyQqHIPmebEXs/sOTLgfeCNkY4LCYDSvVpZ6VBUxs5iuA6Ku59KCCBNDDGekVEuvP7X2P7/5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS2Q0IVc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64d2c50f0d6so17076733a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jan 2026 10:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767552265; x=1768157065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfDs7DqszebnHmL46L7VaAm03Q1xsOVYA4XooF/3n1A=;
        b=JS2Q0IVcxU9RWA0ypCnsnw2ZO2YV/eOGxUa/Kt8ZgyxxZhycix7igeLXDYeU6elWuf
         bje+DRdIANw0dvwxRN5PK+36xLbet11EoKEAhvY5lUQUicSWd5xqHLbf9m824Vr5qdiv
         IiHy+3zlNLo8DmvNvK2nknOuH/WephfjuTJ2ZberwdA6taie2cIMe0WduH2yPSdn9S5e
         rXFOByKPJFyRMS5GzhMcr7+W1CiD8/EZgt8xgEMgbUfXzAKaloVr2yY+V1n1daWqtEHP
         /ppAMTqhBdd0ZmARzjprseGG834O5W+SW7Qu3X3QzHBKLn/D+JmxboyjZ2hbWkt4LbS3
         e0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767552265; x=1768157065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TfDs7DqszebnHmL46L7VaAm03Q1xsOVYA4XooF/3n1A=;
        b=AJUOUBzYNYTjwekZ8qHmOpS/0+3scH7h/ATgzZ/4x2JeqyXMLHQmGmFA/Dc3bCsJlP
         yDcF9cDVS9NIaca3d2dJNMjQOARSK8WmWsPl5mOS+LXXzw8/ITf0wkIR5bO7GulSRUjZ
         meQXnMvCo1YHAV4KSIjmmtHvLEVq6KAdDEGIx69Q69aDDdM1zrNfudlh2U+N57GPX8L7
         zjFXfPbb4i0JLyUukRdlQRz5oSoljn5nZyxw1L5WwHRsliI7bTI/ZA9lXS1wymVOVFiy
         8ScSRKFzmwAvJwZIyUY/6hpka5YzuitTnA57qvyfarn5Go6fkAMEUgpDAiFVABl+huRS
         uu0w==
X-Forwarded-Encrypted: i=1; AJvYcCVND8TeTN5Ws8RKCeie7d3atvP3fCxtowEj0oR7PQps5efbabJxu2W7E1yPaxkHGlcD6k5/3n5xVe6+v17C@vger.kernel.org
X-Gm-Message-State: AOJu0YwNiHUIp6RG3hJhhPoBYXy6wsQi/hFb5svO4SKbjkXX6n+dp1f/
	iwzM6iT3r0hGRBzSnB++opkGx0zO2yvSIXLnuVesxDUsqn7Ft5Am/cQkb7KBz2160nveGyeO0o5
	M2m9ZYSPzZ7x3v7ZRbuxjHJhDDvi17HA=
X-Gm-Gg: AY/fxX7WpBbM9hBTxzy5J2iFjLZ7S5hw9yAPob0Q48IphYk+TjhyZVpm50ZMLPgYZSp
	UEb5F5myNO3aC1g97L2jPUZGlrHSYHCSrP4fUt1bZBra5S0OZBaMiKjBcJjmEsmcDl8Uk5cXC1G
	ZqvQPCE5OYkS5vVewT35LY5LmVFK/p3+9R6yfqP2x/xPbfV+j8pSysFDbHXeQQPEmEQFgjLIpbF
	TIkFjuKGjAHZCSZNTeJz28uM1HDUagPbR/HL5k+sz3g3zLEPv07dya8sIBlGwn/8+rpIDYbkWs+
	0aHCY9aPboCjY3Y6BYYUmQPhA3RtXg==
X-Google-Smtp-Source: AGHT+IGobmM075+9PECiT3+qYwobmHJ0zTC9/9avV8VAIU3rRyNMMeFz3HbbmzkfcqL0GyWgMp94xrmkcc3prZ+LRl4=
X-Received: by 2002:a05:6402:13ca:b0:64d:e1c:4c0a with SMTP id
 4fb4d7f45d1cf-64d0e1c4d98mr50289922a12.0.1767552264317; Sun, 04 Jan 2026
 10:44:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231204225.2752893-1-hsiangkao@linux.alibaba.com>
 <CAOQ4uxjjxUHr3Tkxo9PkrBUPcYG1C309cYA9EEvk1-oVGcV_Og@mail.gmail.com>
 <18246672-2c4f-415e-8667-2f826eb4fe19@linux.alibaba.com> <CAOQ4uxgWc7sVwikg3uV0Ey0rrGG+X_a5JLkK-bBFpQSAEeTSVw@mail.gmail.com>
 <2a7ab37a-7293-4083-82f8-f4022a6fa35e@linux.alibaba.com>
In-Reply-To: <2a7ab37a-7293-4083-82f8-f4022a6fa35e@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 4 Jan 2026 20:44:13 +0200
X-Gm-Features: AQt7F2qnxZnEfgl9eiTfTcbXZzOaOHnxjc1yu79QWS-aXZuyZlu_RwI74eJ-ZbY
Message-ID: <CAOQ4uxhBM-rKQsV-S78G0b_aTTYbeXdt-mCiy7GcC4WSdn-NnQ@mail.gmail.com>
Subject: Re: [PATCH] erofs: don't bother with s_stack_depth increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	Alexander Larsson <alexl@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 11:42=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2026/1/4 18:01, Amir Goldstein wrote:
> > [+fsdevel][+overlayfs]
> >
> > On Sun, Jan 4, 2026 at 4:56=E2=80=AFAM Gao Xiang <hsiangkao@linux.aliba=
ba.com> wrote:
> >>
> >> Hi Amir,
> >>
> >> On 2026/1/1 23:52, Amir Goldstein wrote:
> >>> On Wed, Dec 31, 2025 at 9:42=E2=80=AFPM Gao Xiang <hsiangkao@linux.al=
ibaba.com> wrote:
> >>>>
> >>>> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stack=
ing
> >>>> for file-backed mounts") bumped `s_stack_depth` by one to avoid kern=
el
> >>>> stack overflow, but it breaks composefs mounts, which need erofs+ovl=
^2
> >>>> sometimes (and such setups are already used in production for quite =
long
> >>>> time) since `s_stack_depth` can be 3 (i.e., FILESYSTEM_MAX_STACK_DEP=
TH
> >>>> needs to change from 2 to 3).
> >>>>
> >>>> After a long discussion on GitHub issues [1] about possible solution=
s,
> >>>> it seems there is no need to support nesting file-backed mounts as o=
ne
> >>>> conclusion (especially when increasing FILESYSTEM_MAX_STACK_DEPTH to=
 3).
> >>>> So let's disallow this right now, since there is always a way to use
> >>>> loopback devices as a fallback.
> >>>>
> >>>> Then, I started to wonder about an alternative EROFS quick fix to
> >>>> address the composefs mounts directly for this cycle: since EROFS is=
 the
> >>>> only fs to support file-backed mounts and other stacked fses will ju=
st
> >>>> bump up `FILESYSTEM_MAX_STACK_DEPTH`, just check that `s_stack_depth=
`
> >>>> !=3D 0 and the backing inode is not from EROFS instead.
> >>>>
> >>>> At least it works for all known file-backed mount use cases (compose=
fs,
> >>>> containerd, and Android APEX for some Android vendors), and the fix =
is
> >>>> self-contained.
> >>>>
> >>>> Let's defer increasing FILESYSTEM_MAX_STACK_DEPTH for now.
> >>>>
> >>>> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file=
-backed mounts")
> >>>> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 =
[1]
> >>>> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=3D+JP_-JjARWjo6OwcvBj1=
wtYN=3Dz0QXwCpec9sXtg@mail.gmail.com
> >>>> Cc: Amir Goldstein <amir73il@gmail.com>
> >>>> Cc: Alexander Larsson <alexl@redhat.com>
> >>>> Cc: Christian Brauner <brauner@kernel.org>
> >>>> Cc: Miklos Szeredi <mszeredi@redhat.com>
> >>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >>>> ---
> >>>
> >>> Acked-by: Amir Goldstein <amir73il@gmail.com>
> >>>
> >>> But you forgot to include details of the stack usage analysis you ran
> >>> with erofs+ovl^2 setup.
> >>>
> >>> I am guessing people will want to see this information before relaxin=
g
> >>> s_stack_depth in this case.
> >>
> >> Sorry I didn't check emails these days, I'm not sure if posting
> >> detailed stack traces are useful, how about adding the following
> >> words:
> >
> > Didn't mean detailed stack traces, but you did some tests with the
> > new possible setup and you reached stack usage < 8K so  I think this is
>
> The issue is that my limited stress test setup cannot cover
> every cases:
>
>   - I cannot find a way to make direct reclaim reliably in the
>     deep memory allocation, is there some suggestion on this?
>
>   - I'm not sure what's the perfered way to evaluate the worst
>     stack usage below the block layer, but we should care more
>     about increasing delta just out of one more overlayfs I
>     guess?
>
> I can only say what I've seen is the peak stack usage of my
> fsstress for an erofs+ovl^2 setup on x86_64 is < 8K (7184 bytes,
> but I don't think the peak value absolutely useful), which
> evaluates RW workloads in the upperdir, and for such workloads,
> the stack depth won't be impacted by FILESYSTEM_MAX_STACK_DEPTH,
> I don't see such workload is harmful.
>
> And then I manually copyup some files (because I didn't find any
> available tool to stress overlayfs copyups) and I could see the
> delta is (I think "ovl_copy_up_" is the only one path to do
> copyups):
>
>    0)     6688      48   mempool_alloc_slab+0x9/0x20
>    1)     6640      56   mempool_alloc_noprof+0x65/0xd0
>    2)     6584      72   __sg_alloc_table+0x128/0x190
>    3)     6512      40   sg_alloc_table_chained+0x46/0xa0
>    4)     6472      64   scsi_alloc_sgtables+0x91/0x2c0
>    5)     6408      72   sd_init_command+0x263/0x930
>    6)     6336      88   scsi_queue_rq+0x54a/0xb70
>    7)     6248     144   blk_mq_dispatch_rq_list+0x265/0x6c0
>    8)     6104     144   __blk_mq_sched_dispatch_requests+0x399/0x5c0
>    9)     5960      16   blk_mq_sched_dispatch_requests+0x2d/0x70
>   10)     5944      56   blk_mq_run_hw_queue+0x208/0x290
>   11)     5888      96   blk_mq_dispatch_list+0x13f/0x460
>   12)     5792      48   blk_mq_flush_plug_list+0x4b/0x180
>   13)     5744      32   blk_add_rq_to_plug+0x3d/0x160
>   14)     5712     136   blk_mq_submit_bio+0x4f4/0x760
>   15)     5576     120   __submit_bio+0x9b/0x240
>   16)     5456      88   submit_bio_noacct_nocheck+0x271/0x330
>   17)     5368      72   iomap_bio_read_folio_range+0xde/0x1d0
>   18)     5296     112   iomap_read_folio_iter+0x1ee/0x2d0
>   19)     5184     264   iomap_readahead+0xb9/0x290
>   20)     4920      48   xfs_vm_readahead+0x4a/0x70
>   21)     4872     112   read_pages+0x6c/0x1b0
>   22)     4760     104   page_cache_ra_unbounded+0x12c/0x210
>   23)     4656      80   filemap_readahead.isra.0+0x78/0xb0
>   24)     4576     192   filemap_get_pages+0x3a6/0x820
>   25)     4384     376   filemap_read+0xde/0x380
>   26)     4008      32   xfs_file_buffered_read+0xa6/0xd0
>   27)     3976      16   xfs_file_read_iter+0x6a/0xd0
>   28)     3960      48   vfs_iocb_iter_read+0xdb/0x140
>   29)     3912      88   erofs_fileio_rq_submit+0x136/0x190
>   30)     3824     368   z_erofs_runqueue+0x1ce/0x9f0
>   31)     3456     232   z_erofs_readahead+0x16c/0x220
>   32)     3224     112   read_pages+0x6c/0x1b0
>   33)     3112     104   page_cache_ra_unbounded+0x12c/0x210
>   34)     3008      80   filemap_readahead.isra.0+0x78/0xb0
>   35)     2928     192   filemap_get_pages+0x3a6/0x820
>   36)     2736     400   filemap_splice_read+0x12c/0x2f0
>   37)     2336      48   backing_file_splice_read+0x3f/0x90
>   38)     2288     128   ovl_splice_read+0xef/0x170
>   39)     2160     104   splice_direct_to_actor+0xb9/0x260
>   40)     2056      88   do_splice_direct+0x76/0xc0
>   41)     1968     120   ovl_copy_up_file+0x1a8/0x2b0
>   42)     1848     840   ovl_copy_up_one+0x14b0/0x1610
>   43)     1008      72   ovl_copy_up_flags+0xd7/0x110
>   44)      936      56   ovl_open+0x72/0x110
>   45)      880      56   do_dentry_open+0x16c/0x480
>   46)      824      40   vfs_open+0x2e/0xf0
>   47)      784     152   path_openat+0x80a/0x12e0
>   48)      632     296   do_filp_open+0xb8/0x160
>   49)      336      80   do_sys_openat2+0x72/0xf0
>   50)      256      40   __x64_sys_openat+0x57/0xa0
>   51)      216      40   do_syscall_64+0xa4/0x310
>   52)      176     176   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> And it's still far from the stack overflow of 16k stacks,
> because the difference seems only how many (
> ovl_splice_read + backing_file_splice_read), and there only takes
> hundreds of bytes for each layer.
>
> Finally I used my own rostress to stress RO workloads, and the
> deepest stack so far is as below (5456 bytes):
>
>    0)     5456      48   arch_scale_cpu_capacity+0x9/0x30
>    1)     5408      16   cpu_util.constprop.0+0x7e/0xe0
>    2)     5392     392   sched_balance_find_src_group+0x29f/0xd30
>    3)     5000     280   sched_balance_rq+0x1b2/0xf10
>    4)     4720     120   pick_next_task_fair+0x23b/0x7b0
>    5)     4600     104   __schedule+0x2bc/0xda0
>    6)     4496      16   schedule+0x27/0xd0
>    7)     4480      24   io_schedule+0x46/0x70
>    8)     4456     120   blk_mq_get_tag+0x11b/0x280
>    9)     4336      96   __blk_mq_alloc_requests+0x2a1/0x410
>   10)     4240     136   blk_mq_submit_bio+0x59c/0x760
>   11)     4104     120   __submit_bio+0x9b/0x240
>   12)     3984      88   submit_bio_noacct_nocheck+0x271/0x330
>   13)     3896      72   iomap_bio_read_folio_range+0xde/0x1d0
>   14)     3824     112   iomap_read_folio_iter+0x1ee/0x2d0
>   15)     3712     264   iomap_readahead+0xb9/0x290
>   16)     3448      48   xfs_vm_readahead+0x4a/0x70
>   17)     3400     112   read_pages+0x6c/0x1b0
>   18)     3288     104   page_cache_ra_unbounded+0x12c/0x210
>   19)     3184      80   filemap_readahead.isra.0+0x78/0xb0
>   20)     3104     192   filemap_get_pages+0x3a6/0x820
>   21)     2912     376   filemap_read+0xde/0x380
>   22)     2536      32   xfs_file_buffered_read+0xa6/0xd0
>   23)     2504      16   xfs_file_read_iter+0x6a/0xd0
>   24)     2488      48   vfs_iocb_iter_read+0xdb/0x140
>   25)     2440      88   erofs_fileio_rq_submit+0x136/0x190
>   26)     2352     368   z_erofs_runqueue+0x1ce/0x9f0
>   27)     1984     232   z_erofs_readahead+0x16c/0x220
>   28)     1752     112   read_pages+0x6c/0x1b0
>   29)     1640     104   page_cache_ra_unbounded+0x12c/0x210
>   30)     1536      40   force_page_cache_ra+0x96/0xc0
>   31)     1496     192   filemap_get_pages+0x123/0x820
>   32)     1304     376   filemap_read+0xde/0x380
>   33)      928      72   do_iter_readv_writev+0x1b9/0x220
>   34)      856      56   vfs_iter_read+0xde/0x140
>   35)      800      64   backing_file_read_iter+0x193/0x1e0
>   36)      736      56   ovl_read_iter+0x98/0xa0
>   37)      680      72   do_iter_readv_writev+0x1b9/0x220
>   38)      608      56   vfs_iter_read+0xde/0x140
>   39)      552      64   backing_file_read_iter+0x193/0x1e0
>   40)      488      56   ovl_read_iter+0x98/0xa0
>   41)      432     152   vfs_read+0x21a/0x350
>   42)      280      64   __x64_sys_pread64+0x92/0xc0
>   43)      216      40   do_syscall_64+0xa4/0x310
>   44)      176     176   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> > something worth mentioning.
> >
> >>
> >> Note: There are some observations while evaluating the erofs + ovl^2
> >> setup with an XFS backing fs:
> >>
> >>    - Regular RW workloads traverse only one overlayfs layer regardless=
 of
> >>      the value of FILESYSTEM_MAX_STACK_DEPTH, because `upperdir=3D` ca=
nnot
> >>      point to another overlayfs.  Therefore, for pure RW workloads, th=
e
> >>      typical stack is always just:
> >>        overlayfs + upper fs + underlay storage
> >>
> >>    - For read-only workloads and the copy-up read part (ovl_splice_rea=
d),
> >>      the difference can lie in how many overlays are nested.
> >>      The stack just looks like either:
> >>        ovl + ovl [+ erofs] + backing fs + underlay storage
> >>      or
> >>        ovl [+ erofs] + ext4/xfs + underlay storage
> >>
> >>    - The fs reclaim path should be entered only once, so the writeback
> >>      path will not re-enter.
> >>
> >> Sorry about my English, and I'm not sure if it's enough (e.g. FUSE
> >> passthrough part).  I will look for your further inputs (and other
> >> acks) before sending this patch upstream.
> >>
> >
> > I think that most people will have problems understanding this
> > rationale not because of the English, but because of the tech ;)
> > this is a bit too hand wavy IMO.
>
> Honestly, I don't have better way to describe it, I think we'd
> better just to focus more on the increment of one more overlayfs:
>

ok. but are we talking about one more overlayfs?
This patch is adding just one erofs, so what am I missing?

> FILESYSTEM_MAX_STACK_DEPTH 2 already works for 8k kstacks on
> 32-bit arches, so I don't think FILESYSTEM_MAX_STACK_DEPTH from
> 2 to 3, which causes hundreds-more-byte additional stack usage
> out of mediate overlayfs on 16k kstacks on 64-bit arches is
> harmful (and only RO workloads and copyups are impacted).
>
> And if hundreds-more-byte additional stack usage can overflow
> the 16k kstack, I do think then the kernel stack can be
> overflowed randomly everywhere in the storage stack, not just
> because this FILESYSTEM_MAX_STACK_DEPTH modification.
>

Fine by me, but does that mean that you only want to allow
erofs backing files with >8K stack size?

Otherwise, I do not follow your argument.

Thanks,
Amir.

