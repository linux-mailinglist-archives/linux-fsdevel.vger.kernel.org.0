Return-Path: <linux-fsdevel+bounces-15463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9406D88ED2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 18:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433441F32191
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DF8153BDE;
	Wed, 27 Mar 2024 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HDfwRf3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6CC153835;
	Wed, 27 Mar 2024 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561619; cv=none; b=fcIVv9som0VasUTHzjYoHyABLWKqOlbDQ5/mGu5EuHXdTWXOE9gsj2mKlMgISy4FFfam60mP5Qt/l1CXT82D/rCs6P0Nh6qZPny8ngr/o+9QH72c/He4aqxV2fNKGHIntmXy49lYGRLsjMTbnBMOys4uTwi9p13JsTFrXDMSvgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561619; c=relaxed/simple;
	bh=uB7kpus4vivNVZYNNT9/+H7DMP6DSIa06ehGi6L+8KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXyzba1tB1xYP1jQDtHkqi3qAIDYzLwFYQdxW2jAOG4yWIDu7xyMLXVzaFLnxwRFCJreBBQvuCGLk9Lex37VJ8mJ/aCg6Mz3tkjNqaznlr+uboEfHZTcNSIEDpOknXp7QbQYVD7ehg4qRIK9FYA+ztfslFt0X9Ww06VpKluiIY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HDfwRf3f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7rtlcMvAOZqMG91SbLLXeao498bSKZqxUrAUPkW+pUQ=; b=HDfwRf3f9ZX9fBrm5LQIxQEnEx
	zRji8K6f9jOwKJMzW0ps8UWVTIQ+DpE6EenLKh7kpWOjyp1cwkxzOxyFit8ikVRetjY0m6pdQbBmo
	cgRxegFCABQRAW0DoxZGjzAkXHWyQ8Qmyj6CVD1YFeBKrD5iLZk6kTMWAayIaAP9Lzo6/VDogbCIw
	I4hGSVwSGmsWotZ1Zr4n+AFwFE4oQRDQGICi9aX+P7JaGn85ZYew742acjLnQAuTdTVaOz8/p8DI2
	T+g+iD9V0hpVxiLJQNRFLTuRuHOzcCeZdKqbtUWm1QZEg6DXI3wqVnfZvFZ0K8MIQUyAAVjHTnfgm
	veRKIGKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpXMS-00000004NZT-3R3f;
	Wed, 27 Mar 2024 17:46:52 +0000
Date: Wed, 27 Mar 2024 17:46:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "hch@lst.de" <hch@lst.de>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
	"dhowells@redhat.com" <dhowells@redhat.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
	"netfs@lists.linux.dev" <netfs@lists.linux.dev>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@lists.orangefs.org" <devel@lists.orangefs.org>,
	"linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>
Subject: Re: [RFC PATCH] mm, netfs: Provide a means of invalidation without
 using launder_folio
Message-ID: <ZgRbjAn-d3_SAaQJ@casper.infradead.org>
References: <2318298.1711551844@warthog.procyon.org.uk>
 <37514eae34c02cefb11fc4c6d3f4ae2296fb6ab5.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37514eae34c02cefb11fc4c6d3f4ae2296fb6ab5.camel@hammerspace.com>

On Wed, Mar 27, 2024 at 03:56:50PM +0000, Trond Myklebust wrote:
> On Wed, 2024-03-27 at 15:04 +0000, David Howells wrote:
> > Implement a replacement for launder_folio[1].  The key feature of
> > invalidate_inode_pages2() is that it locks each folio individually,
> > unmaps
> > it to prevent mmap'd accesses interfering and calls the -
> > >launder_folio()
> > address_space op to flush it.  This has problems: firstly, each folio
> > is
> > written individually as one or more small writes; secondly, adjacent
> > folios
> > cannot be added so easily into the laundry; thirdly, it's yet another
> > op to
> > implement.
> 
> This is hardly a drop-in replacement for launder_page. The whole point
> of using invalidate_inode_pages2() was that it only requires taking the
> page locks, allowing us to use it in contexts such as
> nfs_release_file().
> 
> The above use of truncate_inode_pages_range() will require any caller
> to grab several locks in order to prevent data loss through races with
> write system calls.

I don't understand why you need launder_folio now
that you have a page_mkwrite implementation (your commit
e3db7691e9f3dff3289f64e3d98583e28afe03db used this as justification).
Other filesystems (except the network filesystems that copied the NFS
implementation) don't implement launder_folio.

