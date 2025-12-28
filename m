Return-Path: <linux-fsdevel+bounces-72148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3310CE5769
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Dec 2025 22:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EB0E30019F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Dec 2025 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C60F9C0;
	Sun, 28 Dec 2025 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc/i0FUp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2511FB1
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Dec 2025 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766955699; cv=none; b=QHMnyJdnXc1VEBvAqycVPIAT13KKkWlA7Y7DIi6rlssa0FdtLg6dPceJuI+9ATDL0HHqe8S1d65S00EdZbv+Fheyzq0lnn0K6rDqc2eZUBf8eNPDoqm4cfKd05c7knHGvcw32BYd3xDnXHNnCMbokzD++1Vdq2NIYdQTVohNvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766955699; c=relaxed/simple;
	bh=7wNbVw619X8aRFmU2T95+v87Jr4XCQZy+luXVKAo9Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdkPKteFKwX/nhWKtHhy1KO9UigWUNzErLTwcbzhiuAlIZ2W/5L1BhTsgg9/UsuaWVjKr3TeN5EJ+ujK7G47tm+a8wE5kjy4QeL55E0wNiea5mVk/bBm+Rn4XUcOP2g1aKHxEU7MF15oG7K0KdmmgFhm5j5qVpBPSTEHJIVNkdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc/i0FUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6E1C4CEFB;
	Sun, 28 Dec 2025 21:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766955699;
	bh=7wNbVw619X8aRFmU2T95+v87Jr4XCQZy+luXVKAo9Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lc/i0FUpJtGLGIPM6mugaqKIsHyf0oFQT4euP/Tlxc4frEZ19xiZLagUmOh8JONjc
	 PbSyYWqJv5U/8fiPiMOOrnPdF8p+cEUhccFN8I+HBj7hZDGYmdMAvqafy3du0ZZB4x
	 6CAGWEQuUx9BXZyRlUY2p0N9Ct6h+mTKIUeEuv/b1xsiVMek3TZtV83iuY+3bUJJ5Q
	 CVpwpxsejOY6FLg3cAzda8zFY5jz9h4nwtTpqpj1nfgyaQ+qCoK2bEFHn86SAhCJxC
	 jPBTVZCnHhdJbzUwgz09W1OezFWtK0/n1mZwjTP2mBpLw78vPqy/5Zgo4LdTjB7xNw
	 W6GeA5Gu/2UtQ==
Date: Sun, 28 Dec 2025 13:01:37 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] pidfs: protect PIDFD_GET_* ioctls() via ifdef
Message-ID: <20251228210137.GD2431@quark>
References: <20251222214907.GA189632@quark>
 <20251224-ununterbrochen-gagen-ea949b83f8f2@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224-ununterbrochen-gagen-ea949b83f8f2@brauner>

On Wed, Dec 24, 2025 at 01:00:24PM +0100, Christian Brauner wrote:
> We originally protected PIDFD_GET_<ns-type>_NAMESPACE ioctls() through
> ifdefs and recent rework made it possible to drop them. There was an
> oversight though. When the relevant namespace is turned off ns->ops will
> be NULL so even though opening a file descriptor is perfectly legitimate
> it would fail during inode eviction when the file was closed.
> 
> The simple fix would be to check ns->ops for NULL and continue allow to
> retrieve namespace fds from pidfds but we don't allow retrieving them
> when the relevant namespace type is turned off. So keep the
> simplification but add the ifdefs back in.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Link: https://lore.kernel.org/20251222214907.GA189632@quark
> Fixes: a71e4f103aed ("pidfs: simplify PIDFD_GET_<type>_NAMESPACE ioctls")
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Tested-by: Eric Biggers <ebiggers@kernel.org>

>	case PIDFD_GET_USER_NAMESPACE:
>#ifdef CONFIG_USER_NS
>		scoped_guard(rcu) {
>			struct user_namespace *user_ns;
>
>			user_ns = task_cred_xxx(task, user_ns);
>			if (!ns_ref_get(user_ns))
>				break;
>			ns_common = to_ns_common(user_ns);
>		}
>#endif
>  		break;

Not directly related to this patch, but you know that the 'break;' above
breaks from the scoped_guard() block and not from the switch statement,
right?  (Considering that scoped_guard() is implemented using 'for'.)
There is a break after the scoped_guard(), so it ends up being the same.
But it's confusing.  It would be much easier to understand if it was
rewritten to not use an inner 'break':

            if (ns_ref_get(user_ns))
                    ns_common = to_ns_common(user_ns);

- Eric

