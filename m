Return-Path: <linux-fsdevel+bounces-73238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA770D134DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98071307E05C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DD72BF019;
	Mon, 12 Jan 2026 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DbJ85YSe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B72C0272
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228233; cv=none; b=fawkrEjB1CSL8wkSYy8waYuLpLPnOZ2KwCWaGcTUhzrynQlyMHCMbFTYvu5DWSMvlJNMtyMja9TM4PSU03eFf23qjyIDDM0VS9xfjNZXnoQa3vAPSDZr4wpB0e0UqQiTYnJpdOAnx0HhljVy6Dy3wGhwOCIqic5ZRaBH+Bxd8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228233; c=relaxed/simple;
	bh=VeWksy66lpkvgMhVOcEq/CQua3k6ndGuRBBIBT86hX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoXOpmXUXXnjcbseVb0hoJoVZq7o000PFkIEwLHyi9HKKREjFufynOvXZHICQCsFJh9tjsCfT8e//WviJOy00NJ9Cksc/iDgsoZY240bx5tD4xjyn2yxYxXlPAOm5iDjwDvzo1cRvp0kfNzktno/HyxxWL0Ctmu5fym1sCbIYKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DbJ85YSe; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so41727065e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768228229; x=1768833029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ufp0SZFe0MebuLzATEI2/9d5yfpShZoQXYWtR9jnTtQ=;
        b=DbJ85YSee6JqVyq3jcPhZ7x0S03Ty9JPFZP7J/rcQTAU7p5oMws5b8tP6sdCe4lDWd
         gthz4pNGruFz5FUvS99CDZUAlif5iJgEk4+MHSQazQyDXyEWa2fytpVjzPrPJ8nHAWBZ
         rjpOmqyoozwU7ejlGZ92CGnZy1EKx42NXBX2I4z7+28ohYEClym2/2iUjJNYxg9iprZO
         IVUEiLcUy2g+/J4WQcdJXwA4PT4lyHdO9ufhbXe5aEHmJB5593HAZ8lw6Yzvw+cAbYl8
         ZZ8aJVv3pwscNc9uuh/QuxuC01S6vvJqcW+kmpGoL/1VCjU01Ilu8+eJEs/jWb+nX823
         xmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768228229; x=1768833029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ufp0SZFe0MebuLzATEI2/9d5yfpShZoQXYWtR9jnTtQ=;
        b=WqcOXDOm0TGDSXVxsSM/GgJJxEr+RV/BRS5P1pNUNMx+WP3M86Rb4nnPDPXRVczZFk
         QTEjkSeDUVVGyJzLQjj/maZ2zQHub0VFUxCdEsrH+Dv9CBNVXTmPJz3wUs+kSz/ZS0Tv
         LdQkijLreEzZ2a4CRO9g5C/NH/dSh3ov1tkGrt145YOssatVU0k2fBxxae7WiyLSKUzy
         cmLMoGChTJ9qIfjP27OX/t0uXQqp0f0dOmtGDxk7n6QE0WjT18RkBvoYy1eaEsQdBYF5
         WebynAbtx5o7gNvv4RnfA6sfxRx/bu7nqfPcVJCxWUGVGaJi+8yKtXRXVfMrR7kcLF8a
         EjRw==
X-Forwarded-Encrypted: i=1; AJvYcCX6s2lPxVMe/VjwRD6yZsPfgBeC0mysVkSz4MC2Kum+u3hiYZqGtBL+XXZbI6x1JrEXkhqGIUak6Zsdgpqu@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmpqvJ36yWXjhjM/HW5ik21Eoe2wYedBHx/EEPesScEewRYSf
	m0pupFiMEGHKVehRJlz0+E9h/CJYvTXrwRtJcMK1w5zMW5OONFR3k0NlovTkClSk81E=
X-Gm-Gg: AY/fxX5qqgWu7M7TUVnk714J9Gw4nBjIMqLkH6USGdkGjr7jSHaBPAehxwGNb9sYshG
	4qpMHg6gaqt4QeuAT2VupX8M/z2I0seHlnk3fMpgJ+2VUkt1FNDkYKkIisr7g2y9HaJ6tf4j5mZ
	XTqjF7af8DakGpStzDxeeASEmIVXpThj2UbaDVKnji9XV+e10PeZFd7GRj32gYfILSORENTl8Ur
	AvDGT14tEU6KYkeNBvcQZ4f9N9ITYYe9WjknQpbnFH64aQz5GM/Yy5/j49lySfdnCzpimgQQa5V
	AiPPuxwzLOk1v1cNCOXqudysrLEe8trpRc49MauuSQ24gYYpf2p35Khs457WtGFnhOJFT604nss
	9pGazBD1st3hYq73M965xe+T1OyT9rxC4QJ8CBuTc24eGTs4Q50HgbS6uMXCamKF16TLa78Xuzw
	UHlJcQyAqRrhKj4lF7wmsbmBhKAU8pqj0=
