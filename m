Return-Path: <linux-fsdevel+bounces-63057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D58FBAAAA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 23:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DF1189F946
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9C25E47D;
	Mon, 29 Sep 2025 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ePmZrFkX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52B52236F7
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759182404; cv=none; b=YA6QGTehuxCViA32FtkdNG4VHx1WXsx7PHc7N1t71n5woU/7k+71XWceTCTfwiQj8/HXLixvPu/9X5rQaIFDySQH1AMVodF0m/+amzO6Afx/xiaNOjjrVVDTh52gYqnLCaNH9+ShFuYMhmE3IllGX+kBNHd/LwATa6+UO4iJb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759182404; c=relaxed/simple;
	bh=8+CjnvXZ9bKHU9NoIwXjmxWvO9fLdof4asOnxs6Y3J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLX63AU2mZH4dhZ3u7Zja8xu14a7Q8++RLLzYT5HU0yYmNL216tb28MjxnkppqvSnmi8emDBz1onuwSeRnuncpGU2Wkdh4q/ptCvpxGAkoJMDdVH+PHLg70rzn3xQePy7S7WtTxy2p6NIclO+I68LJXZCEiRDGu96f245R/+elk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ePmZrFkX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so3616958f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759182400; x=1759787200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JBQVuh0pyfNoSFHzgB4ISgtBSFYpT2CuO6PbFEJ29As=;
        b=ePmZrFkXscGHM3Mx2Tht/ZW6Y8qBkDjo3gj5Ci+dcCXgENZsThlMGhVbS5YjCSg5Oa
         tnJkcvYouCh60eczIPVKyJLi2b3pXINwKx5q5f1kWGxe0M+3BIMdQ+alXJH9t5PYyHVe
         UQqyF54M/JUp2MBW/FQ8B6Z5D5qLVnBA8lHbhYTdhyVh4+2UkGvmAq5s40sMphgelvq3
         MLjV6lrd6NKtZOiDUmHQGcQdeZ+v0ligsofS4gV+m4rSGT0p3XdCUEcnjC+FWu83TcNr
         6mwq2Z578qn1dhZ5pWrackSfy7ba0bBi4n8tKFeLGeV5ZLEGRPTUeXtnLbhyyWttM6ir
         JQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759182400; x=1759787200;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBQVuh0pyfNoSFHzgB4ISgtBSFYpT2CuO6PbFEJ29As=;
        b=wtEKBXADez0No3TU42v7UXJqY8+0X3aKoG91E/I9z7qDXvxpI3XxrYCeAYbIztnwx+
         4Uml0/e6SaqoxiRnLL0JVg9tf6dthXZOsZVIRjk/i8fLhLYCrfSw28qmfeeYhVfHyeUo
         yaD/bwAN5rA8xb7h86zA1BgMmMbyyY3KJinc5yjGsnR3rHBTnGK72H2a1ARtFBlYmW21
         E6++2RvgUrBZr7c1RznHaQwVyfGvWKf4FM57fLsk+lx9sLFPz8QaKbM5CtHa1Eda/WPo
         E7PuO0jLgM/Z0MGRUJ0hyT74R/9EghCNLHiByWH53TCdnCdAPselIjqGZ78RKjQ++KZs
         sv1w==
X-Forwarded-Encrypted: i=1; AJvYcCXo5f1fl2uEkVS0q/I/zoXSATbVKXxxHdFtdgcUsNyCqeDmezuZ9Rb7pQwmMuj78uxJlGkWAgHV+thTEfzK@vger.kernel.org
X-Gm-Message-State: AOJu0YxevHx/BxkuLGxeueVbGzgKh5HzE7Lwt7Yh02g9WERI14oaGqwD
	HMcKUr3ohddq3IytRIH1r7gt0JzTwzaqphm+5eHIyfP/eZaIpIWX4ZgNqGbMmOnDjYA=
X-Gm-Gg: ASbGnctNwiyigrA05sr52V67+W5lJIgRcMosWQOxG0g0dDypLa3iJVOQDOF0DxQDvHJ
	nB3M8uVZiBa2DPTBBus11hHZ6shWqZEn8/beuu0A2JhLGaL8jiWt+QZM1EaUvyNiau3C/AmG/Vz
	6fCMSGBA3ue7MfUEFTOZf4IglbVTAIO0o11NnzfyYLulkRU2i9DX9/+EqeYPklNrCEhB2ZF5azt
	aGZKp279VXSK7KdfvV1JYE/TUfrlXaoQB6+ehrbsihZwP2RrURPAfnC+50LZwTnljlGQkakwcBm
	OUUgOf5nDTEsxjHOXictIR15RZciBScF1V58+kVYaLjr6xUsd6t+sOA4gXRJKzEXNSqmaobfan0
	J32XklWnfsWQEeVDgMb0yauJtZaxWwikeRxG42rob0igTNKEHBYA=
