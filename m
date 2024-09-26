Return-Path: <linux-fsdevel+bounces-30142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64D986EBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 10:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC36B1F22CB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 08:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198C7135A53;
	Thu, 26 Sep 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EvL2P/Kb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3710188CB8;
	Thu, 26 Sep 2024 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339117; cv=none; b=ZijmI5OHduWcnwB3RfJ5bqJBXL6P5uJHl/UXfE/crHl+fJDA8D3z7RCAnjlKRzi2i5ujcl/odr3i0umLIIAvIuGFV+hqYDjAaV52C14t53jSTVn2DIUR9fuqfZjfKMP9Esa9V5wVsJcmR2CcGW3dQDXtPjOubF4lwIHgKA/i2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339117; c=relaxed/simple;
	bh=Dk3nLSd80JhfGjSp5EHO2aPMGizzZ4RiwipSe4RcKSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeXgTFtiwnzlwTrBGvUpgWHG6oVxPThg4FbusWMLgY5braf9W1sVMq0slEvvhsIUo53J1pjG+ehsR2DVhD1Ko65JzIbkIZvrLZ7NT3Jk5saTlLbf7XLmYDsFfN7SiqDZ1JSIhijmK2UH6KRSIqoxwA2cvajnV+hO4ZWsD7C39Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EvL2P/Kb; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727339111; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PKsWARor3DVvs3wWB30YmVXctqsq0fmGOIDstG8XMAg=;
	b=EvL2P/KbM+qkrmSGBt2iny2gM3F+5rs6x9bFeO0vlmoKZbGKgHr9P2ggVy4Kr4cFXk8MCeCnXXuo+nMt7RFlf2TyzJ19pilQar6IasM0cP6fwUEipWmUQfo5Faom/wbLxC+6/1IjrXg6WVjMfBe82aPTpfyqfUiGHo9EWrfNfnI=
Received: from 30.221.129.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFmjSo-_1727339109)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 16:25:10 +0800
Message-ID: <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
Date: Thu, 26 Sep 2024 16:25:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Gary Guo <gary@garyguo.net>,
 Yiyang Wu <toolmanp@tlmp.cc>, rust-for-linux@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/26 16:10, Ariel Miculas wrote:
> On 24/09/26 09:04, Gao Xiang wrote:
>>


...

> 
> And here [4] you can see the space savings achieved by PuzzleFS. In
> short, if you take 10 versions of Ubuntu Jammy from dockerhub, they take
> up 282 MB. Convert them to PuzzleFS and they only take up 130 MB (this
> is before applying any compression, the space savings are only due to
> the chunking algorithm). If we enable compression (PuzzleFS uses Zstd
> seekable compression), which is a fairer comparison (considering that
> the OCI image uses gzip compression), then we get down to 53 MB for
> storing all 10 Ubuntu Jammy versions using PuzzleFS.
> 
> Here's a summary:
> # Steps
> 
> * I’ve downloaded 10 versions of Jammy from hub.docker.com
> * These images only have one layer which is in tar.gz format
> * I’ve built 10 equivalent puzzlefs images
> * Compute the tarball_total_size by summing the sizes of every Jammy
>    tarball (uncompressed) => 766 MB (use this as baseline)
> * Sum the sizes of every oci/puzzlefs image => total_size
> * Compute the total size as if all the versions were stored in a single
>    oci/puzzlefs repository => total_unified_size
> * Saved space = tarball_total_size - total_unified_size
> 
> # Results
> (See [5] if you prefer the video format)
> 
> | Type | Total size (MB) | Average layer size (MB) | Unified size (MB) | Saved (MB) / 766 MB |
> | --- | --- | --- | --- | --- |
> | Oci (uncompressed) | 766 | 77 | 766 | 0 (0%) |
> | PuzzleFS uncompressed | 748 | 74 | 130 | 635 (83%) |
> | Oci (compressed) | 282 | 28 | 282 | 484 (63%) |
> | PuzzleFS (compressed) | 298 | 30 | 53 | 713 (93%) |
> 
> Here's the script I used to download the Ubuntu Jammy versions and
> generate the PuzzleFS images [6] to get an idea about how I got to these
> results.
> 
> Can we achieve these results with the current erofs features?  I'm
> referring specifically to this comment: "EROFS already supports
> variable-sized chunks + CDC" [7].

Please see
https://erofs.docs.kernel.org/en/latest/comparsion/dedupe.html

	                Total Size (MiB)	Average layer size (MiB)	Saved / 766.1MiB
Compressed OCI (tar.gz)	282.5	28.3	63%
Uncompressed OCI (tar)	766.1	76.6	0%
Uncomprssed EROFS	109.5	11.0	86%
EROFS (DEFLATE,9,32k)	46.4	4.6	94%
EROFS (LZ4HC,12,64k)	54.2	5.4	93%

I don't know which compression algorithm are you using (maybe Zstd?),
but from the result is
   EROFS (LZ4HC,12,64k)  54.2
   PuzzleFS compressed   53?
   EROFS (DEFLATE,9,32k) 46.4

I could reran with EROFS + Zstd, but it should be smaller. This feature
has been supported since Linux 6.1, thanks.

Thanks,
Gao Xiang

