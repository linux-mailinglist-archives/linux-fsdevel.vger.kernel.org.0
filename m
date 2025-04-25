Return-Path: <linux-fsdevel+bounces-47317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20DFA9BD2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 05:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CAA9A0686
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 03:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D9E1581F9;
	Fri, 25 Apr 2025 03:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBo/6pkD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36BB4C6E;
	Fri, 25 Apr 2025 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745550930; cv=none; b=F2FoQ+g3YtIh2d0NQW3FPur6UTAlbErvvSghsrCs4IH96Ry6NP8GElSUYierZUaEMwEcnBWxfH66vD/rs2f4CLOKqrKaz3d8bYRqmRtc8a3+3wb6boyU+Ntc2axuEQt/VZc9WX+XW8qb0rgNwWEjUy3A9de7NmNHWt0NsbjmTnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745550930; c=relaxed/simple;
	bh=lf5tYFHlmIW306cV5CFtXC6/2U+4s88U3LbYKiT5a0k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RpIukp40V8DHu6+CGSsOEi5QPidWmi9AnaLIW2nwPZ1n2UIJVCpjpBYR1EHYdhh8qmMJj6ebJsakSvugJQXDEJzr/fhSbi0iBaWTTzUzhI9oS1cyojHGKqX+9AIpYoEFYxvo6NmIhWvfr6cN4K4gvJEeQ9OaG1ekSHuKLd/NAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBo/6pkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D949C4CEE3;
	Fri, 25 Apr 2025 03:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745550930;
	bh=lf5tYFHlmIW306cV5CFtXC6/2U+4s88U3LbYKiT5a0k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VBo/6pkDA2LAogTSBoBn3KFLL/xy9d+85Hj3iXb0gREbs6wSKM/zRz6ITogqG/66W
	 WUwUUgSlFVxQzsF0Nj7ceWd0CpsxKHU7nG6yftMZEr72APlPEwKz+3kYOJkxFrFLhm
	 k49uDAViNnQo1SkFaY8uWfSutlCK3pfvEUywSgsswO9PTaFP/zqzxe2F2vk603LVrX
	 k5OGlsEy3cKpcAaoS0BrFnmjfBkeyL6QO+vPBrsAaukPOZldiqRelNPM08hQUPJiry
	 MOmoyR1FWlUWjZOHPtx6q2Z4CMrQv+C/a3O+Hqt0bw+D8fM/9hZ3FrQIL7Ma3KzfX+
	 E7P3ToTYd69sg==
Date: Thu, 24 Apr 2025 20:15:26 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
CC: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/4=5D_mm=3A_perform_VMA_all?=
 =?US-ASCII?Q?ocation=2C_freeing=2C_duplication_in_mm?=
User-Agent: K-9 Mail for Android
In-Reply-To: <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com> <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
Message-ID: <51903B43-2BFC-4BA6-9D74-63F79CF890B7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 24, 2025 2:15:27 PM PDT, Lorenzo Stoakes <lorenzo=2Estoakes@oracl=
e=2Ecom> wrote:
>+static void vm_area_init_from(const struct vm_area_struct *src,
>+			      struct vm_area_struct *dest)
>+{
>+	dest->vm_mm =3D src->vm_mm;
>+	dest->vm_ops =3D src->vm_ops;
>+	dest->vm_start =3D src->vm_start;
>+	dest->vm_end =3D src->vm_end;
>+	dest->anon_vma =3D src->anon_vma;
>+	dest->vm_pgoff =3D src->vm_pgoff;
>+	dest->vm_file =3D src->vm_file;
>+	dest->vm_private_data =3D src->vm_private_data;
>+	vm_flags_init(dest, src->vm_flags);
>+	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
>+	       sizeof(dest->vm_page_prot));
>+	/*
>+	 * src->shared=2Erb may be modified concurrently when called from
>+	 * dup_mmap(), but the clone will reinitialize it=2E
>+	 */
>+	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
>+	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
>+	       sizeof(dest->vm_userfaultfd_ctx));
>+#ifdef CONFIG_ANON_VMA_NAME
>+	dest->anon_name =3D src->anon_name;
>+#endif
>+#ifdef CONFIG_SWAP
>+	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
>+	       sizeof(dest->swap_readahead_info));
>+#endif
>+#ifdef CONFIG_NUMA
>+	dest->vm_policy =3D src->vm_policy;
>+#endif
>+}

I know you're doing a big cut/paste here, but why in the world is this fun=
ction written this way? Why not just:

*dest =3D *src;

And then do any one-off cleanups?


--=20
Kees Cook

