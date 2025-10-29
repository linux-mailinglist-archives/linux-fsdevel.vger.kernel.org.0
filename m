Return-Path: <linux-fsdevel+bounces-66304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD2CC1B999
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C63156555B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE19335505D;
	Wed, 29 Oct 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlX3/Neg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275B35503B;
	Wed, 29 Oct 2025 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745346; cv=none; b=o80XkQFgXdV8HZdJ5OgIVsZ/ek8jm3WtB87yNTWi+D7W3TRjnlBZhPLILjVYYkio/kdXKIF0DYLE+CX2xPLB8P9Y/N8un6If9EyGFyGtphHORb5Ayf9GCRIvLOmlvUXk73iPnZ5JCsvaJZnhO/nBjS1qggzcePJA4hqorTeeU7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745346; c=relaxed/simple;
	bh=76AtYLNQ1Gb/fR9DQRDYv8CtcVfoHaZgTGBfqdc1qGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdbP/SHm63YXuju/hHrP2ATKWAL7CSZljZqJIn/modOyw+JIWF3qwOH9XyeT0SG3O3A4Zy5uQYJ2eB9YJ8G7thKx/h1qtSxEhswzVuFA1rPycjvGiKI7lnClVYJrposa6ek7/A4D4dz3u+BL91oTz5GE4FtdKKUDQOA4e5o0bz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlX3/Neg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEC9C4CEFF;
	Wed, 29 Oct 2025 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761745346;
	bh=76AtYLNQ1Gb/fR9DQRDYv8CtcVfoHaZgTGBfqdc1qGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlX3/NegS26E/3MnqJgLqCAkl3WXfP4RWIqGvoECJ5SwaTs1Iwl1R+84g1dVM0GfM
	 dKWq6fF3WXaXe0nM2rQ7vCTIPyYm54d6uncrmi1JcdT8YgdQ9pxEJK7YBmbqHYnghy
	 hmPJVIijHF2QcB5dmAxwghVevg5jfgN+Igkshvtd6E8+F/Xwv3HpKQH3wwTvReCbv6
	 TPaWvzCzYw5YEo15zrfMSh3opGmtIyer9oSnj1r0SGuInYNPaLxj/qgV01yl8aRJTl
	 nQ8Zl3bDOlOW92FgzTXrbQx2EsmXDtc2Uk5CbHQdtWemLc8Qn1y9PD25Xt1/igO5uu
	 FZnRLXzXOJ7bw==
Date: Wed, 29 Oct 2025 14:42:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	David Sterba <dsterba@suse.com>, Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH] fs/pipe: stop duplicating union pipe_index declaration
Message-ID: <20251029-mailen-neueinstellung-3e0d445134c2@brauner>
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
 <20251023164408.GB2090923@ax162>
 <CAHk-=wg6mxof1=egFUDTNEj3__tCWLTbKjYLzxipVCn6ndXr+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg6mxof1=egFUDTNEj3__tCWLTbKjYLzxipVCn6ndXr+g@mail.gmail.com>

On Thu, Oct 23, 2025 at 06:48:13AM -1000, Linus Torvalds wrote:
> On Thu, 23 Oct 2025 at 06:44, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Yeah, this would also be a good conversion example so we could include
> > it in kbuild-next with the appropriate Acks. We probably do not want to
> > take too many other conversions in the initial pull. If people really
> > want to use this in other places for 6.19, we should probably do a
> > shared branch for these changes that maintainers could pull into their
> > own trees.
> 
> Yes. This is a good example of what the use case is and why we're
> doing this extension. So Ack both on including it as such, and on the
> whole "let's not go overboard with other conversions" thing.

WHAT??? We're actually doing that? This is fscking lovely! I thought
this would never fly and so I actually never proposed it. Who do I have
to hug for doing this? I'm a very happy boy right now.

