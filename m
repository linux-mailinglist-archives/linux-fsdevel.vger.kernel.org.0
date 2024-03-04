Return-Path: <linux-fsdevel+bounces-13552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C7B870BCB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 21:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F0F1F23406
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E7FF9EC;
	Mon,  4 Mar 2024 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htSrteYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC1DF62;
	Mon,  4 Mar 2024 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585359; cv=none; b=o/eZ5OY2NPiTRdVKpXkyrHcJqlSevOHYPfME3tDcSwGBSyHBv/dCNdbhnjmEDPfNq5V9hRxJbU1a4EW5sjIv+3ZYyuGdZ9EoD1wh4K7PlD19ybLlqru6JJJJiMqCfDhnXVbeJlmtekCdlxnl4QGWr8UF7IHijpt4MeRGfid0HtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585359; c=relaxed/simple;
	bh=qA3wp40s0TgC64C968JuBW0iFlvYudGYXaZL0z1kdos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNtD9UAfCt59Wp/XDus+doG8qelyNx0qY2U8IviEsVmFmNltjgV9IgQNKslEAWwl1LKQ9MhS0flUGmjUvjZ23pallDqrNaJwtpMo9UTGQ5jsqJ96h/4Tk2GLsNy7TDAl/udCg78O0GEwRtdxcwYz48CBFumh5qinu1pe5H8TyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htSrteYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA32C433F1;
	Mon,  4 Mar 2024 20:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709585358;
	bh=qA3wp40s0TgC64C968JuBW0iFlvYudGYXaZL0z1kdos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htSrteYGSxexp0AIPLEosWQkDIN/m6PR9JxkE7YMbfJC9ZYAS3Hjdjp3GsWNyP5Nb
	 3broy/k5GhDk6z2uuzzpHLM5tMwxwpYt3gatQkkD8WFMsqaoldGzu5GgDjP/+3mQFr
	 2Tqa0OlDqRD/I/cvuzBAVgHftrz6GKVdVnae/4l2x6sa0We60wT3Ku3tv4zQpC74yc
	 Pp1JJrQoNxIknbKKIdhvc5p3ESuJTgwLypXD6ugUW6sfidZMU5pN1xP2zFAg2Gagvk
	 y5ej6/i506V0lSge/eaozpTXCXNx4EMzJH0T28J+hVTs/tMbOlyKTzCJgRcGYkzj6m
	 /9nnb1D1Xmq9Q==
Date: Mon, 4 Mar 2024 12:49:16 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O
 submitted via libaio
Message-ID: <20240304204916.GD1195@sol.localdomain>
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-2-bvanassche@acm.org>
 <20240304191047.GB1195@sol.localdomain>
 <73d9e8a1-597a-46fc-b81c-0cc745507c53@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d9e8a1-597a-46fc-b81c-0cc745507c53@kernel.dk>

On Mon, Mar 04, 2024 at 01:09:15PM -0700, Jens Axboe wrote:
> > If I understand correctly, this patch is supposed to fix a memory
> > safety bug when kiocb_set_cancel_fn() is called on a kiocb that is
> > owned by io_uring instead of legacy AIO.  However, the kiocb still
> > gets accessed as an aio_kiocb at the very beginning of the function,
> > so it's still broken:
> >
> > 	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
> > 	struct kioctx *ctx = req->ki_ctx;
> >
> Doesn't matter, they are both just pointer math. But it'd look cleaner
> if it was below.

It dereferences the pointer.

> 
> > I'm also wondering why "ignore" is the right fix.  The USB gadget
> > driver sees that it has asynchronous I/O (kiocb::ki_complete != NULL)
> > and then tries to set a cancellation function.  What is the expected
> > behavior when the I/O is owned by io_uring?  Should it perhaps call
> > into io_uring to set a cancellation function with io_uring?  Or is the
> > concept of cancellation functions indeed specific to legacy AIO, and
> > nothing should be done with io_uring I/O?
> 
> Because the ->ki_cancel() is a hack, as demonstrated by this issue in
> teh first place, which is a gross layering violation. io_uring supports
> proper cancelations, invoked from userspace. It would never have worked
> with this scheme.

Maybe kiocb_set_cancel_fn() should have a comment that explains this?

- Eric

