Return-Path: <linux-fsdevel+bounces-15971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B07896440
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F0B4B217FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 05:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E654E1D9;
	Wed,  3 Apr 2024 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K+uUaojR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB311870
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712123543; cv=none; b=l0dujKTOLJFeZvctOTeSo3ZuGtZ4rpTg+RNwqz2ERFzd79nlJkfOeEL99UYnfYPcIe2QmBi4BMi386n/NLYaD2GFNElZrfPnPrK0UxgbqCtU0dZo8+DOJRz/fTCgxw7DxAnQG6oNtluIcwsfR6/UdS/rACrfwMdMv3xBWebErB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712123543; c=relaxed/simple;
	bh=au+raaVKbX1jQKKXn891U3zO9Q4Pgp0W5C444VSlB/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qdEpmuyJ5aVsjw3g48L3qrQ7ag8OYg2B/yw4Yjl22v+/GKVa9BaghOOm4dz4zQXpXFuqQRlTCjCiXcJjYnh2ajzLe56m6dkLxH1Qw8S76ajVTCQIXNTKDvmVQhf86ZmjUbmt1+nNVo3qwgvbZYAvgocrjwn8/ljywZuktAxrVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K+uUaojR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513e10a4083so6854076e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 22:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712123539; x=1712728339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qy+3n1QCV9lICWk9IKzr1g9NsOrhM3hYEbipct4rUzc=;
        b=K+uUaojR+bPnEFCOFLpo1M5ivTs5qH3+qpdnQ1qQL27MlNxWi2pS9oG7Qk1qYuM1Wt
         Z5IdFVWtaWLZD49UaqPfoCbtidtlVtUzzELoHeD0PayhD13vGovpQRnBGWHHiIWNF9uO
         Z66828vhDxgGRIFxnrNcF0qzNeu8RdE3ybAwufWNIW9d3ddEOVKrHmQdfF0kws5Zy/qV
         Arrm1PEbYxYLTy4s+vCwlXSl0ZB4Tt+iLtbAAN98dJG0oZDspPeShK55v4lV8YTFzAMZ
         XC7qP0r/hmsys/i3ABmIH3bYn3JMbxfpYAv4eRyV/x1pDJKnpyqQv1eurNTPUGoO6lfD
         emhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712123539; x=1712728339;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qy+3n1QCV9lICWk9IKzr1g9NsOrhM3hYEbipct4rUzc=;
        b=Kx8DObSVPiTNCpxqRpSEvQj6ZJ5cKzMy6GLeMevfjnRKhJHq2w3MsPlqvFq/0JXFQJ
         yKH5DzI8dhenJgwNeobVBpP5kkJ7bj5gtw5osRTxJjC63sXOXwvR9Fh76PutppgYK7/Q
         o5mJ8SdOPr9o4HZywtsQ+lRLANsHkzCD68DoyWWsrlheadr+YidaJHlbSO4Et1Dpz3Ka
         Ug0C/JNlcP8J+fs93k9whB/fdFypYYs3io909GeUUic2SVvrG9GN065WIxtY44vf2IjX
         zNeytDwGgAIPzBz5zOCB6cpGEJTKY9vo1DRQntL5tu18d2k/KUZMSDtqki67md/XP90U
         k1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVuHvi9zUf03vbzalTs+Hehp1fm7JAUMh7MiH1O2Gfsm3EuwNWAfhfQulqZXRuO1NLPYF4VFkHeH818VbFyp6z2xVCrsgpvofXb4P6qcg==
X-Gm-Message-State: AOJu0Yxes9OSxqFS2eYK/nnp1mADwqTtw+NDxSrT7pnefGn4yTCpSdCP
	f2fJ+Z94hLZ2J5Om1KlAyifxxgZRj5mVrR7SM2QJqCyKuNr9Nx+8YNC4N0c6LUo=
X-Google-Smtp-Source: AGHT+IFmvBZ6VoJlXKEwgJEoqiULEeKNPf4CaElA6N9VlSA4Ec4aT9grkWNhxdYqbBsnWXh4NnPQbQ==
X-Received: by 2002:a2e:920d:0:b0:2d8:4169:3a58 with SMTP id k13-20020a2e920d000000b002d841693a58mr51352ljg.41.1712123538857;
        Tue, 02 Apr 2024 22:52:18 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id v62-20020a626141000000b006e73f400295sm11258315pfb.61.2024.04.02.22.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 22:52:18 -0700 (PDT)
Message-ID: <821adc74-1c35-4003-aa31-a2562791dde8@suse.com>
Date: Wed, 3 Apr 2024 16:22:10 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] btrfs: fiemap: return extent physical size
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Jonathan Corbet <corbet@lwn.net>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-doc@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <cover.1711588701.git.sweettea-kernel@dorminy.me>
 <93686d5c4467befe12f76e4921bfc20a13a74e2d.1711588701.git.sweettea-kernel@dorminy.me>
 <a2d3cdef-ed4e-41f0-b0d9-801c781f9512@suse.com>
 <ff320741-0516-410f-9aba-fc2d9d7a6b01@dorminy.me>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <ff320741-0516-410f-9aba-fc2d9d7a6b01@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/3 16:02, Sweet Tea Dorminy 写道:
