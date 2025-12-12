Return-Path: <linux-fsdevel+bounces-71180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DC7CB7E59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 06:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21E4F300A24F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 05:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275212DECBF;
	Fri, 12 Dec 2025 05:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Jn/oyTQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B112940B;
	Fri, 12 Dec 2025 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765515722; cv=none; b=kfDnIo6OGFp139T6bYfIPca4h7YUn9GX4EhRjdsFt8koghFXxgbZh2eBQ5SbHivXg/ExF8M1lWV7wBVI8nFjb76LFOmxEo43anBZGaiFeznwQ/f5fv1An6GjBdhvcOZjGlDtWMT4lv7lDQAC4dZoWAEs1ubm/ooa3Ki64eV1uic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765515722; c=relaxed/simple;
	bh=Ns5krDTOXGE5aDCGbfArwMhCmJNXV3YtNOUiNJsrRII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quVGOiI5lTy8es6/tAyrsTVAtWLv0pdZgHBhbr/+VV9pco30RvNFL8Jd9JhcqgsZZxRNC1+xlKFgdsSqEg/QIleDF0W5IxNL6rQemo5lr5o9k0i5wnFEawI6/ELq5dzuV3H+OOLDyrUpTCU9r92Kd21lRyd7GiKUJJpXPnTwV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Jn/oyTQp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ovb8csmcXCyUzvPPL/s5rZjS0U6avn9QuytjWB/Yh1I=; b=Jn/oyTQpLShNLcDQ6f6TaTWNtC
	di/EaBklgDBoDZRfOlDcJ8byPFubhakbpoCES85WmuQDG9pNVloED+HpK5gtCijVFnuX8HXrtpIZU
	tEE4QEZXt+ESzboR1cvMVPJ+Zr8uP+91qOx6Wsq/bWeLHavMjALbdi80gtf3347MsQdlU+S1UgDnt
	EuzHQ4IM8Q7pUxz5hzv0smDZZ8HS5GFkMW4HN9b+NXFU/Prl1CmNVcCpg2SEL5lhn3O1MW+DwnBkI
	fW1C379ZPtXKdtcRQA7Iinu+5NrFwjDxcDShVPo2j7X73p1EB1HemuJVvwdjFN4BsoP9pPaerT7Fc
	l1VoO14Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vTvIP-0000000AkHR-47w8;
	Fri, 12 Dec 2025 05:02:26 +0000
Date: Fri, 12 Dec 2025 05:02:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Hugh Dickins <hughd@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: 6.19 tmpfs __d_lookup() lockup
Message-ID: <20251212050225.GD1712166@ZenIV>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 11, 2025 at 07:56:38PM -0800, Hugh Dickins wrote:

> Of course, 2313598222f9 ("convert ramfs and tmpfs") (of Feb 26 2024!)
> comes out as the first failing commit, no surprise there.
> 
> I did try inserting a BUG_ON(node == node->next) on line 2438 of
> fs/dcache.c, just after __d_lookup's hlist_bl_for_each_entry_rcu(),
> and that BUG was immediately hit (but, for all I know, perhaps that's
> an unreliable asserition, perhaps it's acceptable for a race to result
> in a momentary node == node->next there).

Hmm...  Could you check if we are somehow hitting d_in_lookup(dentry)
in d_make_persistent()?

