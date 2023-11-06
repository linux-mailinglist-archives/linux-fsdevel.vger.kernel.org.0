Return-Path: <linux-fsdevel+bounces-2155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2061B7E2BA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 19:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81899B21214
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A922C865;
	Mon,  6 Nov 2023 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p3TGXWkI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357018035
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 18:08:39 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E294
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 10:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j5OST9jzsK2inebKt2PrF+eoLsFk25qHEykVZ3vVgnQ=; b=p3TGXWkIvmSqnWNFSANXCyE62+
	Xy75IwXujOhQWUFLi+KJirvw+XECMz+U7gtuOGZl0tCjSD5Zdmi4iId2kqBMDzBEhRttq1BUgK/1p
	tYAvwOc+EpVu7339WNusINXD747ENQEglkeaROWBERcEu6cVUQI++nQfQs5iSwGCxuRfL3YH9vWSK
	Wyq6YQVjWkAIYnNtCRwCsmtpCH2/+HcAUgFUwEOSz+FmtcTboOBzOPHy/m6NJwoBM55mmMUA4mD3T
	NqJ91+WwyRL4ptY0XnWQeHceNetUcxh15MjZP8oxnm1amuqgKQdpbrNurOesQrrOzYg8ROl8ujtAK
	IzabqDuw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r041X-00C8OG-2u;
	Mon, 06 Nov 2023 18:08:32 +0000
Date: Mon, 6 Nov 2023 18:08:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: make s_count atomic_t
Message-ID: <20231106180831.GU1957730@ZenIV>
References: <20231027-neurologie-miterleben-a8c52a745463@brauner>
 <20231103081907.GD16854@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103081907.GD16854@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 03, 2023 at 09:19:08AM +0100, Christoph Hellwig wrote:
> Same feeling as Jan here - this looks fine to me, but I wonder if there's
> much of a need.  Maybe run it past Al if he has any opinion?

[resurfaces from dcache stuff]

TBH, I'd rather see documentation of struct super_block life cycle
rules written up, just to see what ends up being too ugly to document ;-/
I have old notes on that stuff, but they are pretty much invalidated by
the rework that happened this summer...

I don't hate making ->s_count atomic, but short of real evidence that
sb_lock gets serious contention, I don't see much point either way.

PS: Re dcache - I've a growing branch with a bunch of massage in that area,
plus the local attempt at documentation that will go there.  How are we
going to manage the trees?  The coming cycle I'm probably back to normal
amount of activity; the summer had been a fucking nightmare, but the things
have settled down by now...  <looks> at least 5 topical branches, just
going by what I've got at the moment.

