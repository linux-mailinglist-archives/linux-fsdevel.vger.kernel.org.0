Return-Path: <linux-fsdevel+bounces-20348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3743D8D1AD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 14:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FDB284745
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F289E16D9A7;
	Tue, 28 May 2024 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t6rnuVyk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF5A16D33C;
	Tue, 28 May 2024 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898422; cv=none; b=uwRbHSIfnyDoahM0zxOctoxnu6YuhQPHCW7dUoH+xnH6QqJ7yEp3+ZTD361oqpgMsBHF2JZi+tcv6lWMqDk8S0WLFA0n6Lh0S4KL/lJthEXVVVz+VG75bDqStl8hwxk9C/c2hCpY2ER3UU6R9OA8gnML5TPS3mf7Iexwqt/S/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898422; c=relaxed/simple;
	bh=ucel0VCAjN/oDU+URcHY43YqIVDaj1+TA1ii6J3sN3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXR1tsinqbp1qoz/Dnm+8cRGNymrS81tlHzeckhj8ocH6y6JjTz95QFZGNCCDi3IJakkNHpawEx0K2yaQhlPetsquMOujb8ZOvC36dPJ8woQOCbXLhlL92Otdn+6mSerLi1ZBYf3qs0bGWFgyJkvlTnfV/WWApYjnBgcB/pQfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t6rnuVyk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ucel0VCAjN/oDU+URcHY43YqIVDaj1+TA1ii6J3sN3Y=; b=t6rnuVykEcAU15WWPDvnz1j2J6
	PIfy7CNVFojD0nFbFgPp+GslcpAR/gHGcuep4lbCujEDY3AdgPh5JEyMdbBx15I9wnnFIieZ+0d2+
	MXc2GGTFmkkVsDx4MUmO/R6WXmpoyaLlgYOUCaqFWFd8WLLPnxKU5WilkychhqKO2wZXpZvxTHgJw
	UTSgxmPV+P/dgO801g8AMxENmLfvuxwhd4eGXS5ewlVqwsqVJPc6xnKhfUCRVBIBntFYBpBhN441v
	okr9Iu/IjZvRcM0cxqyhNCztVJFScpvJeaCkHFdzb7MpGsvQtGL7hKB7SnCU5qhgPn1Mt5oUFekBc
	oZCUGR7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBvho-00000008dEB-4Axy;
	Tue, 28 May 2024 12:13:29 +0000
Date: Tue, 28 May 2024 13:13:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: akpm@linux-foundation.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com, hare@suse.de,
	ritesh.list@gmail.com, john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Message-ID: <ZlXKaJ9soHMKMbGB@casper.infradead.org>
References: <20240527210125.1905586-1-willy@infradead.org>
 <20240527220926.3zh2rv43w7763d2y@quentin>
 <ZlULs_hAKMmasUR8@casper.infradead.org>
 <20240528101332.b7uwjjjeifgsugrw@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528101332.b7uwjjjeifgsugrw@quentin>

On Tue, May 28, 2024 at 10:13:32AM +0000, Pankaj Raghav (Samsung) wrote:
> Btw, I noticed you have removed mapping_align_start_index(). I will add
> it back in.

Add it in the patch which uses it, not this patch.

