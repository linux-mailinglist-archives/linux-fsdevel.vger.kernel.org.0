Return-Path: <linux-fsdevel+bounces-55776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C7B0E955
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 05:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38713A705D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 03:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443A1E04AD;
	Wed, 23 Jul 2025 03:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kX7Rwi8+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C00E2AE72;
	Wed, 23 Jul 2025 03:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753242551; cv=none; b=sSaYGIu1hz64cqGLl/SB7F4gdbLBaYsLLssdkSph5uNnE/uQMdLHHIxAq6OVOqnGKsOXTUwbdNrWqu9mGmpavq7h++9E8xh/NXWR465mgmDHGEVijWOdfIdAS8TQb5IQNb7aDnQfE4VvkE6+Qwqp5scFK6S+EV2B6ls0AM/3NZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753242551; c=relaxed/simple;
	bh=uP8pg53IOW1x+mnBF9LVUJmo/Px1+Dd9C0NDn8AHZ68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA4n+qrhCtuYbNMWJ7fvLbTg8mG7wn+ml9svBevANd8PRPKcfqxYLxrhnrkFf3P/En3gTOw/ySNT23VjAysKSzjWImATag5RLOi2pBvMJMeT2oo9037ixhpVCPKlHMI3j+Cd+wuCymbeQ3/l32I8vfqLsBCIUnX5koMExsVckeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kX7Rwi8+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q5RU45U8nmhOn3JoGvW7gjfJN0+I6bGK6xzj0rg2pJ0=; b=kX7Rwi8+cQFEyz9f+GGinQ4tZ5
	S3+nzms96Xhf+Rj5eyPkV/AB0/sWrurrZBvB88KSFRWmrySGuaCtobAVkoLQbFz5rC9sZO11BqpQd
	eN8/gjN1xkKvRLWu2Sg8A1urBbdtQcIZcPOkAPsrS8vOZAjIxqV2Vb510f37JJ/wXRiUUWFz/eSC+
	DRG2WfYwRk+il38T5HUW7vZQ11rkjHpwnq2Lg0esX7NYhs90x8pFP336pI6WhkqvGXtYHPt065wfO
	iIyJb2KbuskmNX679BdLbjUzpDmpQlHVihmIcV6FMV3L+Tv0EFfGj14GSVwhBcfPd7+yAcVFgzkak
	AtdjFKuw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueQTW-00000005d95-1zeb;
	Wed, 23 Jul 2025 03:49:02 +0000
Date: Wed, 23 Jul 2025 04:49:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v3 01/13] fs: add fscrypt offset
Message-ID: <20250723034902.GN2580412@ZenIV>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
 <20250722-work-inode-fscrypt-v3-1-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-work-inode-fscrypt-v3-1-bdc1033420a0@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 22, 2025 at 09:27:19PM +0200, Christian Brauner wrote:
> Store the offset of the fscrypt data pointer from struct inode in struct
> super_operations. Both are embedded in the filesystem's private inode.
> 
> This will allow us to drop the fscrypt data pointer from struct inode
> itself and move it into the filesystem's inode.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/fs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 96c7925a6551..991089969e71 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2332,6 +2332,7 @@ enum freeze_holder {
>  };
>  
>  struct super_operations {
> +	ptrdiff_t i_fscrypt;

Umm...  Why not put that into super_block itself?

