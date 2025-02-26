Return-Path: <linux-fsdevel+bounces-42639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A397A4580E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2274B164FCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B501DF990;
	Wed, 26 Feb 2025 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suHNHSAp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26591664C6
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558364; cv=none; b=IA6ZbJuxHy8Yt/ViOj/4D/iUrOgl2mUR2wiOPWFm4GWn0qUruMPzGToOZrp6G62YsQtC6wNA1Qbr/IpYO7N3uig/pdNqsscVPmk/gKue1/AVH1qwA6Pn40yU9OhaWVzDN/vWsDN0llh7x0pOkcq5F+m05U3j2XSwP3g8KypWCjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558364; c=relaxed/simple;
	bh=1bP3GEs64QJ33piJu8MWHXOubif0pD26dMrowq+gHqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5aWjB9r++bPozCXSqUqk8iMKUbjH4HJIGr5W+AUulAHq5PRwgj8GlNKkF4t++sTkNwd4VHZKc75airitqtPDwOseMxMo885Bv5a11hMPgCnsNR8oIwfZ0vrjS8zjp5H4+HBn8J8MYLu3GyfGOSAw3TcWWqUlUozNNnkeebcS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suHNHSAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F51C4CEE7;
	Wed, 26 Feb 2025 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558363;
	bh=1bP3GEs64QJ33piJu8MWHXOubif0pD26dMrowq+gHqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=suHNHSApcMew7rLEp2+qJc4gmY/kZlolAZuR1j18ugya15bUTy5s4HaMZeaX4u9dl
	 r88JH/164t9/r8U+sDcSEdrx8v0HWj3PWJkhOjgJ8au15J4sBnYFitckHHw7fu8J7Z
	 je8oI509DZMGlJIOAHZsYUMtb/Kw5KoNDwHkMJvxVzoAtppn3xjTjRfxPx7zxBEdNV
	 wmfWOAQ2W4NokBnsNb0c7juyIKrrmFWFvH0EB0UPR8Z4RVjB6pUbDz9gON5WHeMWqS
	 fNqVuGVi5LzHBJALyssDJdMEN6hRGziN8L7dex8xrg3g0z9YDaEd1C0ArtVrbQdnaK
	 dws+9GY/jYFhg==
Date: Wed, 26 Feb 2025 09:25:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 01/21] procfs: kill ->proc_dops
Message-ID: <20250226-heizt-rampen-49434a87fa1c@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:31PM +0000, Al Viro wrote:
> It has two possible values - one for "forced lookup" entries, another
> for the normal ones.  We'd be better off with that as an explicit
> flag anyway and in addition to that it opens some fun possibilities
> with ->d_op and ->d_flags handling.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

