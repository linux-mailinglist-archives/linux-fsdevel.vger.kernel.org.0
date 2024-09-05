Return-Path: <linux-fsdevel+bounces-28707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63B596D2ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 11:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD2E1F23195
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC56197558;
	Thu,  5 Sep 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFiPiyuJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892319306F;
	Thu,  5 Sep 2024 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527771; cv=none; b=HmObl4B0c3HvtkGWef/mWWcmxejqR4GMeO8k1JVp502ixi0FdzZKv3rrx+RIESmQ/2QKUH41RR0oqZnyOxMofdwHNOTanqUua+46M55w20F53LMS3TG1naQOK4qr7hy46cT0YqqbB6oT98cnQExQRUWJC4ZIpYQe+/wm9nqJtRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527771; c=relaxed/simple;
	bh=7Dw5VKZkulLlheyA1Qjs3IF3Ob0JkeSjdUhPsmJtaCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu1L7q3/SR0vyRD+ctbivVPq/oTnVXQ+sTUiEeQrkGNXp8L8iUuU+WQw/6YzzNrRfh/vea3TaA1LMbvayj/X4IlLrdRuuqZbb4uueaupOK/pWJ5lvKqqDQpvu5aLRTTNg5TmJq8pJFz7XGnhFfzol3NcCG3UKriLNHIO8dFSG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dFiPiyuJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XsdqhbJ3zmhNs2KrvIEKmoJ1rY5ARJ37kpe6b70U7Bg=; b=dFiPiyuJETW8FuNmBJbojo4NDN
	do4sznt5lbniPfb64SPy5h0o8fthSkCTgiYh9ZYMm98KKABQKG+SvrJIi0yAywxxm625bfMBWdZnN
	0qBdd9qkaX72KKVTuvTq2gciXTAL4w4KvDvjoyOgNR9yrYVV3kr2Z16yxd4tXUEd7W/2MX/zEI4fa
	6RUAkV2lW03ksZRr091NA63GzohWIhJAjuCZ8sFWUE5YPV+oOcxOV/xBqutA3Bjsc/y32KXjOXU9y
	sJynLllYCesV+6+NfUuUhwOD54BoI1l80Sd/654R/dZHHhm42C1b9cgBadAIda4/VKEhoG+xcrvut
	btt3PsIw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sm8b0-00000000Rt1-0fGT;
	Thu, 05 Sep 2024 09:16:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4C443300599; Thu,  5 Sep 2024 11:16:05 +0200 (CEST)
Date: Thu, 5 Sep 2024 11:16:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240905091605.GE4928@noisy.programming.kicks-ass.net>
References: <20240731105557.GY33588@noisy.programming.kicks-ass.net>
 <20240805143522.GA623936@frogsfrogsfrogs>
 <20240806094413.GS37996@noisy.programming.kicks-ass.net>
 <20240806103808.GT37996@noisy.programming.kicks-ass.net>
 <875xsc4ehr.ffs@tglx>
 <20240807143407.GC31338@noisy.programming.kicks-ass.net>
 <87wmks2xhi.ffs@tglx>
 <20240807150503.GF6051@frogsfrogsfrogs>
 <20240827033506.GH865349@frogsfrogsfrogs>
 <20240905081241.GM4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905081241.GM4723@noisy.programming.kicks-ass.net>

On Thu, Sep 05, 2024 at 10:12:41AM +0200, Peter Zijlstra wrote:
> On Mon, Aug 26, 2024 at 08:35:06PM -0700, Darrick J. Wong wrote:

> > [33965.988873] ------------[ cut here ]------------
> > [33966.013870] WARNING: CPU: 1 PID: 8992 at kernel/jump_label.c:295 __static_key_slow_dec_cpuslocked.part.0+0xb0/0xc0

> > [33966.040184] pc : __static_key_slow_dec_cpuslocked.part.0+0xb0/0xc0
> > [33966.042845] lr : __static_key_slow_dec_cpuslocked.part.0+0x48/0xc0

> > [33966.072840] Call trace:
> > [33966.073838]  __static_key_slow_dec_cpuslocked.part.0+0xb0/0xc0
> > [33966.076105]  static_key_slow_dec+0x48/0x88

> > This corresponds to the:
> > 
> > 	WARN_ON_ONCE(!static_key_slow_try_dec(key));
> 
> But but but,... my patch killed that function. So are you sure it is
> applied ?!
> 
> Because this sounds like exactly that issue again.
> 
> Anyway, it appears I had totally forgotten about this issue again due to
> holidays, sorry. Let me stare hard at Thomas' patch and make a 'pretty'
> one that does boot.

I've taken tglx's version with a small change (added comment) and boot
tested it and queued it here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/urgent

Could you please double check on both x86_64 and arm64?

If green by with the build robots and your own testing I'll push this
into tip/locking/urgent to be sent to Linus on Sunday. Hopefully finally
resolving this issue.

