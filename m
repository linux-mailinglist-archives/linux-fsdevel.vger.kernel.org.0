Return-Path: <linux-fsdevel+bounces-33211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7479B587C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 01:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19CF284367
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA3213FFC;
	Wed, 30 Oct 2024 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnr5DMhs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F045414A90;
	Wed, 30 Oct 2024 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247565; cv=none; b=uXiMV1NMQiRadPXzGaRx2QPvzENoafZ03zu/+WnfilIt9+o8CCz8W4+wdNNIlb+CsM4RWGg2DwspQEuEeaoemtLdA3TKmL1GDLqghgdHFJXmXYKloT8ok/e3BbFY7UnYorrlbiltnDNJ0AGadSr5U/KEBZ4LecFZd5eowRLkSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247565; c=relaxed/simple;
	bh=f38V4kmHxE7lwt2Aux4o0mus7CH/8aVcYXWh42w4XPQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=UXfum1xEIgai+vOX6pdYv3PJJp7917QpcbVJWEIulmE5J/85rteAeVIfOij+fHyWAbuXjruJ8aZBKvks8hCRqlPgGuyGqyGZZ4SOWYIrcWu5+bD19DMtaippk1FGN8wHVKLotWqTp0AzVwn9tVgkuEFXPtHBk5hLIrPXmidZ/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnr5DMhs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so4506725a91.0;
        Tue, 29 Oct 2024 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730247561; x=1730852361; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dQdKoPzOIuoHdb6Qc6bY8tDsxr9M/9m4Dwj67y65+ms=;
        b=mnr5DMhsfW4NVnS2cJyUwb9ZbC9/VczpTnBku2G1bRffouSzsBoQb/vsMlhPxzmbz8
         n0/fB01uiMl4PnoxgGKs8l077gi52yujqh3MhWL0RVp7TYlz9KgATs374ZssOA27Noqf
         vDL6KLkSF/I64mw433L8pHCpdrkJa+431LKPg5t0e6kWoeLdzlvXAGDwjsVvm6ksDIRd
         NRuIw6dGvSX2Bcw4kwszxoxqDX5UMuW1CbznGsNiCWYHXAAGC9wUuoGCLprxMtbUVciT
         2v/o/Tt5xXvmNhxoicpfbgvym+fpjx5fvUDZmoM3f07Etnp7aA1FWLHM+T+fa0AFcjM4
         iHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730247561; x=1730852361;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQdKoPzOIuoHdb6Qc6bY8tDsxr9M/9m4Dwj67y65+ms=;
        b=YmyCGkafyTGToOfQdPiUttSSOBmrnNX8yHyOz/b81BJN7tKEJEBaULqbthhY8ARe6v
         wy5ylst3sivk/9FSAZAmUJzcVHkl0g1ddzoWqA9frKN0m1SH6LmDHlUgPTkrICA/41sY
         +b+T6iImcJ7fcV9p36DaY9Jny0GWVgcvUbLxi91sBok/0JZAAMUWo3d8AHRJ0tydCSao
         46l1oY4kUHd4BpjL8Aewd5WkCnwExT1bX0GBor6tBSnZolpQ4Ef2ItMo5kru2nwltA4p
         wg4Ixjy+LDmHegODW7e85ZjRmmTAosbLhFjnSPNE810tkqrGFHQ23e4LI7bZHE8fgqi3
         2LEg==
X-Forwarded-Encrypted: i=1; AJvYcCUB+9n/6pbnn3owwuFkEKq5T/ywR+C4XovWAtZDA4IPegQzrTOfrIMug6VBbAfxGqaPybxh+QFBjWkg@vger.kernel.org, AJvYcCWlXk37Ol1LDbnwhrGA6gF050a11Oh6rCX95tx3QN+RCNoSTDL8faiAVo/DyXzBRP2xII6RMv5iVvGM9XvQ@vger.kernel.org, AJvYcCXq+eOWCILpr39KdwifYIE3+sEDtimhoQjmjaMU6763egounUBfnYZMh38YLlNrPQqV+DI6RbsYu4d4pXpM@vger.kernel.org
X-Gm-Message-State: AOJu0YzefXKWy+fd/K6l1BEhcPPqLUnVyXmHEMEbookbmXEOVmLDlS0l
	fz0RhvrHG9RPHenFmyhB2/RlNKSkyWcQdGN6x4hUQE0nDf8iIm5n5WvP5w==
X-Google-Smtp-Source: AGHT+IGDNTfChnbNsw7tnu459JmsqAytVIj1MSrA7nFj9F78Vf57YmERtYrhbH55zsc3Fjfa0OgFrw==
X-Received: by 2002:a17:90b:1e50:b0:2e0:74c9:ecf1 with SMTP id 98e67ed59e1d1-2e92ce4e833mr1739145a91.10.1730247560961;
        Tue, 29 Oct 2024 17:19:20 -0700 (PDT)
