Return-Path: <linux-fsdevel+bounces-35712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DEC9D77AC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 20:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA64B360AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 17:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2B013C9A3;
	Sun, 24 Nov 2024 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z15ZQpyV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD92136338;
	Sun, 24 Nov 2024 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471032; cv=none; b=dX2KWUoT5QIIh8MUzPm4y3t9iyKbEVJbhDukSiwo9kCp84qYkXvcPBBmhOYA1DUe2YrOP3aAraRkvoKhcJN9dvK3HIGtIld5TDCfJxl7me0THCRN10vzM2H9GzC4Hfw9FU22xPN6FszQoNr0hmMaJI9fHvA1p12xnTwPCCVnFMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471032; c=relaxed/simple;
	bh=ubOwint+3PmjNJ0preXeyEidlcfvtrj0m5hTebbcIIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibFZ/+Tpme4sTIWW/z3+LAyGTlXTO0wt5R6giSw3/qJQE3hfIYGgzN6Pwom6JbeY4h90NKVz29zbkK47pWvI8P2SWJ2Ah83M/WfKrwVnbQ3keD8aCtTR9LodAdtu372oDC4qmJSeBT4CqA/VyaQu2yRWsewPlA4NTYXI963Sz2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z15ZQpyV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso4816088a12.3;
        Sun, 24 Nov 2024 09:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732471029; x=1733075829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/Sbe5hmOJDMXdPSuXWaoL3oWZV0YgB+btzyAOk0TiU=;
        b=Z15ZQpyVHg7HV67RbDVRp4j+LRUFuhNlqwOs6GzRXiXDX0J6axws0gEr0HXX/kkFXx
         SlGzZsIYrvWwKjieYyFgTcMMYv6JsYXaRzsXHfpH0dcP1s8vynxqyJUKKPFE6S70SqdF
         K7n6X6FmFe12lrSIHvZbmekQ6ebILoXuSU9uxT0sE6NUg6z3S8OLwuHUz9j23KKQuQ6k
         +AAqBBWZVilDy8OJzA3zs3EtUUj6WhWG9liBPXXrajyv4QcK/Dqq29t6+GbUan7G4nnW
         KU//9DGjlRn6McDud+1LXzUprpRCdOdv+sLZHKzzJ9WQEQx3+6izdQX9cA2jKr9kRxb7
         LjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732471029; x=1733075829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/Sbe5hmOJDMXdPSuXWaoL3oWZV0YgB+btzyAOk0TiU=;
        b=qYmf93C4J02MV3B+Pb8ojNx+DZXjG04UPJOaZ8cQgoBxXguuptBEI3Gu82U4pVpvFl
         5g3dvl5dG6JhwdIvtADo6ZFs7WIk7+RpPq6e+Qh8wdJV8tuXw9UqC9rHLLVjYIMFhlr0
         O/HqOV/gt/aA+Aik2I1SCN+sF/kD66567kvPOwWef5inzWAMNQfgb3JVg3RjYBBxncKE
         NKM27Tp/4usYGZU5B5O4OfGAKnJ+cYVpWm8nbcgszKY8hPvEb6c5q5pz5Uxtik+qk7UN
         uXyA3/A3so008M3fuhrS3aWR/S7/4/rNkQyLzV0X91o2kbRvRo5eHbny5nOTvwoU3azW
         ganA==
X-Forwarded-Encrypted: i=1; AJvYcCUgqZCYz/ar80pFX61qFLGk8enk9R2Rc3n0gIqwY50six8DC3GxZdaBhpWai21yA9bjhA13vTNonynQMDoh@vger.kernel.org, AJvYcCVNAi2fekIL71yV9NjRFBcDclx6GOmibgWgb8tLtArZ3Bi+9mK/gStLms/IePOHw0XD0eRFn3Ozi5wRMGZr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hxjnhcQLnyB4GtOXY1iiaP+XA04k6Gh2rRTqj3YEO2Q123pY
	DS1md7Dllq0BZlSP1dHhT9XOgRzWvivn4tYFxOxV3hzrmCllwIaQ
X-Gm-Gg: ASbGnct3ApB7PS27PFQ1QFOOfrxurrmBwWp5UsEpEdPALt+IcGnZa26jJ3NktA+2mn2
	zfEez8RjEJVk5UeIUop5n6tsTbsbt4Io4dIAmaC7HWG56aGVZP6Dmpp5HoQuRBQHv7O1kqW/eQm
	2vBWSKeNVnbMyLXcViRC55XTnNIGJ1O2BtuhZjgr0XErARSLevTYjHUzCBDld8ELQrZwyqkAYhl
	UXMsI3rIO5HWZv3wV1aOnhJ55tpUWeRE+1tGc2A+o1EfF9IzM2mG3nrrNI/AyPv3w==
