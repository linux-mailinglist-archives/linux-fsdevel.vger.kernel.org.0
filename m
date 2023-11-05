Return-Path: <linux-fsdevel+bounces-2031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C7E7E1716
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 23:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D5428132F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244D518E24;
	Sun,  5 Nov 2023 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="H9riKP84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3918C3C
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 21:59:56 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0430E1
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 13:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MuHnp9Pxg+A1VocflGHE5/xz0t19ZtAEvC/vZ4i0wwU=; b=H9riKP84sg95Le+9b0NFpUppa/
	TSZWZyBnvdpP0UUkeYgUlual/DGe41dhend9tL+a550NL9B3wgrzU4QIzjXTvhzQDU1KDUrVe5U8y
	xPsr9PeO/og1B+ljwtCelEiX0PaUkwZzbiUqkJphP/jiFDE77/HYx4tuCJew4//0YyH5KR+Oh0hbr
	uJFAR4Upwr4B9YVqy9pgD1VCGyL0DrYWpyaypnoKFODJ8EdjtcPSGYrerwMA9UDfLnYuHmuTOWliQ
	8At7xdR2wPn1JDaVmd+9IKfqJskOn8jK8XPTX0q96yBp97MWKkzHuPYD1aTNaNpALJHSJTCst5f6H
	08nMZ2NQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qzl9m-00Bh8A-1J;
	Sun, 05 Nov 2023 21:59:46 +0000
Date: Sun, 5 Nov 2023 21:59:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231105215946.GQ1957730@ZenIV>
References: <20231030003759.GW800259@ZenIV>
 <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <20231031001848.GX800259@ZenIV>
 <20231105195416.GA2771969@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105195416.GA2771969@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 05, 2023 at 07:54:16PM +0000, Al Viro wrote:

> 	* have shrink_dcache_for_umount() mark the superblock (either in
> ->s_flags or inside the ->s_dentry_lru itself) and have the logics
> in retain_dentry() that does insertion into LRU list check ->d_sb for that
> mark, treating its presence as "do not retain".

	BTW, no barriers, etc. are needed for those - once we are into
shrink_dentry_for_umount() there must be no dput() calls anywhere on
that filesystem.

