Return-Path: <linux-fsdevel+bounces-34521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E09C6108
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EFD2854AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B8B2185B2;
	Tue, 12 Nov 2024 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LwTiiZkt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A2A207212
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438531; cv=none; b=goxSMbNqT3f3sdgvZJs175Y6UE6UEmGrU/9eHJ13uMBsrAs3kyL+b2t+p9jVj3Kl8ttQ/fiRJH7pMqTzoli/48KZuwCj/g7Uvp8+2KjrY3xRyByDn30BQ+YUPVLr8HZl7CB67Lh6AOji4iMuLdbF8iR4e9ex8kL7OhskYA7DfrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438531; c=relaxed/simple;
	bh=eBTaB4haV1+fSAnpXlnmJPonxx05FWC9EMFbUs9j2+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spqV9BMFE1q6DTeLwyHGODvrW6MQnVTrYq6xq+ZRlATxQS0gK95TQziK8KSjsEOnBlVv9o7yMHquRVQM+WRA7yfyDYiCcfzBV54/vkNd7u4sz/1XGe5UBtpupEZt7VAUlm1JH0I9wTSfY6gMtbHTdYbueWiPIAlc1aHEhr8unjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LwTiiZkt; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e619057165so3470163b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 11:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731438527; x=1732043327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2L7Qc7cWvztIAJNQU15qiNixT/BI8zR+cXMMeIYHYo=;
        b=LwTiiZkt+VCGzeCcLOD2cfdUkTUxBSeBTSiufKCHowuLFSXh0U7dkvYiaRls+OVChd
         /IndjGkRrtXwmv+QH0neUcKKBzBKi6qCOKjhmBN7RViQqV0L2XylxL5NnaNfZCDd1QqY
         lH146t9Ol5f89rLAvrZuxljQdXuAJ4VX45UtJzRTXomKQednR430nM64t/ELvandZU8n
         24DRgbMjG/YLWid+jNkrLBVjagyFMqunye10eT+HKasiVHx7tq+F4X/bOXlpaeYsdAtC
         XjVnTunVtbeFwV/uKJ++w8vT432YcwbbkIoMZx5Fuen8Sj04WIWfcooJM7I3P+6fBU3k
         BDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731438527; x=1732043327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2L7Qc7cWvztIAJNQU15qiNixT/BI8zR+cXMMeIYHYo=;
        b=en75GYdVIxPD+3J5rjlvRnibXZimXpagEWZ7vGnDeFMlHmEt3HT9zPS3WGd77aOxNm
         1EWF6J15ZFgfr9RVYgO5sjQlM8UeFqB3FSQ2MNXiVtUtfVkB9LVW6gsDsXUJvSqOB62H
         VnOJWelKYlA+An62GEhRb2jXaluFd2bSTSQ3rszbEEP4jTj2odQZk/3t/8d4ErlJ+1nZ
         g5JEpvm/mr1P4JjA9MQzLn5xu8IBSJ4Mi9CiOaJgFL/hRa3q769XZGIQShANvr1A77uc
         eGvPOivXBSqKSiCLxLEst4IfbhvzchGTd9SUkXfO8oj6eGp7NIhdqEoH1Kree9UXWHf1
         PQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHJjsVp8BwAY2r21c9Av/GrT5S7l0h3L5U1FhRU4p3xpc5/vTEkW2SMNOe2C7OVkiQnG2EQalGf5qGuR1Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8mPHMGI5uB+pOlYovPQAR9NG9Nut9rlacFc6qcfvZSeGm4ukn
	CHM6WKUB2nhjrPm2JDSxL1J9Ddv6oqwFpb7o2W7wn94BrSq+qxtHdEpQU3N49xQ=
X-Google-Smtp-Source: AGHT+IHoD/uu9DK4NnbrmBtV1ufstZJ55RPP5+LQ3aAZ0f5dnSCso4iUv4jnAvRgbKIUMZBidnJMoA==
X-Received: by 2002:a05:6808:1790:b0:3e6:263b:9108 with SMTP id 5614622812f47-3e7946adb92mr15187907b6e.22.1731438527201;
        Tue, 12 Nov 2024 11:08:47 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7b0955af5sm22182b6e.4.2024.11.12.11.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 11:08:46 -0800 (PST)
Message-ID: <b1dcd133-471f-40da-ab75-d78ea9a8fa4c@kernel.dk>
Date: Tue, 12 Nov 2024 12:08:45 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
 linux-kernel@vger.kernel.org, willy@infradead.org
References: <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <ZzIfwmGkbHwaSMIn@infradead.org>
 <04fd04b3-c19e-4192-b386-0487ab090417@kernel.dk>
 <31db6462-83d1-48b6-99b9-da38c399c767@kernel.dk>
 <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
 <ZzLkF-oW2epzSEbP@infradead.org>
 <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk> <ZzOEzX0RddGeMUPc@bfoster>
 <7a4ef71f-905e-4f2a-b3d2-8fd939c5a865@kernel.dk>
 <3f378e51-87e7-499e-a9fb-4810ca760d2b@kernel.dk> <ZzOiC5-tCNiJylSx@bfoster>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzOiC5-tCNiJylSx@bfoster>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 11:44 AM, Brian Foster wrote:
