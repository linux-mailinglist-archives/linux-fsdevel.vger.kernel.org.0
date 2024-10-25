Return-Path: <linux-fsdevel+bounces-32932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1959B0DBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5391A1C2314D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65B20D51C;
	Fri, 25 Oct 2024 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W2ACu073"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD218B462;
	Fri, 25 Oct 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882216; cv=none; b=g+CL6qCCPlB6vjIe55Gw9d05A1lTaefNg+BQ6i3MCeaCjWfKFZb2jsYZyoTGGZ74nB7G6IGURMrahnr0QsK+aOqoBZVQv3Txs1uxqCAChYavcRNu5ZkbE6LIU3tcsD3rnskuSRmGLkdCf3bQ89Pkxinc5tkeh6g1eRpSrtO3VcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882216; c=relaxed/simple;
	bh=8ooSi9CAvgT2phJOW64BYgbdx09kev5VA70Ys0nj5oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+K+G3rtxMA/oOQ/ha2+pfXcpFR3ZUUVMdQng7Ty4EtFVwkKWbE2SH9UH6egB8qEp7wD5M9RofFJ7j/Q9Hwuww0nvDp1pjJ1r3CfdMBIwzyCLAe5Us75phRvL6GBzjO8fi6BVuNCqpuMulZQV/tiA7XP1vK4k0BHLW2RhIJol84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W2ACu073; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bcmNzj2gfctTPmBxLe9Bb1pTwUUujfLr4SgsgNMM2t4=; b=W2ACu073+/ZmL3tZfSLah0s6rE
	HinIsk8Fe+nvzsq0m+cyHvADCJ8bnUThf0tr5j841dYN9A46OpFsK4JPwZp+hLpeQaxiI/+HLqiRV
	F8bDZjdX51kX8vNzAxeLio+APUKmklzRtqXvFD/GbWQqalmmGi0s9T/5GU444yDn2/zKO8e0BTyex
	gsvIuDbU5VZtynIH5rtkKhRGo7w+ETGPQxp/vMQ44+cGBeVfIkwtiOPMZkpzqE5710CTA2WogIKHI
	FRZZXGdmVmc6Ng/tms6GWLL7tqaVClEghWnGcagrXqSDUMYvs1RMGqhvxXd0pIFjveVl/3yKWBz0T
	vQkN82mA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4PNy-00000005WOa-0jtA;
	Fri, 25 Oct 2024 18:50:10 +0000
Date: Fri, 25 Oct 2024 19:50:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] ecryptfs: Use a folio throughout
 ecryptfs_read_folio()
Message-ID: <ZxvoYed-FPzKqjFs@casper.infradead.org>
References: <20241017151709.2713048-1-willy@infradead.org>
 <20241017151709.2713048-3-willy@infradead.org>
 <nrdqlalnw7juepbpqrefnbh4a6ltjavwgogwv5ltkd76mieflz@jvjtoenberj7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nrdqlalnw7juepbpqrefnbh4a6ltjavwgogwv5ltkd76mieflz@jvjtoenberj7>

On Fri, Oct 18, 2024 at 11:51:11AM +0530, Pankaj Raghav (Samsung) wrote:
> On Thu, Oct 17, 2024 at 04:16:57PM +0100, Matthew Wilcox (Oracle) wrote:
> >  	ecryptfs_printk(KERN_DEBUG, "Unlocking page with index = [0x%.16lx]\n",
> 
> Nit: Unlocking folio with index ..

Sure.  I wasn't terribly careful because I don't think ecryptfs will
ever be converted to support multiple pages per folio, so they're
essentially the same thing.  Same reason I didn't bother renaming any
functions.

