Return-Path: <linux-fsdevel+bounces-18469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8838B93CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 06:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8428CB21E90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 04:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCB41C2A3;
	Thu,  2 May 2024 04:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZDdX0d1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695E1865A;
	Thu,  2 May 2024 04:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714623115; cv=none; b=DxJ/OlIA2d7PwegFo0Ki7M7BGxjBRXltFTVAY9x7q0ddLVY2nTQR1JbqLCcjCgTRh0P66nlI/uOtlk1DXaIrwl/vXR6OzVFnOor+I3tWpUFhXNS48x5lVsBTjnebSL3Yh5Dd//DoiS3MFTcPQdnOvsTcJ7TsnFjUtNRW6z8wpew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714623115; c=relaxed/simple;
	bh=9P2xg7FQQsOTqsM9+ldNhqpV6mM5zpq+Ljk3LmOB/qU=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=r2kBmjmYVn4NCyZKXc29iEixED7Sd5mRKlchuNdCatFKV2Ze+QW60x7cHdKZy2Ihc9OeI+M9EIiI0Ty4xcDhF6RgioHHQTzXvW8OvDrCESYXzIB6iVhAf+NZj9aOs/tYUI4n2V7zkl9qqCHK8hAcbrqw+t9rCEiXmTuYBcFW9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZDdX0d1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f07de6ab93so7003090b3a.2;
        Wed, 01 May 2024 21:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714623113; x=1715227913; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d/pO3KnwV5/hmCMrLfPzaasia4xkM57wUS++D9NkkGM=;
        b=SZDdX0d18CUSTMLrCSPYdQI/+aBPoUswr8jpOm9j3R8K7UR9/mQHkotu5BFhEikQ6I
         DtLczDuLv3HUDLgynG1J6jpHe22vAdhDu5pcPH4nchVK+r8MlwBjHCRSm7SCWJI3y8Rn
         hPraL6ksyvTnrz807oOwbGYXHiPlyPJwFNz+yO6FflNnrVepMqtGAZbENEOpLKmkUxlX
         AI7b9WxetdnkHEY3JGQOzZWx27EJEkToacVo76QEUdhh6j+RC/o/TeUmgeBSx/CcJ3bn
         1BYRGPSqAqagKENYCtMa/zXhYquYyAOER0BIGf7MfHuQdd+sQZ+KFbtC562tZdVxcv+M
         26Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714623113; x=1715227913;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/pO3KnwV5/hmCMrLfPzaasia4xkM57wUS++D9NkkGM=;
        b=l8dsh5TVvrHS2mssEOs3rFCcmEyzo4QtFwaeunaY0XW+X2eThwNdj/7yA26MrM8QD9
         8eqEbUgyO3DPaG9EFyFZzkFSYQKGnnwXQGA3P7gDoV+lxd2gbVdYD+SglYZsrqzqsHVr
         tUTxQd8olu3WTHaCVGYLMc/574ewkqsuXCDSeFrwd1Ud41I7iR5rLCVYkRnqtvp3E9Pw
         3aJbp4/8Y1uPCvF6b5kB3OHjsAaVwupf2mOfDq1pEDODovr10GaeY9mdAJGk3+T+f41S
         28PVo9R+6/6kqmQ/Po+r4UOaqTLvmPbmwVYSXObqUwQWWQXqk3bdqfKG8ui0OMn/kR+y
         AITA==
X-Forwarded-Encrypted: i=1; AJvYcCUBVIZhKXRzAbANF8FebYQBgCqWNmGOM6NDYKUYW8YgNLAS9YZ06rfRW15mcdlZtB2bcC23IDYsB6OENfPnSTaxC2yR1UV04rLn8mSCARGEaOC12aZGi54lwcH/vWZ8FkJhT5niH6VCrS1fFLDxBJs1KwJ1W6J4sZimeJs5v9pOSeDPslBmRuI=
X-Gm-Message-State: AOJu0YwckLwEsq0kJ0WXRp1TJkl071TDigRPuE7v9cWUz7JGNaDfKfwV
	5u16zYh811pwvdbHe96au1b12CuXhLPc+U0Giy3trZLc7z0XhXu9
X-Google-Smtp-Source: AGHT+IHBezvM4qNTsf04QOHARohIj7h1mUhy1D38HBCSojZX6TJxw+sBESjB8870/wRg2sNyBm0Xjw==
X-Received: by 2002:a05:6a21:8189:b0:1af:63f2:bc62 with SMTP id pd9-20020a056a21818900b001af63f2bc62mr4674374pzb.15.1714623112936;
        Wed, 01 May 2024 21:11:52 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b001eb2f4648d3sm169228plg.228.2024.05.01.21.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:11:52 -0700 (PDT)
