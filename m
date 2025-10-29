Return-Path: <linux-fsdevel+bounces-66175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B876EC182F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 04:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D69A1C66B81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 03:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832BA2E7F07;
	Wed, 29 Oct 2025 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKsdSKIt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D827D77D
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708519; cv=none; b=pgvreBYwXeQZAB1hm6eeQtlHXTXsYeS6ap1J23Z7T9kxVihJWclRcdRF5o4Bu5R4tqG0bXbmkeNCF9cAzwKkMBGNnjGbVyjS1Jxo3+IVmQT7lzmduluxiyq/j4H8SjAuXWvKDvSAw3PI6/x/Oo0eJVs+cErV0v6/likYW2Nt+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708519; c=relaxed/simple;
	bh=uK0Ge79ImFTTS7GqiWcbUy+z6bqmI9L8dyHzWiVaw7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgg2dX5Xv0YgnS/rB8sJSSe6HCY9OtcYTYzrGyiPUVruYVrsAs71Bp1V63P+OBqvQ0S0hT5uiT/x/76dLWtWMn4U8MjCqHRYB6BASpusr6MMKI+Lu/qyXhxBuhEWE0/p8ymwSOa7wEqOqKU8E6NOBJ4kuGHfM861toyZvZWzgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKsdSKIt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33badfbbc48so8512561a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 20:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761708518; x=1762313318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=myjSnTBkH1I5KQfjqAoij4FYA0X2tqCwC7K0bbUx6vM=;
        b=WKsdSKItOP53AOipmLk4BlSvppjX4I1ti+kwl29Ll0ZLjREyLWKAlbRoJDldCxwzPA
         xCxorqimDv4fMQbJguEz7Rrt1bDxeQyXfN1IuAGcFpr1oG4FAjnZMGmRORCwTqoFlIGs
         l8N53hmJfLNsQJ/C/mAfb7GEjTK4ac1ugV9Q5YjIMEppyUxxUMZfUgcZsGB77VfsmrJK
         0hsqQYLnOfWyQYYWDJzN2jvpgZRIV4KVAyXq9BmreDC/avh+3SEDenw5Ady+AQB9zeJV
         QejGzaLytm2rKzUiQz26HMJNbZnQB0EX0vjgR+Mp25n8NEmCbDO4NTpF0vr4bHOSBCQB
         3aBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761708518; x=1762313318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myjSnTBkH1I5KQfjqAoij4FYA0X2tqCwC7K0bbUx6vM=;
        b=YkyF4VC9DUcHhAcnvsrV3btyyrM+4FBmdD6pEQz+K4P70gm5XvxOyoDoMoSz5n6my+
         SBR60H8ZRjU3Odj//K/9H7csnSGVT71/fjBTMdeXDGcJ+9HNu+ZMoR7oNLArvK/eFH//
         18j5N8jiUXQ1ejAuTDJZWBs6mp8FU8xvO4QDfL6JzIkScR8UlNTSNCfrIVlUrHba+O3O
         GcmPNoKC/6BqS+fHGlV2P3vCS86VkgGKQSpYGPYx6Or0bGWmgvaaCTmwV8KNNraefLYn
         3TcKm2qY3IgnHsFkH1d4GsfDAs4NPWsvvraHhdR+SsJHx6fpUaROgm4qceornTvnJ3Ev
         3bpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1TyO4Q8X0GxYJ5kZdJXQV0fcgPLqPX5c+fIV9nfhAFctC5GqpgpOwQxCxjNYz+s/8DVGEIN4pKCw05gMb@vger.kernel.org
X-Gm-Message-State: AOJu0YwdnbZbzOCgnLgnHvo8VgWtWreGY17rJezdVMwpgxUwWwo71PZ3
	i0EILBSTjIjN81LaLegGBI5kGUAO/WS8xVZkF+5QpdaVflXf+pWO6n6Ui9WVEWNT
X-Gm-Gg: ASbGncuLCtwZ0GKwLk2v74YmOJkQYEe4+Usu8kDL/Z8KScG3pjvNPm7l6u5ODqH0yeq
	mqc/xsB3adB26fElA4Ip5OKtKh9GfTE3C+N56QG8kJmFcGJ0V0cQFDfe9OmmLklGSpxrLduXrKQ
	RaTb4j9UoyK49Em4UUxeuuH5joSNCPOekHNDaovJPx7hWjzF0lBpab9lZUxqRBs8jxAwh4b5SUo
	CSHI6Nyu2ALW7DmLxLzh1rOgZ4DJErJ0xTJu3u5MtNJYePviJy8CKBZsasvMJNYJKnHAZxraP/R
	iARJ0UJGU/08MZ2vreX1EAlc3W9Ny8dmYQnBNc7SJXmxbhaIvIuVqKm1yYx3FcNtYzbWh5nF/gH
	PyKnS1kOnVgNECMSkHwAQhPU6cEsk7Pegle8jkqZXHeCQXCB6lGDMhen2OdJoFZRkcPj2CsIEEx
	ZTTh9mk2yydat30sOFl7JR8n5pMxmluj6IOaG5cxwFOnKcJw==
