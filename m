Return-Path: <linux-fsdevel+bounces-63043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E1BAA293
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B99E1922F08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 17:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABF830BBA2;
	Mon, 29 Sep 2025 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVws92ay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5741E21257F
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166739; cv=none; b=J3Q04EXrV0ppjClpFFYZsWt4odWyKMJLUF2duYvuEDG+nzQ1hjQl2IyGJaOiZ9vGVZmpEwpOrvVYypUZiBYec8sK2XEBoRtFwFXCR6ilQC0PL42Xcs6604iLJPXbI9BVpMlnRBaDuyQ/TJx1GKLC4KQhLW0BkGhARE0kCXcxOV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166739; c=relaxed/simple;
	bh=VVYb6l7eN/w2xrTNTiKlVrCQaCvMJ+yP1V4VJA9K7TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTdZOdUkTy5mWLGsVMo9IUz3p/VYjRxASGC1MCBf/hhe6o4Y9xfJiGgpJjmRERWYnTTlrDSIbggU6M2FTkgH/nNZkXB3jp5nRpgAfLhcQaKZf5Df0VRTkt+xS2eSBLSKaZiPYM5rC3g+8EJjKOMsBzT88EGVCK0G/m4vtpu4Eu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVws92ay; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4dfe74ed2e1so22526081cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759166736; x=1759771536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kN3zHjnrPWcSAlq06fpAHsMZD3W9kqfJ0wO2VWCl62g=;
        b=EVws92ayw8J4vmQv1b/wgrTRUvBZqPsfcp/ujcBmJEAr9rry+anRZlM8/RUQL+2O2u
         Pbsotlv+I45oaxidWCw6h6BIBlO1Hx+2LaWJXvE9ljjkldUOokhCKYtQIL/ck1uj6QeG
         q1VTOw1aAkrUQfMrMgJltQ07SdMstrVBdAZn+GmJ426eh5eSjKJar/xDKhl41Fx3sz/2
         doV3WDMfbPYZo7bvyFSrqTZUHUPvIgkhEXAQ7xeUkeSB9IeiWB8ixQOeAuMeeoH/LmvI
         pG7cBBSruyksPLUmddB77MhyVN+VWs6VOI/rXUzuWDYv05l9PDLxeFqPmFmzqAw7Aizm
         /0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759166736; x=1759771536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kN3zHjnrPWcSAlq06fpAHsMZD3W9kqfJ0wO2VWCl62g=;
        b=FMNeXK2o7HXJW45yD7CCVxESEncwsyenChhC9jMG/Y68NCi0aeeQjOQXuRsq6BUfZK
         1Hp9os6Rw/TE2gs2RZXJz3b0pgUV2C272iVPnuzF5BsrluXyYJhmcQev6+yRx7OEIbvW
         RqiNCtJuTfbA3l4JHo36Zjawtik7ILpiQtA+axDe2HKwrjp6qv758iLGldo7bu7Nztwk
         dZn02+F/aFXjZl4gzdKxYN4DmbRi+KqyOq/3n7blIoE2piZ4a5Cdxo/W68Sli2z0SgbG
         hWe3cDG6kKEMmTgb9TMIH8YbHwJYZnDpmjISR6+ZxLDcawM/D53+Lyxpa6ytpGjNKIzo
         8pfw==
X-Forwarded-Encrypted: i=1; AJvYcCWBMzy47h29a1qagFSgq2m+S1UGj06wk7TfAgFwmyLBxGvj/uCUHqMAlM/UEFDACl7nYrtJgA/ipweKObCO@vger.kernel.org
X-Gm-Message-State: AOJu0YzWxZcEov5c0vMP5LKfuWaJjgDGnjVQ/SavDks4mmAj289RsS9m
	mf5lhyPbLMQJje3gLH55jGi8KMQcdV/D4zdOQUICHN0qgu4B7KZdSiiO5SxlLQCwGn979S65RYv
	/tfrfYz45kYfgD5DUaa3c+ILalEZzmNY=
X-Gm-Gg: ASbGncvlHAJGi7ME5LtMpLuIc6iazurHRhzDNDXxaBZs9x9gFqtpT/MiaYT1Wo2Tucm
	E0Kn4AmTelp4OcY787hnJobPgi2qiib91TkLjaWXa1k/BOGz+CGKmKvKZKMzSfLfP6hbRy0afLQ
	9B2B+Kav1i55qghVfpyxJ8M4kbu+WIitQl9nfWgWbkxPXszDe99tQw3x1KCxiF/dKQU2dIJ57q7
	V+fcts2f4etbMCgNtNAu9JiMwClewKJPx1hk5k=
X-Google-Smtp-Source: AGHT+IFOC8I0Jyb9kZndNKOrqmtxJ/lOXNppAuIzQw0a7RBDXY+CI+aJmPk7S4oSKzPWOgayKBldLBvD7+wTeQSzJqY=
X-Received: by 2002:a05:622a:5a92:b0:4d5:eedd:6881 with SMTP id
 d75a77b69052e-4da4962eec5mr242428281cf.37.1759166735872; Mon, 29 Sep 2025
 10:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925224404.2058035-1-joannelkoong@gmail.com>
 <dc3fbd15-1234-485e-a11d-4e468db635cd@linux.alibaba.com> <9e9d5912-db2f-4945-918a-9c133b6aff81@linux.alibaba.com>
