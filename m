Return-Path: <linux-fsdevel+bounces-36668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9169E7805
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 19:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D361885CE8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532C4203D6E;
	Fri,  6 Dec 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lQqbRWZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658DD1F4E21
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509381; cv=none; b=d7r9166E/r4xEqifkF7KNSkNMcrGxVmop9xN9QzKeNb7OItsFuVx/dKR6JlcYrsu/KwLJDYg5PltAiGA8yXrkU5a2yImPHcsVmNtfSELa5Js6+dBHxYZM0/TPRpttctyqVRzAbpgl5YfKlmdguZrGVBwNZvT/043Tv5YFZmg580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509381; c=relaxed/simple;
	bh=kf+zolflO/EHKE7MBlJ7iCG3NR0ZL/XWpDUekPqViOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Va51SEe7C6wFZDKttM4NBiX9CKYyOO3pRxXqyA5GpPideeKzNo4HJBI+S85dODlBu2wW5sEm+nDpUmSHZSuh++JaALFIGoiRtNl/Hp4lmyBEXEkPqp22UbBB35BHykOfjAoE5/MP2DBVKzAb6q/t/1ePMSaPWojJajHn4IY3OXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lQqbRWZj; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fd1dcbbc08so1514405a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 10:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733509378; x=1734114178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3FJ78ZOiVCMNMYdkIsCKf6EgHgZd92CbNxtZ6WSke4=;
        b=lQqbRWZjq0uoAu9w7fHaVlr06XGUFUyeYIDX5AOOzuAOHYGwFhNftG9PgHiEXgpkt+
         KTF/is6AnM8uVQpd55qcZAVoFDn+a80tNftIJ0lTu1g7RXXAjG1g3S0IB/VjhTePKndc
         XqKeBFXNI5dQa3K6SVOuqW7Rz4tAluh6syDEBYsaKI9zEnZKMw6g8s4/tzVTVhQhmiE5
         9Bsa/vGwS+UgsTLlKVHKXVr4GLLe+FBz2jNsJXvNF5lYaFJ3gV3oeMQIkS3NTCm1F+oO
         FUG9U8eLwa7zQ7oxE5piIqhxnusYkNPjqucmozwLbZaicHDqIh2d0KUk3HAB/zI6rfBk
         /WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509378; x=1734114178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3FJ78ZOiVCMNMYdkIsCKf6EgHgZd92CbNxtZ6WSke4=;
        b=vfkiIq5xtcqYdE6bkmVud2b7pRESxg1wqB3PVd/FJ84GsBB0a/emr0OHtmnDV0ipCx
         zqaJ+9z5o4QUYeBtVOgMsNo34B3ac6COkBGvh2ncwmD8P/vKIaxh7TGB8v7VxEgwNjAk
         Czq9dddf4sZSVBTe4D2DNeqXfMBCRgt6X4eJvWI0dKJ+NIN2ZRtSht5uMf6pnW4XZCkt
         TX1OaddyaEP5Ebd0ZGkJGgjQOx2Xwf/IGaqkX7y5lPsO5RDPi0b7lANklkAwWiLRXDOn
         /WciwGRoPtQsgi0NmDbOSPnc5cb/2fIpfo4JQYZhcrh6QH7oLwfg0PtEJ9ArR4pftcPo
         G5aw==
X-Forwarded-Encrypted: i=1; AJvYcCWg0rKxThfQEybninDSvlv9/6UZTdqt1+7ajM0m1IJEtWyOtzvoh1rvyFn1MoPwZgvosvULsKs08s/qJkOR@vger.kernel.org
X-Gm-Message-State: AOJu0YwViTbL55xUuW/R7y2Qwf7mRXrOkGmc/vBTN6s9PiRPMbrqTwn0
	BlxPMDMQk6CfFCjuHHOtewRlrRHZRNk+0kXBsCz6SGbaPn863L/iYUP3PA6do1HXpsB+foYF3dj
	V
