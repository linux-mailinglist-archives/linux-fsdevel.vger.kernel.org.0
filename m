Return-Path: <linux-fsdevel+bounces-45752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B664A7BB5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1C6178EC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 11:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E791D95B4;
	Fri,  4 Apr 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG6f7mXt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18141A315C;
	Fri,  4 Apr 2025 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743765166; cv=none; b=Soyla0uOmvQGF/HYy9mU1gNwWdG7hJX+VerZY2b6U28QWb/qwA3kS4Lm2uJEPQep2TIzxDBsBkEzSrhg0oTguSujIKtsPv5i9orB94wFX51r2fn9vlouDBQRNJfdrCWCHVauhmh5J6PHZv2SgN7BojD07ZUx/EQHumM7VvsTECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743765166; c=relaxed/simple;
	bh=JdMvni59cKETAkfx+9g0kSjEtVX79NsMaYWZpjyaBrc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=GTQExQ5y6Ond46I5bOfHbqw1Y3H1n4VDW+wNC0kT+bTsQJK2em8ZXF1UzWy5TEFiM7Cn3S4ZoAHPLrIPrpImr/Gu7MmDT+fWDloLWzcasKLdYahrpbNmxs+ZpzynQ5hfziSItgZSdiPpGk0W1CaaXtEwXT3nZ6w49HBgU5yPKhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG6f7mXt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso2463522b3a.2;
        Fri, 04 Apr 2025 04:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743765163; x=1744369963; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cJ884e+6+ThAhT/tgtu6Fq7dwkXhsFnLWZFjjMBf/SY=;
        b=nG6f7mXttAjoRMLr12XVG892vFW80GMICALMCDT9fdh3Xtc9bbQzITH1DkevYqFL36
         oSUj8nWUrWViq0VpBD/o0k3WyhTyO0oXB1rjVFnKSEBQ0klOvDgML8X1sw+gllS9r3bR
         NrnEfYTDs5y8++5BScHEAw7cNx1AetZDj2+vYdZNIgFbVoQdlV+7f4CjklcJFIdk5uFW
         97Ie3/twWqaxjLAx2HzVlA3oaEbZQ7/5p5qYFM7bQWR3Q+7fbDspWjk319Lhkvd+knPp
         lv8FJvYiVhup9iJyuoF3n1dQ+ggSkeyoM/lX+axVknLwE1lSTgywWGwXqbXZLXWHKyXe
         7pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743765163; x=1744369963;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJ884e+6+ThAhT/tgtu6Fq7dwkXhsFnLWZFjjMBf/SY=;
        b=C05OSmX9mAGkTSAQg0qo6yR8eqYFnOrIN38Tro6OOzWaq7eC3vmFpeyLpTWWYLihzE
         AQF7yl3a5O1pmNXf6Yaxx7JQKKcyM/lWCOzewYmgz5ZBYN7i80g8WNCjN4AiiMLMetOM
         H9UnedX/LAUY2aGU5UqM7NDkM3i8AcN6TOfyJ2nI00QFu/v/lL3X/no/V0sT4NmkuXFw
         98eEo9Wg2lSVrtWGyy96Ys3rfDaPkCuvLqeOvjI78usahW2W+j6lHbTCLchDnbIgGRvt
         aLciH+Ssf+5mWqucZJLk1A3FtnKNFmCCqVzZX8ZUQ58mO/abtFe/ceLvG22PDKBqV9yc
         Xc8g==
X-Forwarded-Encrypted: i=1; AJvYcCWHYXMtzQi52vFTx5OXt3tCC2qR/aSpwPYDrbj8P70l7oUGUDCQ2KaCPVxqy30AKKGGw8/o5QC0tRxz@vger.kernel.org, AJvYcCWKzklffVepdZNy643Wxwz/Qm6LbFFFpoWGRIjT/hty+a7zTv/eUi6sLzoyQanc8wLAmnjBDuIia+qax7uj@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGq7nOPXF5e5SIuC9IMc+aDce9ye2/nfiiqZg61UR+ex1UXvU
	c8+LTMk0bmwZ2ZweBnuoZ8kGvB40SBo+AZDqCZL92KrK1XPwTwdClJKWM5Q0
X-Gm-Gg: ASbGnctHRc3DKSeYZricFaNzguQifHWJA4tvIpZ0or870QKc4bTuY8gdNSNOrZkYgab
	2yVA3J8XolOSnY4yklb2G5e3M8UYRHjPyVG8mEswOSz8tjcsv3GMoaNxcI2k3rvbjIJAlV7BI2/
	2CzMH8uGaZp+kjqcogBvqWg/AjOH8WcLkHfz1SeXtqGgONeiitLdYguVIm0DaVvYsmI6fRksgcY
	a7sUheHD+o6malJxFKC/8GNe0nX8qvaPd6cVeaIebSYIB8pb+YdlNJCAczDylGZMhMn3LP+vRes
	NUwvFHYFkS3smrQnhYrGG7Dla6ADSBhYNmTt
