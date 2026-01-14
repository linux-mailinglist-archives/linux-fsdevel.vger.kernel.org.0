Return-Path: <linux-fsdevel+bounces-73652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A58C2D1DBD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9FBC306F8C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 09:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66034F47D;
	Wed, 14 Jan 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z3iBphex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE936BCE4
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384359; cv=none; b=PEvjiZL1LycdnaYjjYmZQwH0rwDFyxAAtnM1qEbSe3RxzClsKHwK8o5lBKezt2hPfiYynZUGAX0aJrCH+C59nJhUnUhin9Y8vNXXuPQ/cuvamp90M43n9UOgn7QiqwAkqoDuOwTDLj7VBMCiuA61rLvR0vGOmO7BNcwvs8W3H6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384359; c=relaxed/simple;
	bh=J4dz6kKuytMo2H9dr0wYUS9WBbX2v/mYRV9CdF8Grc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOYrMG6rTu4CNib5y+/S6W2GU0ZmEf9iNJqORAqIoO1Q57blopuYveAz7oV9OLPWaQ3RMKTvWBBca1i/dzI/yq2ZOUMf5VabQ2itan6p93Stv5ZqqH7/Ck9WlZUXCkQX/xNajDjsoeac9/V4fKpr14VJ00BBw6R2PRnEkzT6unk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z3iBphex; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so92864065e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 01:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768384356; x=1768989156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KpGGSGXQLjgoeWNiePO4dkZ0AztAG/JhaIZwvTGrYOs=;
        b=Z3iBphexqbdY2HetGRPcrtkfPFcXj6HtcBSIGBdA1smtgc3s5yGbylgYjQNhOkz4bL
         DD5z5oeNasvOnv4R57yu/AbHb7TzWIXM6z6/3zujXub5e8l392BhYiTS+XUxu75/I3X6
         5KornKBOlapQ3w/dxGt2BLDxWmzFX4oPx6wrmpv437rWfXTgaeyg2ch5IoyO5jXmCTfN
         mVM2VcybbsUxB/27hQ7gEjjnOY2rFl55SxVp73hX4/WYslcmA21ADBFpPkvAYlTo4GsA
         WiTpETz+8NZL1Ro3SyfL8Oerg1lewVHClmnp5SALiVevtTF0y91CR0RZk7emkfclNFBA
         0V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384356; x=1768989156;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpGGSGXQLjgoeWNiePO4dkZ0AztAG/JhaIZwvTGrYOs=;
        b=r+9B3QsZb1rq1XEpvACAEdSRiPHiiloSj/OdvSYDYu1aiR+INdst8FVEeDStd29Ykh
         8koOxmdOMzo6r5SPAqXbcnaYFAOsdMoGT4rD8B7g1NYJrVI5XfqwOMrNfPyX7/pepseN
         NloE1wzk/v3F9Q7KWzFRIKODl/VTX+Caq0hi+WByRwF2yka2bpCRLL/crm0G/6pO8UVo
         5p/9ObNlyNVXx8b6BbAIy7/ZCy+tScCui3B5AglbnQbbOrtrU/lhw+6BoCTj9IH2d/Vg
         IeHFjWhp64ljIvHFzxhFMtMEKgaX1GN4W3uVUIgsszDifNQmCXInQcpbqH9sfPsfoWIv
         YA4g==
X-Forwarded-Encrypted: i=1; AJvYcCWpklSBRNYSG8OxcwY2zaQ1hYf9nl3QsCiuQHedfsHPn61Mehh6I2l2m8BmAC/M8B/iGWyQ/tffBMzLF0SZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyxOn48UpPTCLolS+rTFjZ5VNH2HclHSBgbYKQpgr9f2bpkMrAj
	iU8tqIgV1PblG3oPMJi4mtS6lV6XNUkoVT+CZFckh84D/C/dcncUbenQQ1AIhVgzjGw=
X-Gm-Gg: AY/fxX6VzAbP1TmlPUVyS7y27RDsrH7CGKhs6Ow+RdyMP2Tta8V3dRDFfU63Ldg7QLC
	hr7Zh1ipTur1Sbtwzl3RifKIJj9Uu3+XBZFK9oXQGHwcj9pB0eyD3nGSPQfSicSXSTQX9lA0cUW
	EHQt19gopH2UuFGKTvOvd2p91kPqTuiIzWXezJHEPvlgr1ucZ9iB5VRgH5/GZdi+Y1a9q1Sbyqg
	hijQkxvQMqrxUYEa1K5ri/1Mi4u1nb55W8vYLBd0r+Cn9Y+GTF3oPTsCXXpttRb/r1lThFYxcGW
	HoryqtdBaKFayEcsWhv0xcxw8KpOyUrrLpKLXrfeio2i9czREoKBNk60TiI4Cr00mZEIACmooKX
	vk1D1Il/iS5jslpx9KlsOZ9bpOZAHAG60ld3YG+gsI0io968vpR2XTBCn+I/ugXHN5fpzk2h9XD
	FQOsO/Xz82AagXO9kf43M1e2BrWgoUkFPqoSkOzO8=
