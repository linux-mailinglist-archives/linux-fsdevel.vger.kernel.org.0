Return-Path: <linux-fsdevel+bounces-59606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4012B3B11E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 04:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489935822A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 02:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAEB21FF36;
	Fri, 29 Aug 2025 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnhfmUlZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE71A58D;
	Fri, 29 Aug 2025 02:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435674; cv=none; b=FgIVXmVLwcdNYuREeHj1EKGlutksHPVuUbqT4nN0r5Z5FutVOX9tYfyOcrskKK4kHm8p/LFNw1qpHGmANLJfBYVaWM9YfWDY4fM6x1fcsaiULfM4zrMKQ/5N3rq5JAcUfHM3WqCNv7o1LZHQsOiAw0pjtx54jW7HhjW83Xodc7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435674; c=relaxed/simple;
	bh=0NaqKPi0nbkduXdLlQqcuDuAki5cwbyz75CUvTa8yvs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=s/+FGJu1cBsx+JR7E0TqQQHwHfybqfDAF6eyzo9BaLfIcK7WfbJ8VWF9npyMirOb82HuvVsBWxpspN8cMgqyzBc/MPM5j7uq2pcoJtw7J16MYGSi5FzRqusa4aytO6Erri/IVPhWNGioZ1oMtOWDMXXzAAoY1H4z4X0Pvri2kvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnhfmUlZ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4cf40cd0d1so231788a12.0;
        Thu, 28 Aug 2025 19:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756435672; x=1757040472; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JZ9wmr99Yf2OiqbFk7ybwlinPpULK3DDjyydQHoTCNU=;
        b=hnhfmUlZuLoS10Do1TG7UAuYIUV4Moh0Yv6Q4/hCivr6M0dD2bATPrJ0CYve4xPrzI
         OcfC1HdhAt3Oy5AaCMYOcogPKQZhqIxS12uBURuN4yxZcTKwdGfeiuTOmA/B6uSjyRkE
         xDmZevZg4la3133dIqc04DE6taak62G1kyUiLEby0ZZNPw8pP0vIfq89y5d4UBVf81so
         PYyN2IazaDL2v2SZGKrFsYs+6dop5JrK+NeDap+XmCk/sQv7cvT/EBsg7/VwaECbD4Nx
         02XZGhT0OTqCvEOkTw9aVUlefPOvh523+xPPq5ODXfK6komRKDfMp2oGZp2Uj0zkmGt/
         2v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756435672; x=1757040472;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZ9wmr99Yf2OiqbFk7ybwlinPpULK3DDjyydQHoTCNU=;
        b=f7GDeHrX04lcwpEWZv3PWkiI7NQ/4ha6G9ih4aJZo6GxABrnUYpCbzm7cKCbceMXER
         3Lohbuk/6bmgZCE9Jn7z5PWc7EVD3VJPdMwYsJXFTfLlKPEtVWBP5A0FydgIdQg109Jp
         1WREW6oKYXehz1vsPBpLRw92RaeZd868v3iz12BlvXaBEJ+/3O95YXeF4JDa2xwuKqcw
         qWp6ybCvkOJECtYZHxJPXwi+twbOtULPgIpynJzdo4kQJMpDa2IzEhko2nWlUwMMOPW+
         ktqIjO/beUr4ITuVAijdKM9Hjo+q8+ciQ6NGob8QMLrd/22AdqNG5Li8R4ppaTr2sMlm
         JQWg==
X-Forwarded-Encrypted: i=1; AJvYcCULNBoQ4T1/N11+Hq+6ZoREkQ8UMY1vEec0voSMvPUhXAWEN0MY+A5mo+wNMVCn+T9f+awT1JtBsej8Iv3PcA==@vger.kernel.org, AJvYcCUoa5az0NRa6AEqdqxRK/YlmZlzbDNz1Lu3gYtGTTJjJFZL7UNEewFYJ2XWiv1vfFnGkFaTDWw6awvoWA==@vger.kernel.org, AJvYcCVg8P2pyO//1kI1b2ChfoaFYuoK3GtGcwcVAmLwDqkzJ1vkCJFj31Kr4lR6aRVAGt5hfHiQzhRlfOb+@vger.kernel.org, AJvYcCW4xBpiAaHg0wmMgDszCzuJW8NTUthU2sK9vwThXHz0PjxAPvMeHjhZJ3w8S/2rIE71yq4bUTKewSfASwbT@vger.kernel.org, AJvYcCX/1rPcuNa9C1NfAkMrWIxu4sh8zjKyHKz0uZOmGiaFrAg5KX32b9x3v+PxPG7YdYGxtaLXHtmMZAV4cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeNwf/OdCVL28zjeCSmyyiCK+4SDZ+TWQMPTj3jYo5BbrAl3sv
	IG3mTRoVSIqFJ4fxGFVd11ExnHlrYv7OZGhsvwC/6QaJJV/0ALwnVLln
