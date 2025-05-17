Return-Path: <linux-fsdevel+bounces-49319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7DCABAA69
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1CD9E73D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005491FFC5B;
	Sat, 17 May 2025 13:33:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2941EB182
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 May 2025 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747488781; cv=none; b=sxsRCzJ0UBVa+M+t1tDpqjqtwxo4J/eZBAARViO3o8P6SeJRLe4GReQEWkIIwIFFS3tUIRSuI/jA3jlxFsYomBcS5wylufDSs9VD6djKKh3kbv1IeYXt9qsFf4dgXa81GHBBD/O//iD4SkCdLzAl06VquqfRqEJsmF3sGqvPyts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747488781; c=relaxed/simple;
	bh=7Uiu5sok/IPJVqCc0NMlN2qCwME8WRs10Rp2Ksstdh0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9DyMEPEhVxfaUxoMUyGTtfvhsDHMNskZe6lWyQoI0gT08TV+0fknJ3TU3RI0ysz7BLUgug7yit44O3uudnAZMZ3lmSiar7tSaqixjWx9DpChrGFeClwqr/ER1wrKCp5bRPGpiUa2K+sV+EFWZg0TXNTPjWiWf23lArEGlM/tb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Sat, 17 May 2025 09:32:52 -0400
From: Rich Felker <dalias@libc.org>
To: Vincent Lefevre <vincent@vinc17.net>,
	Alejandro Colomar <alx@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20250517133251.GY1509@brightrain.aerifal.cx>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516143957.GB5388@qaa.vinc17.org>
User-Agent: Mutt/1.9.5 (2018-04-13)

On Fri, May 16, 2025 at 04:39:57PM +0200, Vincent Lefevre wrote:
> On 2025-05-16 09:05:47 -0400, Rich Felker wrote:
> > FWIW musl adopted the EINPROGRESS as soon as we were made aware of the
> > issue, and later changed it to returning 0 since applications
> > (particularly, any written prior to this interpretation) are prone to
> > interpret EINPROGRESS as an error condition rather than success and
> > possibly misinterpret it as meaning the fd is still open and valid to
> > pass to close again.
> 
> If I understand correctly, this is a poor choice. POSIX.1-2024 says:
> 
> ERRORS
>   The close() and posix_close() functions shall fail if:
> [...]
>   [EINPROGRESS]
>     The function was interrupted by a signal and fildes was closed
>     but the close operation is continuing asynchronously.
> 
> But this does not mean that the asynchronous close operation will
> succeed.

There are no asynchronous behaviors specified for there to be a
conformance distinction here. The only observable behaviors happen
instantly, mainly the release of the file descriptor and the process's
handle on the underlying resource. Abstractly, there is no async
operation that could succeed or fail.

> So the application could incorrectly deduce that the close operation
> was done without any error.

This deduction is correct, not incorrect. Rather, failing with
EINPROGRESS would make the application incorrectly deduce that there
might be some error it missed (even if it's aware of the new error
code), and absolutely does make all existing applications written
prior to the new text in POSIX 2024 unable to determine if the fd was
even released and needs to be passed to close again or not.

Rich

