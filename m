Return-Path: <linux-fsdevel+bounces-18428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 512318B89DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 14:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588ADB23B19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A9512FB16;
	Wed,  1 May 2024 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2fvmp9a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768012C49F;
	Wed,  1 May 2024 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566000; cv=none; b=Nra3kwn3k141OcNxrnF/4o3ETuNfy0J7Xx2hj44x5uwjN3cTp+uw4ao63lPVjzaIzkQJc4A5tIRkLjd9egjkHYqQboMafDacZiX6Cdak82JRlhW+JRVPbiIJ20wH8sdMB9Y6nbDQsSXUWcziGeMLnxK9hqYmzI4Zvi7BdtOtk6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566000; c=relaxed/simple;
	bh=cDoOmYzAYQKD5INwb4Si/7qAYJjCsw6v5b3DdRgc5GA=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=TgLXsUkc1RQaHR95CKAVR/hLW6QyNskyV+VLpjiiZRtUGYc7GOeIjk6IuJ1dsyaupb+7zaWcBERY62JZlORJEot5tS0MBLprwhQe6Q5ILdQ8BHT8yMCRlYODqN0QIxAxB+rAKgamVJ+LGwCvmNFPrmHjsWCBdLS9uBRWbGVpAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2fvmp9a; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e50a04c317so36841005ad.1;
        Wed, 01 May 2024 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714565999; x=1715170799; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+bXJh1WFpGfj02zZsMPGyMBrA1lTWkDff/10uQbdd4=;
        b=m2fvmp9acjoYlmSyXFxav3ezR/+FFF+ZS8U6ek1GHHr9GEl0mPNQ9Iz1us5rJzrsHO
         FZvei1qTNpG6M9yIYUixYEXDV7I5TTVIHtceavJHPXuBhzotzyU98D2mm7queqq0+dDa
         Pr5d4a0iq7x75AS3WEdMnXEVzYj0/mypE1mciNQifneXPxqMa3ni984F6+QjBgDTVsOI
         oQ5D1vyamvg85tfnhvFvbF3ulXG0iD81x0RFxx8/mukWSyhcMdAAjwZgpVybWJ5tSKti
         fyNCgrTO+9n/NHrE/4XJYO7pMCNUsVwQGaB0/5OTtFMf1RiWi/X5hScyLagjjj5cUj+y
         SlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565999; x=1715170799;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+bXJh1WFpGfj02zZsMPGyMBrA1lTWkDff/10uQbdd4=;
        b=JPmMsMmzX8gy6dgRLA8xby2eZcPTzBELBaCtAbksi5Uji6+cQ3VqnAKsObb17dlllM
         NgLzvNXWZXGpmpRBAKHUiYBoqdJUDnoHXu72WQiu8Ga3upukEIZyP1YSibsriBPC8iHh
         d3XoFV5imL4fknchOZLJHgA3jQ6m9mF7ySktNZ76yIht2tuj/3i6HdIgiXmpNbRe/0pC
         Gld38lrW4RWyX7uKU86tv49Ushk08esk4RdxyHl4HebCkd1wo+y9ai/XI5VBml9yiLul
         cYzBoABH8jYVQl93PlrBcjRnBbInsqJRYeujvHyJAbonfV0h+uRlmEV3dAI0h2F1WTo0
         bpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpFvpe2pGQT+xkS5zOxlfU5ZF89wuixsBF5WeXHBIgDcOFdTChJWfTeWA/9Ub+5CkOMkrEEp5lW0NwlcZ/9Fz/l/fiGQByJF0jwgeCqP1HmN8KfokQkQDnK4OMNyZwvvt2WYeK6aqoOw+A9Q==
X-Gm-Message-State: AOJu0Yy+nxFC+AO4Oe4ecNeoiA4h1KsuFS4jnAgN4KQW/PtN+ab0a27q
	kA5t2FUExBZrQ5BTxe+knCBPtEnotJ+IwM0uiF+LkL4PLRCgiq/u
