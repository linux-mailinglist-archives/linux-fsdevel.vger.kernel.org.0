Return-Path: <linux-fsdevel+bounces-32890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233539B05F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 16:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B7D1C20D88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A00206501;
	Fri, 25 Oct 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lur8MBR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FFB21219A;
	Fri, 25 Oct 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867106; cv=none; b=BvCnf0oqvPG9ZdEGFn5quc6SGHGjQ5un9Avh+RSEZOhw1jYNZ1enrTTJZ+q2z/dgfvUNVF7nfcc4JpK0HxXHFXZdWhR23iQIHNaXFSo8AbzVQlLeLydDQDGvZczlY1jIWWOTAn1LwqKk20BdhwB9mBSto2c+v4prd/VaZlRJ5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867106; c=relaxed/simple;
	bh=jOEqqD6eKub5OsQMn1xgga0X/jrQgRJtdPD5dGCwuZU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=pUe6112lNKez7nliU/rByCrcSTjmeZd2U/iSfUiVy0MrTnyLPl7ObO1mUOF559GrvD5Vn2b90YhHSrBKhU/WidZFp0eESpyxQySMsQheEBdQ8NVnccYPGpP9iRMeGAiQgKbSVjHevkDDjNU16+FERQL3zvhPmKipe/1kK4GearI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lur8MBR6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdda5cfb6so18960705ad.3;
        Fri, 25 Oct 2024 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729867103; x=1730471903; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V94RD6jfT9MDE0QIyHUh0lfRze2S4BWxc5Wb309byfA=;
        b=Lur8MBR67bC5ssjAXNJQVRMEtPcxTzBc76hojiCOVm3IxWKEtPB3CD8Byxgq4HuLRI
         cDKuym69VVci61rQzMax9lHptOd6Y+sbHuo/TiC8haT3N9leqJsCcZvxGn5V/hKt85IH
         kPt9ClqO04bDjN7v3ok5zvckvegR4phxupRJCavLjywBOJ2sEKjwSo/aGNhMrXBRby8t
         SeD53d65YWhZnlwwR98MF45itvUPUHN0Q6IFhUWKe9bZOnQMwQRWQ6zVDqsdNz5Mk8rt
         aDUL7TW9CM4d7AszsF00ZIlkp6E+Rs0fStv7ZdHPHnHa7HvDMnAcGdeuZ7FIzxiXN03c
         lvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867103; x=1730471903;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V94RD6jfT9MDE0QIyHUh0lfRze2S4BWxc5Wb309byfA=;
        b=npn6nlk5qnHx23yD9ZgD7GPfXMC99E8cURE16jPHR0OGdiOvNq9sx0Brpr7VXz6T2g
         k7L5wJ5dPA7yOzWnOSbkhxvcNfxf0bcd1iKQLi4lLdMEPjjQLTPOL6HHog2uaij0v/6z
         BTtz5JhnUfc348Dmj/sxxPhNUB+haT1RZktQNQRkWo8I5At+au/6cGQL3idebk5HHGx5
         ddjoEq1S/mCinsfKwkg9EM6qMIirXcwSv3I1ZLmGVsTGkxz58dcd1zxp6UBFaRQ/kt0Z
         MHifRTgEJzOzXlOSbdfXFV8wk2f0HDpRV1XRTIxUZW2kpcnxOTddMR6lnFS1g4121XEz
         eIkw==
X-Forwarded-Encrypted: i=1; AJvYcCUWvBjuLd8Puo5L1+W4VDlv4D4BHXpxaL6lpi/NoIZc7wbGwJIFNSD+8piWYvO7o5fLss7KSrq63fpv@vger.kernel.org, AJvYcCVWGu3hJiCHjXdTUAbT2qi/ZqooO/+kUxZ68Iq/ETWl8/3sd4EZQXSiRhGXGoatX4RxAap4iKxWNPIP7vDePQ==@vger.kernel.org, AJvYcCWGvdAVJMBYo4J/OywJcFYBiQN+nx5l2CrMzY4JX6tCpaI8BQBE+iw1AWDkDquhHQ5IuTw+Iy+biyVo3iUy@vger.kernel.org, AJvYcCXX32f97r5g8cNDRDIRSi7YDsmxzQ5zexBObixtOzO/9MhFSihVXO4jRidLGVVRSgpIvtdlCOZC7Nvc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7hxXgbpV9tPniJmAKdHxB5EBi9eaCyC23bwhv1Nd5Dw9JbQLa
	TqYjnfBOA/VIQTRNH+BZznULLWx4M4vMoE0wxRwciP3+khH7S2NhVOImlA==
