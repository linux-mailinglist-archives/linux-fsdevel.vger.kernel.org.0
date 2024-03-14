Return-Path: <linux-fsdevel+bounces-14406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D40187C0A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 16:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA661C21159
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C644E7317D;
	Thu, 14 Mar 2024 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIiQTPyi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0618E20;
	Thu, 14 Mar 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431550; cv=none; b=ZuPNhW1lt6pg+equOXJk5I0OT7amyY5cg3qmgyg1b3efYVuPmHVhHzeULEheYnXuogzkfEXtuXFZwMfUGw/d37Ty08FLdJhj95L7o/FkCR6ZijAAXQfbEQPsEFP8wXZ2KgzwaOHvOBTCw9LzeEjwPgNV+9ShtUU8fCluwytodh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431550; c=relaxed/simple;
	bh=Z7TYGBPOoIBukUksfxYV+hx+h1FdGbsx9QGwkRCvrGg=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=QCVOpWP7+M5cTu5s4Vn/OFX5inafWyo8rabSEHZKkx98nw5FZRcY+0Q3I3j/F3usx8kZTqC1igQnQi8fLNBIEXZ7sBSRmH4N4dlN9iMZHYmwsSLI9HAapgyqr4CtLGffjT4JrQVLu1JY0z1S+VpJriM/u7e+HiXyw1WCK1Tb07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIiQTPyi; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e4d48a5823so953637b3a.1;
        Thu, 14 Mar 2024 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710431548; x=1711036348; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cx2Q7SMtzb14PMck/KCjjiXpz4N8Haj7beKabn3YkmM=;
        b=BIiQTPyi83wvGqe5NSs/I2S1XNat2Lg7BcGn2/MWOLPPqXFlvZQaYbDMuKZYgGRJIP
         6P9nWHNaPftNKj/CzSQf6rsLJtdXESVKpq30sG63aR5O1B7PuvwATFHa7VkKuHn8zTWQ
         BH+k93J/hnjS2DvzGaBDlEy7tMoyhQYQZNIs4O6M6/NTltN+TZHcg6annhXkPKawtnW+
         YDlIJVs0tj/GnV9ictxghxz5ggPEITACstAsFrHLqHR0U+wbrQ4BA9Kw3/KcUNhMonjL
         ljV7m0QSv4r6KWj7rInT5gultg/tdHA1mcOIe9imDLRn8fP6QKWm7v0sWElH+z7JIdpy
         +cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710431548; x=1711036348;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cx2Q7SMtzb14PMck/KCjjiXpz4N8Haj7beKabn3YkmM=;
        b=RM3g49vgmtExzIKtO0jGTQMjkM9VU2JWKIH5C4tDnakeShxLJ2/plaRZHWRl3fUzau
         FS9xEd//YnQDto77+17LGk//yoQ+0VrtzxuTscB2soItucCjcEaklAsW7XLS8GK+85vG
         Ystrvhved8RGxHEseqwoIYfmMFcFjXh1KTCfBdAf7dPzIzZkHaGJNCDkwOnri2omcU9O
         cm7OWMTumylk0RneoyoQLjFZ/HggakQU6FnB7PBK95ZrYbFoLJA8Em5nAiw/zOVZ2RkM
         vptBFfrsWrH/YaLv2DFkl6mzf7cP9bBm0EjogSGcb6N75oE/ulqqY/jMTMUkS999RVZX
         z50w==
X-Forwarded-Encrypted: i=1; AJvYcCX72WV6JGK+i7w1mgXYxof+8Sa9h1Tq8J+f7+KwegfXDJMxEHnqRx0DHjew2gbi8l5p8FyYvVXtq5f9131u5qDQkfmmGPOmT6x83QEImky3hMPKDkcL93w+i/OAPJDgHxZ6XecpfXvaek8nVE4mREIIOgQII1QOpQPs9pAbPBzPHD7LNx40Bq8=
X-Gm-Message-State: AOJu0Yys5VKQl/ZokUlDEuACT/Tu0ZxGeZZLwjfcWjf7R84bGwLq2K3L
	MF8MhVk3YJJQFM79wgN9NC1RV40193ibwtne1omqRnv1AtQNClfq
X-Google-Smtp-Source: AGHT+IFYLPUsIucrzPsDiX/M3/odhTswA8YDYlkZ8C6cNzRTo6gKZotrBhRFjmfYzK6sXU/NLDCy2w==
X-Received: by 2002:a05:6a21:7898:b0:1a3:46fd:6e2d with SMTP id bf24-20020a056a21789800b001a346fd6e2dmr565925pzc.7.1710431548067;
        Thu, 14 Mar 2024 08:52:28 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id p24-20020a056a0026d800b006e650049472sm1632118pfw.123.2024.03.14.08.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:52:27 -0700 (PDT)
Date: Thu, 14 Mar 2024 21:22:14 +0530
Message-Id: <87r0gcn74h.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong" <djwong@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC] ext4: Add support for ext4_map_blocks_atomic()
In-Reply-To: <9fdf92e9-ad77-4184-9418-8a209e24ec20@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 08/03/2024 20:25, Ritesh Harjani (IBM) wrote:
>
> Hi Ritesh,
>
>> Currently ext4 exposes [fsawu_min, fsawu_max] size as
>> [blocksize, clustersize] (given the hw block device constraints are
>> larger than FS atomic write units).
>> 
>> That means a user should be allowed to -
>> 1. pwrite 0 4k /mnt/test/f1
>> 2. pwrite 0 16k /mnt/test/f1
>> 
>
> Previously you have mentioned 2 or 3 methods in which ext4 could support 
> atomic writes. To avoid doubt, is this patch for the "Add intelligence 
> in multi-block allocator of ext4 to provide aligned allocations (this 
> option won't require any formatting)" method mentioned at 
> https://lore.kernel.org/linux-fsdevel/8734tb0xx7.fsf@doe.com/
>
> and same as method 3 at 
> https://lore.kernel.org/linux-fsdevel/cover.1709356594.git.ritesh.list@gmail.com/? 

Hi John,

No. So this particular patch to add ext4_map_blocks_atomic() method is
only to support the usecase which you listed should work for a good user
behaviour. This is because, with bigalloc we advertizes fsawu_min and
fsawu_max as [blocksize, clustersize]
i.e. 

That means a user should be allowed to -
1. pwrite 0 4k /mnt/test/f1
followed by 
2. pwrite 0 16k /mnt/test/f1


So earlier we were failing the second 16k write at an offset where there
is already an existing extent smaller that 16k (that was because of the
assumption that the most of the users won't do such a thing).

But for a more general usecase, it is not difficult to support the
second 16k write in such a way for atomic writes with bigalloc,
so this patch just adds that support to this series.     

-ritesh 


>
>
> Thanks,
> John

