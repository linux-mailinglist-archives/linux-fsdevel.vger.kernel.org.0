Return-Path: <linux-fsdevel+bounces-62862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC3BA30F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 11:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570C91C01ADE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 09:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B3A29BD8E;
	Fri, 26 Sep 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZqydGu82"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2011429B778
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877297; cv=none; b=BmyAgo5PnTGTla1npeGc0IGJcB0gsrZkl4ZIdDStEWAPMPoC2m462np7v0Kftomk8KdS3suZkuVfzP7LFmsv8O59iDadG5+FKB4tLUuC2xwthwbfWcLsh7sKsi+U1O8Olu0ga6BtWX7Rj4TqcZYnloI9kZqY6VjhM83F83dJNkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877297; c=relaxed/simple;
	bh=nb4vNzMsslVxdpFm8AG77r4lgw0dxP0MZ99VQeN6bkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogwHPSE2/KrXCQUgFrLAZAS4qrT3/C1GB8MbwQ0VzSMVoaNRw0Ir0OeLChzHrRvI8cVPHgpcl/gCE4yHId+skQE2xGENbUKFttiUn7UsuEyWgXB299nB83znf9fZmYGftKQPH1k2hboG4kj5N3HW9OHJVD46NLDmzbcQx1yvM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZqydGu82; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4c794491480so26902611cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758877293; x=1759482093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G/GFYlKX8sXH9/MVnPU5JNJW5GLLJS28gOFEuvHHi/s=;
        b=ZqydGu82d3K/7W5vQzUHIV+GydavqTRIqQt40xwUSHd1bT+mKVLZ9+jHeDboUqwq0Z
         MKJYzBBontQrkigMXOC0n819kD4oV3ITL0sxoEm6L6JUt79gFE5YB+E/CtbTj/hqQH7A
         xySvzK/5mwcZ2VC9mMmkFDw+oJw4MqfQPTuoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758877293; x=1759482093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/GFYlKX8sXH9/MVnPU5JNJW5GLLJS28gOFEuvHHi/s=;
        b=akB2MUZMqevQ8jtsEu/946aCWIlW9yV50aEOpJUsQN+lIO+6lTgKvp5BCNI7w2XaOD
         9uI16c/rfw12foMtM38ZQFg0TjSyPaz4Y3K38CEDD00RRBfz7q8UThkbaX6QeRlnm+zo
         MkCt5MsPRToi4wsIPidKOueUcAmsr2Vc5w63p+hm5TTc5mdDOYuPi7sZ9/Gj/4VfnqO1
         EaYd19LhFxq1ws/59Rt+zS71yjWvzvc1G1mEqYNri8+JNTgjMz+Z9iW/qga/3KKGegkH
         wdGXF3pTPTDLWSjiaqq/p91IgqjOq7fbJCEoCHuJMCq/CVd+nOxAg87XlyWOFYFBMVqw
         J5uw==
X-Gm-Message-State: AOJu0YyUj1lBZZXFfklSJW8o/PvF15qbpOTHWzXFTLJS27H6fBYA6lJD
	xEKynwv19bKec4O46NkeJ3hvvDzH6kgfTUm17JcOENFmQt2igG21zdjKXHs1RulAxmpb4FZlJiG
	fR6XaA3AO7HDasbCgQb5YA2IEejkL5yBJjhbBMCrGxQ==
X-Gm-Gg: ASbGncv5wrZVmWZY3IvKfUsO0vXGvM1EnLGrc7FVAtjfdrgyXYstLlw/z3PQo+laaTc
	OS8IQ5JZT9chJ89+pMnEngMGC/WYCXjnndaU5mYk9tq50WLtEqZxVQrDvY0L8YQfFOGnuSuotO4
	1EZBYYZ2R7JBZCt+LB4+HXRcdooBDfSM82ZukOE/4eTfyNr0w2ZSTQt3v7h0C5gqWYTpis7Z9re
	0QE3iWmHYgrjSVvfFE3Ov5im7+/FhFXSmBS3gOz6/9D2oD/KQ==
X-Google-Smtp-Source: AGHT+IHzalmSFeS2hW534mTf27M196Uxb8VIlcKO6L9aIo/0iAFRQkxP8597Cv2HReRDKaD5Ym4wy+usutK7h7mOOb4=
X-Received: by 2002:ac8:5fd3:0:b0:4b7:ac70:d7ee with SMTP id
 d75a77b69052e-4da47c0570cmr76627321cf.14.1758877292711; Fri, 26 Sep 2025
 02:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925224404.2058035-1-joannelkoong@gmail.com>
In-Reply-To: <20250925224404.2058035-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 26 Sep 2025 11:01:21 +0200
X-Gm-Features: AS18NWDzpmIFyfqJed-8UXKwoNHRrfCxmto9gvn_Hs3Vc9F5z9XP26K83W96iB4
Message-ID: <CAJfpegvM48p__QALuxH_PBGcyNR2JYvJCav4Ug05SZYg1ZSRgw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix readahead reclaim deadlock
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, osandov@fb.com, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 00:45, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> A deadlock can occur if the server triggers reclaim while servicing a
> readahead request, and reclaim attempts to evict the inode of the file
> being read ahead:
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
> During readahead, the folio is locked. When fuse_evict_inode() is
> called, it attempts to remove all folios associated with the inode from
> the page cache (truncate_inode_pages_range()), which requires acquiring
> the folio lock. If the server triggers reclaim while servicing a
> readahead request, reclaim will block indefinitely waiting for the folio
> lock, while readahead cannot relinquish the lock because it is itself
> blocked in reclaim, resulting in a deadlock.
>
> The inode is only evicted if it has no remaining references after its
> dentry is unlinked. Since readahead is asynchronous, it is not
> guaranteed that the inode will have any references at this point.
>
> This fixes the deadlock by holding a reference on the inode while
> readahead is in progress, which prevents the inode from being evicted
> until readahead completes. Additionally, this also prevents a malicious
> or buggy server from indefinitely blocking kswapd if it never fulfills a
> readahead request.

I don't see a better way to fix this, but Cc-ing Willy as the
readahead/mm expert.

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reported-by: Omar Sandoval <osandov@fb.com>

This is not a new bug, right?  So at least add a

Cc: stable@vger.kernel.org

Thanks,
Miklos

> ---
>  fs/fuse/file.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f1ef77a0be05..8e759061b843 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -893,6 +893,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
>         if (ia->ff)
>                 fuse_file_put(ia->ff, false);
>
> +       iput(inode);
>         fuse_io_free(ia);
>  }
>
> @@ -973,6 +974,12 @@ static void fuse_readahead(struct readahead_control *rac)
>                 ia = fuse_io_alloc(NULL, cur_pages);
>                 if (!ia)
>                         break;
> +               /*
> +                *  Acquire the inode ref here to prevent reclaim from
> +                *  deadlocking. The ref gets dropped in fuse_readpages_end().
> +                */
> +               igrab(inode);
> +
>                 ap = &ia->ap;
>
>                 while (pages < cur_pages) {
> --
> 2.47.3
>

