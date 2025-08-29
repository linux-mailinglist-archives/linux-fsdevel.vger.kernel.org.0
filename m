Return-Path: <linux-fsdevel+bounces-59607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89884B3B1BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 05:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83F01C80CBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 03:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E37220686;
	Fri, 29 Aug 2025 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox2jY90A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655D714B950;
	Fri, 29 Aug 2025 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438858; cv=none; b=tWnlI33m1FuZ+4NbJ8Im5RWnFxC/XW4H/DItZaZ8LDyutn391765Wsx54ECF2Gvx/Jg8XLGsAVArUuEOvlhAzPChRYAtFWMQdcC+DAW+DqP/tngEhv3Qbpq3ep1+czCiYobYsOwHSlzvD1pNQOjWA7Y+XY7bIyBAODryjlvmuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438858; c=relaxed/simple;
	bh=HL94/RsYpfErAps6eTEGXeJUgnGdftRMudR84530hlQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=auHQId6C4CgywUclOgJ4NjM8MtLyOeGPEOWTr79fc6VRMGaj4EZsHCWOnz5YCSdd0rgTGA9PJYkivjSi8ufA3lBNMW33ILZnKCNyflGMRN3vlqzISclQgSs/9iUSJ03IKVHo7wlLgd4g8PSJbZ2X+fGsZrEXex9KK+fnOPTC8Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox2jY90A; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b49cf21320aso1864529a12.1;
        Thu, 28 Aug 2025 20:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756438856; x=1757043656; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=en0FtuLbpSkfsZBRvwj+MVzEjDhjumfZ8xUGHaQ27Mc=;
        b=Ox2jY90AxBzEjvthKDr2qg4mMmYZHAKR0hLwFx3INSzFPZRTUz99RxKAi2lGSyxOtG
         9NWBaaomIvzm3QCaJwHb2eWCxfd11O9E46cuK4K6la3MyX5E1mLOAgJQjt2Z3QotP9qH
         He7wUgV516fv29AR3TD6A5/4LZzbg0/Aj9RFsjp1NFkjRn1cbhbR1d1MPUHysK4+CBBn
         34OD6dd0IgAsTf8xH/tMHU45pWB6n3dg/X1WZjC3gse7f4ZSXbecndCsT/9aapalGHbS
         oAA2q8ugMLtABZA+P4/BCiEQEEyZRik/YZiAMmDBEKcykTUgu75kXkbELxjY7MkG2IzY
         XQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438856; x=1757043656;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=en0FtuLbpSkfsZBRvwj+MVzEjDhjumfZ8xUGHaQ27Mc=;
        b=Po/P2PF7FaeS5P3tE+EASYIX9j4uWQaSRErPZsYGSLj7dnYGc9Q8ttTStMQkYpSCEO
         yQCqEiHMz2fDbXsi2jVmW/uFqaX7gYgkWve7vKScY08ll7/j/FC8i9btuIgMfZJ8DGrp
         b0EbpyStA9SteI5Upw+sxaSS5DcgT398PfQiYRKN9QjQAdMlwB0JaCfewx4Lfr4G/WMo
         XVWy9mK1b8EDMeTuh2H3qnlExlV3LQ7cioNqBPCnpLZE8JM0evlRuOxPQt80LFPv7O4g
         5zHp3c22FqEgVVOAoa4yuz0p2SxBnDr5c+Ba5bQs0KqGMbVtK/khwXUlrN1OO77GgpYE
         fzZw==
