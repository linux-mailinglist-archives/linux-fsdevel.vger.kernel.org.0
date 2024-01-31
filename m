Return-Path: <linux-fsdevel+bounces-9618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F14E843633
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 06:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B47A28A800
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 05:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2E13DB92;
	Wed, 31 Jan 2024 05:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cE/36VbY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5143E468;
	Wed, 31 Jan 2024 05:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680065; cv=none; b=mVL0719VYK4CUpCv4iG2KHTBxCdK2Z6FrhhDbfQIqFIKO9H6PCaFcb/TrlRHhqVT4XDP0fqZrUiSjeMnJ+H1f0QcU31gPRbQlKdi6q+FacXu2XiS41ap0IrPvINcCSjobI3KYkKijtBCCWTBteYbCxLo2aYm4S0O5pf0XgAarb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680065; c=relaxed/simple;
	bh=F6moQ6b9hiDMnR0QCy3aTXiISPhYTzA0ruzY3ud/4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCu8Y5b/ZrvI++veomxsG7f1RvYUdEnb8EnaVJyrdI5QeqiCv53peqAKCDShZbZzjplInKlq+dxxbXJ7tZNeiPvrNVbBICyGCXNCyM+O3T2uUYLrnnrCuxvNfU6xCFVWrxjlc+bgmjhq/4uYVO+lwzZzBDI+OU8Dj4FmFhz/3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cE/36VbY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jk7WOZDUvIYW2PjF8VD17+BgmLnTpAIrlDYLakGFvFE=; b=cE/36VbYtZ0pze2of8EvkDAQ/8
	D10bqRlYDzXeaaWU+/7Bb5Q0KTCPtFrrsWW94+I3M38KcBfenFc19xlfbFOQantxHu643P/RNXMDH
	dCX+o6WmoNA2BCwEWS8Zk3cF53kvYnM5decKvTNWzbu68DI7PF/vbY0v3QvOHA7kSoM0tTr11GXUc
	iiQsM4UTN/su7ZB9pMGLknezdjuNDBqXN9IUHHIiE5LVTFGsOGKuHn8nR4EWCogq4iRiucu/CPjsm
	fwXc7hDl30TPNyUdweYsrsryGrwaJkLVF/Zy+VNsHxp2sIm5bi0o90Gjw4hkHL0S8DsSS7SR4A+XQ
	JaUdThsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV3Rl-00000001ZKH-26eL;
	Wed, 31 Jan 2024 05:47:41 +0000
Date: Tue, 30 Jan 2024 21:47:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>,
	syzbot <syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com>,
	adilger.kernel@dilger.ca, chandan.babu@oracle.com, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: current->journal_info got nested! (was Re: [syzbot] [xfs?]
 [ext4?] general protection fault in jbd2__journal_start)
Message-ID: <Zbne_dN3i85JjPxw@infradead.org>
References: <000000000000e98460060fd59831@google.com>
 <000000000000d6e06d06102ae80b@google.com>
 <ZbmILkfdGks57J4a@dread.disaster.area>
 <20240131045822.GA2356784@mit.edu>
 <ZbnYitvLz7sWi727@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbnYitvLz7sWi727@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 31, 2024 at 05:20:10AM +0000, Matthew Wilcox wrote:
> I'd suggest that saving off current->journal_info is risky because
> it might cover a real problem where you've taken a pagefault inside
> a transaction (eg ext4 faulting while in the middle of a transaction on
> the same filesystem that contains the faulting file).

Agreed.

> Seems to me that we shouldn't be writing to userspace while in the
> middle of a transaction.  We could even assert that in copy_to_user()?

That sounds useful, but also rather expensive.


