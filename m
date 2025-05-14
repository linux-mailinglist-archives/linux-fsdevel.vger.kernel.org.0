Return-Path: <linux-fsdevel+bounces-49004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35432AB7509
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 21:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4118C711C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E221F28CF47;
	Wed, 14 May 2025 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2AZDxEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83C27FD7F;
	Wed, 14 May 2025 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249419; cv=none; b=uUQ7I8RF6mEnQI8C3igWKSKjemG/RsUWnbhiUcJGRI9FjxSstDz387YsF+Mds6XctkQtnqTN7eXtJHpwGntmTK/3r/ZSXFYoD8bCak9gvc99qwTZKWoziwV8lgGy/1MqhVFC51y71Pj7iUlxrhpMXZZ4Hx7+rz9hBj05wvmglZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249419; c=relaxed/simple;
	bh=olQv+Iqlsw9ehf68aTDfu+IPmQk6zg7Hybbf1WgQ+kY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Bhfbg77almeBSdcssxUMm39VEOx8jlkChT8s/vEpCL9/F0+UorItUV4nFTsuJAvBrqKjRvtmsbkb+mpKl8KftYQ507wZDkAwEROZwGFXIZ4U2RX6rN0MV5Sknp8X9GnxSJZuP008OH6pcNegsVY4xp+9ejdv5ucj90iQWx4kAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2AZDxEC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30aa3980af5so265980a91.0;
        Wed, 14 May 2025 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747249416; x=1747854216; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+YlrYY3IjqLpXxJD2EBl8JMbYDzoBeESUoM4PwKQpNM=;
        b=e2AZDxECKpR+Ct/WDu4v1T27eHwoWSrpZIwF6PZhvKUIid3SnGU/cr50va31kBmSRd
         JSoqnkWRYSfUjVXFeLozGUYSMmXRHp+qBcaliepRHikp61lRtBZ/DMKXHhBh3kRyFSoi
         QC1j46pUyGTADIEk/SvnMPVo8vysuITLQVfZLmIv1z2ZYzveoGeetR9nb+3DZ0w5LzSW
         ax6vTQ3XGg9GD83maRtSRpLJk32HbQkXUvZ1sdmxNYnymGyKXcVII0EUnmoGYdyVVrME
         HZI3cA6wEtO3bHb5pFUeJxJlPeBUam7+FZ24KJKKJ4hz+WR12lpHwKBH1wLOe3/Vl/C4
         Y8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747249416; x=1747854216;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YlrYY3IjqLpXxJD2EBl8JMbYDzoBeESUoM4PwKQpNM=;
        b=cPRcal9xbLdslc2iqVVlOnSqMH7qgwwB8ugqBMjTny6fa27EU+0QnwRu2bpRD7QM77
         focKFRml242Jb+D2+kbzMaCk0d/qJghYEOuc8c/2cNmTaKDtb2dSPUDYg63XXnxQEgTs
         nB6QpkxY1dnc6OBwsP2US9wvSyFVHYr201K/FsZybyCO2YbOTOHf+utrUQeoFqi7eqjw
         hASyKj11eH6fKk6OGsxQrVuktFJp5nouIjK//6+fMlKvMeBPbJEzFcyibJ/LIgwBLa2j
         jam5mc4Ecya7pNNp9QOgGESzY/Zfk9GEuMZrSIzwB/ivuJo3ln5H+O2RcD0E5Cd2DNcT
         LjYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJVe3kXaQPhP9CqmuRrYZGqjzb6YLiMOeh1dn5W7GaJdLve29Bh/u5gl4n5PMHmveKSnr1AwpOoLK/tIpa@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcGpoV3o+lUE4jXtoS3Kapn/zfnUVqGSI2bUv6KEWbkGoF2Qi
	nYHntHqrKxKq/SBth/c7FP3hxmQ7bEElDztq0A0mu++AJHX1NdkLwrO5WQ==
X-Gm-Gg: ASbGncvsWbB6ekgfaYa5K5D1nvhz/9vG/oEWJ1VEX0tFhBwzIPGAXeWrqgl59qo2YwN
	GpOJcTMz1BDL671hS47VkmbtilIZBXzzNOIvt6c2MRlm3YdGDoITu4MlYOuCJNauWIIvDUaSjO/
	j0QYy3Vgei0usq6L1GZFd0xPUZRl7QgwKvDMyhongxaxI+A241d9Nfj8rEKNtFeUwQkyuXHl0FC
	TivZM3rzoq75cOtphXdLul6rpgN4ys0/lktcuNQvmIwufL85y/g3V2IZfqwNRS5REA9xsmMAiro
	jSp/ZMvtMi4HtNRVWoXPEa4EYMGtBlAvWsSYvToxtw==
