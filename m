Return-Path: <linux-fsdevel+bounces-11096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A902850F8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 10:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054EC1F21856
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B5107A6;
	Mon, 12 Feb 2024 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ/zY1lA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF17101C2;
	Mon, 12 Feb 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707729384; cv=none; b=ZT0j3uWEi/gcy+TM098qW8WsPACM4bsLEm7Z1W5HnnwBXyfzOcgOXF2kYEK/hx3CUJnGwIOfR5BYMrAYEBO1XKKzT31h32pf1fEzUgJ49WRsJIdTnTfLGkV5x6eVIMfY7n9evnIGeFQ16DAaOPKXXzmR/I7h9VkyQ/HFQfosFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707729384; c=relaxed/simple;
	bh=zUG1WqlA0YtwRVLcWHISLkv3a3WSW8qTED3nIesi2HQ=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=tcYuTgjQ2FkqEvPTRVIO2IDMqolCw3iVGktCVsgvuJCZKLqOtkF4aLxYGFgHBqruEFdCa/n8nTBEEl/GeAJoFpPZrxpKx955o4cJFapeVpbsVoEIW1TxXTWFWCPyux9W8m0mzGx4odV3ATCe1uRl0jhnsCBrkF2QnHSml8RViqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ/zY1lA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so2493376b3a.0;
        Mon, 12 Feb 2024 01:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707729382; x=1708334182; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g6IO++R9WeYb4qAE84/3bcX8ZgMaoHDBddIgy6fgRYw=;
        b=GZ/zY1lA9PvphYWqTnb/PXYkg8lxqjAN3HYNmhdFolsd0Dg1ZmUq4V73tJqlK5Xr9B
         ePUUijM/RKGE0UTkdkLbDvp5QTnBycqoCEwL1UD71VbrQXgPeTiWTzDBZkM8kA8D3Zpo
         mid4UHofVY60gBMWGqI5l9o31rJ2iqZSP9kzwnXNPTrSOKwC/tsLh8gKFD+ZNphCmZWH
         0qXlW27AwWNdSLp4UhZDmuH0vMeTy71yrweQI8rhl5Hf4hxBjyBwvBC4/9UroEuoaNn9
         lDe26Rp0f8m9VFgAKysRN/xrXJPnri1yp2poFDRnQCBKEn0asvd0j1a9X/77oJrWIPyh
         OSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707729382; x=1708334182;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6IO++R9WeYb4qAE84/3bcX8ZgMaoHDBddIgy6fgRYw=;
        b=Jw7yg0d1eUD0+c2rhAv8KKNFcS79tDk+R8MBbr6WLhGzpVinNzJBFPQXUtIyaSRPEj
         EUiiLuKZD03I5zQjs3hHUJqAoWTRxVm892xnWb56YthQ0XCYf9enldciJbbM6LpFrYz0
         U+oGDv7dE600cDrg0VcxNHlbIBYuzAfAoLN9sFxCrpWiXwDAhu/khuZ0H838PvhPsXRV
         GAl7l7+rUSoI7DGrP5umTS40dsGp4MQCq8XGyzV/mvYlgyrs/miYX263JIdSYgSZTMVt
         90mSQnZIHUbFmy84kDEzgY/r9OLQgmhST6CEQ0BB8F3K/EKOyNylT64LzdA07Z2HWV9n
         bq0g==
X-Forwarded-Encrypted: i=1; AJvYcCUVw12iOohC8DZETcInlSiBcWHCkPhO0HXjyHr7kX0+M2KFvJHT8cGGuzODmHmHgyCbrJvPhnEufV1BOasOYuKkFGWU/OY9zGdt12RBPV6/UoImZm4Gv+d4RhIHP5Igc1S0grCxNesLmhIxrA==
X-Gm-Message-State: AOJu0YwLz6hlS3tOkqSrL0BH7OIYj0zmIwqJNj4qNTPNgQTfHX3DT9+u
	NLCHwQvuBdoUsM7Q1pTVei2b/JJ1jQZiOTdsUJzrnKVIWCADCeDB1JrTiqT6
