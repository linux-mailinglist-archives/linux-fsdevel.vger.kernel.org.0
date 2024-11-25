Return-Path: <linux-fsdevel+bounces-35773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5259D8534
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 13:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4179EB41AE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6311991D9;
	Mon, 25 Nov 2024 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fo2jFC+q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E2198A19;
	Mon, 25 Nov 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533768; cv=none; b=S7cA2f0kJbGnaONUCMuCWW+IZmZ1R+ttFbgLvIEN+TrapOv6yEOBYqIJKWHKFrOXHB2COXNCaxccP7EkCpPYa/jdSWED4QLLZi1OIkBpyY3FYIPQ+Xb/kT7SAazHbBBHpp8GvWgLnQOvFakZwvBHIxiBj3VW3Q1xd41M8Mi+ptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533768; c=relaxed/simple;
	bh=6HafA0KRF/+3BM26xL0fEBf7N5sS0U2Dr7+T/CzQ1kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiFIRXWBFovKdqkLeua9qW1BwTXV5zDfA89JyGZeUtO+AUvDoe0gtdRpWj6LvoIjWqcqCgtmHll6W40qdAIkRCjz9b+i0v6tfkIeCvD1/AyvGI6FGU3NuXftZTW4dMLpHAqBi3yPLTC9tSnjYOckLGoi3kcqKmIdgcNvTJB53Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fo2jFC+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50485C4CECE;
	Mon, 25 Nov 2024 11:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732533768;
	bh=6HafA0KRF/+3BM26xL0fEBf7N5sS0U2Dr7+T/CzQ1kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fo2jFC+qxBxW50TiP69eT54+pqsvVbuNSALlPudGO8vXDvjz99ow5qJbHp7MkfqCw
	 DULlPMeb+rQTNhaKc0qmuPLwC/viQCB0a+dk7E5y6Mq/6Ui0KlGLDF2M/M8lDMDzXa
	 eKlAmswi3iyrdI3CvirrKlFj9WtJ+LKbCKqiruxothd0E/o6njZ5Y8Oh8JV8hWaXUf
	 1oBR3r/XpWHnczXzaE9t/h0Da1JWKOte6SNNpgR0Dv0oZufjuaSfZcD9G/GuRyaKnW
	 hi4EXtVbFltDStSVBtDFOUa/Fe9lAxlTe8flu//60FAgbJup2PwATetWdnSQ6gFS9s
	 38o0VMpbuBC9A==
Date: Mon, 25 Nov 2024 12:22:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 21/26] smb: avoid pointless cred reference count bump
Message-ID: <20241125-fernweh-autobahn-6006e984ec8b@brauner>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
 <20241124-work-cred-v1-21-f352241c3970@kernel.org>
 <20241124183743.GX3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241124183743.GX3387508@ZenIV>

On Sun, Nov 24, 2024 at 06:37:43PM +0000, Al Viro wrote:
> On Sun, Nov 24, 2024 at 02:44:07PM +0100, Christian Brauner wrote:
> > No need for the extra reference count bump.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/smb/server/smb_common.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
> > index f1d770a214c8b2c7d7dd4083ef57c7130bbce52c..a3f96804f84f03c22376769dffdf60cd66f5e3d2 100644
> > --- a/fs/smb/server/smb_common.c
> > +++ b/fs/smb/server/smb_common.c
> > @@ -780,7 +780,7 @@ int __ksmbd_override_fsids(struct ksmbd_work *work,
> >  		cred->cap_effective = cap_drop_fs_set(cred->cap_effective);
> >  
> >  	WARN_ON(work->saved_cred);
> > -	work->saved_cred = override_creds(get_new_cred(cred));
> > +	work->saved_cred = override_creds(cred);
> >  	if (!work->saved_cred) {
> >  		abort_creds(cred);
> >  		return -EINVAL;
> 
> Won't that leave a dangling pointer?

Afaict, the whole check doesn't make sense because I don't see how
override_creds() could be called on a task with current->cred == NULL.
There's no way to opt out of having current->cred set.

