Return-Path: <linux-fsdevel+bounces-49933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F646AC5C14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 23:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400981BA2CF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC0A20FA85;
	Tue, 27 May 2025 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kN1afY4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB71D63F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380627; cv=none; b=Np4m7ooBMDqIfMNqVMuvnwayKVV8t+VT0jZ8mRavEGXGNRu9C8N6GWrb8nqYMMcuOqE+u9aNt+mZX2FAsgn4pIaZR+RHd+CEg27hxdm/PQGr1Swn9H85lc6b2QIuqa9T5C5RD9nUny64Dz2ZY1mSnAXRevKTWaqT6+Coeb52LZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380627; c=relaxed/simple;
	bh=VjkxiO3aChbkpfhZTqNPfUkqrpMiyG4sH8VOano4dko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6oqxt6F59HH3sm+g23oqXfvIZ9ypQpOn+VQ/IG+6Q27Ql7wvpJUcmh2MTSPxVTogebUv5uMyBoO0Vc8VpW7W5CtwFOMVArPTX/bK6CMLa6jcgOuxBLGtcPXAM43FK6TBqrEW///Zn/Pz3LirRKyCxbXT84Itu3vQNiJn4xhZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kN1afY4t; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86a464849faso278003839f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748380624; x=1748985424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yF+6FT9PNvPbo4sx/ufQ+V21d6An2oWzJEAGPygG0eM=;
        b=kN1afY4tJQISGcS5mMMuLB6HPt9z9KEP9NHz4rwrI/4k65LTqoAPk3/6jrfZDWS59p
         17rDzu6TejnsYnyiS3+wNkHfJ2T8O8L/Pl/QhQNb9fP5sfMiaimPfT9m4htlyKNj5XML
         eXBWJ6daV+/pDLPqyBA0wH/VF9m2gcynVjN/KBefJVfkWPsIxJCsq0gs8jMHkLqeQ9av
         6bHskmzCP9iZ7j3FTusv3m7TWLzYvo3M51xBJKYxkvx0BYBkXk2AcE75h1UG0G6W8d9r
         Y5jniAEZEIIK7gjhr9v77c6UIFDjgdo0GTG5BRrapdkiuyZ2CEBUOr7Ks/q08oemG7Fi
         A0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748380624; x=1748985424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yF+6FT9PNvPbo4sx/ufQ+V21d6An2oWzJEAGPygG0eM=;
        b=SvP1ZB4YxZ096IRjEocaDdeEy8BG9h8ysdMIVp0If8u9HnQd9gqevFLoVMDq3vdaYd
         pJ2W+U5gA62yoSXQNnJgyyTCaok6oCBmHItNzzMTeHg43Cy4Uhx6QLTFoYq5p1V2/uk0
         yS+gF2727pbFrQyteGxvtY3gSQWDqLbaVyn41Gco1vAiXqLp3WAx+ecRL9Y6RxdpgNDE
         qYVyGBV8ZwnLdheZJQXffwHjYMo7Tyvu8Sz683//TbxjLZFnWhU/WQllJYGFA3e0LExE
         A7nVsCeODu2go8rmEsSx4q1ScTbSHVyYwnRJo0lKEZIbR13ntEjecIN99zrN2Mkpv5ni
         uRkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCkDZMP6O+kzHQZYkDNeixb+wCXCxz49ScmyM7vbY/+EBlugyYEH/sC7XPZ5JPuh4MNFIYyp1BBUvyQox0@vger.kernel.org
X-Gm-Message-State: AOJu0YxLB+SiTi2dFXr9htTWL64Heh2/K/QU7m1uh/Q32gkYjQWLtviv
	nUS6/VXZcJoDH38ZBpXXESQYQtBI876HgAHfG/bTh5j2eYgyaisu2SYtQ++PHvcbcTg=
X-Gm-Gg: ASbGnctMWquIiVrS/acHTUntEIa5lbG6dc1vCBs2Z6bcvMC7Vsr/02TpINK/4DVmrck
	iLtR6+m2n2tHsWLSBGT3Xv1Gb+ZMVEsagCHw0c4NSmwmz1aA7squASv0rDHKBMaCRaVibQiCLkF
	J8pKR0sDYpVyd/qTjIwxqOeqExrb/UKBn/RniWNuhlJeCBVlcK5W805jblhb3EnfxTAI6UhPQMS
	Vjj5UN35PFhlGJeJy/PeyvInLbB+97ssOKmLL/tkxqi7998GQlEOJhcfiijeWUETKVxiaXJui0H
	VXtBq6HMn2jReBOczD/NnxkNt872ZPbws/6NHA9Gk+p5cdNB
X-Google-Smtp-Source: AGHT+IFew7Hqs1LLu+x1mBxRqtC/8hhBkw/kSvdUM5vHl7ttcMMDVV4boTbH7S8hCTa8ytg0PMh97w==
X-Received: by 2002:a5e:d516:0:b0:86c:bbea:a6ee with SMTP id ca18e2360f4ac-86cbbeaa74bmr1405053839f.6.1748380624064;
        Tue, 27 May 2025 14:17:04 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdba5b635esm50247173.32.2025.05.27.14.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 14:17:03 -0700 (PDT)
