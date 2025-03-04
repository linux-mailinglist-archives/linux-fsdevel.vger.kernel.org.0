Return-Path: <linux-fsdevel+bounces-43030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD044A4D283
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 05:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCA83ADFE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 04:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFBE1EEA34;
	Tue,  4 Mar 2025 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtzweX1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015D37160;
	Tue,  4 Mar 2025 04:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741061966; cv=none; b=B9yvERCwTC+4hepIC1CHHDUIq+ksPaHsFVL6GZMB+wxUwWaDBZWRmXfIkRoPjayqX7ROlbuccG1EwpKlRjVmduSQx+0hkEwj/ocEGQrFM5irKG8I6s+DzG+VSh9wfCkH/lp0/bu0+X90FJ+oHQ4Ke6kyxT9b0XFx82zCuQ4jmPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741061966; c=relaxed/simple;
	bh=E4zSxkRdxpBHJnCFEpoSKhm8+YIJc8a1vUeGcruwJNU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=pQWnF2G5IhdDNEW+LfPoXlLK0VaD+yzXdoHUY341LZF4MIZ6FzPV5J0p7cttWZ6VelvuKZsPBjTKWrCeou+7XQY9bh0/QPOc/NGRWjxMJ5GMRHyYrUJxh778sAfJu5Gd22agHWKPVwEdJOGbqfb3DEK0o8mRsMZhwShgo2yjz1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtzweX1e; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22349dc31bcso90098935ad.3;
        Mon, 03 Mar 2025 20:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741061964; x=1741666764; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b5BZZqzU3LyDmpLf80WHlDyl/IunQEMvOhtkkYrHchw=;
        b=MtzweX1eJywMDPzeIpmKlpF9TLv8vN/9QGJA5J2L+gc62USLfQ5y/gTvhUum+Za7XQ
         9bBByyYx6I4l2jiHFsp/n/WEyifUdY7OB4nrS6hHnZCJKmt7E3sr4WHLiRuDv1dxJVxu
         Nq1uvCg3n8hcskliI2FK1prOeMRRiya7vQWxcROoLGisRo11WqFtCjRjYgPgJ3435qHC
         UljEm4ugNX6F5o5oqBrGU5R8zaiXFwa4f2xqjmHL6W1b24UitYGboDo6ZTiyqeN5fP77
         CPw+j581+Wq0rlODfxWfBE2YEsYzUbIOOikgENr1eIeqOrkdNCsql46cONSbkBgJS8bm
         v05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741061964; x=1741666764;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5BZZqzU3LyDmpLf80WHlDyl/IunQEMvOhtkkYrHchw=;
        b=AXik0JImHmdKwi33oCR60SA5UAakl8mgNnxeAms4VqBFPl03i1tu7mZqTdT9G9/Dp/
         L+1WH3F37Ta3inKef4jlQyKrh0+2iNOq2yyR7T0CsCfdzzAUHFjWgxqI0NDT081DP48f
         cw2FxCIItyZBSzQx6CTMkXChD6m/lkPK3QPdC8EYwZwuWUVyjvxmYvufSbmHsxpg8dzh
         CZYa/9OtViaS37bDhmbRmrYSj+3obmTqSTZ4v/HH18D6E+Km1kLlf0ey4JDI38q+shPf
         7n+4fnCvLA4hD3HBmSmUR+qz5o0TP0Y0S603foEWEnjnDu9qUZ15di80KKJkkUl9mizD
         V0UA==
X-Forwarded-Encrypted: i=1; AJvYcCUC9JWueMwLD2JXEM4QlVeaQ+Fc05IzPJDmdbl0gHiSHqKgJ1YqUGMSDMQU3kxyF9O/NvIprtUdDpRk@vger.kernel.org, AJvYcCUUls1FmysHLLUlxqgg4o5ORTXaK12Il9aNvKD+d7EcfIu5+iZ8KPPRAkSf3ttSXerFogE9MPB8W69q1qsSJA==@vger.kernel.org, AJvYcCVj5hmGQLoPC+EyJgZcasEijg6D5U7Tjm2OrbWb4QgAalJubgzamvRRMXFvDeXEKwbvrHlYJcVi6C0LzU2O@vger.kernel.org, AJvYcCXnP2dmNENzhrSyZWLpIo5MltkfXcaBH5MMEz2B/gWFQn3mhSG5eJ4ZS1gWIIRW1ZB+Hgcsr3zX@vger.kernel.org
X-Gm-Message-State: AOJu0YzRPYI568pZH5pfYDZq1cIfHXmAGPZlPgZ4kUHHxte9A7AKKYNt
	g3E84HGv1hqQTf/8h041eBQ2ajbPqqId4VoIdZ/dfwUpKAqolf77