X-Google-Smtp-Source: AGHT+IGAy77BYb2sj28kul03uzYpgVhloteM6XMaZRCsF/CCUubw48jERhj8bT+n/DRoL9slGyKfCA==
X-Received: by 2002:a05:6a00:4b05:b0:736:4cde:5c0e with SMTP id d2e1a72fcca58-739e4922df6mr3211945b3a.10.1743765162934;
        Fri, 04 Apr 2025 04:12:42 -0700 (PDT)
Received: from dw-tp ([171.76.86.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee818sm3192000b3a.55.2025.04.04.04.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 04:12:42 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-xfs@vger.kernel.org
Cc: djwong@kernel.org, ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: iomap: Add missing flags description
In-Reply-To: <cfd156b3-e166-4f2c-9cb2-c3dfd29c7f5b@oracle.com>
Date: Fri, 04 Apr 2025 15:53:24 +0530
Message-ID: <87ldsguswz.fsf@gmail.com>
References: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com> <cfd156b3-e166-4f2c-9cb2-c3dfd29c7f5b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 03/04/2025 19:22, Ritesh Harjani (IBM) wrote:
>
> IMHO, This document seems to be updated a lot, to the point where I 
> think that it has too much detail.
>

Perhaps this [1] can change your mind? Just the second paragraph of this
article might be good reason to keep the design doc updated with latest
changes in the iomap code.

[1]: https://lwn.net/Articles/935934/

>> Let's document the use of these flags in iomap design doc where other
>> flags are defined too -
>> 
>> - IOMAP_F_BOUNDARY was added by XFS to prevent merging of ioends
>>    across RTG boundaries.
>> - IOMAP_F_ATOMIC_BIO was added for supporting atomic I/O operations
>>    for filesystems to inform the iomap that it needs HW-offload based
>>    mechanism for torn-write protection
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   Documentation/filesystems/iomap/design.rst | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>> 
>> diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
>> index e29651a42eec..b916e85bc930 100644
>> --- a/Documentation/filesystems/iomap/design.rst
>> +++ b/Documentation/filesystems/iomap/design.rst
>> @@ -243,6 +243,11 @@ The fields are as follows:
>>        regular file data.
>>        This is only useful for FIEMAP.
>>   
>> +   * **IOMAP_F_BOUNDARY**: This indicates that I/O and I/O completions
>> +     for this iomap must never be merged with the mapping before it.
>> +     Currently XFS uses this to prevent merging of ioends across RTG
>> +     (realtime group) boundaries.

>
> This is just effectively the same comment as in the code -

I am happy to add/update if you would like to add more details.

> what's the use in this?
>

To keep the iomap design doc updated with the latest changes.

>> +
>>      * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
>>        be set by the filesystem for its own purposes.
>
> Is this comment now out of date according to your change in 923936efeb74?
>

Yup. Thanks for catching that. I am thinking we can update this to:

   * **IOMAP_F_PRIVATE**: This flag is reserved for filesystem private use.
     Currently only gfs2 uses this for implementing buffer head metadata
     boundary. This is done by gfs2 to avoid fetching the next mapping as
     otherwise it could likely incur an additional I/O to fetch the
     indirect metadata block.

If this looks good to others too I will update this in the v2.

Though, I now wonder whether gfs2 can also just use the IOMAP_F_BOUNDARY
flag instead of using IOMAP_F_PRIVATE? 

>>   
>> @@ -250,6 +255,11 @@ The fields are as follows:
>>        block assigned to it yet and the file system will do that in the bio
>>        submission handler, splitting the I/O as needed.
>>   
>> +   * **IOMAP_F_ATOMIC_BIO**: Indicates that write I/O must be submitted
>> +     with the ``REQ_ATOMIC`` flag set in the bio.
>
> This is effectively the same comment as iomap.h
>
>> Filesystems need to set
>> +     this flag to inform iomap that the write I/O operation requires
>> +     torn-write protection based on HW-offload mechanism.
>
> Personally I think that this is obvious. If not, the reader should check 
> the xfs and ext4 example in the code.
>

It's just my opinion, but sometimes including examples of how such flags
are used in the code - within the design document, can help the reader
better understand their context and purpose. 

Thanks for the review!

-ritesh