> On Tue, Nov 12, 2024 at 10:19:02AM -0700, Jens Axboe wrote:
>> On 11/12/24 10:06 AM, Jens Axboe wrote:
>>> On 11/12/24 9:39 AM, Brian Foster wrote:
>>>> On Tue, Nov 12, 2024 at 08:14:28AM -0700, Jens Axboe wrote:
>>>>> On 11/11/24 10:13 PM, Christoph Hellwig wrote:
>>>>>> On Mon, Nov 11, 2024 at 04:42:25PM -0700, Jens Axboe wrote:
>>>>>>> Here's the slightly cleaned up version, this is the one I ran testing
>>>>>>> with.
>>>>>>
>>>>>> Looks reasonable to me, but you probably get better reviews on the
>>>>>> fstests lists.
>>>>>
>>>>> I'll send it out once this patchset is a bit closer to integration,
>>>>> there's the usual chicken and egg situation with it. For now, it's quite
>>>>> handy for my testing, found a few issues with this version. So thanks
>>>>> for the suggestion, sure beats writing more of your own test cases :-)
>>>>>
>>>>
>>>> fsx support is probably a good idea as well. It's similar in idea to
>>>> fsstress, but bashes the same file with mixed operations and includes
>>>> data integrity validation checks as well. It's pretty useful for
>>>> uncovering subtle corner case issues or bad interactions..
>>>
>>> Indeed, I did that too. Re-running xfstests right now with that too.
>>
>> Here's what I'm running right now, fwiw. It adds RWF_UNCACHED support
>> for both the sync read/write and io_uring paths.
>>
> 
> Nice, thanks. Looks reasonable to me at first glance. A few randomish
> comments inlined below.
> 
> BTW, I should have also mentioned that fsx is also useful for longer
> soak testing. I.e., fstests will provide a decent amount of coverage as
> is via the various preexisting tests, but I'll occasionally run fsx
> directly and let it run overnight or something to get the op count at
> least up in the 100 millions or so to have a little more confidence
> there isn't some rare/subtle bug lurking. That might be helpful with
> something like this. JFYI.

Good suggestion, I can leave it running overnight here as well. Since
I'm not super familiar with it, what would be a good set of parameters
to run it with?

>>  #define READ 0
>>  #define WRITE 1
>> -#define fsxread(a,b,c,d)	fsx_rw(READ, a,b,c,d)
>> -#define fsxwrite(a,b,c,d)	fsx_rw(WRITE, a,b,c,d)
>> +#define fsxread(a,b,c,d,f)	fsx_rw(READ, a,b,c,d,f)
>> +#define fsxwrite(a,b,c,d,f)	fsx_rw(WRITE, a,b,c,d,f)
>>  
> 
> My pattern recognition brain wants to see an 'e' here. ;)

This is a "check if reviewer has actually looked at it" check ;-)

>> @@ -266,7 +273,9 @@ prterr(const char *prefix)
>>  
>>  static const char *op_names[] = {
>>  	[OP_READ] = "read",
>> +	[OP_READ_UNCACHED] = "read_uncached",
>>  	[OP_WRITE] = "write",
>> +	[OP_WRITE_UNCACHED] = "write_uncached",
>>  	[OP_MAPREAD] = "mapread",
>>  	[OP_MAPWRITE] = "mapwrite",
>>  	[OP_TRUNCATE] = "truncate",
>> @@ -393,12 +402,14 @@ logdump(void)
>>  				prt("\t******WWWW");
>>  			break;
>>  		case OP_READ:
>> +		case OP_READ_UNCACHED:
>>  			prt("READ     0x%x thru 0x%x\t(0x%x bytes)",
>>  			    lp->args[0], lp->args[0] + lp->args[1] - 1,
>>  			    lp->args[1]);
>>  			if (overlap)
>>  				prt("\t***RRRR***");
>>  			break;
>> +		case OP_WRITE_UNCACHED:
>>  		case OP_WRITE:
>>  			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
>>  			    lp->args[0], lp->args[0] + lp->args[1] - 1,
>> @@ -784,9 +795,8 @@ doflush(unsigned offset, unsigned size)
>>  }
>>  
>>  void
>> -doread(unsigned offset, unsigned size)
>> +__doread(unsigned offset, unsigned size, int flags)
>>  {
>> -	off_t ret;
>>  	unsigned iret;
>>  
>>  	offset -= offset % readbdy;
>> @@ -818,23 +828,39 @@ doread(unsigned offset, unsigned size)
>>  			(monitorend == -1 || offset <= monitorend))))))
>>  		prt("%lld read\t0x%x thru\t0x%x\t(0x%x bytes)\n", testcalls,
>>  		    offset, offset + size - 1, size);
>> -	ret = lseek(fd, (off_t)offset, SEEK_SET);
>> -	if (ret == (off_t)-1) {
>> -		prterr("doread: lseek");
>> -		report_failure(140);
>> -	}
>> -	iret = fsxread(fd, temp_buf, size, offset);
>> +	iret = fsxread(fd, temp_buf, size, offset, flags);
>>  	if (iret != size) {
>> -		if (iret == -1)
>> -			prterr("doread: read");
>> -		else
>> +		if (iret == -1) {
>> +			if (errno == EOPNOTSUPP && flags & RWF_UNCACHED) {
>> +				rwf_uncached = 1;
> 
> I assume you meant rwf_uncached = 0 here?

Indeed, good catch. Haven't tested this on a kernel without RWF_UNCACHED
yet...

> If so, check out test_fallocate() and friends to see how various
> operations are tested for support before the test starts. Following that
> might clean things up a bit.

Sure, I can do something like that instead. fsx looks pretty old school
in its design, was not expecting a static (and single) fd. But since we
have that, we can do the probe and check. Just a basic read would be
enough, with RWF_UNCACHED set.

> Also it's useful to have a CLI option to enable/disable individual
> features. That tends to be helpful to narrow things down when it does
> happen to explode and you want to narrow down the cause.

I can add a -U for "do not use uncached".

-- 
Jens Axboe