X-Forwarded-Encrypted: i=1; AJvYcCUqu/Q/ejN1+66ht6Ei7k90yxy+KO8HWoMG0sT2E2xm6R3OaZaJAqZmh0anDgEzxg+/NhAkcEOtJiA4cStmKw==@vger.kernel.org, AJvYcCXCT9JGnLqi9lwlTj4BtGC6P8QcO9fZPBpWQ5673Uf2nmoJf2ar0MJBOoXT5yh8A6u3ii5P2yAopmXBhw==@vger.kernel.org, AJvYcCXGTbWJvUvVRJeZxLIjaRcTuRJVyQdxNnUwC5TDK4vxINygo6j2R2KQsHyy2Cyd+Rc/CvGw6pa//Yqv@vger.kernel.org, AJvYcCXsRtxHSghLYVp9fqYHR5SJCdonUdEaFVh2Exe7pqxW61r3GbGYJBO32q8oSShxsnOPR+4dPNMERZWVeQ==@vger.kernel.org, AJvYcCXwFm7mgn33VVUySwZO4AjkQig2CYHL/tOzqBo3zD4iS6gip4YbVzONjrtozns+jLgnZ7BMrarC6JcKhjAb@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQ8Bp4WglHdPHTs4HwiKSov3D6+WKMVKQLtXBeVzi29Avo1Iv
	SOMC+/B7MoI/47TIifw1er1+5pi/uFtiPzyc+dnNPQzlYFB2IicPbv9w
X-Gm-Gg: ASbGncvsfRff70B/pqhhzRx4PnUUofyucqpF/FU8R9zRkvbLVyh8h18QqcKwbJ/v4ep
	2VlEjAM5mhkBqs9nWExp8d/uUHrrsk5c59n1//MZjt8FUPqXKMlhbJ9bbnTAevdw1X8/PXlRNjh
	3YF6rbEU+N6/srdcgUJEpRLU+6JqMjj/pngABjTOyipfFTBB1kJC5XDW2Ukt03N/SsixMVqWhsU
	PUQvhiqw+akGdEsqKuC06VvqJaSMWDLUlHeKc9zcwfYJ1sy7362rIRvmQarK8pvhoAmnhYnYOEe
	SfJke9eH1XeQtvvu0wSV3bjVbcmHZDCstn1mFh3eAkC5Tfg3KVYq8fbx28FWv0HXheQ2BRsYrTD
	isJp5uBjeBdyuduj44wQLIRg3XQ==
X-Google-Smtp-Source: AGHT+IHMtAOg2MhaA/X/A/11IDxmp+zSkIboCNf3+rVXJ+/rgIXFXRYq7sAfSwoIMV75zidhVJbDjQ==
X-Received: by 2002:a17:903:4b48:b0:246:2afa:4cc with SMTP id d9443c01a7336-2462ef67771mr362027945ad.42.1756438855554;
        Thu, 28 Aug 2025 20:40:55 -0700 (PDT)