In-Reply-To: <9e9d5912-db2f-4945-918a-9c133b6aff81@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 29 Sep 2025 10:25:25 -0700
X-Gm-Features: AS18NWBhhToIaUIoetqnie3kCXuNo0g7YxY_2U7hxKh9w1faovcLpaSiJKfx01M
Message-ID: <CAJnrk1b=0ug8RMZEggVQpcQzG=Q=msZimjeoEPwwp260dbZ1eg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix readahead reclaim deadlock
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, osandov@fb.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:19=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
> On 2025/9/26 14:51, Gao Xiang wrote:
> >
> > On 2025/9/26 06:44, Joanne Koong wrote:
> >> A deadlock can occur if the server triggers reclaim while servicing a
> >> readahead request, and reclaim attempts to evict the inode of the file
> >> being read ahead:
> >>
> >>>>> stack_trace(1504735)
> >>   folio_wait_bit_common (mm/filemap.c:1308:4)
> >>   folio_lock (./include/linux/pagemap.h:1052:3)
> >>   truncate_inode_pages_range (mm/truncate.c:336:10)
> >>   fuse_evict_inode (fs/fuse/inode.c:161:2)
> >>   evict (fs/inode.c:704:3)
> >>   dentry_unlink_inode (fs/dcache.c:412:3)
> >>   __dentry_kill (fs/dcache.c:615:3)
> >>   shrink_kill (fs/dcache.c:1060:12)
> >>   shrink_dentry_list (fs/dcache.c:1087:3)
> >>   prune_dcache_sb (fs/dcache.c:1168:2)
> >>   super_cache_scan (fs/super.c:221:10)
> >>   do_shrink_slab (mm/shrinker.c:435:9)
> >>   shrink_slab (mm/shrinker.c:626:10)
> >>   shrink_node (mm/vmscan.c:5951:2)
> >>   shrink_zones (mm/vmscan.c:6195:3)
> >>   do_try_to_free_pages (mm/vmscan.c:6257:3)
> >>   do_swap_page (mm/memory.c:4136:11)
> >>   handle_pte_fault (mm/memory.c:5562:10)
> >>   handle_mm_fault (mm/memory.c:5870:9)
> >>   do_user_addr_fault (arch/x86/mm/fault.c:1338:10)
> >>   handle_page_fault (arch/x86/mm/fault.c:1481:3)
> >>   exc_page_fault (arch/x86/mm/fault.c:1539:2)
> >>   asm_exc_page_fault+0x22/0x27
> >>
> >> During readahead, the folio is locked. When fuse_evict_inode() is
> >> called, it attempts to remove all folios associated with the inode fro=
m
> >> the page cache (truncate_inode_pages_range()), which requires acquirin=
g
> >> the folio lock. If the server triggers reclaim while servicing a
> >> readahead request, reclaim will block indefinitely waiting for the fol=
io
> >> lock, while readahead cannot relinquish the lock because it is itself
> >> blocked in reclaim, resulting in a deadlock.
> >>
> >> The inode is only evicted if it has no remaining references after its
> >> dentry is unlinked. Since readahead is asynchronous, it is not
> >> guaranteed that the inode will have any references at this point.
> >>
> >> This fixes the deadlock by holding a reference on the inode while
> >> readahead is in progress, which prevents the inode from being evicted
> >> until readahead completes. Additionally, this also prevents a maliciou=
s
> >> or buggy server from indefinitely blocking kswapd if it never fulfills=
 a
> >> readahead request.
> >>
> >> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >> Reported-by: Omar Sandoval <osandov@fb.com>
> >> ---
> >>   fs/fuse/file.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >> index f1ef77a0be05..8e759061b843 100644
> >> --- a/fs/fuse/file.c
> >> +++ b/fs/fuse/file.c
> >> @@ -893,6 +893,7 @@ static void fuse_readpages_end(struct fuse_mount *=
fm, struct fuse_args *args,
> >>       if (ia->ff)
> >>           fuse_file_put(ia->ff, false);
> >> +    iput(inode);
> >
> > It's somewhat odd to use `igrab` and `iput` in the read(ahead)
> > context.
> >
> > I wonder for FUSE, if it's possible to just wait ongoing
> > locked folios when i_count =3D=3D 0 (e.g. in .drop_inode) before
> > adding into lru so that the final inode eviction won't wait
> > its readahead requests itself so that deadlock like this can
> > be avoided.
>
> Oh, it was in the dentry LRU list instead, I don't think it can
> work.
>
> Or normally the kernel filesystem uses GFP_NOFS to avoid such
> deadlock (see `if (!(sc->gfp_mask & __GFP_FS))` in
> super_cache_scan()), I wonder if the daemon should simply use
> prctl(PR_SET_IO_FLUSHER) so that the user daemon won't be called
> into the fs reclaim context again.

Hi Gao,

We cannot rely on the daemon to set this unfortunately. This can tie
up reclaim and kswapd for the entire system so I think this
enforcement needs to be guaranteed and at the kernel level. For
example, there is the possibility of malicious servers, which we
cannot rely on to set FR_SET_IO_FLUSHER.

Thanks,
Joanne

>
> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> > Gao Xiang
> >
> >
> >>       fuse_io_free(ia);
> >>   }
> >> @@ -973,6 +974,12 @@ static void fuse_readahead(struct readahead_contr=
ol *rac)
> >>           ia =3D fuse_io_alloc(NULL, cur_pages);
> >>           if (!ia)
> >>               break;
> >> +        /*
> >> +         *  Acquire the inode ref here to prevent reclaim from
> >> +         *  deadlocking. The ref gets dropped in fuse_readpages_end()=
.
> >> +         */
> >> +        igrab(inode);
> >> +
> >>           ap =3D &ia->ap;
> >>           while (pages < cur_pages) {
> >
>

