Return-Path: <linux-fsdevel+bounces-32444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB969A53D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 13:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC6B282296
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4A191F7E;
	Sun, 20 Oct 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAJ0IFZL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D2186E58;
	Sun, 20 Oct 2024 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729424443; cv=none; b=BduuEr8QK+dq1Reds7tkFEun8NcDj7fBB+FJ//8ETIcOrJuVJFec0UrYq3PvDXgQXA8PpWVa/6Ls2fVB0gZ9h14i6gt/VhBQ+cjDoMbVGuTBr4qCSxKUA1eogt6PN718p5Pj+7pR4idxR97LWLVN1LK+fKpDJtPyS7PLAFbNEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729424443; c=relaxed/simple;
	bh=LZSclOn3sg2DTi+j7QmICefur9TypI9bFU0OWBdbLZ4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=C2WslwIHgB56HJxnK2hviI/QhonWOsNbTAH8rdQJvTEb6HuYCM2n0wAemr+jedGyrti4//i+KDPkeakGl0sHtbjsLiTyl+pEJl6RbUgGhdel+92oCoVFxsGGQXXJrlQWihJ0rZTAi+MBsyIYvmeCgaWjvRqQGmFtBIgp4UnssUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAJ0IFZL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e5130832aso2481411b3a.0;
        Sun, 20 Oct 2024 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729424440; x=1730029240; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vUbICe/4LF2trKdQd96Gc7YLcrYUreXzljzyoUzCuwE=;
        b=cAJ0IFZL9+7WRHuz+rx0/hMlh2bAQWbZwNWgNyIrbipm2RPtKKVXRJcPj6h7xCmfSb
         ZwLnkk6/ifl+KvIsucOfhFe4wemrOmkhsR8WDftd/gQunq+bHnMYmVJbBzO8mBEoKKBU
         EmoiZdkYdVqQgnONBJvJ+RPS0IQNvmgJn+ellmcXDQ8bHAIdRN+kwo6pog5/xi4FCuJH
         8QOlyDiv6I208MAcCDGtdUCOqy9DHSWx9LmWS6j83d20L7X0ms3DcF2/nthH1srv7IBW
         xvfO0OdwDgD9vqLK9yGFhZlAsjQFjxiCFdUOGDYGjv4B9+BHdk9/xZJ+rZYisL57EowJ
         eTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729424440; x=1730029240;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUbICe/4LF2trKdQd96Gc7YLcrYUreXzljzyoUzCuwE=;
        b=s6tuaG2ZljPtVrDKDnSUfHXCZRbT3Ai1SS5XW6mKEkdEvOl/OMV7piCzu0Sz6CQHoV
         QiIKLCOQRBycdpn2n+eKLdOuoyiiXXPEbVKGb9Lk94bOO81+aMXAm6didXsDNu5gWxl+
         Lz4Wr/bOa+oP1YAh4+7V9R/ZTajXhPqPqYvVWg6TYI76rm/ISPirA+VSyFTReRKCTcgc
         OgS5OmW4Wb0BE6oL+/qmjNFyuPxCWuCnYwfyJPwn9PsH6tZt0rpK8oFoT9Pt2fPZ9PUl
         qy1cch0pI3cd0Af8AflqPJ6Gs22gS05kGu4oSOdX2hzJ/IO5cDheGnvfTwl3xrhFeg1X
         Jbwg==
X-Forwarded-Encrypted: i=1; AJvYcCUFsVQjEPJmjaYd0CnkmnPhfaQKjowOzrQqDQu7F5P3KMva0mUOrIycgiZfJss5FgY6O6MoQh+7qQz8@vger.kernel.org, AJvYcCUXyvNWuGqiid3XORNUJX+4WJKFL6/Tb853RJ8jwsCNchdOvb1gh4v8EGV0XNC4rL3vVG0bK1Nmvw9dfFF4@vger.kernel.org, AJvYcCVc9U/Wk9Z5m/GBCAOFjHx3Ep6S+uMRiHt/hqtyOJjx0qvMs9MuUMlanhwxgfYWdZShAcdknFlj8E4OqACE@vger.kernel.org
X-Gm-Message-State: AOJu0YxnmSlFIYlSaBIovAdYjBo+HdsbWhvPbAh+BGVwxrHgiEh2kmQB
	Q9JckO87tCGxO5ZJZZkylZl3bbKMp6sDe6mE2rb7z3qR+fLNzfwA
X-Google-Smtp-Source: AGHT+IF8ArixtltKuMOBS4gFAzUTxigNcFYIrJKlSo95ockDQwjrWKKyBPcdau9vkhpcJsnR/vgd3g==
X-Received: by 2002:a05:6a00:2d96:b0:71e:4a51:2007 with SMTP id d2e1a72fcca58-71ea3129934mr11867922b3a.4.1729424440437;
        Sun, 20 Oct 2024 04:40:40 -0700 (PDT)
Received: from dw-tp ([171.76.81.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415066sm1030291b3a.198.2024.10.20.04.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:40:39 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de, martin.petersen@oracle.com, catherine.hoang@oracle.com, mcgrof@kernel.org, ojaswin@linux.ibm.com
Subject: Re: [PATCH v10 5/8] fs: iomap: Atomic write support
In-Reply-To: <cec9eab6-8e3b-47af-94c1-56fa1e449e82@oracle.com>
Date: Sun, 20 Oct 2024 17:07:41 +0530
Message-ID: <87o73fgg3e.fsf@gmail.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com> <20241019125113.369994-6-john.g.garry@oracle.com> <87sesrgp5v.fsf@gmail.com> <cec9eab6-8e3b-47af-94c1-56fa1e449e82@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 20/10/2024 09:21, Ritesh Harjani (IBM) wrote:
>>>   -293,7 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>>   	const struct iomap *iomap = &iter->iomap;
>>>   	struct inode *inode = iter->inode;
>>>   	unsigned int fs_block_size = i_blocksize(inode), pad;
>>> -	loff_t length = iomap_length(iter);
>>> +	const loff_t length = iomap_length(iter);
>>> +	bool atomic = iter->flags & IOMAP_ATOMIC;
>>>   	loff_t pos = iter->pos;
>>>   	blk_opf_t bio_opf;
>>>   	struct bio *bio;
>>> @@ -303,6 +306,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>>   	size_t copied = 0;
>>>   	size_t orig_count;
>>>   
>>> +	if (atomic && length != fs_block_size)
>>> +		return -EINVAL;
>> We anyway mandate iov_iter_count() write should be same as sb_blocksize
>> in xfs_file_write_iter() for atomic writes.
>> This comparison here is not required. I believe we do plan to lift this
>> restriction maybe when we are going to add forcealign support right?
>
> Yes, we would lift this restriction if and when forcealign is added. Or 
> when bigalloc is leveraged for ext4 atomic writes.
>
> But I think that today it is proper to add this check, as we are saying 
> that iomap DIO path does not support anything else than fs_block_size.
>
> For forcealign, we were introducing support for atomic writes spanning 
> mixed unwritten and written extents in [0]. We don't have that support 
> here, so it is prudent to say that we just support fs_block_size.
>
> [0] 
> https://lore.kernel.org/linux-xfs/20240607143919.2622319-4-john.g.garry@oracle.com/
>

Sure.

>> 
>> And similarly this needs to be lifted when ext4 adds support for atomic
>> write even with bigalloc. I hope we can do so when we add such support, right?
>
> Right
>

Thanks for confirming that.
The patch looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