Message-ID: <555564a3-cc29-4fc1-a708-9ef395469d90@kernel.dk>
Date: Tue, 27 May 2025 15:17:02 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: don't lose folio dropbehind state for overwrites
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <a61432ad-fa05-4547-ab82-8d2f74d84038@kernel.dk>
 <aDYqtuXdLvcSl78t@dread.disaster.area>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aDYqtuXdLvcSl78t@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 3:12 PM, Dave Chinner wrote:
> On Tue, May 27, 2025 at 09:43:42AM -0600, Jens Axboe wrote:
>> DONTCACHE I/O must have the completion punted to a workqueue, just like
>> what is done for unwritten extents, as the completion needs task context
>> to perform the invalidation of the folio(s). However, if writeback is
>> started off filemap_fdatawrite_range() off generic_sync() and it's an
>> overwrite, then the DONTCACHE marking gets lost as iomap_add_to_ioend()
>> don't look at the folio being added and no further state is passed down
>> to help it know that this is a dropbehind/DONTCACHE write.
>>
>> Check if the folio being added is marked as dropbehind, and set
>> IOMAP_IOEND_DONTCACHE if that is the case. Then XFS can factor this into
>> the decision making of completion context in xfs_submit_ioend().
>> Additionally include this ioend flag in the NOMERGE flags, to avoid
>> mixing it with unrelated IO.
>>
>> This fixes extra page cache being instantiated when the write performed
>> is an overwrite, rather than newly instantiated blocks.
>>
>> Fixes: b2cd5ae693a3 ("iomap: make buffered writes work with RWF_DONTCACHE")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> Found this one while testing the unrelated issue of invalidation being a
>> bit broken before 6.15 release. We need this to ensure that overwrites
>> also prune correctly, just like unwritten extents currently do.
> 
> I wondered about the stack traces showing DONTCACHE writeback
> completion being handled from irq context[*] when I read the -fsdevel
> thread about broken DONTCACHE functionality yesterday.
> 
> [*] second trace in the failure reported in this comment:
>
> https://lore.kernel.org/linux-fsdevel/432302ad-aa95-44f4-8728-77e61cc1f20c@kernel.dk/

Indeed, though that could've been a "normal" write and not a DONTCACHE
one. But with the bug being fixed by this one, both would've gone that
path...

 
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 233abf598f65..3729391a18f3 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -1691,6 +1691,8 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>>  		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
>>  	if (wpc->iomap.flags & IOMAP_F_SHARED)
>>  		ioend_flags |= IOMAP_IOEND_SHARED;
>> +	if (folio_test_dropbehind(folio))
>> +		ioend_flags |= IOMAP_IOEND_DONTCACHE;
>>  	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
>>  		ioend_flags |= IOMAP_IOEND_BOUNDARY;
>>  
>> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
>> index 26a04a783489..1b7a006402ea 100644
>> --- a/fs/xfs/xfs_aops.c
>> +++ b/fs/xfs/xfs_aops.c
>> @@ -436,6 +436,9 @@ xfs_map_blocks(
>>  	return 0;
>>  }
>>  
>> +#define IOEND_WQ_FLAGS	(IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED | \
>> +			 IOMAP_IOEND_DONTCACHE)
>> +
>>  static int
>>  xfs_submit_ioend(
>>  	struct iomap_writepage_ctx *wpc,
>> @@ -460,8 +463,7 @@ xfs_submit_ioend(
>>  	memalloc_nofs_restore(nofs_flag);
>>  
>>  	/* send ioends that might require a transaction to the completion wq */
>> -	if (xfs_ioend_is_append(ioend) ||
>> -	    (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED)))
>> +	if (xfs_ioend_is_append(ioend) || ioend->io_flags & IOEND_WQ_FLAGS)
>>  		ioend->io_bio.bi_end_io = xfs_end_bio;
>>  
>>  	if (status)
> 
> IMO, this would be cleaner as a helper so that individual cases can
> be commented correctly, as page cache invalidation does not actually
> require a transaction...
> 
> Something like:
> 
> static bool
> xfs_ioend_needs_wq_completion(
> 	struct xfs_ioend	*ioend)
> {
> 	/* Changing inode size requires a transaction. */
> 	if (xfs_ioend_is_append(ioend))
> 		return true;
> 
> 	/* Extent manipulation requires a transaction. */
> 	if (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED))
> 		return true;
> 
> 	/* Page cache invalidation cannot be done in irq context. */
> 	if (ioend->io_flags & IOMAP_IOEND_DONTCACHE)
> 		return true;
> 
> 	return false;
> }
> 
> Otherwise seems fine.

Yeah I like that, gets rid of the need to add the mask as well. I'll
spin a v2 and add the helper.

-- 
Jens Axboe

