Return-Path: <linux-fsdevel+bounces-18731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B3F8BBCBC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 17:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6491F21A18
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D194433C3;
	Sat,  4 May 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TZ6mwWsd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669163EA9B;
	Sat,  4 May 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714836777; cv=none; b=ZkPD2wchNgSoTsLOuXwnaU/xkPItn2c2QLdK7ZVTOQe4hLkC570VzxrJ9c2OWPKs6Wd/AcOz4OjvNavmbjG28Lx4IBW2fvCGGf5F+tcjMZ5rS1rKHKN6BZrnze1C9+J0HXBKBfPnLjZhEPbj91DwMnGzVGvcluHuq0YWvCgX/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714836777; c=relaxed/simple;
	bh=W1KYPkox8fkNsg4FzwVivBA9xyKYIfqdEtzwYk7j8dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh9oqnRlImtFykcUm3jjhlR4ryRF3FJLjS6qXwcY5/vlBKlHEsUsLWy9T8JodKjsQqSGdu59oCTU8/EBCMIfclQ77MYs7GfzztrOXNaY36XZlpAlMwUvFrRcB7GwhPz0biaaVp8hSHT6TQjJUALfdIdl6yrc0MNIpLysX+QsIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TZ6mwWsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785E2C072AA;
	Sat,  4 May 2024 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714836776;
	bh=W1KYPkox8fkNsg4FzwVivBA9xyKYIfqdEtzwYk7j8dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZ6mwWsdpO8tPgqajyyjyguNSqGMytj1NkC+qrcAA0JSWWpPfe2SpyL+TxXKbUtWF
	 JPHxRWsmylBL2E0BpXufoXTL0XJqSE6sJkHN1GshLFgv4bRm5mghdHE1gouZE6ONR9
	 tFk2hgMi/F8dviXNhoSAXLir9gODlgYuhGxYEWGw=
Date: Sat, 4 May 2024 17:32:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
Message-ID: <2024050425-setting-enhance-3bcd@gregkh>
References: <20240504003006.3303334-1-andrii@kernel.org>
 <20240504003006.3303334-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504003006.3303334-6-andrii@kernel.org>

On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> I also did an strace run of both cases. In text-based one the tool did
> 68 read() syscalls, fetching up to 4KB of data in one go.

Why not fetch more at once?

And I have a fun 'readfile()' syscall implementation around here that
needs justification to get merged (I try so every other year or so) that
can do the open/read/close loop in one call, with the buffer size set by
userspace if you really are saying this is a "hot path" that needs that
kind of speedup.  But in the end, io_uring usually is the proper api for
that instead, why not use that here instead of slow open/read/close if
you care about speed?

> In comparison,
> ioctl-based implementation had to do only 6 ioctl() calls to fetch all
> relevant VMAs.
> 
> It is projected that savings from processing big production applications
> would only widen the gap in favor of binary-based querying ioctl API, as
> bigger applications will tend to have even more non-executable VMA
> mappings relative to executable ones.

Define "bigger applications" please.  Is this some "large database
company workload" type of thing, or something else?

thanks,

greg k-h

