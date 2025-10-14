Return-Path: <linux-fsdevel+bounces-64082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF86BD769E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 07:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6282E188FABE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282C3296BDA;
	Tue, 14 Oct 2025 05:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TMa9tT67"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1032874E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419572; cv=none; b=lgw/hID6KvJ7T4LAmMFTtGI5GJlkfgDfwzY5S9RTqM6V1YSdlY8SSEj/Ze3IeVRMsYOy6f9K3vyF+Ob3GqeQquZOZp0iWXu5bWS/m4CpNMNg5oFrDBCTieCmEAMKjUKNyQQjhyh5DdBdnicjrUr0z9JnGRwjE6saBlDl1LAVMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419572; c=relaxed/simple;
	bh=RzZ2rpgYX4TU7MT3Xglqz4bP41cT5Oh6ggAKNbiU4Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9IP0K6IysKF+H0G3FL+jHO98irGfvce4Y+NnLF2VaoHCLYKCrjaSyFJ4zZ+wQqkrRXpFPsb9ROVYmg4WveJwb1SWLXsUj69QbSPLg9WWe/Ayl+zN9RzEPdIVETMuhJiIZgwTXm0BR8JQjj/GNdjo0DXySKRbtve7DEiqeI+x/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TMa9tT67; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee1381b835so3043931f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 22:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760419568; x=1761024368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PJeA08PmXO0Rt+J6zqTRksSe9Q2LhvStVnJgFH8knlE=;
        b=TMa9tT67BZUz1dqoyEp7c7boJbzouJq/CFRT9LOK/U9xCWA5vMvOBkUMWgn1smAdp2
         Brts+rKceBUpEtfxGyevkKllE57ptajVK/Eu+A8iHkucCdATPSb7WIDXOtz6HOW+wi8c
         b1G1G1SGA/0IJoBMYoH4XBtKaYKWhWcsl9aYGRNKlerxCDvmJYHTMEreFgZEsBR8Pczy
         DqEx2WUacQh4R5Seu9dNoTTBFl7ELoBSytZUQrIisqCRVSA365p2yHsi0zsaQBMQuVbb
         E3kJOKe+LmCfVnqJnKd7m34sLRZxcDWH0bJ10MP4uqwq0ZluEixXFBM1cuY/BJQNMCc+
         o85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760419568; x=1761024368;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJeA08PmXO0Rt+J6zqTRksSe9Q2LhvStVnJgFH8knlE=;
        b=bOrM1Q/TwjC0U8645ljNK2/JTVSuGnlkof39uyTZmJ5143QFJtIhPgCGRwoBBO2RPM
         8SYrr+7CDqYVKN1qyeHspbMY8DtcONET2/D6T07Q/k2fwlgmGeJSQANo/Vix954b0mVt
         AjWpVjbO9a3hwoaJaNAt1oLdtez0nyFny9klvlpqNCr9796wQ4/EQLQjFTgmjy99rZ+Y
         +z6rrFfrge2jmydbiraZ1ojaiCkXfmFvq6i15pE9QFuyLNUd5KlWormDNwQr8HK0lLty
         jnFpTjQJ7OyodI1gJeDLXGWt5fIBkouFo1gT+ODNGb5eNmFu6K9fqVsAGGjOgOc5nBkF
         wxYw==
X-Forwarded-Encrypted: i=1; AJvYcCXrdZh0Uw/pHJutD17hcv2NZvZiW5oJ3mF0WEPrZzPTXmiQq43mtND/tRvfwXRvEDfGpt80ar2FMDaAgdMJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwIEIx2k7aNWhq4vmLNWLUncwSPvx/tu0PryVOkP8rXbR7fCNd7
	dnJ8vuFDQNnLYZZ8I3rxoVxMY/+n7Thi0339UaMDNhtq1EttWfzWfBbKkwDSu8CPJxk=
X-Gm-Gg: ASbGncvIJVU3SMQm2Gciss8JDabZvyPy+0ceYkMwyscV/f2iX9kghRtpRPX7ojwbBOE
	pJsRFfkV/Rv0UbmJ4EjmAXQv4OkIUFPc1AV1gpsLkXjOukeWef5OTg/cx/rnTW0kShkKYE9TwBs
	ae+atVWm+xuOmXH52ipz2jxAQGryH9qcaJFGn/mm0Yy1EsSUfV4LDW4xbp/TnbltORJpmV1fTld
	kC++RVVKLPSreRn0hpnNMftM0Fr/z4gjCLot+AQyy+JFFgcghUp3QCzsdNaWfxfSWtPJBdGL9fs
	FkmET45TXuvImTc5OfA61aD9xHCsvEjPdnE2P2L5RBrd87cUUT5LWYsIzHJD3kRATzeYrAhUfAr
	DfKp1S7ltW1wZGZQQ5ZhDFCXCcvU+J0BrK/Cv7XEsDbTa/JB+AyRVhOHjwAxGfN/C/lYy2CS3Ua
	0IScPR
