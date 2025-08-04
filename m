Return-Path: <linux-fsdevel+bounces-56664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B82B1A6F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 18:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9C9178CE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2B126CE1A;
	Mon,  4 Aug 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sa/NacXS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z2OWHsxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC926B760;
	Mon,  4 Aug 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323367; cv=none; b=nyXc16wTLsFJ/7+AMenMDfWHJtbneTIqgDPwlNh6yVjl6IV+E04xlPrELj2bwrBJaJ+DZEAiK5DSc4QAV19U8SyVKGwkgq4WrIf42pTHYFbrRTre/kBogxyeo9OfOqISeAdPcZwCNpgVMKWXtmHXYnhS3Rl+Bmir96Yanr9clus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323367; c=relaxed/simple;
	bh=3upPUktO+09VnFtkDqW5LFxgZiwKK8ouU4yZc9vM3Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugW9/7OskAlqbWy0Iil7omh9Yw7Jw7LfoUXrDRe4Fkcqpbjp5fZ6YoSKM89W8TvpUk383VOyzxhBVMKHSnViWdZfwL1lzO0sS5lbX4ldnS5Ql4e8JAty9EqEVqIlO0Cf/3xKNFfO/9wkqPthutHH/H4cU/l8ezxmvKgt3usPkyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sa/NacXS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z2OWHsxc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 4 Aug 2025 18:02:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754323364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1xjRfaGiRJyV9n1qkZp3LNENeNHzx2QQkGJp0VfPu04=;
	b=sa/NacXSWKrozCvK1UW7n0KTpAzvD7igIwEoHaJqwal0ukzW1WHEG5VepZWrDK9Rjz0utB
	WlwsaO2AhsH0y/hf3rhOLqO/8ChSmibvuDcBHU3A/8mn9izh4/oNreeo3eO2R8YpojAHNn
	S6DbL+4NtM3X3CLLL/+lqvjALPLz5hFGJ/+xcu/Q5ZtQP36LuhChW9yGaKOPG1DsRzYt6g
	cWv+Wv9Fm6+FgmFjra3XZ83I0kb7ZmeO39riaDYdVr7W+Ypb6kq7bi72RPBc5kjPfU9jKh
	FT4oJOSF/jHBCchtdoUDazPEQqo53LlsDg7d5yL8qmESAVj5bOxryhdX/Mns2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754323364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1xjRfaGiRJyV9n1qkZp3LNENeNHzx2QQkGJp0VfPu04=;
	b=z2OWHsxcvSXgw8i4jF6W9XEoYROn9jF6P/fq6KRuaz8eIzpMBczmePRu9wBT3fFdCboM2o
	lmvRdDLK7Zog4eAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sargun Dhillon <sargun@sargun.me>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs: always return zero on success from replace_fd()
Message-ID: <20250804180046-e3025fef-b610-4e4f-8878-1162e0e8975c@linutronix.de>
References: <20250804-fix-receive_fd_replace-v2-1-ecb28c7b9129@linutronix.de>
 <20250804-rundum-anwalt-10c3b9c11f8e@brauner>
 <20250804155229.GY222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804155229.GY222315@ZenIV>

On Mon, Aug 04, 2025 at 04:52:29PM +0100, Al Viro wrote:
> On Mon, Aug 04, 2025 at 02:33:13PM +0200, Christian Brauner wrote:
> 
> > +       guard(spinlock)(&files->file_lock);
> >         err = expand_files(files, fd);
> >         if (unlikely(err < 0))
> > -               goto out_unlock;
> > -       return do_dup2(files, file, fd, flags);
> > +               return err;
> > +       err = do_dup2(files, file, fd, flags);
> > +       if (err < 0)
> > +               return err;
> > 
> > -out_unlock:
> > -       spin_unlock(&files->file_lock);
> > -       return err;
> > +       return 0;
> >  }
> 
> NAK.  This is broken - do_dup2() drops ->file_lock.  And that's why I
> loathe the guard() - it's too easy to get confused *and* assume that
> it will DTRT, no need to check carefully.

To be fair I also got this wrong in my original v2 patch not using guard().
I'll send a fixed version tomorrow.


Thomas

