Return-Path: <linux-fsdevel+bounces-33084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B947F9B3952
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 19:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27652B216F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91621DFD87;
	Mon, 28 Oct 2024 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu8XwCxf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA041DE4DE;
	Mon, 28 Oct 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140753; cv=none; b=Hi6GRxCJPGqXG3g3O6i/wzFeOL8X8u3+aQtSldtAqbhMJ6+ErPJVYCXx06cXFnL36ivS6qbe7cZNavnLEmDdYIJkkZjuIbb8myIvdf/+FgEhU2qFdpBbiZUUKNFVP9FzK+FObJ4PoSaTt35yp0HaM5bFb6/Sr05v/vBNVmdX6lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140753; c=relaxed/simple;
	bh=AYtJEjGo8gcP80huS1IqoXQUq0zkyVAYCgidNOLpDm8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=WKol566BQ/2h6DEQLmY3iNG4KeTMy5/ItaivOLi0H/lz10yaY5CCEFIqbOSaY5etYN1URme5czJvGupwhdd4XurSP+UI2nbnKKQOP/KXpmpp87tygOdc4BHZ3hvh9tTATs0CepUyDyuNQPeftJBcpDJayT7itwoz5v5iizIMtj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu8XwCxf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cb47387ceso41100015ad.1;
        Mon, 28 Oct 2024 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730140750; x=1730745550; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SZiPmgj2dPJ6tCBHtrpUtVtByhB4f+Nr2hhGHzMBNas=;
        b=Tu8XwCxfHL0EPB/QK3zerXs48rE/wLhGuSaE2Ko/c/V+17m0xjRhjegpHhAQdudXYA
         jraGmJdUaH+c5hcXxC17+OVYAJwatnH+Wwn+LgxcFnGeyKfXBjIb2dF5qQcHPWLn5rp7
         UjCUJCACrMVtdfXr1bHTOgQ3NC6fWXWlfaBp13bOKpPPQqJ4kRwgz5yIwpKhzxjiu6GO
         XN2eh95cNDp58QHmNI9tvNZ42AOLYFJgC7mghJz0CfPpJVTwEVUIxPPhEvtXtAXaOYJy
         KGFDArBOLvL2ZipAoTPC+bnEWCUMwh2cUjN5TffKuAc1UwFHF87Rg5KfslSTaICy1wYx
         6+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140750; x=1730745550;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZiPmgj2dPJ6tCBHtrpUtVtByhB4f+Nr2hhGHzMBNas=;
        b=Z7HHslonJYXDqm0Qr8dttwouSJDoY4fGtl11vEuwYZf2BdAhCFl/o0W4uHXBD7wVbz
         ED7gk8XwG0S2s/IKX9ulUv6XgQzmNTuedhImqKI3/ZscJC0raa8Q2YRtFhMwSHt2m/D1
         QpqmfYM52a7ak2y1P17G4uhqqiRWth/0xcUenclXUlwV4/M2FNqRuXlophuuI+GhNdf1
         fd6Q/qHoT278Cri5emenCr3gBHW6eG+qugyXZuLw71EbLYHrDvwOeLz9u2tXOiERRPnA
         yPBLA2cDb/hQmtaDsmgb6Ucpkj9k0NojLI6NwHB5/PKt6eMPnO2+N/zBQ+N9BlvJPej3
         wVMg==
X-Forwarded-Encrypted: i=1; AJvYcCVYtmJGfDQQ4tFOYLLayR/zvH72EFimH20zqzaAuNxqtJo3kxUHHyeOp60NLMpwmEkUDbHZuHOHxDP8@vger.kernel.org, AJvYcCX36ZwTsccqgcXqXY49wL7z0XW/nxMDOvDll04YWtFpS/cBzpYjMK5rKxZ9z2sT9B8IQKDEA5VMP36cUz7X@vger.kernel.org, AJvYcCX9aoIZrQGoeWVxbjK5D1BclPLDvuYmYPVeGJCYwQTm1jJyLrlTquT29IJObLsGhZnkz0H0if4hYW2QMlU6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywybj9gSkeXkyy4KhMjjTIVnuq3IqrfuOezDgj7K9TtVsawPp0p
	vNJ9XOGmL0JpswFT0QR78PN5mghEaEkZ4FJgSWyBuS5vtT9EZw+QqH194w==
