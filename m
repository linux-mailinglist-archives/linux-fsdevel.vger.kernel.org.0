Return-Path: <linux-fsdevel+bounces-5354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A41C80AC36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241582819D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0EF4CB2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzQDJjav"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFE39856
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 17:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD156C433C8;
	Fri,  8 Dec 2023 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702056829;
	bh=ehViIvj8EWpZc/VYO0X5zxilozHUnw9ouMC6az1Rif0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzQDJjavyo7Fnqn2J6Eu5rxsrsM3nKViR+eqCBIr/PSCKYUj6QrL27z+ONYWuiFXg
	 DzgnlGG1pIXcOiTvqp0DDz5MtUnRPsOxUY8qtZuTCTo5ktd4FWlyqBkAGpGGQUdnXl
	 cHD9jLkHYb7//gJWgWgMtW2yuZywuueUj4kfLa3ZuVLsjTA9pE/D8y2MvdbqzocebH
	 M0VsfEScRyUuzOhxOpNbYb/iaOYIb5FxPnB1Wb3VT2yRQkFFUSyN3M5NlPSoq2L0Qh
	 Po/aMflhSuezusS42IKqSRqDtcQcZ7nIfEcrOjvYudjCD4UZdy35toS4hYoOfc1YEi
	 0J+5acidGLpdQ==
Date: Fri, 8 Dec 2023 18:33:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: use splice_copy_file_range() inline helper
Message-ID: <20231208-horchen-helium-d3ec1535ede5@brauner>
References: <20231207123825.4011620-1-amir73il@gmail.com>
 <20231207123825.4011620-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207123825.4011620-2-amir73il@gmail.com>

> +static inline long splice_copy_file_range(struct file *in, loff_t pos_in,
> +					  struct file *out, loff_t pos_out,
> +					  size_t len)
> +{
> +	return splice_file_range(in, &pos_in, out, &pos_out,
> +				      min_t(size_t, len, MAX_RW_COUNT));
> +}

We should really cleanup the return values of the all the splice
helpers. Most callers of splice_file_range() use ssize_t already. So
does splice_direct_to_actor() and splice_to_socket(). IMO, all of the
splice helpers should just be changed to return ssize_t instead of long.
Doesn't have to be in this series though.