X-Google-Smtp-Source: AGHT+IFbu69pSUT7wwKqG/eIEoUwq1BOEcX7Rot6KZp0Juj8t1zj9HsqIg803Iz0y59z+K1q8JP/jQ==
X-Received: by 2002:a17:90b:1344:b0:2ff:6f88:b04a with SMTP id 98e67ed59e1d1-30e2e5d7e05mr7543185a91.15.1747249415954;
        Wed, 14 May 2025 12:03:35 -0700 (PDT)
Received: from dw-tp ([171.76.87.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e334e2939sm1914651a91.33.2025.05.14.12.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 12:03:35 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] ext4: Add multi-fsblock atomic write support with bigalloc
In-Reply-To: <20250514164050.GN25655@frogsfrogsfrogs>
Date: Thu, 15 May 2025 00:25:21 +0530
Message-ID: <87msbfyqcm.fsf@gmail.com>
References: <cover.1746734745.git.ritesh.list@gmail.com> <87h61t65pl.fsf@gmail.com> <20250514164050.GN25655@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, May 09, 2025 at 11:12:46PM +0530, Ritesh Harjani wrote:
>> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
>> 
>> > This is v3 of multi-fsblock atomic write support using bigalloc. This has
>> > started looking into much better shape now. The major chunk of the design
>> > changes has been kept in Patch-4 & 5.
>> >
>> > This series can now be carefully reviewed, as all the error handling related
>> > code paths should be properly taken care of.
>> >
>> 
>> We spotted that multi-fsblock changes might need to force a journal
>> commit if there were mixed mappings in the underlying region e.g. say WUWUWUW...
>> 
>> The issue arises when, during block allocation, the unwritten ranges are
>> first zeroed out, followed by the unwritten-to-written extent
>> conversion. This conversion is part of a journaled metadata transaction
>> that has not yet been committed, as the transaction is still running.
>> If an iomap write then modifies the data on those multi-fsblocks and a
>> sudden power loss occurs before the transaction commits, the
>> unwritten-to-written conversion will not be replayed during journal
>> recovery. As a result, we end up with new data written over mapped
>> blocks, while the alternate unwritten blocks will read zeroes. This
>> could cause a torn write behavior for atomic writes.
>> 
>> So we were thinking we might need something like this. Hopefully this
>> should still be ok, as mixed mapping case mostly is a non-performance
>> critical path. Thoughts?
>
> I agree the journal has to be written out before the atomic write is
> sent to the device.

Yes, we were even able to reproduce this problem on an actual nvme
(which supports atomic write), with one of our data integrity test
(which btw still needs little clean up for us to post for integrating it with xfstests).

>> 
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 2642e1ef128f..59b59d609976 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3517,7 +3517,8 @@ static int ext4_map_blocks_atomic_write_slow(handle_t *handle,
>>   * underlying short holes/unwritten extents within the requested range.
>>   */
>>  static int ext4_map_blocks_atomic_write(handle_t *handle, struct inode *inode,
>> -                               struct ext4_map_blocks *map, int m_flags)
>> +                               struct ext4_map_blocks *map, int m_flags,
>> +                               bool *force_commit)
>>  {
>>         ext4_lblk_t m_lblk = map->m_lblk;
>>         unsigned int m_len = map->m_len;
>> @@ -3537,6 +3538,11 @@ static int ext4_map_blocks_atomic_write(handle_t *handle, struct inode *inode,
>>         map->m_len = m_len;
>>         map->m_flags = 0;
>> 
>> +       /*
>> +        * slow path means we have mixed mapping, that means we will need
>> +        * to force txn commit.
>> +        */
>> +       *force_commit = true;
>>         return ext4_map_blocks_atomic_write_slow(handle, inode, map);
>>  out:
>>         return ret;
>> @@ -3548,6 +3554,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>>         handle_t *handle;
>>         u8 blkbits = inode->i_blkbits;
>>         int ret, dio_credits, m_flags = 0, retries = 0;
>> +       bool force_commit = false;
>> 
>>         /*
>>          * Trim the mapping request to the maximum value that we can map at
>> @@ -3610,7 +3617,8 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>>                 m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
>> 
>>         if (flags & IOMAP_ATOMIC)
>> -               ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags);
>> +               ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
>> +                                                  &force_commit);
>>         else
>>                 ret = ext4_map_blocks(handle, inode, map, m_flags);
>> 
>> @@ -3626,6 +3634,9 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>>         if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>>                 goto retry;
>> 
>> +       if (ret > 0 && force_commit)
>> +               ext4_force_commit(inode->i_sb);
>> +

Needs to handle return value from ext4_force_commit() here. Will
integrate this change in v4. 

-ritesh

>>         return ret;
>>  }
>> 
>> 
>> -ritesh
>> 

