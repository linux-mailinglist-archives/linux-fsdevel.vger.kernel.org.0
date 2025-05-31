Return-Path: <linux-fsdevel+bounces-50256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF18AC9B40
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 15:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FCC37AE654
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C34B23C4FB;
	Sat, 31 May 2025 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="SMumDkZY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eeUXMRF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672717597;
	Sat, 31 May 2025 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748699491; cv=none; b=KgxKzyK9KAoE9W0VaEwOC3KESYXYCdwFBC2gPgtvGwu4uyklHfN0mPzRar1EgKMF4kC+CMkdH7O8ZE568wAu71GGJ+A78zq1isyN+dpcPVN/xiD1h+1XvMFES96q3nLdpI1LG/u9+zLXq+qsJXhSYm77qSf7KcCADAYoiclXaI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748699491; c=relaxed/simple;
	bh=/raXh0dUOshGWJWEiIMnLA2Onw6RDiCXkqUbcvlMGY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jo96AvXGPabpIy384oiHSID4+8mA+nqpSzXrHDOh2O8+s+KxC9wU01Rt0akPTu2ht+dBC53TS1T7jqh8dmDj0Kmn00suBTDz5jMsldbDSqvqDxCluX+YlYA8uoU+riACus/GLwQrgcsRR6YGu6kAfpz0DPQTfjCHi+4WfaFF+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=SMumDkZY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eeUXMRF/; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id B50D91D4054D;
	Sat, 31 May 2025 09:51:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 31 May 2025 09:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748699487;
	 x=1748706687; bh=gWomyldKWxU7l0zsMN1/xB5c7EUkzuXCPvf0zYP8PZ4=; b=
	SMumDkZYeEFdxYEwIPRvgGcRaFptC5I03xhTEC7lcLpqIyR2HFJmFqE/QhaTKrYx
	8lK9tzoMqur9vmr/XgGwvzDbIvYBK8ntRRtPJFrNCEm3hS6ne149RHBR7SR2tDn1
	zMF3zxN6dz/cWEI4GwZCBCG0EYu0J1s1CSe2bzVyYqWm226onhKZDVxuqWE2USmd
	9ecX3wT9ozkDOkZS0T2aURCezWrfzHiv/k5lElAx3oYHpxi46YNgpid5dbMj4jTQ
	XaxOninPuTJtMY/CxY5j+pkCRc3Ai4XMi8aK5xXF8dJR0nLuwGKj8DdHyjD2rdsd
	rVNfSgKlcWRektmJf4TCXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748699487; x=
	1748706687; bh=gWomyldKWxU7l0zsMN1/xB5c7EUkzuXCPvf0zYP8PZ4=; b=e
	eUXMRF/Lo0eFxfrq0NAeGCwmsR1xEbHVGZVT0Dmu65lMW869StEqobbjP6O8oq+X
	WkdWpI6SFBRlGLYpLwwnerSChPIR2WW/uBuQuMeCjbbs08R+L5NXP3VRymtFkQwv
	Fk3fGR3C0XhoE5poGXjhHt6cbVPBxlXn5SV5EaBdShum1ECK6QzGOw9yT26IHCT1
	UNw/bBdJckTiGb+HZBVxVCjfaospkzBGVXOMCZnUOu8i+MmNqzJO0WFEUL/Ep8ZJ
	fRmAOz5WOa58H6Pl2lloS2FP1p2d66saczD2pPgnMeniIDpxsKBPdD3xxaA+E7o1
	BaI0BwUDhCAKfQW+iawhg==
X-ME-Sender: <xms:Xgk7aGiOdOhVjen6OmUFvL_p0fQJRnni4o4ca7lPTDORvSeg61Nrww>
    <xme:Xgk7aHAuaHEZR64dbv_CyB5PAtee7pZSifTJc1LacryTElyhVu45vGjSfiR85kMVh
    2mf9sC7MttODMyIuf0>
X-ME-Received: <xmr:Xgk7aOG9tMnKmp4qz57kvjot_YKUtUzpPO5nTUX0w6-W-NhP8qvj7hA3J9yNOFGh3X8l0ozuKeXPMlXIYcokVeuP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefvddtjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfev
    fhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomh
    esmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpedukeevhfegvedvveeihedv
    vdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghr
    tghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsohhngheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhrtghpth
    htoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiikeej
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Xgk7aPRq3LKHnyDPYB8J2-GI7IgQO1xi_1ovkUSq_79KrdOK6z9e8Q>
    <xmx:Xgk7aDyGJJ2wi3hiDbcLYNW2QKSMghPo2aaqsynNBSdqDQhTIVGVZw>
    <xmx:Xgk7aN6rXQHwb2F4VS8UVNtQAZhn3ixZgLc7vr7dEi5Y36hsagogOA>
    <xmx:Xgk7aAwzkSTonorkKVOpUg5J3b4_Np8pLOF5RlU5D8jXgJNnChHCsg>
    <xmx:Xwk7aBxZzVzzDblqzACFNj5vCV1uKCO21d0ztZYnOllXey41gPsPX-eL>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 May 2025 09:51:23 -0400 (EDT)
