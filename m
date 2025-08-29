Return-Path: <linux-fsdevel+bounces-59617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EF1B3B42B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E727C35E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 07:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4780A266B66;
	Fri, 29 Aug 2025 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="IikUcDRV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C035979;
	Fri, 29 Aug 2025 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452105; cv=none; b=k0y+12fWR4M/37Z6A8uTfyAEOYT42hClz4YW+iZ1N4yaVIJvq/dnxz4EnkYcifxvCGrNKhtXF0DWMfxiQKC+qAjJewhjfoRKkQ0zIW3QkyBYqUZnLxXAXJjHYa9+jwwzr26UJKxaENRotmuxDDIhij/c/s1kcxHhjKAsoGsVgPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452105; c=relaxed/simple;
	bh=oqVHI2UBMStAajDRIlceskz5ydoQHOLrTzIz/X1hNpQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WZgANhRnI3jb7Oye0qXMMqbBCqfNJpWrhuInbkmzoJ2HQPJW7QGYNQeQUbReBmhNRgUz7JXR+fwYTSMXEfnkodOu6AXxwwa6+RMkzpOxEKkUhEVNcaCLO+i/0MK7Kn9rjL8iRkJvLUUqDC8hrIlyhnPy8ARgF8e5HJEKirzefzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=IikUcDRV; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id 0349340643CD;
	Fri, 29 Aug 2025 07:21:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0349340643CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756452098;
	bh=6Jb3CbdCmBG5Slw/XWnsXEM6FgT6h4sR5vQX2aLIUmc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IikUcDRVjO9UgCWMlfiIMW3m8firaicgXgugoA8zRl2TP+iCCnOl71z4f6zufe83w
	 FPVacgZ3saz30ERYg0ZRVfNQtxmi6/86jx0ZL7CSTU46E1nYf9u5lZIqpIRwH0p007
	 TcFBhcn/btQ8CQ3QFdzRf7c8A2ZWCo1nULGYYuOw=
Date: Fri, 29 Aug 2025 10:21:35 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: linux-fsdevel@vger.kernel.org
cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
In-Reply-To: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
Message-ID: <5a4513fe-6eae-9269-c235-c8b0bc1ae05b@ispras.ru>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Wed, 27 Aug 2025, Alexander Monakov wrote:

> Dear fs hackers,
> 
> I suspect there's an unfortunate race window in __fput where file locks are
> dropped (locks_remove_file) prior to decreasing writer refcount
> (put_file_access). If I'm not mistaken, this window is observable and it
> breaks a solution to ETXTBSY problem on exec'ing a just-written file, explained
> in more detail below.

The race in __fput is a problem irrespective of how the testcase triggers it,
right? It's just showing a real-world scenario. But the issue can be
demonstrated without a multithreaded fork: imagine one process placing an
exclusive lock on a file and writing to it, another process waiting on that
lock and immediately execve'ing when the lock is released.

Can put_file_access be moved prior to locks_remove_file in __fput?

Alexander

