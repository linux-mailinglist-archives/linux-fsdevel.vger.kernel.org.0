Return-Path: <linux-fsdevel+bounces-28405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3996A0B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E251F29646
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86726374CC;
	Tue,  3 Sep 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHtJFH29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24615688C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373893; cv=none; b=YYtYYrH2/5uAFjhTvLev6GDKzGuYap51/zwgioCImvdVWQipE4odsHE01k1sosA1dHJanwGF4ndv2VNAM/EkSlC1/L/fi31u6ABkaGpzTkfltt99WgemuPCwXBqfsObFcIvp0wUfIh0UzFeJ7rBAplVv0j6urmCdSxO9dN9dDNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373893; c=relaxed/simple;
	bh=rU5hV0tzxrqpUvRgWYZJmh2twN7zBq0feUw6irKmJBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHfMiqHca2S3EuJaEAiXJN++5w9FHqiVM/GCQ070pgZOriFUsmckqJ14k3PMPz7UD+vYTRG75YIwOb62cBkQ+lfv+ETU3K74+YiDDcWu+UjZiLaLJM7JIqRJhJ/6USyKR7mrS/rTiFrjAzbTh/gI/U77q3o3/WiZpMyfqie7f3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHtJFH29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E04C4CED8;
	Tue,  3 Sep 2024 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373893;
	bh=rU5hV0tzxrqpUvRgWYZJmh2twN7zBq0feUw6irKmJBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHtJFH29+GPweZzCUN3jGjIhA/JdQnw96pdhW/TvpV3IZut3kJSWfmHEsxRQ3BUTt
	 hWqdNz7E9/cX8rqj0K5MTZ053Ay6I3prCd22Ibum8KqJKmWMvsZfrv3/ssY+pY7ZZH
	 hQStXuD6xY9VBAHMyyzRRRy/uOayejjQKbiCB4Je8y4ma6Ci7LEHMncFqlw5AEqAMx
	 WVhpBhZK65d4Ul+0LptCzBamNbb2Z+TLgIlMBqAnZdEJOjONMzQGhR4bPiCnqzBbwp
	 sPBnqVvKnSOJnwS36kzJx7B0UdRkWCRl3F3kV5D0xOIyBxVsGEcc4Tmb1FQqT24Yeu
	 74ME/0cDyBpHA==
Date: Tue, 3 Sep 2024 16:31:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 18/20] fs: add f_pipe
Message-ID: <20240903-ernst-besiedeln-e6c9e3f47ef6@brauner>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-18-6d3e4816aa7b@kernel.org>
 <20240903135055.jhcusfiopheb2jej@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903135055.jhcusfiopheb2jej@quack3>

On Tue, Sep 03, 2024 at 03:50:55PM GMT, Jan Kara wrote:
> On Fri 30-08-24 15:04:59, Christian Brauner wrote:
> > Only regular files with FMODE_ATOMIC_POS and directories need
> > f_pos_lock. Place a new f_pipe member in a union with f_pos_lock
> > that they can use and make them stop abusing f_version in follow-up
> > patches.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> What makes me a bit uneasy is that we do mutex_init() on the space in
> struct file and then pipe_open() will clobber it. And then we eventually
> call mutex_destroy() on the clobbered mutex. I think so far this does no

We don't call mutex_destroy() on it and don't need to. And calling
mutex_init() is fine precisely because pipes do use it. It would be
really ugly do ensure that mutex_init() isn't called for pipes. But I'll
add a comment.