X-Google-Smtp-Source: AGHT+IEO+Ym8QUPf8bvZo+LgcayoPLKPXcc7knyY9L6gjnqH8GV0APt/CPFfPn0Q0MnOcykg4+BjKg==
X-Received: by 2002:a05:6402:2347:b0:5cf:9e5:7d20 with SMTP id 4fb4d7f45d1cf-5d02060d320mr8316807a12.17.1732471028496;
        Sun, 24 Nov 2024 09:57:08 -0800 (PST)
Received: from f (cst-prg-93-239.cust.vodafone.cz. [46.135.93.239])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b0b1fsm3228940a12.32.2024.11.24.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 09:57:07 -0800 (PST)
Date: Sun, 24 Nov 2024 18:56:57 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Subject: Re: [PATCH v4] fs: Fix data race in inode_set_ctime_to_ts
Message-ID: <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241124174435.GB620578@frogsfrogsfrogs>

On Sun, Nov 24, 2024 at 09:44:35AM -0800, Darrick J. Wong wrote:
> On Sun, Nov 24, 2024 at 05:42:53PM +0800, Hao-ran Zheng wrote:
> > A data race may occur when the function `inode_set_ctime_to_ts()` and
> > the function `inode_get_ctime_sec()` are executed concurrently. When
> > two threads call `aio_read` and `aio_write` respectively, they will
> > be distributed to the read and write functions of the corresponding
> > file system respectively. Taking the btrfs file system as an example,
> > the `btrfs_file_read_iter` and `btrfs_file_write_iter` functions are
> > finally called. These two functions created a data race when they
> > finally called `inode_get_ctime_sec()` and `inode_set_ctime_to_ns()`.
> > The specific call stack that appears during testing is as follows:
> > 
> > ============DATA_RACE============
> > btrfs_delayed_update_inode+0x1f61/0x7ce0 [btrfs]
> > btrfs_update_inode+0x45e/0xbb0 [btrfs]
> > btrfs_dirty_inode+0x2b8/0x530 [btrfs]
> > btrfs_update_time+0x1ad/0x230 [btrfs]
> > touch_atime+0x211/0x440
> > filemap_read+0x90f/0xa20
> > btrfs_file_read_iter+0xeb/0x580 [btrfs]
> > aio_read+0x275/0x3a0
> > io_submit_one+0xd22/0x1ce0
> > __se_sys_io_submit+0xb3/0x250
> > do_syscall_64+0xc1/0x190
> > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > ============OTHER_INFO============
> > btrfs_write_check+0xa15/0x1390 [btrfs]
> > btrfs_buffered_write+0x52f/0x29d0 [btrfs]
> > btrfs_do_write_iter+0x53d/0x1590 [btrfs]
> > btrfs_file_write_iter+0x41/0x60 [btrfs]
> > aio_write+0x41e/0x5f0
> > io_submit_one+0xd42/0x1ce0
> > __se_sys_io_submit+0xb3/0x250
> > do_syscall_64+0xc1/0x190
> > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > To address this issue, it is recommended to add WRITE_ONCE
> > and READ_ONCE when reading or writing the `inode->i_ctime_sec`
> > and `inode->i_ctime_nsec` variable.
> 
> Excuse my ignorance, but how exactly does this annotation fix the race?
> Does it prevent reordering of the memory accesses or something?  "it is
> recommended" is not enough for dunces such as myself to figure out why
> this fixes the problem. :(
> 

It prevents the compiler from getting ideas. One hypothetical is
splitting the load from one asm op to several, possibly resulting a
corrupted value when racing against an update

A not hypothethical concerns some like this:
	time64_t sec = inode_get_ctime_sec(inode);
	/* do stuff with sec */
	/* do other stuff */
	/* do more stuff sec */

The compiler might have decided to throw away the read sec value and do
the load again later. Thus if an update happened in the meantime then
the code ends up operating on 2 different values, even though the
programmer clearly intended it to be stable.

However, since both sec and nsec are updated separately and there is no
synchro, reading *both* can still result in values from 2 different
updates which is a bug not addressed by any of the above. To my
underestanding of the vfs folk take on it this is considered tolerable.

