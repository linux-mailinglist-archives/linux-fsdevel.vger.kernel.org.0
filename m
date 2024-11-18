Return-Path: <linux-fsdevel+bounces-35143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1571F9D19D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 21:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2073B22262
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7071F1E7676;
	Mon, 18 Nov 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EBei7hg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F713E8AE;
	Mon, 18 Nov 2024 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962697; cv=none; b=Z5ElKtxQHySxhfcTtVjzTLWEl9xmm6zYGXZQKjUMhAZXY1MAMbipevFtWMrZMso/ZDcswb9F+hX+DqGbWmLaXaJHSn43MydO1eC/moXSLP5MKpiUPeyMGPsVWrXoup4cluJPUfIdsFqYb7Ch4F5/XEIc3Labm9hKN000nh2qbTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962697; c=relaxed/simple;
	bh=hxr6X589nGkzN6isc/wO1nfdUP4sjSft0/ICAC7Lvkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWz05SQn5a4Jnxn/h13tVOUKZT4Bopbn18hwyoYDSGBlxD5aV39Avg4okQPBYOKsUgJ0xYdya5ddd53auZAhO5p+F1iK/GzuI+pR3InoTG+1u5mAoDE727Ze9AijVHXoWK7CPBVDJimjexKM7YWWbS0JqRZO1Z8WHbG721NYMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EBei7hg9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Jgjkxw4frr4EM5zhmh3R/CldBWmsGrdOdfJ7IL6ZAI=; b=EBei7hg9WWtBfJ85ufetVruukj
	onGrC3lUzzex4kMnVu+CSIWj7mfyZNp+cMTnmS+H/ZDMVclWpoE1u4feMWjWqSuz0Gtm7cKycOUAt
	zxPkWQ3DjYGbvyrh9rt8dZ8tqz7ZpoEmZ/JdyL/0QsJNCyiH1K1Z3J+LPr2v30NY70UW3VY7F2C5K
	8HDjn5YCRbxY2zGmc2wA/Kj9F/C6jwn9l9Nr7SpdvRKqMSltnQ+SaXu8Rac7RNyvNhyr3C1SDUr+P
	WoxtO50BEt5+ZbupPHLpXRmmt/s+a6s5VQtpeyBEMmVsuNw8RcSOQ7Leis6Ch1d4c0tzhOnHJfFM8
	pvWFqzRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tD8bz-00000003Kov-0P6q;
	Mon, 18 Nov 2024 20:44:43 +0000
Date: Mon, 18 Nov 2024 20:44:42 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com,
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, Liam.Howlett@oracle.com, vbabka@suse.cz,
	jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com,
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com,
	osalvador@suse.de, usama.anjum@collabora.com, andrii@kernel.org,
	ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com,
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Subject: Re: [RFCv1 1/6] mm: Make get_vma_name() function public
Message-ID: <ZzunOu4TcHcJIOht@casper.infradead.org>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-2-pasha.tatashin@soleen.com>
 <8871d4b3-0cd8-4499-afe6-38a9c3426527@lucifer.local>
 <CA+CK2bBqi7+RExARBq5m91kaxC+w+nLYnLf4wyM_MJjaxr2rAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBqi7+RExARBq5m91kaxC+w+nLYnLf4wyM_MJjaxr2rAw@mail.gmail.com>

On Mon, Nov 18, 2024 at 03:40:57PM -0500, Pasha Tatashin wrote:
> > You're putting something in an mm/ C-file and the header in fs.h? Eh?
> 
> This is done so we do not have to include struct path into vma.h. fs.h
> already has some vma functions like: vma_is_dax() and vma_is_fsdax().

Yes, but DAX is a monumental layering violation, not something to be
emulated.

