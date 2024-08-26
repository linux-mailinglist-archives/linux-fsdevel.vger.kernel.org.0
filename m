Return-Path: <linux-fsdevel+bounces-27172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C6795F267
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14A428281C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 13:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFB317BEDB;
	Mon, 26 Aug 2024 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW2kLdfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084810F7;
	Mon, 26 Aug 2024 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677734; cv=none; b=UqTWmQ043gk8GrIAlG0VMUgEZh6doHBgiuvN4uTXCISg400vFnRvASymP4eAw8l2JeYR7M9kpvyoApCpdE2jtBqyCNeZ6ZWXS7D0tBTkfW2nHRGm9VidrXJ0On18l4apPHTplRXBDHpXCRsDiMPC4oLbE6Y7TgLNZ9MCSVabJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677734; c=relaxed/simple;
	bh=BRONPixzBL0ZszZpb2xwZFsJg5ZB3SZbawc7G5yzV58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRGZ/U+j2jq5wBnbfzwdkmW6cm7dT73xmgHnQgycxZDqphko3pxI4F2mgmVMM3ZoGrpV3DFSpHYVBDOMtz75fqvWJqkmiHGhLyKAbFVjm6nK5gFiioX5uQ+Xm41IYBSVpcLJxYikD2U3BmOxNWpEz9eybSS6vorw8ZX3oLRh2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW2kLdfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6AAC56890;
	Mon, 26 Aug 2024 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724677733;
	bh=BRONPixzBL0ZszZpb2xwZFsJg5ZB3SZbawc7G5yzV58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jW2kLdfk+I4ftnJrw0QXlqy0m0RbtkcKqstKGg9L0LO15XukG4H2837ido4aW1/7b
	 1QzNh/4RZBwzRJBxqY5LeSmqhT2M6BVwzuY2BXjYRFtBL+bRlmnWLs+JUwiNL5mrKW
	 xPprQHb1eJWlgwG+IRLJKB+CheIJKWQ6tx7dadhd7uhvdySh43ozmc6varjD9/16sO
	 hRuJb7LL87s/oE52O65CVi/dLuRwvrzdZucfBPsO8ZpJeIi8ftxNqYGhSjUOg2hdi5
	 EJ79JRHTCfDaPr2axXLEyCOWEX+WBJn7sgeznyW07INKQaUsg6NxKbodAPYU2fGu8J
	 yAoMtZx3MrJ1A==
Date: Mon, 26 Aug 2024 15:08:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, Tom Haynes <loghyr@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 5/7] fs: add an ATTR_CTIME_DLG flag
Message-ID: <20240826-glasdach-zaudern-ee3d4761973c@brauner>
References: <20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org>
 <20240826-delstid-v2-5-e8ab5c0e39cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826-delstid-v2-5-e8ab5c0e39cc@kernel.org>

On Mon, Aug 26, 2024 at 08:46:15AM GMT, Jeff Layton wrote:
> When updating the ctime on an inode for a setattr with a multigrain
> filesystem, we usually want to take the latest time we can get for the
> ctime. The exception to this rule is when there is a nfsd write
> delegation and the server is proxying timestamps from the client.
> 
> When nfsd gets a CB_GETATTR response, we want to update the timestamp
> value in the inode to the values that the client is tracking. The client
> doesn't send a ctime value (since that's always determined by the
> exported filesystem), but it does send a mtime value. In the case where
> it does, then we may also need to update the ctime to a value
> commensurate with that.
> 
> Add a ATTR_CTIME_DELEG flag, which tells the underlying setattr

Fwiw: disconnect between commit message and actually used ATTR_CTIME_DLG.

> machinery to respect that value and not to set it to the current time.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Are you set on sending us on a mission to free up ATTR_* bits after
freeing up FMODE_* bits? ;)

If there's going to be more ATTR_*DELEG* flags that modify the
behavior when delegation is in effect then we could consider adding
another unsigned int ia_deleg field to struct iattr so that you can check:

if (ia_valid & ATTR_CTIME) {
	if (unlikely(iattr->ia_deleg & ATTR_CTIME))
		// do some special stuff
	else
		// do the regular stuff
}

or some such variant.

>  fs/attr.c          | 10 +++++++++-
>  include/linux/fs.h |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index 7144b207e715..0eb7b228b94d 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -295,7 +295,15 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
>  		return;
>  	}
>  
> -	now = inode_set_ctime_current(inode);
> +	/*
> +	 * In the case of an update for a write delegation, we must respect
> +	 * the value in ia_ctime and not use the current time.
> +	 */
> +	if (ia_valid & ATTR_CTIME_DLG)
> +		inode_set_ctime_to_ts(inode, attr->ia_ctime);
> +	else
> +		now = inode_set_ctime_current(inode);
> +
>  	if (ia_valid & ATTR_ATIME_SET)
>  		inode_set_atime_to_ts(inode, attr->ia_atime);
>  	else if (ia_valid & ATTR_ATIME)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7c1da3c687bd..43a802b2cb0d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -211,6 +211,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  #define ATTR_TIMES_SET	(1 << 16)
>  #define ATTR_TOUCH	(1 << 17)
>  #define ATTR_DELEG	(1 << 18) /* Delegated attrs (don't break) */
> +#define ATTR_CTIME_DLG	(1 << 19) /* Delegation in effect */

What's the interaction between ATTR_DELEG and ATTR_CTIME_DLG? I think
that's potentially confusing.

