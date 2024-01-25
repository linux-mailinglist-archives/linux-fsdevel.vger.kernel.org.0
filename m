Return-Path: <linux-fsdevel+bounces-8867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8DA83BD89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FED1C249C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5429D1CAB5;
	Thu, 25 Jan 2024 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7cXshX8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11551C686;
	Thu, 25 Jan 2024 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175497; cv=none; b=kolcaZdky0iKA4KioKielAjULW1L3egfq33h2UtRuxi0udZ632jhW12jV9XjasgCCe4ayjMhCpS1ncSEFyMeyH7KGHu+tuElYNNENJ5Fn1CTBlEGlQuLFbKGKEylV2u5Bme+FvPjDmSS2bKe1FkvmDYAOubCiJ95VwWtLKth6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175497; c=relaxed/simple;
	bh=uPP+taTP7ZolS6r9LsAYX+LZFusJs4p/dtdN1utPMp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m49Vd3TB1Zo6B/0fnCI1ykGFV9osPtkHqjiVy6WHa4fVhe1iYIFGc9vhxUYwFMoxpD2SFHTF/8UoSOg8ngFHo7V3KZbEtqZXpVLsOnfParBlKStv4PUyitjlrYpbPVk7XP3bFngr5l/hhz4qC+XXUAywEoKauH3UfniHrQzM8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7cXshX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED44C433F1;
	Thu, 25 Jan 2024 09:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706175497;
	bh=uPP+taTP7ZolS6r9LsAYX+LZFusJs4p/dtdN1utPMp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7cXshX8VvMZ6jy4uPpWWynFqF9KKNfsuTOE+lHocKux1Enp2X7ezkrdx2mEtZ1VQ
	 LItqtzp2SW+2CD3snw+qSYfrsmDrEq0Dn4raou7eXyBJ2dtkI+P8orlt5xAokl5o8n
	 L0cBeGTUN9cFzTsSa+L6AcTLagQF/Y5/LBUYrGsCJ8eTWL6c56NA4hpyHlORUbS/D8
	 LOnSMKWCMSO8ZmNLQ4UMXAbKfv/Qz0N0UJkxikSraGGpia2d09HLaan9M226Qo2U9o
	 xeM0WwgfCW15yfnLsHT9YlnVBBRQ/m6QJ0XvpwG7srrfyEL0qK5dkix11u+AICshRh
	 JzCBBEhUijaXw==
Date: Thu, 25 Jan 2024 11:37:49 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
	aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
	axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
	jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com
Subject: Re: [PATCH] userfaultfd: fix return error if mmap_changing is
 non-zero in MOVE ioctl
Message-ID: <ZbIr7SMd1GJa6T7z@kernel.org>
References: <20240117223922.1445327-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117223922.1445327-1-lokeshgidra@google.com>

On Wed, Jan 17, 2024 at 02:39:21PM -0800, Lokesh Gidra wrote:
> To be consistent with other uffd ioctl's returning EAGAIN when
> mmap_changing is detected, we should change UFFDIO_MOVE to do the same.
> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  fs/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 959551ff9a95..05c8e8a05427 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2047,7 +2047,7 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
>  			ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
>  					 uffdio_move.len, uffdio_move.mode);
>  		else
> -			ret = -EINVAL;
> +			ret = -EAGAIN;
>  
>  		mmap_read_unlock(mm);
>  		mmput(mm);
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 
> 

-- 
Sincerely yours,
Mike.

