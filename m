Return-Path: <linux-fsdevel+bounces-36151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0433B9DE7DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C875162134
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83A719F424;
	Fri, 29 Nov 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Ngk+Hi0X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ABysHRM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF219CCEC;
	Fri, 29 Nov 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887643; cv=none; b=oc8gcXvn+gYKw4bMlDGftT1FmoJIZbykt/bsR9yWDU+O0Kh+VIJ7mPbVGX6pty+hDpdkEMy9GrShgFg8a6xYyp5lRA82a+KUlbdjWpokWIXKuH20LB1B6+VS865x/9dy2XUMZq6cKdd38/EmAuq/jNX8PHDzFwc7zJX/e817hBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887643; c=relaxed/simple;
	bh=dFpk9+Oi8CaTJlXtBdCrQJEm0FQh2/JS7AzsTZ1GUcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyyNj7uSaYyJ9q7ATDNOzpL0Mg1Okh3DDt8pI4x+zK78JA3pw4WuYPUMW4Zci8kzL6cPul99e02x994UMBHlGT4rlTDxd48mFHe65YAkvTcjjwQtzq1Og5BmMkJqTA/JBFp29OEyB5ua3ODys2tckMyrtbaFj1c6nH7G0rTwHOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Ngk+Hi0X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ABysHRM4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D5FAD1380679;
	Fri, 29 Nov 2024 08:40:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 29 Nov 2024 08:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1732887637; x=
	1732974037; bh=h46sUWkmGOYezCFJtOC5vKVOrSkLwYy7bd1paRuMmx4=; b=N
	gk+Hi0X85vWgyt65XNrWgjZNvRWl9o6tt+R63M+CGmXij/Y5biOzwgu7GL1Bg1SN
	FnhSqeYfpCY5oBiYYOT2UXWR7LssANB2KFQAetoSX3nl7y7CqTPJj+q93SaPSqB7
	BE3oOxoeS/peOsuCEb1oeaPiHODlDvV0fbAcj4Wfr01p8QUXVb4ySmfvgDiuUYYR
	+NhMNTOmRdUTWVNKdBNmjqmd850b37cOqZ+GXbPIcKnqzYMFJCBcbH7EwaH46eoM
	WgwCrg6lc/FbrcbKYdwRj+YjwBzIxOizPzF1qOZ/xerquDKbKEjsx1PKMYoCIwnx
	GT8CSJRllH2YhYrC/AR2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732887637; x=1732974037; bh=h46sUWkmGOYezCFJtOC5vKVOrSkLwYy7bd1
	paRuMmx4=; b=ABysHRM4mlKrqpp/V50m4xqjyx8b8YDyk0e5rbq+I2A5I2Gl3Qe
	1K/4iX4j8rUxAsRdm9YEKYBYmt2LM5jqXAJY640Ov3/bv1Jn2YXAkbrV2V1bIL91
	zd1lbEEwlujMfz2RtNpErqorsNhN6cBcCWoSTBXZ4FV1BZOODxZBj9PhVVIoeCku
	70Q6g9euYTYs/Lla+ty/tyvL9nsYNGw8t0mQMV+tziQug+gsIKKcErXdl/QAO1Vu
	o9l1t92KOgsZjG6KMY0xEEWxhywEGASoCBlX66zE6kunFHdTk+WrEwjkO1gCaiZk
	Y1SzezHPRnTxnU/AO9A5soTc2jT/ds3UNGQ==
X-ME-Sender: <xms:VMRJZysEK7njFXfPZPT4DgTUOO60QaJPiquOE_wwwSvA061a8n-MeA>
    <xme:VMRJZ3eEqeZtGXbDhnNeYTteOMxIk23lrJCz3c6k5NC5eAzn8tidk1Qr-nNw0-OoX
    AYmGbaUE-74LifqsKg>
X-ME-Received: <xmr:VMRJZ9yoRMoptZf8V8l7R6QsWG2j1f2jiwB2vYeN5X33uIcSjVFGn_5iEssNu5c_oPnouQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecu
    hfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhessh
    hhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepleetudegtdfgheduudfh
    teelieeuvddtheeijeejudefjeefgeettedutdeggfdunecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtoheple
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtph
    htthhopehshiiisghothdolehflegrjehfjeeffhgstdejlegsvdefkeejrgeisehshiii
    khgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlhi
    esihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhho
    uhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepkhhirhhilhhlrdhshhhuthgvmhhovh
    eslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggrnhhtohhnsehsihhn
    rgdrtghomh
X-ME-Proxy: <xmx:VMRJZ9P5pIY_pWc98BnmQXaanJLdbcrbCFXDW2VkEDq6eKEFiEsd_A>
    <xmx:VMRJZy-1eREtLVml4Npi1-AmohyWzF-VlSCnfiztMHJc6DDzx_CkmA>
    <xmx:VMRJZ1X71BPSEkrh-gRVyES_BgDuXyFdDnECcPTc-yFT3soq8u57mA>
    <xmx:VMRJZ7fydqbW0_HYs5EcZlyGeqWsA8XKEifHukyQr7NngQdGGttF_g>
    <xmx:VcRJZ1Y1iOpIh6JgnvalbtOJz5q9fPocmTlQ1Ds3Pg5g0nJJMdbp-vEY>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Nov 2024 08:40:33 -0500 (EST)
Date: Fri, 29 Nov 2024 15:40:29 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v1] mm/filemap: don't call folio_test_locked() without a
 reference in next_uptodate_folio()
Message-ID: <2r2suyel6m6ngntarnxwtobicwignmmm3lfivvp5goufzis56e@rwtncfi7nxxn>
References: <20241129125303.4033164-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129125303.4033164-1-david@redhat.com>

On Fri, Nov 29, 2024 at 01:53:03PM +0100, David Hildenbrand wrote:
> The folio can get freed + buddy-merged + reallocated in the meantime,
> resulting in us calling folio_test_locked() possibly on a tail page.
> 
> This makes const_folio_flags VM_BUG_ON_PGFLAGS() when stumbling over
> the tail page.
> 
> Could this result in other issues? Doesn't look like it. False positives
> and false negatives don't really matter, because this folio would get
> skipped either way when detecting that they have been reallocated in
> the meantime.
> 
> Fix it by performing the folio_test_locked() checked after grabbing a
> reference. If this ever becomes a real problem, we could add a special
> helper that racily checks if the bit is set even on tail pages ... but
> let's hope that's not required so we can just handle it cleaner:
> work on the folio after we hold a reference.
> 
> Do we really need the folio_test_locked() check if we are going to
> trylock briefly after? Well, we can at least avoid a xas_reload().
> 
> It's a bit unclear which exact change introduced that issue. Likely,
> ever since we made PG_locked obey to the PF_NO_TAIL policy it could have
> been triggered in some way.
> 
> Reported-by: syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/674184c9.050a0220.1cc393.0001.GAE@google.com/
> Fixes: 48c935ad88f5 ("page-flags: define PG_locked behavior on compound pages")
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Looks reasonable:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

