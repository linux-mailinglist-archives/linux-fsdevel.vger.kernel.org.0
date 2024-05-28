Return-Path: <linux-fsdevel+bounces-20334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4988D1904
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89361C24688
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FB616C6AA;
	Tue, 28 May 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0IUVrhai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686116B756;
	Tue, 28 May 2024 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893734; cv=none; b=HJU4L+ek0e81sMbvI3t4Du0h5qCS0amKyjWCrw2wNJF4xZ3yhYjPZ+XNJAmEXepiHU31BBL6vrEOg5PzS9N/laGqmIq/+4pFdkYNK7MGtFna7sFEW6TzYCBzNiwEF4Gznrp5Q6LcJ+xUMJt9TmEJs1pvr5DDB0aF6ak7tfWv3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893734; c=relaxed/simple;
	bh=zr8XaKBl+ZknJmKpXKchgNyCDFwEJM5O2gqCp7zrmWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CD8i9zrw7bgmUcpSSoPmjV9Eh6jr3gVXIYopYuB9B77oAnj5bLf3BONrAEu6tiKevLYhhq/XkRekRfgUY7mTuyHLBcNmf0NF7tPpiYQeWx6nJsUsXOdpDVFfnI5dKVKs/cA+W+wc66znJX6LAoUCO+jSUZRCKYrJV6BZxY4EpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0IUVrhai; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zr8XaKBl+ZknJmKpXKchgNyCDFwEJM5O2gqCp7zrmWQ=; b=0IUVrhaiaNYINgCLY7uDrFqI8+
	Qfx4xa5KeQgj4gl/qJT1aLpJDPKnL5mCKlwdr9bTiqF+pQCV1yJsTZQd3QHtdIg/jY02EGs/WJvYb
	Ew5hdpVph61ZGpnfZZsV49mPKv+f8EYTlMk05yWA+bqD3aBT4CCwXTdargfGoMV6erljBd2n/sT6R
	RezAxTHmu8iuZ7Tdtg0sLB+yGol+lA2DhZBQO3ZOu6Bp69784yxkaD8WwJwCXRxaZh/0h2cjbM4K+
	bJfXIprtxLXlU7ilEaQbudKoaZfnGjRR8ZeG3Gqf8J0mGnWlsWeCcTQwRXZoKftkW7e21Ll71Agc+
	2vvKz/eA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBuUL-00000000Ha5-3bef;
	Tue, 28 May 2024 10:55:29 +0000
Date: Tue, 28 May 2024 03:55:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlW4IWMYxtwbeI7I@infradead.org>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
 <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org>
 <20240528-gesell-evakuieren-899c08cbfa06@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-gesell-evakuieren-899c08cbfa06@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 28, 2024 at 11:17:58AM +0200, Christian Brauner wrote:
> As I've said earlier, independent of the new handle type returning the
> new mount id is useful and needed because it allows the caller to
> reliably generate a mount fd for use with open_by_handle_at() via
> statmount(). That won't be solved by a new handle type and is racy with
> the old mount id. So I intend to accept a version of this patch.

The whole point is that with the fsid in the handle we do not even need
a mount fd for open_by_handle_at.

If you insist on making this interface even more crappy than it is and
create confusion please record my explicit:

Nacked-by: Christoph Hellwig <hch@lst.de>

in the commit :(

