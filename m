Return-Path: <linux-fsdevel+bounces-28227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF83B9683C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8F72832DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585E51D2F55;
	Mon,  2 Sep 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CkNLDlH4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D515C15E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270849; cv=none; b=a1gp2S8E7Wp/1DS0LWb48kZRnELlVgFkdG3p+fvIxQf9u1OIP6+shZXvDqw6aXhgEirTGLrW/bshHJaHO5Ncblp0ZO2TTv53uNNWtmT8Ea2VM5lFcKHtNS7zthUfhKSPZNOtOvbOO6uRmIQM8f8HGy7bp1+MLTckNUnH1q4JGiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270849; c=relaxed/simple;
	bh=YMsp0Axv/uxUn1zoXPlqC4e4Ujl4vyVqm4CoVEcJJh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU0AZhJujcP1mvUxgknkk5uR3zpD1MCc4GWSRDfFzw3qB0TX+ltu0BPRrBvBlIQ12s6y+oaW0o2oJPwSdRV0yUo09iXiTgbGMPNyL/DWSknDidilMhyx5H6aqAlaVESaP0klFAZP4Rn6TfRe1ipswp5Uneoj9f8ePluVFPc4u18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CkNLDlH4; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Sep 2024 05:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725270845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9/nHM/VVP4A0TXNpwjoUe9SG01QPiNcoM3DvPaMwq+A=;
	b=CkNLDlH4YmUt7qngTBEDKimfB5JnCJrNXlLgkCcW0RzLdZQ+5s0GAqAwtbBp6P4Lg4C2JM
	+8wmwvdryLnMgmCqryPH+iAjeoKRxbv/Y8WKwKq5qyZRWLuw9i3Sv/WH2E1zUsIy7pH5z5
	4KggrwyIykguR/mvUoaLICLzI5vrDlg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Vlastimil Babka <vbabka@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
References: <20240902095203.1559361-1-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902095203.1559361-1-mhocko@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 02, 2024 at 11:51:48AM GMT, Michal Hocko wrote:
> The previous version has been posted in [1]. Based on the review feedback
> I have sent v2 of patches in the same threat but it seems that the
> review has mostly settled on these patches. There is still an open
> discussion on whether having a NORECLAIM allocator semantic (compare to
> atomic) is worthwhile or how to deal with broken GFP_NOFAIL users but
> those are not really relevant to this particular patchset as it 1)
> doesn't aim to implement either of the two and 2) it aims at spreading
> PF_MEMALLOC_NORECLAIM use while it doesn't have a properly defined
> semantic now that it is not widely used and much harder to fix.
> 
> I have collected Reviewed-bys and reposting here. These patches are
> touching bcachefs, VFS and core MM so I am not sure which tree to merge
> this through but I guess going through Andrew makes the most sense.
> 
> Changes since v1;
> - compile fixes
> - rather than dropping PF_MEMALLOC_NORECLAIM alone reverted eab0af905bfc
>   ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN") suggested
>   by Matthew.

To reiterate:

This is a trainwreck of bad ideas. Nack.

