Return-Path: <linux-fsdevel+bounces-49320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F23FABAA7A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 15:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6355A1B6315D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA8F1EB182;
	Sat, 17 May 2025 13:43:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234281FFC62
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 May 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747489434; cv=none; b=M9F5bAvWAiO4R6eNvEEZiZd9lEFGboPNSQGVLf4KMoT9XKwJThXPMWSwTcmXlfzXJs93OKZI/Wvt4dAIUw7iekUhyPW2u8ENr7j32y2p27PeSnHWqzEZJig6fr79d5I0SlaJOQkkV06dIe4Sqs916MJPp/UuOK9QnhqTVlzPrsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747489434; c=relaxed/simple;
	bh=F2o5V94rw2wBjPmWdsTmdrsvluyqrPSyGsk7WcBbEPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYA1MhNwafIFQcVwcDFSOR7+9AhW1kwsJs2eFGkB4//04lmYGxIRlZYbJEkmeWh84oBGWwuNNC2eWYZBfhdfwsGVGFV0by04wXcjvwpeFIAsmnvWon7WaO6mtwvyGCQMNLNVIuxmG1fVC0Z+TD3aR2+m0tUh2CHoECxDYeOv1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Sat, 17 May 2025 09:43:51 -0400
From: Rich Felker <dalias@libc.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20250517134351.GZ1509@brightrain.aerifal.cx>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516142024.GA21503@mit.edu>
 <bsvslfjgcmzvcanxp3ay6ohitqulwuawwgzy234nfkj6ecdxbq@2uhld4vpitou>
 <qthuiudgbwuxh4bwwpcvpbosqrz6rl4js46atvenhmujkbjnz4@crakvrigxnz6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qthuiudgbwuxh4bwwpcvpbosqrz6rl4js46atvenhmujkbjnz4@crakvrigxnz6>
User-Agent: Mutt/1.9.5 (2018-04-13)

On Sat, May 17, 2025 at 03:03:52PM +0200, Alejandro Colomar wrote:
> Hi,
> 
> On Sat, May 17, 2025 at 07:46:48AM +0200, Alejandro Colomar wrote:
> > Hi Ted, Rich,
> > 
> > On Fri, May 16, 2025 at 09:05:47AM -0400, Rich Felker wrote:
> > > FWIW musl adopted the EINPROGRESS as soon as we were made aware of the
> > > issue, and later changed it to returning 0 since applications
> > > (particularly, any written prior to this interpretation) are prone to
> > > interpret EINPROGRESS as an error condition rather than success and
> > > possibly misinterpret it as meaning the fd is still open and valid to
> > > pass to close again.
> 
> BTW, I don't think that's a correct interpretation.  The manual page
> clearly says after close(2), even on error, the fd is closed and not
> usable.  The issue I see is a program thinking it failed and trying to
> copy the file again or reporting an error.

The authoritative source here is POSIX not the man page, assuming
you're writing a portable application and not a "Linux application".

Until the lastest issue (POSIX 2024/Issue 8), the state of the fd
after EINTR was explicitly unspecified, and after other errors was
unspecified by omission. So there is no way for a program written to
prior versions of the standard to have known how to safely handle
getting EINPROGRESS -- or any error from close for that matter.
Really, the only safe error for close to return, *ever*, is EBADF. On
valid input, it *must succeed*. This is a general principle for
"deallocation/destruction functions". Not an explicit requirement of
this or any standard; just a logical requirement for forward progress
to be possible.

> On the other hand, as Vincent said, maybe this is not so bad.  For
> certain files, fsync(2) is only described for storage devices, so in
> some cases there's no clear way to make sure close(2) won't fail after
> EINTR (maybe calling sync(2)?).  So, maybe considering it an error
> wouldn't be a terrible idea.

Whether data is committed to physical storage in a way that's robust
against machine faults is a completely separate issue from whether
it's committed to the abstract storage. The latter happens at the
moment of write, not close.

If an application is trying to ensure that kind of robustness, the
return value of close is not the tool. It needs the Synchronized IO
interfaces (fsync, etc.) or something specific to whatever it's
writing to.

Rich

