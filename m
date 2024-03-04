Return-Path: <linux-fsdevel+bounces-13497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4EF870849
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580EFB2388B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B86612F7;
	Mon,  4 Mar 2024 17:31:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kanga.kvack.org (kanga.kvack.org [205.233.56.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2861FA4;
	Mon,  4 Mar 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.233.56.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573483; cv=none; b=jTLb5rh2wTsGSVEL90z1cGyvtc0XOMx0DfLbGT5h1HNitJsvm2gi5oLqXUaB0oYI0qhidXK+n4X3rg/i5nTmsSucQ5njtsjd0HmKoiAAOMpJa2hhlwSe5+P5FyfC/Uw0K7HupzPBooq/zLwEuevxI5bh0sTXsZKmcpzUA5/d7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573483; c=relaxed/simple;
	bh=Tl4tLi0JyDRR497x6GHkoHWa7mhQVEGmFRIbiwCjj7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzKIGXv7I5b+vmRagbfmdT1GjYYIwLnw7baFWIBW59xaUrP6n4we32IwYiXY9J/22CUXT0unXvh2teUG0icnTbCQKBr9VKWJZNbPVC/7dbDVa7TqH/bREGEcW29p8LTKhTzhalmwvAOLKpK2Q0ZH3bUh2Lito3uEvgG3ESdPaUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=communityfibre.ca; spf=pass smtp.mailfrom=communityfibre.ca; arc=none smtp.client-ip=205.233.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=communityfibre.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=communityfibre.ca
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id 9B7F56B007E; Mon,  4 Mar 2024 12:31:20 -0500 (EST)
Date: Mon, 4 Mar 2024 12:31:20 -0500
From: Benjamin LaHaise <ben@communityfibre.ca>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com,
	brauner@kernel.org, jack@suse.cz, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/aio: fix uaf in sys_io_cancel
Message-ID: <20240304173120.GP20455@kvack.org>
References: <0000000000006945730612bc9173@google.com> <tencent_DC4C9767C786D2D2FDC64F099FAEFDEEC106@qq.com> <14f85d0c-8303-4710-b8b1-248ce27a6e1f@acm.org> <20240304170343.GO20455@kvack.org> <73949a4d-6087-4d8c-bae0-cda60e733442@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73949a4d-6087-4d8c-bae0-cda60e733442@acm.org>
User-Agent: Mutt/1.4.2.2i

On Mon, Mar 04, 2024 at 09:15:47AM -0800, Bart Van Assche wrote:
> On 3/4/24 09:03, Benjamin LaHaise wrote:
> >This is just so wrong there aren't even words to describe it.  I
> >recommending reverting all of Bart's patches since they were not reviewed
> >by anyone with a sufficient level of familiarity with fs/aio.c to get it
> >right.
> 
> Where were you while my patches were posted for review on the fsdevel
> mailing list and before these were sent to Linus?

That doesn't negate the need for someone with experience in a given
subsystem to sign off on the patches.  There are at least 2 other people I
would trust to properly review these patches, and none of their signoffs
are present either.

> A revert request should include a detailed explanation of why the revert
> should happen. Just claiming that something is wrong is not sufficient
> to motivate a revert.

A revert is justified when a series of patches is buggy and had
insufficient review prior to merging.  Mainline is not the place to be
testing half baked changes.  Getting cancellation semantics and locking
right is *VERY HARD*, and the results of getting it wrong are very subtle
and user exploitable.  Using the "a kernel warning hit" approach for work
on cancellation is very much a sign that the patches were half baked.

What testing did you do on your patch series?  The commit messages show
nothing of interest regarding testing.  Why are you touching the kiocb
after ownership has already been passed on to another entity?  This is as
bad as touching memory that has been freed.  You clearly do not understand
how that code works.

		-ben
-- 
"Thought is the essence of where you are now."

