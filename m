Return-Path: <linux-fsdevel+bounces-45911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EFFA7EC3F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 21:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17839188DB91
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 19:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE832641ED;
	Mon,  7 Apr 2025 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixQBzJ8r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E30A2236EF;
	Mon,  7 Apr 2025 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051309; cv=none; b=L77VBKHu0VFakG4mghJ6hd5Ua6wqLJrF3cNFDdDGITwb8A00S8eZ0sjgCTOgoxp62hf87z42LO5wUmRWPUZp6nORr/n82P/E6Hs2XELpM03OvzVR7F7I+5BzlqXby5S4738MK/UOY4at1JJ/suUBuGPen5LUa87vMhCp7FAr+jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051309; c=relaxed/simple;
	bh=WsJxHs7ssFBLw+K2ayKsr/xwB0JkZ16lTqa8TgJxi8M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=B1bUPoaj5jqY9g5M1R8U90f2xqdv8eDUXQp5ihQaQ0r/n2jmNc1hNVaAcZCuWcFyV0xSgD+IWUiYHhZfZvt6URrXUj6+BnV1oKs8p6NCr65bqDBZxcNVtNotAR6EmxspoXP8+7UHzxckWu+JZtO+Pf5/X61czGJ+RpujquP7V6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixQBzJ8r; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223fd89d036so55388025ad.1;
        Mon, 07 Apr 2025 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744051306; x=1744656106; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CIpAmSbBdQep2UPEbRPweZhmkepvDXxjx+XL+AXt7sI=;
        b=ixQBzJ8rGRLDNIjjstXyDYigbXc8ieB85Or+NgMzeY+09vbs4srpo4gmQtm11OZ8iv
         tcSvbYfi4msrDkDoe7i7kjsuAAxIwcg3J6BO7xk0kDCRBM8buyf3F85XTQGlo0kVvB/i
         DK52y0Q/V+3KM3MPJ4H8Lxnc06wEPbMKHT/6/O3saAG6ND2u7tUhioH2LoVgbJo0LmVx
         Ws7jr3WqLCHtVHcdZ89glKo6eHN+UC09WYgOj0pS61lIg2jre4mcVgzeQKgbhHWiYzi9
         M/7oJ1q+7vPlw3H6gSYvZ0xf6+Y8mDIz/zmx4RdGAApTrjgQJ9psKCTnqFMGk5Gl3dxt
         ntxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744051306; x=1744656106;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIpAmSbBdQep2UPEbRPweZhmkepvDXxjx+XL+AXt7sI=;
        b=s/3eE5Cl89m7oqcsT9eKxtMpam7T3jEa5b/HEK3MORb8wN+eoXSLx4RaB2pwJMVNVl
         dVT7FmmfRmbbq+1TMe4rXPhQa+DDdtHdunkkgyvAP8hmvjRD11TVKkA08+orww2woH6T
         OsbiAbHltsn0gHiwdPl4EiI5/+/P/1TBc/mNWNsN04oR//+78D5FI2ZrYK62Mmy5AHtp
         uS/wlDDnZs2D3MLtp6EO8QphS179L1fs8P4GlcoDVoq+J8IGk6ojleKi9nlh61WGVuIR
         fHnFV+sH+TiyV645FKDG9XodRFySyG6PzDCCxK8+MVoOUEsVDqPqy3FJwTml2uvAFIUx
         vrMw==
X-Forwarded-Encrypted: i=1; AJvYcCU6yGNLw2fVn0so3W5TS38g5jewPj0xKXXEgqzclnngHNWJ3fPGN0oK54l2cjzKQPjjkFxqka2dXiTWKFe/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw33fl0D4+yrNMNIuEOEH1+JaEts4yuETxhwHvoWTS4/au4m6T0
	UjvRfaqaZWyRkYTjUu45YETgNnuZqNBKStQ7w4v3Y2NtATBdV9TEzxsEbQ==
