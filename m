Return-Path: <linux-fsdevel+bounces-64250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D38BDF813
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 17:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A487C4E7142
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2EF335BA6;
	Wed, 15 Oct 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Q7mdH6HU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z2LZtyfv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A3274FD0;
	Wed, 15 Oct 2025 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543949; cv=none; b=fEQnUXroqdK3dkbZT8xwH/h+RRmovhuTAn9v+oua3lgmWMKLqSP5GmU9sE21XqQ8zfIslRDIij/MZNfC+JiZLDuTLi/CxVuF+Yql/z/2XHO2bxvHCAwd8/xV1dKpjM54TVSyVRfiGR/nH+trbXHKH3DEWnsvttdd+65Sfok2+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543949; c=relaxed/simple;
	bh=i4hqPcdADIH6RrpLI5BrZeBw2xLyE6eAeS/d+pT+KZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm04u39A3KZ/GcPL2vOkCjHxfMEA/wkDVT0S26kERwnoPXrF+HTeMxHxqdBzsjNMljCQ3IgH3o85w6OUVV72pQ8WTjRzPeEtuu95uDbUQ0LqUDGxGwi+d2trbQQyOO0iD5tkiaSQ6RoPqBgfctgfFDmh3bXctP/2Ea9uzJlfI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Q7mdH6HU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z2LZtyfv; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DE0B9EC01F5;
	Wed, 15 Oct 2025 11:59:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Oct 2025 11:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760543945; x=
	1760630345; bh=v3YhLDOjSOHSx+F9m6lOAdQ2eMBIiBXjWJc7qhY9J2E=; b=Q
	7mdH6HUNhs14Dp1G4lGpDlcmQ6fcxF1Z+cAR9tC65LjD4qspFH8Xvs7Vc3zChVKt
	IjvdyO6n41JZIWO+BDKg8jlTH6VBOtOS/VxWPc7m3VA5qhkU1OWhiHnVO8v/JbGc
	RzAnYvknk/QRf1H67x99OdNf2iyooE9dhoc0TNsADCwhwcqv+BkWIl0/2V9/rxq3
	GNiXzcRvPyTp4ROlYZYvJ9cmSQEHL4eSPqYLR1fVuecqHsaEzqx3Eho482MG2jAq
	Y8IExQ7SqUlNsvJ8ZSBSzRjJjuwn3Ya6Lfk/G9peSPsCEbDTy9Ds+zNkaAksnQe7
	WnkMLa1H2F4ZXU4r6NcmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760543945; x=1760630345; bh=v3YhLDOjSOHSx+F9m6lOAdQ2eMBIiBXjWJc
	7qhY9J2E=; b=Z2LZtyfvAxOH6178TmtGPgwo2HwZZww0KkTTY/SxLrrj1Gra6Vt
	FG8WiJExaHMfTJh+2eRaUKaGvpALeZVP0xmUbjt/F6TJKeLFnfeSs7d/Bn07V9y6
	rHTuHfODwtBXLheoTLehS6p5Ci0P44UYztAzwkAHBtF9MsNKKlOi/sZ4lKN2jE1M
	nhJn0DLibo9eSJKRMSs8j8qzsquKnBGNTIeI6vjWpHBcC2yor2EWtFDw740L+Jx7
	WS8WwZyPhjzVNI4JYd69yvBiyFjbSOEAe3/poZcSNec8E3vB4R6NNfrY650VZP5X
	h7igwPiFPX+Mp3OlwsEXqQr7GpfM9H168ag==
X-ME-Sender: <xms:ycTvaAd7F_rGgLOsbJOrmFCtKTKz8AZNmV2IIRW8JiV2iEZm9NDy8w>
    <xme:ycTvaIkqZmPsrqJFivkAKstoWNCOp5kZX6AsznJaNGjMBw2uEkZMg4gEZnpUHL8ra
    gQG-ZUhFFuX6wkrEt1CH0hYfhgXTItC8lN2d9CMWulMuWmWMLJRSA>
X-ME-Received: <xmr:ycTvaNxT852gNlaDTLj7P11PCqLVsXesyJ8uHkKcHQyb37OmoC023KUQmGWh9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epfihilhhlhiesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:ycTvaDz8L1rYsHHI51SL-LQkF2tPIDfCBHztiSROBZ_7sCXg0MctDQ>
    <xmx:ycTvaFVYRquVd3TiPgcbAnhw8_-s-ip-0vGSqPq1aAqI3tgcvGOAtA>
    <xmx:ycTvaCRGVlJyqA3Qah7imWMfNw44KfaYxEGAx5SNRJHlEUG9o-Xi_g>
    <xmx:ycTvaFQY3uz0A-Ok3okAaODb_MvhMZMvkhzinNWfCcWRNxn-hQ-XSg>
    <xmx:ycTvaMkFnV31N70t3bdfB9HS10dGRE7AjlR0TD1pja_HYICqOEa9rdX0>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 11:59:05 -0400 (EDT)
Date: Wed, 15 Oct 2025 16:59:03 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm <linux-mm@kvack.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: Regression in generic/749 with 8k fsblock size on 6.18-rc1
Message-ID: <rymlydtl4fo4k4okciiifsl52vnd7pqs65me6grweotgsxagln@zebgjfr3tuep>
References: <20251014175214.GW6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014175214.GW6188@frogsfrogsfrogs>

On Tue, Oct 14, 2025 at 10:52:14AM -0700, Darrick J. Wong wrote:
> Hi there,
> 
> On 6.18-rc1, generic/749[1] running on XFS with an 8k fsblock size fails
> with the following:
> 
> --- /run/fstests/bin/tests/generic/749.out	2025-07-15 14:45:15.170416031 -0700
> +++ /var/tmp/fstests/generic/749.out.bad	2025-10-13 17:48:53.079872054 -0700
> @@ -1,2 +1,10 @@
>  QA output created by 749
> +Expected SIGBUS when mmap() reading beyond page boundary
> +Expected SIGBUS when mmap() writing beyond page boundary
> +Expected SIGBUS when mmap() reading beyond page boundary
> +Expected SIGBUS when mmap() writing beyond page boundary
> +Expected SIGBUS when mmap() reading beyond page boundary
> +Expected SIGBUS when mmap() writing beyond page boundary
> +Expected SIGBUS when mmap() reading beyond page boundary
> +Expected SIGBUS when mmap() writing beyond page boundary
>  Silence is golden
> 
> This test creates small files of various sizes, maps the EOF block, and
> checks that you can read and write to the mmap'd page up to (but not
> beyond) the next page boundary.
> 
> For 8k fsblock filesystems on x86, the pagecache creates a single 8k
> folio to cache the entire fsblock containing EOF.  If EOF is in the
> first 4096 bytes of that 8k fsblock, then it should be possible to do a
> mmap read/write of the first 4k, but not the second 4k.  Memory accesses
> to the second 4096 bytes should produce a SIGBUS.

Does anybody actually relies on this behaviour (beyond xfstests)?

I think this behaviour existed before the recent changes, but it was
less prominent.

Like, tmpfs with huge=always would fault-in PMD if there's order-9 folio
in page cache regardless of i_size.

See filemap_map_pages->filemap_map_pmd() path.

I believe the same happens for large folios in other filesystems.

Some of this behaviour is hidden by truncate path trying to split large
folios, split PMD and unmap a range of PTEs. But split can fail, so we
cannot rely on this for correctness.

I would like to understand more about expectations in real workload
before commit to a fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