Message-ID: <027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org>
Date: Sat, 31 May 2025 14:51:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] landlock: Use path_parent()
To: Song Liu <song@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
 amir73il@gmail.com, repnop@google.com, jlayton@kernel.org,
 josef@toxicpanda.com, gnoack@google.com
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-3-song@kernel.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250528222623.1373000-3-song@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/28/25 23:26, Song Liu wrote:
> Use path_parent() to walk a path up to its parent.
> 
> While path_parent() has an extra check with path_connected() than existing
> code, there is no functional changes intended for landlock.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/landlock/fs.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 6fee7c20f64d..32a24758ad6e 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -837,7 +837,6 @@ static bool is_access_to_paths_allowed(
>  	 * restriction.
>  	 */
>  	while (true) {
> -		struct dentry *parent_dentry;
>  		const struct landlock_rule *rule;
>  
>  		/*
> @@ -896,19 +895,17 @@ static bool is_access_to_paths_allowed(
>  		if (allowed_parent1 && allowed_parent2)
>  			break;
>  jump_up:
> -		if (walker_path.dentry == walker_path.mnt->mnt_root) {
> -			if (follow_up(&walker_path)) {
> -				/* Ignores hidden mount points. */
> -				goto jump_up;
> -			} else {
> -				/*
> -				 * Stops at the real root.  Denies access
> -				 * because not all layers have granted access.
> -				 */
> -				break;
> -			}
> -		}
> -		if (unlikely(IS_ROOT(walker_path.dentry))) {
> +		switch (path_parent(&walker_path)) {
> +		case PATH_PARENT_CHANGED_MOUNT:
> +			/* Ignores hidden mount points. */
> +			goto jump_up;
> +		case PATH_PARENT_REAL_ROOT:
> +			/*
> +			 * Stops at the real root.  Denies access
> +			 * because not all layers have granted access.
> +			 */
> +			goto walk_done;
> +		case PATH_PARENT_DISCONNECTED_ROOT:
>  			/*
>  			 * Stops at disconnected root directories.  Only allows
>  			 * access to internal filesystems (e.g. nsfs, which is

I was looking at the existing handling of disconnected root in Landlock
and I realized that the comment here confused me a bit:

/*
 * Stops at disconnected root directories.  Only allows
 * access to internal filesystems (e.g. nsfs, which is
 * reachable through /proc/<pid>/ns/<namespace>).
 */

In the original code, this was under a

    if (unlikely(IS_ROOT(walker_path.dentry)))

which means that it only stops walking if we found out we're disconnected
after reaching a filesystem boundary.  However if before we got to this
point, we have already collected enough rules to allow access, access
would be allowed, even if we're currently disconnected.  Demo:

/ # cd /
/ # cp /linux/samples/landlock/sandboxer .
/ # mkdir a b
/ # mkdir a/foo
/ # echo baz > a/foo/bar
/ # mount --bind a b
/ # LL_FS_RO=/ LL_FS_RW=/ ./sandboxer bash
Executing the sandboxed command...
/ # cd /b/foo
/b/foo # cat bar
baz
/b/foo # mv /a/foo /foo
/b/foo # cd ..     # <- We're now disconnected
bash: cd: ..: No such file or directory
/b/foo # cat bar
baz                # <- but landlock still lets us read the file

However, I think this patch will change this behavior due to the use of
path_connected

root@10a8fff999ce:/# mkdir a b
root@10a8fff999ce:/# mkdir a/foo
root@10a8fff999ce:/# echo baz > a/foo/bar
root@10a8fff999ce:/# mount --bind a b
root@10a8fff999ce:/# LL_FS_RO=/ LL_FS_RW=/ ./sandboxer bash
Executing the sandboxed command...
bash: cannot set terminal process group (191): Inappropriate ioctl for device
bash: no job control in this shell
root@10a8fff999ce:/# cd /b/foo
root@10a8fff999ce:/b/foo# cat bar
baz
root@10a8fff999ce:/b/foo# mv /a/foo /foo
root@10a8fff999ce:/b/foo# cd ..
bash: cd: ..: No such file or directory
root@10a8fff999ce:/b/foo# cat bar
cat: bar: Permission denied

I'm not sure if the original behavior was intentional, but since this
technically counts as a functional changes, just pointing this out.

Also I'm slightly worried about the performance overhead of doing
path_connected for every hop in the iteration (but ultimately it's
Mickaël's call).  At least for Landlock, I think if we want to block all
access to disconnected files, as long as we eventually realize we have
been disconnected (by doing the "if dentry == path.mnt" check once when we
reach root), and in that case deny access, we should be good.


> @@ -918,12 +915,15 @@ static bool is_access_to_paths_allowed(
>  				allowed_parent1 = true;
>  				allowed_parent2 = true;
>  			}
> +			goto walk_done;
> +		case PATH_PARENT_SAME_MOUNT:
>  			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			goto walk_done;
>  		}
> -		parent_dentry = dget_parent(walker_path.dentry);
> -		dput(walker_path.dentry);
> -		walker_path.dentry = parent_dentry;
>  	}
> +walk_done:
>  	path_put(&walker_path);
>  
>  	if (!allowed_parent1) {


