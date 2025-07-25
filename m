Return-Path: <linux-fsdevel+bounces-55992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81173B1154B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B788B16F2BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 00:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466631428E7;
	Fri, 25 Jul 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcaTPV+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E32811CA9;
	Fri, 25 Jul 2025 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403694; cv=none; b=nPQwffAc5+2rTgHz1Y0F0+cLS1DhO9ZYFdMl1+s+G8Ihhd8e1Prk/qTXRoJfA+pVCJTAWE9mxpUNjkPMw3iEfEoi4AnwphkP2IftaArG0CCABAuLzaoZ5cFJ/2rImHdUgkzNr9arSNM8kdqQbEawTAwluFvPO0sicO1g8xEB9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403694; c=relaxed/simple;
	bh=V7NgcOidnNGpMpPbjHZl2z+WhRGJ2bmoE2hfz77Rkxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8/ZKt3/Ggmmf+R8L+oPp6XSXyesqjWpkmXJ8kkJEUZ9otiqyjLc8na4k6bm3zgEdR/EqtkHtjBSoKDlmdeONfrQABRhlBZKTf+Ncj49ck2MWjWBi5nfMW3+elbuI939cH8/ZDD1EddT8hLKBMWlZScjYbY4byAaoMHwZe9IkI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcaTPV+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB00C4CEED;
	Fri, 25 Jul 2025 00:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753403694;
	bh=V7NgcOidnNGpMpPbjHZl2z+WhRGJ2bmoE2hfz77Rkxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TcaTPV+1q0217UeiN+/AvLky2WvFSL/zwEGOQBKjwCBxOI+6t+rVdWK7/lqNzIbmC
	 arpJOOllh50avhktbuP+uCWE6RQJbqg69K9Zfrg0s1ZeChxgUWW1XHm/k5Jyy6pWjd
	 iIqOZCRxk1ipcurq0OzwWEZ6O3lYJtv0mXv2W/Tn01xSVZYfiv9exd9KdWDySlHwoO
	 I1zR5JxsjA4pnhzvagplJpQYl/F8Z4ASc5AGnSKtT4TJGgOkW+20aghkI4YqBvUId9
	 kmprz4bS6cTfqoBce3LSJrZjiv0+oe2+5jzWNn3y4ALuTf8ZHt8n2XuILZZO9DybWA
	 KvfqUu9fCi1pA==
Date: Thu, 24 Jul 2025 17:34:04 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v4 06/15] ceph: move fscrypt to filesystem inode
Message-ID: <20250725003404.GC25163@sol>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
 <20250723-work-inode-fscrypt-v4-6-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-work-inode-fscrypt-v4-6-c8e11488a0e6@kernel.org>

On Wed, Jul 23, 2025 at 12:57:44PM +0200, Christian Brauner wrote:
> +#ifdef CONFIG_FS_ENCRYPTION
> +	.inode_info_offs	= offsetof(struct ceph_inode_info, i_crypt_info) -
> +				  offsetof(struct ceph_inode_info, netfs),
> +#endif

This should use the offset to the VFS inode:

    offsetof(struct ceph_inode_info, netfs.inode)

> +/*
> + * struct inode must be the first member so we can easily calculate offsets for
> + * e.g., fscrypt or fsverity when embedded in filesystem specific inodes.
> + */
> +static_assert(__same_type(((struct netfs_inode *)NULL)->inode, struct inode));
> +static_assert(offsetof(struct netfs_inode, inode) == 0);

Then no need for this.

- Eric