X-Google-Smtp-Source: AGHT+IGrGpGhcI95c5DMP672QlHISusRMmNdSZjfnjcUd//Uku5n9Mpyuwa8gnooQRqjnAoP2rIKaA==
X-Received: by 2002:a05:6000:2505:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-42672425b82mr14532469f8f.47.1760419567943;
        Mon, 13 Oct 2025 22:26:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c14sm151516595ad.6.2025.10.13.22.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 22:26:07 -0700 (PDT)
Message-ID: <f6d30bb5-8e0e-4351-a11f-4a78f7a541e7@suse.com>
Date: Tue, 14 Oct 2025 15:56:00 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl
 index=on
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
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
In-Reply-To: <20251014015707.129013-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/14 12:27, André Almeida 写道:
> Hi everyone,
> 
> When using overlayfs with the mount option index=on, the first time a directory is
> used as upper dir, overlayfs stores in a xattr "overlay.origin" the UUID of the
> filesystem being used in the layers. If the upper dir is reused, overlayfs
> refuses to mount for a different filesystem, by comparing the UUID with what's
> stored at overlay.origin, and it fails with "failed to verify upper root origin"
> on dmesg. Remounting with the very same fs is supported and works fine.
> 
> However, btrfs mounts may have volatiles UUIDs. When mounting the exact same
> disk image with btrfs, a random UUID is assigned for the following disks each
> time they are mounted, stored at temp_fsid and used across the kernel as the
> disk UUID. `btrfs filesystem show` presents that. Calling statfs() however shows
> the original (and duplicated) UUID for all disks.

Yep, that's the btrfs' hack to allowing mounting cloned devices (as long 
as they are all single-device only btrfs)

Although I'm not a huge fan for that, without that you can not even 
mount any cloned btrfs in the first place.

> 
> This feature doesn't work well with overlayfs with index=on, as when the image
> is mounted a second time, will get a different UUID and ovl will refuse to
> mount, breaking the user expectation that using the same image should work. A
> small script can be find in the end of this cover letter that illustrates this.
> 
>  From this, I can think of some options:
> 
> - Use statfs() internally to always get the fsid, that is persistent. The patch
> here illustrates that approach, but doesn't fully implement it.
> - Create a new sb op, called get_uuid() so the filesystem returns what's
> appropriated.
> - Have a workaround in ovl for btrfs.
> - Document this as unsupported, and userland needs to erase overlay.origin each
> time it wants to remount.
> - If ovl detects that temp_fsid and index are being used at the same time,
> refuses to mount.

Or, let btrfs to reject the cloned device in the first place.

> 
> I'm not sure which one would be better here, so I would like to hear some ideas
> on this.
> 
> Thanks!
> 	André
> 
> ---
> 
> To reproduce:
> 
> mkdir -p dir1 dir2
> 
> fallocate -l 300m ./disk1.img
> mkfs.btrfs -q -f ./disk1.img
> 
> # cloning the disks
> cp disk1.img disk2.img

If you really want to use the same copied fs, at least you can use
`btrfstune -m disk2.img` to change it to a new metadata uuid (without 
re-writing all metadata).

Then everything should work.

Thanks,
Qu
> sudo mount -o loop ./disk1.img dir1
> sudo mount -o loop ./disk2.img dir2
> 
> mkdir -p dir2/lower aux/upper aux/work
> 
> # this works
> sudo mount -t overlay -o lowerdir=dir2/lower,upperdir=aux/upper,workdir=aux/work,userxattr none dir2/lower
> 
> sudo umount dir2/lower
> sudo umount dir2
> 
> sudo mount -o loop ./disk2.img dir2
> 
> # this doesn't works
> sudo mount -t overlay -o lowerdir=dir2/lower,upperdir=aux/upper,workdir=aux/work,userxattr none dir2/lower
> 
> André Almeida (1):
>    ovl: Use fsid as unique identifier for trusted origin
> 
>   fs/overlayfs/copy_up.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 


