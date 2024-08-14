Return-Path: <linux-fsdevel+bounces-25846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E58D951105
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2D0281449
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 00:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE17B1FA1;
	Wed, 14 Aug 2024 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="pXhW7HHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC87E1859
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723595291; cv=none; b=alJ32Rg96qqTfgKzGjTPvF5SUrOonqcC9aVcl4ORCXuJ7OPTHEmBvnG58wdx5qT3EySp9vgSE4bTRZvOdA8Q+KZp+EDDWI3qBhC/UAFIdFd7cEads5BPwDZHMcbxTp9df3o7OgGguI6NO6No3GbRyqt/AiLsDyUgzzLVHehcDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723595291; c=relaxed/simple;
	bh=24MruGhDlX2JWI1CHWe1e4B6nwuCUAe+eYWwAbYt85k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTxtRKoxun1JjbDnuNWU6OvTKdPjXsuFj9yZax42CFutp6Y7PdfX8ogtOfVmNSJrcNj89WPkoQo2OCVrIWtETyKAeFeQcWkr9g3xyyTSwnP0YjhMbU/hmLhtCGvp1jguT6kF8aapIovGbxUFoEM8z8bwN3qFtAsoRz3G3z7DVNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=pXhW7HHs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-200aa78d35aso31437495ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 17:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723595289; x=1724200089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4be7udvz9R9rydsaMSDozSuZk0sYO5yu7qJyyDml2NU=;
        b=pXhW7HHs5tFz/oyoOmjKY/6txWsoOxZUkWCmJixYSD4ese+vk7TCCUOr4ew5TvXNb4
         AHZgUH056rEW9CiR4gcSYFk4SXCWAnAPoOVWGnwVIO7Viymlr66+3rj7ecTCBGGUvEKM
         3s3ARxv8EEPAn3c/9xUOjdhuTpVyvGvKvyEKAZP4w/5rRPAGM+wIvkxGrKvw8l2nmizy
         iNAmfkdkykyq/SsVUqDrwDYziHDeVOxdfC7eN5bpf17Ws+wdvRQQMjEcqB7NczVG+u8k
         Uj9CUKT/QwNED+S1zLVI7VRImvPOoI6qYk3NSJOH/1j5YMg7o6dgT2UQlw6fmz8G5wox
         4/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723595289; x=1724200089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4be7udvz9R9rydsaMSDozSuZk0sYO5yu7qJyyDml2NU=;
        b=upld+nxM5dHtn7pj7q0TzERU2u9NsmPZ/vxI1hVgLBgFSb1/mrVyU/iALTt4ZOt7n2
         ohC8Fio/FEOLeifb4iN1WsXrx5Vw0/DSoBB4uPTYTqlqWtUl+Dul0XI9W0DZ+S/UeqbT
         AKiRfFmwPyVW5I8/mIIWL0EAbFZ7CAjHWWA41MyXD/moH0rHQLUsOdOmvhC926VidOxf
         8Nx5xlS6cPmP7i5y+y+L+D0T12ahhAMTi5c8duFCdZC+9ECe1HT+P58qXPouI07pkvuH
         4DhX/DvPIRWsozDKHEKFAnR1N56K5VVOCXcxRRp0d0YAkg55Nfy6HrWSoqoGl4M1srcb
         6DlA==
X-Forwarded-Encrypted: i=1; AJvYcCVqP4sg49BYc0c0uHKZ3zDcd/HG0adVanc6IjL4mAlobbPVdO35YNJLl9JLG3iJ64eHlYz9VtMs5CuF8hcAaninjxyGINtMJJxf5nTRUw==
X-Gm-Message-State: AOJu0YzodLT+w37n4TCq8QRo/JZgp1nEJl3m0eY6Jti4VCqL8KclQQaJ
	h8sriQVdv5+d6Mwue8rVkZgwSRoMCYQG2S6+yS6flYsTXFdG0DB4x2rS9WOnvd0=
X-Google-Smtp-Source: AGHT+IH2RpvA6yqK5DHVPHFaL19vHW061hRoHggconhnsf2N1F+CHfcBeuIKIlaZb9+7z3wGoubZHA==
X-Received: by 2002:a17:903:3607:b0:1fb:8f72:d5ea with SMTP id d9443c01a7336-201d64a5b20mr15553525ad.50.1723595289074;
        Tue, 13 Aug 2024 17:28:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1e583esm19080015ad.302.2024.08.13.17.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 17:28:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1se1ry-00GChE-0X;
	Wed, 14 Aug 2024 10:28:06 +1000
Date: Wed, 14 Aug 2024 10:28:06 +1000
From: Dave Chinner <david@fromorbit.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <Zrv6Fts73FECScyd@dread.disaster.area>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812090525.80299-2-laoar.shao@gmail.com>

On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af905bfc
> ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To complement
> this, let's add two helper functions, memalloc_nowait_{save,restore}, which
> will be useful in scenarios where we want to avoid waiting for memory
> reclamation.

Readahead already uses this context:

static inline gfp_t readahead_gfp_mask(struct address_space *x)
{
        return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN;
}

and __GFP_NORETRY means minimal direct reclaim should be performed.
Most filesystems already have GFP_NOFS context from
mapping_gfp_mask(), so how much difference does completely avoiding
direct reclaim actually make under memory pressure?

i.e. doing some direct reclaim without blocking when under memory
pressure might actually give better performance than skipping direct
reclaim and aborting readahead altogether....

This really, really needs some numbers (both throughput and IO
latency histograms) to go with it because we have no evidence either
way to determine what is the best approach here.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

