Return-Path: <linux-fsdevel+bounces-15950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FE08961F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 03:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E8B1C233C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 01:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D3134BD;
	Wed,  3 Apr 2024 01:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxH8p3fM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E09D29B;
	Wed,  3 Apr 2024 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107613; cv=none; b=l6L9ArZNqnATDw5d4QDqScsylJFY8FrbwgQHDGsFupRymYtGvhq8AygWfS1HBpIBQWHq/jqGBo1QvFqkHzVWRg4rtu418NrE8PB+dp0N3tGmOGZ9GmdGP4wnPjC43WtciCW5MnipjnL79728g1xO6H9zuSNr4usi/NkMPNMjB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107613; c=relaxed/simple;
	bh=mF+2sS0dgEpJGvcfOshVPrnAcb2zqkRLy1L+aLs61AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjJClZB297iCTmsC8q5uYcr15MbgKuwbf1mjjhpq+ap9ZLXvIH4jaCIuicOCVzPG6rZ8noTSlvFvqma03G+dtijxbNYjBw6wTE+B+cz0/uBVoqgz1ZwgldbDUakgM69LipHiAFMnZY1PksXOCpKX072ZZ/04wItosD0GoiUWNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxH8p3fM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44785C433F1;
	Wed,  3 Apr 2024 01:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712107613;
	bh=mF+2sS0dgEpJGvcfOshVPrnAcb2zqkRLy1L+aLs61AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxH8p3fMxBq9C+iYnlgbQvwT1lcPUjGJ+Mp7j+s2as1K/B6K5dxTJyzN9iN/a+hzj
	 +Wf8A/v4kKkxi6FoWDq0RWWyMVmQpj6Ueuj9X1UTJxlmryPcVsDLwmpyvp/wcftU+5
	 6C9F4BfXmoJiOhEAUuTkRrGCrLJIYXhkd5NoXe48T5T9ybw6jTEh9k+VZ5R3tbdh23
	 wfBo4/VisSLRlAz4h2eGipnvDWPYHPfUGbT0LKtTyZwLoPUAR7EoYlLIYxOzylCzAH
	 3Uht2hX9HXBCZXXpPgl6L7mfTXYQsBFDFDuqaspICrdBg/G9GPpOos5X8Yk/ebSEXa
	 stK8u3/PXvSFA==
Date: Tue, 2 Apr 2024 18:26:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 27/29] xfs: make it possible to disable fsverity
Message-ID: <20240403012652.GE6390@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175869006.1988170.17755870506078239341.stgit@frogsfrogsfrogs>
 <20240402232510.GA2576@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402232510.GA2576@sol.localdomain>

On Tue, Apr 02, 2024 at 04:25:10PM -0700, Eric Biggers wrote:
> On Fri, Mar 29, 2024 at 05:43:06PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create an experimental ioctl so that we can turn off fsverity.
> 
> The concept of "experimental ioctls" seems problematic.  What if people start
> relying on them?  Linux tends not to have "experimental" system calls, and
> probably for good reason...

They're trapped in my enormous backlog of patches.  They get this
special treatment so that I can show them to developers without anyone
getting any fancy ideas about merging them.  Once I get close enough to
actually consider merging it, I'll move it out from under EXPERIMENTAL.

IOWs: I'm not planning to push xfs_fs_staging.h itself to upstream ever.

> Also, what is the use case for this ioctl?  Is it necessary to have this when
> userspace can already just replace a verity file with a copy that has verity
> disabled?  That's less efficient, but it does not require any kernel support and
> does not require CAP_SYS_ADMIN.

No, of course it isn't needed if replacing the file is easy.  That
however assumes that replacing /is/ easy.

The use case for this is: "I enabled fsverity on my backup volume so I
could detect bitrot, then the primary disk died, and when I went to
restore the primary, I got a verity error."

Being able to read known-bad corrupted contents are less bad than losing
the entire file or having to do surgery with xfs_db to turn off
fsverity.

Just for my own convenience, this would enable me to try out fsverity in
a few places while being able to undo it quickly if <cough> we end up
changing the ondisk format during review.

> And of course, if do we add this ioctl it shouldn't be XFS-specific.

Yes, this is a proof of concept.  I'd lift it to fs/verity/ if you
accept the premise.

--D

> - Eric
> 