X-Google-Smtp-Source: AGHT+IFvWWdoMQM6RNYDapxbsM4h4P3YcXw3SecLY3N7HCNZ2L6CMlzm0f7SFQlfUpgy0Dd9wL6DMg==
X-Received: by 2002:a05:6a00:3d4e:b0:6e0:e5d2:5f01 with SMTP id lp14-20020a056a003d4e00b006e0e5d25f01mr1314349pfb.24.1707729382365;
        Mon, 12 Feb 2024 01:16:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/RlqtvHvacAp6YKw4f2dp/IVrLfxbfR0vs8PmplbdlO2NqWyb8hnHrUszD8mYwHgpJwpNulu2y3QYAxNPTnBoDeqw9dYOvukIOcrO+O/aCIbIFfJ7H2nIVK0WuRKEjlVSJH5W6RViZu+q6U7S/1uM67vFLzwRDKkTGwmI+8iMcSLHVyVqNmyXaA6w4VJfWZ9kQaAEW7kxBzaqLTW4OhJEco12e8DP/kLK9ZOXViV7yeysijtXfYuSMK/pffRJLgfgFdDuMb2BdysCiteM8/SSN4inr6BGDvYoJeTaLSZJo+6FDbr7GbCEuE8KkqmXBrbemdoUyY48QUP48tVUnjwzHaC9OJBhUi3xANSV8F68tZtYZHA8ZumjGOufjMBqIR/WRrR8uREEpAaOsv2J2yU89MG3moIK6UlnQntEmVA8O2joCfnlIrfDKjAO6Y/gEid2BQ3HcP8R/1NrUzH5iZyXkulsh1LQEd5lVg==
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id lo17-20020a056a003d1100b006dbda7bcf3csm5042750pfb.83.2024.02.12.01.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:16:21 -0800 (PST)
Date: Mon, 12 Feb 2024 14:46:10 +0530
Message-Id: <87ttmef3fp.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org, willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v3 00/26] ext4: use iomap for regular file's buffered IO path and enable large foilo
In-Reply-To: <20240212061842.GB6180@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Sat, Jan 27, 2024 at 09:57:59AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>> 
>> Hello,
>> 
>> This is the third version of RFC patch series that convert ext4 regular
>> file's buffered IO path to iomap and enable large folio. It's rebased on
>> 6.7 and Christoph's "map multiple blocks per ->map_blocks in iomap
>> writeback" series [1]. I've fixed all issues found in the last about 3
>> weeks of stress tests and fault injection tests in v2. I hope I've
>> covered most of the corner cases, and any comments are welcome. :)
>> 
>> Changes since v2:
>>  - Update patch 1-6 to v3 [2].
>>  - iomap_zero and iomap_unshare don't need to update i_size and call
>>    iomap_write_failed(), introduce a new helper iomap_write_end_simple()
>>    to avoid doing that.
>>  - Factor out ext4_[ext|ind]_map_blocks() parts from ext4_map_blocks(),
>>    introduce a new helper ext4_iomap_map_one_extent() to allocate
>>    delalloc blocks in writeback, which is always under i_data_sem in
>>    write mode. This is done to prevent the writing back delalloc
>>    extents become stale if it raced by truncate.
>>  - Add a lock detection in mapping_clear_large_folios().
>> Changes since v1:
>>  - Introduce seq count for iomap buffered write and writeback to protect
>>    races from extents changes, e.g. truncate, mwrite.
>>  - Always allocate unwritten extents for new blocks, drop dioread_lock
>>    mode, and make no distinctions between dioread_lock and
>>    dioread_nolock.
>>  - Don't add ditry data range to jinode, drop data=ordered mode, and
>>    make no distinctions between data=ordered and data=writeback mode.
>>  - Postpone updating i_disksize to endio.
>>  - Allow splitting extents and use reserved space in endio.
>>  - Instead of reimplement a new delayed mapping helper
>>    ext4_iomap_da_map_blocks() for buffer write, try to reuse
>>    ext4_da_map_blocks().
>>  - Add support for disabling large folio on active inodes.
>>  - Support online defragmentation, make file fall back to buffer_head
>>    and disable large folio in ext4_move_extents().
>>  - Move ext4_nonda_switch() in advance to prevent deadlock in mwrite.
>>  - Add dirty_len and pos trace info to trace_iomap_writepage_map().
>>  - Update patch 1-6 to v2.
>> 
>> This series only support ext4 with the default features and mount
>> options, doesn't support inline_data, bigalloc, dax, fs_verity, fs_crypt
>> and data=journal mode, ext4 would fall back to buffer_head path
>
> Do you plan to add bigalloc or !extents support as a part 2 patchset?
>

Hi Darrick,

> An ext2 port to iomap has been (vaguely) in the works for a while,

yes, we have [1][2]. I am in the process of rebasing that work on the latest
upstream. It's been a while since my last post since I have been pulled
into some other internal work, sorry about that.

> though iirc willy never got the performance to match because iomap

Ohh, can you help me provide details on what performance benchmark was
run? I can try and run them when I rebase.

> didn't have a mechanism for the caller to tell it "run the IO now even
> though you don't have a complete page, because the indirect block is the
> next block after the 11th block".

Do you mean this for a large folio? I still didn't get the problem you
are referring here. Can you please help me explain why could that be a
problem?

[1]: https://lore.kernel.org/linux-ext4/9cdd449fc1d63cf2dba17cfa2fa7fb29b8f96a46.1700506526.git.ritesh.list@gmail.com/
[2]: https://lore.kernel.org/linux-ext4/8734wnj53k.fsf@doe.com/

-ritesh

