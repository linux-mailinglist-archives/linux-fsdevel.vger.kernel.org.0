Return-Path: <linux-fsdevel+bounces-50407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A85ACBEBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 05:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8254170AB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 03:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5A116E863;
	Tue,  3 Jun 2025 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WMygVBoX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8282C3261;
	Tue,  3 Jun 2025 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920434; cv=none; b=qE3InRCdDd8zU7r45L89WJqTcz3fPjBXtNi1Y7EVIHfLU+lLp0EdYN4dYehHeZVriqo3y5qYwqJE/uqb7kWwtUgrCXq2cQ/HEVMMlqXSsFFnYKvPC4O528N5JleDaYieiDqy+x92pe0dhsEdkwMVtwzb8HgDob2DXczphYwOUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920434; c=relaxed/simple;
	bh=HJ5XX5EuAJe6CyKHwGCoNaHBSAneuvBEC6f3F7MnUVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL0RRKWFvM/e3a/0o3KMFYnT1UPTp+5e5gkn10LNljuB2BbABoJPKUvJDSHfn9LcGYr8HpXOfdum6Pm+jNx2QHLPc2iOWik+GsR83h9nJDJF++RwkmF5VLF9gLwYqSK8OSzP4M+F00TKsr7FRThzYWkontLLyPm9df5g0ExC+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WMygVBoX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rqlxqVcLZnSmkTnq26ieMyCkIRygZObCR9CdREzwSCg=; b=WMygVBoXpxf2nK69GArd7UzujY
	PMUYQP5MWjvH9DQXAxNj0BfQPF6gXVPJAPxgG4TK+JGY95kyEamD/3BiB/+ijlEAP8dr+tkUTdJnG
	6uOr3ynpb7pqZ2hqBzGIBpusC/NmuLtxw6fntoqttT2jrzqDz4Ym9D+fdZmX7+tYnmXERCPWdmkUj
	vUCjPKlTIdUoWc1PuYQNcmpLezYSMXIgSrYDqTAtml9q0yXrIwoep5d0LmafWT/TQphijz2mGEryc
	9jS4eEM8oiiUHQNvCDtrd3QdQV8H8V4P/NtnFAPTMBitF3KmQ23Sh9mBRicdiMfKULEh+60JzFkr8
	tvkEMxtA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMI62-00000001aY5-20j9;
	Tue, 03 Jun 2025 03:13:50 +0000
Date: Tue, 3 Jun 2025 04:13:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aD5obj2G58bRMFlB@casper.infradead.org>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aD03HeZWLJihqikU@infradead.org>
 <CALOAHbDxgvY7Aozf8H9H2OBedcU1efYBQiEvxMg6pj1+arPETQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDxgvY7Aozf8H9H2OBedcU1efYBQiEvxMg6pj1+arPETQ@mail.gmail.com>

On Tue, Jun 03, 2025 at 11:03:40AM +0800, Yafang Shao wrote:
> We want to preserve disk functionality despite a few bad sectors. The
> option A  fails by declaring the entire disk unusable upon
> encountering bad blocks—an overly restrictive policy that wastes
> healthy storage capacity.

What kind of awful 1980s quality storage are you using that doesn't
remap bad sectors on write?

