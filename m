Return-Path: <linux-fsdevel+bounces-20317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9072C8D163B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0AA31C227B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C612A13C831;
	Tue, 28 May 2024 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="prbu0lei"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D913C3F3;
	Tue, 28 May 2024 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884885; cv=none; b=N6zeOOcSywXkM0Q1PYcH7aU4ywMv8FStZFRAVKQK9eerFNPDH+8Z7B3abAXykdQOhl9pMXJGGWi+LHGpyUU/E+DUrjo7E7eb/fJf2vLcWAnqkJ6C4zVbjyMI4aaeGuJ9UJsoQIi9Sqa11MeBut8dFmdttXjTYHtJ5D1KxIbtNCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884885; c=relaxed/simple;
	bh=I4rJx3Vi7g8QyIjXX/Wgz8GsjvztY6q4ysfS3GR5qiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys65yQbd6XpNBs8PVTyOJ+CBM1w9SKXEpg2O4SH1vFO9eF1md2OK8WTbJHCLFDpMaKipoX40rpFB6cUvwj2mXjdvqc3mig7dw86VNlt3GHMqSSRu/FsRZdGikymdt/1oDO+vNpQlIpzuYCbUHz9l5fijNhrfYhJyWK2XebIWO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=prbu0lei; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T1FIunXr6SUrbznzUoW3R7DYmUUGSbdYlhleRsosS7w=; b=prbu0leiIBpQYY5tpyT42PKygl
	hfa7Y2pw4QeYIZ/EEwGxYajHs/B9jVTVzjL06KaDsUdQb+EvH2qsBNEN8A0u3QME3BlU32oQOltQi
	2uyG4K9CcQpJYkkz5WaxU25h+BoQnsT0+dU+xvSjZu4/hoDIMvH/2rlAR3It7oJhnHcFV8MpObUcY
	uKSeEEfDXy3BcX6HUo69J+W0Zn5D1eYtEpAA2o7nxPj0fz9XZKrYJEDZtbjulKhuUlhOtxraKkj09
	9kHBs/6ow304OJ+aYk7tpbku90oOYylCKgs4xoaC0bnDTDj61WBSR/SUE3n3iiI0KJxKfN4Bqr1yo
	Jwu/zX5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBsBc-0000000HTn5-1wEW;
	Tue, 28 May 2024 08:28:00 +0000
Date: Tue, 28 May 2024 01:28:00 -0700
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
Message-ID: <ZlWVkJwwJ0-B-Zyl@infradead.org>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
 <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 28, 2024 at 10:20:21AM +0200, Christian Brauner wrote:
> > This would solve all the problems in this proposal as well as all the
> > obvious ones it doesn't solve.
> 
> As I've said multiple times on the thread I agree that this is what we
> should do next and I would be happy to take patches for this. But
> exposing the 64bit mount id doesn't impede or complicate that work. It's
> a simple and useful addition that can be done now and doesn't prevent us
> from doing the proposed work.

I really confuses the user story as we now have not only one but two
broken modes for the open by handle ops.  We just further go down the
rabbit hole of mixing a non-persistent identifiers with a persistent
one.

> Hell, if you twist my arm I'll even write the patches for this.

I'm also happy to help with that despite very limited time, but I'd
rather avoid doing the misguided mount ID thing.

