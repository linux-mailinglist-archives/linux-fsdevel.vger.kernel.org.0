Return-Path: <linux-fsdevel+bounces-66180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74155C185E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 07:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0D7B4F1A0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 06:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606742FB962;
	Wed, 29 Oct 2025 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiNLTNpq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F02E975A;
	Wed, 29 Oct 2025 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761717670; cv=none; b=HFXdC3vcdToJlHSrTgsLn02RvV9LQjGZvBRtbZ+A2yG0DBbv1PxivyL3xP/xof2ny+4NBiAW+YxvF/sC2NawMz2gqXZvlDVqB2H4qq3qQGq8q3E5X31WuVPHSoxvtiJYxbHCPXjf49aAl3AbRYVm23wD1PWQar8JhiAiZ3VcKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761717670; c=relaxed/simple;
	bh=ZI/8Bq9jwlWaFkJKy1t3Vn35o5/zoty1As8rh0A7Mgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7wfvVe5tTPDyO73/XXGPq3c4F6zxEZuzyDmWneXX40oQEbEwAL2Vafnzn4S62NkF7FReJimd+Kk88vw/LHfm801w+Wo9Vytr3FiT7Qq/GJ3Hz18NM7uGgvjDySvMeH19QiUM6D/k1GcJR6vi4HGQLCMMf8+VMOMG5T/33NRpeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiNLTNpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EFFC4CEF7;
	Wed, 29 Oct 2025 06:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761717669;
	bh=ZI/8Bq9jwlWaFkJKy1t3Vn35o5/zoty1As8rh0A7Mgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CiNLTNpqiiR16vTDiciK1fs6YkVHx5vrRoPgsswMnF0FNi8Gq/628PIELz5beHsux
	 Ye1mTu8zj9AVydqL/0+J33J+gc7Kf+IQSMEAXXDVGwceV9zYxiHtODtIQ6UL58cNKr
	 88rP/h9Bb8vTnzzXOJjqwLtIFCKOro+deHKfcmtDZ5Smbr+t9oRaY9iYPr7C80/Mz0
	 xtJXJsNo5cQJfRU+AQawOKb3rmm1HeAovFOK2RWeP0rcRVxeVAqy9lWpgoUUFbwFou
	 Nw3cEEwjtW0GhCOZir3VmxvEvXRifXX6+F+MLPXfgytWxYdp+r+706D4ginRg4lXM+
	 dNZooM5E1dz0A==
Date: Tue, 28 Oct 2025 23:01:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brajesh Patil <brajeshpatil11@gmail.com>
Cc: miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com,
	eperezma@redhat.com, virtualization@lists.linux.dev,
	virtio-fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: Re: [PATCH] fuse: virtio_fs: add checks for FUSE protocol compliance
Message-ID: <20251029060108.GR4015566@frogsfrogsfrogs>
References: <20251028200311.40372-1-brajeshpatil11@gmail.com>
 <20251028200755.GJ6174@frogsfrogsfrogs>
 <c7zugpb4pzquasx67zypnuk2irxvb7cp5puwuw3rncy6gb5wdn@qigavsewium3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7zugpb4pzquasx67zypnuk2irxvb7cp5puwuw3rncy6gb5wdn@qigavsewium3>

On Wed, Oct 29, 2025 at 08:58:30AM +0530, Brajesh Patil wrote:
> On Tue, Oct 28, 2025 at 01:07:55PM -0700, Darrick J. Wong wrote:
> > On Wed, Oct 29, 2025 at 01:33:11AM +0530, Brajesh Patil wrote:
> > > Add validation in virtio-fs to ensure the server follows the FUSE
> > > protocol for response headers, addressing the existing TODO for
> > > verifying protocol compliance.
> > > 
> > > Add checks for fuse_out_header to verify:
> > >  - oh->unique matches req->in.h.unique
> > >  - FUSE_INT_REQ_BIT is not set
> > >  - error codes are valid
> > >  - oh->len does not exceed the expected size
> > > 
> > > Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> > > ---
> > >  fs/fuse/virtio_fs.c | 30 +++++++++++++++++++++++++-----
> > >  1 file changed, 25 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > > index 6bc7c97b017d..52e8338bf436 100644
> > > --- a/fs/fuse/virtio_fs.c
> > > +++ b/fs/fuse/virtio_fs.c
> > > @@ -764,14 +764,34 @@ static void virtio_fs_request_complete(struct fuse_req *req,
> > >  {
> > >  	struct fuse_args *args;
> > >  	struct fuse_args_pages *ap;
> > > -	unsigned int len, i, thislen;
> > > +	struct fuse_out_header *oh;
> > > +	unsigned int len, i, thislen, expected_len = 0;
> > >  	struct folio *folio;
> > >  
> > > -	/*
> > > -	 * TODO verify that server properly follows FUSE protocol
> > > -	 * (oh.uniq, oh.len)
> > > -	 */
> > > +	oh = &req->out.h;
> > > +
> > > +	if (oh->unique == 0)
> > > +		pr_warn_once("notify through fuse-virtio-fs not supported");
> > > +
> > > +	if ((oh->unique & ~FUSE_INT_REQ_BIT) != req->in.h.unique)
> > > +		pr_warn_ratelimited("virtio-fs: unique mismatch, expected: %llu got %llu\n",
> > > +				    req->in.h.unique, oh->unique & ~FUSE_INT_REQ_BIT);
> > 
> > Er... shouldn't these be rejecting the response somehow?  Instead of
> > warning that something's amiss but continuing with known bad data?
> > 
> > --D
> >
> 
> Right, continuing here is unsafe.
> 
> I plan to update the code so that in case of any header validation
> failure (e.g. unique mismatch, invalid error, length mismatch), it
> should skip copying data and jump directly to the section that marks
> request as complete
> 
> Does this seem like a feasible approach?

Yeah, I think you can just set req->out.h.error to some errno (EIO?) and
jump to fuse_request_end, sort of like what fuse_dev_do_write sort of
does.  I think that sends the errno back to whatever code initiated the
request.  I don't know if virtiofs should be throwing an error back to
the server?

--D

> > > +
> > > +	WARN_ON_ONCE(oh->unique & FUSE_INT_REQ_BIT);
> > > +
> > > +	if (oh->error <= -ERESTARTSYS || oh->error > 0)
> > > +		pr_warn_ratelimited("virtio-fs: invalid error code from server: %d\n",
> > > +				    oh->error);
> > > +
> > >  	args = req->args;
> > > +
> > > +	for (i = 0; i < args->out_numargs; i++)
> > > +		expected_len += args->out_args[i].size;
> > > +
> > > +	if (oh->len > sizeof(*oh) + expected_len)
> > > +		pr_warn("FUSE reply too long! got=%u expected<=%u\n",
> > > +			oh->len, (unsigned int)(sizeof(*oh) + expected_len));
> > > +
> > >  	copy_args_from_argbuf(args, req);
> > >  
> > >  	if (args->out_pages && args->page_zeroing) {
> > > -- 
> > > 2.43.0
> > > 
> > > 

