Return-Path: <linux-fsdevel+bounces-34877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046009CDADF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 09:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC0E28360A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 08:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEF318E05F;
	Fri, 15 Nov 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="KjYK9ERW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Csxz+lyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A018BC36;
	Fri, 15 Nov 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660561; cv=none; b=tLAMdmh7BJsSW4fYJ23ZF/n8sZccPlp/mIdv8aq4xS9RLoZvgFJ+8LJuPAHdwBiekfF93xMEGLM8dBraSRGwfyXPW3DfOHrNY8BgCIEfWLwJkbokYFwuIzqSeG9dAtdNvajm9alErlwGDDEcc9usN2wTO0OZ3eLYA936sRslQfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660561; c=relaxed/simple;
	bh=Wk98YQs1fhjFtM7kc4yXuBwnDskMKxFjh/w65kt/2wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO2quheCrB4uD/tkt3vqtdfUvlqNAykBHfQcciw3tuUdk0c7l+k4GOHGM3smeucJmSo7PjfpiX2zyGgEk6kjzBct1mGakeoGevbjVDfuT0+O8DnJXNVNaDj3EqqzQ+HHdRmSDJ0OWAqUdrBlWbh12GN2X8SVz/guYIYilDUWWJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=KjYK9ERW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Csxz+lyZ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 37C651140151;
	Fri, 15 Nov 2024 03:49:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 15 Nov 2024 03:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731660557; x=
	1731746957; bh=Iaji9P4Funvw7r0qArvkXpNAHznh5sdnkxmV7nx9XAk=; b=K
	jYK9ERWo+b/9O9yWM3VYBPdlzRIhn/GsCwKz65L9HH8qqkP/wDYnJdej5Sdxv1Oa
	o8aUlQFMaz7EU1sF9bMNL93pUaR8lc5vGlkl/kHBzbDYhX/W8KUq/2PrmUUUemcY
	yTkCN0FFKazvuUGzbwLFLYtptvUP6sdbxrHR3v77ZtUSszCkxHYrkP7/OU2WT5I4
	nl1N6gkhm2utCFaqm81/n6PbZ2bfMSwNaWfGwnqKamxndIqg9L+1b69Fe3+sdMNC
	giY1cuzGyy8BNhSrT76X/0rqWvMcrHe3dnxDFjCEtOiTxfqI9ScTEIE74ycflQZg
	DIcfFOaiABhUrBrcPyldg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731660557; x=1731746957; bh=Iaji9P4Funvw7r0qArvkXpNAHznh5sdnkxm
	V7nx9XAk=; b=Csxz+lyZaPEgendotkPPZbMtqk7t4iaGLW/c54YxIJJCdfFREiH
	KATPLJ0GRBSRF7oA5MJbIsoK2NBxFUBhKxZfCCHd7tb4oIT0mqpatlJZSl9vX0iK
	cwsuzTo0LfJ3xiKzJK0RGIJ+mF8GD6+ZQwZc7YHxR3Bvi13AcNh1giAei2goxWZ6
	gtg7oHnlCfKKjEbgGGzjDURGzEMg0eZPEfIQX8tNwpLWhWXm3SWS1qmFJor4p5Bw
	+9qcmNZwVswh82WH0z2CYBccWyRRJNab8/HUy7753Z+H+KW+UfAuvS9FG1LDk9ip
	c56fRBrZ5g1o5LEsZ/hlI38UsHOtK6JlKfg==
X-ME-Sender: <xms:DAs3Z5Asdbehi4P3hc7OUrnaUGYzB0ZavqkZDSzdetYcfqkoVrCItA>
    <xme:DAs3Z3h1o5_97bBaZ8rW0cclaxdQK33C-6lEA5Fy16w965dEedSIbVNdGQ-cYRMtO
    5pxsmYJy9_MgrkmYks>
X-ME-Received: <xmr:DAs3Z0ksIyYjd8A5Ft4XH2D_RR4BIZ4wCL0TNMGfOdKlzX7PMh-ShQgwE45cfWoBgqW3pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqmhhm
    sehkvhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdr
    ohhrghdprhgtphhtthhopegtlhhmsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhl
    lhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgvgihtgees
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DAs3Zzzd8jzmVBNcCn-cDOM4zaeAoPNE2KHHdmr5ekAmt9POByt36w>
    <xmx:DAs3Z-Tev12Kfd5rRCyu9FQAS6CquRgSdsDJZiNBdOqUAcpO23GN9Q>
    <xmx:DAs3Z2ZbCQAg1NIhakA2wVdhw1XKrZAVFEULRQwl9NBPdKJV0HVRRQ>
    <xmx:DAs3Z_Qfv5Rs8nDB9uffzNIzrGA9xMrPGvHOCybQ8ni5FTdPM_8HWg>
    <xmx:DQs3Z6YT5f0sbbQQjcItTIVFoyLoyuqnRTfw9MlesicUQdmCwc0XtJIq>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 03:49:12 -0500 (EST)
Date: Fri, 15 Nov 2024 10:49:08 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bfoster@redhat.com
Subject: Re: [PATCH 08/17] mm/filemap: add read support for RWF_UNCACHED
Message-ID: <66q2ojkbzy2l7ozzc4ilputbgvdtwav4r4qdvnl7x32tuutums@zachqbvl7y3w>
References: <20241114152743.2381672-2-axboe@kernel.dk>
 <20241114152743.2381672-10-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114152743.2381672-10-axboe@kernel.dk>

On Thu, Nov 14, 2024 at 08:25:12AM -0700, Jens Axboe wrote:
> @@ -2595,6 +2601,20 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
>  	return (pos1 >> shift == pos2 >> shift);
>  }
>  
> +static void filemap_uncached_read(struct address_space *mapping,
> +				  struct folio *folio)
> +{
> +	if (!folio_test_uncached(folio))
> +		return;
> +	if (folio_test_writeback(folio))
> +		return;

Do we want to drop out here if the folio is dirty, but not yet under
writeback?

It is checked inside folio_unmap_invalidate(), but we will lose
PG_uncached if we get there.

> +	if (folio_test_clear_uncached(folio)) {
> +		folio_lock(folio);
> +		folio_unmap_invalidate(mapping, folio, 0);
> +		folio_unlock(folio);
> +	}
> +}
> +
>  /**
>   * filemap_read - Read data from the page cache.
>   * @iocb: The iocb to read.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

