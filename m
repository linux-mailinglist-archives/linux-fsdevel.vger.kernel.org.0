Return-Path: <linux-fsdevel+bounces-64850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C030BF613F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FF5463BD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2553732E751;
	Tue, 21 Oct 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="VtVOLEBl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aFvs788V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1556332E13D;
	Tue, 21 Oct 2025 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046279; cv=none; b=uGsz1DExPzMmuRoQbrhAtWribXBnwirnEMLIk0ePUFDp1MdayV2WAqD5oP8vekgj5eYv7qgcekKRMN1yVaaA5eBbvY98c6W+0o8fMHo7Uv2WSm7J7dXg9ljJ4IQk8srkvXAMuqK6DntxTBBQFxKZ0PFbvEb2Ma7WdKw1eBHeUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046279; c=relaxed/simple;
	bh=i2ypIgVxR5XKVj6oglN5eSqLYS95V5/BxaV2psQ371E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrlIeNztNlDQUO/4U0HGKU1GlTNfF8dnC/Xudwpo+JcG8xcpqYCatPgl/klcImJh6WlOOnlBPj999N/+6CbVVlo3aQzpNVYu/RqXxgSo992s03fYtn2ZKp7B6FEi2m3J9TKMjS2lU9vVUIFvjRAekbx6vAq6jAjH27MnF9KQrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=VtVOLEBl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aFvs788V; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 0D7891300099;
	Tue, 21 Oct 2025 07:31:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 07:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761046274; x=
	1761053474; bh=BLuUH66s5GK5mvKmYkyR8CP4H6QviMHTV/wP+OAXiXQ=; b=V
	tVOLEBljxFSK4E4lhTxWAlL/ba9qwZSnEFWSqacoI5R7kgVCiKIxoZsvON95LFmE
	xoDya60LWDBFSR1e1bw30/GlLZL3o4nfz3qXpuIXZEZVRo/ViKE0F5YjvaFfPGnj
	XuEsBzH/m+N0VrP2WS3y34OTx9W1ecGRywFMNkHd313pgpswYEpYIvtCa2h4KzmP
	iWGxHm3fAIJTRvKerXuOFdhRQ8qD59t87gxFH1nIuj4q17xFdxHTYLA7o8cLH/nR
	erdQBTUQA0O6ettsJnUL8VXnCLZ9t6LktqKOwd99TTuN3yQ8M5JUjTglXwWHz02r
	ktf+vlegg3qaaGpJCXowQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761046274; x=1761053474; bh=BLuUH66s5GK5mvKmYkyR8CP4H6QviMHTV/w
	P+OAXiXQ=; b=aFvs788VrXnd8g82PJYeNvUI53vVxwk18Ndv2uvKvtvljy15OTR
	h4WYYBHrrO+OwztFJwlVUS3amF90w4OU3xannSAyfXNZZyFBGuqKZz0TPO3GNtd7
	LiBz9h62+fvFY/U77VleCHyLpxXsueVua3dTMnsPnipA+ss0hGUKvYE0Mf0KiRBY
	Sgk9YXLNRYO/jp8C2ZihSvz5d/tszQz5kDaAzAni8tstEoQVQ+4BaHllZ6+lxQkP
	D5LVzU8oBa06CeB9a8Mxj9LiULXttMUuOH8q0IxAYzTW2606yBTDoRA3PI46DEj8
	lNL9R3RMlSX7og8eRViJsCCsaaHBhdM5PDQ==
X-ME-Sender: <xms:AG_3aJ1aLBz_kNGW9nRdGfmahw6U8DwgfJ-dJoX4CCAQyD3ZfiQqqQ>
    <xme:AG_3aMROrGlYnv_olSTsAAGcoyItemt7cJPJvcTK9R9s_oEUVHjjsk29KztSIwSlb
    vqT7hiXnfY_JMBBL4u9p_ubgE9t-AmVcNL0IwiFGc50tzmOeX8-EA>
X-ME-Received: <xmr:AG_3aBAIomb4Gm8dpNjkqNcOf7uDGKAk-0FfSyVR-jQv_6heE_eHP6-bnedBGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrd
    gtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:AG_3aCYxh4OsdSuannxhKiVcXTYN90LbuhkeFf2kpQu-BoU26k4U2g>
    <xmx:AG_3aNawM5tTZoyPJCGn-YFXzTHP4sTIeYfby4T22uZYJj1m-X7Pqg>
    <xmx:AG_3aNlk51B-HQP3ueaKimaqsrIvO87dFdtNhnYUcmr32cJyis5SDA>
    <xmx:AG_3aEMZGhoCb0mdqmLKXuelhtzyUKqbNAiPRiAxuewOAMFhzPgfhg>
    <xmx:Am_3aE5rG7YeIoEvLbRvVYLoTuCMmIb3LpXFvKkmi-ujHwsAIlZVxTEF>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 07:31:12 -0400 (EDT)
Date: Tue, 21 Oct 2025 12:31:10 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/truncate: Unmap large folio on split failure
Message-ID: <eokncpih37zm7ypt6gn5xyetx6jlemhvvfdzpmdlxleqlsqcr4@45h5w5ahwugs>
References: <20251021063509.1101728-1-kirill@shutemov.name>
 <20251021063509.1101728-2-kirill@shutemov.name>
 <a013f044-1dc6-4c2c-9d9a-99f223157c69@redhat.com>
 <37ceab54-c4b2-449e-aa46-ffaefe525737@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ceab54-c4b2-449e-aa46-ffaefe525737@redhat.com>

On Tue, Oct 21, 2025 at 11:47:11AM +0200, David Hildenbrand wrote:
> On 21.10.25 11:44, David Hildenbrand wrote:
> > On 21.10.25 08:35, Kiryl Shutsemau wrote:
> > > From: Kiryl Shutsemau <kas@kernel.org>
> > > 
> > > Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> > > supposed to generate SIGBUS.
> > > 
> > > This behavior might not be respected on truncation.
> > > 
> > > During truncation, the kernel splits a large folio in order to reclaim
> > > memory. As a side effect, it unmaps the folio and destroys PMD mappings
> > > of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
> > > are preserved.
> > > 
> > > However, if the split fails, PMD mappings are preserved and the user
> > > will not receive SIGBUS on any accesses within the PMD.
> > > 
> > > Unmap the folio on split failure. It will lead to refault as PTEs and
> > > preserve SIGBUS semantics.
> > 
> > Was the discussion on the old patch set already done? I can spot that
> > you send this series 20min after asking Dave

Based on feedback from Dave and Christoph on this patchset as well as
comments form Matthew and Darrick ont the report thread I see that my
idea to relax SIGBUS semantics for large folios will not fly :/

But if you want to weigh in...

> Also, please send a proper patch series including cover letter that
> describes the changes since the last RFC.

There is no change besides Signed-off-bys.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

