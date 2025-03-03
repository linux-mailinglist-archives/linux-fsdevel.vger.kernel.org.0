Return-Path: <linux-fsdevel+bounces-42988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF02A4C9EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242791886249
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D623C8D0;
	Mon,  3 Mar 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zc6RJe2Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543943C00;
	Mon,  3 Mar 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022693; cv=none; b=aihtsNJYfMTTNp7eeGCRaDSYjkmx1WM3yoW/LLqWNWqFRY8inRKq4vtUBRDjsmzrk797OiAuJNw7cO/VGb4O1CBW3IA7wV0+EC+mrkbw3H7eWLrHvN6TcUrU08l9jlOku2GisT+LMf2NfN7YxuVMnyRcVfK+4fPs6MaOWTe0FnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022693; c=relaxed/simple;
	bh=BBXIeF3s4cWm1soZ0YqK9pYdpjsklMIOiJu8xjo7k2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuEatxMb95SGzsgJjOFvJAlrLm18UWw0Njn7g0ypmU/Nb8/JdOnD1w2tM1KX0c+Ymj3bK2RX1chewuWL/V4qfR+A7ipZizHcz1+Zmq6YT8hWAkIh64WCO3Elt8xMMZIi9pGGVJ5Egy6TeQ9ApHOYt4Shef4g8V/cvEmdv547S4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zc6RJe2Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=HkSuV/vGaF5uKZu66/cVbxyXHK2ocanHIOHlW07RMXE=; b=zc6RJe2Q3P/PR/6udZth9WSORF
	PGFiQHy3t+wMaX7UwZXuQDy4iJjFEbrhweTBfZMbSQirw5I+PDIMYQ0f/9NziA6cihazsg7AwFpSq
	MS5ntvw5JebPKFI0pZcChGu8FjvcZxpzI5kSvxSFz4r+Lr2DdZQULU1NZ954WMzppEMuvJ3ocxgXI
	fJopaqkTvxnr4RRTSppLXNfJXKLQ+AI0Mo+7qVsjuFv97LL/uxLlFUKjG6nlLpxYw9KfU5GEC9EaG
	VmwlzwHYWfZWXNBxE/uvCnhY68CosOJS/z6BlJBxHvsOVBwKW9RO28IfO6Cd2T3aGymnn1/Fe/zlu
	XNHqpUMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp9X8-00000001jb1-3goI;
	Mon, 03 Mar 2025 17:24:50 +0000
Date: Mon, 3 Mar 2025 09:24:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Heinz Mauelshagen <heinzm@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z8Xl4ki3AjYp5coD@infradead.org>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <CAM23VxprhJgOPfhxQf6QNWzHd6+-ZwbjSo-oMHCD2WDQiKntMg@mail.gmail.com>
 <Z8XHLdh_YT1Z7ZSC@infradead.org>
 <CAM23VxprSduDDK8qvLVkUt9WWmLMPFjhqKB8X4e6gw7Wv-6R2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM23VxprSduDDK8qvLVkUt9WWmLMPFjhqKB8X4e6gw7Wv-6R2w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 03, 2025 at 05:06:16PM +0100, Heinz Mauelshagen wrote:
> On Mon, Mar 3, 2025 at 4:24 PM Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Mon, Mar 03, 2025 at 03:57:23PM +0100, Heinz Mauelshagen wrote:
> > > dm-loop avoids the file system abstraction, thus gains the resulting
> > > performance advantage versus the loop driver.
> >
> > How?
> >
> 
> It uses a predefined map and thus avoids VFS -> FS write path overhead
> completelly.

But you simply can't use a "pre-defined map".  It's fundamentally
unsafe.

> The inode fiemap() operation would avoid issues relative to outdated bmap().

No, using that for I/O is even worse.


