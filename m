Return-Path: <linux-fsdevel+bounces-37238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2637A9EFEDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 22:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CD42855E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB11D1D7E5F;
	Thu, 12 Dec 2024 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQjI+KZy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EBC2F2F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040528; cv=none; b=rzpozOHEcO64adwsC8KrhAkge8uq8M1uakFof72Mp/gAFXS/nskxUNGveWoP8kAF2lkjgExGWK59TYxgptpZHDdQfRjAvHLksHDiqWtgtIiwHWu+Rlj5uEGHFGytpah+BvuL28iaKW/fQ6JMc3CEBKkkroyFsqbdMmO8YacQ/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040528; c=relaxed/simple;
	bh=DbkaXIXEzMTZRQFA1Y8c+fJ6+WUxBf3mq7vc1+jCinM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqgvvJxtlt7Du6LU6S3JDQeIg1zFZ1sXVulESkLL4Jrt0r5UuShEKUWAO8deS0jFHwM7c75HiAdevoFkbH/vx86vXKBJ/p/aFVtLvuF62XpIqzaWVLMj9vTP+3AP7tK56QKIj6ISkA22LNFpf58neTNxHSuneEgKSHCuR53sB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQjI+KZy; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467a0a6c9fcso11007891cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 13:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734040525; x=1734645325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYOz2EtXsxscCq7snwg9gISQ03O0oecfZCV5i8i6cfo=;
        b=iQjI+KZyM9NV/2YBBlMGU5PaqBpANSd6Jb0wOPHrLCk/U+fFmZJi0hlDn0tBw9rrJt
         cZsCATWaElLoEMYW7pQDHuG/cB71vbSOF1VscASbttaNwDWpfzGSEdLk8vTcYpVI+fXN
         c41aoZDKt+YwRrOoKAnbDK2SDK8lYhTIUfEIbSNSZV87eHqcT2FBuKXzGaSe3XtTFuqV
         K1ROnSFNVFOgB0XawFmvSf/l/c+ME90io5Bkn6yOkC8c/VB7g+/W7dLnL+d9/Bha72YS
         8OtC7/A2B+LlqB1Xc3fz35dd2fgblQFPFV1flJ6oZkSMbRJ/XF7dSxjW0/MUw/BR0FKX
         19BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734040525; x=1734645325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYOz2EtXsxscCq7snwg9gISQ03O0oecfZCV5i8i6cfo=;
        b=FDZffDATwQfM5kEPSHgOb+jePWYOMOU4oFhoFRyUYEyAMQVlMM7/dpBk2av8Ry6dIG
         G8gWX/qZDwIO1rfn0dqm6FeAoWCHSX2XGn14rGYwUz3GT+c4PeCMZ+EKedH4V5JqIKNi
         nmOeNn101m5RYMHO2VYR3bRX4mtLfM74nzpKCsUefoi/vbQB7zlSFPcw1Mf+s4Bb4oOy
         dayOclcWmD2UD6qMED5xrz8kxTvoQIUbO83fyPuw8oH0XYoKwI4pov9K3grolAkvI/L8
         /Uq6F5zkcEZjb5I7iswn4DmVdGuVviCb1bN6ublaKeIhtRrl/G9yWzfTQnwdr46mM00P
         31pA==
X-Forwarded-Encrypted: i=1; AJvYcCUr6Wrz3UsGnBCIuNL7qsTbcBmqHKYca5Ury3o5ZMrst6Kz2byPhroh+U9WxB8raWPdpkcb8nt369HgToYu@vger.kernel.org
X-Gm-Message-State: AOJu0YxUu3oW4r+cdrl3stsiAOts4SJA0eXKecnMg/mnUoDbOTs0wkzK
	CqMyKs2mpF8wU/+P9edZ117yiirPIOa8B5VfPdq9XsC3z21yY+fej4S8ElQNd3Eluw88JgDIqly
	JvG4u7vJ3Sx9ujusC91yXAOSKZhg=
