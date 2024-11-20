Return-Path: <linux-fsdevel+bounces-35251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6279D31F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 02:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1372AB23D47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 01:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E9B22097;
	Wed, 20 Nov 2024 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2wZfub/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3CF848C;
	Wed, 20 Nov 2024 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732067077; cv=none; b=fHCFFP0ThzYYoSmCoK5vsQyMJ7J3Q9+DcfmadHMnEEaVHwkDZq2BTsIWA30HNgog8s9Y5RsZPXzlNOLkqoQgAakQ9k17nYzJIKLM5HF5vp0KDPZF9F3GfOLh5qm21T9TupYEyF7HOm6krIlz0VMpbOILWWmoJcNfHkJqZYHC3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732067077; c=relaxed/simple;
	bh=N4HiQB17Z3vYGECwOvk/cqK4Q/N0FyvBVoa3JW3io1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNlPqKTNHlQ2KIfXrtZzNMbYRegQm+ar7J4AOEMzoKxkmpicBO2GC+6KhGIzAll0YL0KtNUhSf5Dh1Ed4ZUUpLtHFPcBNkZw8tIIcw32+GIKsl6Pdqv491WkURlTNHlyUZ/x6Mf+fV2maZhHXvNaPYoplRJlbxtDt6O1QsmEK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2wZfub/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa4d257eb68so79428766b.0;
        Tue, 19 Nov 2024 17:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732067074; x=1732671874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGvpf6g4Dc68ipCf5V61ph+6g7GtAJ4EqxhkjvAMcog=;
        b=b2wZfub/quuXXiC068O4dgr7Y/T8GLoQZwxhNg3KN3G2Ml0p6mti4TU7hgc0LfJcVG
         icKfoKnLidhIJ96Zjlij35b/lSrjmjeLx51qF6a51B+uuQmQL1a4FJgMGOYNwiwaYmoe
         ahbYsg1d7zjgOqTPsSTFYvjpt7Kp1IzZl7wlXfax76BnEkOwe9QqoMi/OQjw9eaj+K4j
         DBgM7o44BS7CXqMWacK6xtrLUkjIdiksl9Mnqmz8yR4GqTyxCJ0fEsjPZBczbkZVd71U
         HAXxoCCBqr/tFSlm5LSWc9DEjI2utRV8XAuCTvd+h/XngOpOfvqiRxAL0OOFGhu6pjTb
         6sTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732067074; x=1732671874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGvpf6g4Dc68ipCf5V61ph+6g7GtAJ4EqxhkjvAMcog=;
        b=gKGemiCEiJHsodWoRvFvuOisP8w55SE5l/RxWpyaSHJad5g+R8spH9KDEK4JoA46z1
         dq/sU0xd5E02PbvpZBLcK5J2TS1GUG6X0yARcJye+JYGgUXOH4SCoTnhPCd/V/sQLKLX
         745EERKYidF74Tdo8v/r5V/ikU/9AIm5SdEF+gOkVl+VVWvxVZomW4Bv5nx51J1B3EFw
         AdeHvr6SaAa8PPdOWA8NtXdWx014QtFTynVeNFKMt/1DEKRmeQI6o6eRJIm7/Smc1+0Y
         PUtz2e0DGOQlCV6x6beoq2aKQal5TcbB8ec/b2yRGYuviHG4Rm55SuyJ4DIoluYCDfw3
         Kpug==
X-Forwarded-Encrypted: i=1; AJvYcCVzBtbdz+gND/UwUxBCWzznm7x7so36rifw2yqnbmBzdaa0YgDVUpaEOppfymoUFPFyQN5U7q+Ie328gDEd@vger.kernel.org, AJvYcCW06D1mv1oQB9XC6BpZa0+0/s2DSYqAItY2fX9nu46jo7WP6yxSqcVEl3qs6ciRz18wqF4zUB3m@vger.kernel.org, AJvYcCWvgvIKb6ChRpIpPMr+aCs6SN2woROCChgRGea97zOxmn9ylUXqIsd1Dttdr9KjL44jmxVD7+FvSvmXFnN5@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxs7VeBnurMt+3L190gyzvahERk3Y43BWV8ig0yYcp21BPnLn
	UMUNBPKYin1Pemni7FrlQ4UMcfs/O6dMx0u/FBD45s7R0c6xs4GW
