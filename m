Return-Path: <linux-fsdevel+bounces-8232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B228312C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 07:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CCCB21307
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 06:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3E1B664;
	Thu, 18 Jan 2024 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lkcvKH7G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10003B641;
	Thu, 18 Jan 2024 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559975; cv=none; b=njRKhvWACXjfOxt1RSvT1RGUqA7S1jcBKiO9kZ5qoOtw8UgQGl2DJy/HjeG+v84iWPLDlUgm29rSBy41LqEye//8JmUVYHMW8eltAxx+w6pAPsLuVLci7ML1sKyeZ4ydmfMMuBCrlQm16crQd7ujwFk4mQCEDCkFdnWxJB+ANxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559975; c=relaxed/simple;
	bh=hAs1CBP9nFp8fRl6ScKq+dk9sf0olGP7j0lB4yh74M8=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Sender; b=bdWZIeWHwLmtV4SsvYUd8ce/XHYjJ5dW4AEcxSsFjXDtPAketG/1nlVReckM6z+OjMM9VcqwNuEHj56gWNEJFOQDKFbUGJ5kf8miTMA76k97+KWH0IbnC0Og42EzB5pCFYkD918xV39AWf861pAmBdLtba7/fM+vulX1INTX6sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lkcvKH7G; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lYRMfUzWNzw81gXqLF5QlOfs0HjHhZ6pKn6BffNqfhc=; b=lkcvKH7GoVwPjGtbf7e+tO8FQW
	mIsDfPwOm9F0uNQ7QvTOwfjyLv/dBGf6C2HVe+hShpfI2XcjMRO4X4QKD81DwqCNTWasRxe/cja0P
	8fNpLr8jBK/jMMv2wzx0jRjL++OAKxk08/wMF8s1hxMvMJg55LRCMq/raPoc4t6ETB1pS2/6Smn4t
	0RdtXPTMFIDuDxZvMRqmF5maXSOimH65QDXq9l50os+8KvcaWbMl1OzEU/fP0L10T/GDg2TPYB79O
	r96sgIj9ml3UL9juGuAiywZwW63ZNnEtF4xUDrdYLRMxrkjDRYOqmj5KBLzqwrWUsEHe2dIb00jqp
	8jz880/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rQM3n-007HUj-00;
	Thu, 18 Jan 2024 06:39:31 +0000
Date: Thu, 18 Jan 2024 06:39:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-xfs@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: Re: [BUG REPORT] shrink_dcache_parent() loops indefinitely on a
 next-20240102 kernel
Message-ID: <20240118063930.GP1674809@ZenIV>
References: <87le96lorq.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240104043420.GT361584@frogsfrogsfrogs>
 <87sf3d8c0u.fsf@debian-BULLSEYE-live-builder-AMD64>
 <874jfbjimn.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jfbjimn.fsf@debian-BULLSEYE-live-builder-AMD64>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 18, 2024 at 10:59:06AM +0530, Chandan Babu R wrote:
> On Thu, Jan 04, 2024 at 06:40:43 PM +0530, Chandan Babu R wrote:
> > On Wed, Jan 03, 2024 at 08:34:20 PM -0800, Darrick J. Wong wrote:
> >> On Wed, Jan 03, 2024 at 12:12:12PM +0530, Chandan Babu R wrote:
> >>> Hi,
> >>> 
> >>> Executing fstests' recoveryloop test group on XFS on a next-20240102 kernel
> >>> sometimes causes the following hung task report to be printed on the console,
> >>> 
> 
> Meanwhile, I have executed some more experiments.
> 
> The bug can be recreated on a next-20240102 kernel by executing either
> generic/388 or generic/475 for a maximum of 10 iterations. I tried to do a git
> bisect based on this observation i.e. I would mark a commit as 'good' if the
> bug does not get recreated within 10 iterations. This led to the following git
> bisect log,

> # bad: [119dcc73a9c2df0da002054cdb2296cb32b7cb93] Merge branches 'work.dcache-misc' and 'work.dcache2' into work.dcache
> git bisect bad 119dcc73a9c2df0da002054cdb2296cb32b7cb93
> # good: [6367b491c17a34b28aece294bddfda1a36ec0377] retain_dentry(): introduce a trimmed-down lockless variant
> git bisect good 57851607326a2beef21e67f83f4f53a90df8445a
> # good: [ef69f0506d8f3a250ac5baa96746e17ae22c67b5] __d_unalias() doesn't use inode argument

Lovely...  Could you try to do the following:

bisect from 6.7-rc1 to work.dcache-misc; for each of those revisions
	git worktree add ../test HEAD
	cd ../test
	git merge work.dcache2
	build
	test the result
	cd -
	git worktree remove -f ../test
	git bisect {good,bad} accordingly