X-Gm-Gg: ASbGncuL/E6SxowJA1cqnJNCLwdhcQg41BLSWHLHH1NEbMysw+F+TwpQX1eVr3UZm1e
	IMJbL3IGsn3m+FVjDrGK7aOVSiD5l8kLoyVJ8AKbz1Y7bxPYe9ERXq53pfQCvwuLOWY+pv/irR2
	lcDiStpzqtj0SW2Y/pu0moUsLIgKYW4tAjlLr1KUUsZoUcxkOnoc78N6oArO5v3XQvIyq4XuM5i
	UkzszOxuYJrGoPj5z8LxF9gS/s5Du4pqJS5MDB59slu0IzmnafYlWbtQdzWrx0w7TXJfhvQlyfH
	NRTcvOyTB69bi2yZujhE/Kb5iOacWeoTmg1qQg==
X-Google-Smtp-Source: AGHT+IGyLnXU48VROf4eIEM9JE/bEc0s12E1atZPU8MYK+Bgk6HdBsy65wH7qxGpf1uQ/d9Bst6Wxg==
X-Received: by 2002:a05:6a00:3e1e:b0:736:46b4:beef with SMTP id d2e1a72fcca58-73646b57724mr11858996b3a.3.1741061964126;
        Mon, 03 Mar 2025 20:19:24 -0800 (PST)
Received: from dw-tp ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7362dbde43bsm6526845b3a.25.2025.03.03.20.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 20:19:23 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, "Darrick J . Wong" <djwong@kernel.org>, 
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, kirill@shutemov.name, bfoster@redhat.com, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, fstests@vger.kernel.org, Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Subject: Re: [PATCH 09/12] mm/filemap: drop streaming/uncached pages when writeback completes
In-Reply-To: <20241220154831.1086649-10-axboe@kernel.dk>
Date: Tue, 04 Mar 2025 08:42:32 +0530
Message-ID: <87h649trof.fsf@gmail.com>
References: <20241220154831.1086649-1-axboe@kernel.dk> <20241220154831.1086649-10-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Jens Axboe <axboe@kernel.dk> writes:

> If the folio is marked as streaming, drop pages when writeback completes.
> Intended to be used with RWF_DONTCACHE, to avoid needing sync writes for
> uncached IO.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  mm/filemap.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index dd563208d09d..aa0b3af6533d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1599,6 +1599,27 @@ int folio_wait_private_2_killable(struct folio *folio)
>  }
>  EXPORT_SYMBOL(folio_wait_private_2_killable);
>  
> +/*
> + * If folio was marked as dropbehind, then pages should be dropped when writeback
> + * completes. Do that now. If we fail, it's likely because of a big folio -
> + * just reset dropbehind for that case and latter completions should invalidate.
> + */
> +static void folio_end_dropbehind_write(struct folio *folio)
> +{
> +	/*
> +	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
> +	 * but can happen if normal writeback just happens to find dirty folios
> +	 * that were created as part of uncached writeback, and that writeback
> +	 * would otherwise not need non-IRQ handling. Just skip the
> +	 * invalidation in that case.
> +	 */
> +	if (in_task() && folio_trylock(folio)) {
> +		if (folio->mapping)
> +			folio_unmap_invalidate(folio->mapping, folio, 0);
> +		folio_unlock(folio);
> +	}
> +}
> +

Hi Jens, 

Want to ensure that my understanding is correct here w.r.t the above
function where we call folio_unmap_invalidate() only when in_task() is
true. 

Almost always the writeback completion will run in the softirq
completion context right?  Do you know of cases where the writeback
completion runs in the process context (in_task())?  Few cases from the
filesystem side, where the completion can run in a process context are,
when the bio->bi_end_io is hijacked by the filesystem, e.g.

	/* send ioends that might require a transaction to the completion wq */
	if (xfs_ioend_is_append(ioend) ||
	    (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED)))
		ioend->io_bio.bi_end_io = xfs_end_bio;

	if (status)
		return status;
	submit_bio(&ioend->io_bio);

In this case xfs_end_bio() will be called for completing the ioends and
will queue the completion to a workqueue (since this requires txn
processing). (Which means in_task() will be true)


