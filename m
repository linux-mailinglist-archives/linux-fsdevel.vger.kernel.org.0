Return-Path: <linux-fsdevel+bounces-49269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D255AB9EBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E98EA7A9F40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858BC199FAC;
	Fri, 16 May 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZKQ5bk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F61922C4;
	Fri, 16 May 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406190; cv=none; b=o3UIwKXnZe2to7ethsNTAkT8rhDfsmW1SX5Eys7HFnkbDaxtcw5siIdHObHjCOiyZyw+TvZSMBw1h5f7DTqh1uTvD4BNFYHfF0weSX32GTF6u3co+W26NRTL4RRq4OpKU+0Rx56JoH9C1xmCp3aYxzrIvMKNh6uIbIBOgsVX2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406190; c=relaxed/simple;
	bh=fta6nrMIVM/+cFwELKqOmi5xHWs4Ef+e9jRIu3cPwOA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=o2UmZPV86dfGoysCmJlJLB9NZuB1s56WQq1/yGx+00OJW9wxqzc+nwIcn74VfjMXQ5Q5bo9FfwRVfmiZwtGEbvznRBv8YUWMenO6/idnCN2LDUiWHJd0sp5R94ZXbbQ+UQCVpCb1Yj72fFVLnzmNu2MAkpOlKH0/uZrg6ymLcLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZKQ5bk8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22fac0694aaso16554605ad.1;
        Fri, 16 May 2025 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747406187; x=1748010987; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IM+92lUsT2Z/tON4akr6Qdh1u4q79iFCAlooh+mpdNg=;
        b=hZKQ5bk8ysvPjy3+FG6yAyPw2vevvpK9AjAHD8kUKPptN+vmtDNHQVWWMC+j61KdO0
         B3D/kzhoxBq3f/y5YUhK1sqlsq2oh8PHv2N9ffOsbkb+ZMhBfPEfS2orlYWw1i8UbU8C
         Z5VwYD3yD0V8uoH5Id5YnRBtOsatuhuSHJiAavUCoBTW4SL02SX2mfyr0i6NhlHfUdso
         ijZe4iNzqIWGh6tgmGhM2NX+4GpJpAbVkR61nsB3QFt5UsnohnSTQ9qCS5bnjHAPMWvY
         yXBD9LxfjhpmxhXxDKvoM1tn/S8cn11JBOZ/cDSDqBOeRRxuvwL8RO8wxQlFCBhWYJ2T
         8AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406187; x=1748010987;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IM+92lUsT2Z/tON4akr6Qdh1u4q79iFCAlooh+mpdNg=;
        b=enriKr7GTP4ilYbzuLpxqtkfboJty9Z4TfBkNf12LglFvGEEraHtqRRNJAvSgjaYB/
         votI9ROXd0XCy/OOzPpiNFdxDdnzyC1BSC1vYRpBjXdBVznexmqX6NQwsCw4vC0wqIG9
         AD6ZCJtScvG6s3UZxYX1pf0a3t9RGYpcerwAC3vEzlGjFFCzGiFwqsT3/4uhesMqpLe/
         HIPWWU4SzDxzU6oAE97WE7JZ2W0I7bbQJQikiDTQ4K5ucZTTrBUG6b0IK+Ku3xLN0C3w
         N8DI0wcOOZzGx8NlgX5DkU3NURJckEWYhD9IqNiFXw/XrLq2Vwvn0xvTkjFXtpW5PhvK
         86Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXGY09nQtiwZvZJzj1iPWLsTTtSb3/YpZVTQN9v50sLEAVVS0enVUkTbwB5Su+7CS5VaDvmTHbZSFHwJJPs0A==@vger.kernel.org, AJvYcCXuKfXS+nfFBno9LH2D+eN0R7fjLIfDpKmQOnmYvyTms1dEqhijBYuHtCSGj5DDsIJNOfd1pbdez0RZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxyT4VNQ3Q2iJuCdK9kqllqd7LLW1MdcZlF5k3qedU8cnmTGlaI
	fMZYmrbFlZ1hiOu5SkS38OD8umqXJlgJ9QYPUYPFEWgz9BTIFpy/Rsli/PbxnA==
X-Gm-Gg: ASbGnct9GmeSBpQEpXia87ZJ65GLgUtl7NWF5HNMpZQfIMgpWmaImQTx3dsJvIldv3J
	Ucq4fPVBAYD9JX24qxgJcqeDIWG06UfuJxF7F7N87YIeTZKsoWBEzaDPv/qWwRJl3cW0BZiT3Ej
	a1CekOzNzI6EesqctE2OkQkgksNVwXL2GUWGdwvTbFuweClnECpBl7KU/VTZGb6hn5aSEAW+ahX
	WnoRTV7OE79/eiX3FJBuMkrwkclOBni27yceoSE4iYJzqvTJDJ3YrMEd7u3xYFXFOFk4WZIh+LG
	fafJ/kfIo40iDJGd3MmJM7MY6b+zet09jXHK3JlSmT8S
