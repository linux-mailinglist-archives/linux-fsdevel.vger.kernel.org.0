Return-Path: <linux-fsdevel+bounces-40897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88528A2838B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 06:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07453A6221
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 05:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC621D591;
	Wed,  5 Feb 2025 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z8H07EbS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921D25A638
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738732448; cv=none; b=qPT9MWTJMtvEzW0HPKY5OZtJEzE5M9C/j2H6PcsqD4Wv1wEW6enqsVPFBaa9wXtIi/Ji6JPNWG4CsemzcApIcKSlPGuOSVMwbawOORPZ96M6UrQTRbJVRwad1Sd1X+GTNZqjj6azZoB4B6s6EQYqF4zp8q2BTW0wh/olfWsUKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738732448; c=relaxed/simple;
	bh=B10Qi1xSRpaM7cgn6N/SZnll7XG3DDdmbUJgRfjqRl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loDT9r8j2dW2Q0jYNcEDbalCuSnVwRtuE4ZQGIuIXcmLRbY02T7fWbNN+FqzMqEmsIWt2oZNxdZ38kGUZ5qbVySZo4z+EsrYViiU+8GhcjMoMjLhkzSJEqlF0yOu8SB4VQGPNySz0yq8qvzhvLyvWnDU6xIojdQerqzL7JrHdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z8H07EbS; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 4 Feb 2025 21:13:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738732438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=40LKlZdvHe2+/43VAKHA6Dt2qSIbaNKuRbj8soUYXSE=;
	b=Z8H07EbSqJ3ftrcxB7jB1+MRp3i8IzNmkVl+r7ckOwwzp3oeIUNFZn4zPHHiRN3GkLeJ++
	lAbN2j3gADYLhOLAEBDJ8QRaM1192KYc74JYQzh4H89lDfIT7360KIhZeeWa62NBTiwuQ3
	TlnI3YqwNEH2tboVLa+nBajT8rVTyCE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Sang <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 2/6] selftests/pidfd: add missing system header
 imcludes to pidfd tests
Message-ID: <m2yk6rpzd5nbcpgepqnavk4wzblnkvxk2smqoacghkl5esmjbx@girbz5mfxcd4>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <fab8843ea8664b5089f95ccfdcfd5bd7a5a6bb0b.1738268370.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fab8843ea8664b5089f95ccfdcfd5bd7a5a6bb0b.1738268370.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 08:40:27PM +0000, Lorenzo Stoakes wrote:
> The pidfd_fdinfo_test.c and pidfd_setns_test.c tests appear to be missing
> fundamental system header imports required to execute correctly. Add these.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