That means the user visible effect of having an in_task() check for
calling folio_unmap_invalidate() are - 

1. If an append write or write to a unwritten extent or when cow is done
using RWF_DONTCACHE on a file, it will free up the page cache folios
after the I/O completes (as expected).

2. However if RWF_DONTCACHE writes are done to any existing written extents
(i.e. overwrites), then it will not free up the page cache folios after
the I/O completes (because the completions run in the softirq context)

Is this understanding correct? Is this an expected behavior too and is
this documented someplace like in a man page or kernel Documentation?

The other thing which I wanted to check was, we can then have folios
still in the page cache which were written using RWF_DONTCACHE. So do
we drop these page cache folios later from somewhere else? Or is there
any other mm subsystem utilizing the fact that those pages remaining in
the pagecache which were written using RWF_DONTCACHE can be the
candidates for removal first?

I am just trying to better understand on whether we are treating these
page cache folios marked with PG_dropbehind as special or just as a
regular page cache folios after the I/O is complete but these didn't get
free. I understand the other reason where these won't get freed is when
someone else might be using these folios.


<Below experiment to show page cache pages cached after doing an
overwrite using RWF_DONTCACHE>

I was trying to add -U flag to xfs_io for uncached preadv2/pwritev2
calls. (I will post those patches soon).

Using -U flag in xfs_io, we can see the above mentioned behavior.

e.g. 
# mount /dev/loop6 /mnt1/test

// Do uncached writes using (-U) to a new file
# ./io/xfs_io -fc "pwrite -U -V 1 0 16K" /mnt1/test/f1;
wrote 16384/16384 bytes at offset 0
16 KiB, 4 ops; 0.0036 sec (4.277 MiB/sec and 1094.9904 ops/sec)

//no page cache pages found as expected
# ./io/xfs_io -c "mmap 0 16K" -c "mincore" -c "munmap" /mnt1/test/f1    

// overwrite to the same area using uncached writes (-U)
# ./io/xfs_io -c "pwrite -U -V 1 0 16K" /mnt1/test/f1;
wrote 16384/16384 bytes at offset 0
16 KiB, 4 ops; 0.0016 sec (9.340 MiB/sec and 2390.9145 ops/sec)

// Overwrite causes the page cache pages to be found even with -U
# ./io/xfs_io -c "mmap 0 16K" -c "mincore" -c "munmap" /mnt1/test/f1
0x7ffff7fb5000 - 0x7ffff7fb9000  4 pages (0 : 16384)

// Try the same after a mount cycle
# umount /dev/loop6
# mount /dev/loop6 /mnt1/test

// Overwrite causes the page cache pages to be found even with -U
# ./io/xfs_io -c "pwrite -U -V 1 0 16K" /mnt1/test/f1;
wrote 16384/16384 bytes at offset 0
16 KiB, 4 ops; 0.0009 sec (16.361 MiB/sec and 4188.4817 ops/sec)
# ./io/xfs_io -c "mmap 0 16K" -c "mincore" -c "munmap" /mnt1/test/f1
0x7ffff7fb5000 - 0x7ffff7fb9000  4 pages (0 : 16384)
#


Should we add few unit tests in xfstests for above behavior (for
preadv2() and pwritev2()). I was planning to add a few, but since we are
already discussing other things here - it's better to get an opinion
from others too for this.

-ritesh


>  /**
>   * folio_end_writeback - End writeback against a folio.
>   * @folio: The folio.
> @@ -1609,6 +1630,8 @@ EXPORT_SYMBOL(folio_wait_private_2_killable);
>   */
>  void folio_end_writeback(struct folio *folio)
>  {
> +	bool folio_dropbehind = false;
> +
>  	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
>  
>  	/*
> @@ -1630,9 +1653,14 @@ void folio_end_writeback(struct folio *folio)
>  	 * reused before the folio_wake_bit().
>  	 */
>  	folio_get(folio);
> +	if (!folio_test_dirty(folio))
> +		folio_dropbehind = folio_test_clear_dropbehind(folio);
>  	if (__folio_end_writeback(folio))
>  		folio_wake_bit(folio, PG_writeback);
>  	acct_reclaim_writeback(folio);
> +
> +	if (folio_dropbehind)
> +		folio_end_dropbehind_write(folio);
>  	folio_put(folio);
>  }
>  EXPORT_SYMBOL(folio_end_writeback);
> -- 
> 2.45.2

