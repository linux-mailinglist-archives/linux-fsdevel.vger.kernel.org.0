Return-Path: <linux-fsdevel+bounces-36048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B799DB29D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 06:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD6AB2283F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 05:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D923C142624;
	Thu, 28 Nov 2024 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF5ATNJ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1356134BD;
	Thu, 28 Nov 2024 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732773036; cv=none; b=IbNhNxRY7hMTihUrv7BuNbiDsXHGf39UHpXa5rduJ5j7ynY5h6WhLuHz9arxNoz+xa3bGr3jvepl7oHihJqakCuuNgUZ8YqerFb5TLnKUDWi7EI36A9WLrSi6BHCUt9ZdCU7FAoj2hLPzAqKsGyjfrkZZCHfGowZ6Gc3ozE7fdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732773036; c=relaxed/simple;
	bh=jy02W4fUSO/ynBhM1FmXmxBPyqudopqiVK8oLXZwHgY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=Uu16RnZ9wzWHSmfGjQpm2F06NOuXieJTcdAxW5+VeUyQh3kqzAUvvcdYOtPq2LL9kwKwBHTeNxPOjtF0VninVIJS2z0fJPp+iGq3sFwvb6fHrswK8uDDKECO6f5O833Xzm+MV7fZg48o4neeF//Id7PEnzggZhAbebgChjJPKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF5ATNJ7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2eb1433958dso352003a91.2;
        Wed, 27 Nov 2024 21:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732773034; x=1733377834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLjeQx75L3lYmciLRB+c43uodhAABK8j/Hm5E1oeO90=;
        b=ZF5ATNJ7vivdlYfQlTUkIEigKH4qkCiW7aoX1AVt6N28sFMqTwNzAwsrwPtTm3cR4F
         0uv2olTsxREnCg5v9V30ptbMQybhrUXPr9K19lNbxa9EKm9xGXiswRbUsP4tK7N54ycv
         5lf+QlxsMLBcBeMy/HqsdFy5dT2w+OYidO5qSy+AYrToGDOHZXSiTFRsxX6FZ5N4kFdp
         XGNcVil/+XXLRYw5BR5KINCvMXBWH9DxxdWpvstgB27O4izcBLn/rXV8+SLHjXAAx7k2
         +pKqgdjtFp5akFjIY+oY99PiQXXjRvZ6lc81G2KiUmjjWY/a5PRCfvzlAkoBVhfcF6Gg
         Z5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732773034; x=1733377834;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLjeQx75L3lYmciLRB+c43uodhAABK8j/Hm5E1oeO90=;
        b=kFGdU+6v6b+ObHoQc6h9hQGbhCBC0dLolrAoRkLBG1WJzWW5+zsPkSjRY/ooninF7o
         F22z/s0hIZN3PwPB32UIWBW8smxBYakREFfZdNsUmwG8zCVzeSK6mFlejycKMFNYmPh3
         a+Rxo13FC3aVK/slJpBPJxnddp1ezdQNSIGD9USuihVcHIQzPtU1rjo9NLhZKoDLBz2G
         dqOlNc6GY0dHZk2fYpUOPTkcEh3Kwcj/hkO8akzeNTcHaC6Ai2CYKgYnpHWOC2tBA26k
         WhUcvP4xUK9GRdLOQiIfK4qMf+wIdZ5vigNCm1NsQgDEzVrVkB4P1eGZNYL+2mCtk/Wb
         9uPg==
X-Forwarded-Encrypted: i=1; AJvYcCUD6GnKTwsC2ATMjK8JZGXScEn8EikyMspCw8pLyT1YfRB/akyxeFM0EUKAMzZuKz1A6BacEqg9CxXyPDMG@vger.kernel.org, AJvYcCUYYbupx0JUr+OHtT0V7lLwIIas0/4h4lwIIjfrKg47L/pJYS1a9Vt3KcKV4WBUkud+nAJKCLFRfCwISg==@vger.kernel.org, AJvYcCVU78qt0RIccRNDXBKd6/yw8PKYXlWqX4rb+Qf+z6hwXNCR5urku0SzeI7hq3eBSrMRuRSC6DVVdEg+Nyc2CA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/0DraHbpDjQHVqeBFfZ/fssKGzxWLfeg9I8Z0mM6QRSzDzJd
	Tcy9n7/tqEyOmdeXxCf4ds7avMP1sE63iFVeZkwpd1YfsN5pS6VD
X-Gm-Gg: ASbGncsnE+V6uZw1DyMoLVzzy3tE0PW9Tx/CCH8Kynxn6Td80Y7T6WcGpPJe2fLUSqC
	sONv2sq+esH1MyBpjD1FpYQFu5u/VIklxfgqwoNi4zk5UNS9QvVQ+1j7FuCJvRVTtlkSc0RP5Ze
	JUYo4d9GZ6zTyDHP5mSUmXlqlPTtZsZHfrV17X68evV8cBKchRhSjaJwF9BNjIpPsT211QA5fPR
	paG6M6XM80KBaaSUshjCKGFa7JAR4VlhvpR3LNZg0U=
X-Google-Smtp-Source: AGHT+IGvcaRwwg7Z6lX7Dj/twWMoZA67eSUPjEvK6r1tl4fqPwjizLPoPiL2oxPD3RSEg5ww+ZcLUQ==
X-Received: by 2002:a17:90b:4b82:b0:2ea:7329:46 with SMTP id 98e67ed59e1d1-2ee08e9f0c6mr8602080a91.5.1732773033915;
        Wed, 27 Nov 2024 21:50:33 -0800 (PST)
