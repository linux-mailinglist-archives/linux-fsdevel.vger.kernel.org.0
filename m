Return-Path: <linux-fsdevel+bounces-49173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0769AB8EA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 20:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA2D1BC7799
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F58227E98;
	Thu, 15 May 2025 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRBPZNer"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237CAC120;
	Thu, 15 May 2025 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332944; cv=none; b=twahGMWo3/ay0GjQRwmMOvxbJKG/w/6QfKCqExq0IVUqmtTvzFyBv3zSo9UQsN1EfJvSmKx8pLx2H3VSs7z0f1CFCUnJf/xRV5PTPH8zVSNcE7IM/qPzfgxa4uFXCKQEz3QD5ZZ+q4zcthDKTbTix1ki7TjQI80MmAodpmR23cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332944; c=relaxed/simple;
	bh=w9miBO5UQ/iOirnMGv9pf+IIPDaI4GpUyrpt7TTTbdQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=o8FJE2l4B5E25W/meqB/KX2MpkQ8eHZCbKOsQaGPvzCStAjuZ474xlVVXs62zLQFz9y6BXYSDdwT0RiCfESa1M8EvTnGrXHox1GmMe8d73n0+17F8GUPWs4QE5HLHe4oUE1LAqSx8Sb7xyIyI93LAnwBVnG+df4xsRSk/JIBItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRBPZNer; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7423fb98cb1so1570842b3a.3;
        Thu, 15 May 2025 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747332942; x=1747937742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0Ym7zMWibe1G7GXw0DgDucXriZKLssgRREVxYMi1Fo=;
        b=lRBPZNerxnSWip3dTAMOXpiyIGDaiDxrCykNuAy2mxF1pgaz6e1omQz39CNqRRmSa0
         eSUoEwoPRbPEEAuBvpalDdNnspuOVye9bWHwT/UZEKF3jkhT6WjIp0f87AfXa5lGLNcc
         ds3cwhW4S7Icl2y1Xxd5g1QFgIp2JtlmCRMsce1kHODy3lUvHe8SkrJ/H5/DHxB2iseV
         9+sQ+Ddv8XOzcsuVKY4VL6ffi/269zFYtTONka61787Ax+hl0G2w6aHC3MquQCwR1sLi
         Kysdr/SlMzBqdRsuaM6QM/39BXckjWSD3/7mbjmy8psJmJ7YzPrNkZUFHfsi+kHLI+OA
         oZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332942; x=1747937742;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0Ym7zMWibe1G7GXw0DgDucXriZKLssgRREVxYMi1Fo=;
        b=mgjIy8ObZEHhwhich116WsLq+C+LabXvd8Yj6NcBQBqoHG8f3+vESWcdvpq+u0esJN
         xos8emEjlvwHfQv9QLkzsty09gn1NCTdoKPkYXWWlMvRSKyLYE2vJqR7jgrWkVa2/D02
         0GBnmiQPSTdxrN987xeSFNc00Un5ROKO0pqrWuQZ9WRIAlnUckMkVWICKTyr+/eC3ef4
         HvLEJ8c3AHNRatLTRKHVlXdF0rScfTcgteWd+chh3dLMDbRzSW2OQO4IBhMAP+HxBJm6
         3gyL6XVXdB/R4BPwcSsIhw2OY4FeEsL8W7T7VffdYF4YSYmOVGiGPFsSIUS/4FjQoJED
         ttOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbv4MhFi9UYxzTVKQXYkO9SkfmdpaIj9lZwbdY3fUl7hc2rVzUU+1o722sZzXS5gXUJLijSa59LJUDSl+f@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+p99S7yRta6eGougwsYPiV1oTy94173y+LYg98CsFMj6qfkzM
	tySlwta3Mv58AjZk1KbNrf99PbP5JQlx0oE4DMAWLjh2oehkQiWs8LmWdodyDQ==
X-Gm-Gg: ASbGnctto9D5Rya8ZrgGOhLKojuoW30W1DT/Ix6WRxfvjoE83VdHX5BGwgESSrrHG4t
	zSMQs8clq976jcJAyIbsKuxSvNd184jsIwGWTBF2rTCtkaH7FmCuzSVUmZpokuknvQdwrifOXnA
	Mrwq13xe49gUA2jgz36Y1S/sBTnPqepfadkGLZ2b4sKirvfBwhGRkOEOL/fl1M5KIZdhyJYz7I6
	n/S5Wk4MiGrK/IM0SJOPIc4FLpaaBKUixfFrmg5C4NgrD9FPcCfht36fPE1Mekh6NPJu0CN/UDx
	l/IlhH3HKKTIPMtiESu0DvutJovhynCY5TpA8JHilC3pwdK6SbeQ//I=
