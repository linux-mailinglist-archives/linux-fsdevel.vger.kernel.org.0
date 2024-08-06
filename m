Return-Path: <linux-fsdevel+bounces-25116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D83949436
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BF81C208BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284F1EA0CB;
	Tue,  6 Aug 2024 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p7zU6Joe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83701EB4AD
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956909; cv=none; b=tZ8T3DWcdrpbyJ7gFKZXfRfoGxFYYFoq2pzZGw6/csDRG/mqGKPrAaP9HfU1BmYbvcG5umPLqL5T0vowvLyCCZ+pQe2uYt9EmZVqMd/DPvpQ3lCRFaa2oTW4cj6HzGicrH07/uaduUurRySeS/62HHtOxC7iRBZMGE3CiskAibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956909; c=relaxed/simple;
	bh=iaWE9yu8hrA6OKKP7vL8RFYXB4urzVh94GvHVMuIRK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uL5rXHRae484UebYyi7K39R5GjQb0LBoAOBVxAtPNmIeMwJDPmQ10HKdN6ZxkE5kvraxNpCDqWnVEZC+elfuNiVfRy52NQf1JvIUWtlQn1HKcI07F36NMzKNsYoyVPRc/a8fcgdwrHrioSfhIg9bwybnb/08pbNR110VT/lhrD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p7zU6Joe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uLWMF6OsdQgWbPb68OYzp4I8hAoNLjPzPFIk6wDNkl4=; b=p7zU6Joey1Ki4h2kYb2eRJ3elh
	vkxCuBEGwaEOPjfpU2o7tWocoLuOYgH0nT36zBbwZyNr4S3HPxw7zW1Xc+V3y++GPJvOfCmDHrtFl
	XwaLjeovJvAzYjhyXbz/FAFs31bI8BWQtc+KgdOC37BNrPesanOAoiSdo/900HxyRtJ6wiGX7DpUC
	VXncJdRKEjFr8sFiR2W1RAgnXvyI0i8474gaGMquedKhsg71yTxvAfBt9peGszRCPQx2EBWtX5Z11
	xfK/fM29Q/knWQm6iCcTSbKKrOWeuROBAaJV+BrHQElAzT22JgroDQwE9ZLlMs8tEpTW1BjcnjVau
	YnQpRU7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLnP-00000005suz-02Nn;
	Tue, 06 Aug 2024 15:08:19 +0000
Date: Tue, 6 Aug 2024 16:08:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
Message-ID: <ZrI8YlBhacGFN2Ao@casper.infradead.org>
References: <20240804080251.21239-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804080251.21239-1-laoar.shao@gmail.com>

On Sun, Aug 04, 2024 at 04:02:51PM +0800, Yafang Shao wrote:
> One solution we're currently exploring is leveraging the preadv2(2)
> syscall. By using the RWF_NOWAIT flag, preadv2(2) can avoid the XFS inode
> lock hung task. This can be illustrated as follows:
> 
>   retry:
>       if (preadv2(fd, iovec, cnt, offset, RWF_NOWAIT) < 0) {
>           sleep(n)
>           goto retry;

But that's not how you're supposed to use RWF_NOWAIT!  You're supposed
to try it _once_ in the thread that can't block, then hand the I/O off
to another thread which _can_ block.  Because that single thread is the
one which does all the blocking I/O, there's no lock contention.

So this is a kernel workaround for bad application design, and should
be rejected.