X-Gm-Gg: ASbGncsnEyEDsGr3bzQIJ80/u+giUSQ+6WN3EK8JPYtaRs/4/+8q5xPTTHhrnwPV6Kk
	kh4/KZk1UIVHHKpUifblIkblACEY/BDJw4xUzZEbQWpxwkmodeGNKtvOCAWDWm7uZycr+UE1kDf
	E6sTG7niQn7AJXKtCgvfRSFvD59lMIkazFr/kYp+jPFrtihvis2J1ztB0CJbfZvB9qndAawrtDs
	etD4ivxWtK1U7BabnLhbI8MeS1OqwQx2hoGC+BZXOJVzEdCZSaIkr8rT5ARm0iD9+W5b2Lt1jKy
	2cFgB0TnNoxr/r+gKHTGIuODuvDFXgVQNRQr8ChBWwPlSDrzeTqV7VQXYGsiCXv1vsF0ZaoDmHp
	AWDZnB8ZPPd7IxfwVaE5nnt6U3Q==
X-Google-Smtp-Source: AGHT+IEVbsRZ4L7P12wxeChIuvyRzeF7VdizyYTaB4AKMbmobBgFbKFhASHYn55ebbptuM5XyJhT7Q==
X-Received: by 2002:a17:903:198e:b0:242:e29e:d6a6 with SMTP id d9443c01a7336-2462ef66f01mr341960885ad.40.1756435672223;
        Thu, 28 Aug 2025 19:47:52 -0700 (PDT)
Received: from dw-tp ([171.76.86.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906598808sm8925935ad.116.2025.08.28.19.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 19:47:51 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org, hch@lst.de, martin.petersen@oracle.com, djwong@kernel.org, linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk, Jan Kara <jack@suse.com>, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
In-Reply-To: <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq>
Date: Fri, 29 Aug 2025 07:41:21 +0530
Message-ID: <87bjnyg9me.fsf@gmail.com>
References: <20250819164922.640964-1-kbusch@meta.com> <87a53ra3mb.fsf@gmail.com> <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq> <aKx485EMthHfBWef@kbusch-mbp> <87cy8ir835.fsf@gmail.com> <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Jan Kara <jack@suse.cz> writes:

> On Tue 26-08-25 10:29:58, Ritesh Harjani wrote:
>> Keith Busch <kbusch@kernel.org> writes:
>> 
>> > On Mon, Aug 25, 2025 at 02:07:15PM +0200, Jan Kara wrote:
>> >> On Fri 22-08-25 18:57:08, Ritesh Harjani wrote:
>> >> > Keith Busch <kbusch@meta.com> writes:
>> >> > >
>> >> > >   - EXT4 falls back to buffered io for writes but not for reads.
>> >> > 
>> >> > ++linux-ext4 to get any historical context behind why the difference of
>> >> > behaviour in reads v/s writes for EXT4 DIO. 
>> >> 
>> >> Hum, how did you test? Because in the basic testing I did (with vanilla
>> >> kernel) I get EINVAL when doing unaligned DIO write in ext4... We should be
>> >> falling back to buffered IO only if the underlying file itself does not
>> >> support any kind of direct IO.
>> >
>> > Simple test case (dio-offset-test.c) below.
>> >
>> > I also ran this on vanilla kernel and got these results:
>> >
>> >   # mkfs.ext4 /dev/vda
>> >   # mount /dev/vda /mnt/ext4/
>> >   # make dio-offset-test
>> >   # ./dio-offset-test /mnt/ext4/foobar
>> >   write: Success
>> >   read: Invalid argument
>> >
>> > I tracked the "write: Success" down to ext4's handling for the "special"
>> > -ENOTBLK error after ext4_want_directio_fallback() returns "true".
>> >
>> 
>> Right. Ext4 has fallback only for dio writes but not for DIO reads... 
>> 
>> buffered
>> static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
>> {
>> 	/* must be a directio to fall back to buffered */
>> 	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
>> 		    (IOMAP_WRITE | IOMAP_DIRECT))
>> 		return false;
>> 
>>     ...
>> }
>> 
>> So basically the path is ext4_file_[read|write]_iter() -> iomap_dio_rw
>>     -> iomap_dio_bio_iter() -> return -EINVAL. i.e. from...
>> 
>> 
>> 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>> 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>> 		return -EINVAL;
>> 
>> EXT4 then fallsback to buffered-io only for writes, but not for reads. 
>
> Right. And the fallback for writes was actually inadvertedly "added" by
> commit bc264fea0f6f "iomap: support incremental iomap_iter advances". That
> changed the error handling logic. Previously if iomap_dio_bio_iter()
> returned EINVAL, it got propagated to userspace regardless of what
> ->iomap_end() returned. After this commit if ->iomap_end() returns error
> (which is ENOTBLK in ext4 case), it gets propagated to userspace instead of
> the error returned by iomap_dio_bio_iter().
>
> Now both the old and new behavior make some sense so I won't argue that the
> new iomap_iter() behavior is wrong. But I think we should change ext4 back
> to the old behavior of failing unaligned dio writes instead of them falling
> back to buffered IO. I think something like the attached patch should do
> the trick - it makes unaligned dio writes fail again while writes to holes
> of indirect-block mapped files still correctly fall back to buffered IO.
> Once fstests run completes, I'll do a proper submission...
>

Aah, right. So it wasn't EXT4 which had this behaviour of falling back
to buffered I/O for unaligned writes. Earlier EXT4 was assuming an error
code will be detected by iomap and will be passed to it as "written" in
ext4_iomap_end() for such unaligned writes. But I guess that logic
silently got changed with that commit. Thanks for analyzing that. 
I missed looking underneath iomap behaviour change :). 


