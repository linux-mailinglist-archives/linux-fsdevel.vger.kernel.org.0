Return-Path: <linux-fsdevel+bounces-68355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 885E2C5A1F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33A7C3541C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6425A322C63;
	Thu, 13 Nov 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkcUyIFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8D35957;
	Thu, 13 Nov 2025 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069476; cv=none; b=tM9iX9/r20419yy1wfdb7uNd4NqZ+Dxx8J/fxQJHnISnvgsL/reTL27YBrVw9hJU4OMg9iSELNwKeJojKHpkJTo+X1ADgz5QGaKMKHIOPfJqzpauWY93fyRfQxPm3+7ER9tTSkCYl1cNZnxl6s0oSEMC7aR62A3T4x0lZhzHg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069476; c=relaxed/simple;
	bh=o54ZjLoKcMYAX56FjleyKUqr6oF9heHKICZtIjYz0xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjk7FCzVgqL5b7FGwVwl98yXomfuQa9JAw5SKWKKONCOs+d5psZMpwqlC54/aJOLCo1rv/soK8aF808MX4mqrsxlwQLEn/9p07VYbPG9KqLKYlf+iUk5AsA/mSyu3HxgeXOuSeoxbAna3cOGXovTUquqBDDZZAeV90T8g58/DVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkcUyIFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC56C113D0;
	Thu, 13 Nov 2025 21:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069476;
	bh=o54ZjLoKcMYAX56FjleyKUqr6oF9heHKICZtIjYz0xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkcUyIFZTrdfZuOv9S8CSUd9Ra61Kaq+raK4O4V8TQ8O8q9srJ9ZLQ/+JdfQihuNZ
	 a6/2n16mkQaCfxWF+jcT6coyjkABonzpa5ErD6vLqLHNiZ+pPXzebf8vx9Se2F544F
	 15uJR6cOfWzLwKCH+nl55uL7d6j+17c5gYt0sQRkQ802DV/Gq8pMCT3Fdviqa+udoM
	 Ns2sCRYP2zXwEVWiOO6M8+YPDCHTXNBxKhIB5Tl7xnaiAaGfj5gMeOEtsJiVkzlL09
	 J9wTnDbBxSjEnucuhVAX22vpM46EbJ6wGbNFFOiaWqjDbDjQJqM5y7iNQSiYtmc40Y
	 7BudUltLRyFKw==
Date: Thu, 13 Nov 2025 22:31:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 42/42] ovl: detect double credential overrides
Message-ID: <20251113-legten-stuhl-ce4187addfa8@brauner>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
 <20251113-work-ovl-cred-guard-v2-42-c08940095e90@kernel.org>
 <CAOQ4uxh5j5wEKRoZrb-Vp+rt3U07A6D2O4Ls_ZWJ9cp2PjR=4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh5j5wEKRoZrb-Vp+rt3U07A6D2O4Ls_ZWJ9cp2PjR=4A@mail.gmail.com>

On Thu, Nov 13, 2025 at 07:42:28PM +0100, Amir Goldstein wrote:
> On Thu, Nov 13, 2025 at 5:38 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Overlayfs always allocates a private copy for ofs->creator_creds.
> > So there is never going to be a task that uses ofs->creator_creds.
> > This means we can use an vfs debug assert to detect accidental
> > double credential overrides.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/overlayfs/util.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index dc521f53d7a3..f41b9d825a0f 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -66,6 +66,8 @@ const struct cred *ovl_override_creds(struct super_block *sb)
> >  {
> >         struct ovl_fs *ofs = OVL_FS(sb);
> >
> > +       /* Detect callchains where we override credentials multiple times. */
> > +       VFS_WARN_ON_ONCE(current->cred == ofs->creator_cred);
> >         return override_creds(ofs->creator_cred);
> >  }
> >
> >
> 
> Unfortunately, this assertion is triggered from
> 
> ovl_iterate() -> ovl_cache_update() -> vfs_getattr() -> ovl_getattr()
> 
> So we cannot add it without making a lot of changes.

Hm, that's an idempotent override so it's fine but idk. I'm not happy
about stuff like this. But fine.

