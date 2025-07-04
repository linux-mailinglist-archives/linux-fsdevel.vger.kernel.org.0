Return-Path: <linux-fsdevel+bounces-53875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D06EAF856B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 04:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D417E1C84934
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 02:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B411A4E9E;
	Fri,  4 Jul 2025 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sI/rU59H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708542869E;
	Fri,  4 Jul 2025 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751594633; cv=none; b=nq+nYp6sF+UWdaUY4zP3PHaPmn2qacuDd75kfX8SRQ3bVem/zmQtGm/ctpVfgTilkp8ms+Gz83fcNYW4OXnC1mmaUHQsl/WBtgzRQVuTi0G9cIGVQ3FGwmMN3gtOnfQOaVt1W+AstSb6u3lQVRqH0k9gLhMUUIkAn29zCFoJOgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751594633; c=relaxed/simple;
	bh=epro97/CzykWe2P0Kc/c1P/hEUsL/QzbIYjMBiV1Xpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZppMlpALCgieWMT03+40bb24mE26Cs+RBwVAUaBwagAoRWvpn/GxCVCU02W0uhsrJJRfynBjs+EHXmOZlpUbpA0B7CjtSm6XIyFhHIMHBtpS+LRe1lfzlF8cTayMG0jsOzcyWyO74atD+sBPBQMnRP96giMCc3o3LnEulIK2q1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sI/rU59H; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=paXUcMhFn9asEXi9y0KMo+HqPmeYpQViJhvuLWWzFwQ=; b=sI/rU59H1SoHjRaxYzGvhZda+M
	KPA/jAXyo8ddFqALS8uHmEq16PPeT/uBqicjkDpKEXSFS61mAv8923dFUNqPLe2FcEXzAEH94yeV2
	rHlF76NyBHKxf78FusJjNLARnl3qe0zA+jweqLz2lI2+Fz2ORsKgpVYKYkuKBBiLwXEjs5ZisFubH
	CUsPliNKQ8v9julzZJ/im//fEO7N4BOFF/11u9KC/5Qmb188aInHkvMD1GDveN5E+PWtJdBchFlDu
	WNCFitH8US27CWZ9qtVBEJG6K/vmXY+KL728hks+w/7rstQ1SX8amlRGQDvM8tjCtq6FZ8SqwoStJ
	4sCtVkhQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXVmG-00000008G5m-2zQc;
	Fri, 04 Jul 2025 02:03:48 +0000
Date: Fri, 4 Jul 2025 03:03:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3?] proc_sysctl: remove rcu_dereference() for accessing
 ->sysctl
Message-ID: <20250704020348.GN1880847@ZenIV>
References: <>
 <20250703234313.GM1880847@ZenIV>
 <175159315670.565058.128329102948224076@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175159315670.565058.128329102948224076@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jul 04, 2025 at 11:39:16AM +1000, NeilBrown wrote:
> On Fri, 04 Jul 2025, Al Viro wrote:
> > On Mon, Jun 16, 2025 at 12:49:51PM +1000, NeilBrown wrote:
> > 
> > > The reality is that ->sysctl does not need rcu protection.  There is no
> > > concurrent update except that it can be set to NULL which is pointless.
> > 
> > I would rather *not* leave a dangling pointer there, and yes, it can
> > end up being dangling.  kfree_rcu() from inside the ->evict_inode()
> > may very well happen earlier than (also RCU-delayed) freeing of struct
> > inode itself.
> 
> In that case could we move the proc_sys_evict_inode() call from
> proc_evict_inode() to proc_free_inode(), and replace kfree_rcu() with
> kfree()?

proc_free_inode() can be called from softirq context, so we'd need to
touch all sysctl_lock users for that.  Definitely a larger patch that
way, if nothing else...

