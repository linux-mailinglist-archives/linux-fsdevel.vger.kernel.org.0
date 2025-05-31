Return-Path: <linux-fsdevel+bounces-50257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A25F2AC9B4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 16:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 065667B0102
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803EA23C51B;
	Sat, 31 May 2025 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="moVj1CYq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTGBixEH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFD8F40;
	Sat, 31 May 2025 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748700355; cv=none; b=nIu/HV+dSCTXV6POskytd/ZdCSgdeIDPcVlK5c97BEPHCaw0NOWM5ljR5JmPngpsYKmpeRwkb6cg8ts3IFlbsL/Vod2lRuMbgUoOxfOXAy/2gbj8pDM4PLSEBXrJ4LDJhzxs4jvRu37EdcmzPSHK8skvLmo0AeqIuRKu4xziZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748700355; c=relaxed/simple;
	bh=batWj7URm34wWw9sXlRBBBteLVUWZCIEeamnoUIO5tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1I+b2+vbY+CwK5oHbqb+MhdVOwadtay9By6jrGjoNwKQytrGxIA+oQek8/Djn7F5Du9eed6bql+1gc+OIPJLNmKPjFcVL0XuTUaklI5qc/WVPLUz+2jjib+UoaN6shwvZf7YxuhSHEHVhJAhfi0uRAlmzkwjJeOHi0wzp4cZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=moVj1CYq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RTGBixEH; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 321771D402D4;
	Sat, 31 May 2025 10:05:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sat, 31 May 2025 10:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748700352;
	 x=1748707552; bh=A+gTdLvLewZ3oziHVaenP3eeBdz5U2TDYfESpkgT7nQ=; b=
	moVj1CYqwNmsbH3Gx2RV6/WscvhkB7/Is5dUl2plqq4kiNTa+Ey+45lJUAUmjkDj
	2ToU533fS7eel48t/qS+NirklWOio9AOksNRzuyOd8oGGVT0bTxsIZxGjt8O5u2t
	kj/Myt9RMLeLxDqVM2TWi5O3A7ySbFBGaaPBer9lq4ia7p72foiT59qSG+DG312V
	I2pEz0pK7Z7HROV0QQDRd0zBP2OTlEegBKVwjWeQlgnKuWkxfdpqD6/sx4vAd5M+
	6cKxOKcn0kUgkaOYyfJsVjzjhU5RKkQ/jEhju6fuUM/jhFWFoocM7YWYQufVXspJ
	kaOJAG6zNQELiBopp1ogow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748700352; x=
	1748707552; bh=A+gTdLvLewZ3oziHVaenP3eeBdz5U2TDYfESpkgT7nQ=; b=R
	TGBixEHEd1P+t1+wxUa5xSz+LLmZixAuDfgmUlDJL/jZcjMaCqUNjCc90VRG+PJr
	/EiniRBC645fJ+GR+YdkSvPusr8fUiEP/JCmclIRkn40HUm4DDhdOfjelTYlkkOd
	teGaZQgfO9DzGlVpmb2gUEQofgbOrkle3Hi0lPw3LWRmJq5wW4P1Bn+VVpitrGUX
	eRmFxaj8nTJNYG3QpShi9P8x6BXgG4fyDhgNbN9F/YvU0jjrlaZP/k4sgy+P0SsT
	LeYB5wJHPlnbmx6RcXWIyjh6NpiXbfBqcKTccxwfXUNPcoHQnJ+RjBd2Gbpo8vSM
	K8f2ndIttdXbXOtMY5rkQ==
X-ME-Sender: <xms:vgw7aOf2yFvZIQsubZLLT8lBkCFBM_P9W5T25AlVg4SmktGrymw6aw>
    <xme:vgw7aIPGTtn1RVZJjBzSjFy9dRXzodTqvLjdyOXu_QHNm1G_Pp5vUXoFIDM4zdJu1
    TvxG4USXMPRO9HGp_Q>
X-ME-Received: <xmr:vgw7aPiPCN9YKYMLJCgt0KSQUyUUGfrgQhLwIJu8xUyGBibTdNs8S0iQHKlE4QtPYw4CgMshSpKC4gI3gVGiuOVn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefvddutdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfev
    fhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomh
    esmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpedukeevhfegvedvveeihedv
    vdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghr
    tghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsohhngheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgt
    phhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoh
    epjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuh
    hlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgv
    rghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:vgw7aL-IgbW0ZGo43QjiyaZ4u0q9Kg-UnZu6EuDecNhtRVN5h1C5YQ>
    <xmx:vgw7aKuXWpcqGrImvuZ3fcc0wZDB0g2MgKgfEvjgNSav_ZE8x4p-TQ>
    <xmx:vgw7aCHSYHJGGpJODPOzaJEAX1bPMTj951ipWPFQi2xf79hSmQN_dQ>
    <xmx:vgw7aJOvDHf1eEzAJuEbYDwLvLQyUyMCrMyqsbhOuW2c0j0Kg-JfaA>
    <xmx:wAw7aO-8dn3ojXS0NCoV5anjiPuwX4nI_2yYrGvP4CI4w8DZHUX-KeNW>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 May 2025 10:05:48 -0400 (EDT)
