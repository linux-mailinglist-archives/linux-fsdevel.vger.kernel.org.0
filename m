Return-Path: <linux-fsdevel+bounces-32999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6B49B1533
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 07:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874E2282F96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 05:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CE4178CDE;
	Sat, 26 Oct 2024 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg1R3QxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B2217F3F;
	Sat, 26 Oct 2024 05:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729921480; cv=none; b=l93+MjM6yMKFWUnqqfOx4ebLn7TTbobsfoAjGBU/bsMRBK5MDHPQ+/uNs1I2egYYagX1f04HN0eItrYQKiA3w2e2fr+lR+Wb44T2ebrjLJ9DEmotStfTCjpEn0EAA7AqcWJkORfyXY/ko4Vx9xMuf2XBD6OHgkgoRNl36z+XEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729921480; c=relaxed/simple;
	bh=A1aBScev47NvYDzMNRyQDRsKQ5KVDM+kNaUOOfpqaRg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=PQMR1C68vu8ZsFsDstGANSx2VPlQfovVPzDfEZ6WmXWok3pY5nkq7RzV7gfjBjzuYOqkfQUA/fMYmdyw5UjtRYFvU5xDjG8dCMNfcQdgAuM6wijE4wuGIz1kejj6COTbTqnH4eBgCMBU2lHX0Cc08g0YopmmUvER5qfp40mM82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg1R3QxE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c714cd9c8so26365675ad.0;
        Fri, 25 Oct 2024 22:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729921476; x=1730526276; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dwInZFxWk1oSj023EruEa3s3vAa0MvGR1IM7qfmaKqQ=;
        b=lg1R3QxEyIMnOZ+fKFnk230oUSObwQkJJ17pM1Dta+LX+n4pYID6EX4AUUrPV4rUkR
         OUVv5SQDmFhiS2xD1CUm+mE7GEaGuYJj+9tBIaE73sOrlGK2iQSI3gfjQMt5+jTkWBxD
         5eF6jMbACoR/sADVNpMJjocU+bFj+yLzmE2k1scm/EAgky0LUo4YBBPjy23DOuIoqDRd
         yCcFPtj6BLiPL/JO0CMbDsPyku1b0hF/sMmovrWFTj9pWR1wgjssl2nFxEw/buMgZzab
         mcWMq4n061cMWoAFYkqGan92kGvyNnWoyBBT1G4qoZgsYSQV5ANofsp1ZhZF4uWbPKh8
         avHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729921476; x=1730526276;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwInZFxWk1oSj023EruEa3s3vAa0MvGR1IM7qfmaKqQ=;
        b=eOSRGViOHenTpgewSKQUE4MXUDSjwkCcuGfGFF4Es/ILQWs+SLAy+EBjUm081p98Jj
         Zjdg201ImrVP0YT7K6UEAJwL0FBqV72yPzZNynjSrJlhooACLOfjnYds7854IFD5jjNJ
         jgVniV2z5+VqPw6SPq272JZ01KPjvFKFqe7uCNeW0rwurCeTJzPR3dZvxnPIFcvr6AbJ
         nYbofBzQy2CReeuqFjmZG1Z+guS4fRjfJiaTgXq+wyd3HHwxELKCLUouKTjW6VkaiORK
         jsG+XDaO46ZthagoaRqaW6PWItS3uX6YM/Wn9TRfdeNEi3GVea805eSxUIY1j8jhrQ3l
         d6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfUqQHbJ49ApAkZwQQU1rof+c2NqOlf1oP6ICTSyFfcJyCAWBRZuW2IwLhcqugTImtzNPnK8e05fxw@vger.kernel.org, AJvYcCVnPr7rdQPyLf5Q+b1XclfTzRyL79E2wvcq4pioFpWplWMDRND7NSpySXTyulrE0mqkL9ujLDL6arykWEf7@vger.kernel.org, AJvYcCXVhkmDeZdc6Kt7NeHIMp8F2RTaSKUmrk2EI9JQcpDJ81SWAV3PkxcLs+LgqnD3pk0qd8DmlnxwZ5TWKgsq7w==@vger.kernel.org, AJvYcCXiDLXumlpTvD2ay4QaUvp4j/9mrPANlkLcN6DXTFYAqxOxX446pVbPlm1GSzaBuh/urBACMgiogWdp@vger.kernel.org