X-Google-Smtp-Source: AGHT+IHDVuFl+T/cu+HZzO3h+yAn0G+FdrWgV6XO6swWljps8VItMR+Lttj4fdxMmzgr/HRFuS5nGg==
X-Received: by 2002:a05:600c:82c3:b0:475:de68:3c30 with SMTP id 5b1f17b1804b1-47d84b21466mr211537245e9.16.1768228229374;
        Mon, 12 Jan 2026 06:30:29 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865f84besm139369365e9.1.2026.01.12.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:30:28 -0800 (PST)
Date: Mon, 12 Jan 2026 15:30:26 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	dan.j.williams@intel.com, akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, 
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com, david@kernel.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, rientjes@google.com, shakeel.butt@linux.dev, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	baohua@kernel.org, yosry.ahmed@linux.dev, chengming.zhou@linux.dev, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, cl@gentwo.org, harry.yoo@oracle.com, 
	zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 5/8] Documentation/admin-guide/cgroups: update
 docs for mems_allowed
Message-ID: <o6eky3g4jyvtc2cy6lk7rjc6or6tcvwbhdarrlpn4geuibvrul@65fygkf6vg44>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-6-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zsg7ffk6fb5gx5vt"
Content-Disposition: inline
In-Reply-To: <20260108203755.1163107-6-gourry@gourry.net>


--zsg7ffk6fb5gx5vt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v3 5/8] Documentation/admin-guide/cgroups: update
 docs for mems_allowed
MIME-Version: 1.0

Hello.

On Thu, Jan 08, 2026 at 03:37:52PM -0500, Gregory Price <gourry@gourry.net>=
 wrote:
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2530,8 +2530,11 @@ Cpuset Interface Files
>  	cpuset-enabled cgroups.
> =20
>  	It lists the onlined memory nodes that are actually granted to
> -	this cgroup by its parent. These memory nodes are allowed to
> -	be used by tasks within the current cgroup.
> +	this cgroup by its parent.  This includes both regular SystemRAM
> +	nodes (N_MEMORY) and Private Nodes (N_PRIVATE) that provide
> +	device-specific memory not intended for general consumption.
> +	Tasks within this cgroup may access Private Nodes using explicit
> +	__GFP_THISNODE allocations if the node is in this mask.

Notice that these files are exposed for userspace. Hence I'm not sure
they'd be able to ask for allocations like this (or even need to know
about this implementation detail).

> =20
>  	If "cpuset.mems" is empty, it shows all the memory nodes from the
>  	parent cgroup that will be available to be used by this cgroup.
> @@ -2541,6 +2544,25 @@ Cpuset Interface Files
> =20
>  	Its value will be affected by memory nodes hotplug events.
> =20
> +  cpuset.mems.sysram
> +	A read-only multiple values file which exists on all
> +	cpuset-enabled cgroups.
> +
> +	It lists the SystemRAM nodes (N_MEMORY) that are available for
> +	general memory allocation by tasks within this cgroup.  This is
> +	a subset of "cpuset.mems.effective" that excludes Private Nodes.
> +
> +	Normal page allocations are restricted to nodes in this mask.
> +	The kernel page allocator, slab allocator, and compaction only
> +	consider SystemRAM nodes when allocating memory for tasks.
> +
> +	Private Nodes are excluded from this mask because their memory
> +	is managed by device drivers for specific purposes (e.g., CXL
> +	compressed memory, accelerator memory) and should not be used
> +	for general allocations.

So I wonder whether the N_PRIVATE nodes should be included in
cpuset.mems[.effective] at all.
(It resembles CPU isolation to me a bit ~ cpuset.cpus.isolated.)
Maybe you only want to expose it on the root cpuset cg and inverted like
cpuset.mems.private?

Thanks,
Michal

--zsg7ffk6fb5gx5vt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWUFgBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AivpwD+JBcYsTGjsYsxubfnEPsa
ZpJvMAA2jVDEmQNiB588agwBAPoLqRDiK7ZtFi8f8bY/cXcHgh+krN2tOGh2v+x0
RlAB
=oogw
-----END PGP SIGNATURE-----

--zsg7ffk6fb5gx5vt--