X-Gm-Gg: ASbGncvbkEMZy8S4GwqC9dZvigtWYU+4GmVMyfHG0wcqAAxbjfzJvzGT8XKJHwxw1dq
	PE0RZ4lSppBAVdc2RADhZne0T7yibHfuUUpS6+Np+0iJZ8tO6busCwpSqBsQQ6JQY4AAb/k7qTF
	cLxxdCIqlL0q6reUSw0HGozf+FP6bIC7wQvXbZIspVU05nHmd/VNyg9EWTiRUqPgYBUWorcmZLF
	9uNKedo203+T7XuCmCZhmrSF3IMobzCum3Fpn0dteuwezBnLFYWswSH5Q==
X-Google-Smtp-Source: AGHT+IHZGJYd2MJ3DSBJ5dS+uaz/fvvXJs4HyxPKMbVKQT4GlNW86jLqGUGSgu6lfLCPoThTJFDfbw==
X-Received: by 2002:a05:6a20:1584:b0:1e0:c971:a138 with SMTP id adf61e73a8af0-1e18715e8e0mr4909996637.39.1733509377622;
        Fri, 06 Dec 2024 10:22:57 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:47b4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45fa64d2sm3480035a91.28.2024.12.06.10.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 10:22:56 -0800 (PST)
Message-ID: <39033717-2f6b-47ca-8288-3e9375d957cb@kernel.dk>
Date: Fri, 6 Dec 2024 11:22:55 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] mm/filemap: make buffered writes work with
 RWF_UNCACHED
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-13-axboe@kernel.dk>
 <20241206171740.GD7820@frogsfrogsfrogs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241206171740.GD7820@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 10:17 AM, Darrick J. Wong wrote:
