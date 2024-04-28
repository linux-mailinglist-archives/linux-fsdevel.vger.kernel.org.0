Return-Path: <linux-fsdevel+bounces-18021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9957F8B4D99
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 21:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D46B210FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 19:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32319745D6;
	Sun, 28 Apr 2024 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FibtZezt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0A64CC0;
	Sun, 28 Apr 2024 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714331233; cv=none; b=TA1jIDhoZ9uFaviKBoHzSKsdGFrs85nI6f8423PVTEpeoU6oZdhTWf8KK3l1MzHj0uRJHYcH27G+Q5LRbC6VBo8xgfRpp8RStxc7Sg0l6Vmzm5opwFr9Z73v998unk8Z0iOAgjC4B+m9+5QTNycSTubGQ7OlwY/gmJ+IQie1IRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714331233; c=relaxed/simple;
	bh=b5cvrCbZsmN8LkAL+zAyl9pSrzy3Xs+uHy/uTuVSP2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bic/SrVDlZsM9h9lbb1CU9PQry7eEaNBDkTKu5hmyk2lCwLy2jfhxrr6SmbOUmC7Z72ZuEv/Hi6fowQcKDrTHRf5QolyTUEPQeLk5p9XAYc6wESbywbv/OUrtCY/djgrsCbPdhC5RJ0SMmmeHbK7AorbhGaAW4QF7ZhYABlFT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FibtZezt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O9aBO2yF7wh1qXln0prXHRgrrREVpn8Q86UMRWAhbc4=; b=FibtZeztHmj1g72O1E31Vtuqxc
	LGL2Tboc4G5/AlhKjfmA8s4CO5qEFWbege8rXS3r/nDOJWETPFQwR5KHByPpT+03sXS2OpbCEbXqV
	IE2R+o5IcWOiRdLlE1OFtG6wOohBkCuvkbSF0m9+CkoWl4s2Jkn/32T/lKcZp1ugHdrMv/uT7/3OF
	gbXDijtt24OAJyA6OKTcG/S8DWnsDj0Yen7L3fv+rQofio/ew4Qjrp3Q3fZ23Hd6wmAs1C26i6n6b
	tbWLWh24pq2Yn1IifF0MBRAeXW6EGjgwhaydKYJEP+rrAKiZ1L9HeAJWoUMf4gQZ+smRSL4cTUkOk
	/mxKjlkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s19rh-006w9Y-0h;
	Sun, 28 Apr 2024 19:07:09 +0000
Date: Sun, 28 Apr 2024 20:07:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
Message-ID: <20240428190709.GX2118490@ZenIV>
References: <20240427210920.GR2118490@ZenIV>
 <20240427211128.GD1495312@ZenIV>
 <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
 <20240427234623.GS2118490@ZenIV>
 <20240428181934.GV2118490@ZenIV>
 <CAHk-=wgPpeg1fj4zk0mvCmpYrrs0jVqrFrRONNFgA8Yq6nLTeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPpeg1fj4zk0mvCmpYrrs0jVqrFrRONNFgA8Yq6nLTeg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 28, 2024 at 11:46:05AM -0700, Linus Torvalds wrote:
> On Sun, 28 Apr 2024 at 11:19, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > FWIW, pretty much the same can be done with zram - open with O_EXCL and to
> > hell with reopening.  Guys, are there any objections to that?
> 
> Please do. The fewer of these strange "re-open block device" things we
> have, the better.
> 
> I particularly dislike our "holder" logic, and this re-opening is one
> source of nasty confusion, and if we could replace them all with just
> the "O_EXCL uses the file itself as the holder", that would be
> absolutely _lovely_.

The tricky part is blk_holder_ops, and I'm no fonder of it than you are.

Christoph, do you have any plans along those lines for swap devices?
If they are not going to grow holder_ops, I'd say we should switch
to O_EXCL open and be done with that; zram is in the same situation,
AFAICS.

Might be worth a topic at LSF, actually...