X-Google-Smtp-Source: AGHT+IGsUjCFz3IRvH+sm1iBtHXYzpWXPl8/usgsJfUshZ6e3iWqYhjikKEhPIHCn1AfVf0B/C6ZOw==
X-Received: by 2002:a17:902:f693:b0:20b:7be8:8ecf with SMTP id d9443c01a7336-210c6c7f095mr108266405ad.53.1730140749888;
        Mon, 28 Oct 2024 11:39:09 -0700 (PDT)
Received: from dw-tp ([171.76.83.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6dcfbsm53600815ad.103.2024.10.28.11.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 11:39:09 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] ext4: Warn if we ever fallback to buffered-io for DIO atomic writes
In-Reply-To: <Zx8ga59h0JgU/YIC@dread.disaster.area>
Date: Mon, 28 Oct 2024 23:44:00 +0530
Message-ID: <87a5eom6xj.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com> <Zx6+F4Cl1owSDspD@dread.disaster.area> <87iktdm3sf.fsf@gmail.com> <Zx8ga59h0JgU/YIC@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Hi Dave, 

Dave Chinner <david@fromorbit.com> writes:

> On Mon, Oct 28, 2024 at 06:39:36AM +0530, Ritesh Harjani wrote:
>> 
>> Hi Dave, 
>> 
>> Dave Chinner <david@fromorbit.com> writes:
>> 
>> > On Fri, Oct 25, 2024 at 09:15:53AM +0530, Ritesh Harjani (IBM) wrote:
>> >> iomap will not return -ENOTBLK in case of dio atomic writes. But let's
>> >> also add a WARN_ON_ONCE and return -EIO as a safety net.
>> >> 
>> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> >> ---
>> >>  fs/ext4/file.c | 10 +++++++++-
>> >>  1 file changed, 9 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> >> index f9516121a036..af6ebd0ac0d6 100644
>> >> --- a/fs/ext4/file.c
>> >> +++ b/fs/ext4/file.c
>> >> @@ -576,8 +576,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>> >>  		iomap_ops = &ext4_iomap_overwrite_ops;
>> >>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>> >>  			   dio_flags, NULL, 0);
>> >> -	if (ret == -ENOTBLK)
>> >> +	if (ret == -ENOTBLK) {
>> >>  		ret = 0;
>> >> +		/*
>> >> +		 * iomap will never return -ENOTBLK if write fails for atomic
>> >> +		 * write. But let's just add a safety net.
>> >> +		 */
>> >> +		if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
>> >> +			ret = -EIO;
>> >> +	}
>> >
>> > Why can't the iomap code return EIO in this case for IOCB_ATOMIC?
>> > That way we don't have to put this logic into every filesystem.
>> 
>> This was origially intended as a safety net hence the WARN_ON_ONCE.
>> Later Darrick pointed out that we still might have an unconverted
>> condition in iomap which can return ENOTBLK for DIO atomic writes (page
>> cache invalidation).
>
> Yes. That's my point - iomap knows that it's an atomic write, it
> knows that invalidation failed, and it knows that there is no such
> thing as buffered atomic writes. So there is no possible fallback
> here, and it should be returning EIO in the page cache invalidation
> failure case and not ENOTBLK.
>

So the iomap DIO can return following as return values which can make
some filesystems fallback to buffered-io (if they implement fallback
logic) - 
(1) -ENOTBLK -> this is only returned for pagecache invalidation failure.
(2) 0 or partial write size -> This can never happen for atomic writes
(since we are only allowing for single fsblock as of now).

Now looking at XFS, it never fallsback to buffered-io ever except just 2
cases - 
1. When pagecache invalidation fails in iomap (can never happen for
atomic writes)
2. On unaligned DIO writes to reflinked CoW (not possible for atomic writes)

So it anyways should never happen that XFS ever fallback to buffered-io
for DIO atomic writes. Even today it does not fallback to buffered-io
for non-atomic short DIO writes.

>> You pointed it right that it should be fixed in iomap. However do you
>> think filesystems can still keep this as safety net (maybe no need of
>> WARN_ON_ONCE).
>
> I don't see any point in adding "impossible to hit" checks into
> filesystems just in case some core infrastructure has a bug
> introduced....

Yes, that is true for XFS. EXT4 however can return -ENOTBLK for short
writes, though it should not happen for current atomic write case where
we are only allowing for 1 fsblock. 

However given there are several places in EXT4 which has got fallback logic,
I would still like to go with a WARN_ON_ONCE where we are calling ext4
buffered-io handling for DIO fallback writes. This is to catch any bugs
even in future when we move to multi-fsblock case (until we have atomic
write support for buffered-io).

Thanks!
-ritesh

