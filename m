Return-Path: <linux-fsdevel+bounces-52593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55EBAE46E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94A8447C37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3017F230996;
	Mon, 23 Jun 2025 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/7kBapV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402357260C;
	Mon, 23 Jun 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688584; cv=none; b=aXrDgpysxpq4gQd4cBq/oaWqUbV+N1ta2AIew0aI3o9zKeD3X9EGIXMADpRbku3PfuhNDl13z0RZYG+Qf+7nojpqy5+ot53vnkb2MrObPVdTgQ3q5s7pZPJZdVAFKA3APTLwc/Ikog8+vFSNrYPX4ADrrKu+3P0aVWFStG7ygag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688584; c=relaxed/simple;
	bh=OeRLWoRyEy++iJRkY3vkId3+Dw5vrAz0YkWZvBU00C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COnHn60GjArrw45JIr1zqXlzK7y/T1wpB3S9sgo1vwj184tUsY9AVglhsx99qGGhlmd70YpMuZ+dJyjclder3PY/VWPU6eNSttQh8bH8UuVTEm/QauBej9hmcwzEDlqP+UWKYfV/c2gLYGB9wJUaWeKeYqhQBDsdI9q53keLdxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I/7kBapV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ounh5g8nmQna3ynAqQoYNAJIx8BI+xFyYBBxhBPvMuE=; b=I/7kBapVVQnuoXY3Ck7sT4+W1R
	2kO2gM+Hk1gbBN1KdkyaodQn7pBQNlPPU6Z/7CpxrBJNHCUiu4+AmAqVozrCp9z6ySxptXcFcjElt
	Rzy4wTJcDfLMvVPRAwUKZyriRBtMplSrgZqhTUDi7AZVM3jVm0AkbJGWVYbY1XHRd71HUHJkCBibG
	8FIHHant993zYDUge1ZA2ddOTImOYpMnu46nUVsxhjpgDFPTqKQoXsg2hE0awdd80TnpL8cJeQuyJ
	m/nIlUBF7lwDFEDASHciX0mCgXxQzn3w/vgxll/zr9CdeF1ajfgOl6fM0b60OLSLrLlhQoZgCOr/k
	P2uMarCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTi4X-0000000324c-2UWR;
	Mon, 23 Jun 2025 14:22:57 +0000
Date: Mon, 23 Jun 2025 07:22:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Mike Rapoport <rppt@kernel.org>, Shivank Garg <shivankg@amd.com>,
	david@redhat.com, akpm@linux-foundation.org, paul@paul-moore.com,
	viro@zeniv.linux.org.uk, willy@infradead.org, pbonzini@redhat.com,
	tabba@google.com, afranji@google.com, ackerleytng@google.com,
	jack@suse.cz, cgzones@googlemail.com, ira.weiny@intel.com,
	roypat@amazon.co.uk, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Message-ID: <aFljQTbXXXHG1E6f@infradead.org>
References: <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
 <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
 <aFQATWEX2h4LaQZb@kernel.org>
 <aFV3-sYCxyVIkdy6@google.com>
 <20250623-warmwasser-giftig-ff656fce89ad@brauner>
 <aFleB1PztbWy3GZM@infradead.org>
 <aFleJN_fE-RbSoFD@infradead.org>
 <c0cc4faf-42eb-4c2f-8d25-a2441a36c41b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0cc4faf-42eb-4c2f-8d25-a2441a36c41b@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 23, 2025 at 04:21:15PM +0200, Vlastimil Babka wrote:
> On 6/23/25 16:01, Christoph Hellwig wrote:
> > On Mon, Jun 23, 2025 at 07:00:39AM -0700, Christoph Hellwig wrote:
> >> On Mon, Jun 23, 2025 at 12:16:27PM +0200, Christian Brauner wrote:
> >> > I'm more than happy to switch a bunch of our exports so that we only
> >> > allow them for specific modules. But for that we also need
> >> > EXPOR_SYMBOL_FOR_MODULES() so we can switch our non-gpl versions.
> >> 
> >> Huh?  Any export for a specific in-tree module (or set thereof) is
> >> by definition internals and an _GPL export if perfectly fine and
> >> expected.
> 
> Peterz tells me EXPORT_SYMBOL_GPL_FOR_MODULES() is not limited to in-tree
> modules, so external module with GPL and matching name can import.

Sure, technically they can.  But that's not the intent of the export,
but rather abusing it.


