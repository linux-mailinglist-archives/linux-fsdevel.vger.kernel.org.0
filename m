Return-Path: <linux-fsdevel+bounces-32261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B069A2E0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96675282BE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0088E1C233C;
	Thu, 17 Oct 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Pg4BoAjA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD313D24C;
	Thu, 17 Oct 2024 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194450; cv=none; b=WQdyLtiS2l4/ZXv0UwhO7y1yyUH7vC/Gu9OeyKkwb+J4w/1PA/bU8EU2TVofjNUYOiQBf246ybiuU26lEueMsZtoHcdDxXs/HWwo5kA+9sknQWIKgCmiPkNt5jAsnmv9O2g6cb2+dZL2ggDOlFJlWW2gjCRkwQIqPNHDp+Wm/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194450; c=relaxed/simple;
	bh=XW3f/Wbh98h0phcw1W9jFysotT6hms77v1pNz7sLkRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNOEETErILou0yisuYBkmXXoI/vc4gt332QhmdQHmwEeqXYIosLDtTivNC4keoG6Q2waLdp7uwsrT55sn5pV7AdQW+WmEEpePAfVXFscTzqN4r71Nt6ETwN3Nf/5/zP5747iRLoZcG+MtT4EXFGhKVXukrD2Wn40xNiRolCPlTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Pg4BoAjA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=piSvJWFFEO4RubCC5E7jON/ciF7R8UnqtbDkLoxlou0=; b=Pg4BoAjAqcb5QrKo2Ppv2/OOU0
	GG2hjdx4UwnUe1svJm5+4acF1MIT04UGi/4kXbufS4vLc7adUoDAEX1iLVufLAQS7fHQ/bfyI5VU3
	yOxbpfVLG/WBXDZmn/LSfX7yV+dRI/yQMo/vdaptj8A9p3+65iyKjv8wc5nS1IGoq9cJJ5VcJ52uX
	QhUMj4g/OIsVfwk0j9nAvxzFy8Af4w7xl5yOdlvuUA2NZ6QavpenP/pXztaJl2EzOi+3vCX11L2mG
	xXV87XJxInaj2CTVuJ7Bx2DPqkdabRd7QspcYgxjeUG4E8e0wgcWnugKt7WHSqU2mfhEEch5TbB7J
	Q3fox+hw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1WSz-00000004nui-1ynR;
	Thu, 17 Oct 2024 19:47:25 +0000
Date: Thu, 17 Oct 2024 20:47:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: introduce struct fderr, convert overlayfs uses to that
Message-ID: <20241017194725.GM4017910@ZenIV>
References: <20241003234534.GM4017910@ZenIV>
 <20241003234732.GB147780@ZenIV>
 <CAOQ4uxjS0CX+nA4xqmrrMYDPXRPWMT00+S8z8OMhMWc9omSvMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjS0CX+nA4xqmrrMYDPXRPWMT00+S8z8OMhMWc9omSvMw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 04, 2024 at 12:47:09PM +0200, Amir Goldstein wrote:

> I had already posted an alternative code for overlayfs, but in case this
> is going to be used anyway in overlayfs or in another code, see some
> comments below...

As far as I can see, the current #overlayfs-next kills the case for
struct fderr; we might eventually get a valid use for it, but for the
time being I'm going to strip the overlayfs-related parts of that branch
(obviously), fix the braino you've spotted in fdput() and archive the
branch in case it's ever needed.

> > +#define fd_empty(f)    _Generic((f), \
> > +                               struct fd: unlikely(!(f).word), \
> > +                               struct fderr: IS_ERR_VALUE((f).word))
> 
> 
> I suggest adding a fd_is_err(f) helper to rhyme with IS_ERR().

Umm...  Dropping fd_empty() for that one, you mean?

> > +#define fdput(f)       (void) (_Generic((f), \
> > +                               struct fderr: IS_ERR_VALUE((f).word),   \
> 
> Should that be !IS_ERR_VALUE((f).word)?

It should, thanks for spotting that braino.
 
> or better yet
> 
> #define fd_is_err(f) _Generic((f), \
>                                 struct fd: false, \
>                                 struct fderr: IS_ERR_VALUE((f).word))

I think that's a bad idea; too likely to spill into struct fd users,
with "it's never false here" being a nasty surprise.

