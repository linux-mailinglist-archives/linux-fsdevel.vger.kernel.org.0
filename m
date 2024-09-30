Return-Path: <linux-fsdevel+bounces-30420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9CD98AE1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 22:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47ED1F2132D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 20:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288B51A2562;
	Mon, 30 Sep 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HNeoExnW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pWaiUOZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41651A0BDA;
	Mon, 30 Sep 2024 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727593; cv=none; b=Clsurp4wFQsOEuEXGnD2jzrCdQvXeadru2oB798sDlEfvgXW2/4hvAs8N7hYqC9iD7iG0N7tLRA5ZnIPCvFI2VhfIp7aQMULJlLJF+aOnX+W7JEPPvA3Odv6xz1UPEiQR+6oFA5VDaiVe5DpfarDvGqUaBGvmwG3ayrkab/6074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727593; c=relaxed/simple;
	bh=/ZZZZhhI1TbUcR+RJ3yp+CjtkFJLxY22I0UwfsZohRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BpAEwN8h8Hu+48vvq0JkA3YCgVmM0lnU6WfnZm/3AfhcyCzB77S8XKT490zhrh7C5rYvAKNYXg5+pxHy96O1OuYY7tzg8vI+Lc9UN9PJoBdRnXhJCkB4TesL2Xb8R8Qh4uqd/uij2DfK0qkQKG8ojywXQ4tTfSj8yVhKxAq8gI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HNeoExnW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pWaiUOZf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727727590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/LtJqKHUTSwVdWDJ6SYgdQJeD/iftK+N2Uf0ekJLtA=;
	b=HNeoExnW+oeHm7SmHkX8d15Zjdr1SoahHX+PJDVmShf5T/z5YcA0TiqBCQOjEF8tYPT0xV
	+h7/GwnkvGqj2U5N1jrgxe5nx+DrKTX4y9vGpHxjjCCrUhjsAmFS830XqfPnBg0orb2Wxe
	YjCyFSogq8d8lUU4ubbFZMv6OtODKOoxby8BzlO4uWuEB0WA/my5ow2Rs7eJh4s+BxVCVO
	jhz30M2OrYOzQtX2JV7VWwbBw+rTwzDiwh+dJutMHEdO/Uh6ttnbqu2mJbkXnKLwIV1zYA
	R9OUP+6ZugtygSRByLsPPx0hn+n2YeRxw1ayDN2TdiFuJwxqM8InVRi0fTxe7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727727590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/LtJqKHUTSwVdWDJ6SYgdQJeD/iftK+N2Uf0ekJLtA=;
	b=pWaiUOZf5GRjFO3neiTHp/w5ivxA1upXAxA68R6hb+7uEsv+m1y6j3FSGtGacutTgd6BfI
	5NPRzTiItvTDMMBw==
To: Jeff Layton <jlayton@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J.
 Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Chuck Lever
 <chuck.lever@oracle.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 01/11] timekeeping: move multigrain timestamp floor
 handling into timekeeper
In-Reply-To: <4933075b1023f466edb516e86608e0938de28c1d.camel@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
 <20240914-mgtime-v8-1-5bd872330bed@kernel.org> <87a5g79aag.ffs@tglx>
 <874j6f99dg.ffs@tglx>
 <b300fec8b6f611662195e0339f290d473a41607c.camel@kernel.org>
 <878qv90x6w.ffs@tglx>
 <4933075b1023f466edb516e86608e0938de28c1d.camel@kernel.org>
Date: Mon, 30 Sep 2024 22:19:49 +0200
Message-ID: <87y138zyfu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 30 2024 at 15:37, Jeff Layton wrote:
> On Mon, 2024-09-30 at 21:16 +0200, Thomas Gleixner wrote:
> I have the following section in the multigrain-ts.rst file that gets
> added in patch 7 of this series. I'll also plan to add some extra
> wording about how backward realtime clock jumps can affect ordering:

Please also add comments into the code / interface.

> Inode Timestamp Ordering
> ========================
>
> In addition to providing info about changes to individual files, file                          
> timestamps also serve an important purpose in applications like "make". These                       
> programs measure timestamps in order to determine whether source files might be                     
> newer than cached objects.                                                                          
>
> Userland applications like make can only determine ordering based on                                
> operational boundaries. For a syscall those are the syscall entry and exit                          
> points. For io_uring or nfsd operations, that's the request submission and                          
> response. In the case of concurrent operations, userland can make no                                
> determination about the order in which things will occur.
>
> For instance, if a single thread modifies one file, and then another file in                        
> sequence, the second file must show an equal or later mtime than the first. The                     
> same is true if two threads are issuing similar operations that do not overlap                      
> in time.
>
> If however, two threads have racing syscalls that overlap in time, then there                       
> is no such guarantee, and the second file may appear to have been modified                          
> before, after or at the same time as the first, regardless of which one was                         
> submitted first.

That makes me ask a question. Are the timestamps always taken in thread
(syscall) context or can they be taken in other contexts (worker,
[soft]interrupt, etc.) too?

Thanks,

        tglx

