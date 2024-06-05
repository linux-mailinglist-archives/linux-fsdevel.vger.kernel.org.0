Return-Path: <linux-fsdevel+bounces-21041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF548FD0C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A73287D73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDE61B963;
	Wed,  5 Jun 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSS3mbPC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC13199A2
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597398; cv=none; b=Z6ca/1jkmmlaBnj4X4MniKB7SagMjNKzkvL6b0FuVdQQOu4SQqT9ZRpHuWnAggtruW7NhC5OD87XqouxI0MfepzgeMQg6IdyMSB60GRthz9FgOgMqnlH7kQtZ81ZaM7YGmyE2gWo8+GH1+AEGy7/4gTnUglK0qizQWVydJXg364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597398; c=relaxed/simple;
	bh=zlxSVlud+E4ymyqN3DILMjsRr1gnpto18pAHqcsn4z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvBGu23tbF+aTOIw6AcvB5cD9g7XVLQCKb7LYEQNzZDxc8qektcynYKl4399kI8UsukVTDLj/GW2eUcktasdHi0mReKN1hsNKfyedtVSav4GWGxw0J+LeqYkYgRPfrKl0uPw/TSBhHo4VoTdhCizlg1OE3kPMb4IfZGym2vs1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSS3mbPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD9BC2BD11;
	Wed,  5 Jun 2024 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717597398;
	bh=zlxSVlud+E4ymyqN3DILMjsRr1gnpto18pAHqcsn4z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSS3mbPChZ9bjKB/PRv2BUxErwSbP9zc6SUgMHmL6mVYh9rILNlOzjbEab9dItW4q
	 doMI8600dvGmlY/PrEDBq4nfjFZwFRGCQRwyz5V1rO7haPx+izzFuzDgFmK2nqvim2
	 /pJcC5oFs6pVj3kIssrEiUS7XfpLeIO52UPL86jkhDMGzvUb7oJH0l9aRGlfjqiwax
	 jmuZDgFlGElwLRL+LN7FpuK9mUIrFsFwksOSljEeyqm2nTW36mm0mnYIUV+AEQbP/e
	 Y84Og4vkXXjdV72Dh3L+/JxSdPm+uY0DYVXJ7drz1pO3NHi3ODNq/AF7QL1mZgxilg
	 EPlpbE1ylpY8Q==
Date: Wed, 5 Jun 2024 16:23:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] possible way to deal with dup2() vs. allocated but still
 not opened descriptors
Message-ID: <20240605-strategisch-walten-40bc8601984e@brauner>
References: <20240605022855.GV1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240605022855.GV1629371@ZenIV>

On Wed, Jun 05, 2024 at 03:28:55AM +0100, Al Viro wrote:
> 	dup2(old, new) has an unpleasant corner case - when new has been
> already reserved by e.g. open() from another thread, but that open()
> still didn't get to installing an opened file to that descriptor.
> 
> 	It's outside of POSIX scope and any userland code that might
> run into it is buggy.  However, we need to make sure that nothing breaks
> kernel-side.  We used to have interesting bugs in that area and so did
> *BSD kernels.
> 
> 	Current solution is to have dup2() fail with -EBUSY.  However,
> there's an approach that might avoid that wart.  I'm not sure whether
> it's worth bothering with - it will have a cost, but then it might reduce
> the pingpong on current->files->file_lock.

Fwiw, doesn't seem worth the trouble and would likely just complicate
things for something that we've never really heard being a problem.

