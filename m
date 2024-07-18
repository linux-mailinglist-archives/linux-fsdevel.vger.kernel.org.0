Return-Path: <linux-fsdevel+bounces-23900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455E7934964
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 09:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82BEDB22897
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FF774058;
	Thu, 18 Jul 2024 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wb6bcu8l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62995768EE
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289173; cv=none; b=MI/Rm+QhvHfnc5+3tFlmx4x3ZAZzAhQKuIFpBD9hpYHyf4jXJ7AocCZOqjNTII+m3c/tOwPSO9I9EzquGzNsW4cEXRuSxN2oIqMMBKO4bbcPa8YH1oMoYYl5ss527r3Va/kOr0t2gtwp/EZQf9LKH1IRw3+ZzOhevGjXZofSpn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289173; c=relaxed/simple;
	bh=gZ+mg6geoezziew2mhl2AtLEm35HWHVK2lpCX0HMns4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnkOk0G9uPbeQSfRdLMe6FXhEaj9HoJVuWzLFTHHbyIzEsbEQ8A3By9G214rfUfn3lmkkX+n3thfmJFhjdrjInTJtZPnzmwNksQO3xIi340qo13jYjJefeCkql4VIqS5zcXX1GbHLnTJscmCK2Ij1cXi/wcEMtu3alx/KKfznqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wb6bcu8l; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so8001071fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721289169; x=1721893969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ItcZOxEWC9jKArqH07Fv+He9OxE1gAM7tmpwWQe9zzE=;
        b=Wb6bcu8l9TR2nVCCK79x9HqGMhiO9w6rxCzaFFTSIZFQUnmwFrxSQw0dToNhgnOQD0
         dTyg8ZUF+Jt4QzPgwJx0ynNgUlVGS837c5knPSthFM8SJSlQgBTss5sEWFH6jZNUehPq
         U0Vga8TJTs8jvpKTbKi1eo9BaI+cKE0FJCxrkfhEHvbeYqrhI0AghkR+LJ28A/BZw4t0
         7IWdaZohYiICwdAHyMmCsPbnXUaS8g39+6gYKoSfIEzB5WBo+y9KJQ5ZPYqKjFtosRY7
         83A+gpkOzdrQtK1vUktcowrdq8KJZ6nPXhzElrOHSm+bqtio0VvVfug+dMIjIfcFRHrx
         pUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721289169; x=1721893969;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItcZOxEWC9jKArqH07Fv+He9OxE1gAM7tmpwWQe9zzE=;
        b=C5Onxw6iyyobF+MlW4Pm1PpI5lvLEld23nobGEU4xzEiy2O91UrP+MEkeIjx+HefKP
         1IMVr4RK76JPWkUf9Dkna+7+tPBu1td89uKg4+W4LFLoSxDbZhTym7DX56ZS0jwfpxcV
         go4o9wAtJvs+HvPnnj3OgVHAsEU4BCpoLU7kmN6tGGgwzqAZux9k+AfsDACFAI+Z6qEo
         JjIYclCjPAg0kCEvDIbjDw5aS3LrM9yBm+Ht0UdphXyBlVnKo/rCATcxbl6g7KaRluqL
         hJP1yD4NlMRfGE+41QJux6b9Nw1gQpU8+q1E/H+MmUp33R6NibJByyhnodqqsaifa67Y
         0RBw==
X-Forwarded-Encrypted: i=1; AJvYcCUnA7WHwCmGHxURH+es9XbXgpCLXlJRV+i4rr0TgXGyfiwvK58fNroxVEI0gGl6KywAdPurg2plTCHiS2k47LGLMU3bsqnyjK8I/f9h7Q==
X-Gm-Message-State: AOJu0YyojFkymz1hTJNHxXqmafV/fVZouzJNO1XbeRYlam9y44S19jQp
	6GmRzRzKd6A+ZbSPauh72Va+zX8rRAUHB6WGwsWKFEK6TaSfX0tT33yQWvEhEl4=
X-Google-Smtp-Source: AGHT+IHSLlJlVxe4hTKCuBdztBtQFfrHPSw+bG3aGP5TG/PL63MfSusrvKjUmhO3C9+6OMznKQ/l0Q==
X-Received: by 2002:a2e:bc0c:0:b0:2ec:56b9:259b with SMTP id 38308e7fff4ca-2ef05d45b55mr12993411fa.49.1721289169134;
        Thu, 18 Jul 2024 00:52:49 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb772c1ce1sm32210a91.7.2024.07.18.00.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 00:52:48 -0700 (PDT)
Message-ID: <3cc3e652-e058-4995-8347-337ae605ebab@suse.com>
Date: Thu, 18 Jul 2024 17:22:41 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Cgroups <cgroups@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka> <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
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
In-Reply-To: <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/18 16:47, Vlastimil Babka (SUSE) 写道:
> On 7/18/24 12:38 AM, Qu Wenruo wrote:
[...]
>> Another question is, I only see this hang with larger folio (order 2 vs
>> the old order 0) when adding to the same address space.
>>
>> Does the folio order has anything related to the problem or just a
>> higher order makes it more possible?
> 
> I didn't spot anything in the memcg charge path that would depend on the
> order directly, hm. Also what kernel version was showing these soft lockups?

The previous rc kernel. IIRC it's v6.10-rc6.

But that needs extra btrfs patches, or btrfs are still only doing the 
order-0 allocation, then add the order-0 folio into the filemap.

The extra patch just direct btrfs to allocate an order 2 folio (matching 
the default 16K nodesize), then attach the folio to the metadata filemap.

With extra coding handling corner cases like different folio sizes etc.

> 
>> And finally, even without the hang problem, does it make any sense to
>> skip all the possible memcg charge completely, either to reduce latency
>> or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?
> 
> Is it common to even use the filemap code for such metadata that can't be
> really mapped to userspace?

At least XFS/EXT4 doesn't use filemap to handle their metadata. One of 
the reason is, btrfs has pretty large metadata structure.
Not only for the regular filesystem things, but also data checksum.

Even using the default CRC32C algo, it's 4 bytes per 4K data.
Thus things can go crazy pretty easily, and that's the reason why btrfs 
is still sticking to the filemap solution.

> How does it even interact with reclaim, do they
> become part of the page cache and are scanned by reclaim together with data
> that is mapped?

Yes, it's handled just like all other filemaps, it's also using page 
cache, and all the lru/scanning things.

The major difference is, we only implement a small subset of the address 
operations:

- write
- release
- invalidate
- migrate
- dirty (debug only, otherwise falls back to filemap_dirty_folio())

Note there is no read operations, as it's btrfs itself triggering the 
metadata read, thus there is no read/readahead.
Thus we're in the full control of the page cache, e.g. determine the 
folio size to be added into the filemap.

The filemap infrastructure provides 2 good functionalities:

- (Page) Cache
   So that we can easily determine if we really need to read from the
   disk, and this can save us a lot of random IOs.

- Reclaiming

And of course the page cache of the metadata inode won't be 
cloned/shared to any user accessible inode.

> How are the lru decisions handled if there are no references
> for PTE access bits. Or can they be even reclaimed, or because there may
> e.g. other open inodes pinning this metadata, the reclaim is impossible?

If I understand it correctly, we have implemented release_folio() 
callback, which does the btrfs metadata checks to determine if we can 
release the current folio, and avoid releasing folios that's still under 
IO etc.

> 
> (sorry if the questions seem noob, I'm not that much familiar with the page
> cache side of mm)

No worry at all, I'm also a newbie on the whole mm part.

Thanks,
Qu

> 
>> Thanks,
>> Qu
> 

