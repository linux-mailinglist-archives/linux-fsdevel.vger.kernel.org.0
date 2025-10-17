Return-Path: <linux-fsdevel+bounces-64453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15031BE8164
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65324505FB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D6311C3A;
	Fri, 17 Oct 2025 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fWi1v8hN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072D31064E;
	Fri, 17 Oct 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697388; cv=none; b=noevPh2EteEqXXj9KRKSflCXeZsnAyOmGAKwTSxHiTOjVKjWTVSGRP4/oITVsm/42uKXDRxlglUD7PvLKHBynAxdoa/sWF1GS3tYc6u0JCJBVvnJxtxPymw0i4tNTNYQifuY1zi+0tHPmYk376nKF4SRaIPi29Y0q660uIHYv1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697388; c=relaxed/simple;
	bh=DJ2Eal9c2IfaoDNTZlkIgXr5gbRYlBIk/L81n8p0tTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drFERyHyQg655GySWSY2QRqSBihMbfzQQJWZ/NkAsFO/yH+jnh2cSIev3cDRKZHabIhw7IU+JWHv+lPp5NVnSIMBYBjzq7YShhX0QKAvAFGPoRv4bt5W+ZvZo0O1Y7U9zAp9kTa9KjUg5OzbhQLWtZKDklpue+5VKOac2GlckCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fWi1v8hN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0hEYjK4XGVjCrvoOJeg0ZEh8+ica9r/qK/NZKGu0EA4=; b=fWi1v8hNQkssTp7wPTCPBDiNCW
	tjfosPU8LE2dZl3bBZZN83/L6douPhSRNHcYuF//L/0kQ6A3xLfHaa9fw9YSKULC9TDbDeBzFd5QT
	o5Y82LuzrMqrLzagAtt7nAxLS5vsJ06A9OcTR+2If2BEi6ybOAste9RRdfttxtW/w32Vs6JeNYEA9
	OfmnYJcY3uH2+LkO4EeXq9GrtctUlvK8lELPMnbD2ITa7k/xEDDTaGg4sB1quZswTO2o5KohK6S8z
	XGmg8eH28de1pujpSKSj+enhHUebEceGs0B++WfyKTTQuwVClbwH0B4LxCPim6iwiepl0M2k279wY
	LdnPU2uA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9hoR-00000007TnX-3lDP;
	Fri, 17 Oct 2025 10:36:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E92A630023C; Fri, 17 Oct 2025 12:35:54 +0200 (CEST)
Date: Fri, 17 Oct 2025 12:35:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [patch V3 12/12] select: Convert to scoped masked user access
Message-ID: <20251017103554.GY4067720@noisy.programming.kicks-ass.net>
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.570048808@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093030.570048808@linutronix.de>

On Fri, Oct 17, 2025 at 12:09:18PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace the open coded implementation with the scoped masked user access
> guard.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> ---
> V3: Adopt to scope changes
> ---
>  fs/select.c |   12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> ---
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -776,17 +776,13 @@ static inline int get_sigset_argpack(str
>  {
>  	// the path is hot enough for overhead of copy_from_user() to matter
>  	if (from) {
> -		if (can_do_masked_user_access())
> -			from = masked_user_access_begin(from);
> -		else if (!user_read_access_begin(from, sizeof(*from)))
> -			return -EFAULT;
> -		unsafe_get_user(to->p, &from->p, Efault);
> -		unsafe_get_user(to->size, &from->size, Efault);
> -		user_read_access_end();
> +		scoped_masked_user_rw_access(from, Efault) {

Should this not be: scoped_masked_user_read_access() ?

> +			unsafe_get_user(to->p, &from->p, Efault);
> +			unsafe_get_user(to->size, &from->size, Efault);
> +		}
>  	}
>  	return 0;
>  Efault:
> -	user_read_access_end();
>  	return -EFAULT;
>  }
>  
> 

