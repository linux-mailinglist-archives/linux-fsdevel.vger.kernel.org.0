Return-Path: <linux-fsdevel+bounces-23802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD6793382B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7358F1F22881
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 07:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E501CD2F;
	Wed, 17 Jul 2024 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bKNhDQ1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE131BF37
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202155; cv=none; b=M9m9TiyJMF/rNo9mtvnmd5wmMpiFBJE7hlHxHjYXladQScOscWEUi9NK8Mtnsk0wDviF2/Eqnwmjtdwl/7CvfAsph8zN44TkcPPRF0CII7T3cWM1ZloCtcipklrS6uW9JvIBW0wdVhMFwUw2B+pStekySCuRusq00bbKfMWuLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202155; c=relaxed/simple;
	bh=lSLC07cWgDtQxlP0/I5aHy3V2kujSc6et2iDzwJlqi4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=MHE5RI8Z1wFwU+1yn+2In5pZQfEchn9hn4OhUT4FCVPwagBQjIkSjrr1GeWu4O58ff2Twtk1/kwrtKxpLApAeHAEuEldxrC0YYKDCbRgGrfIGJcZfS9ig6CZ/KfjKsHWxoZh4ilX1XSE2POjjpn9onDfBjeblZfvqPyXuDhWZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bKNhDQ1y; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e9c55febcso8428512e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721202150; x=1721806950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovwn3DW6TedKlvHEbgoQx/5Vd4igDUlWIvl8s9WQmRU=;
        b=bKNhDQ1yjRmmYLayq3yw4+qDpdln2jjKus4BLXWvtS+ss4tLTy8zLkxeKw6V/XEn+b
         dyBWm24daUS5fUMTr28YHowcS1ckqvR2cBVpDbnAmaHHZNC+4VGv9tJeKciiiXunOp5j
         I1bfXRumxYshX+QHBnBijCVBMbMbxOZns09Rwa3ePsCE/ivo/dhEY9t2iS0lg0+/xHZL
         krkDuH6VUkcYPjyC0nCPa2XGmb37AhAHgDUnmUvrHVxFE+1eeSh57KxL68aYrYlU3Yzg
         vPyLFcANOjHxoXsHgWg8Ggtngm9LEuwAMIVYFHBTYBclh5I5N6w8vZU9RK4ZOOlqPlH4
         Eqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721202150; x=1721806950;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovwn3DW6TedKlvHEbgoQx/5Vd4igDUlWIvl8s9WQmRU=;
        b=EQsfIMqRaww/nNE7YKzNWE7zF0AXODTr9MN8+8yxjFwnc7dv3s6xX818490Zs7s9No
         /fpCsRTs3of87aN1VhWaJne7v+aPRv1wFI94PPJ1CwgFOQGQ71CNujKpCUMrVRxJ4DwF
         Snfy+5VpMRfg3uA04NRkuIq7XyauEAP6kGHT8f3Pd60scK5y4vNJEp8153tADNSzChen
         W59BDwlwylzQ+UiZSBrtCl7xQ88Rgze7RQYQ9KvfsT6a0XD5W5KJq5YjH/VutybOpftU
         9gotNRVx25r1BrlJ7CLA/SI/2PAFw8jYdoL+VB7sGXqO6iOEESgXvYhD9dqhec7oZOt/
         /oYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/vAGlhCYAJ5DgMEGdJAgojIlQFtREoXgpQUX0N2Cpv55FDoR944TkoGN1mwAn6mlsc4rtK8KE0IxFWWAeWFy0g5QMsDNEcxXLkgTHRw==
X-Gm-Message-State: AOJu0Yw6kunvfWqjHMPhLFROQfCGdcIq7jRj9DK37iKCzFcCnjegXJ+W
	Fv787ZDsOChQhXgigP0XWTOA1y3EH4zc9aZcmpx0co7x7bbRZmphpxa0h7KGISA=
X-Google-Smtp-Source: AGHT+IEbmvUx2Tku1m7n3VYmkCoOi72VBlj6R2Ay0fT/hCS949+rAMA+wRCub2dH2lx/PEDFiZ28Nw==
X-Received: by 2002:a05:651c:14d:b0:2eb:f472:e7d3 with SMTP id 38308e7fff4ca-2eefd04fa1emr6949041fa.6.1721202150087;
        Wed, 17 Jul 2024 00:42:30 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc38a81sm69966755ad.220.2024.07.17.00.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 00:42:28 -0700 (PDT)
Message-ID: <ebdafb52-e538-49c2-89d1-5894dd5382a9@suse.com>
Date: Wed, 17 Jul 2024 17:12:23 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <cover.1720572937.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <cover.1720572937.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ping?

Any feedback?

I guess in this case btrfs is really the only one can benefit from this 
feature?

Thanks,
Qu

在 2024/7/10 10:37, Qu Wenruo 写道:
> Recently I'm hitting soft lockup if adding an order 2 folio to a
> filemap using GFP_NOFS | __GFP_NOFAIL. The softlockup happens at memcg
> charge code, and I guess that's exactly what __GFP_NOFAIL is expected to
> do, wait indefinitely until the request can be met.
> 
> On the other hand, if we do not use __GFP_NOFAIL, we can be limited by
> memcg at a lot of critical location, and lead to unnecessary transaction
> abort just due to memcg limit.
> 
> However for that specific btrfs call site, there is really no need charge
> the memcg, as that address space belongs to btree inode, which is not
> accessible to any end user, and that btree inode is a shared pool for
> all metadata of a btrfs.
> 
> So this patchset introduces a new address space flag, AS_NO_MEMCG, so
> that folios added to that address space will not trigger any memcg
> charge.
> 
> This would be the basis for future btrfs changes, like removing
> __GFP_NOFAIL completely and larger metadata folios.
> 
> Qu Wenruo (2):
>    mm: make lru_gen_eviction() to handle folios without memcg info
>    mm: allow certain address space to be not accounted by memcg
> 
>   fs/btrfs/disk-io.c      |  1 +
>   include/linux/pagemap.h |  1 +
>   mm/filemap.c            | 12 +++++++++---
>   mm/workingset.c         |  2 +-
>   4 files changed, 12 insertions(+), 4 deletions(-)
> 

