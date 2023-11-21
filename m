Return-Path: <linux-fsdevel+bounces-3318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74617F326D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 16:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8185F2826F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566785810D;
	Tue, 21 Nov 2023 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXDNi9Fk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBE482EE
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 15:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A506BC433C9;
	Tue, 21 Nov 2023 15:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700580942;
	bh=f0M6mBjYFCjscRiTm2gWAQ4liqqsKNWnvUBBmTWErrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXDNi9FkhJYnLj/uwP2hLc+IQunRnLpt+t/izpkE/6Z1+IG0q42nPPweChrDcmOi7
	 9/REo6fktYV4kIRkBYgA9AtmQt9EzvLCoHQNPgxnlrthDKY8VUf/3HbHFuZBoXQ7um
	 By8hdNPfzBTW+xwpEC+FbP9qPyIbRXWzJl3vCmcqC3x2yZPA9E2KZ4Jtd36NpoQtcu
	 21LtKvzoeOEWfp8rrPQvaZOmArZ2KlcLQwTB6v+LUPEQm6DrqdFzGZ7NoQbVELLTvX
	 5dctN1p8cFsuu4VeSHbSM6ngIoTmi2oiVrsU5P9KQuXpMVa3U+A90P061YAPL2P6h2
	 a/EOhyXWSVM8g==
Date: Tue, 21 Nov 2023 16:35:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/15] fs: move permission hook out of do_iter_read()
Message-ID: <20231121-weinwirtschaft-diametral-71cdad14d4be@brauner>
References: <20231114153321.1716028-1-amir73il@gmail.com>
 <20231114153321.1716028-12-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231114153321.1716028-12-amir73il@gmail.com>

>  static ssize_t do_iter_read(struct file *file, struct iov_iter *iter,
> -		loff_t *pos, rwf_t flags)
> +			    loff_t *pos, rwf_t flags)
> +{
> +	if (file->f_op->read_iter)
> +		return do_iter_readv_writev(file, iter, pos, READ, flags);
> +	else
> +		return do_loop_readv_writev(file, iter, pos, READ, flags);
> +}

That else doesn't serve a purpose here. I would just remove it. Easier
on the eye too.