Message-ID: <c2d0bae8-691f-4bb6-9c0e-64ab7cdaebd6@maowtm.org>
Date: Sat, 31 May 2025 15:05:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Song Liu <song@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org,
 kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com,
 repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com,
 gnoack@google.com
References: <20250529173810.GJ2023217@ZenIV>
 <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV>
 <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV>
 <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV>
 <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
 <20250529231018.GP2023217@ZenIV>
 <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
 <20250530.euz5beesaSha@digikod.net>
 <CAPhsuW5U-nPk4MFdZSeBNds0qEHjQZrC=c5q+AGNpsKiveC2wA@mail.gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <CAPhsuW5U-nPk4MFdZSeBNds0qEHjQZrC=c5q+AGNpsKiveC2wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/30/25 19:55, Song Liu wrote:
> On Fri, May 30, 2025 at 5:20 AM Mickaël Salaün <mic@digikod.net> wrote:
> [...]
>>>
>>> If we update path_parent in this patchset with choose_mountpoint(),
>>> and use it in Landlock, we will close this race condition, right?
>>
>> choose_mountpoint() is currently private, but if we add a new filesystem
>> helper, I think the right approach would be to expose follow_dotdot(),
>> updating its arguments with public types.  This way the intermediates
>> mount points will not be exposed, RCU optimization will be leveraged,
>> and usage of this new helper will be simplified.
> 
> I think it is easier to add a helper similar to follow_dotdot(), but not with
> nameidata. follow_dotdot() touches so many things in nameidata, so it
> is better to keep it as-is. I am having the following:
> 
> /**
>  * path_parent - Find the parent of path
>  * @path: input and output path.
>  * @root: root of the path walk, do not go beyond this root. If @root is
>  *        zero'ed, walk all the way to real root.
>  *
>  * Given a path, find the parent path. Replace @path with the parent path.
>  * If we were already at the real root or a disconnected root, @path is
>  * not changed.
>  *
>  * Returns:
>  *  true  - if @path is updated to its parent.
>  *  false - if @path is already the root (real root or @root).
>  */
> bool path_parent(struct path *path, const struct path *root)
> {
>         struct dentry *parent;
> 
>         if (path_equal(path, root))
>                 return false;
> 
>         if (unlikely(path->dentry == path->mnt->mnt_root)) {
>                 struct path p;
> 
>                 if (!choose_mountpoint(real_mount(path->mnt), root, &p))
>                         return false;
>                 path_put(path);
>                 *path = p;
>                 return true;
>         }
> 
>         if (unlikely(IS_ROOT(path->dentry)))
>                 return false;
> 
>         parent = dget_parent(path->dentry);
>         if (unlikely(!path_connected(path->mnt, parent))) {
>                 dput(parent);
>                 return false;
>         }
>         dput(path->dentry);
>         path->dentry = parent;
>         return true;
> }
> EXPORT_SYMBOL_GPL(path_parent);
> 
> And for Landlock, it is simply:
> 
>                 if (path_parent(&walker_path, &root))
>                         continue;
> 
>                 if (unlikely(IS_ROOT(walker_path.dentry))) {
>                         /*
>                          * Stops at disconnected or real root directories.
>                          * Only allows access to internal filesystems
>                          * (e.g. nsfs, which is reachable through
>                          * /proc/<pid>/ns/<namespace>).
>                          */
>                         if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
>                                 allowed_parent1 = true;
>                                 allowed_parent2 = true;
>                         }
>                         break;


Hi, maybe I'm missing the complete picture of this code, but since
path_parent doesn't change walker_path if it returns false (e.g. if it's
disconnected, or choose_mountpoint fails), I think this `break;` should be
outside the

    if (unlikely(IS_ROOT(walker_path.dentry)))

right? (Assuming this whole thing is under a `while (true)`) Otherwise we
might get stuck at the current path and get infinite loop?

>                 }
> 
> Does this look right?
> 
> Thanks,
> Song


