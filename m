Return-Path: <linux-fsdevel+bounces-21334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A1F902247
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 15:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1142285210
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 13:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8F823CE;
	Mon, 10 Jun 2024 13:01:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD54501B;
	Mon, 10 Jun 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024462; cv=none; b=OFmQ0LPXchQE8jOfakPGEY0mPGa/X0L9yJUc+AkFu3+D+dwu4y9bXtKMwVcpjT51Yuk3l216hQSWQXEL7/eFrZMgNNHZtDFLj5lmXtj0OyMjmPbJCnFseQTdBC5kAsGd0Y8JhznI10nGKPHRI6o9qkdAE6nsuBRT7FnFo/XC+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024462; c=relaxed/simple;
	bh=oeZ4MpWLlEwqn3Pl12O9nYB2grDeF+oGLF9aIpfQcp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOq+hiY1HqDTfe73i+rb6qe1cvk0a2rjTnZcxHNLOr1n9ELKzj+R740kg+hXLi+5prpk7Hb2C0LEV+ywujoyBMLxTsbKx9rq3OgfuG2XNGtS2ZokBgmIlEkyo1KeGOoa8zWM9lB2p+BHPIanF17P8kHYnLBONlr9SjI9xHbb3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id C3CC4579; Mon, 10 Jun 2024 08:00:57 -0500 (CDT)
Date: Mon, 10 Jun 2024 08:00:57 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jonathan Calmels <jcalmels@3xx0.net>, Andrew Morgan <morgan@kernel.org>
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
Subject: Re: [PATCH v2 1/4] capabilities: Add user namespace capabilities
Message-ID: <20240610130057.GB2193924@mail.hallyn.com>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-2-jcalmels@3xx0.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240609104355.442002-2-jcalmels@3xx0.net>

On Sun, Jun 09, 2024 at 03:43:34AM -0700, Jonathan Calmels wrote:
> Attackers often rely on user namespaces to get elevated (yet confined)
> privileges in order to target specific subsystems (e.g. [1]). Distributions
> have been pretty adamant that they need a way to configure these, most of
> them carry out-of-tree patches to do so, or plainly refuse to enable them.
> As a result, there have been multiple efforts over the years to introduce
> various knobs to control and/or disable user namespaces (e.g. [2][3][4]).
> 
> While we acknowledge that there are already ways to control the creation of
> such namespaces (the most recent being a LSM hook), there are inherent
> issues with these approaches. Preventing the user namespace creation is not
> fine-grained enough, and in some cases, incompatible with various userspace
> expectations (e.g. container runtimes, browser sandboxing, service
> isolation)
> 
> This patch addresses these limitations by introducing an additional
> capability set used to restrict the permissions granted when creating user
> namespaces. This way, processes can apply the principle of least privilege
> by configuring only the capabilities they need for their namespaces.
> 
> For compatibility reasons, processes always start with a full userns
> capability set.
> 
> On namespace creation, the userns capability set (pU) is assigned to the
> new effective (pE), permitted (pP) and bounding set (X) of the task:
> 
>     pU = pE = pP = X
> 
> The userns capability set obeys the invariant that no bit can ever be set
> if it is not already part of the task’s bounding set. This ensures that
> no namespace can ever gain more privileges than its predecessors.
> Additionally, if a task is not privileged over CAP_SETPCAP, setting any bit
> in the userns set requires its corresponding bit to be set in the permitted
> set. This effectively mimics the inheritable set rules and means that, by
> default, only root in the user namespace can regain userns capabilities
> previously dropped:
> 
>     p’U = (pE & CAP_SETPCAP) ? X : (X & pP)
> 
> Note that since userns capabilities are strictly hierarchical, policies can
> be enforced at various levels (e.g. init, pam_cap) and inherited by every
> child namespace.
> 
> Here is a sample program that can be used to verify the functionality:
> 
> /*
>  * Test program that drops CAP_SYS_RAWIO from subsequent user namespaces.
>  *
>  * ./cap_userns_test unshare -r grep Cap /proc/self/status
>  * CapInh: 0000000000000000
>  * CapPrm: 000001fffffdffff
>  * CapEff: 000001fffffdffff
>  * CapBnd: 000001fffffdffff
>  * CapAmb: 0000000000000000
>  * CapUNs: 000001fffffdffff
>  */

...

> +#ifdef CONFIG_USER_NS
> +	case PR_CAP_USERNS:
> +		if (arg2 == PR_CAP_USERNS_CLEAR_ALL) {
> +			if (arg3 | arg4 | arg5)
> +				return -EINVAL;
> +
> +			new = prepare_creds();
> +			if (!new)
> +				return -ENOMEM;
> +			cap_clear(new->cap_userns);
> +			return commit_creds(new);
> +		}
> +
> +		if (((!cap_valid(arg3)) | arg4 | arg5))
> +			return -EINVAL;
> +
> +		if (arg2 == PR_CAP_USERNS_IS_SET)
> +			return !!cap_raised(current_cred()->cap_userns, arg3);
> +		if (arg2 != PR_CAP_USERNS_RAISE && arg2 != PR_CAP_USERNS_LOWER)
> +			return -EINVAL;
> +		if (arg2 == PR_CAP_USERNS_RAISE && !cap_uns_is_raiseable(arg3))
> +			return -EPERM;
> +
> +		new = prepare_creds();
> +		if (!new)
> +			return -ENOMEM;
> +		if (arg2 == PR_CAP_USERNS_RAISE)
> +			cap_raise(new->cap_userns, arg3);
> +		else
> +			cap_lower(new->cap_userns, arg3);

Now, one thing that does occur to me here is that there is a
very mild form of sendmail-capabilities vulnerability that
could happen here.  Unpriv user joe can drop CAP_SYS_ADMIN
from cap_userns, then run a setuid-root program which starts
a container which expects CAP_SYS_ADMIN.  This could be a
shared container, and so joe could be breaking expected
behavior there.

I *think* we want to say we don't care about this case, but
if we did, I suppose we could say that the normal cap raise
rules on setuid should apply to cap_userns?


