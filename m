Return-Path: <linux-fsdevel+bounces-27181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFFF95F367
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6274C1C21AC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 13:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091818891F;
	Mon, 26 Aug 2024 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PhIk7oZX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD324FC08;
	Mon, 26 Aug 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680778; cv=none; b=jkAet009fAvJen2vGsjGl5vn1bFhREDkU277Uk6Cyr0MJeURcCX2LIF9vpcDyPb2SQ01Xy1fIkCEmUTQsqwTp0Sf4rQZCkC5zggKxhLSWZYJvqZnpaFo21Huml5pOGZHuv+lQftWsSF+BxmkDBVLmqyeIi5d8pswnu+ejsw7R6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680778; c=relaxed/simple;
	bh=BzciMDPrePqw/+Zb31TamDL7Qy6qsvVfbhnenMPs13g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLyNh5gXP4I4bIrMbsrbju+qtxzwQKNWbLKgPxn143JZHblUQdgJCBAo25qjFRzTJIu/pWi0gPz6B3UO84tSRpZ3za2eM+TSnbjjgcCt0fxc3ilsYMqXQM35416PHZ3CN1h3U+4Z5/MEugf7Vct/Djjk03evy4DG90hEBdNvMM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PhIk7oZX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d9ixmwiMI0t+BMY931VrpBckLQD4BASs08boObwsOs0=; b=PhIk7oZXa/Gkm39cnR6HKbAqgT
	CGgPgHcTlZl+DUS9UqdVVhPpauTPgAIuqtWaw0JHHCxL0FXfttu1cao91QOvhMt67LRmAp2NEkOx2
	cxJh6nBHw1GlAcGiHLnhR0Hwd3yY4ILNspDZt0Db4Cs2BK2LnpJEoPMPnG5hgpUv4HWyudQsNtvAl
	rfW3hzI1sNJNXWmMA6mnx2bfeUGWrz1IXyyl7OnK9sV6a4P3/kgKIeW7VsmwKyyUROeKzzJu17e2m
	V6cJUt9lKMMgSEge6FqTwRlGm0Vcc2IV3xvfVgfte3cUSCKC3AX/IQmoy+XmM6zR8nSNCytePcQWC
	fITMZ/2A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siaFl-0000000FSeG-26RN;
	Mon, 26 Aug 2024 13:59:29 +0000
Date: Mon, 26 Aug 2024 14:59:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] mm: drop PF_MEMALLOC_NORECLAIM
Message-ID: <ZsyKQSesqc5rDFmg@casper.infradead.org>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-3-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826085347.1152675-3-mhocko@kernel.org>

On Mon, Aug 26, 2024 at 10:47:13AM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> There is no existing user of the flag and the flag is dangerous because
> a nested allocation context can use GFP_NOFAIL which could cause
> unexpected failure. Such a code would be hard to maintain because it
> could be deeper in the call chain.
> 
> PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
> that such a allocation contex is inherently unsafe if the context
> doesn't fully control all allocations called from this context.

Wouldn't a straight-up revert of eab0af905bfc be cleaner?  Or is there
a reason to keep PF_MEMALLOC_NOWARN?