X-Google-Smtp-Source: AGHT+IE+shhFrtBhmLuIBVFI3puPOu377u7uarNKu4E76VsuPFISVfuzPCA3UmXQVUS6K+bAe4aLCg==
X-Received: by 2002:a17:902:da85:b0:262:cd8c:bfa8 with SMTP id d9443c01a7336-294deed21abmr17081115ad.34.1761708517614;
        Tue, 28 Oct 2025 20:28:37 -0700 (PDT)
Received: from brajesh ([2401:4900:16aa:e584:a673:aa72:32da:dbb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40a7esm135335605ad.70.2025.10.28.20.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 20:28:37 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:58:30 +0530
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, virtio-fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, khalid@kernel.org
Subject: Re: [PATCH] fuse: virtio_fs: add checks for FUSE protocol compliance
Message-ID: <c7zugpb4pzquasx67zypnuk2irxvb7cp5puwuw3rncy6gb5wdn@qigavsewium3>
References: <20251028200311.40372-1-brajeshpatil11@gmail.com>
 <20251028200755.GJ6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028200755.GJ6174@frogsfrogsfrogs>

On Tue, Oct 28, 2025 at 01:07:55PM -0700, Darrick J. Wong wrote:
> On Wed, Oct 29, 2025 at 01:33:11AM +0530, Brajesh Patil wrote:
> > Add validation in virtio-fs to ensure the server follows the FUSE
> > protocol for response headers, addressing the existing TODO for
> > verifying protocol compliance.
> > 
> > Add checks for fuse_out_header to verify:
> >  - oh->unique matches req->in.h.unique
> >  - FUSE_INT_REQ_BIT is not set
> >  - error codes are valid
> >  - oh->len does not exceed the expected size
> > 
> > Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> > ---
> >  fs/fuse/virtio_fs.c | 30 +++++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 6bc7c97b017d..52e8338bf436 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -764,14 +764,34 @@ static void virtio_fs_request_complete(struct fuse_req *req,
> >  {
> >  	struct fuse_args *args;
> >  	struct fuse_args_pages *ap;
> > -	unsigned int len, i, thislen;
> > +	struct fuse_out_header *oh;
> > +	unsigned int len, i, thislen, expected_len = 0;
> >  	struct folio *folio;
> >  
> > -	/*
> > -	 * TODO verify that server properly follows FUSE protocol
> > -	 * (oh.uniq, oh.len)
> > -	 */
> > +	oh = &req->out.h;
> > +
> > +	if (oh->unique == 0)
> > +		pr_warn_once("notify through fuse-virtio-fs not supported");
> > +
> > +	if ((oh->unique & ~FUSE_INT_REQ_BIT) != req->in.h.unique)
> > +		pr_warn_ratelimited("virtio-fs: unique mismatch, expected: %llu got %llu\n",
> > +				    req->in.h.unique, oh->unique & ~FUSE_INT_REQ_BIT);
> 
> Er... shouldn't these be rejecting the response somehow?  Instead of
> warning that something's amiss but continuing with known bad data?
> 
> --D
>

Right, continuing here is unsafe.

I plan to update the code so that in case of any header validation
failure (e.g. unique mismatch, invalid error, length mismatch), it
should skip copying data and jump directly to the section that marks
request as complete

Does this seem like a feasible approach?

> > +
> > +	WARN_ON_ONCE(oh->unique & FUSE_INT_REQ_BIT);
> > +
> > +	if (oh->error <= -ERESTARTSYS || oh->error > 0)
> > +		pr_warn_ratelimited("virtio-fs: invalid error code from server: %d\n",
> > +				    oh->error);
> > +
> >  	args = req->args;
> > +
> > +	for (i = 0; i < args->out_numargs; i++)
> > +		expected_len += args->out_args[i].size;
> > +
> > +	if (oh->len > sizeof(*oh) + expected_len)
> > +		pr_warn("FUSE reply too long! got=%u expected<=%u\n",
> > +			oh->len, (unsigned int)(sizeof(*oh) + expected_len));
> > +
> >  	copy_args_from_argbuf(args, req);
> >  
> >  	if (args->out_pages && args->page_zeroing) {
> > -- 
> > 2.43.0
> > 
> > 