Received: from dw-tp ([171.76.86.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906390e6bsm10115655ad.96.2025.08.28.20.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 20:40:54 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org, hch@lst.de, martin.petersen@oracle.com, djwong@kernel.org, linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk, Jan Kara <jack@suse.com>, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
In-Reply-To: <87bjnyg9me.fsf@gmail.com>
Date: Fri, 29 Aug 2025 08:49:02 +0530
Message-ID: <878qj2g6hl.fsf@gmail.com>
References: <20250819164922.640964-1-kbusch@meta.com> <87a53ra3mb.fsf@gmail.com> <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq> <aKx485EMthHfBWef@kbusch-mbp> <87cy8ir835.fsf@gmail.com> <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq> <87bjnyg9me.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Jan Kara <jack@suse.cz> writes:
>
>> On Tue 26-08-25 10:29:58, Ritesh Harjani wrote:
>>> Keith Busch <kbusch@kernel.org> writes:
>>> 
>>> > On Mon, Aug 25, 2025 at 02:07:15PM +0200, Jan Kara wrote:
>>> >> On Fri 22-08-25 18:57:08, Ritesh Harjani wrote:
>>> >> > Keith Busch <kbusch@meta.com> writes:
>>> >> > >
>>> >> > >   - EXT4 falls back to buffered io for writes but not for reads.
>>> >> > 
>>> >> > ++linux-ext4 to get any historical context behind why the difference of
>>> >> > behaviour in reads v/s writes for EXT4 DIO. 
>>> >> 
>>> >> Hum, how did you test? Because in the basic testing I did (with vanilla
>>> >> kernel) I get EINVAL when doing unaligned DIO write in ext4... We should be
>>> >> falling back to buffered IO only if the underlying file itself does not
>>> >> support any kind of direct IO.
>>> >
>>> > Simple test case (dio-offset-test.c) below.
>>> >
>>> > I also ran this on vanilla kernel and got these results:
>>> >
>>> >   # mkfs.ext4 /dev/vda
>>> >   # mount /dev/vda /mnt/ext4/
>>> >   # make dio-offset-test
>>> >   # ./dio-offset-test /mnt/ext4/foobar
>>> >   write: Success
>>> >   read: Invalid argument
>>> >
>>> > I tracked the "write: Success" down to ext4's handling for the "special"
>>> > -ENOTBLK error after ext4_want_directio_fallback() returns "true".
>>> >
>>> 
>>> Right. Ext4 has fallback only for dio writes but not for DIO reads... 
>>> 
>>> buffered
>>> static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
>>> {
>>> 	/* must be a directio to fall back to buffered */
>>> 	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
>>> 		    (IOMAP_WRITE | IOMAP_DIRECT))
>>> 		return false;
>>> 
>>>     ...
>>> }
>>> 
>>> So basically the path is ext4_file_[read|write]_iter() -> iomap_dio_rw
>>>     -> iomap_dio_bio_iter() -> return -EINVAL. i.e. from...
>>> 
>>> 
>>> 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>>> 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>>> 		return -EINVAL;
>>> 
>>> EXT4 then fallsback to buffered-io only for writes, but not for reads. 
>>
>> Right. And the fallback for writes was actually inadvertedly "added" by
>> commit bc264fea0f6f "iomap: support incremental iomap_iter advances". That
>> changed the error handling logic. Previously if iomap_dio_bio_iter()
>> returned EINVAL, it got propagated to userspace regardless of what
>> ->iomap_end() returned. After this commit if ->iomap_end() returns error
>> (which is ENOTBLK in ext4 case), it gets propagated to userspace instead of
>> the error returned by iomap_dio_bio_iter().
>>
>> Now both the old and new behavior make some sense so I won't argue that the
>> new iomap_iter() behavior is wrong. But I think we should change ext4 back
>> to the old behavior of failing unaligned dio writes instead of them falling
>> back to buffered IO. I think something like the attached patch should do
>> the trick - it makes unaligned dio writes fail again while writes to holes
>> of indirect-block mapped files still correctly fall back to buffered IO.
>> Once fstests run completes, I'll do a proper submission...
>>
>
> Aah, right. So it wasn't EXT4 which had this behaviour of falling back
> to buffered I/O for unaligned writes. Earlier EXT4 was assuming an error
> code will be detected by iomap and will be passed to it as "written" in
> ext4_iomap_end() for such unaligned writes. But I guess that logic
> silently got changed with that commit. Thanks for analyzing that. 
> I missed looking underneath iomap behaviour change :). 
>
>
>>
>> 								Honza
>> -- 
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
>> From ce6da00a09647a03013c3f420c2e7ef7489c3de8 Mon Sep 17 00:00:00 2001
>> From: Jan Kara <jack@suse.cz>
>> Date: Wed, 27 Aug 2025 14:55:19 +0200
>> Subject: [PATCH] ext4: Fail unaligned direct IO write with EINVAL
>>
>> Commit bc264fea0f6f ("iomap: support incremental iomap_iter advances")
>> changed the error handling logic in iomap_iter(). Previously any error
>> from iomap_dio_bio_iter() got propagated to userspace, after this commit
>> if ->iomap_end returns error, it gets propagated to userspace instead of
>> an error from iomap_dio_bio_iter(). This results in unaligned writes to
>> ext4 to silently fallback to buffered IO instead of erroring out.
>>
>> Now returning ENOTBLK for DIO writes from ext4_iomap_end() seems
>> unnecessary these days. It is enough to return ENOTBLK from
>> ext4_iomap_begin() when we don't support DIO write for that particular
>> file offset (due to hole).
>
> Right. This mainly only happens if we have holes in non-extent (indirect
> blocks) case.
>

