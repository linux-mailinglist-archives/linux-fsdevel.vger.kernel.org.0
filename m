Return-Path: <linux-fsdevel+bounces-67371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB86C3D431
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 20:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 108344E426C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5484E33507F;
	Thu,  6 Nov 2025 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGyOK8Rq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F72286D57
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457914; cv=none; b=pfT4fd/8e5VlhlYOFRsF3qb037GuUHT358c8ZTLrv8Vj0QdQ4eOYhQhkqVcgRatW1GNFpV87vohB70CFLePU2LvqSd0Gg3AOOF+YKNkXm5gzIA1MTUCm2gqRSB4aMpJR2IBzdbt1Q6kffHiv6V1zTGyjeqrlqG63pzAaQtNj/5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457914; c=relaxed/simple;
	bh=htCCclXRRTSfNtzxMezZq4IR7RmLZZSdOeEpdNANtiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXZWv8ebV2xukBLUYPK0lDllcy+axdW/7HqGHjdkRNDBtzI1oiVBqdtN//Bz31PgyOSBlmgYl/fSBt2AOddQfdFVKcQNWo3HqryBu/b6GLGSgG81J2+AMVpQZlEHloChGTDKV6rrxnI7TjFnYg3dnpAX/n0Rq+0wsKsvgfh289k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGyOK8Rq; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed25b29595so14519391cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 11:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762457912; x=1763062712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au4yHmJ+eAAs4ru8qXuzKlpyKvxCeRwM44jREzgs70s=;
        b=DGyOK8Rq7w8VqwKtyMJOyfJP22L769UOwq0InqRtkyjv08hO3Gbl6iLxC9JteYWSUJ
         noNEAWYNKvtdy7/onk2fDsh/Up+y8AS95Bb/mpRBb6vgVZDEksCkn54E2gCRSIj1cqoG
         a9BwLpGmWQlrt9PaRclIDNAR217BIf+kFciUNiDPrtPECHmKXiU7SSv5V8++3BK3QplY
         NyyA09hdgkwOyPioRrEOsl6YU2fZlzEAzxkroT/aB5xyIyTwD7g8GLL6Y96R5pFHvb1V
         66lNmIbq6g6G4nTgXSKvwO0V78xC0UOuaMgWca9Cq6yP+PY0nK50OUCz8JeRCUwINIoY
         KIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457912; x=1763062712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=au4yHmJ+eAAs4ru8qXuzKlpyKvxCeRwM44jREzgs70s=;
        b=iSCqPmLDZQAM8UNxrrk/SWSEu2b7J6CeiCdeHpU161A8ceYUdJb/joBNghaN73MRqY
         lyc7PXChbUjh9DowQvyIq/fz/ca3XNCP0qsIpEmjNkVc3u6PC73d0ACcwAZ2a5wn9H2R
         SLdkwtqCj4dL2mssP1HV65FfSf9jdld2xoRbAg6aF54bnEVa+EHKiA3NBeh+ecwKMTFr
         voQ0FJBbBstuBzgfTPH41Ewk4hEXJj/SgWWrTYqShjXRLgkzWFuhLZule1+FpNW+ErKa
         Y0wUObJX0gKluSOOWeCMoIaTWp2LGxx/n633ACponzobm4YeaXSwmanQSteqWCzuxV5N
         jD+Q==
X-Gm-Message-State: AOJu0YxPdOCaZI/NtHPW/MdMStJA6t2bEfs11Eu+S38hg6JbzZ1WXnbe
	gfJfrJREX7G9FPvWRXoBqb7ncNdxCuJ3LnoMJwV+wSCP3Jiu0k1Vot55m0yDDCVgEaS795syPVB
	alXh4GyaRQJUTpJffg7a8EV4uh7ARxFCjzQ==
X-Gm-Gg: ASbGncvFkmZ1jFrBjNDHwgY3S0VBAhnGIl2TciBIM12uh3U3H4xwy5gHC0qn4pUBasd
	zqgcfXTa5lhG6QeqMbiJIwc3pBJ3sJPEnBVSkD+y6550N4oWqGz8qed/MiMN+5ul0toJKvQsbJo
	TslMq35bA+0ny+C8SSma4DY12DM7U76K+LmS88uLhLgtGyThHI8eVCtmHbtkSGOdfsiryIqtroI
	aQKKPvEVSGbMXZu2X8Wv5Zb7qSAWHA+fn3TshUfWuhGIrn49rRKYkFeBsk4y0fI9B9WECLB1Kq0
	1jwTHdYlRB/yYes=
