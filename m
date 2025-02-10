Return-Path: <linux-fsdevel+bounces-41420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 372E7A2F480
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A451887029
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01CA24F5A7;
	Mon, 10 Feb 2025 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLdwuFKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C66256C88;
	Mon, 10 Feb 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206850; cv=none; b=tIiuWcRnQmzrISkho8fEWJlFdt5TRbIIBhsEfP814r/KGFTkbUdcQ27PiAH4eLkD0YY3HlPz+lAY0uyQEVaouAudbzLHh3T1q5I5r+iBerilKd2aSwEz7pkoiL4jQ2qx0no9vl6DtKgGC788UBrPEvk11GwgOY+9fiUDTpsB5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206850; c=relaxed/simple;
	bh=tpsTov6Qr/s5OOulL+UdOsWM2lAtGYCZxb/IGeVYfOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvZ7B/lDcw9XxMpV+rnbSjLliDvbjB76CqdK4FTod6xUWgWB6IjkzIiaStCXyRjUwGcVbQ4PewvHK6wPIQm9FkhC3BuvawkHF9CyYAXfE1H0+DPHKnBoPktH16V9OJYBcNJA7rTjVJP/temi/HVqNtXOb8jy6Oq8DpUhqnQBOA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLdwuFKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70775C4CEE5;
	Mon, 10 Feb 2025 17:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739206849;
	bh=tpsTov6Qr/s5OOulL+UdOsWM2lAtGYCZxb/IGeVYfOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLdwuFKfXyQYohVa5/G0tTRg6Koz6o8MJ0B3SPXOH3WjJTcE8wOX9ogcbysaONH6O
	 NvIDNmOvJu+h7qhw7Shh/0hRivKcrP2ri4yhbXYEFLZHJlHmk5aRc9xmNNK6iD4UQv
	 7SNBm27KcvwtFaVVePvTIx6eC7KX6c4QHKmIwRGRAU7sx4iXGdd5KD5ZvylYUkBbZ8
	 K+M+5vmeXJeDuG/AdJAix0fhxM86Lga74z3pr4GmcGN0TH66qGwJdVm1WzwrvqF4ET
	 gY6KtdW7Qm/jvO4kM7/0fI7HzYqigY+mHLyxheqOmz7uGXprnNyGtkQS2WCzl6jYis
	 JpJKNhQaveRZw==
Date: Mon, 10 Feb 2025 17:00:47 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z6owv7koMsTWH1uM@google.com>
References: <20250117164350.2419840-1-jaegeuk@kernel.org>
 <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
 <Z4qmF2n2pzuHqad_@google.com>
 <Z4qpurL9YeCHk5v2@casper.infradead.org>
 <Z4q_cd5qNRjqSG8i@google.com>
 <Z6JAcsAOCCWp-y66@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6JAcsAOCCWp-y66@google.com>

On 02/04, Jaegeuk Kim wrote:
> On 01/17, Jaegeuk Kim wrote:
> > On 01/17, Matthew Wilcox wrote:
> > > On Fri, Jan 17, 2025 at 06:48:55PM +0000, Jaegeuk Kim wrote:
> > > > > I don't understand how this is different from MADV_COLD.  Please
> > > > > explain.
> > > > 
> > > > MADV_COLD is a vma range, while this is a file range. So, it's more close to
> > > > fadvise(POSIX_FADV_DONTNEED) which tries to reclaim the file-backed pages
> > > > at the time when it's called. The idea is to keep the hints only, and try to
> > > > reclaim all later when admin expects system memory pressure soon.
> > > 
> > > So you're saying you want POSIX_FADV_COLD?
> > 
> > Yeah, the intention looks similar like marking it cold and paging out later.
> 
> Kindly ping, for the feedback on the direction. If there's demand for something
> generalized api, I'm happy to explore.

If there's no objection, let me push the change in f2fs and keep an eye on
who more will need this in general.

