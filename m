Return-Path: <linux-fsdevel+bounces-73463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB53D1A206
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DC2F3090B53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23D233E377;
	Tue, 13 Jan 2026 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCwwjjWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B33876CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320736; cv=none; b=FNQGvYzNUWNtZMjAf5CPMyHLGiFaWDFvsE+hnFCm8IsXOiUV3pl1PEwlxdl1kY3JbER/HS/3dkXs/41aO4pH5c3AiKRGe/mXBkdVX2e7rNUMZrvRqg96vc+SLquOUGNcExUghRuAdNwjTOCUeGB9ic+WM/AVssqjgm6E8Bd3h6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320736; c=relaxed/simple;
	bh=Bbgay3xH0HL6qpaZI+QX8lNfNBwTdLpxwSmb6ZtNFAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXxAp42ciZWmFXA+M6RLmLlt8/pu0Fbun2kCyWFVssMzXJxj9vj6JcW5LVtjsdQ/oGDMAJrQKWwJGcsAsR92QznXPS1OlwTQYPSce+bNLIAEwuHaq+KnN74TNf8F4aXC6EgmGbpdyC26JHaeAkub0cHzBjAU1NCKkkPi6APxLHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCwwjjWf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768320734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6uoxS+e0KEmqgRcsAruPreFQtmLGrOONweoxE8QSUzg=;
	b=jCwwjjWft4t52Mwfk3EVgDyES+EtlGQ+hVF3SmH1lHsbtxzR4G71DSRA74BOdh5aQRkfzi
	o/eA+LMlt8BuS50hWsDMMSLbZoutjFbG5SR4Mp9efMt/go5OXVfVvLD9qgb8IU8Svp2Rmz
	gMQULwt3RxJZMFtVUR7X6jkkFOdxvvw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-vLamiVYWPFizZ-ZTtvwD0A-1; Tue,
 13 Jan 2026 11:12:05 -0500
X-MC-Unique: vLamiVYWPFizZ-ZTtvwD0A-1
X-Mimecast-MFC-AGG-ID: vLamiVYWPFizZ-ZTtvwD0A_1768320724
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8ACF1954B0B;
	Tue, 13 Jan 2026 16:12:04 +0000 (UTC)
Received: from bfoster (unknown [10.22.90.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C593030001A2;
	Tue, 13 Jan 2026 16:12:03 +0000 (UTC)
Date: Tue, 13 Jan 2026 11:12:01 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: wait for batched folios to be stable in
 __iomap_get_folio
Message-ID: <aWZu0TxyoyHFTqXi@bfoster>
References: <20260113153943.3323869-1-hch@lst.de>
 <20260113154855.GH15583@frogsfrogsfrogs>
 <20260113155805.GA3726@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113155805.GA3726@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jan 13, 2026 at 04:58:05PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 13, 2026 at 07:48:55AM -0800, Darrick J. Wong wrote:
> > I wonder if we ought to have a filemap_fbatch_next() that would take
> > care of the relocking, revalidation, and stabilization... but this spot
> > fix is good as-is.
> 
> Let's wait until we have another user or two.  Premature refactoring
> tends to backfire.
> 

I agree on not being too aggressive on that... I do like the idea
though, so I'll try to keep it in mind if this happens to expand down
the road. Thanks for the fix.

Brian


