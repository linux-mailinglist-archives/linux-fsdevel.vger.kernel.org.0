Return-Path: <linux-fsdevel+bounces-36212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D1E9DF6EB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 19:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A8DB2115E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6124C1D86F1;
	Sun,  1 Dec 2024 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK+KiVzD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFEA1B6555;
	Sun,  1 Dec 2024 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733078251; cv=none; b=b5vRGs/9CoYtIYe4C+PUmZg3SXomF9qd57LimViTXEQjwqli9uQOd+r2gQZuuIKVajhxX2GwoQwcF2isDBaEw3LdO4vXS0C8trhxeBhRnXNMJEftS7hmHaBUG07DYNcfsoz4YTR/OE693OIJNHopJ8p0fVOmSqQQARhZV0QoxPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733078251; c=relaxed/simple;
	bh=+2Py7UlQjNUpEgABFHHx3R+0RCZbSYTPDzWE1soAJuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQQfgkZU2FfOwzHZCkNFJGnPy054qbTW32pfFw4JkGf8QCNbnjZ3ZTjm+lUKN78nHRi0a5YX0XqGALsew62LA9JzxkGaTZo4QiqNMU5pvlFWEB4ctNo/ndeWgUnmyzTEvy6AYjJYL8WePUKmeajxO8OotgDf4mHmSb50kY2Sa6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK+KiVzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44210C4CECF;
	Sun,  1 Dec 2024 18:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733078251;
	bh=+2Py7UlQjNUpEgABFHHx3R+0RCZbSYTPDzWE1soAJuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BK+KiVzDxrtkhyhQ9wpPL3KqiL59QI8rrmqxkfIVPVTiccFG9IQLBF2fdvYHpYqdp
	 y0DAETWL4FPrzsIpvR1luJp7o9bw0LZHYODQeQGS1g3bfbhJQMi187UyGn/H/SMkok
	 oUow0TpUJYJyockrcQoaD39KB+LgwtRn3QiuN/SIgKMNs/lmBnHgFC+g4YHtbg4eHJ
	 FZ5l8y59skSPDWCS5Xjo9Dgs7AoNn1UwSb6/JiNfDv0G71SH0oJlmq//EftXBOfvoM
	 UgKXfLDwXdSdYwT8a3TN3zQ7iwMjAoOL8IsoAj18hgjVi2w282Z2czi4Yk0vcyiVDx
	 CyfaRrn3j5G2g==
Date: Sun, 1 Dec 2024 19:37:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Tycho Andersen <tandersen@netflix.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <20241201-seerosen-opern-8dfda1f79c50@brauner>
References: <20241130045437.work.390-kees@kernel.org>
 <20241130-ohnegleichen-unweigerlich-ce3b8af0fa45@brauner>
 <CAHk-=wi=uOYxfCp+fDT0qoQnvTEb91T25thpZQYw1vkifNVvMQ@mail.gmail.com>
 <20241201-konglomerat-genial-c1344842c88b@brauner>
 <CAHk-=wgcbq=2N8m5X8vJuUNgM9gpVjqpQzrnCsu19MP8SV5TYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgcbq=2N8m5X8vJuUNgM9gpVjqpQzrnCsu19MP8SV5TYA@mail.gmail.com>

On Sun, Dec 01, 2024 at 08:54:41AM -0800, Linus Torvalds wrote:
> On Sun, 1 Dec 2024 at 06:17, Christian Brauner <brauner@kernel.org> wrote:
> >
> > /*
> >  * Hold rcu lock to keep the name from being freed behind our back.
> >  * Use cquire semantics to make sure the terminating NUL from
> >  * __d_alloc() is seen.
> >  *
> >  * Note, we're deliberately sloppy here. We don't need to care about
> >  * detecting a concurrent rename and just want a sensible name.
> >  */
> 
> Sure. Note that even "sensible" isn't truly guaranteed in theory,
> since a concurrent rename could be doing a "memcpy()" into the
> dentry->d_name.name area at the same time on another CPU.

Yeah, I saw, if the dname.name assignment is reorded to happen before
the memcpy() afaict. Anyway, it's not that important especially since
PR_SET_MM_MAP puts comm, auxv etc. fully under user control anyway.