>
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> From ce6da00a09647a03013c3f420c2e7ef7489c3de8 Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Wed, 27 Aug 2025 14:55:19 +0200
> Subject: [PATCH] ext4: Fail unaligned direct IO write with EINVAL
>
> Commit bc264fea0f6f ("iomap: support incremental iomap_iter advances")
> changed the error handling logic in iomap_iter(). Previously any error
> from iomap_dio_bio_iter() got propagated to userspace, after this commit
> if ->iomap_end returns error, it gets propagated to userspace instead of
> an error from iomap_dio_bio_iter(). This results in unaligned writes to
> ext4 to silently fallback to buffered IO instead of erroring out.
>
> Now returning ENOTBLK for DIO writes from ext4_iomap_end() seems
> unnecessary these days. It is enough to return ENOTBLK from
> ext4_iomap_begin() when we don't support DIO write for that particular
> file offset (due to hole).

Right. This mainly only happens if we have holes in non-extent (indirect
blocks) case.

Also, as I see ext4 always just fallsback to buffered-io for no or
partial writes (unless iomap returned any error code). So, I was just
wondering if that could ever happen for DIO atomic write case. It's good
that we have a WARN_ON_ONCE() check in there to catch it. But I was
wondering if this needs an explicit handling in ext4_dio_write_iter() to
not fallback to buffered-writes for atomic DIO requests?

-ritesh



>
> Fixes: bc264fea0f6f ("iomap: support incremental iomap_iter advances")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/file.c  |  2 --
>  fs/ext4/inode.c | 35 -----------------------------------
>  2 files changed, 37 deletions(-)
>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 93240e35ee36..cf39f57d21e9 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -579,8 +579,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   dio_flags, NULL, 0);
> -	if (ret == -ENOTBLK)
> -		ret = 0;
>  	if (extend) {
>  		/*
>  		 * We always perform extending DIO write synchronously so by
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..c3b23c90fd11 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3872,47 +3872,12 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
>  	return ret;
>  }
>  
> -static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
> -{
> -	/* must be a directio to fall back to buffered */
> -	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
> -		    (IOMAP_WRITE | IOMAP_DIRECT))
> -		return false;
> -
> -	/* atomic writes are all-or-nothing */
> -	if (flags & IOMAP_ATOMIC)
> -		return false;
> -
> -	/* can only try again if we wrote nothing */
> -	return written == 0;
> -}
> -
> -static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
> -			  ssize_t written, unsigned flags, struct iomap *iomap)
> -{
> -	/*
> -	 * Check to see whether an error occurred while writing out the data to
> -	 * the allocated blocks. If so, return the magic error code for
> -	 * non-atomic write so that we fallback to buffered I/O and attempt to
> -	 * complete the remainder of the I/O.
> -	 * For non-atomic writes, any blocks that may have been
> -	 * allocated in preparation for the direct I/O will be reused during
> -	 * buffered I/O. For atomic write, we never fallback to buffered-io.
> -	 */
> -	if (ext4_want_directio_fallback(flags, written))
> -		return -ENOTBLK;
> -
> -	return 0;
> -}
> -
>  const struct iomap_ops ext4_iomap_ops = {
>  	.iomap_begin		= ext4_iomap_begin,
> -	.iomap_end		= ext4_iomap_end,
>  };
>  
>  const struct iomap_ops ext4_iomap_overwrite_ops = {
>  	.iomap_begin		= ext4_iomap_overwrite_begin,
> -	.iomap_end		= ext4_iomap_end,
>  };
>  
>  static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
> -- 
> 2.43.0

