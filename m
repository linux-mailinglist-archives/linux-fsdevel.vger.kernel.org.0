Return-Path: <linux-fsdevel+bounces-17388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A598ACBB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1FC1C2264E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030D714659A;
	Mon, 22 Apr 2024 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="mqmUocXs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82D2481DD;
	Mon, 22 Apr 2024 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784325; cv=none; b=oFbM8sGy9hUBSHaSYcQzw/9qeer5nEX85sC3TTK9oAG+Tk+UQXQtAfbdXhyNicgHhdr+N/6JYUZ1VBknvm3GxZql2MCZ06jlC4VXmgPDMqVAWAw7qy2/exOZCASm8E3TduG78h3TqRnjMZ19g8zbalJOunhA6fdFeceGOfqCB7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784325; c=relaxed/simple;
	bh=dAPocxet1Oe850nbPG3d6+xiuiTaILe0wrclc0bquhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOwJfAi7g1qpOInmGfKF2mAOZxZnPk10zlgAW1W94PxKqQa2xVBKuM2bytiCay8uzhEYQyMESY9/NUx3rdO0OcnY48TGnjEbhvVn+9o5lmg/cvN8o0mqQFnlFCMGIIIbyC69K7nwMfstEL3RxRsdV1PF7sAiSQmq0NKVPDTLZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=mqmUocXs; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VNMnK3Nksz9svZ;
	Mon, 22 Apr 2024 13:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1713783829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gcKvfN037TA7hZSa4d4wVaW0uvAV7xIvSo/LgCapk+E=;
	b=mqmUocXsR3w50nQdtWP075s0eXt8c5DeM+rfi3aUvt846NgO+qnHJo4yQ7QUkHZi+6M1XA
	oJO0688sir/I+srkC0WLRug6oq1qkVdQAPXuW2ps6tHah0BNuNNq8jh+9+Oy68WDLOiO3o
	H2fpseCkE5oUuy5GwzGd4m40QKDQ/6Da8cnRhlU0QX17oh6vxC18/hmPqh9nMI3Vq3nyOW
	lvs5sKHvUnLlcjKR0ZYBIGV+xraV5tvf4//IYSXPvFSP3Sfr3X88gVh5VQBcLAPsMws0Tc
	0EsYRbVASkL/dJ/7VA9ofv/A1nGnv3IhjqN1K+E+RQaxfTQGpL8w0sogSRT+rw==
Date: Mon, 22 Apr 2024 13:03:45 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de, mcgrof@kernel.org, 
	djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	david@fromorbit.com, akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 05/11] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <i4c6xe6jdei2to6kah4kgjehpjlanaqfulju2jzsu5ny2gmegv@2b2oh44oilnj>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-6-kernel@pankajraghav.com>
 <ZgHJxiYHvN9DfD15@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHJxiYHvN9DfD15@casper.infradead.org>

> > @@ -515,7 +562,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
> >  		if (index & ((1UL << order) - 1))
> >  			order = __ffs(index);
> >  		/* Don't allocate pages past EOF */
> > -		while (index + (1UL << order) - 1 > limit)
> > +		while (order > min_order && index + (1UL << order) - 1 > limit)
> >  			order--;
> 
> This raises an interesting question that I don't know if we have a test
> for.  POSIX says that if we mmap, let's say, the first 16kB of a 10kB
> file, then we can store into offset 0-12287, but stores to offsets
> 12288-16383 get a signal (I forget if it's SEGV or BUS).  Thus far,
> we've declined to even create folios in the page cache that would let us
> create PTEs for offset 12288-16383, so I haven't paid too much attention
> to this.  Now we're going to have folios that extend into that range, so
> we need to be sure that when we mmap(), we only create PTEs that go as
> far as 12287.
> 
> Can you check that we have such an fstest, and that we still pass it
> with your patches applied and a suitably large block size?
> 

So the mmap is giving the correct SIGBUS error when we try to do this:
dd if=/dev/zero of=./test bs=10k count=1; 
xfs_io -c "mmap -w 0 16384" -c "mwrite 13000 10" test

Logs on bs=64k ps=4k system:
root@debian:/media/test# dd if=/dev/zero of=./test bs=10k count=1;
root@debian:/media/test# du -sh test 
64K     test
root@debian:/media/test# ls -l --block-size=k test 
-rw-r--r-- 1 root root 10K Apr 22 10:42 test
root@debian:/media/test# xfs_io -c "mmap  0 16384" -c "mwrite 13000 10" test
Bus error

The check in filemap_fault takes care of this:

max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
if (unlikely(index >= max_idx))
        return VM_FAULT_SIGBUS;

The same operation for read should also give a bus error, but it didn't.
Further investigation pointed out that the fault_around() does not take
this condition into account for LBS configuration. When I set fault_around_bytes
to 4096, things worked as expected as we skip fault_around for reads. 

I have a patch that return SIGBUS also for the following read operation:
dd if=/dev/zero of=./test bs=10k count=1; 
xfs_io -c "mmap -r 0 16384" -c "mread 13000 10" test

This is the patch I have for now that fixes fault_around() logic for LBS
configuration:

diff --git a/mm/filemap.c b/mm/filemap.c
index f0c0cfbbd134..259531dd297b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3600,12 +3600,15 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
        }
        do {
                unsigned long end;
+               unsigned long i_size;
 
                addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
                vmf->pte += xas.xa_index - last_pgoff;
                last_pgoff = xas.xa_index;
                end = folio_next_index(folio) - 1;
-               nr_pages = min(end, end_pgoff) - xas.xa_index + 1;
+               i_size = DIV_ROUND_UP(i_size_read(mapping->host),
+                                     PAGE_SIZE) - 1;
+               nr_pages = min3(end, end_pgoff, i_size) - xas.xa_index + 1;
 
                if (!folio_test_large(folio))
                        ret |= filemap_map_order0_folio(vmf,

I will send a new version of the series this week after doing some more
testing.

