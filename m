Return-Path: <linux-fsdevel+bounces-8086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EE382F45F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 19:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E18028311E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FFE1CF89;
	Tue, 16 Jan 2024 18:36:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614681CD38;
	Tue, 16 Jan 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430200; cv=none; b=TTRXNJjlJ78OFN3t2rFlfdRPvjvUNeTqBGchb+0hW5JzhDXqeowbtu7zPDijbGlRMmhmCCCPyUgPTWtMwBE/Qaks+YaY4yTqlcK1CSjsW+7kLAOwGtYr2lDnoL+3J/hyZhDXhUYsawYWjoj/uiP5IqQwed6Vsqi31HJp7OjNna8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430200; c=relaxed/simple;
	bh=jg/ppbd1iRmPyZSC5aPUW90GyNeC2z1ibAOXwyj+cXg=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=NG48208DvqySuQRQese0alF5RhsPhZErEVRzwmPF1BF52PC0HDi0iiR7qWsnQ7vnsgpS1gJmvSuPS6fAMKuMt6w759WJtAbrgauEJgN+l1JQUAatanaPgFqytdZiLoKMjADxrZJH1aNra4qamZRgd+I81UqLpUq4TfulBN+TcNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55AAC43390;
	Tue, 16 Jan 2024 18:36:38 +0000 (UTC)
Date: Tue, 16 Jan 2024 13:37:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, kernel test robot
 <oliver.sang@intel.com>, Ajay Kaher <ajay.kaher@broadcom.com>, Linux Trace
 Kernel <linux-trace-kernel@vger.kernel.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Create dentries and inodes at dir open
Message-ID: <20240116133753.2808d45e@gandalf.local.home>
In-Reply-To: <CAHk-=wji07LQSMZuqbHFRnnaKvpQugqZ_GnCsfPvg9qJGVDujA@mail.gmail.com>
References: <20240116114711.7e8637be@gandalf.local.home>
	<CAHk-=wjna5QYoWE+v3BWDwvs8N=QWjNN=EgxTN4dBbmySc-jcg@mail.gmail.com>
	<20240116131228.3ed23d37@gandalf.local.home>
	<CAHk-=wji07LQSMZuqbHFRnnaKvpQugqZ_GnCsfPvg9qJGVDujA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 10:21:49 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Here's a clue: just fix your inode numbers.
> 
> I can think of many ways to do it. Here's a couple:
> 
>  - use a fixed inode number for all inodes. It's fine. Really. You might
> confuse some programs that still do getpwd() the legacy way, but hey,
> nobody cares
> 
>  - just put the inode number in the same data structure everything else is
>
> 
>  - make the inode number be a hash of the address of your data structure.
> That's actually the closest to a traditional "real" inode number, which is
> just an index to some on-disk thing
> 
> I'm sure there are other *trivial* solutions.
> 
> None of this is an excuse to misuse sentries.
> 
> Try the first one - one single inode number - first. You shouldn't be doing
> iget() anyway, so why do you care so deeply about a number that makes no
> sense and nobody should care about?

It was me being paranoid that using the same inode number would break user
space. If that is not a concern, then I'm happy to just make it either the
same, or maybe just hash the ei and name that it is associated with.

If I do not fully understand how something is used, I try hard to make it
act the same as it does for other use cases. That is, I did all this to
keep inodes unique and consistent because I did not know if it would break
something if I didn't.

Removing that requirement does make it much easier to implement readdir.

I think I'll do the hashing, just because I'm still paranoid that something
might still break if they are all the same.

-- Steve

