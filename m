Return-Path: <linux-fsdevel+bounces-21303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07975901964
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 04:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90F1B2147D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 02:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9681CAD4B;
	Mon, 10 Jun 2024 02:33:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BBF136A;
	Mon, 10 Jun 2024 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717986787; cv=none; b=owhSqJAQSOgU6vC3jGYJs6RtU2ojNK0iUa88OSYKLm3yWMEeJ4fEOzHJppSMvx8J31PNdhdjkdcpe9+r9/XfPLeC47pRZopT2m9RlzyTv/AqkSF9aJSYJjwVCkLl4u7OLPgjf+5T8uAOvXdyB2z1XtF1S8ogCt8JOd8/QwMco5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717986787; c=relaxed/simple;
	bh=HbycHs7DADBVRvhki7EX2pSnnSjZWAfNBicUJiliqt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtY4YQLcj1Aj1Ja0JxvG905IMPg0QEv5mTgltCPzPYh8NC0JxKGtAGQo0vCPSerSycGmMe8RliNr1+jE1YbaC8rYdMqqqtcetY6Ki8l+NnsD+0tc8VpX9bmEphsqJKEG9R5UqSAs1cgQ1STDkxOC/kExeAW6vtsEtXx96RY6vSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 63BEA234; Sun,  9 Jun 2024 21:33:01 -0500 (CDT)
Date: Sun, 9 Jun 2024 21:33:01 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org, ebiederm@xmission.com,
	Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>,
	John Johansen <john.johansen@canonical.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	containers@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	apparmor@lists.ubuntu.com, keyrings@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] capabilities: Add securebit to restrict userns
 caps
Message-ID: <20240610023301.GA2183903@mail.hallyn.com>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-3-jcalmels@3xx0.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240609104355.442002-3-jcalmels@3xx0.net>

On Sun, Jun 09, 2024 at 03:43:35AM -0700, Jonathan Calmels wrote:
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

But you are not (that I can see, in this or the previous patch)
keeping SECURE_USERNS_STRICT_CAPS in securebits on the next
level unshare.  Though I think it's ok, because by then both
cap_userns and cap_bset are reduced and cap_userns can't be
expanded.  (Sorry, just thinking aloud here)

> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
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

In the case of userns_install(), it will be the target user namespace
creator's bounding set, right?  Not "our parent's"?

> +	if (iscredsecure(cred, SECURE_USERNS_STRICT_CAPS))
> +		cred->cap_userns = cap_intersect(cred->cap_userns, cred->cap_bset);
> +
>  	/* Start with the capabilities defined in the userns set. */
>  	cred->cap_bset = cred->cap_userns;
>  	cred->cap_permitted = cred->cap_userns;
> -- 
> 2.45.2