Received: from dw-tp ([223.186.46.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa36672sm295468a91.14.2024.10.29.17.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:19:20 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] ext4: Warn if we ever fallback to buffered-io for DIO atomic writes
In-Reply-To: <ZyFh3uCGqB20+2X2@dread.disaster.area>
Date: Wed, 30 Oct 2024 05:21:48 +0530
Message-ID: <87h68u79ij.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com> <Zx6+F4Cl1owSDspD@dread.disaster.area> <87iktdm3sf.fsf@gmail.com> <Zx8ga59h0JgU/YIC@dread.disaster.area> <87a5eom6xj.fsf@gmail.com> <ZyFh3uCGqB20+2X2@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Hi Dave, 

Dave Chinner <david@fromorbit.com> writes:

> On Mon, Oct 28, 2024 at 11:44:00PM +0530, Ritesh Harjani wrote:
>> 
>> Hi Dave, 
>> 
>> Dave Chinner <david@fromorbit.com> writes:
>> 
>> > On Mon, Oct 28, 2024 at 06:39:36AM +0530, Ritesh Harjani wrote:
>> >> 
>> >> Hi Dave, 
>> >> 
>> >> Dave Chinner <david@fromorbit.com> writes:
>> >> 
>> >> > On Fri, Oct 25, 2024 at 09:15:53AM +0530, Ritesh Harjani (IBM) wrote:
>> >> >> iomap will not return -ENOTBLK in case of dio atomic writes. But let's
>> >> >> also add a WARN_ON_ONCE and return -EIO as a safety net.
>> >> >> 
>> >> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> >> >> ---
>> >> >>  fs/ext4/file.c | 10 +++++++++-
>> >> >>  1 file changed, 9 insertions(+), 1 deletion(-)
>> >> >> 
>> >> >> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> >> >> index f9516121a036..af6ebd0ac0d6 100644
>> >> >> --- a/fs/ext4/file.c
>> >> >> +++ b/fs/ext4/file.c
>> >> >> @@ -576,8 +576,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>> >> >>  		iomap_ops = &ext4_iomap_overwrite_ops;
>> >> >>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>> >> >>  			   dio_flags, NULL, 0);
>> >> >> -	if (ret == -ENOTBLK)
>> >> >> +	if (ret == -ENOTBLK) {
>> >> >>  		ret = 0;
>> >> >> +		/*
>> >> >> +		 * iomap will never return -ENOTBLK if write fails for atomic
>> >> >> +		 * write. But let's just add a safety net.
>> >> >> +		 */
>> >> >> +		if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
>> >> >> +			ret = -EIO;
>> >> >> +	}
>> >> >
>> >> > Why can't the iomap code return EIO in this case for IOCB_ATOMIC?
>> >> > That way we don't have to put this logic into every filesystem.
>> >> 
>> >> This was origially intended as a safety net hence the WARN_ON_ONCE.
>> >> Later Darrick pointed out that we still might have an unconverted
>> >> condition in iomap which can return ENOTBLK for DIO atomic writes (page
>> >> cache invalidation).
>> >
>> > Yes. That's my point - iomap knows that it's an atomic write, it
>> > knows that invalidation failed, and it knows that there is no such
>> > thing as buffered atomic writes. So there is no possible fallback
>> > here, and it should be returning EIO in the page cache invalidation
>> > failure case and not ENOTBLK.
>> >
>> 
>> So the iomap DIO can return following as return values which can make
>> some filesystems fallback to buffered-io (if they implement fallback
>> logic) - 
>> (1) -ENOTBLK -> this is only returned for pagecache invalidation failure.
>> (2) 0 or partial write size -> This can never happen for atomic writes
>> (since we are only allowing for single fsblock as of now).
>
> Even when we allow multi-FSB atomic writes, the definition of
> atomic write is still "all or nothing". There is no scope for "short
> writes" when IOCB_ATOMIC is set - any condition that means we can't
> write the entire IO as a single bio, we need to abort and return
> EINVAL.

yes. As long as it is a single bio, I agree even the short write
condition should not hit based on the current iomap code.

>
> Hence -ENOTBLK should never be returned by iomap for atomic DIO
> writes - we need to say -EINVAL if the write could not be issued
> atomically for whatever reason it may be so the application knows
> that atomic IO submission was not possible for that IO.
>

