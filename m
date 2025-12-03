Return-Path: <linux-fsdevel+bounces-70526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF8CC9D7A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 02:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E98B54E3868
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 01:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AD5219A71;
	Wed,  3 Dec 2025 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2Vz5nDp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nIKzMiDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594121A449
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724190; cv=none; b=JyH8+nq+UD4VGM5YyZdqDhUjWCO2rH9/SxXJ82w6hnka0MiLJA1erQSH4np4YVKvKHOE+g89Yp8XpiIusp5USpZ5ebDrzB0DVj3qzEpM0QsaLa8uIjxViihIQYoZAKM+ZGKk3n1JhuFBkJE+dPW1lWbQFCPFTVAu0Mmd1vhizqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724190; c=relaxed/simple;
	bh=6d9MLhbuGhImXKQsbqVvBDxpx5TNDGot34v3meko/w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+PBRi0QVW327lxHK+Ezvt1xhOURHqK8MQJ7eVFyu1rxhVPbn76ja4szPaE4wzER2HSSqnXiL+X0NFy23CZoM6zWzU5WZkO04fTGBEGRCZQREriVo6KOzi6qYkGjj0YIDj/v1hjlUj4OYAMAc6chjYCU4CmEUZ6T30eTVZ0oyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2Vz5nDp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nIKzMiDT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764724186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFZSJbUMoFREDOMf4hNQovtb4fH0ilmA926PCOmpAo0=;
	b=A2Vz5nDpTmGs4GHfM9HOj2JzlW45O0V1+uUen+BKdzJt1uOO67q0lCZSUT0WVjqjVSdjzr
	1AAclNXfceYcQi4F1Uy/ST9AVcC5LbYnFSaaBIF/pLtXZPmclscuA6Cj9QM00CeAyleKgh
	Pz6SQpaT7fmMXYtIO9d2eeJM2W+zmos=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-3eLgvTNZMTCB5vv30pMT-w-1; Tue, 02 Dec 2025 20:09:45 -0500
X-MC-Unique: 3eLgvTNZMTCB5vv30pMT-w-1
X-Mimecast-MFC-AGG-ID: 3eLgvTNZMTCB5vv30pMT-w_1764724185
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7c70546acd9so12644122a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 17:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764724185; x=1765328985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kFZSJbUMoFREDOMf4hNQovtb4fH0ilmA926PCOmpAo0=;
        b=nIKzMiDTYTRCQ4i+WVMAO8hO/8R/+QgC48uLhbHwQrlUQqLE3T7ERgn2xcXcbj+ebC
         dqvxRyCef/6gP8xUD+L1x4sFZlvYHYnNKzrh0Pihq+LMyOPS3XZBohQsTJFtcyVM5o0H
         q8owlIQvEsPq2O3F96k8vhGHmbnR796vKqC3x5jdtD/9FkuYKYMp6SG68mzjtCC5hW/v
         uN4FOXKplyhPgVZdB1BcengjcDIiSUeG1WS7usn2SuGHHvmEQRWbCG4gJcPMPu2pfE3O
         yKxIh6pCX9OnJ8/N3DXDgEHC8qIFjHDMiyOagKtzXGxc6hEke9MWcuKJcm1taFoYBvkC
         jzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764724185; x=1765328985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFZSJbUMoFREDOMf4hNQovtb4fH0ilmA926PCOmpAo0=;
        b=NvQoeH1AKrzj7hCSLvhePj5mj7z42omjH7Iy3eGiawJpcsJsbkX4i9Ockb9A6a7Bu5
         jDn7kA0QUN+btGnpgLOZIAXPaY5o9iZc0PN7xWLbNZSMVgr1WG95iX+HS/Qgx2t8FJ6F
         lq8a4sqim54we8FdPeM3arBqsO7m6qun14aU7Soz3qi3yfeDtKC3EvqxLgHRpK015gfb
         zc8tzhNtTAF+FvJg5E5e+gjt5sklewuKGsLDf/paj3vYrix4t5wo/N/sDZUpZF6aGSOc
         FOm/6fjyFd/gqNGcl3u7JzL7PDV9QFPnnlqQWxOHv5YA7VpS8l7HHM7alrI61PoewvUu
         RBdg==
