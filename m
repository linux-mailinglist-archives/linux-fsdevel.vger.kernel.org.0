Return-Path: <linux-fsdevel+bounces-56012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4806B119A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 10:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C023B26F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 08:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC5BA36;
	Fri, 25 Jul 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdtSNx9k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73518DF62;
	Fri, 25 Jul 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431326; cv=none; b=Vz0PiObLEM48LOz+Zaqy3ZoFtVv+S0IfFBZGZpGonJL0nW1XSJUQuta6ZtiMxWSmHhnPNKaH7BqBbtdMtrEJGTJQUe1jwHFkYqlMM7jTmRKi9smF3d4Okl66F6v9D0g3LAiBAdOj1gtWjK+ykEvAWKhROI1AimGe4q0jK4ePA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431326; c=relaxed/simple;
	bh=+sT9dUqPEv8gyTOb1EsWdKkMIkRtW9uKzE3TK7yY4N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QytLncj6UTZP09OHBPaIh0ZE3Zdfvv6hMrrjmfr8d0/V9JygBslK4a06DcvxF0vVODVETuUSyQz2pozHjZ5BweL8OZoegEi4lGy0isgfxXpnNCHkEgp5KK6vsLtlXK45ikUG5M0L0H+J6idWGu2pFEpgs8yc3CGNXaU07kKwDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdtSNx9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91002C4CEE7;
	Fri, 25 Jul 2025 08:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753431325;
	bh=+sT9dUqPEv8gyTOb1EsWdKkMIkRtW9uKzE3TK7yY4N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdtSNx9kAF+eaoLwvupTuwwLFMjAgwTKKMjI0h54lecJL0kKgMNL0tzKtT4/29you
	 Yv5YdHX6lTkAs6hUtqp0DP5OqprIhAamAI0X15LWK9g7HFkoHP4AzW6UOTKZl2KnmE
	 aPIDiLtGVBVy9BFbkWeIrer9uuBToW7rVY3RO7AH0mazGy1Y6hQ/zcf6WRm4NuXNV/
	 JVJYb6Nu8ltd0CFhAYLWqV84LnEGgYr6pvFXFmfQS1CH52mjl10z9NBKKDwvyqeE6+
	 EI+xaD3OUF1tA5oAKWQEJLKnfq4eI9bhPPBYwKPP6r4d+sFhnzc0yl5jx3xPOdytU3
	 3DDxZbkAdEwsQ==
Date: Fri, 25 Jul 2025 10:15:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	fsverity@lists.linux.dev
Subject: Re: [PATCH v4 06/15] ceph: move fscrypt to filesystem inode
Message-ID: <20250725-idiotensicher-student-62440e8170f3@brauner>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
 <20250723-work-inode-fscrypt-v4-6-c8e11488a0e6@kernel.org>
 <20250725003404.GC25163@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725003404.GC25163@sol>

On Thu, Jul 24, 2025 at 05:34:04PM -0700, Eric Biggers wrote:
> On Wed, Jul 23, 2025 at 12:57:44PM +0200, Christian Brauner wrote:
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	.inode_info_offs	= offsetof(struct ceph_inode_info, i_crypt_info) -
> > +				  offsetof(struct ceph_inode_info, netfs),
> > +#endif
> 
> This should use the offset to the VFS inode:
> 
>     offsetof(struct ceph_inode_info, netfs.inode)
> 
> > +/*
> > + * struct inode must be the first member so we can easily calculate offsets for
> > + * e.g., fscrypt or fsverity when embedded in filesystem specific inodes.
> > + */
> > +static_assert(__same_type(((struct netfs_inode *)NULL)->inode, struct inode));
> > +static_assert(offsetof(struct netfs_inode, inode) == 0);
> 
> Then no need for this.

Ok.

