Return-Path: <linux-fsdevel+bounces-20004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A528CC3A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 16:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AD31C21D41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 14:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135C219EA;
	Wed, 22 May 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ca4A5aCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83B22EE5;
	Wed, 22 May 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389980; cv=none; b=foVdCoM1HzEobhvsifF8LGpggeWVaj9700vLp0Wu6MXooeQ0G28WteRVdqOYGjheN72CEV0r8FsJ4JjAYwmhpaTj9a/dmmKbHupaNC1faeOOU/VUWw1kmzz9KS7ygfKv3nylJn5Fu1PtFwMbakoY6ZrD6wbSqeKORrGiNgiYiYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389980; c=relaxed/simple;
	bh=taK1R5jKS6B4fCGxzFCLE434wCi1GNNxDNuMK1l5sRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ5TqbvvZre2XyErXHcCO0nc87fHKvCD+zZIRbCUnpYZzVeVruwCo61iL2WrK8/sEReZKaFJESSdU66fMUttlnqyqKSrWj1odfryvnTcP0CAbkO2scv9U4rb9xmz1AUlYY8YvmtOG+TIH5vPGduk6IjrDqjdz/Yr15kf6dloqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ca4A5aCk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u2+ROOHYbkCaIa0leCLabsPb6B7hDNDjI6pFITeWd6A=; b=ca4A5aCkkcOqMvTo1iBrEAKAXC
	vnzUjoJj7fWA/n0wodKzJBZCYbq+MYO67wUupXdDXIQwTHOihB6Mt+QASIv+pbZqLNFRcMESZSZZb
	YQEHw+V49/xvQrVphkrS4SqABj0isfUUQ0RpfXZ5LY/U0dXm7E/5iph8ts8gyzWOT2vZbS19Kovd0
	X7/qpW7dQQpTmj889a02Ln4UDGMe4y+ywMvX2H5s9gaHNRqKKOzfrKAEFLabt3+UWjlrfZxqbvYRK
	EsbdR+n2SH/LLoyufLZteCHHjwgWnKwO4YaSlFescAXX0As4V4EtheQ6jIHtaSare6t3sNFqxo9bI
	qOoh2p+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9nRH-00000003Hvb-2vFW;
	Wed, 22 May 2024 14:59:35 +0000
Date: Wed, 22 May 2024 07:59:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm: swap: print starting physical block offset in
 swapon
Message-ID: <Zk4IV53Q_fyx9Vx4@infradead.org>
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
 <20240522074658.2420468-3-Sukrit.Bhatnagar@sony.com>
 <20240522145637.GV25518@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522145637.GV25518@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 22, 2024 at 07:56:37AM -0700, Darrick J. Wong wrote:
> On Wed, May 22, 2024 at 04:46:58PM +0900, Sukrit Bhatnagar wrote:
> > When a swapfile is created for hibernation purposes, we always need
> > the starting physical block offset, which is usually determined using
> > userspace commands such as filefrag.
> 
> If you always need this value, then shouldn't it be exported via sysfs
> or somewhere so that you can always get to it?  The kernel ringbuffer
> can overwrite log messages, swapfiles can get disabled, etc.

Scraping a block address from anything is just broken.

Wher is the code using this?  It needs a proper kernel interface.

Same about the warning crap in patch 1.

