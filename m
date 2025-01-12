Return-Path: <linux-fsdevel+bounces-38955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08523A0A6E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 02:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BD11685A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 01:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E27B9475;
	Sun, 12 Jan 2025 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2mPPjZLr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832F79E1
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736647002; cv=none; b=lkzyuO0hjUUG5Y1LjttiyMzbRioXBYk2U9hF1QwDS/BMgv+/dJIBBdVD9Y5yNWmC/ZAqbVYI6vJnOvfdGrLxjXnSe0di+t4EQ/ftvTt2BZo68cHWja66Qhy48yZp/8xKFU1V7/J2sePSOW0ey+6qpfq67h6P/67OMCGvL1NIw/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736647002; c=relaxed/simple;
	bh=TZB+2j3/THwvV16Z+j97is2AGz+IU7FhelneY6Omtg0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mUUkRJWtnrpIx+0+FN06yfVNQkqVIbNEctWD+xPeq86zM2yHyxPyL/gLrS1Rsyjm1UKMVjqUmf9MzRg9cHYDhAG3cfgnOYtjnpamLfDgpkQRMCJwTDj7sQsvE+zRfRkSYKG8bMjKMQoUVQQd78fLTAx1Zd8OwNhbwl57eNLqXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2mPPjZLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B6AC4CED2;
	Sun, 12 Jan 2025 01:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736647002;
	bh=TZB+2j3/THwvV16Z+j97is2AGz+IU7FhelneY6Omtg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2mPPjZLrIVWTedJ2K8spZdw98oYiL5/IObV6vYUROD2N/uy1PQKmNqUjlrzGo0lb5
	 s55S5HevFl2PkVC2QcftVkpeXWDjSGdji1qmGZqQfje3A4vDIXLzVP8NwQPUoWx7f+
	 YnF8DhYRsnv+azubt25XHIeFhiE+FwDJz7Rq4Xek=
Date: Sat, 11 Jan 2025 17:56:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Phillip Lougher
 <phillip@squashfs.org.uk>, squashfs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] squashfs: Fix
 "convert squashfs_fill_page() to take a folio"
Message-Id: <20250111175641.5bbfdc297e85c7a6ef185327@linux-foundation.org>
In-Reply-To: <Z4KxSBcKpwwr-WF2@casper.infradead.org>
References: <20250110163300.3346321-1-willy@infradead.org>
	<20250110163300.3346321-2-willy@infradead.org>
	<b9ce358d-4f67-48be-94b3-b65a17ef56f9@arm.com>
	<Z4KxSBcKpwwr-WF2@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 17:58:32 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, Jan 11, 2025 at 01:21:31PM +0000, Ryan Roberts wrote:
> > On 10/01/2025 16:32, Matthew Wilcox (Oracle) wrote:
> > > I got the polarity of "uptodate" wrong.  Rename it.  Thanks to
> > > Ryan for testing; please fold into above named patch, and he'd like
> > > you to add
> > > 
> > > Tested-by: Ryan Roberts <ryan.roberts@arm.com>
> > 
> > This is missing the change to folio_end_read() and the change for IS_ERR() that
> > was in the version of the patch I tested. Just checking that those were handled
> > separately in a thread I'm not CCed on?
> 
> https://lore.kernel.org/mm-commits/20250109043130.F38E0C4CED2@smtp.kernel.org/

I have this as a fix against a different patch: "squashfs: convert
squashfs_copy_cache() to take a folio"

> https://lore.kernel.org/mm-commits/20250110232601.CBE47C4CED6@smtp.kernel.org/

I queued this separately as a hotfix, without cc:stable.  I guess it
didn't really need that urgency, but wrong code is wrong.

> Shouldn't be anything missing; I applied the first one to my tree,
> then wrote the second one and the third one you're replying to.  Then
> I did a git diff HEAD~3 and sent the result to you to test.
> 
> Has anything gone wrong in this process?

I don't think so.

