Return-Path: <linux-fsdevel+bounces-40998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9681A29E96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 03:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7AE1888430
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 02:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404536A33B;
	Thu,  6 Feb 2025 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZevDOquR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE2D529
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738807484; cv=none; b=msivTmaxS++CdegzThA2hlp3KBGrto0SWwy69mLmrabGQ0/7fmeC2IxL7KlB3O+w8RYOAKCyxAe6I245r905ipCYxlPIAUaFN6MxQHfU56Xni5USqxwgV71F4lMeRSKmtk1SNEwXFyLbFoNTplHiaZgm4FlhpR1PRGQHGxS1yE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738807484; c=relaxed/simple;
	bh=2BGYdAJ6jgN730vfsbEIZyGAPPsX6XOBK8JFPG31Df0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WvUVT4Y4oxF/qoQevPUV9cKdKSjTOahO3oqDuWvn/U9GcnKZDyt58tT8W9lFJ4rMU/Hwp6YJMhTXBYQ2U/qDXz0h1rtbd8T30qLACKJ66wLuAqddJmZM7/cvXN+ILA9HL6WSsc7tWGKujkEyAHXRvkBXEF2yErri+mpk1AcSdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZevDOquR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50C5C4CED1;
	Thu,  6 Feb 2025 02:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738807484;
	bh=2BGYdAJ6jgN730vfsbEIZyGAPPsX6XOBK8JFPG31Df0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ZevDOquR3Zv5c6kBmwCR6/d3VClFcr/U1uC+mxUfZN0h6nPSEmZAVOTCG+9YWcdpY
	 m57t+hJ7Z4G3dkqSV7bxmVrIs1z094lTw6F1V49jUARksh2OPT+tR1XkwdRC01O2wv
	 TeApgbxcHVXUBxjQQITUI27JV6wj1LF+FZnDhNT1m10rjhxYI3WhYIfcVqdcXPC5Lq
	 EzBtt17WGw9jfbCP0sJ2mzw1YnD3mbov2VXGjGXYAe85wpMkhnl2kjoVNQ4kY8Aawx
	 kJ0Wo7Ml4+0Rd+8caM9PdILU3illFiljbR9pjQ/Lx0e4jSAVtc3RbAPtDsMq/se5By
	 JdsoO4wLX7UPQ==
Date: Wed, 05 Feb 2025 18:04:41 -0800
From: Kees Cook <kees@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
 brauner@kernel.org
CC: viro@zeniv.linux.org.uk, neilb@suse.de, ebiederm@xmission.com,
 tony.luck@intel.com
Subject: Re: [PATCH 1/4] pstore: convert to the new mount API
User-Agent: K-9 Mail for Android
In-Reply-To: <20250205213931.74614-2-sandeen@redhat.com>
References: <20250205213931.74614-1-sandeen@redhat.com> <20250205213931.74614-2-sandeen@redhat.com>
Message-ID: <DD66BE90-95CD-4F75-AD47-50E869460482@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 5, 2025 1:34:29 PM PST, Eric Sandeen <sandeen@redhat=2Ecom> wr=
ote:
>Convert the pstore filesystem to the new mount API=2E

Thanks for doing this!

> [=2E=2E=2E]
>+static const struct fs_parameter_spec pstore_param_spec[] =3D {
>+	fsparam_u32	("kmsg_bytes",	Opt_kmsg_bytes),
>+	{}

I am reminded to change the global to u32 (ulong is way too big), and fix =
the pstore_set_kmsg_bytes() prototype to be u32 not int=2E :)

> [=2E=2E=2E]
>+	/* pstore has historically ignored invalid kmsg_bytes param */
>+	if (opt < 0)
>+		return 0;

Seems like a warning would be at least user-friendly=2E ;) I can add that =
later=2E

> [=2E=2E=2E]
>@@ -431,19 +434,33 @@ static int pstore_fill_super(struct super_block *sb=
, void *data, int silent)
> 		return -ENOMEM;
>=20
> 	scoped_guard(mutex, &pstore_sb_lock)
>-		pstore_sb =3D sb;
>+	pstore_sb =3D sb;

Shouldn't scoped_guard() induce a indent?

>=20
> 	pstore_get_records(0);
>=20
> 	return 0;
> }
>=20
>-static struct dentry *pstore_mount(struct file_system_type *fs_type,
>-	int flags, const char *dev_name, void *data)
>+static int pstore_get_tree(struct fs_context *fc)
>+{
>+	if (fc->root)
>+		return pstore_reconfigure(fc);

I need to double check that changing kmsg_size out from under an active ps=
tore won't cause problems, but it's probably okay=2E (Honestly I've been wa=
nting to deprecate it as a mount option -- it really should just be a modul=
e param, but that's a separate task=2E)

Reviewed-by: Kees Cook <kees@kernel=2Eorg>

(Is it easier to take this via fs or via pstore?)

-Kees

--=20
Kees Cook

