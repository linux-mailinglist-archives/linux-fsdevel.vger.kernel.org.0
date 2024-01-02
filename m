Return-Path: <linux-fsdevel+bounces-7129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF92821F82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911691C2251A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC9C14F91;
	Tue,  2 Jan 2024 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AF5FmNad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8155814F6D;
	Tue,  2 Jan 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yll9ik5nj/RKHcc0X7snHFL6YFsTYxSrnn00ighgwfI=; b=AF5FmNadQ4yqLEuhUY/zMGTyPs
	KmYUrp2TmS7ASCybxrFRTFo/XULYv8YOqGtE+7du+cJbNb98QyqgZ/wvX7vMGwxzngrg+9PpOeuYX
	TO6HrcMaTP+JnPLn9AJJ2sM8x1/xXQmIWbQFd+Fkqk1ShR8jehEi1jj9/AZwZRHESHNdNrK7JpV5C
	1ilSKnKVIJ1KQJYbBe2aUd5JDdV6FT8v/msk4l2U/5pZUVmTWkql5ZATnRPEH5HEk6yED1XCHp2dQ
	AjJWvYtkEst8W//mwWyPinKVTBmDb/KHcRqyWcj0uYJ9DBr+xW1e2Zqx4kOkrGk1Oc52l2Ql7tkCP
	a3TRSgiA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rKhdE-00AfG7-3t; Tue, 02 Jan 2024 16:28:44 +0000
Date: Tue, 2 Jan 2024 16:28:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2/2] virtiofs: Improve error handling in virtio_fs_get_tree()
Message-ID: <ZZQ5vKRcq9kkQxSD@casper.infradead.org>
References: <c5c14b02-660a-46e1-9eb3-1a16d7c84922@web.de>
 <5745d81c-3c06-4871-9785-12a469870934@web.de>
 <ZY6Iir/idOZBiREy@casper.infradead.org>
 <54b353b6-949d-45a1-896d-bb5acb2ed4ed@web.de>
 <ZY7V+ywWV/iKs4Hn@casper.infradead.org>
 <691350ea-39e9-4031-a066-27d7064cd9d9@web.de>
 <ZZPisBFGvF/qp2eB@casper.infradead.org>
 <9b27d89d-c410-4898-b801-00d2a00fb693@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b27d89d-c410-4898-b801-00d2a00fb693@web.de>

On Tue, Jan 02, 2024 at 11:47:38AM +0100, Markus Elfring wrote:
> > Do you consider more clarity in your argumentation?
> 
> It is probably clear that the function call “kfree(NULL)” does not perform
> data processing which is really useful for the caller.
> Such a call is kept in some cases because programmers did not like to invest
> development resources for its avoidance.

on the contrary, it is extremely useful for callers to not have to perform
the NULL check themselves.  It also mirrors userspace where free(NULL)
is valid according to ISO/ANSI C, so eases the transition for programmers
who are coming from userspace.  It costs nothing in the implementation
as it is part of the check for the ZERO_PTR.

And from a practical point of view, we can't take it out now.  We can
never find all the places which assume the current behaviour.  So since
we must keep kfree(NULL) working, we should take advantage of that to
simplify users.