Thinking more on this case. Do we really want a fallback to buffered-io
for unaligned writes in this case (indirect block case)?

I don't think we care much here, right? And anyways the unaligned writes
should have the same behaviour for extents v/s non-extents case right?

I guess the problem is, iomap alignment check happens in
iomap_dio_bio_iter() where it has a valid bdev (populated by filesystem
during ->iomap_begin() call) to check the alignment against. But in this
indirect block case we return -ENOTBLK much earlier from ->iomap_begin()
call itself.


-ritesh



> Also, as I see ext4 always just fallsback to buffered-io for no or
> partial writes (unless iomap returned any error code). So, I was just
> wondering if that could ever happen for DIO atomic write case. It's good
> that we have a WARN_ON_ONCE() check in there to catch it. But I was
> wondering if this needs an explicit handling in ext4_dio_write_iter() to
> not fallback to buffered-writes for atomic DIO requests?
>
> -ritesh
>
>
>
>>
>> Fixes: bc264fea0f6f ("iomap: support incremental iomap_iter advances")
>> Signed-off-by: Jan Kara <jack@suse.cz>
>> ---
>>  fs/ext4/file.c  |  2 --
>>  fs/ext4/inode.c | 35 -----------------------------------
>>  2 files changed, 37 deletions(-)
>>
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index 93240e35ee36..cf39f57d21e9 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -579,8 +579,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  		iomap_ops = &ext4_iomap_overwrite_ops;
>>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>>  			   dio_flags, NULL, 0);
>> -	if (ret == -ENOTBLK)
>> -		ret = 0;
>>  	if (extend) {
>>  		/*
>>  		 * We always perform extending DIO write synchronously so by
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 5b7a15db4953..c3b23c90fd11 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3872,47 +3872,12 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
>>  	return ret;
>>  }
>>  
>> -static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
>> -{
>> -	/* must be a directio to fall back to buffered */
>> -	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
>> -		    (IOMAP_WRITE | IOMAP_DIRECT))
>> -		return false;
>> -
>> -	/* atomic writes are all-or-nothing */
>> -	if (flags & IOMAP_ATOMIC)
>> -		return false;
>> -
>> -	/* can only try again if we wrote nothing */
>> -	return written == 0;
>> -}
>> -
>> -static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>> -			  ssize_t written, unsigned flags, struct iomap *iomap)
>> -{
>> -	/*
>> -	 * Check to see whether an error occurred while writing out the data to
>> -	 * the allocated blocks. If so, return the magic error code for
>> -	 * non-atomic write so that we fallback to buffered I/O and attempt to
>> -	 * complete the remainder of the I/O.
>> -	 * For non-atomic writes, any blocks that may have been
>> -	 * allocated in preparation for the direct I/O will be reused during
>> -	 * buffered I/O. For atomic write, we never fallback to buffered-io.
>> -	 */
>> -	if (ext4_want_directio_fallback(flags, written))
>> -		return -ENOTBLK;
>> -
>> -	return 0;
>> -}
>> -
>>  const struct iomap_ops ext4_iomap_ops = {
>>  	.iomap_begin		= ext4_iomap_begin,
>> -	.iomap_end		= ext4_iomap_end,
>>  };
>>  
>>  const struct iomap_ops ext4_iomap_overwrite_ops = {
>>  	.iomap_begin		= ext4_iomap_overwrite_begin,
>> -	.iomap_end		= ext4_iomap_end,
>>  };
>>  
>>  static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>> -- 
>> 2.43.0

