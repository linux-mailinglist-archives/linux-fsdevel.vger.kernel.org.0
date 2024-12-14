Return-Path: <linux-fsdevel+bounces-37398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D74C9F1BA9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 02:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913D87A0464
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 01:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4C5101DE;
	Sat, 14 Dec 2024 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYxcpPe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78750C8EB;
	Sat, 14 Dec 2024 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734138328; cv=none; b=s/8s9V1jrU+odsO/PiFHZPVcZjyH92RCKH35LhC6ZlPKwLAJwTk1tmQUCKW7F5+r8G/5XiW4lUIiG5ZMTDJn1XBr9Somt3f/j7yjK1qXcqYktezhro8dS0rhAng/wPlx9oEb4QmLh4oC8TVCq9bewUb72STH2D0EiPrXHpTDnSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734138328; c=relaxed/simple;
	bh=8v3HTeJ8Zzta/QPlaLiGhVXZsgkLuLw6qMhtr9jT3/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow3D1EKatCbr4xtynrvlLeJPYDi+urv//hDxFg79RWQVt+sY2nYcr1nU+Qxw76bLrNPSNpwCQlqVLta4nrtUyCUhviNlab0XgUp6x2YwbuYplaI3h4LiLE0gKF09CdGARQmAqcluq7WP4lq7yh4dNwuQm+/LrDpa6o5s5/2gGyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYxcpPe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D2BC4CED0;
	Sat, 14 Dec 2024 01:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734138327;
	bh=8v3HTeJ8Zzta/QPlaLiGhVXZsgkLuLw6qMhtr9jT3/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYxcpPe9kKxjt/67AlvX1qE9ryGZ4CUuoEJIpFY1rwHaA5b27iGfzypm6RQRkRGB9
	 kZ0iMjjKc+BCVBQZMaStu2W7puRFEcVbf00ha8k+DceeKXkyuRQBmiK0nuucJV0qRL
	 9f4qwY1Z3qhQkcDRMAEYbzydtRTp7g/+h0TsyQNVMoSLVoEV3UfrQ2WYcDISGx/R1/
	 rck7tCxXzMmrGozWLdjYoSn/C8m5ucRhouBfLbLrRQdgUGfAECKyjLF9Tc5r9V4wnE
	 HAo4gy+m4OMSgsZf64a8hqBvgf+ygvoXJODJHP6P00mw+oZr4exEm4E9I6K/ZN2+TH
	 2G83okmSoRtYA==
Date: Fri, 13 Dec 2024 17:05:24 -0800
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: abstract get_arg_page() stack expansion and mmap
 read lock
Message-ID: <202412131701.81693C36C@keescook>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
 <5295d1c70c58e6aa63d14be68d4e1de9fa1c8e6d.1733248985.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5295d1c70c58e6aa63d14be68d4e1de9fa1c8e6d.1733248985.git.lorenzo.stoakes@oracle.com>

On Tue, Dec 03, 2024 at 06:05:10PM +0000, Lorenzo Stoakes wrote:
> Right now fs/exec.c invokes expand_downwards(), an otherwise internal
> implementation detail of the VMA logic in order to ensure that an arg page
> can be obtained by get_user_pages_remote().

I think this is already in -next, but yeah, this looks good. It does mix
some logic changes, but it's pretty minor.

> -	if (write && pos < vma->vm_start) {
> -		mmap_write_lock(mm);
> -		ret = expand_downwards(vma, pos);
> -		if (unlikely(ret < 0)) {
> -			mmap_write_unlock(mm);
> -			return NULL;
> -		}
> -		mmap_write_downgrade(mm);
> -	} else
> -		mmap_read_lock(mm);
> +	if (!mmap_read_lock_maybe_expand(mm, vma, pos, write))
> +		return NULL;
>  
> [...]
> +	if (!write || addr >= new_vma->vm_start) {
> +		mmap_read_lock(mm);
> +		return true;
> +	}
> +
> +	if (!(new_vma->vm_flags & VM_GROWSDOWN))
> +		return false;

The VM_GROWSDOWN check is moved around a bit. It seems okay, though.

> +
> +	mmap_write_lock(mm);
> +	if (expand_downwards(new_vma, addr)) {
> +		mmap_write_unlock(mm);
> +		return false;
> +	}
> +
> +	mmap_write_downgrade(mm);
> +	return true;

I actually find this much more readable now since it follows the more
common "bail out early" coding style.

Acked-by: Kees Cook <kees@kernel.org>

Thanks!

-Kees

-- 
Kees Cook

