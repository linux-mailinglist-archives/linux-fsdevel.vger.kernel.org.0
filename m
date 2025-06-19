Return-Path: <linux-fsdevel+bounces-52202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E1DAE02CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E87189DC6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49220224234;
	Thu, 19 Jun 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQnBwOlJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87D178372;
	Thu, 19 Jun 2025 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329512; cv=none; b=stzVsU5jpDD5kfuZCgh7ZwbTN4bb/m4KlVWtKOFl1JhaUVFJcu5kyoxnwAo5R4NDIWmOzJtIZLnjv2N38q2TIdtUZ7kPhyuEnts1YEq+3jrvtEL2DYP8Q5Y1TTgrFZgiTh4QaqcSaq6jFiPKmzgnXiTmRY3eAT1FAZuFR9aaMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329512; c=relaxed/simple;
	bh=vnHi+RdO+P6c9f2EfRap8UJxGiKK7J1jHomttd6Dip8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnwKs5SzznAsA7mardSvcj7uwPmTLClLf6abUtP6z1bXRIpb64R0N33EQ/wh91KZYf8pmGd6y8/lrxtZkbNFyAagtAX1FxI9ySeLcv2anqafTvjCcSgIE259o1gHAiep94HsHvNr9Yuol385hIxwfiT9xOuz1ptstcn1GW1VY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQnBwOlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9399BC4CEEA;
	Thu, 19 Jun 2025 10:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750329512;
	bh=vnHi+RdO+P6c9f2EfRap8UJxGiKK7J1jHomttd6Dip8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQnBwOlJJ/89T7M179iD1AtWZGIGb6wExbxzEknJVqHP/+9vTjvDTX3WnS8Vl+orG
	 u2Bt6exz0WK/3MZMehqzjT4znWzKTsFxaQTLvg2R/mo8n3tPn+oIbBSM9TpWgdfbM4
	 T2Op7PQVXLgQ+hT50NfZRiYUKBX6CCwRJhflJhWVjROvGmPK9TkA95vq4wOqGZ9Xgq
	 pbjint9ouDMlfGd7gyKC8pDHxLhf4DN6zVnHTxDixSYlOlct243FQi0nY0uWrZs9dN
	 1B/bxwbD22dnbtjigtRUuLzXCoBJTTaZiJSkvxBeXhnbT2yJOD7YnQkMGJJh8n1mtQ
	 Dota6Cqy1zlAw==
Date: Thu, 19 Jun 2025 12:38:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shivank Garg <shivankg@amd.com>, david@redhat.com, 
	akpm@linux-foundation.org, paul@paul-moore.com, rppt@kernel.org, viro@zeniv.linux.org.uk, 
	seanjc@google.com, willy@infradead.org, pbonzini@redhat.com, tabba@google.com, 
	afranji@google.com, ackerleytng@google.com, jack@suse.cz, hch@infradead.org, 
	cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Message-ID: <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
References: <20250619073136.506022-2-shivankg@amd.com>
 <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>

On Thu, Jun 19, 2025 at 11:13:49AM +0200, Vlastimil Babka wrote:
> On 6/19/25 09:31, Shivank Garg wrote:
> > Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
> > anonymous inodes with proper security context. This replaces the current
> > pattern of calling alloc_anon_inode() followed by
> > inode_init_security_anon() for creating security context manually.
> > 
> > This change also fixes a security regression in secretmem where the
> > S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
> > LSM/SELinux checks to be bypassed for secretmem file descriptors.
> > 
> > As guest_memfd currently resides in the KVM module, we need to export this
> 
> Could we use the new EXPORT_SYMBOL_GPL_FOR_MODULES() thingy to make this
> explicit for KVM?

Oh? Enlighten me about that, if you have a second, please. 

