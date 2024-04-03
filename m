Return-Path: <linux-fsdevel+bounces-16021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C1A896F10
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 14:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EDA1C25DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A14259155;
	Wed,  3 Apr 2024 12:41:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0D13AA38;
	Wed,  3 Apr 2024 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148099; cv=none; b=K4Uh55RMie1Zj3C2b+Or/azFZ/CuiEcopyQ40roIu11h1bDY8/SRDZvlpNAlyl+2muS3AsMS+Blgsaq/TfqlpR0qBlWyHxJNXDIBEXl9gyTWPG9UKnHTT7q27PzFfezjDT/CZMhT6Lhlg1cvz04Qp49xTlpJmSthFP2iyMVYPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148099; c=relaxed/simple;
	bh=d4BtMeCIKoUh183OFoEp9GiVl1NNtv0+vPrUb8D+OQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQZHpnfb7KX6sqB7M9bI86qSwt6/Ax5PUgfNRDj8HlfLB9pxDxeVTk0iGU7VnLMMQgusDsZPzKZ3uihv74z+2Skh9t0tE8V+IFIM84QRwAEH5b7jKHOMr4epaRgQ2OAFQpeXNq/+54LtQIxtd9Z0F56a9FoKhiFPlL6TjG6QnME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B14568BFE; Wed,  3 Apr 2024 14:41:25 +0200 (CEST)
Date: Wed, 3 Apr 2024 14:41:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/26] mm: Export writeback_iter()
Message-ID: <20240403124124.GA19085@lst.de>
References: <20240403101422.GA7285@lst.de> <20240403085918.GA1178@lst.de> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-16-dhowells@redhat.com> <3235934.1712139047@warthog.procyon.org.uk> <3300438.1712141700@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3300438.1712141700@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 03, 2024 at 11:55:00AM +0100, David Howells wrote:
> So why are we bothering with EXPORT_SYMBOL at all?  Why don't you just send a
> patch replace all of them with EXPORT_SYMBOL_GPL()?

No my business.  But if you want to side track this let me just put this
in here:

NAK to the non-GPL EXPORT of writeback_iter().


