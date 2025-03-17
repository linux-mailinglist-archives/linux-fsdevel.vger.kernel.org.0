Return-Path: <linux-fsdevel+bounces-44201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D20A653BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 15:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491F53A0209
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 14:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABED24337D;
	Mon, 17 Mar 2025 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk3hcw8q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34FDDA8;
	Mon, 17 Mar 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222205; cv=none; b=EO1xIYU1kNT138ZUNXIUzNGlXX9H/Z757YBtqYyjGkAmCCCJ25SWYnZs/fGgTPc/S8cERPlIbBHCalMdb+7OHyV9g2Etsv9GgI5SSx9lvRO4WAlGcgENoISbh7B+KzCU3tccNr2uGRdEyVUmvlPUXglhOZAXdcqZFchXz0np+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222205; c=relaxed/simple;
	bh=4TX+lSEn5TaZbpa1TO0GRQ1WwTSTQelGfR2LDjLBtKY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ZqJlcDpaghFqt/18av8DIu1CL22VgnoUEwiTeBAruRD1w7DlNJx+g0mgLq4FDLLj7sDWbi2M+MD8h1f2/PUzg5wc+tiYu9kPuZroL9+hcMxyPC5VOuFttthZTO7J8yL0h1B9GrxOppO+wQ0ST8xwd1cirw/c1HzR7h3xbW3gHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk3hcw8q; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2239c066347so90154155ad.2;
        Mon, 17 Mar 2025 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742222202; x=1742827002; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QihfPZn7yT8b0vOjQdUT1guP8CAMaA7FtKVCMbpLNL4=;
        b=jk3hcw8qZu23sWpaKbe6kIy8RJIRDxC3kGCgr6xxrfcR8fLlVSp0RzfbGhZTyvsoMR
         mZ9HuGA3UdErxgh3YoxRI+SKZSnPF4L0kdoGWKg4ofmZdk/TDtQKFn4S0a5nKGYypRmG
         tuJX1HzFf2wB6A9RZZ1kGtXaWBM+QLOxZksTOJDuIKmw0R2o7IbFlteCzS8HywjzrwtE
         mGbcksXMd9KlqsJL3FiW3xO/cAO0a9meg6LXEow+ycHVrpK48sCZmQMVdrfsk1J2Hg0z
         rHjJfbhylciPaVuyV6H6EM6oY+zU98JKQqSxsJimTtmackpxjAqsVtDYGbDmrM2WjVKB
         Q5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742222202; x=1742827002;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QihfPZn7yT8b0vOjQdUT1guP8CAMaA7FtKVCMbpLNL4=;
        b=piov/8PAZekscmObymllxUXehxUU7DFGzPaCZXK1WdNWDRgEAHNoM0naRYESvsLbWZ
         YqCzv89fCRSuBR6BnQdxQAeyryRScVEQ5cHjXbUYGh3toDp/2cl0Nhy2aZcCE2dJJcaJ
         /CguGD5Ht1vIk0SO9FnQWLATLIOgNoIS9/U6XMp1NLVmSQHHNId7ltXSXNWtabfmoIgl
         ggT3Dy5ON4nv/AqdUjIbfJOGJOSiST/7VxEikvFZ5Q+zzAK6E3AnKr0l8mPNhVUoVu+u
         DYu5LvD/1CJ1CX4wkXMbCBNp3NNi8DGNwVDo3hx50NVQfd9siXgkMAbepxUSTUnipUjj
         kcxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOmNyobRvc2gpROGlraekTPUyLxZNyhqsruCq+emPJgrT8gUAQn3T4whurJ3niNEwcW/QgYfQRphWIHngiyg==@vger.kernel.org, AJvYcCVKnmIA3KEi9UgLKts+G7WZ8kfbLQN7Strvx5ZL6SxekEZL1se8NRYdxsiUSTqNH/K1L8nCW416p2EOTQXh@vger.kernel.org, AJvYcCVOGxXnbGF1/oh9jzFdhoOTz5zwWX/Rjhcn/gl46WGehirgASHKdj4jNJSTmxa//eZjlbB8zTIUqOIr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf0rmz8NcJuYjGBqExy1JNKu1rXic0CmTHFUGGXOPskl6oC0fM
	1vPWRMkB+o0E3lW5bG97cH2I1yy1V/dFsIX4CGstYHqRmTMeo5audDPqNw==
