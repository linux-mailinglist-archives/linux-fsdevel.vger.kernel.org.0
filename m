Return-Path: <linux-fsdevel+bounces-32885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACEA9B0348
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 14:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F3D1F21D9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 12:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B065206519;
	Fri, 25 Oct 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ7wJu7D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163572064FE;
	Fri, 25 Oct 2024 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861178; cv=none; b=Lj7pP4CFnJ6IFXf/MvnTrImmomlFh/ZJT1t//QgkgvSB+PzMMlKmRXQXrw9L9i38H0/1mltECK2xqAcl9M8RL0DU8TUEkQ/9w2gelbMkAppx6m8FNbSPl09ruf6iTsrEQQj9EA4ZNxh4IRiB3rozssC0aaEmyf2HQBxuNuRnohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861178; c=relaxed/simple;
	bh=l0sytxywCiAfXKGcO9SLlzfTkZ0ecVvtu6hWrTMitsE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=nXrBeLDbR3iEcgLlpny0OGM4c30hXJn0oM59+4v55Xv/kUF4g0yBx+6tPneXujO9h+6WDjS91zWJf0t7LwdJmGHROaldeDR1Al/fmRAYVrMKhXM73tRc1ryCMyLEikSRYiwlSdHxvO1GRF1kfbmpwE59Nuao9fT4VLTHjzjLhCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJ7wJu7D; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c805a0753so19210885ad.0;
        Fri, 25 Oct 2024 05:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729861174; x=1730465974; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sS0sCHvb+I6L+9QyAsfqaRm1T+v1p6mphFE4KTK0Jys=;
        b=SJ7wJu7DEURCcL9lbNxju8nKwQlBy+M+6ia/sN5S38Uf6jQ22No/p3r8ycyl5T7+SG
         txHxLyKLC3jFZsnDe5qpllyK4CooDnsZ3di35M1z4nJBcCt8YA10o6eASuzxKrXC5joU
         BgOTRWC7UUt2qlnO5Pf2+1PX2N/iU6RdM3zhZU9yRCnZd1Pa86dI6WdQyYY26JrWqaAU
         Suz777A1B+BgP2aZv2Q7SIkeDxTIxVfXAwaH8U2bFCjOqkT2zhAeBsi+mn5gSK4w9PSy
         Gdf+MA7ocs9VG4TBbCUkJvxLfkGVXqQAJqQlGloWXidIyZGzq6JTmpthR8vd5kq1kFoQ
         66yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729861174; x=1730465974;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sS0sCHvb+I6L+9QyAsfqaRm1T+v1p6mphFE4KTK0Jys=;
        b=SvC+EwsDO38GYMSC48yssFB/etqNjs/17Hv1B04u6DdbpXP565Kq1gPPtB3k0ZF+9x
         qbF1mVfo7zEADXxJ8kKeXCQ8MWp3VAz6BvdtVlohylC373PTSn9AK3MhA75wwXM3ScaS
         BWK82LUJLbqydlOC4zWACZveA211nFlPQENx7+nP02DToJ3KX6INgd1/LGTSLrZK2P6h
         RwVOJ1M4aj6Cv1zMQwzL/BzRDoGzS/aOeVMRUS1b0J5+eM9ShU9HKAHw+Z0OjT1D+tg8
         YYQ0hifpPOvWtGxE+HuDDffdc/THgw/p24Az9yAYxl3O4j/rgAHppVeZ2D4ZXTlwnQUM
         Y3bw==
X-Forwarded-Encrypted: i=1; AJvYcCU8z1GECdJKhKCVou2qw+++B5Opd3bozpDRXNyr+lXe8s2QBfMlfbK3trGOCRAyNvJMe0yD7LN0qhF/w0cy@vger.kernel.org, AJvYcCVIfOjTThuSU9gko4tY0O3YM2djJoXGh9MWkuVwiL99uv59saCNhOx+mOPMSiw1ZK9QdLQaJM7aQfJrfVcEKg==@vger.kernel.org, AJvYcCVr0hDdC7BCO/C5Ws4ftUlKXaFBYpY/yFP2xrCwQNTMElPUVHVqWrmPOJnsUMRprzEzS52i7LJq1mw0@vger.kernel.org, AJvYcCW3f9buCXZnPoIWaCzZC3GruoVItyzOsWF7bR4HU2DizJQ+mZwm+s8fB7TA+Sc3Hn7Yew/Z+jXQdano@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu3LiFW/EdxmLiR+D99Y4yhvoM4GZ6xIEAw+Xfyz/RJ5IzvcOd
	TTaOEls6URDjDVzn9nnj5AnPjzXtB+15J35YH8SBJT0ddPVJvSkgkMjzxw==
X-Google-Smtp-Source: AGHT+IG+TukVZ5cKFAVsZkN3PXK9I6J6zGYg6kmbkictFDjWrWJwFkWpgfljYTCv/kpR03zG9YKbeg==
X-Received: by 2002:a17:903:2292:b0:20c:7be3:2816 with SMTP id d9443c01a7336-20fb9aa20d1mr76427815ad.40.1729861174280;
        Fri, 25 Oct 2024 05:59:34 -0700 (PDT)
