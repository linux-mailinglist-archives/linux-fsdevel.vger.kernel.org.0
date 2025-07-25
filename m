Return-Path: <linux-fsdevel+bounces-56039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C201DB12128
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 17:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF2A1CC5949
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADD62B9A4;
	Fri, 25 Jul 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JNJdONl4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F919F127;
	Fri, 25 Jul 2025 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458338; cv=none; b=cOtJF9ZyeEIMSI5G2ZfAKT02bs9aIUgpVoTsnzwGWFcIXkSiXQ+I4coQJL4rOxcCz8k0S/VkA+/fY38jDXjdMa3XbMxAARpXWZJXuhSTJKxuYTo/GSxwpB0VA0fwlAKLQAVu5e0M2Z8PEp/gaTA+dNROx9+v5DH7sOp4m+L3lA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458338; c=relaxed/simple;
	bh=m/TmRr29If4nePO7c2k3b0Tkfy5nlPGR1W2gOUTDsa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/vdCZAeqFiWI5/9i4xzWgKHwkLNimy+1UHOLUOWdR4Jdh/iOXgislFNdj7RphUWNDE+mFA0o6EuyJfU3tXcZsOgscYya35BWP/Zhbbx9Mv6R7iPyNW0FbNiNDE1qcZxEtAexummp6ESXUiqJ+ik4dM4p7n/S48P1aotWyNJ8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JNJdONl4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=otUuWz9mfPFiVZUJEvzXYbOISqnMQyxkucKTmIZSSLo=; b=JNJdONl40Ij0yVJfj0J4ihq/N4
	AzSztQ4QnTxRNAUTMSoHh5dty/pKn0QZ6qoGn6cZQM3OQkPMyMZVrteksH6V4F/xku+IBoEByqCqv
	33KHCTRYK9bZe5ntZPaXv9KU7iCQoqydAUArH8iSFL2ASF4Mo85lAxBbTQrkaQ1IqNLTdW6M15agS
	uGkMR3VcvfHSfrnnWQV7Xt6fYZf1LUjDLPPkfVlk0JnUxqKf7y/4wXJzME8awFABT/iafB/tYCqwa
	+WMpROtkcqXH6M8UoklSQyc4hUD9CH/Spp7BZE62oYDE8Lm46YquCuUJB8kX/wFIekXs6IWIvI2zE
	YnY9o5hQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufKbz-0000000E1ua-39Sk;
	Fri, 25 Jul 2025 15:45:32 +0000
Date: Fri, 25 Jul 2025 16:45:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Xiaole He <hexiaole1994@126.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/readahead: Optimize nr_to_read boundary check
Message-ID: <aIOmm8cejmAyvSZ5@casper.infradead.org>
References: <20250725152834.7602-1-hexiaole1994@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725152834.7602-1-hexiaole1994@126.com>

On Fri, Jul 25, 2025 at 11:28:34PM +0800, Xiaole He wrote:
> If nr_to_read is, for instance, 3, and end_index - index + 1 is also 3
> (meaning 3 pages remain), the condition 3 > 2 evaluates to true, leading
>  to nr_to_read being assigned 3 again. While compilers might optimize
> this trivial self-assignment, it introduces unnecessary logical overhead
>  and reduces code clarity.

But it makes the initial comparison more complex (by one operation) and
I bet you can't measure the difference anyway.  I'm not inclined to
tweak this.