Date: Thu, 02 May 2024 09:41:39 +0530
Message-Id: <87a5l8am4k.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org, djwong@kernel.org, willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before inserting delalloc block
In-Reply-To: <ZjLG9PK0uMFgSqhj@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Wed, May 01, 2024 at 05:49:50PM +0530, Ritesh Harjani wrote:
>> Dave Chinner <david@fromorbit.com> writes:
>> 
>> > On Wed, Apr 10, 2024 at 10:29:16PM +0800, Zhang Yi wrote:
>> >> From: Zhang Yi <yi.zhang@huawei.com>
>> >> 
>> >> Now we lookup extent status entry without holding the i_data_sem before
>> >> inserting delalloc block, it works fine in buffered write path and
>> >> because it holds i_rwsem and folio lock, and the mmap path holds folio
>> >> lock, so the found extent locklessly couldn't be modified concurrently.
>> >> But it could be raced by fallocate since it allocate block whitout
>> >> holding i_rwsem and folio lock.
>> >> 
>> >> ext4_page_mkwrite()             ext4_fallocate()
>> >>  block_page_mkwrite()
>> >>   ext4_da_map_blocks()
>> >>    //find hole in extent status tree
>> >>                                  ext4_alloc_file_blocks()
>> >>                                   ext4_map_blocks()
>> >>                                    //allocate block and unwritten extent
>> >>    ext4_insert_delayed_block()
>> >>     ext4_da_reserve_space()
>> >>      //reserve one more block
>> >>     ext4_es_insert_delayed_block()
>> >>      //drop unwritten extent and add delayed extent by mistake
>> >
>> > Shouldn't this be serialised by the file invalidation lock?  Hole
>> > punching via fallocate must do this to avoid data use-after-free
>> > bugs w.r.t racing page faults and all the other fallocate ops need
>> > to serialise page faults to avoid page cache level data corruption.
>> > Yet here we see a problem resulting from a fallocate operation
>> > racing with a page fault....
>> 
>> IIUC, fallocate operations which invalidates the page cache contents needs
>> to take th invalidate_lock in exclusive mode to prevent page fault
>> operations from loading pages for stale mappings (blocks which were
>> marked free might get reused). This can cause stale data exposure.
>> 
>> Here the fallocate operation require allocation of unwritten extents and
>> does not require truncate of pagecache range. So I guess, it is not
>> strictly necessary to hold the invalidate lock here.
>
> True, but you can make exactly the same argument for write() vs
> fallocate(). Yet this path in ext4_fallocate() locks out 
> concurrent write()s and waits for DIOs in flight to drain. What
> makes buffered writes triggered by page faults special?
>
> i.e. if you are going to say "we don't need serialisation between
> writes and fallocate() allocating unwritten extents", then why is it
> still explicitly serialising against both buffered and direct IO and
> not just truncate and other fallocate() operations?
>
>> But I see XFS does take IOLOCK_EXCL AND MMAPLOCK_EXCL even for this operation.
>
> Yes, that's the behaviour preallocation has had in XFS since we
> introduced the MMAPLOCK almost a decade ago. This was long before
> the file_invalidation_lock() was even a glimmer in Jan's eye.
>
> btrfs does the same thing, for the same reasons. COW support makes
> extent tree manipulations excitingly complex at times...
>
>> I guess we could use the invalidate lock for fallocate operation in ext4
>> too. However, I think we still require the current patch. The reason is
>> ext4_da_map_blocks() call here first tries to lookup the extent status
>> cache w/o any i_data_sem lock in the fastpath. If it finds a hole, it
>> takes the i_data_sem in write mode and just inserts an entry into extent
>> status cache w/o re-checking for the same under the exclusive lock. 
>> ...So I believe we still should have this patch which re-verify under
>> the write lock if whether any other operation has inserted any entry
>> already or not.
>
> Yup, I never said the code in the patch is wrong or unnecessary; I'm
> commenting on the high level race condition that lead to the bug
> beting triggered. i.e. that racing data modification operations with
> low level extent manipulations is often dangerous and a potential
> source of very subtle, hard to trigger, reproduce and debug issues
> like the one reported...
>

Yes, thanks for explaining and commenting on the high level design.
It was indeed helpful. And I agree with your comment on, we can refactor
out the common operations from fallocate path and use invalidate lock to
protect against data modification (page fault) and extent manipulation
path (fallocate operations).


-ritesh

