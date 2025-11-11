Return-Path: <linux-fsdevel+bounces-67889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D736DC4CDAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC4B34F61E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3700F2FB0AE;
	Tue, 11 Nov 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YcPy51xd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F68325D917;
	Tue, 11 Nov 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855038; cv=none; b=AmluT9T1kADFqgq1JX/F+zkZX+vRYscth+lTAuEGt9n+0aZ+B8ueXLE1GEf24sax52cPRyD5MeKNG3ORjN8dc2VeSVQzmM/wksI6erjRPNMMLkY9Bmj0YDCEW6ghoJf4wX+JE5WWHES4k4x1MFJ0UAUN9UqSNsLR+50a54uqyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855038; c=relaxed/simple;
	bh=XMgYp8Gm+XEta1jQY2obPybGwzYn6v9qbTYbWzfkUzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQO+IvJaD8+sAQGE921satKXiLNL0tS4vZVTwnY5Ay32ihRUj56HlCwjV/0m05I8I7xesexxF1ddOmHSrOFKdFKcRt/Pk7kos0Aw26YSlMR4p5wzLkYwcIQXYoTrLyhIIwNzlwhTmSFftOCfbDwxdj6UgnpLSpBX5kLDA4kUPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YcPy51xd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=74kl5pxl+IxCE2jWnHrnRBrtYTfeR/qWfujHqjcfkXs=; b=YcPy51xdz204WgVj3fAeA+4fMd
	GsUk9sdgzX3j1LbfziGjyQYniiSDqUcoB0rMjvtbdy+X+sE+a7+Qe46RfxSNrInvpfTUglen5q9pd
	eyyTKtSjE9Fzq5Npjs8ggvAiqo4ZYdoA5uZfASvjoSARSvwhnkhbLuMrGGmwD5hsUCL7dBLe+uOab
	/lbxKMStgMmRJB6RdfnxfdMwHOj2d9f9PTujuY3JX0Sh9WS7dHoyKempQgXRfRMNFGC35ulioTS9J
	4Hqz8umPzx28rtqBz9igUeGD3fVXMhQeY+3h1Im/Cxj+TTBnptLnrK5SN9zCZCgsWNdWAhV/cIXdn
	A1KP5juA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkFx-0000000Covz-3iiH;
	Tue, 11 Nov 2025 09:01:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D190300328; Tue, 11 Nov 2025 10:57:08 +0100 (CET)
Date: Tue, 11 Nov 2025 10:57:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] restart_block: simplify expiration timestamps
Message-ID: <20251111095708.GG278048@noisy.programming.kicks-ass.net>
References: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>
 <20251111-formel-seufzen-bdf2c97c735a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251111-formel-seufzen-bdf2c97c735a@brauner>

On Tue, Nov 11, 2025 at 10:48:45AM +0100, Christian Brauner wrote:
> On Mon, Nov 10, 2025 at 10:38:50AM +0100, Thomas Weiﬂschuh wrote:
> > Various expiration timestamps are stored in the restart block as
> > different types than their respective subsystem is using.
> > 
> > Align the types.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> 
> @Thomas, @Peter, do the timer/futex changes look fine to you?

Yeah, I suppose. But I forever forget the restart block details.

That is, I don't object to the changes, but I need to spend more time to
ascertain correctness if that's the ask.

