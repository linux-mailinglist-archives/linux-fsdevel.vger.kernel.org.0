Return-Path: <linux-fsdevel+bounces-49002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260ACAB74D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 20:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A504A1B19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6A289820;
	Wed, 14 May 2025 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M53f4oka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED943597C;
	Wed, 14 May 2025 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248916; cv=none; b=d/UvEdsTAtQMKlo0CPS85FrPjUcu0N02XHoTGuNNMLjGArtEy0JteHqOrki9xSv/kelozKGILu22K7yAYLIXd0XtR76UGU6kXW2ZJh3iMl2O3GMiymNsrTkt0BIeDOO/xMNubCkgtAAThN+TfeMhjSxQX7g788xeZ4RaZwhyyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248916; c=relaxed/simple;
	bh=kwOVsy+CVbjNBe09eSw9iLIJR0Wabaf8jGNNDkxJqa8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=a/JoqGrcgOgzSuKM3JREDAXYLD7SZeZFP1L/hmC2118jMPYEA6gdCFECWJtxMVOEEzYQZfnog4WLZwRNIOB8DhhOoL4m7NlrIytpKQ1PZAiUrkdJmhhIT8NfB3PD7UHJX3OueP3r1AFtBtNzqVorARJrf9RQTkmmfQzwgyxaB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M53f4oka; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22fb7659866so1853535ad.1;
        Wed, 14 May 2025 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747248913; x=1747853713; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vB47hBQXP29dxblr8y5ocHPgRCp14lly7rgEc9Dk18U=;
        b=M53f4okaIaLfJAIZBHW0UfbLS+wGmrzCdMdwYL5Ta/qd320jY7kwWrKqvy181KPyOP
         JZfPAzfNon0qxyonaM70xYPniru1wg2ZcQU4gmRxpcPH1RSzKkscJz1g8WdhMI9h2JG4
         5VhbTk7tUI1JBmKeom6GsHRxpZOxDkQBCfnXs+OXqVShfGA5ychrBewOaug/tjUcqYtx
         zhf+oI7WDR+OzaS82B1CFRkLgKVG3KoqIkMPNWkj74dP+lX4GDE4XkH7dAj8+9jbXzeV
         PLiqgKx0NYcrZDse38N8K9Dxd0EGKcApHrwIwWCgNPfsOd3otq9qU5GMkzmzCbT6jJoq
         nN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747248913; x=1747853713;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vB47hBQXP29dxblr8y5ocHPgRCp14lly7rgEc9Dk18U=;
        b=mYd9q1ZU2SkmEQdRfLvzIeaxgGMtH0cbKqkn2MtufrRDDf9eHZwOiubmK6guDYqRqQ
         gFO5fuN/x4VPe2428X63Kn2JQH3ZVP46Y8xbmsWQ3rER/CyOLfVXpWA9Yi0PzwVJ/JJO
         IeargJwFfabsebOy0T9KBlt0H+WRMhbgY3uBPffhGCUIVOgX7/WnCTdz4VbJ79qq/Izq
         nBgtGolU1Mmt3x85uFd6cjhxL5TE/NZCHidZpuC17wyT7z9IgIzGQXg241A049G4thmS
         S8xXg/nmklmxF3B3dUEh0NI7h/KBTBP4jmR2coTN/sZtD4UvKIxxD0HP8x9CAnLRRoow
         So+A==
X-Forwarded-Encrypted: i=1; AJvYcCWQh5tah2GIgHcfsOyuBgHZhPdhCRgce8FcqjiRhrI+8kJOQLOIkvxkViRotlfJYrlh+6cw6XpcoLe32gbY@vger.kernel.org
X-Gm-Message-State: AOJu0YxPuWkqrhKaSHN+wbYoIRtB96q4nopt8q7VVpfHu/JVAqlMiZgd
	3GvRGEqQzcxeTDtAiddXbkjUPT4sbGShrvPTzZ1qO+FKu788hcpDKR5rQg==
X-Gm-Gg: ASbGncv2GTFWg7yx2r1sO+8XpLco+fEx3mJp8fxVHGWQL2irqJDmcMSZT8MzHNNOziH
	9X1QxO3dK2+16Ypt6+XOwaRIDUAWjeXZYgC0zNwIKtzBOdovqR9uFGB1NmUVLTquIwfHVjAI53u
	NgsplW1Qhzp0gSBxR4ZTb9ImFXIdV+nj1MXtlpLSsyw49b/ZANAkH4nH2laQfZ2ke0T4z10ToI0
	UMxAi197GcPsoEhgfV9lYuR8OSvZLAhWnkYf9+B7LwThNX+OncKRBAbBFEgia48nVIAxaHl+f6T
	pCS0wn+/8eWfKKiJmmfT4QQ1N14F/q6eBdhOfpJdQA==