X-Google-Smtp-Source: AGHT+IHH66m34ehe2oGyA8sEbgvqCf0QfvwZyF4PH1MwqMJKPg649zwjVE/zpqgicmyWWWJMHAmO0A==
X-Received: by 2002:a17:902:c213:b0:1e4:24bc:426e with SMTP id 19-20020a170902c21300b001e424bc426emr2154990pll.28.1714565998423;
        Wed, 01 May 2024 05:19:58 -0700 (PDT)
Received: from dw-tp ([171.76.84.250])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b001ebd72d55c0sm5600171pla.18.2024.05.01.05.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:19:57 -0700 (PDT)
Date: Wed, 01 May 2024 17:49:50 +0530
Message-Id: <87le4t4tcp.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org, djwong@kernel.org, willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before inserting delalloc block
In-Reply-To: <ZjHmY6RoE3ILnsMv@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Wed, Apr 10, 2024 at 10:29:16PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>> 
>> Now we lookup extent status entry without holding the i_data_sem before
>> inserting delalloc block, it works fine in buffered write path and
>> because it holds i_rwsem and folio lock, and the mmap path holds folio
>> lock, so the found extent locklessly couldn't be modified concurrently.
>> But it could be raced by fallocate since it allocate block whitout
>> holding i_rwsem and folio lock.
>> 
>> ext4_page_mkwrite()             ext4_fallocate()
>>  block_page_mkwrite()
>>   ext4_da_map_blocks()
>>    //find hole in extent status tree
>>                                  ext4_alloc_file_blocks()
>>                                   ext4_map_blocks()
>>                                    //allocate block and unwritten extent
>>    ext4_insert_delayed_block()
>>     ext4_da_reserve_space()
>>      //reserve one more block
>>     ext4_es_insert_delayed_block()
>>      //drop unwritten extent and add delayed extent by mistake
>
> Shouldn't this be serialised by the file invalidation lock?  Hole
> punching via fallocate must do this to avoid data use-after-free
> bugs w.r.t racing page faults and all the other fallocate ops need
> to serialise page faults to avoid page cache level data corruption.
> Yet here we see a problem resulting from a fallocate operation
> racing with a page fault....

IIUC, fallocate operations which invalidates the page cache contents needs
to take th invalidate_lock in exclusive mode to prevent page fault
operations from loading pages for stale mappings (blocks which were
marked free might get reused). This can cause stale data exposure.

Here the fallocate operation require allocation of unwritten extents and
does not require truncate of pagecache range. So I guess, it is not
strictly necessary to hold the invalidate lock here.
But I see XFS does take IOLOCK_EXCL AND MMAPLOCK_EXCL even for this operation.

I guess we could use the invalidate lock for fallocate operation in ext4
too. However, I think we still require the current patch. The reason is
ext4_da_map_blocks() call here first tries to lookup the extent status
cache w/o any i_data_sem lock in the fastpath. If it finds a hole, it
takes the i_data_sem in write mode and just inserts an entry into extent
status cache w/o re-checking for the same under the exclusive lock. 
...So I believe we still should have this patch which re-verify under
the write lock if whether any other operation has inserted any entry
already or not.


>
> Ah, I see that the invalidation lock is only picked up deep inside
> ext4_punch_hole(), ext4_collapse_range(), ext4_insert_range() and
> ext4_zero_range(). They all do the same flush, lock, and dio wait
> preamble but each do it just a little bit differently. The allocation path does
> it just a little bit differently again and does not take the
> invalidate lock...

Yes, I think it is not stricly required to take invalidate lock in the
allocation path of fallocate. Hence it could expose such a problem which
existed in ext4_da_map_blocks(), right?


>
> Perhaps the ext4 fallocate code should be factored so that all the
> fallocate operations run the same flush, lock and wait code rather
> than having 5 slightly different copies of the same code?

Yes. I agree. These paths can be refactored and if we are doing so, we
may as well just use the invalidate lock as you suggested.

-ritesh