> On Tue, Dec 03, 2024 at 08:31:47AM -0700, Jens Axboe wrote:
>> If RWF_UNCACHED is set for a write, mark new folios being written with
>> uncached. This is done by passing in the fact that it's an uncached write
>> through the folio pointer. We can only get there when IOCB_UNCACHED was
>> allowed, which can only happen if the file system opts in. Opting in means
>> they need to check for the LSB in the folio pointer to know if it's an
>> uncached write or not. If it is, then FGP_UNCACHED should be used if
>> creating new folios is necessary.
>>
>> Uncached writes will drop any folios they create upon writeback
>> completion, but leave folios that may exist in that range alone. Since
>> ->write_begin() doesn't currently take any flags, and to avoid needing
>> to change the callback kernel wide, use the foliop being passed in to
>> ->write_begin() to signal if this is an uncached write or not. File
>> systems can then use that to mark newly created folios as uncached.
>>
>> This provides similar benefits to using RWF_UNCACHED with reads. Testing
>> buffered writes on 32 files:
>>
>> writing bs 65536, uncached 0
>>   1s: 196035MB/sec
>>   2s: 132308MB/sec
>>   3s: 132438MB/sec
>>   4s: 116528MB/sec
>>   5s: 103898MB/sec
>>   6s: 108893MB/sec
>>   7s: 99678MB/sec
>>   8s: 106545MB/sec
>>   9s: 106826MB/sec
>>  10s: 101544MB/sec
>>  11s: 111044MB/sec
>>  12s: 124257MB/sec
>>  13s: 116031MB/sec
>>  14s: 114540MB/sec
>>  15s: 115011MB/sec
>>  16s: 115260MB/sec
>>  17s: 116068MB/sec
>>  18s: 116096MB/sec
>>
>> where it's quite obvious where the page cache filled, and performance
>> dropped from to about half of where it started, settling in at around
>> 115GB/sec. Meanwhile, 32 kswapds were running full steam trying to
>> reclaim pages.
>>
>> Running the same test with uncached buffered writes:
>>
>> writing bs 65536, uncached 1
>>   1s: 198974MB/sec
>>   2s: 189618MB/sec
>>   3s: 193601MB/sec
>>   4s: 188582MB/sec
>>   5s: 193487MB/sec
>>   6s: 188341MB/sec
>>   7s: 194325MB/sec
>>   8s: 188114MB/sec
>>   9s: 192740MB/sec
>>  10s: 189206MB/sec
>>  11s: 193442MB/sec
>>  12s: 189659MB/sec
>>  13s: 191732MB/sec
>>  14s: 190701MB/sec
>>  15s: 191789MB/sec
>>  16s: 191259MB/sec
>>  17s: 190613MB/sec
>>  18s: 191951MB/sec
>>
>> and the behavior is fully predictable, performing the same throughout
>> even after the page cache would otherwise have fully filled with dirty
>> data. It's also about 65% faster, and using half the CPU of the system
>> compared to the normal buffered write.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  include/linux/fs.h      |  5 +++++
>>  include/linux/pagemap.h |  9 +++++++++
>>  mm/filemap.c            | 12 +++++++++++-
>>  3 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 40383f5cc6a2..32255473f79d 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2912,6 +2912,11 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
>>  				(iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
>>  		if (ret)
>>  			return ret;
>> +	} else if (iocb->ki_flags & IOCB_UNCACHED) {
>> +		struct address_space *mapping = iocb->ki_filp->f_mapping;
>> +
>> +		filemap_fdatawrite_range_kick(mapping, iocb->ki_pos,
>> +					      iocb->ki_pos + count);
>>  	}
>>  
>>  	return count;
>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>> index f2d49dccb7c1..e49587c40157 100644
>> --- a/include/linux/pagemap.h
>> +++ b/include/linux/pagemap.h
>> @@ -14,6 +14,7 @@
>>  #include <linux/gfp.h>
>>  #include <linux/bitops.h>
>>  #include <linux/hardirq.h> /* for in_interrupt() */
>> +#include <linux/writeback.h>
>>  #include <linux/hugetlb_inline.h>
>>  
>>  struct folio_batch;
>> @@ -70,6 +71,14 @@ static inline int filemap_write_and_wait(struct address_space *mapping)
>>  	return filemap_write_and_wait_range(mapping, 0, LLONG_MAX);
>>  }
>>  
>> +/*
>> + * Value passed in to ->write_begin() if IOCB_UNCACHED is set for the write,
>> + * and the ->write_begin() handler on a file system supporting FOP_UNCACHED
>> + * must check for this and pass FGP_UNCACHED for folio creation.
>> + */
>> +#define foliop_uncached			((struct folio *) 0xfee1c001)
>> +#define foliop_is_uncached(foliop)	(*(foliop) == foliop_uncached)
> 
> Honestly, I'm not a fan of foliop_uncached or foliop_is_uncached.

It definitely is what I would elegantly refer to as somewhat of a
hack... But it's not _that_ bad imho.

> The first one because it's a magic value and can you guarantee that
> 0xfee1c001 will never be a pointer to an actual struct folio, even on
> 32-bit?

I don't think that should be possible, since it's deliberately 1 at the
end. A struct like folio (or anything else) should at least be sizeof
aligned, and this one is not.

> Second, they're both named "foliop" even though the first one doesn't
> return a (struct folio **) but the second one takes that as an arg.

I just named them as such since they only deal with the folio ** that is
being passed in. I can certainly rename the second one to
folio_uncached, that would be an improvement I think. Thanks!

> I think these two macros are only used for ext4 (or really, !iomap)
> support, right?  And that's only to avoid messing with ->write_begin?

Indeed, ideally we'd change ->write_begin() instead. And that probably
should still be done, I just did not want to deal with that nightmare in
terms of managing the patchset. And honestly I think it'd be OK to defer
that part until ->write_begin() needs to be changed for other reasons,
it's a lot of churn just for this particular thing and dealing with the
magic pointer value (at least to me) is liveable.

> What if you dropped ext4 support instead? :D

Hah, yes obviously that'd be a solution, then I'd need to drop btrfs as
well. And I would kind of prefer not doing that ;-)

-- 
Jens Axboe

