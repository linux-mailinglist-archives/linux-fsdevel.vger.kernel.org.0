Return-Path: <linux-fsdevel+bounces-70168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4AEC92BC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 18:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D33BF346463
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C32D5959;
	Fri, 28 Nov 2025 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jt6Llu3a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188972C3251
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349027; cv=none; b=RGRA7gJHbHmyO4sGK2XoAnsRDzL6AIzkIcIlWuhEflk5Qc6IhP57c/JFwTkWw0WxcFlAI9C1D3C4J7j2tmufOikKFmOHcUKG//bwNXeSH/GeiWDh6K3JCqUZXu22wW+qsRRmq593SghE8LVTdhbTbcqTSVFLUhkJTwB9mE8V67Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349027; c=relaxed/simple;
	bh=5a/KZrW0A9GQei5mM0R5P2xPq0Ot8BgBWZpdHRpIRH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jI0Je1iAKc67LxzxjXKLtkNYwqgusgr591dpQlNIBSFF3nuEY/F/A8SDPyeVM4XAhjLzz9WKzg0C0jqUGmsiNVCLQNvbwwDgyaTHyBWsjqGg6zjl6oSbkSjKHIoXAvIDKKXtT2V0/29/0YUh/q0r5+hXKDM8Bt39zZ+9HDXYnRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jt6Llu3a; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dHzwj6RxkzRgw;
	Fri, 28 Nov 2025 17:56:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1764349010;
	bh=TIpd7YF1NtXKZclZu6eTYoVD0AdCSNp5YWfa6nAMZ20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jt6Llu3akl54ddEx8Bwglt1lMVV+uWolhvalHwqVIYJ3bgKp4rYmZkErAEEk6ljx3
	 Z6SqrkaJwx77VESFX+HrCqxrX3LfmB6dYyeHwJvUQlYZPQTFm8KOSMEI+CPygnoHD7
	 WxvVwaWR4M2uejr8Mx1mfuidwHjuoTBGNbywdEpE=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dHzwd2kqsz1BPK;
	Fri, 28 Nov 2025 17:56:49 +0100 (CET)
Date: Fri, 28 Nov 2025 17:56:39 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ben Scarlato <akhna@google.com>, 
	Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Justin Suess <utilityemal77@gmail.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Paul Moore <paul@paul-moore.com>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 1/4] landlock: Fix handling of disconnected directories
Message-ID: <20251128.oht7Aic8nu9d@digikod.net>
References: <20251126191159.3530363-1-mic@digikod.net>
 <20251126191159.3530363-2-mic@digikod.net>
 <adf1f57c-8f8e-45a9-922c-4e08899bf14a@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adf1f57c-8f8e-45a9-922c-4e08899bf14a@maowtm.org>
X-Infomaniak-Routing: alpha

On Fri, Nov 28, 2025 at 01:45:29AM +0000, Tingmao Wang wrote:
> Hi Mickaël,
> 
> I think this implementation makes sense - to me this feels better than
> ignoring rules between the leaf and the mount when disconnected, given the
> interaction with domain checks.  This approach is also simpler in code.
> 
> However, there is one caveat which, while requiring a slightly problematic
> policy to happen in the first place, might still be a bit surprising: if,
> for some reason, there are rules "hidden" in the "real" parent of a (bind)
> mounted dir, a sandboxed program that is able to cause directories to be
> disconnected (for example, because there are more bind mounts within the
> bind mount, and the program has enough rename access (but not read/write))
> may be able to "surface" those rules and "gain access" (requires the
> existance of the already questionable "hidden" rule):

The crux of the issue is indeed the policy.

> 
>   root@g3ef6e4434e3a-dirty /# mkdir -p /hidden/bind1_src /bind1_dst
>   /# cd hidden
>   /hidden# mount --bind bind1_src /bind1_dst
>   /hidden# mkdir -p bind1_src/bind2_src/dir bind1_src/bind2_dst
>   /hidden# mount --bind /bind1_dst/bind2_src /bind1_dst/bind2_dst
>   /hidden# echo secret > bind1_src/bind2_src/dir/secret
>   /hidden# ls -la /bind1_dst/bind2_dst/dir/secret 
>   -rw-r--r-- 1 root root 7 Nov 28 00:49 /bind1_dst/bind2_dst/dir/secret
>   /hidden# mount -t tmpfs none /hidden
>   /hidden# ls .
>   bind1_src/
>   /hidden# ls /hidden
>   /hidden# LL_FS_RO=/usr:/bin:/lib:/etc:. LL_FS_RW= LL_FS_CREATE_DELETE_REFER=./bind1_src /sandboxer bash
>                                         ^ this attaches a read rule to a "invisible" dir
>   Executing the sandboxed command...
>   /hidden# cd /
>   /# ls /hidden
>   ls: cannot open directory '/hidden': Permission denied
>   /# cd /bind1_dst/bind2_dst/dir       
>   /bind1_dst/bind2_dst/dir# cat secret
>   cat: secret: Permission denied
>   /bind1_dst/bind2_dst/dir# mv -v /bind1_dst/bind2_src/dir /bind1_dst/outside
>   renamed '/bind1_dst/bind2_src/dir' -> '/bind1_dst/outside'
>   /bind1_dst/bind2_dst/dir# ls ..
>   ls: cannot access '..': No such file or directory
>   /bind1_dst/bind2_dst/dir# cat secret
>   secret

This is valid, but in this case access to secret is explicitly allowed
by the policy, even if the related path is no longer reachable.

> 
> Earlier I was thinking we could make domain check for rename/links
> stricter, in that it would make sure there are no rules granting more
> access on the destination than what's granted by the "visible" rules on
> the source even if those rules are "hidden" within the fs above the
> mountpoint.  This way, the application would not be able to move the
> source's parent to cause a disconnection in the first place.  However, I'm
> not sure if this is worth the complication (e.g. in the case of exchange
> rename, source is also the destination, and so this check needs to also
> check that there are no "hidden" rules on the source that grants more access
> than the "visible" rules on the destination).
> 
> I see another approach to mitigate this - we can disallow (return with
> -EXDEV probably) rename/links altogether when the destination (and also
> source if exchange) contains "hidden" rules that grants more access than
> the "visible" rules.  However this approach would break backward
> compatibility if a sandboxer or Landlock-enlightened application creates
> such problematic policies (most likely unknowingly).
> 
> Stepping back a bit, I also think it is reasonable to leave this issue as
> is and not mitigate it (maybe warn about it in some way in the docs),
> given that this can only happen if the policy is already weird (if the
> intention is to protect some file, setting an allow access rule on its
> parent, even if that parent is "hidden", is questionable).

I agree.

> 
> Not sure which is best, but even with this issue this patch is probably
> still an improvement over the existing behavior (i.e. the one currently in
> mainline, where if the path is disconnected, the "hidden" rules are used
> and any "normal" rules from mnt_parent and above are ignored).
> 
> Reviewed-by: Tingmao Wang <m@maowtm.org>

Thanks for the deep analysis!

> 
> Kind regards,
> Tingmao
> 