X-Gm-Gg: ASbGncsf/PkvYTuAEtl55TM0fwRIRwcJDTsScephSoO5kOzH79WJZU0X7wioXSA27Pp
	OQOiKBTFWcEGPeDhaoHSRAv7oyi4o1QPdEX5RUrp7QO1hhz0OO0h+tSAXCJddYGCdmuFoZX7341
	Oyi/0DtA2WdghSPMqIEqIuBulKZafI1TGLR2jlZnA1f6yjvXvLDhaNy2HW9uTB0cVrD6iSgNAFQ
	yDHHyAyQ2HWcFesSGqkd32haqhzo0bxHypSJATYFcNfFzVGKIjPIOsb4Thnr++Ki7Gc037CWO4J
	bifw3IJ/6PdaUkkYDMi7+5bM8WZqDFnVQuw=
X-Google-Smtp-Source: AGHT+IGa7/w+zv1hKMZv9koIXd49+8ZWBJNdIAoATsZ0zFn6zGIWgu8nAMSpdWde0TOXMDCKKOBFpQ==
X-Received: by 2002:a17:902:ea0d:b0:223:628c:199 with SMTP id d9443c01a7336-22a8a0b4154mr155141975ad.52.1744051305700;
        Mon, 07 Apr 2025 11:41:45 -0700 (PDT)
Received: from dw-tp ([171.76.81.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c3819sm84508635ad.87.2025.04.07.11.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:41:45 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, John Garry <john.g.garry@oracle.com>, ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: iomap: Add missing flags description
In-Reply-To: <20250407162527.GC6266@frogsfrogsfrogs>
Date: Tue, 08 Apr 2025 00:00:40 +0530
Message-ID: <878qobzuwf.fsf@gmail.com>
References: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com> <20250407162527.GC6266@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Thu, Apr 03, 2025 at 11:52:27PM +0530, Ritesh Harjani (IBM) wrote:
>> Let's document the use of these flags in iomap design doc where other
>> flags are defined too -
>> 
>> - IOMAP_F_BOUNDARY was added by XFS to prevent merging of ioends
>>   across RTG boundaries.
>> - IOMAP_F_ATOMIC_BIO was added for supporting atomic I/O operations
>>   for filesystems to inform the iomap that it needs HW-offload based
>>   mechanism for torn-write protection
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  Documentation/filesystems/iomap/design.rst | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
>> index e29651a42eec..b916e85bc930 100644
>> --- a/Documentation/filesystems/iomap/design.rst
>> +++ b/Documentation/filesystems/iomap/design.rst
>> @@ -243,6 +243,11 @@ The fields are as follows:
>>       regular file data.
>>       This is only useful for FIEMAP.
>>  
>> +   * **IOMAP_F_BOUNDARY**: This indicates that I/O and I/O completions
>> +     for this iomap must never be merged with the mapping before it.
>> +     Currently XFS uses this to prevent merging of ioends across RTG
>> +     (realtime group) boundaries.
>
> Hrm, ok.  Based on hch's comment about not mentioning specific fs
> behavior, I think I'll suggest something more like:
>
> IOMAP_F_BOUNDARY: This I/O and its completion must not be merged with
> any other I/O or completion.  Filesystems must use this when submitting
> I/O to devices that cannot handle I/O crossing certain LBAs (e.g. ZNS
> devices).  This flag applies only to buffered I/O writeback; all other
> functions ignore it.
>

Sure.

>>     * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
>>       be set by the filesystem for its own purposes.
>>  
>> @@ -250,6 +255,11 @@ The fields are as follows:
>>       block assigned to it yet and the file system will do that in the bio
>>       submission handler, splitting the I/O as needed.
>>  
>> +   * **IOMAP_F_ATOMIC_BIO**: Indicates that write I/O must be submitted
>> +     with the ``REQ_ATOMIC`` flag set in the bio. Filesystems need to set
>> +     this flag to inform iomap that the write I/O operation requires
>> +     torn-write protection based on HW-offload mechanism.
>
> They must also ensure that mapping updates upon the completion of the
> I/O must be performed in a single metadata update.
>

Thanks Darrick, for the clarification and the review comments on this
patch. Once the remaining tracing patch is reviewed, I will incorporate
these comments in v2.

-ritesh

