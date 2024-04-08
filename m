Return-Path: <linux-fsdevel+bounces-16338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E384E89B66B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 05:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBBE281E78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 03:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF92BE6F;
	Mon,  8 Apr 2024 03:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qBIKJMM7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6681EBE48
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 03:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547067; cv=none; b=TZUG1bGNAuOK2pK7ThigvwXvSWgXG8W5wUiGl2t42Wmfu1y3OCcd44zbjdNN/ciqXVrHtf0bqsYHFE0HoCy7hF1OBZr9W/t2UzhJfDPnNyiSO8JoiC6g1N3x9TiyhmRqoDExR0yOO0V4JcSTKdQUFhzy5lfrZcw3Yy4+TA0ghwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547067; c=relaxed/simple;
	bh=VnWdE9yASeB+aCiYrchZNMlNEbfufJo8MNhQVkBAsNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC/IjcnPFWwzqtNN3D0AKzuqjXiYGAxhhkTltjXMPHaWrqHOIhggHoYYnXKjr7hsHFqEcXlsfi06SNKsROsejDBdvAdkSgHNCEnyw08MHhikTbXuzl6hsBPs99CyDctcCiSs8vM2uQljB97EPCxm/qZAnT42HVL2YmjuHBZ9i7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qBIKJMM7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mcsf8W9/Re9cutOStCl2roqZwQ75Np48svne0+rbPJo=; b=qBIKJMM7Fnalc+pOHBibxo9IQf
	oxXYvZ1c+di8vuNJQ6NTY7uzKdTOzc5l0s29jTMl08XW1XivJwlio10gZl5pTn73OSWRYkwtygssc
	anqJTHxdcFTktEm6mKsbtImK1nfMY7k1GLj8JuX5y2p9pXF/rx/XEmg6cHhVUIFTg2unjI7Im2urN
	A1vq5q36S00efxu5niltAC7kb0QAvJxooQR/r37a13of8Wxa14e0jFRDnbgzCPXmer0D7wY/DsjlT
	0tSxjpVYyU3DO8GCv3A+gIZ3xqCDyHGAbdCl1BXzLA9XgKbWsZOT5f5XMeJQKRoyV7eimq2vBS0RN
	ZzuaAyTA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtfih-0000000GYKU-2OWW;
	Mon, 08 Apr 2024 03:30:55 +0000
Date: Mon, 8 Apr 2024 04:30:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: HAN Yuwei <hrx@bupt.moe>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: Questions about Unicode Normalization Form
Message-ID: <ZhNk78RE2Bocs9ap@casper.infradead.org>
References: <AD5CD726D505B53F+46f1c811-ae13-4811-8b56-62d88dd1674a@bupt.moe>
 <ccfe804c63cbc975b567aa79fb37002d50196215.camel@HansenPartnership.com>
 <D445FB6AD28AA2B6+fe6a70b0-56bf-4283-ab4d-8c12fb5d377f@bupt.moe>
 <20240408013928.GG13376@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408013928.GG13376@mit.edu>

On Sun, Apr 07, 2024 at 09:39:28PM -0400, Theodore Ts'o wrote:
> On Sat, Apr 06, 2024 at 11:15:36PM +0800, HAN Yuwei wrote:
> > 
> > Sorry, I am not very familiar with Unicode nor kernel. Correct me if wrong.
> > 
> > As to what I have read, kernel seems like using NFD when processing all
> > UTF-8 related string.
> > If fs is using these helper function, then I can be sure kernel is applying
> > NFD to every UTF-8 filenames.
> > But I can't find any references to these helper function on Github mirror,
> > how are they used by fs code?
> 
> For the most part, the kernel's file stysem code doesn't do anything
> special for Unicode.  The exception is that the ext4 and f2fs file
> systems can have an optional feature which is mostly only used by
> Android systems to support case insensitive lookups.  This is called
> the "casefold" feature, which is not enabled by default by most
> desktop or server systems.

As I understand it, an important usecase for the casefold feature is
running Windows games under WINE.  I don't do this myself (sgt-puzzles
is more my speed), but there's a pretty important market for this.
Wasn't this why Gabriel was funded to work on it (eg commit b886ee3e778e)?
Or was that the Android usecase?

