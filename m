Return-Path: <linux-fsdevel+bounces-48304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BFAAAD123
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 00:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7366F983E72
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997F621C17D;
	Tue,  6 May 2025 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEW3fLKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D64B1E7D
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746572013; cv=none; b=ohZHYFk4F3TICgRxxjBZzOBT8SjWxpFkUTcBh5JxFn8GLlJM/qYkIbSC9rlk9rQl9KfFMTeLfsUzAMz3Ia5OsaNYIb6B3aCnrSPc5eDrdwe6+XnCOHKvJALGkzZ9RA27MYvJKk6CjfztJLkOu6GO0WYTpvJgJNc6ESNw84MdSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746572013; c=relaxed/simple;
	bh=c6P9JatYlTIJ3jxF0l+Iv/68k6f2OAYUX4a8MeLF17M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhb4puRbPkZ24c5OWth9rN1kXuNLFolSXyW91LFu8mWwZUzLeRc3k/KEvF/GHJymY1ERbQRo3f5rkllBGSPuRYZ7DF+HhW4HNAtgLOaFSmVYyaPqLuNKSlI2oBJhcYMYcmOu6SUVbOfGfOilsi6lK3Aio/CyqTegegpyh4uLqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LEW3fLKu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746572010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0llTU71+wuu/2lptpCidsqva8hziTGM/xjlJt2eiFv0=;
	b=LEW3fLKu+7AJac8Gzgsh2n/23i++OT708WD7670aLaPi82gmhhB+YGPHLVEjlCYQyiCgfP
	JOlvU8rLjeUGaF8rExGz33wIejyFTp5rhpwmXqG2Sr3MdJdJ9Ri0MPrWziAjqLUfN9mNdZ
	vHEawpEVONt8r5vW8qZTl0/pJRVhi9M=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-NRejkD6GOqGDaPfKr5ikew-1; Tue, 06 May 2025 18:53:29 -0400
X-MC-Unique: NRejkD6GOqGDaPfKr5ikew-1
X-Mimecast-MFC-AGG-ID: NRejkD6GOqGDaPfKr5ikew_1746572008
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85e318dc464so1045647739f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 15:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746572008; x=1747176808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0llTU71+wuu/2lptpCidsqva8hziTGM/xjlJt2eiFv0=;
        b=sf+pE0WDlgaPNmlGSrspfyRpdYFHo5C9GxQtTBb4uJ0FMiWfr/IzbxAvuxOvQsWN5D
         YDvyFDp86LHSgCGkldKHqgJv3NkwJJoigcOLlZAyGpql7dKF0dpoUcs/PbNKPuyzf4Ff
         LKJYsNKPduE/CNVVNTd+fRq6Hl/6jN8HmWb/0F7BGGpWUV5fhTz3ciYzWDIued/l87BT
         p9JCKpcmpPmiLl9+cC9eOMJlgIZLyweKB2m0ANj81T2OPIFjsovkFrC0Y7QRe2B3ZEgz
         9JfIGcHt/1FanETux1sdbr8c2IRuLMXnpr40ATjjXwP54S1zMJEkiK/SgDj90WQ8wQbq
         PRnw==
X-Forwarded-Encrypted: i=1; AJvYcCWeECTogEcAbDiBjtCjFNhPeHLBpLYhZH9gLtkLSfVcuJwgcRvVl8AFVCrLJ0f/H/sh4WKuYVyHtHrWN1sv@vger.kernel.org
X-Gm-Message-State: AOJu0YwRXDp01Dg3q2EC0xbj2S+2QPmOHWuXz+RFwDjfnqtGVKayPdCe
	cMLP28OkdSwVYNSs1SCUtOYK7prCBjp9nteuckU8SOEcFfcIch40cppFDmItdwMf3TgsSGrFFo4
	gT9kIBLfRLYLdxNk8GZ2KjDXo5UVITB0g/r0mQAXlb7HGIUcfFIxiIelxe05BHPI=
X-Gm-Gg: ASbGncvxPT9pn+Q2zdVltPmKB9XmyGyBeHpL+qTNSGkuk+Sz9EIXkRNzEdrtzi5/OAS
	3KJFWmXNMBdTcSEL527leMhUkced/tso7OOYOwAO3RlD0zcgbch2Xn4D6G1yeFp3R1b2wf7U3iK
	7f4KeKzXWElN7VKz996e4ywWOFjOz5xFk08e2nT1HQ4zbDKTD919q4OuTBIR/dfhNccvSYxx/mi
	eSq+XCKTF2HCTVTERJUprTVdNn/TLqGU33e/Mqawz4/6KOveqlq64d5N4lQ2TJ1wKP8Pk+MLnwH
	sU0M0cYYeDtPrHB1t1/OpbBeYc01pW87BkHb7ZJnREe9UumTUfnL
X-Received: by 2002:a05:6602:27c2:b0:864:4890:51e4 with SMTP id ca18e2360f4ac-867473b4e6emr199815639f.14.1746572008611;
        Tue, 06 May 2025 15:53:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLPyyvxoe9dOmqV4WB9DwYDkCW3IHrn9dC/80+fDwmnvpf0tcNHGSXbhPRHkxHvBRJErqXGA==
X-Received: by 2002:a05:6602:27c2:b0:864:4890:51e4 with SMTP id ca18e2360f4ac-867473b4e6emr199813639f.14.1746572008357;
        Tue, 06 May 2025 15:53:28 -0700 (PDT)
Received: from [10.0.0.82] (75-168-235-180.mpls.qwest.net. [75.168.235.180])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa2b98f9sm234010739f.5.2025.05.06.15.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 15:53:27 -0700 (PDT)
Message-ID: <118242b9-b64c-46dc-aa5a-99791c071234@redhat.com>
Date: Tue, 6 May 2025 17:53:26 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] f2fs: new mount API conversion
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 chao@kernel.org, lihongbo22@huawei.com
References: <20250423170926.76007-1-sandeen@redhat.com>
 <b673458e-98b6-42ad-b95f-7a771cd56b03@redhat.com>
 <aBoys-gkIcu2AARF@google.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aBoys-gkIcu2AARF@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 11:02 AM, Jaegeuk Kim wrote:
> On 05/05, Eric Sandeen wrote:
>> Hi all - it would be nice to get some review or feedback on this;
>> seems that these patches tend to go stale fairly quickly as f2fs
>> evolves. :)
> 
> Thank you so much for the work! Let me queue this series into dev-test for
> tests. If I find any issue, let me ping to the thread. So, you don't need
> to worry about rebasing it. :)

Thank you for queuing it, and Hongbo for the original series. Please reach
out if you encounter any problems.

-Eric

> Thanks,
> 
>>
>> Thanks,
>> -Eric
>>


