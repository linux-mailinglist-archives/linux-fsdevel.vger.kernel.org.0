Return-Path: <linux-fsdevel+bounces-49281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A04D1ABA02C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 17:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B4C7BAF80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE7F1C5D5A;
	Fri, 16 May 2025 15:44:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA518DF6D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410267; cv=none; b=HZboaln69pcHMsshCUDKAjfALCzeL9o0Ju4lhaZPoim/pv5gwt7ETwyWf8uCwyQlnknIoKic0vHvMpZ7/cMYqOtF6eng4OOKxRRvxKIZFwTykko/2P3xpl6wR++9SwFXrdKgyAqHRl5V8wVm+G+MLxP2DNObxpiAdaicZt58Hb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410267; c=relaxed/simple;
	bh=iNYqyExplFOXrADfmsoivCAAgxTPdETepSc+5F/Cl9o=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnVKN2+Kcg0nKY50ElSt5io8KK/OpleA2L2vW94UxA5W4CovQENL5ZA1SNsY8jEXCaXrOqigmHL8ZE2dlaESHlDVksTErkrlmENSUv9MeXDhuvpSYMCKfqIscYO7IjveRtZeff2AOFkVtGsbbHLpvZX9pK9v8xxjwe9f5V9/K9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Fri, 16 May 2025 11:28:08 -0400
From: Rich Felker <dalias@libc.org>
To: Vincent Lefevre <vincent@vinc17.net>,
	Alejandro Colomar <alx@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20250516152808.GW1509@brightrain.aerifal.cx>
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

It always succeeds in the way that's important: the file descriptor is
freed and the process no longer has this reference to the open file
description.

What might or might not succeed is:

(1) other ancient legacy behaviors coupled to close(), like rewinding
a tape drive. If the application cares how that behaves, it needs to
be performing an explicit rewind *before* calling close, when it still
has a handle on the open file so that it can respond to exceptional
conditions, not relying on a legacy behavior like "close also rewinds"
that's device-specific and outside the scope of any modern
cross-platform standard.

(2) deferred operations in unsafe async NFS setups. This is a huge
mess with no real reliable solution except "don't configure your NFS
to have unsafe and nonconforming behaviors in the pursuit of
performance".

Rich

