Return-Path: <linux-fsdevel+bounces-63279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F8FBB3E73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 14:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42163A1535
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 12:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CADA310625;
	Thu,  2 Oct 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NkaVyv68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3FC12B94
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408510; cv=none; b=oEbtKP93Wz8Iz1gcryqyDPLlfQd9t+0Abg1oy7q+E60C6p3GOvZzIwc9cr/klVhdK+vuWo8Haro2D4W+63PVIVgS2c9I+3GNYHi46OW9WIQX8IjEGhqYTlO6MzXZwliqOMyf1dalSsUgWJNu8rWVxr1vLFUESRlhX80sJdLg1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408510; c=relaxed/simple;
	bh=JTx5FlyjYa7LzF/e5F/Cry2bbB/O/kxLix4Q7uBhEHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBDiVeLkPBcGYisIWLuA4FDJf7PZ3F96TaoZK3dHbqsbUGXmRapeGsTZk3ANhOgeXtElEtR70MXHIHfe0s8oIl8GcT/ULKm1XMqNIrnUUgQzJg7gyH4vn/pRtQq9sP5AvBMBd4citL9RqbX7lYLt7OFuEL7ZJvdPuw1MElR6Nh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NkaVyv68; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=DsZwV+SkLjeMnXSWNdOq5i0meOUEvqjADp4h1noMWs4=; b=NkaVyv68x4cS9m6jVkwnXK+//G
	9wWXyxJEVSHFkXkmEbPlB+mS9ZO9TSxIukq9mGweTE9XfsJsYVvWWx2RLN5WuePrq3iXq4iN+c6+q
	8Ao9r5GA2lGaIs0xdKql8YXrrG2KDbSwopQLySaYfPmnmpu8g12otJickEgZJGrs7TXSppVo3gu5W
	qFNgPrg6Zns9BzNo7g3jcF0bwZBfJEenVNuAhsGcUv7ooh3JCla75Ef3g6M3MM2pv1YsxEjnIMuk5
	Kp0VmVDGgrpL6uwBFtblG3tSvaEmU1D/u+vTo2Y8CYN5Xvvjk5pU74EON5JmDUOlrsGiTiDJh7sto
	l3raTiSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4IWX-00000000Q3U-2RTB;
	Thu, 02 Oct 2025 12:35:05 +0000
Date: Thu, 2 Oct 2025 13:35:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miroslav =?utf-8?B?Q3JuacSH?= <mcrnic@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: shrink_dcache_parent contention can make it stall for hours
Message-ID: <20251002123505.GM39973@ZenIV>
References: <CAD8Qqac-3Oss=M4aU0B_gKCzBhuUo0ChH+8wFkWDPz=mQVqSiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD8Qqac-3Oss=M4aU0B_gKCzBhuUo0ChH+8wFkWDPz=mQVqSiQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Oct 02, 2025 at 12:54:38PM +0100, Miroslav Crnić wrote:

> Option 1:
> Don't differentiate between work stealing and own work.
> Collect items for work stealing in the disposal list along with regular items.
> Fight out the contention per item with try_lock and continue through the list.

Currently disposal list is modified only by the thread that has created it;
which lock (if any) do you have in mind for protecting those?

> Option 2:
> Change shrink_dcache_parent to collect a dispose list for one unique parent.
> Split out unlinking from parent from __dentry_kill.
> Run over the disposal list in 2 passes.
> First pass does everything except unlink parent.
> Second pass does all unlinking under a single parent->d_lock grab.

Do you mean dentry_unlist()?  The problem is, how do you prevent those parents
looking inexplicably busy?  Cross-fs disposal list existing in parallel with fs
shutdown is very much possible; shrink_dcache_for_umount() should quietly steal
everything relevant from that and move on, leaving the empty husks on the
list to by freed by list owner once it gets to them.