X-Google-Smtp-Source: AGHT+IFOOaiVSrby6HvjUISvTCcPeNM21BNo9gYeEFWqji4bptSt9Je4oVIiLQTSP3jiHyNf7KMgWg==
X-Received: by 2002:a17:903:2301:b0:231:d160:adec with SMTP id d9443c01a7336-231de351d48mr38311325ad.11.1747406186555;
        Fri, 16 May 2025 07:36:26 -0700 (PDT)
Received: from dw-tp ([171.76.80.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed5b1csm14824845ad.244.2025.05.16.07.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:36:25 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, djwong@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] ext4: Add atomic block write documentation
In-Reply-To: <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com>
Date: Fri, 16 May 2025 19:45:22 +0530
Message-ID: <87msbcwsjp.fsf@gmail.com>
References: <cover.1747337952.git.ritesh.list@gmail.com> <d3893b9f5ad70317abae72046e81e4c180af91bf.1747337952.git.ritesh.list@gmail.com> <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 15/05/2025 20:50, Ritesh Harjani (IBM) wrote:
>
> thanks for adding this info
>
>> Application Interface
>
> Should we put this into a common file, as it is just not relevant to ext4?
>
> Or move this file to a common location, and have separate sections for 
> ext4 and xfs? This would save having scattered files for instructions.
>

The purpose of adding this documentation was mainly to note down some of
the implementation details around multi-fsblock atomic writes for ext4
using bigalloc which otherwise are easy to miss. But since there was no
general documentation available on atomic writes, we added a bit more
info around it mainly enough to cover ext4.

>> +~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Applications can use the ``pwritev2()`` system call with the ``RWF_ATOMIC`` flag
>> +to perform atomic writes:
>> +
>> +.. code-block:: c
>> +
>> +    pwritev2(fd, iov, iovcnt, offset, RWF_ATOMIC);
>> +
>> +The write must be aligned to the filesystem's block size and not exceed the
>> +filesystem's maximum atomic write unit size.
>> +See ``generic_atomic_write_valid()`` for more details.
>> +
>> +``statx()`` system call with ``STATX_WRITE_ATOMIC`` flag can provides following
>> +details:
>> +
>> + * ``stx_atomic_write_unit_min``: Minimum size of an atomic write request.
>> + * ``stx_atomic_write_unit_max``: Maximum size of an atomic write request.
>> + * ``stx_atomic_write_segments_max``: Upper limit for segments. The number of
>> +   separate memory buffers that can be gathered into a write operation
>
> there will also be stx_atomic_write_unit_max_opt, as queued for 6.16
>
> For HW-only support, I think that it is ok to just return same as 
> stx_atomic_write_unit_max when we can atomic write > 1 filesystem block
>

Yes, so for HW-only support like ext4 it may not be strictly required.
To avoid the dependency on XFS patch series, I think it will be better if we add
those changes after XFS multi-fsblock atomic write has landed :)


>> +   (e.g., the iovcnt parameter for IOV_ITER).
>
>
>> Currently, this is always set to one.
>
> JFYI, for xfs supporting filesystem-based atomic writes only, i.e. no HW 
> support, we could set this to a higher value
>

Yes. But again, XFS specific detail, not strictly relevant for EXT4 atomic write documentation.

>> +
>> +The STATX_ATTR_WRITE_ATOMIC flag in ``statx->attributes`` is set if atomic
>> +writes are supported.
>> +
>> +.. _atomic_write_bdev_support:
>> +
>> +Hardware Support
>> +----------------
>> +
>> +The underlying storage device must support atomic write operations.
>> +Modern NVMe and SCSI devices often provide this capability.
>> +The Linux kernel exposes this information through sysfs:
>> +
>> +* ``/sys/block/<device>/queue/atomic_write_unit_min`` - Minimum atomic write size
>> +* ``/sys/block/<device>/queue/atomic_write_unit_max`` - Maximum atomic write size
>
> there is also the max bytes and boundary files. I am not sure if it was 
> intentional to omit them.
>

The intention of this section was mainly for sysadmin to first check if
the underlying block device supports atomic writes and what are it's awu
units to decide an appropriate blocksize and/or clustersize for ext4
filesystem.

See section "Creating Filesystems with Atomic Write Support"  which
refers to this section first.

>> +
>> +Nonzero values for these attributes indicate that the device supports
>> +atomic writes.
>> +
>> +See Also
>
> thanks,
> John

Thanks for the review John. 

I think the current documentation mainly caters to ext4 specific
implementation notes on single and multi-fsblock atomic writes.

IMO, it is ok for us to keep this Documentation as is for v6.16 and
let's work on a more general doc which can cover details like:
- block device driver support (scsi & nvme)
- block layer support (bio split & merge )
- Filesystem & iomap support (iomap, ext4, xfs)
- VFS layer support (statx, pwritev2...)

We can add these documentations in their respective subsystem
directories and add a more common Documentation where VFS details are
kept, which will refer to these subsystem specific details.

Thoughts?

-ritesh