X-Forwarded-Encrypted: i=1; AJvYcCWM0NpxX+TzgntnJ7f/xEO9bF2WeRPcI2mjhCih4ulLq0vggw2IeCVk0/pii+8vBXS173vuf7jRNmWiqkA1@vger.kernel.org
X-Gm-Message-State: AOJu0YzJZohRDXl9ZaJc+1dSQ0zj+1JN36bl5jc1UOb0wNqvtXS6JhzE
	BuScmXPrRtH7P8rgXZlvtWamCuKjt/OwXvJDFAHBgXe6FAjvkCzBkLbL08jphWY/Guf92T2q/lf
	deWk29CDCeWQp9oUR3SC5sTH2Xs8qEtEACvZ02HE5qsIZj1HZ2LM1r33t0gXIRINeXOA=
X-Gm-Gg: ASbGncuOjBzhKZhWZMX3IKchL2zoK4Y/J765oWrZXTGyCLo7nkEsJEF2N+MAdyx4D0h
	oJQy6BJ5rH2KsdIk4t1a/Dy8k8aHoWT713zLec5FZQV/sJTW54meIJAtqu5NXbfsrh2vtm0d4PJ
	spxERBz6ltHwK1yS8ICo0uRtEZjTH/U8ILgFAD7O2iFQeVe0XqJXzipLTJfhy/weFQ+jUAebrQs
	etr/Ywz0RaQYrALlPrEsrnGzYR/yO9WX5nw+HDbYYAjxv6lOWkxmaM80C8OpDzXBxw53Ad8ffzD
	WAkKukEGv8TRzNJdm5Wrjqb4oLZW0UkJgti1E22RE+LhjmgSSTot4yJuIDofjxhcaQsXwBre+R2
	4SNCvixOCveEYBjEXq79hiomAB8mXPbskmo9Wupk7HPJF4IRuhp4=
X-Received: by 2002:a05:6808:30a4:b0:451:4da2:47d1 with SMTP id 5614622812f47-4536e599060mr212337b6e.45.1764724184845;
        Tue, 02 Dec 2025 17:09:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX66IY0w4jVRYgGZS3OqlgpFq++sZ6b4dlPs/qOP4GCvzDfdGtaSRW5nlyyfoamYMaSZ+eFw==
X-Received: by 2002:a05:6808:30a4:b0:451:4da2:47d1 with SMTP id 5614622812f47-4536e599060mr212317b6e.45.1764724184426;
        Tue, 02 Dec 2025 17:09:44 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-453169f6f67sm6648597b6e.6.2025.12.02.17.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 17:09:44 -0800 (PST)
Message-ID: <c1d0a33e-768a-45ee-b870-e84c25b04896@redhat.com>
Date: Tue, 2 Dec 2025 19:09:42 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/4] 9p: fix cache option printing in v9fs_show_options
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
 asmadeus@codewreck.org, linux_oss@crudebyte.com, eadavis@qq.com,
 Remi Pommarel <repk@triplefau.lt>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <54b93378-dcf1-4b04-922d-c8b4393da299@redhat.com>
 <20251202231352.GF1712166@ZenIV>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20251202231352.GF1712166@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 5:13 PM, Al Viro wrote:
> On Tue, Dec 02, 2025 at 04:30:53PM -0600, Eric Sandeen wrote:
>> commit 4eb3117888a92 changed the cache= option to accept either string
>> shortcuts or bitfield values. It also changed /proc/mounts to emit the
>> option as the hexadecimal numeric value rather than the shortcut string.
>>
>> However, by printing "cache=%x" without the leading 0x, shortcuts such
>> as "cache=loose" will emit "cache=f" and 'f' is not a string that is
>> parseable by kstrtoint(), so remounting may fail if a remount with
>> "cache=f" is attempted.
>>
>> Fix this by adding the 0x prefix to the hexadecimal value shown in
>> /proc/mounts.
>>
>> Fixes: 4eb3117888a92 ("fs/9p: Rework cache modes and add new options to Documentation")
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
>> index 05fc2ba3c5d4..d684cb406ed6 100644
>> --- a/fs/9p/v9fs.c
>> +++ b/fs/9p/v9fs.c
>> @@ -148,7 +148,7 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
>>  	if (v9ses->nodev)
>>  		seq_puts(m, ",nodevmap");
>>  	if (v9ses->cache)
>> -		seq_printf(m, ",cache=%x", v9ses->cache);
>> +		seq_printf(m, ",cache=0x%x", v9ses->cache);
> 
> What's wrong with "cache=%#x"?
> 

Nothing, presumably - I did not know this existed TBH.

(looks like that usage is about 1/10 of 0x%x currently)

-Eric


