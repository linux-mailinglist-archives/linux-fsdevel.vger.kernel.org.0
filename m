Return-Path: <linux-fsdevel+bounces-15349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B6088C63B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 16:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D8D1F3183A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387D13C800;
	Tue, 26 Mar 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="EkT1s0A3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222D312D76F;
	Tue, 26 Mar 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465464; cv=none; b=hfqiaZA2DrpZhYUdmA39KNK7QY24TEm3AFvkVEdjCsCA26c7svsup/fDdrNDXeE4a5GVf6eZYu/0NQdmW7h89yobuOuOWVCDu1S11afsSkrroOhWxe4E3TNLvaWbTn13DD4T2IOw387frKjSi3G46pkJrQrAjc1aRAI1jobfQIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465464; c=relaxed/simple;
	bh=QwHGxohidfEE89ntqE7k8WK7rV4jGKj9cyEcRAHVK+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMTiRTscQoAK+iqwjAXe0mHwKqHPbL1WAa1GSIdLBGxcgMfvKWJtw6ueSHaWLahSc8oyhp9rWQnYyFheaVw5bWxBUwY/AyxYurNf7cjwUgXNTx/8r06oL3fy8h/rBD8SvxXjjPtbA8dXyUhpeQ0Qt0v5L4k8Ubb5ncCo1UKXN+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=EkT1s0A3; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V3t9t6lNtz9sJ6;
	Tue, 26 Mar 2024 15:54:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711464867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9Q/eCZ6v2bw9iLxiFT4xLPFqiE1zWXHKWDB+B3WRm4=;
	b=EkT1s0A3EaBOYWBwVSwGLfqiEHDG+uZDtGtzy/KDIs8RhV5bdRzJ6KwIxFsimklA3dYay8
	Fx26NMvyL6DDn/96RqgcluBtZTuDsuRa8L5V4NkAwvogES+w/a2iw6Er9bDSGcDvYqMlje
	Xzsh0Maj3QqdmaxBE5E04YMK0Gk5ToMq/xkZnjeVSZdWnfkR9+fSs+3tRiy5a8kOJnFWcW
	wj23r9krEvDL3Jm+zgyUsn1VQ/sAAdLkkBCT8wwUj/le62LJXWnl0Jc6g5xnN1039BO+Fq
	CpMEW6liJzT26NyWLn2fQPVBhJy7Fu0BwEfDUzYiFlcZD1llT5VvoC4qbL6ePw==
Date: Tue, 26 Mar 2024 15:54:22 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de, mcgrof@kernel.org, 
	djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	david@fromorbit.com, akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 00/11] enable bs > ps in XFS
Message-ID: <vyw2u4kmij7ddzfj5xfacc5lgmpbvxif3ennxp7oselxt4agfj@kuli2o7nrzin>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <ZgHOK9T2K9HKkju1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHOK9T2K9HKkju1@casper.infradead.org>
X-Rspamd-Queue-Id: 4V3t9t6lNtz9sJ6

On Mon, Mar 25, 2024 at 07:19:07PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 13, 2024 at 06:02:42PM +0100, Pankaj Raghav (Samsung) wrote:
> > This is the third version of the series that enables block size > page size
> > (Large Block Size) in XFS. The context and motivation can be seen in cover
> > letter of the RFC v1[1]. We also recorded a talk about this effort at LPC [3],
> > if someone would like more context on this effort.
> 
> Thank you.  This is a lot better.

Thanks.
> 
> I'm still trying to understand your opinion on the contents of the
> file_ra_state.  Is it supposed to be properly aligned at all times, or
> do we work with it in the terms of "desired number of pages" and then
> force it to conform to the minimum-block-size reality right at the end?

The intention of the patches is to do the latter. Apart from the patch
that rounds up file_ra_state->ra_pages, I don't poke file_ra_state
anywhere and it is updated only at the end after we enforce
minimum-block-size constraint (page_cache_ra_order).

> Because you seem to be doing both at various points.
Could you elaborate more on where I do both? Maybe I am missing
something and I could change it in the next series.

The previous series was trying to do both but I intentially stuck to
updating the ra_state at the end in this series.

