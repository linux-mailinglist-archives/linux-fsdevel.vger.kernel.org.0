Return-Path: <linux-fsdevel+bounces-66345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F13C1C935
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 18:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DF3622F26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7BF34BA33;
	Wed, 29 Oct 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="PuKPezly";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YDVmwxA5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ABE481DD;
	Wed, 29 Oct 2025 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757855; cv=none; b=G/A15CYhlWTzN+hVnpdBC2H9WAQmnonjS2n8gTK/nxzO+MEOPpfgeDvOHjlNO4s81nWp+oughGVbefNUEoPFBAHWTz+PzZfixFZnvZtjJOTZOOKR6d5k5sYvN6GyBsuM3rV3nSVz8UHEHAL4D+FlouSrbjU14wUp6bv4HFsn41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757855; c=relaxed/simple;
	bh=BJkfjQWAVBhXj+eVlG7sIDPUXrM4mtu11fTyqizrGYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPVrw4ue+UgqYXscCD37kmIMAfcnZYcAgkhagrzewzHjv7BUTjKQi9F7IHpg/yCwvq1Y+Hu7SZDZOa/WccVCSlFzDqtG7pZDNWYvTPNzOnNo5GrFPvAJdeeHe7sVd5VtF+GHZlBioeSvppEnLwmvcX8MpfQLo2/Pnvo4uDbVPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=PuKPezly; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YDVmwxA5; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id A0A32130037A;
	Wed, 29 Oct 2025 13:10:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 13:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761757850; x=
	1761765050; bh=60bBq5IIwMjb0a7pvkC94ERZqp+DD7+pnKJsuAq/LCw=; b=P
	uKPezlySAYOoFeK12sfyCSmkoWdrEnbnG0g5S2Coyv5LMdvXgvsDCmM44I8CSTSp
	9bFIK9UGItinH5OvGS9KsSllF5qYIFi3+aqk7R+HL2BHOwR+eRg5dS2IW64tj7Ou
	e3DH94kl5xQggG+Bl7kK9oqFcTTDmIPoMFGd+FtjorzURIBmALPKiICL+dg0HQJI
	3khE4DDAQjGrl3USb9bUaHRz7Y2gHOHORDB1PukkmeD0laF8n6kUr1nGDOQrc5yi
	GBYZteNjZs5dXC9p6CJAaxhZ5fL8Z3xNUDaBq1dHqUwCt4wgEzruOznaIthwFxDy
	I/dUsvhb96fneKpJasiBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761757850; x=1761765050; bh=60bBq5IIwMjb0a7pvkC94ERZqp+DD7+pnKJ
	suAq/LCw=; b=YDVmwxA5juNSdkfC6gTj5fXjErDO2LwaC/xFaMBOJtQhNKaUOtW
	sTT4HSUES4Nyi3qSdkJV4wMFr6PMK2MQbJqaylbA+jw0te64A8X7T321gnAr2hT/
	r/kD1ZcVN0LHIA4u+ZB+ytk+kPgi4r954pS4pxYvCjMn5YBqwr8fIW4IyYRet2A9
	Xc+XjcumRU9wvw4/S8rGmeWWjXrNTLL5OGkF18/o5Ee8i055TKIyasBb0T9rmfAl
	mXEO17hWtFlemZC6lNVZoOortg6T9zgN44ydznaYxy8LJFWneyhl0NHJ4WG5QhJd
	1VS2m0QSp8fgtN8uK81a10EOXECflnI+rrA==
X-ME-Sender: <xms:mEoCacEUnMQhiExXjUB4pIZ--Bn-4wv7TJ4IsSQEquj7XCzc6Z7zvg>
    <xme:mEoCadBSp2M4kTdv8_9pMESGiq45XxTWBumC8KMJptp30-9PyStDYD9zBP0fIAoRU
    edc2Ko_R2QSagUSjRBdYLyaQYEnk9rvBVZxDeZ9IutLgkcBcoLsSqk>
