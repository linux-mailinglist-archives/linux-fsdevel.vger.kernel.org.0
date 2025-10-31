Return-Path: <linux-fsdevel+bounces-66554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E56FC236B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 07:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0615189A446
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 06:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAAC2F9DBC;
	Fri, 31 Oct 2025 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btC5pFhw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6FA2E6125
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892672; cv=none; b=MIygNioDEgOb4vfEHC7pmanjIUihs8S+76nksHN4zuqbn8EQ4PKeZbJvwEgc5PZAcKQcbuAZip2w8sjsrwnUG2xNoYop0mAWM9AZ2TUMcC5rfbwggLc0ooKgCNkTpZkMhGKuNeaMfJtcliZvEGMAfsnfwLGezqGQJ7ZJZAoaC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892672; c=relaxed/simple;
	bh=2Ad22H+YKv3fYSdPT9lbgu9VOjM2ntNDuMEpDFLqgtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOz24fwRqBhTtlu9KsPZZdkZm622eBY5iif80Bplnc0+DiXHFAX15DiLIMSAoDXkjZmyhWziFRxyEQSwx4/OwbXsdMaik/WmtCLN0w5QGJHKnp09B3KreZRlClz5IZH+6cxveQjo6TAWDMdoTKwqqjMc/kEKksETkvGqp1f6r2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btC5pFhw; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63bcfcb800aso2135062d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 23:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761892669; x=1762497469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kS/Ba8wi03ja6q2G16rK+mBdR0oPZku80viIJSVlHq8=;
        b=btC5pFhw9xkOhNITbRDEeX7IBMIZfwYedGjRscgJPL5mMye3/SMxm9v29/ac19vzwa
         dfn+IkIVJgQ+WMC3khNXLZ/sAn8v2ZWJzzt4+lYibX0NFt5ohfLfAe88GKdp8C7ATn3h
         NWXy1qWWHI/aocmoy/uBTMz/tBTNShHJHaXE9sypj30n8Rt5VnOeGtxAV3Z1w1NlCP0P
         KK9xOks9qIIXQIOdqIi1yYlXq4PNaF9XjaF7KP6j9h+/mI1fdV/f4820a3lPFvwcSNKC
         TGZ/zLnCd+MF54M+dO8vkYPhQAOr4zg20T+w3VqEnRRvET27VeU137sewizuwgVlnG6y
         ZBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761892669; x=1762497469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS/Ba8wi03ja6q2G16rK+mBdR0oPZku80viIJSVlHq8=;
        b=OTtNEyppmCESgUftojTcNFwm7gbgeMdg8/zWEZC1iEsupJ86G8FrU/Okl0BQkX59zJ
         QXqaVzG8IYvl1FfD0zJtg5UhnsbEAHIMmezF0kCGqGeg5iWNq+IKVOEJEbSh0sSZcDrB
         W9szUTVRYtt21hqIOHmvDf5Zomd3BAV77xpE5C4BBQylw+J8XhuK8ojRPzDlVN2LMUkC
         t9JFm3u0SkDhvzgIuq0KPWbEVL1exRH5M0MpyUvrKvmguDJAw0E/r+HNjVqsp6m0tn/j
         xumyDOUbLi9CetPOy65F/4FrQYE5/h+twH5gc/wS4jFFxCfp8zpPnIsus51FamH4LiaW
         +GaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0jJgBQDjMFFQOPUUUHRz35ub/+HMhPJn882EwZVbdEETtI58nX3CWI1Yp0FO2SJZDPhG//JvAV2Uw06od@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5h4V893tSvQEj1ObaYvWFcod0l1JyV/DYkEOgoaOgEWNyaAk
	RsqltszWzJTH4wQMkFlO7DaxEgHR8ycFCDsxtPpYjcdaNZeHFxyBwWlK
X-Gm-Gg: ASbGncux6ExEWoRmAGtQQ3CEYuRKqJkDywpeJWCWC6ypJPzUgwOMZz5jmpIe5GwYylY
	hrbOdk3Z27zRkZHrRU3BgRo+QUTlam4OK0nB35nXyBuT4Qgg7PqRcSqA6WgA0YF5s1ExFA7T05l
	e2rbfs3qMpstH9s8x+L1Ktw58WWFgDSnwyQgviFCm1WclzDj/D0WSJ1HzObcOwjALg/opqIq8K8
	tYksJ9SeolQYsxRu6a+H9iFPiYIwnRjm5Hk+/vn2BcmdBsTjPFJCgawjs1AokwreyXS5l7ksOL/
	rb14yPzCDHxNPJtTUhSbWNDwfaa+VvU/83v3DPYI9Sgq2O6YvhvT800Hj/ceV/SdCnn/vCSR/4d
	cQ1qIsqVrzdWcGmpiHwEmr7lM5k3LslHE2Fx7o+ixvsLz9EtqVLEgIKo3HvgK4SaFqMErrR1m82
	+AcV7h9mC7RPzcApSDBqWi8fhebtf6Z6H+opN4rT4=
X-Google-Smtp-Source: AGHT+IE8N0NuNxDPSMdh3gqIxDWFygZpV4mjnnnjXKw/xdAOq6rsstqv2KVKzg0erHaerfWTmEpODA==
X-Received: by 2002:a05:690e:282:b0:63f:8734:36a0 with SMTP id 956f58d0204a3-63f92272105mr1346690d50.21.1761892669464;
        Thu, 30 Oct 2025 23:37:49 -0700 (PDT)