X-Received: by 2002:a05:600c:46cd:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-47ee3305a18mr19473755e9.11.1768384355673;
        Wed, 14 Jan 2026 01:52:35 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88cdsm222064405ad.73.2026.01.14.01.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 01:52:34 -0800 (PST)
Message-ID: <f5568a83-75df-4e84-8cf0-01df6dd4e810@suse.com>
Date: Wed, 14 Jan 2026 20:22:27 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bounce buffer direct I/O when stable pages are required
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260114074145.3396036-1-hch@lst.de>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <20260114074145.3396036-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/14 18:10, Christoph Hellwig 写道:
> Hi all,
> 
> this series tries to address the problem that under I/O pages can be
> modified during direct I/O, even when the device or file system require
> stable pages during I/O to calculate checksums, parity or data
> operations.  It does so by adding block layer helpers to bounce buffer
> an iov_iter into a bio, then wires that up in iomap and ultimately
> XFS.
> 
> The reason that the file system even needs to know about it, is because
> reads need a user context to copy the data back, and the infrastructure
> to defer ioends to a workqueue currently sits in XFS.  I'm going to look
> into moving that into ioend and enabling it for other file systems.
> Additionally btrfs already has it's own infrastructure for this, and
> actually an urgent need to bounce buffer, so this should be useful there
> and could be wire up easily.  In fact the idea comes from patches by
> Qu that did this in btrfs.

I guess the final reason to bounce other than falling back to buffered 
IO is still performance, especially for AIO cases?

If iomap is going to handle the page bouncing I guess we btrfs people 
will be pretty happy to use that, without implementing our own bouncing 
code.

My previous tests didn't result much difference between falling back to 
buffered and bouncing pages, although in that case no AIO/io_uring involved.

Thanks,
Qu

> 
> This patch fixes all but one xfstests failures on T10 PI capable devices
> (generic/095 seems to have issues with a mix of mmap and splice still,
> I'm looking into that separate), and make qemu VMs running Windows,
> or Linux with swap enabled fine on an XFS file on a device using PI.
> 
> Performance numbers on my (not exactly state of the art) NVMe PI test
> setup:
> 
>    Sequential reads using io_uring, QD=16.
>    Bandwidth and CPU usage (usr/sys):
> 
>    | size |        zero copy         |          bounce          |
>    +------+--------------------------+--------------------------+
>    |   4k | 1316MiB/s (12.65/55.40%) | 1081MiB/s (11.76/49.78%) |
>    |  64K | 3370MiB/s ( 5.46/18.20%) | 3365MiB/s ( 4.47/15.68%) |
>    |   1M | 3401MiB/s ( 0.76/23.05%) | 3400MiB/s ( 0.80/09.06%) |
>    +------+--------------------------+--------------------------+
> 
>    Sequential writes using io_uring, QD=16.
>    Bandwidth and CPU usage (usr/sys):
> 
>    | size |        zero copy         |          bounce          |
>    +------+--------------------------+--------------------------+
>    |   4k |  882MiB/s (11.83/33.88%) |  750MiB/s (10.53/34.08%) |
>    |  64K | 2009MiB/s ( 7.33/15.80%) | 2007MiB/s ( 7.47/24.71%) |
>    |   1M | 1992MiB/s ( 7.26/ 9.13%) | 1992MiB/s ( 9.21/19.11%) |
>    +------+--------------------------+--------------------------+
> 
> Note that the 64k read numbers look really odd to me for the baseline
> zero copy case, but are reproducible over many repeated runs.
> 
> The bounce read numbers should further improve when moving the PI
> validation to the file system and removing the double context switch,
> which I have patches for that will sent as soon as we are done with
> this series.
> 
> Diffstat:
>   block/bio.c           |  323 ++++++++++++++++++++++++++++++--------------------
>   block/blk.h           |   11 -
>   fs/iomap/direct-io.c  |  189 +++++++++++++++--------------
>   fs/iomap/ioend.c      |    8 +
>   fs/xfs/xfs_aops.c     |    8 -
>   fs/xfs/xfs_file.c     |   41 +++++-
>   include/linux/bio.h   |   26 ++++
>   include/linux/iomap.h |    9 +
>   include/linux/uio.h   |    3
>   lib/iov_iter.c        |   98 +++++++++++++++
>   10 files changed, 490 insertions(+), 226 deletions(-)


