Return-Path: <linux-fsdevel+bounces-69277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 476B1C7671F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 656D529DFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 21:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FD230AABC;
	Thu, 20 Nov 2025 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K0yiu0qc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171C7272810
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763675928; cv=none; b=gDBZfSnW82+NwsCPAm8W6p7uWZEA3y38W0MWrVL9SqgCdA9pLZ4ch4F3NU2Pml2l9i6m7A56G8CJ7Ap6Xzt4evIl2CekIt+PCw30L1to/Cjf+29iXpAtNQOrd7S09wQBf7YdOP4M5ZV4k7FI94vgkZcmiPcpwmmZk3GQfJOcU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763675928; c=relaxed/simple;
	bh=XkqQKqdjbsDGit7r8PwSbQ1ITxH9cSx/AvqNbVgL654=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=l5d481fqGldN7Qea67Dc2EFpIz6TJ2HD7MoYQsspdQtoy7l3/V1hZbytqZTIlwfbTXawpQwvQtGTVngqEY5tswzo19kWnPzSVN6xauNfahwihHt8Vmy/aqRVEZhYVsYq4lf7sGZUsAEid/Sz6D3bNl1hKETrnM7RHZxZ9efGQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K0yiu0qc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477b91680f8so11639095e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 13:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763675924; x=1764280724; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odrOFQz7SA7CqvpfhSgnCp8rueLsVlj4Xs2HgLIndY0=;
        b=K0yiu0qclIbR8xDzZR5YCuFtvn0Qaces8m5bg5+bZLKtSCRuwbJSVdxZ01kxwbH3Xq
         zmh1rQadCNjaC0UbpwpFECyR4Sbw+lKQoVrNmISNV43d7YHsO6riNf6U2ECxDv98FK2f
         y5JXjYu/MF3GTnMrQIrtkHTUOO1cm+EXFGu/n4GT8rVX6A/obKRQbeRthGmlk6Ocd2vE
         cULlCCKlfhWj95vuvS3Tm6nkRayDTiUyabZCs1v+a6EQk8ZxNrxI/bYY17O3k3haIJ3U
         xFMCZSciGtiAGsxY1z4Bkcx+OxHOJZHmXBZxoVcJl7wNpUl86ysQZ8RztdaKP8htvicJ
         Z6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763675924; x=1764280724;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odrOFQz7SA7CqvpfhSgnCp8rueLsVlj4Xs2HgLIndY0=;
        b=Y6VCVNO77yHhyt4L+r85Ao8V7D6LXR8Cq7eU8vvHMCp4pKyg7XCxpE74WBRW4Aj8Vv
         A4rcjFlmOi/gzJK+cjbHJPRwujQLnYESN+T3bD1uXuiCin0O7KbPkKqXEn6MfZKCN2KB
         Ei2aGPVfe2enYSirD+SSHyWQStUcr0J9QK+TVcB3WHgVJ4KiZswLgFncnMDhJnBrc6Sj
         baL0MEd0MoixXuPRqz0r2LessG8HKIZpYFg7rOruR4zPDMpXr+sD2PkTIMdvQvG1g9W1
         k1RCZPu76UK7kUTshuz2W2quy1fY5kz+qfstWhR65pbr2eoP1U0aBSUDk3j/l1/1FAOj
         8LxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDQvQT8T60QlBpmW5qFjwJ2MEz1vwH7iC82uvsTdmzAx14ZZBSNqmX7he1Se8RVD+F2HsTclQw8ljHAD3q@vger.kernel.org
X-Gm-Message-State: AOJu0YzkaYKBa26NruP8snqAV797wGZ99ve/PvDfIAfcYJMVnrwa/kHM
	b3wTyEULnIrTSlFomnH7vVvqGPIjVjjFj6fpLiRXuBZ5hQN0dxs5sRhL2pzShWOglZw=
X-Gm-Gg: ASbGncszsKzZKaxmPYp3zDTj8rC8ucarqorYRqNlOy7loyvey5262bg6kEYaXkGyPnL
	Vl/e3N3mSTX9tDPmxHgFN6OVoOiPTuhzSNN9kVn6pUifAsIYjBPhzegeogaLM0ul+gV+3sx7gCl
	U6t+bH3+nGBLtdjzHr9RtzrViXKRaOZ00W1q18tojm/q3boZ4I/waMqMBcdju83LI1ndDkj45y4
	OmMcsXVAS9XyG7s9pUAKy2SRbbDLq+08kW62L4s2LCXzefH8KDrzGcnmpbStXAOpOGax/XBViWJ
	RD4o8YR5Pz95UjDIy6nWzeXSac4BI+4ovFpEh6ObU3jWfXlxJhr+W/ckWvX7t8Rd53eMB5eNOXT
	ODk697lnpvt/Ye50roXwr5e+gmwQUr+vC2K0IcavURdLpbZfG2bANhuk9B26cTCKXcpsZt71zZy
	xxtisuEclISHfUKZ9EKRJ+01r8pl9MmMC7qwTfsNI=
X-Google-Smtp-Source: AGHT+IGWFAtqLbFkh6zdSpivlG0zW6mgA2/Oc7afE8qcU2ureWlzGu+bD8EkcyUbHSjDAB1s3Pn4OA==
X-Received: by 2002:a05:600c:1f0f:b0:477:fcb:2267 with SMTP id 5b1f17b1804b1-477c0163336mr2047995e9.8.1763675924328;
        Thu, 20 Nov 2025 13:58:44 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af1ed1e7sm4904088a91.1.2025.11.20.13.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 13:58:43 -0800 (PST)
Message-ID: <48a91ada-c413-492f-86a4-483355392d98@suse.com>
Date: Fri, 21 Nov 2025 08:28:38 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-crypto@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Daniel Vacek <neelx@suse.com>, Josef Bacik <josef@toxicpanda.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Subject: Questions about encryption and (possibly weak) checksum
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

Recently Daniel is reviving the fscrypt support for btrfs, and one thing 
caught my attention, related the sequence of encryption and checksum.

What is the preferred order between encryption and (possibly weak) checksum?

The original patchset implies checksum-then-encrypt, which follows what 
ext4 is doing when both verity and fscrypt are involved.


But on the other hand, btrfs' default checksum (CRC32C) is definitely 
not a cryptography level HMAC, it's mostly for btrfs to detect incorrect 
content from the storage and switch to another mirror.

Furthermore, for compression, btrfs follows the idea of 
compress-then-checksum, thus to me the idea of encrypt-then-checksum 
looks more straightforward, and easier to implement.

Finally, the btrfs checksum itself is not encrypted (at least for now), 
meaning the checksum is exposed for any one to modify as long as they 
understand how to re-calculate the checksum of the metadata.


So my question here is:

- Is there any preferred sequence between encryption and checksum?

- Will a weak checksum (CRC32C) introduce any extra attack vector?

Thanks,
Qu

