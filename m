Return-Path: <linux-fsdevel+bounces-9099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C0E83E2B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 20:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF182866E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704BF225AE;
	Fri, 26 Jan 2024 19:37:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B092261D;
	Fri, 26 Jan 2024 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297833; cv=none; b=n9agr1CgyNxHE/wqj56U4oyCkS0flErfrHvc5rg4Sl+X3v9Noul/zCGpYgZX73k8aixI+dPFoiM/AboGq2Ds5tYC+C5CmV0V9SGY427UX3hUv0P1FXipf0izLP1MQS6Qb+ulbJza5AyO89WebEEsimh0JHN4ruOU4nTP5Rlw7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297833; c=relaxed/simple;
	bh=k4tH5U9WfiG0VOxuGa6XKILf0J3Xbi/bKH/R6EmWu8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sL+b+rO+aFe1mtNKbKj8G9wOiulrqzO4irBTVrEHa/+p6v4Ej+4bg0PbSAepiiNxin6mY5oRlgpFCSF83smaWsoIi5daYAEbTwsjxrDmYHRIFm1ThlU4Gg03RN1I2KFXB5Enm3A04mOhfJcF1vRbgdxZOtMmmZdznRQlsAkk4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4C9C433F1;
	Fri, 26 Jan 2024 19:37:11 +0000 (UTC)
Date: Fri, 26 Jan 2024 14:37:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Give files a default of PAGE_SIZE size
Message-ID: <20240126143714.3eb81db4@gandalf.local.home>
In-Reply-To: <CAHk-=wjTECUZLBgALpvm9zDN8TJCGxyc3VCEXXHMsFNAN+x5Fg@mail.gmail.com>
References: <20240126131837.36dbecc8@gandalf.local.home>
	<CAHk-=whA8562VjU3MVBPMLsJ4u=ixecRpn=0UnJPPAxsBr680Q@mail.gmail.com>
	<20240126134141.65139b5e@gandalf.local.home>
	<CAHk-=wjTECUZLBgALpvm9zDN8TJCGxyc3VCEXXHMsFNAN+x5Fg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 11:06:33 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 26 Jan 2024 at 10:41, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Fine, but I still plan on sending you the update to give all files unique
> > inode numbers. If it screws up tar, it could possibly screw up something
> > else.  
> 
> Well, that in many ways just regularizes the code, and the dynamic
> inode numbers are actually prettier than the odd fixed date-based one
> you picked. I assume it's your birthdate (although I don't know what
> the directory ino number was).

Yeah, it was. I usually use that when I need a random number. I avoid using
it for passwords though. The odd directory number was the date you pulled
in eventfs ;-)

-- Steve


