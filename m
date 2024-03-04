Return-Path: <linux-fsdevel+bounces-13520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F68870A22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986C3B23BE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDA778B5A;
	Mon,  4 Mar 2024 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGp6x3/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915278B50;
	Mon,  4 Mar 2024 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579449; cv=none; b=iSkCV8zksgKr++fpBtz8BQ0yuOyLhODEAVLuYLRAwIgzOxGEyqN6BOw9hxj9ofBZtCwgNAChda4CFLHpBRB69gKexJbioM1b1AlEYv4JbsdgyMj1D5vgmv7GVHUjZ9Rhlq+t113Nwfo55I0S7wekZPOe2YS7DlISAiPZG3mIktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579449; c=relaxed/simple;
	bh=qDXQZV9g9URQJWyf/qmL5My5YsfLz7i43QNkKvtw1Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSJeQiJlPY5bmeYFl1AuvN6QgcKBgfjASzpzdQ3/OoOMaUBHYjqHWxNArZ1I2xfl7LZoQYLOisBya6f7/k5dPKuym5P6IBAxG0ly8LdtXeQ8Xy5fvXO8qOyBW3IhK8nRLA3xwEVXMQ7wEOee7y5FqByLijzJUmSED0ZgUlp9gKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGp6x3/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40E1C433F1;
	Mon,  4 Mar 2024 19:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709579449;
	bh=qDXQZV9g9URQJWyf/qmL5My5YsfLz7i43QNkKvtw1Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGp6x3/uLvlmb5CN7G5MkD2WZTAWvOBAYCnC8/o/rcttSM8T+XxQhQChN3t1nyXG9
	 EEPMCisBP4jqkLXLHX5w10LihtiVZSzjL5YDpDNPJ67Fw4g4xiQb/zg4ZSDuhvz/xx
	 URJ7RrtDJq+6eWhBpxkrFFEtVDWMilctbl9ufDI6q/uy+19tetf0tZ0Orjc81Ndc1m
	 00hKxDapZ95pbhPuyp51eHONqaqD/92KmWK01NL9q1L/lAEyJbQZ/PILFWq11Iyx5C
	 zMH9zqf75rUCSuFz25at/HVRzASmvUQWnBo1062nOzrCFXkSBeQL3Hxd/xdzts11m3
	 UPJaOVlcB/tNw==
Date: Mon, 4 Mar 2024 11:10:47 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Avi Kivity <avi@scylladb.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O
 submitted via libaio
Message-ID: <20240304191047.GB1195@sol.localdomain>
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215204739.2677806-2-bvanassche@acm.org>

On Thu, Feb 15, 2024 at 12:47:38PM -0800, Bart Van Assche wrote:
> void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
> {
>	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
>	struct kioctx *ctx = req->ki_ctx;
>	unsigned long flags;
>  
> +	/*
> +	 * kiocb didn't come from aio or is neither a read nor a write, hence
> +	 * ignore it.
> +	 */
> +	if (!(iocb->ki_flags & IOCB_AIO_RW))
> +		return;
> +
>  	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
>  		return;
>  

If I understand correctly, this patch is supposed to fix a memory safety bug
when kiocb_set_cancel_fn() is called on a kiocb that is owned by io_uring
instead of legacy AIO.  However, the kiocb still gets accessed as an aio_kiocb
at the very beginning of the function, so it's still broken:

	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
	struct kioctx *ctx = req->ki_ctx;

I'm also wondering why "ignore" is the right fix.  The USB gadget driver sees
that it has asynchronous I/O (kiocb::ki_complete != NULL) and then tries to set
a cancellation function.  What is the expected behavior when the I/O is owned by
io_uring?  Should it perhaps call into io_uring to set a cancellation function
with io_uring?  Or is the concept of cancellation functions indeed specific to
legacy AIO, and nothing should be done with io_uring I/O?

- Eric