X-Gm-Gg: ASbGncuK0xjQbBBzYTVG5FCNIiDTnOX7BIYsKmsHlDkj4m1zg3kaf6Yo3Czn4+DHY4h
	Z+t9OwHGO8a3K4WacuOMwukatDZ8xS/H/dwt8pzJgrEDz3sMTIFMg
X-Google-Smtp-Source: AGHT+IFdDU0spNTAwnjdShyrZ8l3zwPUvJqmRzczAM5hgXNB6sFDCRmmBrK5ZHO0603S3eQ6qoGl9iBMyDOZgZ1IyKw=
X-Received: by 2002:a05:622a:304:b0:467:5d0b:c750 with SMTP id
 d75a77b69052e-467a575607fmr3062781cf.22.1734040525424; Thu, 12 Dec 2024
 13:55:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122232359.429647-1-joannelkoong@gmail.com>
In-Reply-To: <20241122232359.429647-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 12 Dec 2024 13:55:14 -0800
Message-ID: <CAJnrk1Z+DfG4T4ANwCDX52eScoFNu8YhEwEPucA_RmOHusg7nA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] fuse: remove temp page copies in writeback
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 3:24=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> The purpose of this patchset is to help make writeback-cache write
> performance in FUSE filesystems as fast as possible.
>
> In the current FUSE writeback design (see commit 3be5a52b30aa
> ("fuse: support writable mmap"))), a temp page is allocated for every dir=
ty
> page to be written back, the contents of the dirty page are copied over t=
o the
> temp page, and the temp page gets handed to the server to write back. Thi=
s is
> done so that writeback may be immediately cleared on the dirty page, and =
this
> in turn is done for two reasons:
> a) in order to mitigate the following deadlock scenario that may arise if
> reclaim waits on writeback on the dirty page to complete (more details ca=
n be
> found in this thread [1]):
> * single-threaded FUSE server is in the middle of handling a request
>   that needs a memory allocation
> * memory allocation triggers direct reclaim
> * direct reclaim waits on a folio under writeback
> * the FUSE server can't write back the folio since it's stuck in
>   direct reclaim
> b) in order to unblock internal (eg sync, page compaction) waits on write=
back
> without needing the server to complete writing back to disk, which may ta=
ke
> an indeterminate amount of time.
>
> Allocating and copying dirty pages to temp pages is the biggest performan=
ce
> bottleneck for FUSE writeback. This patchset aims to get rid of the temp =
page
> altogether (which will also allow us to get rid of the internal FUSE rb t=
ree
> that is needed to keep track of writeback status on the temp pages).
> Benchmarks show approximately a 20% improvement in throughput for 4k
> block-size writes and a 45% improvement for 1M block-size writes.
>
> With removing the temp page, writeback state is now only cleared on the d=
irty
> page after the server has written it back to disk. This may take an
> indeterminate amount of time. As well, there is also the possibility of
> malicious or well-intentioned but buggy servers where writeback may in th=
e
> worst case scenario, never complete. This means that any
> folio_wait_writeback() on a dirty page belonging to a FUSE filesystem nee=
ds to
> be carefully audited.
>
> In particular, these are the cases that need to be accounted for:
> * potentially deadlocking in reclaim, as mentioned above
> * potentially stalling sync(2)
> * potentially stalling page migration / compaction
>
> This patchset adds a new mapping flag, AS_WRITEBACK_INDETERMINATE, which
> filesystems may set on its inode mappings to indicate that writeback
> operations may take an indeterminate amount of time to complete. FUSE wil=
l set
> this flag on its mappings. This patchset adds checks to the critical part=
s of
> reclaim, sync, and page migration logic where writeback may be waited on.
>
> Please note the following:
> * For sync(2), waiting on writeback will be skipped for FUSE, but this ha=
s no
>   effect on existing behavior. Dirty FUSE pages are already not guarantee=
d to
>   be written to disk by the time sync(2) returns (eg writeback is cleared=
 on
>   the dirty page but the server may not have written out the temp page to=
 disk
>   yet). If the caller wishes to ensure the data has actually been synced =
to
>   disk, they should use fsync(2)/fdatasync(2) instead.
> * AS_WRITEBACK_INDETERMINATE does not indicate that the folios should nev=
er be
>   waited on when in writeback. There are some cases where the wait is
>   desirable. For example, for the sync_file_range() syscall, it is fine t=
o
>   wait on the writeback since the caller passes in a fd for the operation=
.
>
> [1]
> https://lore.kernel.org/linux-kernel/495d2400-1d96-4924-99d3-8b2952e05fc3=
@linux.alibaba.com/
>
> Changelog
> ---------
> v5:
> https://lore.kernel.org/linux-fsdevel/20241115224459.427610-1-joannelkoon=
g@gmail.com/
> Changes from v5 -> v6:
> * Add Shakeel and Jingbo's reviewed-bys
> * Move folio_end_writeback() to fuse_writepage_finish() (Jingbo)
> * Embed fuse_writepage_finish_stat() logic inline (Jingbo)
> * Remove node_stat NR_WRITEBACK inc/sub (Jingbo)
>
> v4:
> https://lore.kernel.org/linux-fsdevel/20241107235614.3637221-1-joannelkoo=
ng@gmail.com/
> Changes from v4 -> v5:
> * AS_WRITEBACK_MAY_BLOCK -> AS_WRITEBACK_INDETERMINATE (Shakeel)
> * Drop memory hotplug patch (David and Shakeel)
> * Remove some more kunnecessary writeback waits in fuse code (Jingbo)
> * Make commit message for reclaim patch more concise - drop part about
>   deadlock and just focus on how it may stall waits
>
> v3:
> https://lore.kernel.org/linux-fsdevel/20241107191618.2011146-1-joannelkoo=
ng@gmail.com/
> Changes from v3 -> v4:
> * Use filemap_fdatawait_range() instead of filemap_range_has_writeback() =
in
>   readahead
>
> v2:
> https://lore.kernel.org/linux-fsdevel/20241014182228.1941246-1-joannelkoo=
ng@gmail.com/
> Changes from v2 -> v3:
> * Account for sync and page migration cases as well (Miklos)
> * Change AS_NO_WRITEBACK_RECLAIM to the more generic AS_WRITEBACK_MAY_BLO=
CK
> * For fuse inodes, set mapping_writeback_may_block only if fc->writeback_=
cache
>   is enabled
>
> v1:
> https://lore.kernel.org/linux-fsdevel/20241011223434.1307300-1-joannelkoo=
ng@gmail.com/T/#t
> Changes from v1 -> v2:
> * Have flag in "enum mapping_flags" instead of creating asop_flags (Shake=
el)
> * Set fuse inodes to use AS_NO_WRITEBACK_RECLAIM (Shakeel)
>
> Joanne Koong (5):
>   mm: add AS_WRITEBACK_INDETERMINATE mapping flag
>   mm: skip reclaiming folios in legacy memcg writeback indeterminate
>     contexts
>   fs/writeback: in wait_sb_inodes(), skip wait for
>     AS_WRITEBACK_INDETERMINATE mappings
>   mm/migrate: skip migrating folios under writeback with
>     AS_WRITEBACK_INDETERMINATE mappings
>   fuse: remove tmp folio for writebacks and internal rb tree
>
>  fs/fs-writeback.c       |   3 +
>  fs/fuse/file.c          | 360 ++++------------------------------------
>  fs/fuse/fuse_i.h        |   3 -
>  include/linux/pagemap.h |  11 ++
>  mm/migrate.c            |   5 +-
>  mm/vmscan.c             |  10 +-
>  6 files changed, 53 insertions(+), 339 deletions(-)
>

Miklos, may I get your thoughts on this patchset?


Thanks,
Joanne

> --
> 2.43.5
>

