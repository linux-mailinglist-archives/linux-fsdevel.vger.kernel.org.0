Return-Path: <linux-fsdevel+bounces-29223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8219773F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A241C2435C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFDF1C2DC4;
	Thu, 12 Sep 2024 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vszIJZK+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0B1C2431;
	Thu, 12 Sep 2024 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726178106; cv=none; b=FloG09G/pPKa3q3QwffcMZKXgG7Ru59nm6fuDbUWVxh6AiXSSoluU2xDPl8uoIJVK4roJttVYyC4D2lfLaKrXXfsP+QDcuv2DbUORWB+NeePd0fxxGfj6sPcTNAwgaIS4FffJ3uboJda9TZ//XwqhbWF8m+54VUl49eUdu8dTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726178106; c=relaxed/simple;
	bh=BJkbHY6JbGdmJVgjgCtDgEFzhpZTISMmJWx/J84BNvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzVpaES5SVVdmWmGuGfsJNv+PEh5ScmV+bpsKBk39Wmp/mJ9FzqsKHGIqpaFd34i1sFZcqPChAJPIFfmJgbEgJTP47SZP5pUjXnTqKpnrEYAYzcOxMpFui2jJ0c3um3aI9hnQ6wX55u/+ewleTriodWEPCWq9KwG+L/XjFhA8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vszIJZK+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GnfPyNgu0BILt09ywPU879XMla3butlw0lEC9CUtWzk=; b=vszIJZK+Jvdrtrizior1yTTJ2u
	rlSnrzJnL9q2dvdMvWwzLpMBqr7nZrPLok3EEzuY052thHL6X1OfTo2AJyd+qoXDIZkj7p6kq+Dy+
	4kAczS5IUk/PozZij9/cX92sMmkn9DGnYy/Pkm/Y35meuZVwooU/6I75JM4I9JP/Ukeiq5MqBivos
	XAgxlZKGblo85rJWpR9gEAM+JAr/6tfUAhAIRpNsuX0tMJVeOWZk05dyjsznMpmKwA8g/SvS69l0C
	qJqfii+DAS7LeR7mt6YbnLd8CLuAiO5eXcc4VqpElgF4KxmWju7IrZD6yi6FtAW6tpZzwVx98J23F
	6HCczzJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sormG-0000000BONF-2X2q;
	Thu, 12 Sep 2024 21:55:00 +0000
Date: Thu, 12 Sep 2024 22:55:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Theune <ct@flyingcircus.io>
Cc: linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, axboe@kernel.dk,
	Daniel Dao <dqminh@cloudflare.com>,
	Dave Chinner <david@fromorbit.com>, clm@meta.com,
	regressions@lists.linux.dev, regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZuNjNNmrDPVsVK03@casper.infradead.org>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>

On Thu, Sep 12, 2024 at 11:18:34PM +0200, Christian Theune wrote:
> This bug is very hard to reproduce but has been known to exist as a
> “fluke” for a while already. I have invested a number of days trying
> to come up with workloads to trigger it quicker than that stochastic
> “once every few weeks in a fleet of 1.5k machines", but it eludes
> me so far. I know that this also affects Facebook/Meta as well as
> Cloudflare who are both running newer kernels (at least 6.1, 6.6,
> and 6.9) with the above mentioned patch reverted. I’m from a much
> smaller company and seeing that those guys are running with this patch
> reverted (that now makes their kernel basically an untested/unsupported
> deviation from the mainline) smells like desparation. I’m with a
> much smaller team and company and I’m wondering why this isn’t
> tackled more urgently from more hands to make it shallow (hopefully).

This passive-aggressive nonsense is deeply aggravating.  I've known
about this bug for much longer, but like you I am utterly unable to
reproduce it.  I've spent months looking for the bug, and I cannot.


