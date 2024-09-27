Return-Path: <linux-fsdevel+bounces-30211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8785987CC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 03:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 023C5B21042
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 01:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D723F166F32;
	Fri, 27 Sep 2024 01:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cXdoxNmd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC44139D04;
	Fri, 27 Sep 2024 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727402176; cv=none; b=ju1ip3zMrHo7RdQD2mZg8svu0pUL8d/f3YNFzKg9balz3D8Qf/5IL+A/AY6E2ppLtJ7FUaCfrPVkx2urWFfAyrkNuWnGN+sACfX2jF8fw/m57nssLD+pdRiPkajAr8CDTcWM6F0cZnVRLqlGLdi2n3Fczvd79FpW8f1gdbAQ/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727402176; c=relaxed/simple;
	bh=ncoRFY8uh8Mcll71lsrLV3hAG3+Z6uNOuYcscTQA4+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YRIrjb2RR1hPeIQXKFNtZA/3fJZUEwqKZhdsCGoiB4yONTHrB0WIFksLs5xxeyhEc6TKwy+qMdNot5AmwKdLttFF4a42FWylxENnppn3sQ/8y1b1QEjhqFUmg5Eonuvr2bc1BIB841FypkyLNM9yvl6hnrBzypwblzwSS5UMJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cXdoxNmd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=akB9JoRv18U9cgJ4MunbjCcH+dfMeNfJaDufYgRIIdY=; b=cXdoxNmdsJh0q8qEH9PujgudJy
	0tKKAhs33nn79i5DtJaokcJvxlTdtT7WP9HmvZm577SXk6OyGosRAQrbuE9zal1jvwk+TNUq8OOCU
	D26J753Q8DzewzLUnnVg5UtCGsAMlr1p2SZqz49BNQEvbkpvrQkSkasNJMPC8ggP+8IuD3kXksnxK
	ZIFUUgr11CMA1yioMzmmygE1+Q3/vqbBo0qvTX6D6LHqcZoXSGU3ROAXkCJoTsMYgrjOOJAKAoxL2
	7KetstVIrlBNgjSDjI1VO9783258ew+jdPrPXDmggnhv9EOOz2omAqBUceT+s91jc+DBwXoRSBFt1
	zvG+LQFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1su0DL-0000000FqUU-3An3;
	Fri, 27 Sep 2024 01:56:11 +0000
Date: Fri, 27 Sep 2024 02:56:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [tree-wide] finally take no_llseek out
Message-ID: <20240927015611.GT3550746@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	no_llseek had been defined to NULL two years ago,
in 868941b14441 "fs: remove no_llseek".

	To quote that commit,

At -rc1 we'll need do a mechanical removal of no_llseek -
git grep -l -w no_llseek | grep -v porting.rst | while read i; do
	sed -i '/\<no_llseek\>/d' $i
done
would do it.

	Unfortunately, that hadn't been done.  Linus, could you
do that now, so that we could finally put that thing to rest?
All instances are of the form
	.llseek = no_llseek,
so it's obviously safe (run the script, look at git diff and see
yourself).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

