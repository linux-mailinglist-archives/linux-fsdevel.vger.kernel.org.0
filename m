Return-Path: <linux-fsdevel+bounces-58028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A5AB2818F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F19BB68065
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B827221557;
	Fri, 15 Aug 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEYTbFjm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35919004E
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267764; cv=none; b=ju9jYyFO/m6RMq9qFswo3PH3KvyUdthbJfWINx/cXV5IMMcdbNYnVoL/jYQQ7Qa2FxeoXMoCmZg0R07JLnGbIr1aVwHXvVbNOem+Mvgy1x96G3Sh9Hz+HfZWrmOygnw24gwo5Q6b4UuDeurbdS1xzAetMPUHhsp9X64d9tKBT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267764; c=relaxed/simple;
	bh=2dJE08vXOq+D0VSVgiR+Zcz4TiBPBxuaWW5XkclJ/mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMzTDzhHOyVpMnxyr3j/DReP9mRNPbG9LAb2GXHA7zzvk7cWizQQ/AXFdc83Jb4llVSvVSlZ01IX7LFum+VmguH1vi60eTCJwwUcakVUzv3oJAi6VyknYjhHHJJF9CD4JLsn+B0kRsPp5p+a7r7LeFkGLDbDvuFcVw1ScTCJzy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEYTbFjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EA6C4CEEB;
	Fri, 15 Aug 2025 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755267764;
	bh=2dJE08vXOq+D0VSVgiR+Zcz4TiBPBxuaWW5XkclJ/mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEYTbFjmX5tFYnrbSL9WIAAf0FECljuf/j0yQtdg43B+WENfBsK6t4RL6OY9J4YCs
	 VCW0r+s1RnIPiZxqmlY4nFUGjrjdzWmorr3oOlVAl/ruRCv3/Hs8r7JunKCVbeXu8q
	 Xk0F4amDDNbuVSEjwaAUgghhnwDgQj8moOtrmrGN9aqlbbIpFAGhWENt0tircoHucU
	 cFCjcoY8wia3LfTuW3D4Wm+4QYeoNAG131KHwRdKg8PLwkZKngLZfZFiHzmLISi4zx
	 wR9ZawXZx3YTe4ToOiweokIkbE256a5OIgKgJqRB9jHGIbBkkHb74L8tNqdxzG+kyG
	 rlg0fkNV7Kd7g==
Date: Fri, 15 Aug 2025 16:22:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/2] copy_file_range: limit size if in compat mode
Message-ID: <20250815-zander-eklig-142f14ac9921@brauner>
References: <20250805183017.4072973-1-mszeredi@redhat.com>
 <20250805183017.4072973-2-mszeredi@redhat.com>
 <CAJfpegsiyv52MX_JgkT8jUx194R=vB_BX8VY00muvaVVJGeJoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsiyv52MX_JgkT8jUx194R=vB_BX8VY00muvaVVJGeJoA@mail.gmail.com>

On Tue, Aug 12, 2025 at 01:21:00PM +0200, Miklos Szeredi wrote:
> On Tue, 5 Aug 2025 at 20:30, Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > If the process runs in 32-bit compat mode, copy_file_range results can be
> > in the in-band error range.  In this case limit copy length to MAX_RW_COUNT
> > to prevent a signed overflow.
> 
> This is VFS territory, so if it looks okay, can you please apply this,
> Christian?

I did so now! Thank you. Fyi, I'm on vacation in Sweden and will be back
on Tuesday so that's why there's a few delays.

