Return-Path: <linux-fsdevel+bounces-43438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9996A56A43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352613B523F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3B21B9FE;
	Fri,  7 Mar 2025 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KolgCqAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C2521B8EC;
	Fri,  7 Mar 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357352; cv=none; b=G17Gzmzm9yRn1CMvCC3zpYKXKme8dpK133LOsRE+eJI5AuLH9XdD8OUfiNb/kDYumgeEeRi8vJBh6C7CcNqzrokfADq6a7BZRYhq4Cr2gbxlSMicnm1a7jS83MaAxiKkofNsyfPexL7wfFPUg1hopPJZWibY1hfyhMrg0VUqyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357352; c=relaxed/simple;
	bh=X3ORUjoZt3a05J27V39j/6RYjOtuvKW2HwdHZmExThQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jKaELSpKKRUJ+2Mp8yi+iENHgOIT12+PtKyvyhZvVjcdg6uUJUvg1tsWMsIvgY81TMpKU12kRgmI0PgZYFGgjCtq0YbKfbD+JAi9OTa1M3URCj811vzL6/dtNHIgKrJOy/z8IG8wNGWaFsDX3rjTttLeRzU0kgwksd8YO5OCy+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=KolgCqAa; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 306574105E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741357344; bh=ihMi6eUWoBG67x5XZWjzpKw0nnicR+z1rqoKyPAosc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KolgCqAaKSRvl4BpdkLf68uOY6ycttrCai6uBAeUv7AYMdowFzB1ry6Fa6VN6EU+r
	 bccR64R5gTWUfbaTknO2VDolfU7n0LqUsLvlq22+KM2tlEq+yeOqSE1jRudS9Q4AIW
	 o0Vc8o1cE/Hb9ZdiN8Xe39y/6NnMSNZlKE+PLAZUvlmamH5cJUvvsaF87Fx7qYv8qL
	 4Zsmao2IGj0jFTxt4SzmuF0k9XzKqv4yhhS43MGHNzZ5ZPOBnEyKIK1yjSYqQT41uT
	 vqNEJYuLNI7HBC91PUmiPRd6F/QubeYSPstaCdCrVSwoQWHLGMWq2k/ydrtBC/Ty4h
	 MI4WzsTnml+uw==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 306574105E;
	Fri,  7 Mar 2025 14:22:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pratyush Yadav <ptyadav@amazon.de>, linux-kernel@vger.kernel.org
Cc: Pratyush Yadav <ptyadav@amazon.de>, Eric Biederman
 <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Hugh
 Dickins <hughd@google.com>, Alexander Graf <graf@amazon.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, David
 Woodhouse <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, Mike
 Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha
 Tatashin <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
 Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Wei
 Yang <richard.weiyang@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 2/5] misc: add documentation for FDBox
In-Reply-To: <20250307005830.65293-3-ptyadav@amazon.de>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-3-ptyadav@amazon.de>
Date: Fri, 07 Mar 2025 07:22:23 -0700
Message-ID: <87ikok7wf4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pratyush Yadav <ptyadav@amazon.de> writes:

> With FDBox in place, add documentation that describes what it is and how
> it is used, along with its UAPI and in-kernel API.
>
> Since the document refers to KHO, add a reference tag in kho/index.rst.
>
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> ---
>  Documentation/filesystems/locking.rst |  21 +++
>  Documentation/kho/fdbox.rst           | 224 ++++++++++++++++++++++++++
>  Documentation/kho/index.rst           |   3 +
>  MAINTAINERS                           |   1 +
>  4 files changed, 249 insertions(+)
>  create mode 100644 Documentation/kho/fdbox.rst

Please do not create a new top-level directory under Documentation for
this; your new file belongs in userspace-api/.

From a quick perusal of your documentation:

- You never say what "KHO" is

- Your boxes live in a single global namespace?

- What sort of access control applies to one of these boxes?  What keeps
  me from mucking around inside somebody else's box?

Thanks,

jon