X-Google-Smtp-Source: AGHT+IEWuUwRQbyqGylienh6BMzwpg/JB6xpNoZMrM6WzCCEIgb/HTUw4nCIOtdkN6F8fo+kCYqfX8RwaSIpr2XFfOg=
X-Received: by 2002:a05:622a:1187:b0:4e6:ee71:ee8f with SMTP id
 d75a77b69052e-4ed9497824fmr6087251cf.23.1762457912044; Thu, 06 Nov 2025
 11:38:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010220738.3674538-1-joannelkoong@gmail.com> <20251010220738.3674538-2-joannelkoong@gmail.com>
In-Reply-To: <20251010220738.3674538-2-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 6 Nov 2025 11:38:21 -0800
X-Gm-Features: AWmQ_bm5GPa9LFrjFiVAhIWylI3ld7gMo3TswYkPgcx-PpS_BfKG1fT-qAMdg0Y
Message-ID: <CAJnrk1YemmKkgTN4a-T7Kc1vtUSJi3GO8bY1BfXWZUKcx6NBtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fuse: fix readahead reclaim deadlock
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, osandov@fb.com, 
	hsiangkao@linux.alibaba.com, kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 3:08=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Commit e26ee4efbc79 ("fuse: allocate ff->release_args only if release is
> needed") skips allocating ff->release_args if the server does not
> implement open. However in doing so, fuse_prepare_release() now skips
> grabbing the reference on the inode, which makes it possible for an
> inode to be evicted from the dcache while there are inflight readahead
> requests. This causes a deadlock if the server triggers reclaim while
> servicing the readahead request and reclaim attempts to evict the inode
> of the file being read ahead. Since the folio is locked during
> readahead, when reclaim evicts the fuse inode and fuse_evict_inode()
> attempts to remove all folios associated with the inode from the page
> cache (truncate_inode_pages_range()), reclaim will block forever waiting
> for the lock since readahead cannot relinquish the lock because it is
> itself blocked in reclaim:
>
> >>> stack_trace(1504735)
>  folio_wait_bit_common (mm/filemap.c:1308:4)
>  folio_lock (./include/linux/pagemap.h:1052:3)
>  truncate_inode_pages_range (mm/truncate.c:336:10)
>  fuse_evict_inode (fs/fuse/inode.c:161:2)
>  evict (fs/inode.c:704:3)
>  dentry_unlink_inode (fs/dcache.c:412:3)
>  __dentry_kill (fs/dcache.c:615:3)
>  shrink_kill (fs/dcache.c:1060:12)
>  shrink_dentry_list (fs/dcache.c:1087:3)
>  prune_dcache_sb (fs/dcache.c:1168:2)
>  super_cache_scan (fs/super.c:221:10)
>  do_shrink_slab (mm/shrinker.c:435:9)
>  shrink_slab (mm/shrinker.c:626:10)
>  shrink_node (mm/vmscan.c:5951:2)
>  shrink_zones (mm/vmscan.c:6195:3)
>  do_try_to_free_pages (mm/vmscan.c:6257:3)
>  do_swap_page (mm/memory.c:4136:11)
>  handle_pte_fault (mm/memory.c:5562:10)
>  handle_mm_fault (mm/memory.c:5870:9)
>  do_user_addr_fault (arch/x86/mm/fault.c:1338:10)
>  handle_page_fault (arch/x86/mm/fault.c:1481:3)
>  exc_page_fault (arch/x86/mm/fault.c:1539:2)
>  asm_exc_page_fault+0x22/0x27
>
> Fix this deadlock by allocating ff->release_args and grabbing the
> reference on the inode when preparing the file for release even if the
> server does not implement open. The inode reference will be dropped when
> the last reference on the fuse file is dropped (see fuse_file_put() ->
> fuse_release_end()).
>
> Fixes: e26ee4efbc79 ("fuse: allocate ff->release_args only if release is =
needed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reported-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/fuse/file.c | 40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)

Miklos, does this approach look okay to you?

Thanks,
Joanne

