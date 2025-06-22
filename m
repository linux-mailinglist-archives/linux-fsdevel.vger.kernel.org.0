Return-Path: <linux-fsdevel+bounces-52403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951EBAE316C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 20:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB46316EA67
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D461F9413;
	Sun, 22 Jun 2025 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XHPUHLQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138914A62B;
	Sun, 22 Jun 2025 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750617805; cv=none; b=cPnaxWuVGxyhxNtoBRMEI7b/Qzle8Wk9FbbZyJ4uDqGwzY4DzPDcS3WjwgUeWnl4f0251+fZnD7LNJ8F+x+DPPNObDJEM8a4dLhdW6xPjCPM/erGlPUy6TIkbkAOKqOsFtIqqqAwVHKOn9RGRc9M+3P77I+TZxvH7vkMjMQIThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750617805; c=relaxed/simple;
	bh=3H2wKWU2193WXNtIUhATRt/ZTw4+1SQggiDA+AaWVjI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E7XzzzCdO5K5VAiFzqIUfNADvLUyxudW5lLWnY43METlr6gfWwixpas0NiStI/tLQf5+F5Jc5lJwD42yqiBNJI9NwrZUMtoDwr5CwGm5O5jXALS2Oiny9gNjwlf7CVb2ndja652Ymmj2lMU61L7JDAv1+QVP8BkeybN3rO9Mumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XHPUHLQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D189C4CEE3;
	Sun, 22 Jun 2025 18:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750617805;
	bh=3H2wKWU2193WXNtIUhATRt/ZTw4+1SQggiDA+AaWVjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XHPUHLQglzrHpK2ZS8imdC6/smERAODfvRVpH2JeWdzBL/q/n5IqHb2TQkI29zi1K
	 6oTx1a73gchf1/xMbFySG6/bhXW+GAtxWzT92/UQIr9+80WcSclzzzznwEJHOhgdE7
	 /RQmsUSfX9zDx/b250gr43W8i8T4klKuUDPcoL2k=
Date: Sun, 22 Jun 2025 11:43:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Shivank Garg <shivankg@amd.com>, seanjc@google.com, david@redhat.com,
 vbabka@suse.cz, shuah@kernel.org, pbonzini@redhat.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, ackerleytng@google.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com,
 tabba@google.com, vannapurve@google.com, chao.gao@intel.com,
 bharata@amd.com, nikunj@amd.com, michael.day@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, rppt@kernel.org, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 kent.overstreet@linux.dev, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, chao.p.peng@intel.com, amit@infradead.org,
 ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
 gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, aneeshkumar.kizhakeveetil@arm.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
Subject: Re: [PATCH 2/2] filemap: Add __filemap_get_folio_mpol()
Message-Id: <20250622114322.c6c35800e01e4cc4007a0f89@linux-foundation.org>
In-Reply-To: <aFWR-2WAQ283SZvg@casper.infradead.org>
References: <20250618112935.7629-4-shivankg@amd.com>
	<20250620143502.3055777-2-willy@infradead.org>
	<aFWR-2WAQ283SZvg@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 17:53:15 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Jun 20, 2025 at 03:34:47PM +0100, Matthew Wilcox (Oracle) wrote:
> > +struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
> > +		pgoff_t index, fgf_t fgp_flags, gfp_t gfp,
> > +		struct mempolicy *policy)
> >  {
> >  	struct folio *folio;
> >  
> > @@ -1982,7 +1984,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> >  			err = -ENOMEM;
> >  			if (order > min_order)
> >  				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> > -			folio = filemap_alloc_folio(alloc_gfp, order, NULL);
> > +			folio = filemap_alloc_folio(alloc_gfp, order, policy);
> >  			if (!folio)
> >  				continue;
> 
> This is missing the EXPORT_SYMBOL_GPL() change

I added this:

--- a/mm/filemap.c~filemap-add-__filemap_get_folio_mpol-fix
+++ a/mm/filemap.c
@@ -2032,7 +2032,7 @@ no_page:
 		folio_clear_dropbehind(folio);
 	return folio;
 }
-EXPORT_SYMBOL(__filemap_get_folio);
+EXPORT_SYMBOL(__filemap_get_folio_mpol);
 
 static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 		xa_mark_t mark)
_