Received: from vegg ([2402:a00:163:2ce9:84ab:c8ef:8e7:edf3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7864c667d3dsm2850837b3.42.2025.10.30.23.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 23:37:48 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:07:40 +0530
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com,
	eperezma@redhat.com, virtualization@lists.linux.dev,
	virtio-fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: Re: [PATCH] fuse: virtio_fs: add checks for FUSE protocol compliance
Message-ID: <20251031063740.tyeewgtp7zo2gdi3@vegg>
References: <20251028200311.40372-1-brajeshpatil11@gmail.com>
 <20251028200755.GJ6174@frogsfrogsfrogs>
 <c7zugpb4pzquasx67zypnuk2irxvb7cp5puwuw3rncy6gb5wdn@qigavsewium3>
 <20251029060108.GR4015566@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029060108.GR4015566@frogsfrogsfrogs>

On Tue, Oct 28, 2025 at 11:01:08PM -0700, Darrick J. Wong wrote:
> On Wed, Oct 29, 2025 at 08:58:30AM +0530, Brajesh Patil wrote:
> > On Tue, Oct 28, 2025 at 01:07:55PM -0700, Darrick J. Wong wrote:
> > > On Wed, Oct 29, 2025 at 01:33:11AM +0530, Brajesh Patil wrote:
> > > > Add validation in virtio-fs to ensure the server follows the FUSE
> > > > protocol for response headers, addressing the existing TODO for
> > > > verifying protocol compliance.
> > > > 
> > > > Add checks for fuse_out_header to verify:
> > > >  - oh->unique matches req->in.h.unique
> > > >  - FUSE_INT_REQ_BIT is not set
> > > >  - error codes are valid
> > > >  - oh->len does not exceed the expected size
> > > > 
> > > > Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> > > > ---
> > > >  fs/fuse/virtio_fs.c | 30 +++++++++++++++++++++++++-----
> > > >  1 file changed, 25 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > > > index 6bc7c97b017d..52e8338bf436 100644
> > > > --- a/fs/fuse/virtio_fs.c
> > > > +++ b/fs/fuse/virtio_fs.c
> > > > @@ -764,14 +764,34 @@ static void virtio_fs_request_complete(struct fuse_req *req,
> > > >  {
> > > >  	struct fuse_args *args;
> > > >  	struct fuse_args_pages *ap;
> > > > -	unsigned int len, i, thislen;
> > > > +	struct fuse_out_header *oh;
> > > > +	unsigned int len, i, thislen, expected_len = 0;
> > > >  	struct folio *folio;
> > > >  
> > > > -	/*
> > > > -	 * TODO verify that server properly follows FUSE protocol
> > > > -	 * (oh.uniq, oh.len)
> > > > -	 */
> > > > +	oh = &req->out.h;
> > > > +
> > > > +	if (oh->unique == 0)
> > > > +		pr_warn_once("notify through fuse-virtio-fs not supported");
> > > > +
> > > > +	if ((oh->unique & ~FUSE_INT_REQ_BIT) != req->in.h.unique)
> > > > +		pr_warn_ratelimited("virtio-fs: unique mismatch, expected: %llu got %llu\n",
> > > > +				    req->in.h.unique, oh->unique & ~FUSE_INT_REQ_BIT);
> > > 
> > > Er... shouldn't these be rejecting the response somehow?  Instead of
> > > warning that something's amiss but continuing with known bad data?
> > > 
> > > --D
> > >
> > 
> > Right, continuing here is unsafe.
> > 
> > I plan to update the code so that in case of any header validation
> > failure (e.g. unique mismatch, invalid error, length mismatch), it
> > should skip copying data and jump directly to the section that marks
> > request as complete
> > 
> > Does this seem like a feasible approach?
> 
> Yeah, I think you can just set req->out.h.error to some errno (EIO?) and
> jump to fuse_request_end, sort of like what fuse_dev_do_write sort of
> does.  I think that sends the errno back to whatever code initiated the
> request.  I don't know if virtiofs should be throwing an error back to
> the server?
> 
> --D
> 

I think it is okay to set oh.error in fuse_dev_do_write as it is a server side
reply. But as virtio_fs is on the client side and oh.error has been set by
virtiofsd, I think so we should not overwrite oh.error. Instead, if we
encounter an error in any of the if conditions, skip copying arguments and jump
to the line clear_bit(FR_SENT, &req->flags).

> > > > +
> > > > +	WARN_ON_ONCE(oh->unique & FUSE_INT_REQ_BIT);
> > > > +
> > > > +	if (oh->error <= -ERESTARTSYS || oh->error > 0)
> > > > +		pr_warn_ratelimited("virtio-fs: invalid error code from server: %d\n",
> > > > +				    oh->error);
> > > > +
> > > >  	args = req->args;
> > > > +
> > > > +	for (i = 0; i < args->out_numargs; i++)
> > > > +		expected_len += args->out_args[i].size;
> > > > +
> > > > +	if (oh->len > sizeof(*oh) + expected_len)
> > > > +		pr_warn("FUSE reply too long! got=%u expected<=%u\n",
> > > > +			oh->len, (unsigned int)(sizeof(*oh) + expected_len));
> > > > +
> > > >  	copy_args_from_argbuf(args, req);
> > > >  
> > > >  	if (args->out_pages && args->page_zeroing) {
> > > > -- 
> > > > 2.43.0
> > > > 
> > > > 