Received: from dw-tp ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6df97sm8983925ad.100.2024.10.25.05.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 05:59:33 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
In-Reply-To: <7aea00d4-3914-414d-a18f-586a303868c1@oracle.com>
Date: Fri, 25 Oct 2024 18:06:10 +0530
Message-ID: <87r084mkat.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <f5bd55d32031b49bdd9e2c6d073787d1ac4b6d78.1729825985.git.ritesh.list@gmail.com> <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com> <87zfmsmsvc.fsf@gmail.com> <fc6fddee-2707-4cca-b0b7-983c8dd17e16@oracle.com> <87v7xgmpwo.fsf@gmail.com> <7e322989-c6e0-424a-94bd-3ad6ce5ffee9@oracle.com> <87ttd0mnuo.fsf@gmail.com> <7aea00d4-3914-414d-a18f-586a303868c1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 25/10/2024 12:19, Ritesh Harjani (IBM) wrote:
>> John Garry <john.g.garry@oracle.com> writes:
>> 
>>> On 25/10/2024 11:35, Ritesh Harjani (IBM) wrote:
>>>>>> Same as mentioned above. We can't have atomic writes to get split.
>>>>>> This patch is just lifting the restriction of iomap to allow more than
>>>>>> blocksize but the mapped length should still meet iter->len, as
>>>>>> otherwise the writes can get split.
>>>>> Sure, I get this. But I wonder why would we be getting multiple
>>>>> mappings? Why cannot the FS always provide a single mapping?
>>>> FS can decide to split the mappings when it couldn't allocate a single
>>>> large mapping of the requested length. Could be due to -
>>>> - already allocated extent followed by EOF,
>>>> - already allocated extent followed by a hole
>>>> - already mapped extent followed by an extent of different type (e.g. written followed by unwritten or unwritten followed by written)
>>>
>>> This is the sort of scenario which I am concerned with. This issue has
>>> been discussed at length for XFS forcealign support for atomic writes.
>> 
>> extsize and forcealign is being worked for ext4 as well where we can
>> add such support, sure.
>> 
>>>
>>> So far, the user can atomic write a single FS block regardless of
>>> whether the extent in which it would be part of is in written or
>>> unwritten state.
>>>
>>> Now the rule will be to write multiple FS blocks atomically, all blocks
>>> need to be in same written or unwritten state.
>> 
>> FS needs to ensure that the writes does not get torned. So for whatever reason
>> FS splits the mapping then we need to return an -EINVAL error to not
>> allow such writes to get torned. This patch just does that.
>> 
>> But I get your point. More below.
>> 
>>>
>>> This oddity at least needs to be documented.
>> 
>> Got it. Yes, we can do that.
>> 
>>>
>>> Better yet would be to not have this restriction.
>>>
>> 
>> I haven't thought of a clever way where we don't have to zero out the
>> rest of the unwritten mapping. With ext4 bigalloc since the entire
>> cluster is anyway reserved - I was thinking if we can come up with a
>> clever way for doing atomic writes to the entire user requested size w/o
>> zeroing out.
>
> This following was main method which was being attempted:
>
> https://lore.kernel.org/linux-fsdevel/20240429174746.2132161-15-john.g.garry@oracle.com/
>
> There were other ideas in different versions of the forcelign/xfs block 
> atomic writes series.
>
>> 
>> Zeroing out the other unwritten extent is also a cost penalty to the
>> user anyways.
>
> Sure, unless we have a special inode flag to say "pre-zero the extent".
>
>> So user will anyway will have to be made aware of not to
>> attempt writes of fashion which can cause them such penalties.
>> 
>> As patch-6 mentions this is a base support for bs = ps systems for
>> enabling atomic writes using bigalloc. For now we return -EINVAL when we
>> can't allocate a continuous user requested mapping which means it won't
>> support operations of types 8k followed by 16k.
>> 
>
> That's my least-preferred option.
>
> I think better would be reject atomic writes that cover unwritten 
> extents always - but that boat is about to sail...

That's what this patch does. For whatever reason if we couldn't allocate
a single contiguous region of requested size for atomic write, then we
reject the request always, isn't it. Or maybe I didn't understand your comment.

If others prefer - we can maybe add such a check (e.g. ext4_dio_atomic_write_checks()) 
for atomic writes in ext4_dio_write_checks(), similar to how we detect
overwrites case to decide whether we need a read v/s write semaphore. 
So this can check if the user has a partially allocated extent for the
user requested region and if yes, we can return -EINVAL from
ext4_dio_write_iter() itself. 

I think this maybe better option than waiting until ->iomap_begin().
This might also bring all atomic write constraints to be checked in one
place i.e. during ext4_file_write_iter() itself.

Thoughts?

-ritesh