X-Google-Smtp-Source: AGHT+IHv8Tc2MEIhCPRV97Jl1Ckmb69pyWd6ThNw+/dGHKosCC0AoAuTSFm0zs0rvv9kcdK13Ry55g==
X-Received: by 2002:a17:902:cec6:b0:20c:b483:cce2 with SMTP id d9443c01a7336-20fab2e0fe7mr92648825ad.60.1729867103451;
        Fri, 25 Oct 2024 07:38:23 -0700 (PDT)
Received: from dw-tp ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc082f15sm10079635ad.292.2024.10.25.07.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:38:22 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
In-Reply-To: <509180f3-4cc1-4cc2-9d43-5a1e728fb718@oracle.com>
Date: Fri, 25 Oct 2024 19:43:17 +0530
Message-ID: <87plnomfsy.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <f5bd55d32031b49bdd9e2c6d073787d1ac4b6d78.1729825985.git.ritesh.list@gmail.com> <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com> <87zfmsmsvc.fsf@gmail.com> <fc6fddee-2707-4cca-b0b7-983c8dd17e16@oracle.com> <87v7xgmpwo.fsf@gmail.com> <7e322989-c6e0-424a-94bd-3ad6ce5ffee9@oracle.com> <87ttd0mnuo.fsf@gmail.com> <7aea00d4-3914-414d-a18f-586a303868c1@oracle.com> <87r084mkat.fsf@gmail.com> <509180f3-4cc1-4cc2-9d43-5a1e728fb718@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 25/10/2024 13:36, Ritesh Harjani (IBM) wrote:
>>>> So user will anyway will have to be made aware of not to
>>>> attempt writes of fashion which can cause them such penalties.
>>>>
>>>> As patch-6 mentions this is a base support for bs = ps systems for
>>>> enabling atomic writes using bigalloc. For now we return -EINVAL when we
>>>> can't allocate a continuous user requested mapping which means it won't
>>>> support operations of types 8k followed by 16k.
>>>>
>>> That's my least-preferred option.
>>>
>>> I think better would be reject atomic writes that cover unwritten
>>> extents always - but that boat is about to sail...
>> That's what this patch does.
>
> Not really.
>
> Currently we have 2x iomap restrictions:
> a. mapping length must equal fs block size
> b. bio created must equal total write size
>
> This patch just says that the mapping length must equal total write size 
> (instead of a.). So quite similar to b.
>
>> For whatever reason if we couldn't allocate
>> a single contiguous region of requested size for atomic write, then we
>> reject the request always, isn't it. Or maybe I didn't understand your comment.
>
> As the simplest example, for an atomic write to an empty file, there 
> should only be a single mapping returned to iomap_dio_bio_iter() and 
> that would be of IOMAP_UNWRITTEN type. And we don't reject that.
>

Ok. Maybe this is what I am missing. Could you please help me understand
why should such writes be rejected? 

For e.g. 
If FS could allocate a single contiguous IOMAP_UNWRITTEN extent of
atomic write request size, that means - 
1. FS will allocate an unwritten extent.
2. will do writes (using submit_bio) to the unwritten extent. 
3. will do unwritten to written conversion. 

It is ok if either of the above operations fail right? If (3) fails
then the region will still be marked unwritten that means it will read
zero (old contents). (2) can anyway fail and will not result into
partial writes. (1) will anyway not result into any write whatsoever.

So we can never have a situation where there is partial writes leading
to mix of old and new write contents right for such cases? Which is what the
requirement of atomic/untorn write also is?

Sorry am I missing something here?

>> 
>> If others prefer - we can maybe add such a check (e.g. ext4_dio_atomic_write_checks())
>> for atomic writes in ext4_dio_write_checks(), similar to how we detect
>> overwrites case to decide whether we need a read v/s write semaphore.
>> So this can check if the user has a partially allocated extent for the
>> user requested region and if yes, we can return -EINVAL from
>> ext4_dio_write_iter() itself.
>  > > I think this maybe better option than waiting until ->iomap_begin().
>> This might also bring all atomic write constraints to be checked in one
>> place i.e. during ext4_file_write_iter() itself.
>
> Something like this can be done once we decide how atomic writing to 
> regions which cover mixed unwritten and written extents is to be handled.

Mixed extent regions (written + unwritten) is a different case all
together (which can lead to mix of old and new contents).


But here what I am suggesting is to add following constraint in case of
ext4 with bigalloc - 

"Writes to a region which already has partially allocated extent is not supported."

That means we will return -EINVAL if we detect above case in
ext4_file_write_iter() and sure we can document this behavior.

In retrospect, I am not sure why we cannot add a constraint for atomic
writes (e.g. for ext4 bigalloc) and reject such writes outright,
instead of silently incurring a performance penalty by zeroing out the
partial regions by allowing such write request.

-ritesh

