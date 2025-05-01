Return-Path: <linux-fsdevel+bounces-47793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32494AA59CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE94A1BC2D4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 02:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A8422FE10;
	Thu,  1 May 2025 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Bj7ap4Jj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD0A53365;
	Thu,  1 May 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746067727; cv=none; b=iQFiQkayNNp6JFkZfd+UR8NvVIIv/l3YkTRdivGLiK+T2V/d816NCheYUbSal/n7UbqWRhWpzmVicIRdZrkSqUvR/TkFKs8+2cEu5km4hosNpmIG3FkJkN4UymxJNEUJEyeO9f1EfuFWqg1fPh1cs9tLY//iFfZfVhk5okInkRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746067727; c=relaxed/simple;
	bh=SiR8qUZCHcaaM06puI2UAqKKAllCO1PPU9VZ+0A/yzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfeggEaW5XX3OZrLN7AJaRuF/38IY0fm78OLC9VA4YUtPC2PWH8ciabzOqJ53NqF1DW2VbOdbo0b/3D0TiZjzU0hKo5oa6QoxbbKSfa5YHO6Q2Lx+3ew7GmISXeGpGjyN7KzZA+W/SqV2YLYoY8e1idcjKn6OGigKBC1IW6BqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Bj7ap4Jj reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9485:ffb5:969f:14f8:8aa9] ([IPv6:2601:646:8081:9485:ffb5:969f:14f8:8aa9])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5412mQDW1193808
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 30 Apr 2025 19:48:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5412mQDW1193808
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1746067707;
	bh=7PRkK9qqVbjo+7so5yHj1jsP+OQZAeYuOWlcUQa1x8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bj7ap4JjvS2526GBrqy6wR3W7Q4NgXUX7C1Nii91CwwfCtDL2OK3p/Rns92gK8E2s
	 TfuXIJPqMHYQeH2OfG+y3uoaNw740EaLDQWtMKLAkZV3hoIGb/3tnfDtmk1WjVBfjF
	 Q8fQ5h7U2e/L5rv2db7SDC5YCA36m73dAj797nuftG5TjNdlRXwJcVmeKRN8kW+mZs
	 /IoBdiwJDoOF3ap5kcCVIdBTUiaWg5uXOZLmvmIJKlEKfZn0l0mVCxkoBkiyZxAnTE
	 HEHcQw78hBdFKzZDKeRsDRleHp/CPqQzz+6cAKUGeR5zfkDgaIfgyWHf5j2P9ZOpy8
	 TyTFGrGY/uL6A==
Message-ID: <d87f7b76-8a53-4023-81e2-5d257c90acc2@zytor.com>
Date: Wed, 30 Apr 2025 19:48:20 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <20250425195910.GA1018738@mit.edu>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20250425195910.GA1018738@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/25 12:59, Theodore Ts'o wrote:
> 
> Another use case was Valve who wanted to support Windows games that
> expcted case folding to work.  (Microsoft Windows; the gift that keeps
> on giving...)  In fact the engineer who worked on case folding was
> paid by Valve to do the work.
> 
> That being said, I completely agree with Linus that case insensitivity
> is a nightmare, and I don't really care about performance.  The use
> cases where people care about this don't have directories with a large
> number of entries, and we **really** don't want to encourage more use
> of case insensitive lookups.  There's a reason why spent much effort
> improving the CLI tools' support for case folding.  It's good enough
> that it works for Android and Valve, and that's fine.
> 
[...]
> 
> Perhaps if we were going to do it all over, we might have only
> supported ASCII, or ISO Latin-1, and not used Unicode at all.  But
> then I'm sure Valve or Android mobile handset manufacturers would be
> unhappy that this might not be good enough for some country that they
> want to sell into, like, say, Japan or more generally, any country
> beyond US and Europe.
> 
> What we probably could do is to create our own table that didn't
> support all Unicode scripts, but only the ones which are required by
> Valve and Android.  But that would require someone willing to do this
> work on a volunteer basis, or confinuce some company to pay to do this
> work.  We could probably reduce the kernel size by doing this, and it
> would probably make the code more maintainable.  I'm just not sure
> anyone thinks its worthwhile to invest more into it.  In fact, I'm a
> bit surprised Kent decided he wanted to add this feature into bcachefs.
> 
> Sometimes, partitioning a feature which is only needed for backwards
> compatibiltiy with is in fact the right approach.  And throwing good
> money after bad is rarely worth it.
> 

[Yes, I realize I'm really late to weigh in on this discussion]

It is worth noting that Microsoft has basically declared their 
"recommended" case folding (upcase) table to be permanently frozen (for 
new filesystem instances in the case where they use an on-disk 
translation table created at format time.)  As far as I know they have 
never supported anything other than 1:1 conversion of BMP code points, 
nor normalization.

The exFAT specification enumerates the full recommended upcase table, 
although in a somewhat annoying format (basically a hex dump of 
compressed data):

https://learn.microsoft.com/en-us/windows/win32/fileio/exfat-specification

This is basically an admission that the problems involved with case 
folding are unsolvable, and just puts a tourniquet on the wound.

It also means that "legacy OS compatibility" is really a totally 
different problem than "proper Unicode normalization" and that the 
former far more limited in scope.

	-hpa


