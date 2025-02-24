Return-Path: <linux-fsdevel+bounces-42414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D857A422F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E044C3ACE78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE714A62A;
	Mon, 24 Feb 2025 14:17:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A813959D;
	Mon, 24 Feb 2025 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406672; cv=none; b=W3WbKAvuTjUMA4zqB8NGI3Rd+x/hyS6ZKBLnQIwJf57mUNXWUz/I1OlfvkA6Yyk1xuV++zudT8i48oi1X/jUHBLSFv4qFkFW2kuZWzQsssl5IiJ9fwBNfl90KD4t3Ge+GETX14j9MOJAlvjaSbqmoNeTTy3qQlZyPvxQ1VCMgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406672; c=relaxed/simple;
	bh=VUnXjcEVKg54jcNExXjdThFrgKpM4b7BCxh6UYBN8go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5zke6GVspFgGugMgYvHoJ4a+Y0ciDKJvPOK4p2Au82cWAozVo/gbYSwrlYVrK/HWIeGjui+jVcY7hHujRSlXKbnyyFcVKmFpjt1XvvAHM5Aw03gHqDOBTvIGCxm8v8/7/TtxnKJHWG4DXb68Y8QV3xHONo/lC0nYaeodui1yY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07F8968B05; Mon, 24 Feb 2025 15:17:45 +0100 (CET)
Date: Mon, 24 Feb 2025 15:17:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, Dave Chinner <david@fromorbit.com>, hch@lst.de,
	willy@infradead.org
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio()
 with FGP_NOWAIT
Message-ID: <20250224141744.GA1088@lst.de>
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224081328.18090-1-raphaelsc@scylladb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 24, 2025 at 05:13:28AM -0300, Raphael S. Carvalho wrote:
> +		if (err) {
> +			/* Prevents -ENOMEM from escaping to user space with FGP_NOWAIT */
> +			if ((fgp_flags & FGP_NOWAIT) && err == -ENOMEM)
> +				err = -EAGAIN;
>  			return ERR_PTR(err);

I don't think the comment is all that useful.  It's also overly long.

I'd suggest this instead:

			/*
			 * When NOWAIT I/O fails to allocate folios this could
			 * be due to a nonblocking memory allocation and not
			 * because the system actually is out of memory.
			 * Return -EAGAIN so that there caller retries in a
			 * blocking fashion instead of propagating -ENOMEM
			 * to the application.
			 */


