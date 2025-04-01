Return-Path: <linux-fsdevel+bounces-45456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D7A77E06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFBB07A208D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5B5204F71;
	Tue,  1 Apr 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+MxI1w6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48331204F65;
	Tue,  1 Apr 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518443; cv=none; b=phHUWqDMGvala0Fnrmwk/MBrOk1RRLE8ghNNoPi0x+kbL52iLb/LiedFjnVFzjmehtw8dGFJMSmyt9nxfn5aUUcPcBFrcPiIQOMmwxNz9gUFWo4Jg3TnOVeyL8g3rYcSCDy371ikt5Zz8qCtJUX0mmMvwScIKBxZQaJNhTYqxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518443; c=relaxed/simple;
	bh=u+GoIqV+fjeT7z+mFVcbtJXhmpOHnpXRH54YzZYQbKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj99mJICV5NeBZQnrePXe2erAAc/httIZzHq2nifxCJtSyj0sOamRDiRyKl0Cq1Oo0fw9FNqy+Z8eyWW3MIDJIemT03DswBKIcfIPBKubx8tr95IuXl3VnPxneFKZcbE+uLNhVvLA/kOsyLRO2DvW5+Mjqu8QNdtHw5JseeNlgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+MxI1w6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F6BC4CEE4;
	Tue,  1 Apr 2025 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743518440;
	bh=u+GoIqV+fjeT7z+mFVcbtJXhmpOHnpXRH54YzZYQbKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+MxI1w6UD4FjVaB2IKN1ytV1rYCOD1i65vy0QScvgGG07MwjSnNOfkfD9a8fB8Ty
	 84YFO1uBWW2teT17JKiBs5FMxSnT8EnnX6dHFXv0fRmnGzSw8CKzjBD7ciU0ulj4Hf
	 Nlxpnlnmk9U8lSD9MZkfRZ825X061HAGCBAfk6uiTx2Gpjua4kSENYMErDdi2FxVZT
	 B1SxF2x8j8aLcKZX4s6rw/UDbcNdqCh8/v881SVWZjUGfoGWdaqNGtT0gKOhDotjXI
	 YW4IC95G+xlIfSB9aWiaHPJ5XTBHU9yfKjS8SF+Qhl6RpKJkfL/yaBQm2pf+T/+r2Z
	 TEDfG2wycXd+g==
Date: Tue, 1 Apr 2025 16:40:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, rafael@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	djwong@kernel.org, pavel@kernel.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com
Subject: Re: [PATCH 0/6] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <20250401-ballen-eulen-8d074cd8ca78@brauner>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
 <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <20250401141407.GE5880@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401141407.GE5880@noisy.programming.kicks-ass.net>

On Tue, Apr 01, 2025 at 04:14:07PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 01, 2025 at 02:32:45AM +0200, Christian Brauner wrote:
> > The whole shebang can also be found at:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.freeze
> > 
> > I know nothing about power or hibernation. I've tested it as best as I
> > could. Works for me (TM).
> > 
> > I need to catch some actual sleep now...
> > 
> > ---
> > 
> > Now all the pieces are in place to actually allow the power subsystem to
> > freeze/thaw filesystems during suspend/resume. Filesystems are only
> > frozen and thawed if the power subsystem does actually own the freeze.
> 
> Urgh, I was relying on all kthreads to be freezable for live-patching:
> 
>   https://lkml.kernel.org/r/20250324134909.GA14718@noisy.programming.kicks-ass.net
> 
> So I understand the problem with freezing filesystems, but can't we
> leave the TASK_FREEZABLE in the kthreads? The way I understand it, the

Yeah, we can.

> power subsystem will first freeze the filesystems before it goes freeze
> threads anyway. So them remaining freezable should not affect anything,
> right?

Yes. I've dropped the other patches. I've discussed this later
downthread with Jan.
> 

