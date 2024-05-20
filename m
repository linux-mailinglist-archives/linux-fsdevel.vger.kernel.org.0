Return-Path: <linux-fsdevel+bounces-19743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6138C9873
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 05:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348991F22405
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 03:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDC611CBD;
	Mon, 20 May 2024 03:38:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89741101C4;
	Mon, 20 May 2024 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716176290; cv=none; b=trqReZqquVgi2phcsgREbl3dD5k50himIGptFvZ40C1AgNvFqNlfpYisw+ctTuFD9Arifdx3+b+5ZxKwrH+sWjWwqVEFZ/GvPWwvfQTn7y9annilgOQIgVoY6XIMsOdIgL07+lRlx9uzh6fV4GGSVVEbYdamO4JoZL706n/+Ty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716176290; c=relaxed/simple;
	bh=LZxMx8cq+pqZU8qVni51ciYzQ72ZESo//RuR/LuvJGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIXSg4DtDJCIG6P1jYimo6FZz4keD8Vxpj2nrxPwh8IHttc92y4+PoR4HN0GHEYCGnq0y1ADncSaYRFrZtXIZynHZ8EvPGBKweALh9GhHuwjx9LDAgI4kjKvP5Et/v+eRLjZTyTPLSHeU/D78XxbV6DcF5K77YFUNI+5mGfBPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id B565FA17; Sun, 19 May 2024 22:38:05 -0500 (CDT)
Date: Sun, 19 May 2024 22:38:05 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org, ebiederm@xmission.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 2/3] capabilities: add securebit for strict userns caps
Message-ID: <20240520033805.GA1816262@mail.hallyn.com>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-3-jcalmels@3xx0.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516092213.6799-3-jcalmels@3xx0.net>

On Thu, May 16, 2024 at 02:22:04AM -0700, Jonathan Calmels wrote:
> This patch adds a new capability security bit designed to constrain a
> task’s userns capability set to its bounding set. The reason for this is
> twofold:
> 
> - This serves as a quick and easy way to lock down a set of capabilities
>   for a task, thus ensuring that any namespace it creates will never be
>   more privileged than itself is.
> - This helps userspace transition to more secure defaults by not requiring
>   specific logic for the userns capability set, or libcap support.
> 
> Example:
> 
>     # capsh --secbits=$((1 << 8)) --drop=cap_sys_rawio -- \
>             -c 'unshare -r grep Cap /proc/self/status'
>     CapInh: 0000000000000000
>     CapPrm: 000001fffffdffff
>     CapEff: 000001fffffdffff
>     CapBnd: 000001fffffdffff
>     CapAmb: 0000000000000000
>     CapUNs: 000001fffffdffff
> 
> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  include/linux/securebits.h      |  1 +
>  include/uapi/linux/securebits.h | 11 ++++++++++-
>  kernel/user_namespace.c         |  5 +++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/securebits.h b/include/linux/securebits.h
> index 656528673983..5f9d85cd69c3 100644
> --- a/include/linux/securebits.h
> +++ b/include/linux/securebits.h
> @@ -5,4 +5,5 @@
>  #include <uapi/linux/securebits.h>
>  
>  #define issecure(X)		(issecure_mask(X) & current_cred_xxx(securebits))
> +#define iscredsecure(cred, X)	(issecure_mask(X) & cred->securebits)
>  #endif /* !_LINUX_SECUREBITS_H */
> diff --git a/include/uapi/linux/securebits.h b/include/uapi/linux/securebits.h
> index d6d98877ff1a..2da3f4be4531 100644
> --- a/include/uapi/linux/securebits.h
> +++ b/include/uapi/linux/securebits.h
> @@ -52,10 +52,19 @@
>  #define SECBIT_NO_CAP_AMBIENT_RAISE_LOCKED \
>  			(issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE_LOCKED))
>  
> +/* When set, user namespace capabilities are restricted to their parent's bounding set. */
> +#define SECURE_USERNS_STRICT_CAPS			8
> +#define SECURE_USERNS_STRICT_CAPS_LOCKED		9  /* make bit-8 immutable */
> +
> +#define SECBIT_USERNS_STRICT_CAPS (issecure_mask(SECURE_USERNS_STRICT_CAPS))
> +#define SECBIT_USERNS_STRICT_CAPS_LOCKED \
> +			(issecure_mask(SECURE_USERNS_STRICT_CAPS_LOCKED))
> +
>  #define SECURE_ALL_BITS		(issecure_mask(SECURE_NOROOT) | \
>  				 issecure_mask(SECURE_NO_SETUID_FIXUP) | \
>  				 issecure_mask(SECURE_KEEP_CAPS) | \
> -				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE))
> +				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE) | \
> +				 issecure_mask(SECURE_USERNS_STRICT_CAPS))
>  #define SECURE_ALL_LOCKS	(SECURE_ALL_BITS << 1)
>  
>  #endif /* _UAPI_LINUX_SECUREBITS_H */
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 7e624607330b..53848e2b68cd 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -10,6 +10,7 @@
>  #include <linux/cred.h>
>  #include <linux/securebits.h>
>  #include <linux/security.h>
> +#include <linux/capability.h>
>  #include <linux/keyctl.h>
>  #include <linux/key-type.h>
>  #include <keys/user-type.h>
> @@ -42,6 +43,10 @@ static void dec_user_namespaces(struct ucounts *ucounts)
>  
>  static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>  {
> +	/* Limit userns capabilities to our parent's bounding set. */
> +	if (iscredsecure(cred, SECURE_USERNS_STRICT_CAPS))
> +		cred->cap_userns = cap_intersect(cred->cap_userns, cred->cap_bset);
> +
>  	/* Start with the capabilities defined in the userns set. */
>  	cred->cap_bset = cred->cap_userns;
>  	cred->cap_permitted = cred->cap_userns;
> -- 
> 2.45.0
> 