X-Gm-Gg: ASbGncu/NiQOIQC0TLHOiNLbmJL2PWHMl1f5jD3LCW3xSwxgIDxsJQ0FfX7BKASjPXd
	R/SANmFlVNhLtpJshC4Bw80eH0EkrkGgZn76rB9NpSaTX6xLEvcGRmTOTeMq6pKPcIjbLMMzzrV
	LoIt8vmVhKfIoSLGxvQZRsFwpmr/6KosqvWssYoVE/1JkUri9h/i9ObGerpON7k+Q1T/k4zlBgi
	MzpW6BCTYlruOMpk+FOZf8LTKRoRI6LU7JMrYxVwWomXYHA5b5TO+ywrwus6ULS6GUJSTMCEKoO
	fX0QyQDFsCw/AvlTxSe/+9VilIYqrBtbEQ14qA==
X-Google-Smtp-Source: AGHT+IHAW0CArsr0VInptn5poqQysT00HxenEXl0IjBQeEKz2+8A2xpon7Tdhho4AIV2v7ipEg5Dhg==
X-Received: by 2002:a05:6a21:394c:b0:1f5:7d57:8309 with SMTP id adf61e73a8af0-1f5c119438dmr17154898637.21.1742222202053;
        Mon, 17 Mar 2025 07:36:42 -0700 (PDT)
Received: from dw-tp ([171.76.81.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9fe51asm7219707a12.36.2025.03.17.07.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:36:41 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
In-Reply-To: <cd05e767-0d30-483a-967f-a92673cdcba8@oracle.com>
Date: Mon, 17 Mar 2025 19:50:29 +0530
Message-ID: <87r02vspqq.fsf@gmail.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-11-john.g.garry@oracle.com> <8734fd79g1.fsf@gmail.com> <cd05e767-0d30-483a-967f-a92673cdcba8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

>>> +		}
>>>   		end_fsb = imap.br_startoff + imap.br_blockcount;
>>>   		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
>>>   	}
>>>   
>>> -	if (imap_needs_alloc(inode, flags, &imap, nimaps))
>>> +	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
>>> +
>>> +	if (flags & IOMAP_ATOMIC) {
>>> +		error = -EAGAIN;
>>> +		/*
>>> +		 * If we allocate less than what is required for the write
>>> +		 * then we may end up with multiple mappings, which means that
>>> +		 * REQ_ATOMIC-based cannot be used, so avoid this possibility.
>>> +		 */
>>> +		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
>>> +			goto out_unlock;
>> 
>> I have a quick question here. Based on above check it looks like
>> allocation requests on a hole or the 1st time allocation (append writes)
>> for a given logical range will always be done using CoW fallback
>> mechanism, isn't it? 
>
> Right, but...
>
>
>> So that means HW based multi-fsblock atomic write
>> request will only happen for over writes (non-discontigous extent),
>> correct?
>
> For an unwritten pre-allocated extent, we can use the REQ_ATOMIC method.
>
> fallocate (without ZERO RANGE) would give a pre-allocated unwritten 
> extent, and a write there would not technically be an overwrite.
>
>> 
>> Now, it's not always necessary that if we try to allocate an extent for
>> the given range, it results into discontiguous extents. e.g. say, if the
>> entire range being written to is a hole or append writes, then it might
>> just allocate a single unwritten extent which is valid for doing an
>> atomic write using HW/BIOs right?
>
> Right
>
>> And it is valid to write using unwritten extent as long as we don't have
>> mixed mappings i.e. the entire range should either be unwritten or
>> written for the atomic write to be untorned, correct?
>> 
>
> We can't write to discontiguous extents, and a mixed mapping would mean 
> discontiguous extents.
>
> And, as mentioned earlier, it is ok to use REQ_ATOMIC method on an 
> unwritten extent.
>
>> I am guessing this is kept intentional?
>> 
> Yes

Thanks, John for addressing the queries. It would be helpful to include
this information in the commit message as well then right? Otherwise
IMO, the original commit message looks incomplete.

Maybe we can add this too?
=========================
This patch adds CoW based atomic write support which will be used as a
SW fallback in following scenarios:

- All append write scenarios.
- Any new writes on the region containing holes.
- Writes to any misaligned regions
- Writes to discontiguous extents.


<original commit msg snip>
=========================
In cases of an atomic write covering misaligned or discontiguous disk
blocks, we will use a CoW-based method to issue the atomic write.

-ritesh