X-Google-Smtp-Source: AGHT+IGgAgkFqxy9NAonL2FmT2G8IYBtBN9WQQ2xSjSdI72Cb3527q8bOz5QijSYDyE/y8Zek4LyDw==
X-Received: by 2002:a17:902:da85:b0:224:1609:a74a with SMTP id d9443c01a7336-2319819d98amr72497615ad.34.1747248913047;
        Wed, 14 May 2025 11:55:13 -0700 (PDT)
Received: from dw-tp ([171.76.87.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271d7dsm103093975ad.123.2025.05.14.11.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 11:55:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS
In-Reply-To: <20250514161603.GG25655@frogsfrogsfrogs>
Date: Thu, 15 May 2025 00:17:41 +0530
Message-ID: <87o6vvyqpe.fsf@gmail.com>
References: <cover.1746734745.git.ritesh.list@gmail.com> <29f33ff8f54526d332c4cc590ac254543587aaa4.1746734745.git.ritesh.list@gmail.com> <20250514161603.GG25655@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, May 09, 2025 at 02:20:34AM +0530, Ritesh Harjani (IBM) wrote:
>> There can be a case where there are contiguous extents on the adjacent
>> leaf nodes of on-disk extent trees. So when someone tries to write to
>> this contiguous range, ext4_map_blocks() call will split by returning
>> 1 extent at a time if this is not already cached in extent_status tree
>> cache (where if these extents when cached can get merged since they are
>> contiguous).
>> 
>> This is fine for a normal write however in case of atomic writes, it
>> can't afford to break the write into two. Now this is also something
>> that will only happen in the slow write case where we call
>> ext4_map_blocks() for each of these extents spread across different leaf
>> nodes. However, there is no guarantee that these extent status cache
>> cannot be reclaimed before the last call to ext4_map_blocks() in
>> ext4_map_blocks_atomic_write_slow().
>
> Can you have two physically and logically contiguous mappings within a
> single leaf node?

On disk extent tree can merge two such blocks if it is within the same
leaf node. But there can be a case where there are two logically and
physically contiguous mappings lying on two different leaf nodes. 
(since on disk extent tree does not merge extents across branches.)

In that case ext4_map_blocks() can only return only 1 mapping at a time
(unless it is cached in extent status cache).


> Or is the key idea here that the extent status tree
> will merge adjacent mappings from the same leaf block, just not between
> leaf blocks?
>

Yes, in memory extent status cache can still merge this. But there can
be a case (we can argue in this case it may practically never happen)
that, the extent status cache got pruned due to memory pressure and we
have to look over on-disk extent tree. In that case we will need to look
ahead in the adjacent leaf block to see if we have a contiguous mapping.
Otherwise the atomic write will always fail over such contiguous region
split across two leaf nodes.


>> Hence this patch adds support of EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS.
>> This flag checks if the requested range can be fully found in extent
>> status cache and return. If not, it looks up in on-disk extent
>> tree via ext4_map_query_blocks(). If the found extent is the last entry
>> in the leaf node, then it goes and queries the next lblk to see if there
>> is an adjacent contiguous extent in the adjacent leaf node of the
>> on-disk extent tree.
>> 
>> Even though there can be a case where there are multiple adjacent extent
>> entries spread across multiple leaf nodes. But we only read an adjacent
>> leaf block i.e. in total of 2 extent entries spread across 2 leaf nodes.
>> The reason for this is that we are mostly only going to support atomic
>> writes with upto 64KB or maybe max upto 1MB of atomic write support.
>> 
>> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/ext4/ext4.h    | 18 ++++++++-
>>  fs/ext4/extents.c | 12 ++++++
>>  fs/ext4/inode.c   | 97 +++++++++++++++++++++++++++++++++++++++++------
>>  3 files changed, 115 insertions(+), 12 deletions(-)
>> 
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index e2b36a3c1b0f..b4bbe2837423 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -256,9 +256,19 @@ struct ext4_allocation_request {
>>  #define EXT4_MAP_UNWRITTEN	BIT(BH_Unwritten)
>>  #define EXT4_MAP_BOUNDARY	BIT(BH_Boundary)
>>  #define EXT4_MAP_DELAYED	BIT(BH_Delay)
>> +/*
>> + * This is for use in ext4_map_query_blocks() for a special case where we can
>> + * have a physically and logically contiguous blocks explit across two leaf
>
> s/explit/split/ ?

Thanks! Will fix it.

-ritesh

>
> --D
>

