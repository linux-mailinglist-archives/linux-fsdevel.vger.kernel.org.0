Return-Path: <linux-fsdevel+bounces-59641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4210BB3B88F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 12:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3165814A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BD03081C3;
	Fri, 29 Aug 2025 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="gjB6ybqP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB5283FD4;
	Fri, 29 Aug 2025 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462641; cv=none; b=APIcklY3cMjPuGBx0YgGIeWRHvhedalRgD2KoGi1STnbuEJcQoj05iDZVF3/J9khLa3d7WbrKgQBMHztTLpqAdLj8bkuG/66iEA0/SepAVIbQqkALbI8LTyd87tcFAumwvh6mdBW8uTMZnFrASYuueqBqKQIISeU0NKa0Wfd74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462641; c=relaxed/simple;
	bh=wam/Y26M80XwjZ9JoBeabBQC//hceNoh75ThsWsgTQM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M0xV0v+JEXC6WXwBuQ3IxhJBS6LEkDIAGOr+KAT5Me3J7EfIAhwNx2T1uJ2puTLTU2oHC/n4V41H7IJzyftTcbdA8OLkoevSRx6RjxPpl0OM+TIZK9uHMF4hBWYtNa+54Zp71IGJRuHYJNY1lYEQnANX+5IugH5OlppMaN6CX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=gjB6ybqP; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id 63AAF40643CD;
	Fri, 29 Aug 2025 10:17:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 63AAF40643CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756462636;
	bh=YsN/3O9bmVvZqYNWpDVo0gQHiB6LeFFfhDcrL+DxSIE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gjB6ybqPCzNjwxtuSXZHUielMU9nbIYvBhx+3Q15wN3YCqDOwvaT+ktH0KUQYWVXH
	 TCQpSawbMcvvgRO0DMZVkVpQBmqJ6/olR8uh/cTKJ+k9YIvDOnQt2A6iXfJp9jvdK0
	 M1ujnqZp4Gop6Afcs1KxPfQvJ9n4zFM09X3/fPnU=
Date: Fri, 29 Aug 2025 13:17:16 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Christian Brauner <brauner@kernel.org>
cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
In-Reply-To: <20250829-diskette-landbrot-aa01bc844435@brauner>
Message-ID: <e7110cd2-289a-127e-a8c1-f191e346d38d@ispras.ru>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru> <5a4513fe-6eae-9269-c235-c8b0bc1ae05b@ispras.ru> <20250829-diskette-landbrot-aa01bc844435@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Fri, 29 Aug 2025, Christian Brauner wrote:

> On Fri, Aug 29, 2025 at 10:21:35AM +0300, Alexander Monakov wrote:
> > 
> > On Wed, 27 Aug 2025, Alexander Monakov wrote:
> > 
> > > Dear fs hackers,
> > > 
> > > I suspect there's an unfortunate race window in __fput where file locks are
> > > dropped (locks_remove_file) prior to decreasing writer refcount
> > > (put_file_access). If I'm not mistaken, this window is observable and it
> > > breaks a solution to ETXTBSY problem on exec'ing a just-written file, explained
> > > in more detail below.
> > 
> > The race in __fput is a problem irrespective of how the testcase triggers it,
> > right? It's just showing a real-world scenario. But the issue can be
> > demonstrated without a multithreaded fork: imagine one process placing an
> > exclusive lock on a file and writing to it, another process waiting on that
> > lock and immediately execve'ing when the lock is released.
> > 
> > Can put_file_access be moved prior to locks_remove_file in __fput?
> 
> Even if we fix this there's no guarantee that the kernel will give that
> letting the close() of a writably opened file race against a concurrent
> exec of the same file will not result in EBUSY in some arcane way
> currently or in the future.

Forget Go and execve. Take the two-process scenario from my last email.
The program waiting on flock shouldn't be able to observe elevated
refcounts on the file after the lock is released. It matters not only
for execve, but also for unmounting the underlying filesystem, right?
And maybe other things too. So why not fix the ordering issue in __fput
and if there are other bugs breaking valid uses of flock, fix them too?

Alexander

