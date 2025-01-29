Return-Path: <linux-fsdevel+bounces-40269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF37A215A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 01:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F0D7A337C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 00:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC817A597;
	Wed, 29 Jan 2025 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tMhCvKNP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832091552F5;
	Wed, 29 Jan 2025 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110496; cv=none; b=JAGy0hbyKSWLB9hKSCp3xr9e8uxQIUtD6QN3LN0pL3jE+Wy7uWUancYhCSgHjyHZHsG+x6Oq52FViKNfB8XwMmmlwrl36Z0XTDtimSVlY906PuQSlR/gF4juZJkWslzuNsH3FlfUyKNvuS6ZiuBdTS/cZRx+Bm/21gKFjGf+wfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110496; c=relaxed/simple;
	bh=Qm2+qJTpHPYb80YKBOC3tAU+DARm1p4YqSrcqX9vmp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqzgwkKugkOi10eo7/07zKCJ9yhbNZORvEVpUP98eboYhb74u8CPG/isme4fANvTUPPbtO/niPP+u2x8HsKvb+MQ8OQmQ10txWTWfVOhlSwuSg6/XbP8PdN0af8DE2npihL+dt6HfltHe02q8MvqukvCDVJji701blfX7xuAWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tMhCvKNP; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Jan 2025 16:28:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738110489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9/F2XOZC3O9/NYFAagIt/ZhG8X92VvaqSFdV5agA+GQ=;
	b=tMhCvKNPAtP7s/rAQ1DLmokwbbt2xzs0VJ7r7mCqaPNLncF/80Sqv4VPhCE8aMn7/HGcGs
	2oUzSb4r0Qy432/Yu9ze0uM6FOTIKulQEl6lWDteum1mIIqaoFc/GssdDB4xM+sbO9KCHT
	Jjt+DY9mPk9R9NOsr11Jwej/RsXy/G4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, 
	peterz@infradead.org, mingo@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rppt@kernel.org, liam.howlett@oracle.com, surenb@google.com, 
	kees@kernel.org, jannh@google.com
Subject: Re: [PATCH] docs,procfs: document /proc/PID/* access permission
 checks
Message-ID: <obqnuxousf64hdkaatumcxsqcrinr5scuufepazhzfz6waapnm@nze4eag2wljd>
References: <20250129001747.759990-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129001747.759990-1-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 28, 2025 at 04:17:47PM -0800, Andrii Nakryiko wrote:
> Add a paragraph explaining what sort of capabilities a process would
> need to read procfs data for some other process. Also mention that
> reading data for its own process doesn't require any extra permissions.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