Received: from dw-tp ([171.76.82.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2b22dd01sm588999a91.27.2024.11.27.21.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 21:50:33 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>
Cc: Bharata B Rao <bharata@amd.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nikunj@amd.com, willy@infradead.org, vbabka@suse.cz, david@redhat.com, akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, joshdon@google.com, clm@meta.com
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
In-Reply-To: <20241127120235.ejpvpks3fosbzbkr@quack3>
Date: Thu, 28 Nov 2024 11:10:35 +0530
Message-ID: <87plmf3oh8.fsf@gmail.com>
References: <20241127054737.33351-1-bharata@amd.com> <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com> <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com> <20241127120235.ejpvpks3fosbzbkr@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jan Kara <jack@suse.cz> writes:

> On Wed 27-11-24 07:19:59, Mateusz Guzik wrote:
>> On Wed, Nov 27, 2024 at 7:13 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
>> >
>> > On Wed, Nov 27, 2024 at 6:48 AM Bharata B Rao <bharata@amd.com> wrote:
>> > >
>> > > Recently we discussed the scalability issues while running large
>> > > instances of FIO with buffered IO option on NVME block devices here:
>> > >
>> > > https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/
>> > >
>> > > One of the suggestions Chris Mason gave (during private discussions) was
>> > > to enable large folios in block buffered IO path as that could
>> > > improve the scalability problems and improve the lock contention
>> > > scenarios.
>> > >
>> >
>> > I have no basis to comment on the idea.
>> >
>> > However, it is pretty apparent whatever the situation it is being
>> > heavily disfigured by lock contention in blkdev_llseek:
>> >
>> > > perf-lock contention output
>> > > ---------------------------
>> > > The lock contention data doesn't look all that conclusive but for 30% rwmixwrite
>> > > mix it looks like this:
>> > >
>> > > perf-lock contention default
>> > >  contended   total wait     max wait     avg wait         type   caller
>> > >
>> > > 1337359017     64.69 h     769.04 us    174.14 us     spinlock   rwsem_wake.isra.0+0x42
>> > >                         0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
>> > >                         0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
>> > >                         0xffffffff8f39e7d2  rwsem_wake.isra.0+0x42
>> > >                         0xffffffff8f39e88f  up_write+0x4f
>> > >                         0xffffffff8f9d598e  blkdev_llseek+0x4e
>> > >                         0xffffffff8f703322  ksys_lseek+0x72
>> > >                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
>> > >                         0xffffffff8f20b983  x64_sys_call+0x1fb3
>> > >    2665573     64.38 h       1.98 s      86.95 ms      rwsem:W   blkdev_llseek+0x31
>> > >                         0xffffffff903f15bc  rwsem_down_write_slowpath+0x36c
>> > >                         0xffffffff903f18fb  down_write+0x5b
>> > >                         0xffffffff8f9d5971  blkdev_llseek+0x31
>> > >                         0xffffffff8f703322  ksys_lseek+0x72
>> > >                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
>> > >                         0xffffffff8f20b983  x64_sys_call+0x1fb3
>> > >                         0xffffffff903dce5e  do_syscall_64+0x7e
>> > >                         0xffffffff9040012b  entry_SYSCALL_64_after_hwframe+0x76
>> >
>> > Admittedly I'm not familiar with this code, but at a quick glance the
>> > lock can be just straight up removed here?
>> >
>> >   534 static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
>> >   535 {
>> >   536 │       struct inode *bd_inode = bdev_file_inode(file);
>> >   537 │       loff_t retval;
>> >   538 │
>> >   539 │       inode_lock(bd_inode);
>> >   540 │       retval = fixed_size_llseek(file, offset, whence,
>> > i_size_read(bd_inode));
>> >   541 │       inode_unlock(bd_inode);
>> >   542 │       return retval;
>> >   543 }
>> >
>> > At best it stabilizes the size for the duration of the call. Sounds
>> > like it helps nothing since if the size can change, the file offset
>> > will still be altered as if there was no locking?
>> >
>> > Suppose this cannot be avoided to grab the size for whatever reason.
>> >
>> > While the above fio invocation did not work for me, I ran some crapper
>> > which I had in my shell history and according to strace:
>> > [pid 271829] lseek(7, 0, SEEK_SET)      = 0
>> > [pid 271829] lseek(7, 0, SEEK_SET)      = 0
>> > [pid 271830] lseek(7, 0, SEEK_SET)      = 0
>> >
>> > ... the lseeks just rewind to the beginning, *definitely* not needing
>> > to know the size. One would have to check but this is most likely the
>> > case in your test as well.
>> >
>> > And for that there is 0 need to grab the size, and consequently the inode lock.
>> 
>> That is to say bare minimum this needs to be benchmarked before/after
>> with the lock removed from the picture, like so:
>
> Yeah, I've noticed this in the locking profiles as well and I agree
> bd_inode locking seems unnecessary here. Even some filesystems (e.g. ext4)
> get away without using inode lock in their llseek handler...
>

Right, we don't need an inode_lock() for i_size_read(). i_size_write()
still needs locking for serialization, mainly for 32bit SMP case, due
to use of seqcounts.
I guess it would be good to maybe add this in Documentation too rather
than this info just hanging on top of i_size_write()?

References
===========
[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/locking.rst#n557
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/fs.h#n932
[3]: https://lore.kernel.org/all/20061016162729.176738000@szeredi.hu/

-ritesh

