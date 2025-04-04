Return-Path: <linux-fsdevel+bounces-45737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A7CA7B944
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF853B6C06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87D1A5BA1;
	Fri,  4 Apr 2025 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m7mnnprV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A61A2860;
	Fri,  4 Apr 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756435; cv=none; b=In/mTAUVb2bGizcbOeYpWQIO1I5PVtPL3hT+XsSrrQBIUXhCcZoelWsBz5xTNC3Sy4alZSxF7uFxCKJ2Bsas7PKvk/p1kE6YXTsTMQOxqkM68Ec1Y9xWLkTw2UBhmsNiiP0ymoyuEU37S206us6uzpldkbOPsdiua40Iu5xixsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756435; c=relaxed/simple;
	bh=ziIQO7MWdLztkFvmB4xoAMEoz2Kom54ZCtFmMTKbnbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCJcaj2QaoshAs63OMgYLbtnQrUZkDHwG0l9Q7NYhVncEJsXpDZ9m8gCnOS3s4Ja9/M5n5esUH8OUg6aSF+RsE8JeGgrL6zrcQ0s9GQ/y9zJgOUJeIzGQz7+nbpNlIkCd47n8xmlCUL+7Y9xcRmKidNYHysySQhnKqAHIiR5/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m7mnnprV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7pMLgG2YqPKl7LGVIhcYLYGPaax5GwvFYOF3tJvraJM=; b=m7mnnprVNawItI3WeoW5CLczjE
	S9u/8boj1T9eS6Gjszu8woC9FWhyl1dBq6hcQgkwTDcckM4qXk3xbgkY0TFRBqDqlWBPTIafyODDH
	+I+0wPZ2M1ZXPGAzhl4aj6YWvpI6yfUZH5Zc+KjNHSTtMJsrS2HGfCSAN3A+8VXmb7wgt3KVuJN8Q
	JD6uft052+sZzAos9oyx/n7hqQn3mBxVf/ov8oOl5PxNwY4fE9YQKmJKtKpq9yKbVaHPgd26sM8YW
	y3HWmTHeclQwaTHeuFhjJ2vvsq6EDRp4m1bigxw2U9nWdLXbLqY9h4Lv4UwHUUoIwr+FdAyLOguwF
	nGr8j7+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0chk-0000000BBd6-2TY8;
	Fri, 04 Apr 2025 08:47:12 +0000
Date: Fri, 4 Apr 2025 01:47:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Penglei Jiang <superman.xpt@gmail.com>, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] vfs: Fix anon_inode triggering VFS_BUG_ON_INODE in
 may_open()
Message-ID: <Z--ckIgXpv_-tE1l@infradead.org>
References: <20250403015946.5283-1-superman.xpt@gmail.com>
 <Z--Y_pEL9NAXWloL@infradead.org>
 <20250404-kammer-fahrrad-516fe910491e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404-kammer-fahrrad-516fe910491e@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 04, 2025 at 10:45:43AM +0200, Christian Brauner wrote:
> On Fri, Apr 04, 2025 at 01:31:58AM -0700, Christoph Hellwig wrote:
> > Please make sure anon inodes have a valid mode set.  Leaving this
> > landmine around where we have inodes without a valid mode is just going
> > to create more problems in the future.
> 
> We've tried to change it, it immediately leads to userspace tools
> regressions as they've started to rely on that behavior because it's been
> like that since the dawn of time. We even had to work around that crap
> in pidfs because lsof regressed. So now, we can't do this.

Just because i_mode has something useful, we don't need to report that
to userspace.  We can still clear kstat.mode (with a big fat comment
explaining why).