X-Google-Smtp-Source: AGHT+IGBoA7jGj3ZbQLqM0Ioy2emYkiKyqr2G846rWjX+8AEUzPNGDRyNrQmgCtT+t93Skm6njTP0A==
X-Received: by 2002:a17:907:36ca:b0:a9e:d532:4cc7 with SMTP id a640c23a62f3a-aa4dca6e161mr97907466b.8.1732067073646;
        Tue, 19 Nov 2024 17:44:33 -0800 (PST)
Received: from f (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e043552sm708261766b.149.2024.11.19.17.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 17:44:32 -0800 (PST)
Date: Wed, 20 Nov 2024 02:44:17 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeongjun Park <aha310510@gmail.com>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: prevent data-race due to missing inode_lock when
 calling vfs_getattr
Message-ID: <3pgol63eo77aourqigop3wrub7i3m5rvubusbwb4iy5twldfww@4lhilngahtxg>
References: <20241117165540.GF3387508@ZenIV>
 <E79FF080-A233-42F6-80EB-543384A0C3AC@gmail.com>
 <20241118070330.GG3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118070330.GG3387508@ZenIV>

On Mon, Nov 18, 2024 at 07:03:30AM +0000, Al Viro wrote:
> On Mon, Nov 18, 2024 at 03:00:39PM +0900, Jeongjun Park wrote:
> > All the functions that added lock in this patch are called only via syscall,
> > so in most cases there will be no noticeable performance issue.
> 
> Pardon me, but I am unable to follow your reasoning.
> 

I suspect the argument is that the overhead of issuing a syscall is big
enough that the extra cost of taking the lock trip wont be visible, but
that's not accurate -- atomics are measurable when added to syscalls,
even on modern CPUs.

> > And
> > this data-race is not a problem that only occurs in theory. It is
> > a bug that syzbot has been reporting for years. Many file systems that
> > exist in the kernel lock inode_lock before calling vfs_getattr, so
> > data-race does not occur, but only fs/stat.c has had a data-race
> > for years. This alone shows that adding inode_lock to some
> > functions is a good way to solve the problem without much 
> > performance degradation.
> 
> Explain.  First of all, these are, by far, the most frequent callers
> of vfs_getattr(); what "many filesystems" are doing around their calls
> of the same is irrelevant.  Which filesystems, BTW?  And which call
> chains are you talking about?  Most of the filesystems never call it
> at all.
> 
> Furthermore, on a lot of userland loads stat(2) is a very hot path -
> it is called a lot.  And the rwsem in question has a plenty of takers -
> both shared and exclusive.  The effect of piling a lot of threads
> that grab it shared on top of the existing mix is not something
> I am ready to predict without experiments - not beyond "likely to be
> unpleasant, possibly very much so".
> 
> Finally, you have not offered any explanations of the reasons why
> that data race matters - and "syzbot reporting" is not one.  It is
> possible that actual observable bugs exist, but it would be useful
> to have at least one of those described in details.
> 
[snip]

On the stock kernel it is at least theoretically possible to transiently
observe a state which is mid-update (as in not valid), but I was under
the impression this was known and considered not a problem.

Nonetheless, as an example say an inode is owned by 0:0 and is being
chowned to 1:1 and this is handled by setattr_copy.

The ids are updated one after another:
[snip]
        i_uid_update(idmap, attr, inode);
        i_gid_update(idmap, attr, inode);
[/snip]

So at least in principle it may be someone issuing getattr in parallel
will happen to spot 1:0 (as opposed to 0:0 or 1:1), which was never set
on the inode and is merely an artifact of hitting the timing.

This would be a bug, but I don't believe this is serious enough to
justify taking the inode lock to get out of. 

Worst case, if someone is to handle this, I guess the obvious approach
introduces a sequence counter to be modified around setattr.  Then
getattr could retry few times in case of seqc comparison failure and
only give up and take the lock afterwards. This would probably avoid
taking the lock in getattr for all real cases, even in face of racing
setattr.

