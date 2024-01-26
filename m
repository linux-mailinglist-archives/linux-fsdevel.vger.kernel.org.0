Return-Path: <linux-fsdevel+bounces-9095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B383E1D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD841C22F3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2F222EF4;
	Fri, 26 Jan 2024 18:41:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99D20DD3;
	Fri, 26 Jan 2024 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294500; cv=none; b=AsF3XJ6LLBiR+4sxyWwcstmvKbSM6BbmhYAbAOnvvJGZCnz87hi6meZBZ3H2eqwROSQl/GT37Q4O6OenStnhSa/+IiXQyO+u4NzxcwlOpbZhBZopahgHynQCwKdkn2iX512QbyJ75R7pA4GLS+kklcG0wpDVOm3rvMlw6r8jEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294500; c=relaxed/simple;
	bh=kEQjJsA8wpw6FHNf9vQGPieJQVwYxiG/mQO5T+LdSDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJzH1ic6GMmbBknj0p81UKfEbkrgAkX1YOLqAop25Ua4aXehfk0dGTsmS/RVTT032Dzt0q6HNNpAOvDlyTV+SKMUPGG3iq1OIqlEe/pgZ2IuywvzlKyH4EiiSG3ZCPSZ1YfMCKAUDv+s8pPrRa8t4Cml1ZQAo5xpJyWALdwITew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E80C433C7;
	Fri, 26 Jan 2024 18:41:38 +0000 (UTC)
Date: Fri, 26 Jan 2024 13:41:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Give files a default of PAGE_SIZE size
Message-ID: <20240126134141.65139b5e@gandalf.local.home>
In-Reply-To: <CAHk-=whA8562VjU3MVBPMLsJ4u=ixecRpn=0UnJPPAxsBr680Q@mail.gmail.com>
References: <20240126131837.36dbecc8@gandalf.local.home>
	<CAHk-=whA8562VjU3MVBPMLsJ4u=ixecRpn=0UnJPPAxsBr680Q@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 10:31:07 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 26 Jan 2024 at 10:18, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > By following what sysfs does, and give files a default size of PAGE_SIZE,
> > it allows the tar to work. No event file is greater than PAGE_SIZE.  
> 
> No, please. Just don't.
> 
> Nobody has asked for this, and nobody sane should use 'tar' on tracefs anyway.
> 
> It hasn't worked before, so saying "now you can use tar" is just a
> *bad* idea. There is no upside, only downsides, with tar either (a)
> not working at all on older kernels or (b) complaining about how the
> size isn't reliable on newer ones.
> 
> So please. You should *NOT* look at "this makes tar work, albeit badly".
> 
> You should look at whether it improves REAL LOADS. And it doesn't. All
> it does is add a hack for a bad idea. Leave it alone.
>

Fine, but I still plan on sending you the update to give all files unique
inode numbers. If it screws up tar, it could possibly screw up something
else. And all the files use to have unique numbers. They are just not unique
in the current -rc release. You have a point that this would just fix this
release and the older kernels would still be broken, but the identical inode
numbers is something I don't want to later find out breaks something.

-- Steve

