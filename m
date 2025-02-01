Return-Path: <linux-fsdevel+bounces-40533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE4A24871
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 12:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD631889528
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E614E1547DC;
	Sat,  1 Feb 2025 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="Eb0cA8mC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998117BD6;
	Sat,  1 Feb 2025 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738407785; cv=none; b=ukdKf6wMjVCzF1AY5Dt79l1sdOmEA7o3heBaCLj6I6TZ0VKosDqZ70GMtJ2DTWRO29Jl2psRIGZGERcwrgvxMBKL8P/R2tH9HVY5SR8mr/mdm46uSgwMmfAy0+4vnnxyh1uiFDayJGGKBjgKMgcNA/qLGPrqViXbyIMR2iCCsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738407785; c=relaxed/simple;
	bh=pR9s0IQyvMWtNefe0ZwhuFBEehDQVrZLPbNEAKkKVQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S81bE3CSjMxHKk9E6S0yejeQaWnG3Ky+iR4ekW5wsl32hESUiXi9q2/q1xSnB261lL2sUOuY0jiY/TH3CU++sdhnp9jaXPyXw0e2AcrTIaGBPj6FCKvFbOzcC4e3PM/GjvUvtwa87dHw3KOKooTmr8az212JLLQbSgHQn7z/C+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=Eb0cA8mC; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id AD4EF1771FC; Sat,  1 Feb 2025 11:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1738407782; bh=pR9s0IQyvMWtNefe0ZwhuFBEehDQVrZLPbNEAKkKVQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eb0cA8mCXrFU1vO08vcIs1pX0mNHeyDNfAfPfImRFDkYnI3zX/SIZFEzWLwax3Rnu
	 Dm6LemNN4Nm4vjx+LBe7gkSHZ0RhDIEAucGL/SXVpVRGI/YW4aKUHm7cpkXJvkjPWe
	 MYHemQcwpMdX2RjegxIQMqi6CHQLpNA0MF3kTAADJgTTEC4kreoPfJGvA2e9Knk06C
	 Q63JR3DPKeQTBFHa8WhKhrJ9gST4Q5AnODSz/3/jW6mz2Nf4Oc180TMMLKSlbqrGqw
	 7LhoJ6/t/URcNMH5REklux0Zqa9ocxKBOY9d+Lya9JGFxxAZCCmlLTJXVfsNXpXLEz
	 EQz4yY8QVXj4w==
Date: Sat, 1 Feb 2025 11:03:02 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Kees Cook <kees@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: remove redundant save asides of old pid/vpid
Message-ID: <20250201110302.GA1186433@lichtman.org>
References: <20250201083127.GA1185473@lichtman.org>
 <0B25310A-0907-481E-8ADF-EEFA78927BFF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0B25310A-0907-481E-8ADF-EEFA78927BFF@kernel.org>

On Sat, Feb 01, 2025 at 01:40:00AM -0800, Kees Cook wrote:
> 
> 
> On February 1, 2025 12:31:27 AM PST, Nir Lichtman <nir@lichtman.org> wrote:
> >Problem: Old pid and vpid are redundantly saved aside before starting to
> >parse the binary, with the comment claiming that it is required since
> >load_binary changes it, though from inspection in the source,
> >load_binary does not change the pid and this wouldn't make sense since
> >execve does not create any new process, quote from man page of execve:
> >"there is no new process; many attributes of the calling process remain
> >unchanged (in particular, its PID)."
> 
> See commit bb188d7e64de ("ptrace: make former thread ID available via PTRACE_GETEVENTMSG after PTRACE_EVENT_EXEC stop")
> 
> This is for making sense of a concurrent exec made by a multi threaded process. Specifically see de_thread(), where the pid *can* change:
> 
>  /*
>   * At this point all other threads have exited, all we have to
> 	 * do is to wait for the thread group leader to become inactive,
> 	 * and to assume its PID:
> 	 */
> 
> The described problem in the commit hasn't changed, so this code needs to stay as-is. Or perhaps the comment could be improved?

Thanks for answering, interesting, I'll take a deeper look.

Nir