X-ME-Received: <xmr:mEoCaYUyE90O4bXlKsfln2cY1aMntSGLBBELjtTLeluUD_jkutxybVmRM7mvHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthho
    pegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepug
    grvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrggu
    vggrugdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrgh
    druhhkpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtoh
    eplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:mEoCacyF1RHVcLYRyFT4ZQDb1NNgXDOsB6KNvUHlEmfjAXEn2bWj3w>
    <xmx:mEoCaV6pztrEFaqdCJZva8ahBL9HhMEY7MOrHpN-4vGFCgfrnjolqg>
    <xmx:mEoCaWZGqLI9Hf_Fglz7txSaT3RQ5YDkSAoAxCEdp-l3xFHBWbO7TQ>
    <xmx:mEoCaTN4Pel5vb9e79uW_KKdyBjAMTX85I0kv0O6VEZmyJtTVseF2Q>
    <xmx:mkoCaYAoznBpCEKhVJp9uKe260T7Urz4KZ0Z3cNh6JDnOlIH9fALLPZg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 13:10:47 -0400 (EDT)
Date: Wed, 29 Oct 2025 17:10:45 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] mm/truncate: Unmap large folio on split failure
Message-ID: <iqzgqvkin6istylyqqias7bwulhh2s6l6aqepssk6ptfu5dddy@q2rfk3wewcbz>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-3-kirill@shutemov.name>
 <9c7ae4c5-cc63-f11f-c5b0-5d539df153e1@google.com>
 <qte6322kbhn3xydiukyitgn73lbepaqlhqq43mdwhyycgdeuho@5b6wty5mcclt>
 <eaa8023f-f3e1-239d-a020-52f50df873e7@google.com>
 <xsjoxeleyacvqxmxmrw6dxzvo7ilfo7uuvlyli5kohfy4ay6uh@hsrz5jtkgpzp>
 <20251029151947.GM6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029151947.GM6174@frogsfrogsfrogs>

On Wed, Oct 29, 2025 at 08:19:47AM -0700, Darrick J. Wong wrote:
> On Wed, Oct 29, 2025 at 10:21:53AM +0000, Kiryl Shutsemau wrote:
> > On Wed, Oct 29, 2025 at 02:12:48AM -0700, Hugh Dickins wrote:
> > > On Mon, 27 Oct 2025, Kiryl Shutsemau wrote:
> > > > On Mon, Oct 27, 2025 at 03:10:29AM -0700, Hugh Dickins wrote:
> > > ...
> > > > 
> > > > > Aside from shmem/tmpfs, it does seem to me that this patch is
> > > > > doing more work than it needs to (but how many lines of source
> > > > > do we want to add to avoid doing work in the failed split case?):
> > > > > 
> > > > > The intent is to enable SIGBUS beyond EOF: but the changes are
> > > > > being applied unnecessarily to hole-punch in addition to truncation.
> > > > 
> > > > I am not sure much it should apply to hole-punch. Filesystem folks talk
> > > > about writing to a folio beyond round_up(i_size, PAGE_SIZE) being
> > > > problematic for correctness. I have no clue if the same applies to
> > > > writing to hole-punched parts of the folio.
> > > > 
> > > > Dave, any comments?
> > > > 
> > > > Hm. But if it is problematic it has be caught on fault. We don't do
> > > > this. It will be silently mapped.
> > > 
> > > There are strict rules about what happens beyond i_size, hence this
> > > patch.  But hole-punch has no persistent "i_size" to define it, and
> > > silently remapping in a fresh zeroed page is the correct behaviour.
> > 
> > I missed that we seems to be issuing vm_ops->page_mkwrite() on remaping
> > the page, so it is not completely silent for filesystem and can do its
> > thing to re-allocate metadata (or whatever) after hole-punch.
> > 
> > So, I see unmap on punch-hole being justified.
> 
> Most hole punching implementations in filesystems will take i_rwsem and
> mmap_invalidate lock, flush the range to disk and unmap the pagecache
> for all the fsblocks around that range, and only then update the file
> space mappings.  If the unmap fails because a PMD couldn't be split,
> then we'll just return that error to userspace and they can decide what
> to do when fallocate() fails.

Unmap does not fail and PMD can be split at any time. But split of large
folios can fail if there's an external pin on it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

