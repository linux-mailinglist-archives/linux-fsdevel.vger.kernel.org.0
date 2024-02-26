Return-Path: <linux-fsdevel+bounces-12806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FD286763F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 14:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBCF285C80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02457126F1A;
	Mon, 26 Feb 2024 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JDUG+fLI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2B67EEE6
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953415; cv=none; b=joMXnCn4fiB+YhjTq6huBNnPWJPMX8Cr8AKgIDX5ke9PcRNmPzPKDClKEatDRoySm0dGkijyFjrhcP+tPjpUBCwNVQ8Nr5Vg2XvKgoEayx7NHCsa28mb8gVlBpHV5NGh5UJuSkQUS3odwQ5UKxXE3aP9SWZo9JCB5h1oJunr/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953415; c=relaxed/simple;
	bh=1vO1dAi+EoUTRIxUQv54xnsRj5TDUFErd6CjZk/aZOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn5pgnRsgEBlWsEdeIGZniZndxkaTguRUKRJ72O+DrfgV1hk470XGmvD29eNsMmZBQ/Zoo/yj4k6bgQdxR0HYMMjkPs35klJR3WAmIweLzxsGAguT15G/+jsidOznv/4Q++WeO6CMZTBLKabatmoaxcJ+zb8dKMzCXkJ9F0lTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JDUG+fLI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1vO1dAi+EoUTRIxUQv54xnsRj5TDUFErd6CjZk/aZOk=; b=JDUG+fLINH+jpZ7FWk+O3sH/Dm
	a1REE/SHPym9PSCcLJ+zrSL8OyLRBEBSIsOd0t9xbCKXH64c9DpBsbfO7D0HsZrUxQR4Z2UlmpfXI
	E1Mb58Nig+zEaT7KvawDLTqDqc3nbEgwpOs7OagDiux+xVK0xgstPku8Fz/iuFwsA3qM759I1L+Gn
	bAuumbdzddRsPReRCtR5LE9YtRUhw48W08CrWFUdRmeBSqgL0WAZJXk/ojRhj91OdYG3IcPlFesWy
	A+I53lCS/s9M/WXnq8XBA0V7I3FewNifc/jGMMruCxgesQvqxEmc8/AJFFRQ1ZC6v9x0WuTAAabYR
	wC3fpMfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reaqc-0000000HDxg-18kl;
	Mon, 26 Feb 2024 13:16:46 +0000
Date: Mon, 26 Feb 2024 13:16:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: Add reclaim type to memory.reclaim
Message-ID: <ZdyPPiEykhffDEJZ@casper.infradead.org>
References: <20240225114204.50459-1-laoar.shao@gmail.com>
 <ZdwQ0JXPG4aFHxeg@casper.infradead.org>
 <CALOAHbCaBkqZ1Z9WJ_FqjTkzvCOv2X0iBv9D=M2hkuEO4-8AeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCaBkqZ1Z9WJ_FqjTkzvCOv2X0iBv9D=M2hkuEO4-8AeQ@mail.gmail.com>

On Mon, Feb 26, 2024 at 08:34:07PM +0800, Yafang Shao wrote:
> Additionally, since this patch offers a straightforward solution to
> address the issue in container environments, would it be feasible to
> apply this patch initially?

There are lot sof other problems with this patch, but since I disagree
with the idea of this patch, I didn't enumerate them.

