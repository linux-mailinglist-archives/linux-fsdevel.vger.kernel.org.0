Return-Path: <linux-fsdevel+bounces-59748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3280FB3DDC8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADB91884713
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 09:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B709A305068;
	Mon,  1 Sep 2025 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L1Bow/+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0A230504A
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718066; cv=none; b=rtiVGSAYPygJSh+LHVd0r15iKaM4WnKtTw+pfRgYwR26Y5+Zzep31VqRTYn6FKtM1/AcESFXgko52T5AK4ZL21waCspTy/o4Ft7xJ7amZp3xHS+iIq6XC45pe+m/l0fe26eu7ofgNH1ssWqeCi3o31r49u84ST0VVAXotONPwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718066; c=relaxed/simple;
	bh=uQ85KgfjiIZLekYRGT24c+SqyVX6seLzotf4gZBu12E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=e65bh7PgRTKbG7pZprxcM12XVa60o/TMheEuHE/iOidnH6NjRexxa4IPZlsb4qTO/0vZmygXcSQ7aLiqQlIvFnpAHjRh+CqFGU8zYLpxy3ZV4kLvsjmvqrcWBXbSpFHI5qlWi42B+1q2WoIiOdGG984IHpQodKF2Y37pPByZTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L1Bow/+m; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3cef6debedcso1731162f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 02:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756718063; x=1757322863; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNZG/wPRsZEEsO2B+mQ26lIrxqZ6nOyCSqN70b8c0Eo=;
        b=L1Bow/+mKJqX+7nfCYwR/6Qm6rF7GHhGiuCaq9Hfi488hc8KBJgHMWjHv1bvI6vOnC
         Kq1qNjqRwHgfTumU3kCQSfJkQOG/6UusFYmO0hmpfye4Xb8Q4HA/mzy342nmSRqgwOal
         YOXZfY2K9lSEt/YwMXDYkpQbuHT4mKtuw5ErWBfsgNwysk7MhsKYDIOzctLqDhs5DZCC
         +ftfSZ3+tkRyU7CpPhyPy+gHyI536M7Hn9ZT60K76ao2xMPImaqjVmKprTM0qcwK0sXB
         YJPuXlqol46I9kDa6RsHZbNGsDluvFMnLC708PsY0wTNBafs9+qLbdw+hfX4fMKgwyOH
         SnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718063; x=1757322863;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNZG/wPRsZEEsO2B+mQ26lIrxqZ6nOyCSqN70b8c0Eo=;
        b=FaGq1bYS4ScxSaRVdgZMNDac613e4SrPcTK2ow3ROdaZXyENlfI4tn7gb2LqIBbSvP
         a0Qzn8YiwuzInZg3H/y16o9jDRNIy0+ae8SrO+qYu4VaSOV+Qf3Vwzk5/eElA/J2acCo
         /qnmLwoUTLgRVPSIasonevhH79xtbJ8pXVCfFSl+1s7xeOaQfdiS5B2GYparHm3wQiWj
         a8UFVhi6dBn/5TxtqAg96hHGosQd2gdm2DM7JmzcqsqU9UNqL7N7Gi72CsToAgQ+zpi0
         4YVTYF0GOTkDSU014sPKcGWE/S/smLs2TCtL+J1Aoje/gBHED6ZSOeKCVJgPaCzCsH6E
         oOcA==
X-Gm-Message-State: AOJu0YzfIeWM++CEjEJnLzEs5yI8Kvx2am4C/3nG2hhYIytTfbdezSJU
	63qnYZ/cnu8UutIMYcekgLAangQfoKnCg7oun+aIQ8RExiAphwwN18cCxeFJ9AFyVmZb0XQWCuW
	Lm37G
X-Gm-Gg: ASbGncuA8F04NfOVr+uNG/g+AX6Bp74Z8y4r6G3P/A3INPIZdjQquNFTN4PdsLeqNbw
	xKZn3Yavtnuti+8gs3OYtmpBNBhx/asbENXjAeNivrFWCGaPqGzuZ0V32whPA6+BPBp7GJaTgya
	yVzxzwP+1cdBAiYV50DObiF4GIVuRyXX0CA7NVjVNqslKOGJjH/Ia9AmMwsclXYEhkBl2JdBwON
	ooXaiflZXPiDl3eIn36clSjiqBumNmgHYGRfpe7ogGDfN925exdyBJjANKpzgO+DviRSZBY5ByW
	UBz9IXRYp9M2+H208QB10DSvdQ8Ub+SHa2U0IqyDeM5AoClXbNdTxudTK9Mgjl4+pYFnxpSV8IV
	r4TenQHJODnAMkj1iwvTo2Y80lVHrdjPeFowlGukXuO8YgHWQTk/BKVSDQhVhrDG6fWL/D/Vt
X-Google-Smtp-Source: AGHT+IHoZDuDbi7ROhf/p2Mirpmp7nlPzCdEgOrF1D+ixoJO+T4bFMreda40Wkr5nl4Q1bOelRz6PQ==
X-Received: by 2002:a5d:5846:0:b0:3cb:62c0:1eea with SMTP id ffacd0b85a97d-3d1dcf57a13mr5727958f8f.25.1756718062553;
        Mon, 01 Sep 2025 02:14:22 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903704379sm99020515ad.29.2025.09.01.02.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:14:22 -0700 (PDT)
Message-ID: <8764ecf7-357a-4109-a957-64c3c3dd7842@suse.com>
Date: Mon, 1 Sep 2025 18:44:17 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <wqu@suse.com>
Subject: Highmem, large folio, and bvec. What is the proper interface to
 iterate mp bvecs?
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Recently I'm trying to add bs > ps support for btrfs.

One thing I noticed is the bvec_* helpers, like 
bvec_kmap_local()/memzero_bvec()/... are all for single page bio_vecs, 
meaning bv_len and bv_offset must be inside a page.

This means those helpers will not be able to handle a large folio in one go.

On the other hand we also need to support HIGHMEM, which means we must 
call kmap/kunmap helpers for each page.


I'm wondering will it be possible to handle multi-page bvecs in fs block 
size incremental, without falling back to handle sub-blocks using sp bvecs.
(Of course, all the folios queued into bios will have proper minimal 
order to cover at least one fs block)


Bcachefs is doing the separate handling for HIGHMEM (kmap + kunmap, sp 
bvecs) and regular mp bves in one go for its checksum handling.

Btrfs for now is mixing sp bvecs (checksum verification in block size 
unit), mp bvec (mostly to calculate bio size, so harmless) and folio 
iter for filemap.

Can we have a proper mp bvec handlers? Or is there a way to exclude 
HIGHMEM folios from filemaps completely so that we can just forget 
HIGHMEM for fses?

Thanks,
Qu