X-Google-Smtp-Source: AGHT+IH6ZSW0nbhOJIyzlPCD+90mw37APpAX2deRR1dsego/Tc1GEUQ8a6sbbzN+P4EjaEb7ehubmg==
X-Received: by 2002:a17:902:f790:b0:223:325c:89f6 with SMTP id d9443c01a7336-231d43d9ba7mr6838645ad.10.1747332941737;
        Thu, 15 May 2025 11:15:41 -0700 (PDT)
Received: from dw-tp ([171.76.80.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ebbab6sm771285ad.205.2025.05.15.11.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:15:41 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] ext4: Add atomic block write documentation
In-Reply-To: <20250515165836.GQ25655@frogsfrogsfrogs>
Date: Thu, 15 May 2025 23:44:33 +0530
Message-ID: <87r00pwxkm.fsf@gmail.com>
References: <cover.1747289779.git.ritesh.list@gmail.com> <7afb50dbd7e6b81aa43bf5289a6248a66f0c592e.1747289779.git.ritesh.list@gmail.com> <20250515165836.GQ25655@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Thu, May 15, 2025 at 08:15:39PM +0530, Ritesh Harjani (IBM) wrote:
>> Add an initial documentation around atomic writes support in ext4.
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  .../filesystems/ext4/atomic_writes.rst        | 220 ++++++++++++++++++
>>  Documentation/filesystems/ext4/overview.rst   |   1 +
>>  2 files changed, 221 insertions(+)
>>  create mode 100644 Documentation/filesystems/ext4/atomic_writes.rst
>> 
>> diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
>> new file mode 100644
>> index 000000000000..de54eeb6aaae
>> --- /dev/null
>> +++ b/Documentation/filesystems/ext4/atomic_writes.rst
>> @@ -0,0 +1,220 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. _atomic_writes:
>> +
>> +Atomic Block Writes
>> +-------------------------
>> +
>> +Introduction
>> +~~~~~~~~~~~~
>> +
>> +Atomic (untorn) block writes ensure that either the entire write is committed
>> +to disk or none of it is. This prevents "torn writes" during power loss or
>> +system crashes. The ext4 filesystem supports atomic writes (only with Direct
>> +I/O) on regular files with extents, provided the underlying storage device
>> +supports hardware atomic writes. This is supported in the following two ways:
>> +
>> +1. **Single-fsblock Atomic Writes**:
>> +   EXT4's supports atomic write operations with a single filesystem block since
>> +   v6.13. In this the atomic write unit minimum and maximum sizes are both set
>> +   to filesystem blocksize.
>> +   e.g. doing atomic write of 16KB with 16KB filesystem blocksize on 64KB
>> +   pagesize system is possible.
>> +
>> +2. **Multi-fsblock Atomic Writes with Bigalloc**:
>> +   EXT4 now also supports atomic writes spanning multiple filesystem blocks
>> +   using a feature known as bigalloc. The atomic write unit's minimum and
>> +   maximum sizes are determined by the filesystem block size and cluster size,
>> +   based on the underlying device’s supported atomic write unit limits.
>> +
>> +Requirements
>> +~~~~~~~~~~~~
>> +
>> +Basic requirements for atomic writes in ext4:
>> +
>> + 1. The extents feature must be enabled (default for ext4)
>> + 2. The underlying block device must support atomic writes
>> + 3. For single-fsblock atomic writes:
>> +
>> +    1. A filesystem with appropriate block size (up to the page size)
>> + 4. For multi-fsblock atomic writes:
>> +
>> +    1. The bigalloc feature must be enabled
>> +    2. The cluster size must be appropriately configured
>> +
>> +NOTE: EXT4 does not support software or COW based atomic write, which means
>> +atomic writes on ext4 are only supported if underlying storage device supports
>> +it.
>> +
>> +Multi-fsblock Implementation Details
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The bigalloc feature changes ext4 to allocate in units of multiple filesystem
>> +blocks, also known as clusters. With bigalloc each bit within block bitmap
>> +represents cluster (power of 2 number of blocks) rather than individual
>
> Nit: "...represents one cluster"

yup, will make that change.

>
> With that fixed,
> Acked-by: "Darrick J. Wong" <djwong@kernel.org>
>

Thanks!
-ritesh


> --D
>

