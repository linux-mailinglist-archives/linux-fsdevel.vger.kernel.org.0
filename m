Return-Path: <linux-fsdevel+bounces-45458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D5A77E5E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D93188FD3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFAE205518;
	Tue,  1 Apr 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SU8aI45N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2FD1EA90;
	Tue,  1 Apr 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519565; cv=none; b=ik7EgVvnwyZEgJaj27AqxIT1vuZNJ6yOdHtgHB0dVvkuEd8XkMucr5Sn3IiPY56sEI5zN5g7bewvU3KQeXNRAvT9koTmQaN1RYDg5nMO75NCRiX2q0gIawXWM4tB+OmrAgWc+gQ6vCXd3K9PF3VONuMeD1LZXwezRKhBpGnXRMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519565; c=relaxed/simple;
	bh=Qp32JPwCIhwI6IJoUjbZuNkk0KZ0FXCJ0eWMsufXDuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LApKXb4o/1u+Ve+QPkc4KF5xJKhEyv1FVNwUC1ClrniipLzMWHa81S3hzl8edbGb2HzKLFzJW1uP8UPlb+bWO7YrVARprgISo0V8xk9KuLSrGdf3KlT+MSaBC0nW6ydmb/P1xxW+whoSwmNNw7qTkjGLz34bxftYuZ0r7lbzXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SU8aI45N; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v8h3UgR8VR6iE5/xjwa/0i7baM3xzERwnyg9wSlU+I8=; b=SU8aI45NjuOyu5K+u1haUtN0bX
	pZRPAfRVfptWLUSbCocQ4xlu6fg4lb3JobbR7LcmjaWHlY+0PKPWVYOMbNx8w1S2wXd385WCPjfqg
	OE8sVpjt1nMG1ruIkApiftDq7LH9jvGmdqKtNlbQPZK1eoSXWj/4sCruatjhhGok0Qyp5mpwRWxEk
	g6GOzgRmwqKh+pB4+cZdzcCjWlmHTFwLN36Yki3dz2B4GU01UOppznP6a2c5MQZiLyCCZvFjWqYJc
	2oaOUaCwJMfYBPMiH3p/BpB2375p7dL+Igl711ixNWGAz2bbqXllAdWUD9Yr2UxLVcc8HAsv0vVFc
	JpUztwrw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzd5B-00000006pkB-2UHr;
	Tue, 01 Apr 2025 14:59:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D20E30049D; Tue,  1 Apr 2025 16:59:17 +0200 (CEST)
Date: Tue, 1 Apr 2025 16:59:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, rafael@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com,
	djwong@kernel.org, pavel@kernel.org, mingo@redhat.com,
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 0/6] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <20250401145917.GM5880@noisy.programming.kicks-ass.net>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
 <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <20250401141407.GE5880@noisy.programming.kicks-ass.net>
 <20250401-ballen-eulen-8d074cd8ca78@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-ballen-eulen-8d074cd8ca78@brauner>

On Tue, Apr 01, 2025 at 04:40:33PM +0200, Christian Brauner wrote:
> On Tue, Apr 01, 2025 at 04:14:07PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 01, 2025 at 02:32:45AM +0200, Christian Brauner wrote:
> > > The whole shebang can also be found at:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.freeze
> > > 
> > > I know nothing about power or hibernation. I've tested it as best as I
> > > could. Works for me (TM).
> > > 
> > > I need to catch some actual sleep now...
> > > 
> > > ---
> > > 
> > > Now all the pieces are in place to actually allow the power subsystem to
> > > freeze/thaw filesystems during suspend/resume. Filesystems are only
> > > frozen and thawed if the power subsystem does actually own the freeze.
> > 
> > Urgh, I was relying on all kthreads to be freezable for live-patching:
> > 
> >   https://lkml.kernel.org/r/20250324134909.GA14718@noisy.programming.kicks-ass.net
> > 
> > So I understand the problem with freezing filesystems, but can't we
> > leave the TASK_FREEZABLE in the kthreads? The way I understand it, the
> 
> Yeah, we can.
> 
> > power subsystem will first freeze the filesystems before it goes freeze
> > threads anyway. So them remaining freezable should not affect anything,
> > right?
> 
> Yes. I've dropped the other patches. I've discussed this later
> downthread with Jan.

Thanks!