Agreed Dave. That is what iomap is doing today for atomic write code. 
(Except maybe one minor difference where it returns -EAGAIN in case of
page cache invalidation assuming the failure maybe transient and the
request could be tried again).


	
>> Now looking at XFS, it never fallsback to buffered-io ever except just 2
>> cases - 
>> 1. When pagecache invalidation fails in iomap (can never happen for
>> atomic writes)
>
> Why can't this happen for atomic DIO writes?  It's the same failure
> cases as for normal DIO writes, isn't it? (i.e. race with mmap
> writes)
>

I meant after the patch which adds atomic write support in iomap code
from John, make sure we don't return -ENOTBLK in case of atomic write request. 


> My point is that if it's an atomic write, this failure should get
> turned into -EINVAL by the iomap code. We do not want a fallback to
> buffered IO when this situation happens for atomic IO.
>
>> 2. On unaligned DIO writes to reflinked CoW (not possible for atomic writes)
>
> This path doesn't ever go through iomap - XFS catches that case
> before it calls into iomap, so it's not relevant to how iomap
> behaves w.r.t atomic IO.
>

Right.

>> So it anyways should never happen that XFS ever fallback to buffered-io
>> for DIO atomic writes. Even today it does not fallback to buffered-io
>> for non-atomic short DIO writes.
>> 
>> >> You pointed it right that it should be fixed in iomap. However do you
>> >> think filesystems can still keep this as safety net (maybe no need of
>> >> WARN_ON_ONCE).
>> >
>> > I don't see any point in adding "impossible to hit" checks into
>> > filesystems just in case some core infrastructure has a bug
>> > introduced....
>> 
>> Yes, that is true for XFS. EXT4 however can return -ENOTBLK for short
>> writes, though it should not happen for current atomic write case where
>> we are only allowing for 1 fsblock. 
>
> Yes, but the -ENOTBLK error returned from ext4_iomap_end() if
> nothing was written does not get returned to ext4 from
> __iomap_dio_rw(). It is consumed by the iomap code:
>
> 	/* magic error code to fall back to buffered I/O */
>         if (ret == -ENOTBLK) {
>                 wait_for_completion = true;
>                 ret = 0;
> 	}
>
> This means that all the IO that was issued gets completed before
> returning to the caller and that's how the short write comes about.
>
> -ENOTBLK is *not returned to the caller* on a short write -

yes. That's my understanding too of the short write case handling in
iomap.

> iomap_dio_rw will return 0 (success).  The caller then has to look
> at the iov_iter state to determine if the write was fully completed.
> This is exactly what the ext4 code currently does for all DIO
> writes, not just those that return -ENOTBLK.
>

yes. Agreed.

>> I would still like to go with a WARN_ON_ONCE where we are calling ext4
>> buffered-io handling for DIO fallback writes. This is to catch any bugs
>> even in future when we move to multi-fsblock case (until we have atomic
>> write support for buffered-io).
>
> Your choice, but please realise that it is not going to catch short
> atomic writes at all.
>

Thanks Dave. Yes, I would like to maybe keep a WARN_ON_ONCE since ext4
has a fallback handling logic where a short DIO or -ENOTBLK case could
be later handled by buffered-io logic (though I agree iomap won't let it
happen for atomic write case). 

But a WARN_ON_ONCE just before buffered-io fallback handling logic in
ext4 DIO path would be my preferred choice only to make sure we could
catch any unwanted bugs in future too.

So I was thinking of this change instead - 


diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8116bd78910b..61787a37e9d4 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -599,6 +599,13 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
                ssize_t err;
                loff_t endbyte;

+               /*
+                * There is no support for atomic writes on buffered-io yet,
+                * we should never fallback to buffered-io for DIO atomic
+                * writes.
+                */
+               WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC);
+
                offset = iocb->ki_pos;
                err = ext4_buffered_write_iter(iocb, from);
                if (err < 0)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fcdee27b9aa2..26b3c84d7f64 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3449,12 +3449,16 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 {
        /*
         * Check to see whether an error occurred while writing out the data to
-        * the allocated blocks. If so, return the magic error code so that we
-        * fallback to buffered I/O and attempt to complete the remainder of
-        * the I/O. Any blocks that may have been allocated in preparation for
-        * the direct I/O will be reused during buffered I/O.
+        * the allocated blocks. If so, return the magic error code for
+        * non-atomic write so that we fallback to buffered I/O and attempt to
+        * complete the remainder of the I/O.
+        * For atomic writes we will simply fail the I/O request if we coudn't
+        * write anything. For non-atomic writes, any blocks that may have been
+        * allocated in preparation for the direct I/O will be reused during
+        * buffered I/O.
         */
-       if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
+       if (!(flags & IOMAP_ATOMIC) && (flags & (IOMAP_WRITE | IOMAP_DIRECT))
+                       && written == 0)
                return -ENOTBLK;

        return 0;


> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

Thanks a lot for the review!

-ritesh

