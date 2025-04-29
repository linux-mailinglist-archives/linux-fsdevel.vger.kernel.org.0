Return-Path: <linux-fsdevel+bounces-47618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B94AA12AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 18:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62F31BA4952
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF265253959;
	Tue, 29 Apr 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjBqGeHi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688924113C;
	Tue, 29 Apr 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945662; cv=none; b=dbTs/qhIu2aQtQE3+NvxXKami4enTtYs98DNz7BIcYMMf/RoTJh+PG22TbhuJue8QacqzcRrbjrMbKZX1J1sHQYRlDcEdLumx/mYfYWsK7WI5QlmhVX/sdtT4N0AK5OYhECVkHK3pzdez9K5u81Asi5I4EeHmPcPpgBWK88NI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945662; c=relaxed/simple;
	bh=gr9TqpDzik67MmDx/yJNWxsvaR2w9xNR+74mtWIzDSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB6veQCX3Iyea6CA4VN+6wpv8NjO14B6vCd6KSwM0mKvcVHYJPQwm7ir619rwp+oP4cyD7RL5W+IpRVTSZkVb5HFd02pzbT69l7ASC/XMZLNzNzzB+CWgcT3MLVdYm0ZkVKCl9/W1Rxye4fvb12cZbLMe0yycLk1fEcCc6jvPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjBqGeHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18493C4CEE9;
	Tue, 29 Apr 2025 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745945662;
	bh=gr9TqpDzik67MmDx/yJNWxsvaR2w9xNR+74mtWIzDSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjBqGeHiSIyYnLF9JqHGyzte8jhcIToNNU0IVcuqLDrSYZO4KSuKRFBBoTEc++q12
	 lRPsVjFUCO7dUmV6nBeu4sP1DX4s8GJwbjslnBbXSyJ8s0/A7VnvhbAeGyyUmjXlyr
	 74K+qiT2F8xLKeivwmSxSxaA1T2BFaN4tG9805eYGd4/SSvIIWEXvHdfPKqx7RtDOW
	 vwZTyUXri3wv6BHe+ghfzhoBxNEyJBSCZ2cF6IM6oX9aVhzUEQAUKFHJoleIoC10X1
	 ZLybNxoWxmfyvSZKPug07cfwmUSIXJdEX5uOpWH+2j8uxPR6rYOHxRtvE9D9ORGAIn
	 bRaUOpC+98uxQ==
Date: Tue, 29 Apr 2025 09:54:21 -0700
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
Subject: Re: [PATCH v3 4/4] mm: perform VMA allocation, freeing, duplication
 in mm
Message-ID: <202504290954.B4A4F99E7@keescook>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>

On Mon, Apr 28, 2025 at 04:28:17PM +0100, Lorenzo Stoakes wrote:
> Right now these are performed in kernel/fork.c which is odd and a violation
> of separation of concerns, as well as preventing us from integrating this
> and related logic into userland VMA testing going forward, and perhaps more
> importantly - enabling us to, in a subsequent commit, make VMA
> allocation/freeing a purely internal mm operation.
> 
> There is a fly in the ointment - nommu - mmap.c is not compiled if
> CONFIG_MMU not set, and neither is vma.c.
> 
> To square the circle, let's add a new file - vma_init.c. This will be
> compiled for both CONFIG_MMU and nommu builds, and will also form part of
> the VMA userland testing.
> 
> This allows us to de-duplicate code, while maintaining separation of
> concerns and the ability for us to userland test this logic.
> 
> Update the VMA userland tests accordingly, additionally adding a
> detach_free_vma() helper function to correctly detach VMAs before freeing
> them in test code, as this change was triggering the assert for this.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

