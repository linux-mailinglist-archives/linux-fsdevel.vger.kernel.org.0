Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA912D1811
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 19:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgLGSBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 13:01:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgLGSBt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:01:49 -0500
Date:   Mon, 7 Dec 2020 10:01:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607364068;
        bh=0q3hSpdHGahpDyi3FplEQN1u2LRkg5kTzxu59n1eKhg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdKwUj035xPG2qjEGfZ/kt62gYC4VsNNPVoY6PgYRuwYPaCwm3DTIQaDFpLLU5KzR
         TEzIiA273JQ5+kEdsoQ0fsjMgVbqz2wLUHtD2OM+8vXZnyZ1McvLmt1zSpTgC5FZ19
         Y0DEv0OffgUCJVPpo4XZ/lyqD3q1T8ayRGsg6+SmG8h0BhmkEJ/p7wQhPGs+ap+pLZ
         NmVI+XSsVc8inoDEC/HBzOiFaO+H0Eq5tSdSA9yvVjCOoD6qnBVpA5rwsiJo70fpbD
         cIsLi1qtugGglhcPjRm59gYgJbH5obnllMG/kV95yCksEtbQi3f9cXqYwlWYwyNJJs
         f4/hx4rVbR1rA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH] fuse: Support FS_IOC_GET_ENCRYPTION_POLICY_EX
Message-ID: <X85t4o2fmVUo8RpZ@gmail.com>
References: <20201207040303.906100-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207040303.906100-1-chirantan@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please Cc linux-fscrypt@vger.kernel.org on all fscrypt-related patches.

On Mon, Dec 07, 2020 at 01:03:03PM +0900, Chirantan Ekbote wrote:
> This is a dynamically sized ioctl so we need to check the user-provided
> parameter for the actual length.
> 
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>

Could you add something here about why this ioctl in particular needs to be
passed through FUSE?  This isn't the only dynamically-sized ioctl.

> @@ -2808,6 +2809,21 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
>  		case FS_IOC_SETFLAGS:
>  			iov->iov_len = sizeof(int);
>  			break;
> +		case FS_IOC_GET_ENCRYPTION_POLICY_EX: {

This is in the middle of a 200 lines function.  It would be easier to understand
if you refactored this to use a helper function that that takes in the ioctl
number and user buffer and returns the size.

> +			struct fscrypt_get_policy_ex_arg policy;

'__u64 policy_size' would be sufficient, since only that part of the struct is
used.

> +			unsigned long size_ptr =
> +				arg + offsetof(struct fscrypt_get_policy_ex_arg,
> +					       policy_size);

Doing pointer arithmetic on unsigned long is unusual.  It would be easier to
understand if you did:

	struct fscrypt_get_policy_ex_arg __user *uarg =
		(struct fscrypt_get_policy_ex_arg __user *)arg;

Then pass &uarg->policy_size to copy_from_user().

> +
> +			if (copy_from_user(&policy.policy_size,
> +					   (void __user *)size_ptr,
> +					   sizeof(policy.policy_size)))
> +				return -EFAULT;
> +
> +			iov->iov_len =
> +				sizeof(policy.policy_size) + policy.policy_size;
> +			break;

This may overflow SIZE_MAX, as policy_size is a __u64 directly from userspace.
Wouldn't FUSE need to limit the size to a smaller value?

- Eric
