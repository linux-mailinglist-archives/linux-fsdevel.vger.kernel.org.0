Return-Path: <linux-fsdevel+bounces-64809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE000BF4B05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 08:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF4D18C24D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 06:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09172586C8;
	Tue, 21 Oct 2025 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="aHj0ePuH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sisca4HK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF6354AD4;
	Tue, 21 Oct 2025 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027396; cv=none; b=fySA+EIp53U10phLTf0Cv0tnLn1jDV9FQGR4crwAJRA1iQpUakam6cPBh+3ZRoutWHN499A238OhjgF4z6hauuwRinSU70fR4vNEPjGwtdp/QtaE2jfU+WXfR7kyfg7DczBHmDxraQD9B1JQKWKxwK2vPBixGEu+yWeBhYgAIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027396; c=relaxed/simple;
	bh=HK/nHqr3Qz1QxvaIiI+NbqtuAEIHxyvIk2VqZ1B2g9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0/Va2SawkOnUefaKSNIBw+ey+JCgmvquAg9Z8rddswD9t5CB6LddQRkcWUfVvtnT+IvArF0nAB2NBi2qcgZEufft3B+hpfvIhnGHaeg1hj9c6pjpZoUMJ5XUIR/tTx4gDM3mCIWD86mindnxdu7gnECL68HnjypdHgElqnGEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=aHj0ePuH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sisca4HK; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id CDD5E1300AC5;
	Tue, 21 Oct 2025 02:16:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 21 Oct 2025 02:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761027391; x=
	1761034591; bh=h0I0/rRQeZwp/IbShSTCGxIxrgyAXggNeKL32rwMMgs=; b=a
	Hj0ePuHpTCXW24pov1BOQb4xSCLoG0iRwPOV7Ut2MeVAAcgI6yW+cdKf6rMS02Ut
	V7VCjjbN6MQOFaHdn06Y9QhCHLxh+IqGHMUd+tldZGN8f2NHF9GS+TZcQ2+yDnny
	Jj8E/wC1Nq3NuDcG/9CzkQ+RD8iDkx++Yrqn9pOybE0aZfEqtLbzZI04nKvUSWQx
	Mq4pGrd1wz2j+xCj10WxZs9R16PYYtbw6iV3AqG+bu0iWpSKIvdDLz6F1VinXn4M
	4H2dhjKpW9HqcaBUwt/hMJbAtDv+6IlP56V59xKvXvVAVco7UFaxZKgjA4GpS9LB
	VwPhZ/pYmYwm95ODw86NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761027391; x=1761034591; bh=h0I0/rRQeZwp/IbShSTCGxIxrgyAXggNeKL
	32rwMMgs=; b=sisca4HKx4Ig/i4chEgD7FFZ6gZj0d+Oddv14Y0Jg+W7/faxeZc
	YyDPMM/p/wETgIULXgGprAgVI+qsiUhFMQBYAQTNAJKENUkuxhFEqUqlgl2nd6x8
	1zG8ZsqsO6tJYFPBcLPOthKT+5WmADvFsoD7HFdOtIMjSAaJWFJhham3MraynTOp
	dlJTR54YwpnrSemwhagqeySSF02mk5OsM0X1NwmJSev/UYJb1CEGP6HePHb7uT3N
	h0EH6vd2FnIPcF/LoNy6xPBGHqiZZdMIIhP8GWlirNkc8h3eDjtEd8jbDzhYdCUh
	5YSK7iE46tfGDwIccGRvr28uyM8FSxWvgFw==
X-ME-Sender: <xms:PSX3aJOlA07VrFa5oEBuI9UxfVU4_PGpt34aDSYfALNP9_oYjtKDmw>
    <xme:PSX3aFCnRcHza80FEeERLCpaR0NN0DGk6nVKpCX2eHvdO8rgJuPYF9im2itYBLViA
    -iXCt_Zr0O7rKaMBaV9erhPrTsXx1zPsgCWz4S1iI-BzlS6y81vHw>
X-ME-Received: <xmr:PSX3aLMzW29zICnlZwYz5nazmRwajp2x-6bkr5STG1vUPvyIp-vi9BOEXqBPGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesfhhrohhmohhrsg
    hithdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    ephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidroh
    hrghdruhhkpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpth
    htoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:PSX3aCzl-Z8WNRz8-pZ7B-afK4HGqC8PE_PfiKUfN0gDP1dD6Q31dg>
    <xmx:PSX3aOeghdZuHuWQOPvnu4UWGATq0RBgqYgx_42Tk8aK7Gum1iVSJQ>
    <xmx:PSX3aN11CDm0IrZXGVhulx1jKHgyFjD-UkGi7dPt5jwF9txV13KuYA>
    <xmx:PSX3aHlyEmbgJLV8Q29c82OHwQWV6DoGPztGyi0jeMt45AnQRezF3g>
    <xmx:PyX3aEa-9s5zkJim5FjAIcfsQNkRkQnzVrxtL4ZvpaLwstPrytXxr19q>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 02:16:29 -0400 (EDT)
Date: Tue, 21 Oct 2025 07:16:26 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Dave Chinner <david@fromorbit.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
Message-ID: <d7s4dpxtfwf2kdp4zd7szy22lxrhdjilxrsrtpm7ckzsnosdmo@bq43jwx7omq3>
References: <20251020163054.1063646-1-kirill@shutemov.name>
 <aPbFgnW1ewPzpBGz@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPbFgnW1ewPzpBGz@dread.disaster.area>

On Tue, Oct 21, 2025 at 10:28:02AM +1100, Dave Chinner wrote:
> In critical paths like truncate, correctness and safety come first.
> Performance is only a secondary consideration.  The overlap of
> mmap() and truncate() is an area where we have had many, many bugs
> and, at minimum, the current POSIX behaviour largely shields us from
> serious stale data exposure events when those bugs (inevitably)
> occur.

How do you prevent writes via GUP racing with truncate()?

Something like this:

	CPU0				CPU1
fd = open("file")
p = mmap(fd)
whatever_syscall(p)
  get_user_pages(p, &page)
  				truncate("file");
  <write to page>
  put_page(page);

The GUP can pin a page in the middle of a large folio well beyond the
truncation point. The folio will not be split on truncation due to the
elevated pin.

I don't think this issue can be fundamentally fixed as long as we allow
GUP for file-backed memory.

If the filesystem side cannot handle a non-zeroed tail of a large folio,
this SIGBUS semantics only hides the issue instead of addressing it.

And the race above does not seem to be far-fetched to me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

