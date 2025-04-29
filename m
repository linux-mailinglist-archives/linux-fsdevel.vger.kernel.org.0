Return-Path: <linux-fsdevel+bounces-47617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5698EAA12C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 18:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E5D98310D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6263124C08D;
	Tue, 29 Apr 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvCxpf1z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7FA2517A5;
	Tue, 29 Apr 2025 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945658; cv=none; b=UFNJCHSEcwWZbxxqCcp2xfdGqHQDMOPPgL1Zpe+7E8AngnzdcSc2FEcExpeC54ZrzgE8rH2wyJx1XBzt9vnNceqWByee34Y13ZiicEl4I1WgCbIBnz0OqKHUXZUU2f16zOHs0TrYW1Oc4lCKXuDf0hNXjsHbrRTeoy75SRXw+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945658; c=relaxed/simple;
	bh=++dhepfBhRi0erK+LYv8IWVCWaZFGXckt9RPxoukWxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLi71MLrnSD2qAfiQUTbz3xjkGcTSZ9tTZaRcV5X3MX/DM+y5ib4HvLaOq3w8C4uTKMbATYqqMiXaxqcpaRum2X62OMtvxgAVPc5lGaXDQJInJ/li32ZfXMD8+qUl6FsZBCXA7i3i0PozCHhr11mGKrwi7RosTd4gp4giwQmz2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvCxpf1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386C9C4CEE9;
	Tue, 29 Apr 2025 16:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745945658;
	bh=++dhepfBhRi0erK+LYv8IWVCWaZFGXckt9RPxoukWxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvCxpf1zBWxt7kM/bFBgYrYsVwdvEhgx8DFDqgQezureiY3Ayu7GnmqEwIE5Pq7GN
	 L6W2qSGh70igv0zgSYxP++zBPUJ8is4gXDYl8CCPoMHa0/lePsK0tVy09LkxO4iXEd
	 yoi/SHAnRjszqDaHEpKmGxlBlMV/Sx3RyZJhlVGcN5OlglvJost7IbR2QAtUfwJwuA
	 rpD0tRSpBJ2XLnFhYaWgnZbq3NEXo3YaEN29VwQ5UVlJxuhe7+siV06LROBG6l7/qA
	 HTC2eEpHs0tv30aVV6ftZuS/nRhVCLFdbe4hdksymcwQAlurG5YPZCWqzHLKmic3Jt
	 xjjIDtKPb89Dg==
Date: Tue, 29 Apr 2025 09:54:14 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mm: move dup_mmap() to mm
Message-ID: <202504290954.754D25567A@keescook>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <e49aad3d00212f5539d9fa5769bfda4ce451db3e.1745853549.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e49aad3d00212f5539d9fa5769bfda4ce451db3e.1745853549.git.lorenzo.stoakes@oracle.com>

On Mon, Apr 28, 2025 at 04:28:16PM +0100, Lorenzo Stoakes wrote:
> This is a key step in our being able to abstract and isolate VMA allocation
> and destruction logic.
> 
> This function is the last one where vm_area_free() and vm_area_dup() are
> directly referenced outside of mmap, so having this in mm allows us to
> isolate these.
> 
> We do the same for the nommu version which is substantially simpler.
> 
> We place the declaration for dup_mmap() in mm/internal.h and have
> kernel/fork.c import this in order to prevent improper use of this
> functionality elsewhere in the kernel.
> 
> While we're here, we remove the useless #ifdef CONFIG_MMU check around
> mmap_read_lock_maybe_expand() in mmap.c, mmap.c is compiled only if
> CONFIG_MMU is set.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

