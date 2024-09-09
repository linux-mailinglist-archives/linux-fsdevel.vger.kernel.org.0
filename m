Return-Path: <linux-fsdevel+bounces-28931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E2971330
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 11:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927D41F237D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467041B2EE7;
	Mon,  9 Sep 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6Q2qWZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0F1B253B
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873512; cv=none; b=dTg7br5mtuqDQkRcj8h/IwFhKmOVnSGZZBZOsu1lCigaPvW3ZzXEOUrzwERiZjdbH4q/KjOzyz8zk50X5as0M9uLRKtdREj3+zv1jsRraSa+agFcEB+fUBfMRBsT96jBL4uYM2O1SwqMNTxtYutDKn5etJ/5G5erKJ16gNbG1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873512; c=relaxed/simple;
	bh=GPzd0E7ui+aEseiBiClSy15vw20ljTBM0yt5ijjhDNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcrQ+7aCOtCyil+hhzwQGKJQMyqBOUqU9KjD2z3qy9m7pmHWePID8w/0Wtkg0AYTO7Kyz4+OEXLBYd8Q3F4Od1r80xa6XivQ3+rEWnPk84vd7RP81mOGxB8N51fQD7z2hzU+5hcxtf6YLkkxkr3BI8MWra3GygYkfe6kbbZjMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6Q2qWZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17C4C4CEC6;
	Mon,  9 Sep 2024 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725873510;
	bh=GPzd0E7ui+aEseiBiClSy15vw20ljTBM0yt5ijjhDNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6Q2qWZiBevm32pQmKwLGAwcryx2jNCCia6PPcjHTF5H3Wjn6AOINArmAl7pD7uve
	 DVDQawuIUmmqEwUzss0Ow+9iaTz5W291Xqc1bve+6suDq82gHyzMeKjB39qK2852UD
	 xshM+nXNr4/anZc0ws/yapnBawUc4YR+LSUe1ohscT4Wk3Rbu5ftSujgZLo7NYvXgd
	 fC5QGgd1bPB5QfwwGLhb3BjqEtsGhCPRVZpXG3I/hrG/ScsxyUMt7Q6xejiiAoTBpa
	 Kv6V1O97QpJU29KjSrn+LbQWx2bz4fLxrZd1P2mPDgnaJ/jPM49b8bFGW+ttePBuaA
	 YUUm2ud6hI2Kg==
Date: Mon, 9 Sep 2024 11:18:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, 
	Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: copying from/to user question
Message-ID: <20240909-zutrifft-seetang-ad1079d96d70@brauner>
References: <4psosyj7qxdadmcrt7dpnk4xi2uj2ndhciimqnhzamwwijyxpi@feuo6jqg5y7u>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4psosyj7qxdadmcrt7dpnk4xi2uj2ndhciimqnhzamwwijyxpi@feuo6jqg5y7u>

[Forgot to add Thomas and Arnd as Mike pointed out]

On Mon, Sep 09, 2024 at 10:50:10AM GMT, Christian Brauner wrote:
> Hey,
> 
> This is another round of Christian's asking sus questions about kernel
> apis. I asked them a few people and generally the answers I got was
> "Good question, I don't know." or the reasoning varied a lot. So I take
> it I'm not the only one with that question.
> 
> I was looking at a potential epoll() bug and it got me thinking about
> dos & don'ts for put_user()/copy_from_user() and related helpers as
> epoll does acquire the epoll mutex and then goes on to loop over a list
> of ready items and calls __put_user() for each item. Granted, it only
> puts a __u64 and an integer but still that seems adventurous to me and I
> wondered why.
> 
> Generally, new vfs apis always try hard to call helpers that copy to or
> from userspace without any locks held as my understanding has been that
> this is best practice as to avoid risking taking page faults while
> holding a mutex or semaphore even though that's supposedly safe.
> 
> Is this understanding correct? And aside from best practice is it in
> principle safe to copy to or from userspace with sleeping locks held?

