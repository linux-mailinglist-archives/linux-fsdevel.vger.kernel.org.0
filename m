Return-Path: <linux-fsdevel+bounces-27356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CA69608E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 13:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11901F23B44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DFC1A00EE;
	Tue, 27 Aug 2024 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eCot5GO2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2A139580;
	Tue, 27 Aug 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758659; cv=none; b=r48KuK6NsQR7qeJdm9ab5nWgkCzlucQyKQEcDbmH1YfGhdxOkQGQYZMhupVEKdzK5zctHC1ht4ip1uiRYJ6tRM7VAwzgwDQkID8k0ZjHQ+2rJ5Oy2YxUZC+dkMXmi9X3Utke4X3m+F7Xbz0V8E4C/AK9tR2nUbisLNsr1YuGXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758659; c=relaxed/simple;
	bh=bfxW13z7pEPjtKFNOU5w7SrEAs7p62DFqI5PwjfrY5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqfpKACbCDF3xV/33MxN//dwPZ2X3yBgm5FyIA+/m3QvSWaqsm+PCq+8rrvBcexIkXmPeF16nOvoZJiNvxDXhmwL7P4EY0ZP/cfKYXx0Z3XQMBglR7XAfHJHKM1XIRQ9/AwW6jdbHYeWviJUdiBhmtd+vzXwIFQodvxhIqXN4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eCot5GO2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L3QeFG63p0L9YwT0+qxyiNPTNYtWWhMBJ4I/IWsyCIg=; b=eCot5GO2WcwBf/0qRZJ2OJhGXb
	6luQFGEZlKTLbNwam765PLcvBfPmJ6apvC5T9KfObqJ1c1/cxRCl33ff7mEmNwcKB6LsXc8IHkgGK
	7So40/ip/ppHYOtI1KAQ2c01fuL75YkzKi2pIbg+Dbi3I680xlDW2Nwo39W1Qzcp3EUgKO2gCNxB5
	468xHXikV7dfKfHooeBc9Ds1xjOJtoIzB/tkEkbFdhNr4l16eBn16G+BVFCAci7HkKH+q1oDw/e15
	ZgX7lmvtGR7/0rzyo/bnaS1xji+7b6dlNSrhMMZRjbuqDjD5p+oZpmtYRhgK3kKKiOPDSUDHBe3U7
	4Mm4QnVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siuW0-0000000B2TU-0TME;
	Tue, 27 Aug 2024 11:37:36 +0000
Date: Tue, 27 Aug 2024 04:37:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	syzbot <syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com>,
	brauner@kernel.org, chandan.babu@oracle.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] [xfs?] WARNING in iomap_write_begin
Message-ID: <Zs26gKEQzSzova4d@infradead.org>
References: <0000000000008964f1061f8c32b6@google.com>
 <de72f61cd96c9e55160328dd8b0c706767849e45.camel@gmail.com>
 <Zs2m1cXz2o8o1IC-@infradead.org>
 <9cf7d25751d18729d14eef077b58c431f2267e0f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf7d25751d18729d14eef077b58c431f2267e0f.camel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 27, 2024 at 07:13:57PM +0800, Julian Sun wrote:
> Did you use the config and reproducer provided by syzbot? I can easily
> reproduce this issue using the config and c reproducer provided by
> syzbot.  

I used the reproducer on my usual test config for a quick run.
I'll try the syzcaller config when I get some time.


