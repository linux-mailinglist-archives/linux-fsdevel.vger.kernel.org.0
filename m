Return-Path: <linux-fsdevel+bounces-55791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFA5B0EDF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 11:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2CA965E39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E4283FE5;
	Wed, 23 Jul 2025 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpseCTyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D9B281351;
	Wed, 23 Jul 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261162; cv=none; b=BWOGpGZA5CX1N9nQpUUH+cSagbqB1P6NR3QUxxISgnAXGP9QHdz2LQAoXEd35+lwZ0GwMKSa27m9lqMkxur1bmNQJ+8qWFhrkJ5ob02164gpESPkmKA0Qu4Crmbez7b1II/6xP3kZHPC0xnfdnrIMeKnfkvsAbMba+SPF2dif+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261162; c=relaxed/simple;
	bh=5BCM6YyJZU6BsobHtv34EG5BdF8xNf/L3o2dNtvsnWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvE12XF4qO/KEHV3hc7zeiA6l/57J29M/hviGdIJDYwzD2QDFAu/+yMQH75x5hOyQ/m3Sr6tDeNwJPAju5XNejNJ/pucAYBSzM+dhi7BjR06EyMiqXPNM8pIpBqo/XP4JOG3hEqjyLVWORwbCQS22RoJnvf8oKQHXKP+Y3m83as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpseCTyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC81DC4CEE7;
	Wed, 23 Jul 2025 08:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753261161;
	bh=5BCM6YyJZU6BsobHtv34EG5BdF8xNf/L3o2dNtvsnWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpseCTyZVnoeNGo6a/nmP6goIS51lKGgzp9cBTgth/Fx4PJuNfIzuPBAz/Q788Zwp
	 bnapZBeiUUJbl4FrYIfa6dludMxlvenbPWC6sm8z1VLQEZKpQYIEMrJapE4WzJIl0o
	 c6Wb9oJctkSyMl9f21Chf4UHktpj3AhyFrJdKL8D+BnsJa9J8y2CqSdHda9g6L0LY1
	 Mn/6PBwayQ0jWal1EXGPusaLfkK3By8eTsSC7hMsEGRj+DTap4hQ6gvxQ6RFrUwEdR
	 nMrnanmNmD9VJMVKaFM2kxUFghdsSyuwZFCjDUMkPXOnBf5xWDGgT3DZbB5pTt75M8
	 jqsvpf1dhpZMA==
Date: Wed, 23 Jul 2025 10:59:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	fsverity@lists.linux.dev
Subject: Re: [PATCH v3 03/13] ext4: move fscrypt to filesystem inode
Message-ID: <20250723-briefe-verwoben-376fbf551939@brauner>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
 <20250722-work-inode-fscrypt-v3-3-bdc1033420a0@kernel.org>
 <20250722200751.GB111676@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722200751.GB111676@quark>

On Tue, Jul 22, 2025 at 01:07:51PM -0700, Eric Biggers wrote:
> On Tue, Jul 22, 2025 at 09:27:21PM +0200, Christian Brauner wrote:
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 18373de980f2..f27d57aea316 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1197,6 +1197,10 @@ struct ext4_inode_info {
> >  	__u32 i_csum_seed;
> >  
> >  	kprojid_t i_projid;
> > +
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	struct fscrypt_inode_info	*i_fscrypt_info;
> > +#endif
> 
> Did you consider keeping the name as i_crypt_info instead of changing it
> to i_fscrypt_info?  The rationale for i_crypt_info in the first place is
> that it's filesystem code, so fs is implied.

Ok.

> 
> I see you also had to replace i_crypt_info with i_fscrypt_info in a
> bunch of comments.  It might make more sense to rephrase those to not
> refer to the exact field name.  E.g. instead of "Set up
> ->i_fscrypt_info", we could write "Set up the inode's fscrypt info".

Ok, I'll do that.

