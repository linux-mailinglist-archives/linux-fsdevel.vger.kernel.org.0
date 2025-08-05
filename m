Return-Path: <linux-fsdevel+bounces-56775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885B8B1B78E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 17:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AAF18242E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F5B242D9D;
	Tue,  5 Aug 2025 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FyNtfuhQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE683CD1;
	Tue,  5 Aug 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408103; cv=none; b=Yk+KKAhI772w0p4TCYTeUlNnv0Q5sztvXvcTV1OzZL6cvkMplTE87N0vnWONIbmJ4Jk5gdk2siDlJkL2NT5Mb9v3lwqSOqRRMPaVKrJ2vQ3DOnASlNnSPBaFUMm6Mj5XYgrnIgOmAYzAGExT6+NGL0jRJcc2GBhFHmteIomF9J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408103; c=relaxed/simple;
	bh=XK6HZ5uluC/yLeVprkG4TH9P18HkPbS+rBUFfOfvsrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgI+3oGsPZdv7bPmqu/W9nv6t5ZOKkbHqEk8F91CoO7hEWON8yjsUZKT6CEVsZWpTwoX6hwACmo7jBvkeQ+o7HM7+hr8dYoe/CUO7mx4+9JMtyzwtrxzRcAykP6HX9ROsEr6MAPMUsE1mMMw7dTWwvM5d8AoI/nKMAF2pgJo/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FyNtfuhQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e3EEufs82epJ/gvfFHbwXvJf/cUrVUPjug1lfJYmV2w=; b=FyNtfuhQb/6XxNOdYClktcW3IR
	Ny1cHqKl5RwZP/k+WaYXuqrrHX5G0us3pon2kgHOJv6uCUzeQubObabJasL40EzzrAGCW/8rCYEx9
	DWoDDt4aUEKyAhCARrr4CK3MO0KrZeFc0FLsDKMEGXFrbm0MdL7cwfIxUcgJzobhCNuP+K3joScFC
	o+Q27MurGlT61g5Eawzp/DgcBTgasu9lyJLR0r3BCl2DT6z4FqsFjTbCMvAno7P7JUgGFIH0QtDy+
	+wz7mdt3qUNy5DVaWeNGFj19vA6hQSuXjF1b1Qfz7WpBlh5LZKt6xmUPl8/c9VtVs9h5GFBgQwSQn
	yj2joE1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujJgn-00000004CjA-2YFG;
	Tue, 05 Aug 2025 15:34:57 +0000
Date: Tue, 5 Aug 2025 16:34:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Jan Kara <jack@suse.cz>, Sargun Dhillon <sargun@sargun.me>,
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs: always return zero on success from replace_fd()
Message-ID: <20250805153457.GB222315@ZenIV>
References: <20250804-fix-receive_fd_replace-v2-1-ecb28c7b9129@linutronix.de>
 <20250804-rundum-anwalt-10c3b9c11f8e@brauner>
 <20250804155229.GY222315@ZenIV>
 <20250805-beleidigen-klugheit-c19b1657674a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805-beleidigen-klugheit-c19b1657674a@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 05, 2025 at 01:55:59PM +0200, Christian Brauner wrote:

> The calling conventions of do_dup2() are terrible. The only reason it
> drops file_lock itself instead of leaving it to the two callers that
> have to acquire it anyway is because it wants to call filp_close() if
> there's already a file on that fd.

Alternative calling conventions end up being nastier - I've tried.

> And really the side-effect of dropping a lock implicitly is nasty
> especially when the function doesn't even indicate that it does that in
> it's name.
> 
> And guards are great.

They do no allow to express things like "foo() consumes lock X".
From time to time, we *do* need that, and when that happens guards
become a menace.

Another case is
	lock
	if (lock-dependent condition)
		some work
		unlock
		work that can't be under that lock
	else
		some other work
		unlock
		more work that can't be under that lock

Fairly common, especially when that's a spinlock and "can't be under that
lock" includes blocking operations.  Can't be expressed with guards, not
without a massage that often ends up with bloody awful results.

