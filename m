Return-Path: <linux-fsdevel+bounces-19245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778008C1D7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 06:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C91CB22635
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 04:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CB114EC57;
	Fri, 10 May 2024 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Wws8dFc5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ABD20309;
	Fri, 10 May 2024 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715316496; cv=none; b=ZFJ8BLnPtNxVwqEY9N6QTz76M+D+Nn495q1MMZZul7dTFSbB19fHbzQF3OTbsAI85tf30wAVBF51KbryaRPgijp9xgXSCpGHejlwNGPo4bZvsSuHtIYqYfi9EhkWMEU+PC3tlBNzv9AT7mykPVbz2LI5iNfdEx2Kxmt25grRj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715316496; c=relaxed/simple;
	bh=OixUejj2noa/W3WcINTvjh/Srj4k4t4XGVgiozW4yig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqiMWExIYIRclv9zhwU0OOeBYvrqwq/0Db8Puw6rHIKep5HzkseYncYP5p66CkVbskOHU1uoQ/CZFhz5izvMNs+e+3Uhgebod1SWifB7XjlQNtiEpHFVcq3ysRP68a7Zm6bhwnS/s+d1ZG1UpKPm4NRcDLP9gQC+vqz7V5QP/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Wws8dFc5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dhiDhhEwm20W3AdRoKjizM2sEfdCHCLz0s2eBCvTzLU=; b=Wws8dFc5amGeAFtmtxE8TNKNRL
	g8RnK6XUw51MXBROvF6diEzl9Wp7yRkTMc/K9z36VoPWnq8Rs2HpxmGyqWjG5nN/Z2aUTnQkJn3BG
	9UpnfF0v5uEAUEPgjcEdgnHM1K2zgPEuKx7M8dF4V1li6hIIgeBOgMiMlaILkaWcMWA3esLrgpdPA
	LKsrQ7ZBoK4V826Ga1jMd0UUJsidR9bpWdjjbvRNYFi6vooDdOrEJ04stmSDCZYL6YONC78hidUI8
	ukgFqJFixMMh+CqUW+L8QjzGqvaG7yFhycMUdZu5jOixB2B+A9Kh3BV27Y1yHj+kN82R1SkkvITV5
	qc2u7cGA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s5IAv-0024NI-2W;
	Fri, 10 May 2024 04:48:06 +0000
Date: Fri, 10 May 2024 05:48:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Justin Stitt <justinstitt@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] libfs: fix accidental overflow in offset calculation
Message-ID: <20240510044805.GW2118490@ZenIV>
References: <20240510-b4-sio-libfs-v1-1-e747affb1da7@google.com>
 <20240510004906.GU2118490@ZenIV>
 <20240510010451.GV2118490@ZenIV>
 <6oq7du4gkj3mvgzgnmqn7x44ccd3go2d22agay36chzvuv3zyt@4fktkazj4cvw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6oq7du4gkj3mvgzgnmqn7x44ccd3go2d22agay36chzvuv3zyt@4fktkazj4cvw>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 10, 2024 at 03:26:08AM +0000, Justin Stitt wrote:

> This feels like a case of accidental correctness. You demonstrated that
> even with overflow we end up going down a control path that returns an
> error code so all is good.

No.  It's about a very simple arithmetical fact: the smallest number that
wraps to 0 is 2^N, which is more than twice the maximal signed N-bit
value.  So wraparound on adding a signed N-bit to non-negative signed N-bit
will always end up with negative result.  That's *NOT* a hard math.  Really.

As for the rest... SEEK_CUR semantics is "seek to current position + offset";
just about any ->llseek() instance will have that shape - calculate the
position we want to get to, then forget about the difference between
SEEK_SET and SEEK_CUR.  So noticing that wraparound ends with negative
is enough - we reject straight SEEK_SET to negatives anyway, so no
extra logics is needed.

> However, I think finding the solution
> shouldn't require as much mental gymnastics. We clearly don't want our
> file offsets to wraparound and a plain-and-simple check for that lets
> readers of the code understand this.

No comments that would be suitable for any kind of polite company.