X-Gm-Message-State: AOJu0YzgrU7+2AhDWKMt7ed6YgOgGbmWkHaVQgsOMv868OfED88wKBaP
	0UCxKY+Zl2cf2uy6tOlOuZw6hYuumhOhqla8lnQV+Vzisg3UL1zqQoDGCGmD
X-Google-Smtp-Source: AGHT+IHmhvwfb8Md91NtGvjfR9yMi5Hse67nZ3VT3CQ7ruVWxKaCEtp7Gk7zOXPdnJIcXykL1Ywmew==
X-Received: by 2002:a17:902:cf43:b0:20f:c094:b80f with SMTP id d9443c01a7336-210c6c6b776mr17829375ad.49.1729921476115;
        Fri, 25 Oct 2024 22:44:36 -0700 (PDT)
Received: from dw-tp ([171.76.83.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf70cd4sm18302295ad.87.2024.10.25.22.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 22:44:35 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
In-Reply-To: <20241025182858.GM2386201@frogsfrogsfrogs>
Date: Sat, 26 Oct 2024 10:05:44 +0530
Message-ID: <87jzdvmqfz.fsf@gmail.com>
References: <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com> <87zfmsmsvc.fsf@gmail.com> <fc6fddee-2707-4cca-b0b7-983c8dd17e16@oracle.com> <87v7xgmpwo.fsf@gmail.com> <7e322989-c6e0-424a-94bd-3ad6ce5ffee9@oracle.com> <87ttd0mnuo.fsf@gmail.com> <7aea00d4-3914-414d-a18f-586a303868c1@oracle.com> <87r084mkat.fsf@gmail.com> <509180f3-4cc1-4cc2-9d43-5a1e728fb718@oracle.com> <87plnomfsy.fsf@gmail.com> <20241025182858.GM2386201@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, Oct 25, 2024 at 07:43:17PM +0530, Ritesh Harjani wrote:
>> John Garry <john.g.garry@oracle.com> writes:
>> 
>> > On 25/10/2024 13:36, Ritesh Harjani (IBM) wrote:
>> >>>> So user will anyway will have to be made aware of not to
>> >>>> attempt writes of fashion which can cause them such penalties.
>> >>>>
>> >>>> As patch-6 mentions this is a base support for bs = ps systems for
>> >>>> enabling atomic writes using bigalloc. For now we return -EINVAL when we
>> >>>> can't allocate a continuous user requested mapping which means it won't
>> >>>> support operations of types 8k followed by 16k.
>> >>>>
>> >>> That's my least-preferred option.
>> >>>
>> >>> I think better would be reject atomic writes that cover unwritten
>> >>> extents always - but that boat is about to sail...
>> >> That's what this patch does.
>> >
>> > Not really.
>> >
>> > Currently we have 2x iomap restrictions:
>> > a. mapping length must equal fs block size
>> > b. bio created must equal total write size
>> >
>> > This patch just says that the mapping length must equal total write size 
>> > (instead of a.). So quite similar to b.
>> >
>> >> For whatever reason if we couldn't allocate
>> >> a single contiguous region of requested size for atomic write, then we
>> >> reject the request always, isn't it. Or maybe I didn't understand your comment.
>> >
>> > As the simplest example, for an atomic write to an empty file, there 
>> > should only be a single mapping returned to iomap_dio_bio_iter() and 
>> > that would be of IOMAP_UNWRITTEN type. And we don't reject that.
>> >
>> 
>> Ok. Maybe this is what I am missing. Could you please help me understand
>> why should such writes be rejected? 
>> 
>> For e.g. 
>> If FS could allocate a single contiguous IOMAP_UNWRITTEN extent of
>> atomic write request size, that means - 
>> 1. FS will allocate an unwritten extent.
>> 2. will do writes (using submit_bio) to the unwritten extent. 
>> 3. will do unwritten to written conversion. 
>> 
>> It is ok if either of the above operations fail right? If (3) fails
>> then the region will still be marked unwritten that means it will read
>> zero (old contents). (2) can anyway fail and will not result into
>> partial writes. (1) will anyway not result into any write whatsoever.
>> 
>> So we can never have a situation where there is partial writes leading
>> to mix of old and new write contents right for such cases? Which is what the
>> requirement of atomic/untorn write also is?
>> 
>> Sorry am I missing something here?
>
> I must be missing something; to perform an untorn write, two things must
> happen --
>
> 1. The kernel writes the data to the storage device, and the storage
> device either persists all of it, or throws back an error having
> persisted none of it.
>
> 2. If (1) completes successfully, all file mapping updates for the range
> written must be persisted, or an error is thrown back and none of them
> are persisted.
>
> iomap doesn't have to know how the filesystem satisfies (2); it just has
> to create a single bio containing all data pages or it rejects the
> write.
>
> Currently, it's an implementation detail that the XFS directio write
> ioend code processes the file mapping updates for the range written by
> walking every extent mapping for that range and issuing separate
> transactions for each mapping update.  There's nothing that can restart
> the walk if it is interrupted.  That's why XFS cannot support multi
> fsblock untorn writes to blocks with different status.
>
> As I've said before, the most general solution to this would be to add a
> new log intent item that would track the "update all mappings in this
> file range" operation so that recovery could restart the walk.  This is
> the most technically challenging, so we decided not to implement it
> until there is demand.
>
> Having set aside the idea of redesigning ioend, the second-most general
> solution is pre-zeroing unwritten extents and holes so that
> ->iomap_begin implementations can present a single mapping to the bio
> constructor.  Technically if there's only one unwritten extent or hole
> or cow, xfs can actually satisfy (2) because it only creates one
> transaction.
>
> This gets me to the third and much less general solution -- only allow
> untorn writes if we know that the ioend only ever has to run a single
> transaction.  That's why untorn writes are limited to a single fsblock
> for now -- it's a simple solution so that we can get our downstream
> customers to kick the tires and start on the next iteration instead of
> spending years on waterfalling.
>
> Did you notice that in all of these cases, the capabilities of the
> filesystem's ioend processing determines the restrictions on the number
> and type of mappings that ->iomap_begin can give to iomap?
>
> Now that we have a second system trying to hook up to the iomap support,
> it's clear to me that the restrictions on mappings are specific to each
> filesystem.  Therefore, the iomap directio code should not impose
> restrictions on the mappings it receives unless they would prevent the
> creation of the single aligned bio.
>
> Instead, xfs_direct_write_iomap_begin and ext4_iomap_begin should return
> EINVAL or something if they look at the file mappings and discover that
> they cannot perform the ioend without risking torn mapping updates.  In
> the long run, ->iomap_begin is where this iomap->len <= iter->len check
> really belongs, but hold that thought.
>
> For the multi fsblock case, the ->iomap_begin functions would have to
> check that only one metadata update would be necessary in the ioend.
> That's where things get murky, since ext4/xfs drop their mapping locks
> between calls to ->iomap_begin.  So you'd have to check all the mappings
> for unsupported mixed state every time.  Yuck.
>

Thanks Darrick for taking time summarizing what all has been done
and your thoughts here.

> It might be less gross to retain the restriction that iomap accepts only
> one mapping for the entire file range, like Ritesh has here.

less gross :) sure. 

I would like to think of this as, being less restrictive (compared to
only allowing a single fsblock) by adding a constraint on the atomic
write I/O request i.e.  

"Atomic write I/O request to a region in a file is only allowed if that
region has no partially allocated extents. Otherwise, the file system
can fail the I/O operation by returning -EINVAL."

Essentially by adding this constraint to the I/O request, we are
helping the user to prevent atomic writes from accidentally getting
torned and also allowing multi-fsblock writes. So I still think that
might be the right thing to do here or at least a better start. FS can
later work on adding such support where we don't even need above
such constraint on a given atomic write I/O request.

> Users
> might be ok with us saying that you can't do a 16k atomic write to a
> region where you previously did an 8k write until you write the other
> 8k, even if someone has to write zeroes.  Users might be ok with the
> kernel allowing multi-fsblock writes but only if the stars align.

> But
> to learn the answers to those questions, we have to put /something/ in
> the hands of our users.

On this point, I think ext4 might already has those users who might be
using atomic write characteristics of devices to do untorn writes. e.g. 

In [1], Ted has talked about using bigalloc with ext4 for torn write
prevention. [2] talks about using ext4 with bigalloc to prevent torn
writes on aws cloud.

[1]: https://www.youtube.com/watch?v=gIeuiGg-_iw
[2]: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configure-twp.html

My point being - Looks like the class of users who are using untorn
writes to improve their database performances are already doing so even
w/o any such interfaces being exposed to them (with ext4 bigalloc).

The current feature support of allowing atomic writes to only single
fsblock might not be helpful to these users who can provide that
feedback, who are using ext4 on bs = ps systems with bigalloc. But maybe
let's wait and hear from them whether it is ok if -   

"Atomic write I/O request to a region in a file is only allowed if that
region has no partially allocated extents. Otherwise, the file system
can fail the I/O operation by returning -EINVAL."

>
> For now (because we're already at -rc5), let's have xfs/ext4's
> ->write_iter implementations restrict atomic writes to a single fsblock,
> and get both merged into the kernel.

Yes, I agree with the approach. I agree that we should get a consensus
on this from folks.

Let me split this series up and address the review comments on patch
[1-4]. Patch-5 & 6 can be worked once we have conclusion on this and can
be eyed for 6.14.

> Let's defer the multi fsblock work
> to 6.14, though I think we could take this patch.

It's ok to consider this patch along with multi-fsblock work then i.e.
for 6.14.

>
> Does that sound cool?
>
> --D

Thanks Darrick :)

-ritesh

>> >> 
>> >> If others prefer - we can maybe add such a check (e.g. ext4_dio_atomic_write_checks())
>> >> for atomic writes in ext4_dio_write_checks(), similar to how we detect
>> >> overwrites case to decide whether we need a read v/s write semaphore.
>> >> So this can check if the user has a partially allocated extent for the
>> >> user requested region and if yes, we can return -EINVAL from
>> >> ext4_dio_write_iter() itself.
>> >  > > I think this maybe better option than waiting until ->iomap_begin().
>> >> This might also bring all atomic write constraints to be checked in one
>> >> place i.e. during ext4_file_write_iter() itself.
>> >
>> > Something like this can be done once we decide how atomic writing to 
>> > regions which cover mixed unwritten and written extents is to be handled.
>> 
>> Mixed extent regions (written + unwritten) is a different case all
>> together (which can lead to mix of old and new contents).
>> 
>> 
>> But here what I am suggesting is to add following constraint in case of
>> ext4 with bigalloc - 
>> 
>> "Writes to a region which already has partially allocated extent is not supported."
>> 
>> That means we will return -EINVAL if we detect above case in
>> ext4_file_write_iter() and sure we can document this behavior.
>> 
>> In retrospect, I am not sure why we cannot add a constraint for atomic
>> writes (e.g. for ext4 bigalloc) and reject such writes outright,
>> instead of silently incurring a performance penalty by zeroing out the
>> partial regions by allowing such write request.
>> 
>> -ritesh
>> 

