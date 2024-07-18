Return-Path: <linux-fsdevel+bounces-23901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A1C93496D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 09:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D90283B3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68A17828B;
	Thu, 18 Jul 2024 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bHAlKkqP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78176026
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289436; cv=none; b=pBLJRZ+8M1XuauwfBmt2M4zJzsj/vA28vJAJO+DvQT+d9PMTVmz23ewgFvRx0a1ts0gC4cW/DFB1HznPAzLKjjWqOqhSOvdMLVWtzd3/kLpf6VLY3PfLgbVl7QP1OZzD0oNZs3J3YxfkAhsNJcq0ZmNSubMQ/M+nxrj7oDZ20Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289436; c=relaxed/simple;
	bh=HrjvJMm7kPmpD6F/G745DlsSIlmTJa+UuDxTFfrK0Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Af8aiibSx2UBkgq4xC3TemLvVODBKBXW2C/64u9oyp0KfK+pic6uIBcqabIrt/1kgEhDTSmowWPO3NIWhrFzqoiiOVUm3erOaNYUfEjnGHgaj6fdU8Sdaiu08Ku+oBmWQNmIX/D7I2NUV/q2rNHHy4r8bhNYwwF8i6yYj9fkMns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bHAlKkqP; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eebc76119aso6278431fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 00:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721289432; x=1721894232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ryf/L9F3W+yS7sE2LI6OBmRUvcJA5RPJZdjnYSn/YoA=;
        b=bHAlKkqPLvptUMGsZSnY4Yxxk68FWVPR75EeiR3AndgRWChnRyppPBD7OuIGvCc9R5
         N1mHASM5uHYaBFSuwuTK0aripEUtO6fvnra+NqWmuxSWnzoGxbAtunvkNe62iZzIF8Cx
         gWkxPX3NqGFqNbBscaN9WNQmApHRlFArMgnnsShEdCH5Npb0N/xpTXOARTUd1NU5dCMi
         ytSHi4EIoJ7nV6bsVCCl4dZCVEvsokhXjLpGfQyjUvgYiCI4D0ab66I8tgzjfu4a0qsC
         94iZSWXs5krE/a/4wMj+744rE8ZHNqYO0QieWG9Setx7VtpGMAql410rDp9A3unOdGH8
         EGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721289432; x=1721894232;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ryf/L9F3W+yS7sE2LI6OBmRUvcJA5RPJZdjnYSn/YoA=;
        b=lxeVYwm7/Ce5YojA3QjSgdxYm+Nu0Xog7BKLJjv/LQt+K0jr/zWDpJdhqK8TX6Aw3Y
         r1nJKF8iQUkctgDKKfeWSiYyL1LvtgSBWBSbIL++4SIgK0h6JGlpMbhd53iqQr8Co+/u
         S2yb+z6FR4qr+w0EqfipcdIBqI12XKelXEyvypXExknDX17bkmKcIo4lv5CcCg4B1hRB
         k1JLvTKsBMwSY23eLmejMS0ZDrTGkvAwXIr7OB6rfBmXz2v9UI3bK0lZsEIv+WaYsXAK
         o4RUPz9zgLuaopLdoiw2DohcjHfmSR+jd8AbtIUav61iNov1zfHomHhqBQDgwqaaY2fp
         gbcg==
X-Forwarded-Encrypted: i=1; AJvYcCW8cIc+nhZrXp91RRu7fgGmpAjRGAt1Cp78sdrJ7Kwt+4dOWG+zitRcO7oLNVwFBVCsr1jyviru3ilkN2f9JCgjYTBB0Is+0zVayaib/g==
X-Gm-Message-State: AOJu0YwDwqaPB3yCK7pkDEtTXUMtiSNMee5LKMsZ+SQcknM0Fbn/kbHs
	K4JPRZuStMfu/mKqx/YKEFQvt4poHoGTCMJPfKwOG8V3YlQe5DZIFxT6TvEToso=
X-Google-Smtp-Source: AGHT+IEQZF07rHCNHOIAn/kygtiNr2VBjTyAwR8GmB+YwDBsRxlbRFz1ItA3TV5u6JgIyFN42ZARwg==
X-Received: by 2002:a2e:8185:0:b0:2ee:9521:1436 with SMTP id 38308e7fff4ca-2ef05ca1b4cmr10708341fa.28.1721289431871;
        Thu, 18 Jul 2024 00:57:11 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77541bd2sm24111a91.53.2024.07.18.00.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 00:57:11 -0700 (PDT)
Message-ID: <304fdaa9-81d8-40ae-adde-d1e91b47b4c0@suse.com>
Date: Thu, 18 Jul 2024 17:27:05 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
To: Michal Hocko <mhocko@suse.com>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Cgroups <cgroups@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka> <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
 <ZpjDeSrZ40El5ALW@tiehlicka>
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
In-Reply-To: <ZpjDeSrZ40El5ALW@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/18 16:55, Michal Hocko 写道:
> On Thu 18-07-24 09:17:42, Vlastimil Babka (SUSE) wrote:
>> On 7/18/24 12:38 AM, Qu Wenruo wrote:
> [...]
>>> Does the folio order has anything related to the problem or just a
>>> higher order makes it more possible?
>>
>> I didn't spot anything in the memcg charge path that would depend on the
>> order directly, hm. Also what kernel version was showing these soft lockups?
> 
> Correct. Order just defines the number of charges to be reclaimed.
> Unlike the page allocator path we do not have any specific requirements
> on the memory to be released.

So I guess the higher folio order just brings more pressure to trigger 
the problem?

> 
>>> And finally, even without the hang problem, does it make any sense to
>>> skip all the possible memcg charge completely, either to reduce latency
>>> or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?
> 
> Let me just add to the pile of questions. Who does own this memory?

A special inode inside btrfs, we call it btree_inode, which is not 
accessible out of the btrfs module, and its lifespan is the same as the 
mounted btrfs filesystem.

The inode is kept inside memory (btrfs_fs_info::btree_inode), it's 
initialized at the first mount, and released upon the last unmount.

The address_space_operation() are special that it doesn't implement any 
read/readahead.
Only write/release/invalidate/migrate functions are implemented.

The read are triggered and handled all inside btrfs itself.

Thanks,
Qu

