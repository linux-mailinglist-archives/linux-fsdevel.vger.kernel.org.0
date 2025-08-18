Return-Path: <linux-fsdevel+bounces-58217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A13CB2B411
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 00:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF574168063
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 22:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F0A265632;
	Mon, 18 Aug 2025 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fY2omtyE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF91990C7;
	Mon, 18 Aug 2025 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555678; cv=none; b=QiSG2Dd9dcxbZz9i920DpFCfPG/dBtb3CcHlu8StLzitg/IQiYLFBxXx1vsxfqcmHoXfRlf/q9jvLY/L/NViDw00UTlQvpoARUE0+yngyp+waj31o3gozfEKL89wvjA6ZrlZhRks+m+CJAWphI7JQN475G80owU5Bc3zaE+on+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555678; c=relaxed/simple;
	bh=Rvk/f7Q+mUCd3d44bW8WcOXhUyafuI2HZ5QllPIkyOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p27haAgoEqByxpOXGm/T0xY0bcM0opyhEbZMP8UgxKoCNoSeTbqR5/bN1/pE/ujBrzVwrbAgpZSHwt+7+MVreh7q3y5mHikLDAS9ItJtZh84NYOyXtJOMG9i4xDiRJO4Cm7ovxLNWiNmp+cwkY1kKTC/neIe6QOR0IkHPDevvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fY2omtyE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rvk/f7Q+mUCd3d44bW8WcOXhUyafuI2HZ5QllPIkyOU=; b=fY2omtyEmWoaI7bApBQGWd3EAT
	Omf/Q2+erUQkvILrSegHvyTs22jqfoCc41uXF/rkHl/KH+XZGQfBZTa417vHg7eV085CXI0W5uGxB
	3Dt/FKnVtECmE9nyVfo2rx8E2/ioqNEqKOja2j8pyIeoh4FmCgERGUtMwkG/GI6ZGauvH3Q+9XC37
	SyirQSwxtouyTi+xw11e+iHtPYI9pmhJHgVwElKrA4sZeSjB07+u+lMurdIVVt1RP3nyFPwe2vA9E
	SAuRIQNUPeag02Tzv3XV2PhdOuj5cjWYE73I0p15/TFIfFfRIwQrAVd6EXGhHZu3VtxsV5AOP9GkA
	/eItQqlg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo8E3-00000009AIi-0GNh;
	Mon, 18 Aug 2025 22:21:11 +0000
Date: Mon, 18 Aug 2025 23:21:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	x86@kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked
 access
Message-ID: <20250818222111.GE222315@ZenIV>
References: <20250813150610.521355442@linutronix.de>
 <20250817144943.76b9ee62@pumpkin>
 <20250818222106.714629ee@pumpkin>
 <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 18, 2025 at 02:36:31PM -0700, Linus Torvalds wrote:

> And "goto" is fine, as long as you have legible syntax and don't use
> it to generate spaghetti code. Being able to write bad code with goto
> doesn't make 'goto' bad - you can write bad code with *anything*.

Put it another way, one can massage a code into a strictly structured
(no goto, only one exit from each block, etc.) equivalent and every
hard-to-answer question about the original will map to the replacement -
just as hard as it had been.

I suspect that folks with "goto is a Bad Word(tm)" hardon had been told
that goto was always avoidable, but had never bothered to read the proof...