[...]
>>
>> fileoff 0, logical len 4k, phy 13631488, phy len 64K
>> fileoff 4k, logical len 4k, phy 13697024, phy len 4k
>> fileoff 8k, logical len 56k, phy 13631488 + 8k, phylen 56k
>>
>> [HOW TO CALCULATE WASTED SPACE IN USER SPACE]
>> My concern is on the first entry. It indicates that we have wasted 60K 
>> (phy len is 64K, while logical len is only 4K)
>>
>> But that information is not correct, as in reality we only wasted 4K, 
>> the remaining 56K is still referred by file range [8K, 64K).
>>
>> Do you mean that user space program should maintain a mapping of each 
>> utilized physical range, and when handling the reported file range 
>> [8K, 64K), the user space program should find that the physical range 
>> covers with one existing extent, and do calculation correctly?
> 
> My goal is to give an unprivileged interface for tools like compsize to 
> figure out how much space is used by a particular set of files. They 
> report the total disk space referenced by the provided list of files, 
> currently by doing a tree search (CAP_SYS_ADMIN) for all the extents 
> pertaining to the requested files and deduplicating extents based on 
> disk_bytenr.
> 
> It seems simplest to me for userspace for the kernel to emit the entire 
> extent for each part of it referenced in a file, and let userspace deal 
> with deduplicating extents. This is also most similar to the existing 
> tree-search based interface. Reporting whole extents gives more 
> flexibility for userspace to figure out how to report bookend extents, 
> or shared extents, or ...

That's totally fine, no matter what solution you go, (reporting exactly 
as the on-disk file extent, or with offset into consideration), user 
space always need to maintain some type of mapping to calculate the 
wasted space by bookend extents.

> 
> It does seem a little weird where if you request with fiemap only e.g. 
> 4k-16k range in that example file you'll get reported all 68k involved, 
> but I can't figure out a way to fix that without having the kernel keep 
> track of used parts of the extents as part of reporting, which sounds 
> expensive.

I do not think mapping 4k-16K is a common scenario either, but since you 
mentioned, at least we need a consistent way to emit a filemap entry.

The tracking part can be done in the user space.

> 
> You're right that I'm being inconsistent, taking off extent_offset from 
> the reported disk size when that isn't what I should be doing, so I 
> fixed that in v3.
> 
>>
>> [COMPRESSION REPRESENTATION]
>> The biggest problem other than the complexity in user space is the 
>> handling of compressed extents.
>>
>> Should we return the physical bytenr (disk_bytenr of file extent item) 
>> directly or with the extent offset added?
>> Either way it doesn't look consistent to me, compared to 
>> non-compressed extents.
>>
> 
> As I understand it, the goal of reporting physical bytenr is to provide 
> a number which we could theoretically then resolve into a disk location 
> or few if we cared, but which doesn't necessarily have any physical 
> meaning. To quote the fiemap documentation page: "It is always undefined 
> to try to update the data in-place by writing to the indicated location 
> without the assistance of the filesystem". So I think I'd prefer to 
> always report the entire size of the entire extent being referenced.

The concern is, if we have a compressed file extent, reflinked to 
different part of the file.

Then the fiemap returns all different physical bytenr (since offset is 
added), user space tool have no idea they are the same extent on-disk.
Furthermore, if we emit the physical + offset directly to user space 
(which can be beyond the compressed extent), then we also have another 
uncompressed extent at previous physical + offset.

Would that lead to bad calculation in user space to determine how many 
bytes are really used?

> 
>> [ALTERNATIVE FORMAT]
>> The other alternative would be following the btrfs ondisk format, 
>> providing a unique physical bytenr for any file extent, then the 
>> offset/referred length inside the uncompressed extent.
>>
>> That would handle compressed and regular extents more consistent, and 
>> a little easier for user space tool to handle (really just a tiny bit 
>> easier, no range overlap check needed), but more complex to represent, 
>> and I'm not sure if any other filesystem would be happy to accept the 
>> extra members they don't care.
> 
> I really want to make sure that this interface reports the unused space 
> in e.g bookend extents well -- compsize has been an important tool for 
> me in this respect, e.g. a time when a 10g file was taking up 110g of 
> actual disk space. If we report the entire length of the entire extent, 
> then when used on whole files one can establish the space referenced by 
> that file but not used; similarly on multiple files. So while I like the 
> simplicity of just reporting the used length, I don't think there's a 
> way to make compsize unprivileged with that approach.

Why not? In user space we just need to maintain a mapping of each 
referred range.

Then we get the real actual disk space, meanwhile the fiemap report is 
no different than "btrfs ins dump-tree" for file extents (we have all 
the things we need, filepos, length (num_bytes), disk_bytenr, 
disk_num_bytes, offset, and ram_bytes.

For unused space, since we have the mapping, we can iterate through the 
mapping, finding out all the sectors not referred by any file extents.

It should really just be a fiemap based (and unprivilleged) compsize.
Or did I miss some important things?

Thanks,
Qu

> 
> Thank you!!