X-Google-Smtp-Source: AGHT+IG7ucdybca5Y/dTjKqQS2GBXbxdNdgaDavgXtAwspTObB7YcHr+aCoGLrIQFmroKJMVje+VYw==
X-Received: by 2002:a05:6000:2002:b0:3ee:126a:7aab with SMTP id ffacd0b85a97d-40e4dabf373mr17095040f8f.57.1759182400198;
        Mon, 29 Sep 2025 14:46:40 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7820d7020a8sm6234755b3a.93.2025.09.29.14.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 14:46:39 -0700 (PDT)
Message-ID: <356ac25e-496e-4192-a3e6-2f9f41aa4864@suse.com>
Date: Tue, 30 Sep 2025 07:16:30 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: Make wbc_to_tag() inline and use it in fs.
To: Julian Sun <sunjunchao@bytedance.com>, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, dsterba@suse.com, xiubli@redhat.com, idryomov@gmail.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 chao@kernel.org, willy@infradead.org, jack@suse.cz, brauner@kernel.org,
 agruenba@redhat.com
References: <20250929111349.448324-1-sunjunchao@bytedance.com>
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
In-Reply-To: <20250929111349.448324-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/29 20:43, Julian Sun 写道:
> The logic in wbc_to_tag() is widely used in file systems, so modify this
> function to be inline and use it in file systems.
> 
> This patch has only passed compilation tests, but it should be fine.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c      | 5 +----
>   fs/ceph/addr.c            | 6 +-----
>   fs/ext4/inode.c           | 5 +----
>   fs/f2fs/data.c            | 5 +----
>   fs/gfs2/aops.c            | 5 +----
>   include/linux/writeback.h | 7 +++++++
>   mm/page-writeback.c       | 6 ------
>   7 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b21cb72835cc..0fea58287175 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2390,10 +2390,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
>   			       &BTRFS_I(inode)->runtime_flags))
>   		wbc->tagged_writepages = 1;
>   
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> +	tag = wbc_to_tag(wbc);
>   retry:
>   	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
>   		tag_pages_for_writeback(mapping, index, end);
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 322ed268f14a..63b75d214210 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1045,11 +1045,7 @@ void ceph_init_writeback_ctl(struct address_space *mapping,
>   	ceph_wbc->index = ceph_wbc->start_index;
>   	ceph_wbc->end = -1;
>   
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
> -		ceph_wbc->tag = PAGECACHE_TAG_TOWRITE;
> -	} else {
> -		ceph_wbc->tag = PAGECACHE_TAG_DIRTY;
> -	}
> +	ceph_wbc->tag = wbc_to_tag(wbc);
>   
>   	ceph_wbc->op_idx = -1;
>   	ceph_wbc->num_ops = 0;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..196eba7fa39c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2619,10 +2619,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>   	handle_t *handle = NULL;
>   	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
>   
> -	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> +	tag = wbc_to_tag(mpd->wbc);
>   
>   	mpd->map.m_len = 0;
>   	mpd->next_pos = mpd->start_pos;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 7961e0ddfca3..101e962845db 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3003,10 +3003,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
>   			range_whole = 1;
>   	}
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> +	tag = wbc_to_tag(wbc);
>   retry:
>   	retry = 0;
>   	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 47d74afd63ac..12394fc5dd29 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -311,10 +311,7 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
>   			range_whole = 1;
>   		cycled = 1; /* ignore range_cyclic tests */
>   	}
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> +	tag = wbc_to_tag(wbc);
>   
>   retry:
>   	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index a2848d731a46..dde77d13a200 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -240,6 +240,13 @@ static inline void inode_detach_wb(struct inode *inode)
>   	}
>   }
>   
> +static inline xa_mark_t wbc_to_tag(struct writeback_control *wbc)
> +{
> +	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> +		return PAGECACHE_TAG_TOWRITE;
> +	return PAGECACHE_TAG_DIRTY;
> +}
> +
>   void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
>   		struct inode *inode);
>   
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 3e248d1c3969..ae1181a46dea 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2434,12 +2434,6 @@ static bool folio_prepare_writeback(struct address_space *mapping,
>   	return true;
>   }
>   
> -static xa_mark_t wbc_to_tag(struct writeback_control *wbc)
> -{
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		return PAGECACHE_TAG_TOWRITE;
> -	return PAGECACHE_TAG_DIRTY;
> -}
>   
>   static pgoff_t wbc_end(struct writeback_control *wbc)
>   {


