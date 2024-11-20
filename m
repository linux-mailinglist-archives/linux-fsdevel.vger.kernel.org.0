Return-Path: <linux-fsdevel+bounces-35259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07A09D330F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 06:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED9C1F23D81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 05:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFEE156F2B;
	Wed, 20 Nov 2024 05:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gg273l5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A69804;
	Wed, 20 Nov 2024 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732078898; cv=none; b=rqDTTz9nGfEO0/3UoY+O+e46J/8KOcPoIi2UwEjiWEzRJAoNsbTSO874txVYo+VjZIfREiAzkJvjWWQea2jmbCXH/xixfrW+piT2dxDug/4SMFAYexZwNCn66BSQXXEU83MRcHMTUhtyKpHAt6H8ZpuzlCakFGjRa29j1+uZAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732078898; c=relaxed/simple;
	bh=xT8k5xcfL3/HJYOd2Smwc0mAgxtmn3o5xjnnxvcfAbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuP065lejZnnK25g3pXnJYoemJXx9pCoy647cnWhj+ap2TPTK0Gz7g5di59UeG7ufUe2HCIeBL084/Wkq6xss6/JcMwBx6UipTgFkWUE77MOg3cYSZwDHBp+zMpVr5gTcuYxBEzovXPbVQhaCFOqU7Wj2kTd9Kx1tUucjym93HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gg273l5z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uOV8nZu7BBFpdSK2SDuWNMcSh3DZHFqV7lmIQbSxDvk=; b=Gg273l5zeNHu8yBSAfqSVGLvY5
	ZzFKKctS3gzim6Xlcej4C3U/ggLgd0BSZQi7wgBhWGnKw8IRY8yEh/emFas6c4+vc6gTEj0fDcfjW
	Q+dUpe2BnNG6NCrc9fj/NapIlYGrnqa4fh5KrlJdnr4TxDWbGK+CMuCyItsGFR59R02mJ2b24eObg
	w5MybKFrGqtYzn39nL1emiHUofwY+sw5/4bhP2qGeFLxddNQJ9AvYsLmo7pZaKGsK3lkQoe+IEtxj
	U9iCazBzR2TvyNiFlpU2RTg6V6V8ZBRJyg8JRhwK67UNYZQjGD9AuLLjmrvM5kIM68Nl2ruY6sh7A
	GvQFAL/g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDcqJ-00000004rzE-44nO;
	Wed, 20 Nov 2024 05:01:32 +0000
Date: Wed, 20 Nov 2024 05:01:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "wangjianjian (C)" <wangjianjian3@huawei.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hughd@google.com,
	linux-ext4@vger.kernel.org, tytso@mit.edu, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] vfs: support caching symlink lengths in inodes
Message-ID: <Zz1tK-rMV5uYyco6@casper.infradead.org>
References: <20241119094555.660666-1-mjguzik@gmail.com>
 <20241119094555.660666-2-mjguzik@gmail.com>
 <f7cc4ce1-9c20-4a5b-8a66-69b1f00a7776@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7cc4ce1-9c20-4a5b-8a66-69b1f00a7776@huawei.com>

On Wed, Nov 20, 2024 at 12:15:18PM +0800, wangjianjian (C) wrote:
> > +{
> > +	inode->i_link = link;
> > +	inode->i_linklen = linklen;
> Just curious, is this linklen equal to inode size? if it is, why don't use
> it?

Maybe you should read v1 of the patch series where Jan explained where
that's not true.

