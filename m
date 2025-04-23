Return-Path: <linux-fsdevel+bounces-47015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD65BA97C75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 03:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0790616992F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 01:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFBC1EFFBE;
	Wed, 23 Apr 2025 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eNXJyIDN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47C263F5F
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372874; cv=none; b=S5fp8yKFB87tXfxUXmaRVSpeAzf4S3OMQA4JlfAftXLyGZFfxQ3cPaZ3iMj6lzBE0lQDBW4LloH/LeBHt5oJN5b5YwGHaT03HlK90w6Il9TwP8ZLKcKLV7eO8c1waW69sD1Tpl6imrB69yZSmO/RDMfV1gBcgvIC3zOglhDROmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372874; c=relaxed/simple;
	bh=bKzPe+YnsOjghNA8tClzbffiB7Du6jjlnILdZfmhLeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJSKK8uGEEw/+llCDufamp/npXtW6GrhwvU2cRPxDS6zI/qs0NA4kIC7TNclqx+3cW32BwzqVf3Zpw1GqSAr3kCFA1M3F+16XCfafGSfHYSdx4D31YbkF0jyAx5la1neMyd6AgmzHmAEyhgVza9bw2bI4YajYucIqmA0goQhwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eNXJyIDN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ixXzq8+5TfvN7F+ux1yI6+sVOid8sZuHH4LjcLJXpD0=; b=eNXJyIDNtOHOuDmyCJa/qxs1wL
	gCVEqZlmqoXjhi3VQqwK7MxqBFr3hvzkGmUgyOD8hMchViTXJUDe5nYxEVmaw1M7NS4zArjE7Wlys
	Rb8Nmr8FAAEm6Blxri6GaIBQ9cLj85vXn93b+5CLjAi3LBKQn4haVtRskyoDYwrUOK9yTTWK8s7EC
	4dN9j+G6QKh/rNL469Utn3ermbfqtR/GwRKCmBrDqmMBkUrMXSRdvfz7PVGGzHrq8JMsytOKuRDWD
	K+gs6MeVrXoV7bN6xFRwv1Xis7+BiivWzyM9EZzgHrzThNLCFyVHiCiVx3YaAUaq39e/teudPXlS2
	Vt7cHJGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7PD2-00000008Ezu-0KLX;
	Wed, 23 Apr 2025 01:47:32 +0000
Date: Wed, 23 Apr 2025 02:47:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dave Chinner <david@fromorbit.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Tobin C. Harding" <tobin@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Michal Hocko <mhocko@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [DISCUSSION] Revisiting Slab Movable Objects
Message-ID: <20250423014732.GC2023217@ZenIV>
References: <aAZMe21Ic2sDIAtY@harry>
 <aAa-gCSHDFcNS3HS@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAa-gCSHDFcNS3HS@dread.disaster.area>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 22, 2025 at 07:54:08AM +1000, Dave Chinner wrote:

> I don't have a solution for the dentry cache reference issues - the
> dentry cache maintains the working set of files, so anything that
> randomly shoots down unused dentries for compaction is likely to
> have negative performance implications for dentry cache intensive
> workloads.

Just to restate the obvious: _relocation_ of dentries is hopeless for
many, many reasons - starting with "hash of dentry depends upon
the address of its parent dentry".  Freeing anything with zero refcount...
sure, no problem - assuming that you are holding rcu_read_lock(),
	if (READ_ONCE(dentry->d_count) == 0) {
		spin_lock(&dentry->d_lock);
		if (dentry->d_count == 0)
			to_shrink_list(dentry, list);
		spin_unlock(&dentry->d_lock);
	}
followed by rcu_read_unlock() and shrink_dentry_list(&list) once you
are done collecting the candidates.  If you want to wait for them to
actually freed, synchronize_rcu() after rcu_read_unlock() (freeing is
RCU-delayed).

Performance implications are separate story - it really depends upon
a lot of details.  But simple "I want all unused dentries in this
page kicked out" is doable.  And in-use dentries are no-go, no matter
what.

