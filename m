Return-Path: <linux-fsdevel+bounces-72636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33318CFEDFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 17:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7223331AF07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 16:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B534D4C6;
	Wed,  7 Jan 2026 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ALmo4XpI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4530234B1A1;
	Wed,  7 Jan 2026 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799975; cv=none; b=uqUQ8yqTvl4y65ZVWfHh70Jg2xyph/GhU3gliakScPgJzSs5ouGBr5Z44KlEJnBGm/QEIJH9Pv8AixaQ8O5H93Fu1vh//HL7AfmSnw1YJ8qZa22JW1p8Byoko7AlOK6TEWHgfPbwaA0X6IHDKw9WVu3b5l8AtwEkpnPn63dJ4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799975; c=relaxed/simple;
	bh=nFy0yEzoFh+UjaHPlCVQ48OdYSjCsq9qSNLmXcj1Vd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsVx5L9MYD42RzLS2t03QtmhXAxMxZAum6xHCBmYX7orHqktze8D73MPhpV8MT9clcDOg8gTvMRrB+X3cu7hrJIqc4o1nFA+pLL7KZbshU4vmtJGAl8W/UXVrrM7l+vHdDOoFTI+pHm9Cs+6rr75Xevwfr+aPAHP+7S/jTx0SX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ALmo4XpI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WLCNgvyKZoXQQuDrcbanc8yb4Q1uRHJ/yANy7e6VaJk=; b=ALmo4XpInvUDXmNDzFfYS3DA1T
	UT8t4JKHDCrC20DJK7A7ZFgQ+htYB7V3v1IbOFzYjGrUFsk2hUMZ/rQOQbD+UJq8LF95kQMVRLOfQ
	KYkvj16k833hhUglawi0vzOH5zmaLOJuYaYWZHncpSWg9mpeoCQlhfVCjrEIvuQvbpAHF5hAmMKhN
	Fa1W7hNojDl8s5giyFl4DROryf36opwZCv97r7hosXwzDHkwDxZ6bhH7bXR2r3mU5lq2cO9FVt3MD
	xHMHglD1hksFbATlegUfImo9P6vFewRpvdNpHwokf8bOokgPns4l9nmPqw6vxz4y7CddZCdwd3d4L
	omDEzK9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdVWU-0000000FB4y-1TwP;
	Wed, 07 Jan 2026 15:32:34 +0000
Date: Wed, 7 Jan 2026 07:32:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Hans de Goede <hansg@kernel.org>, NeilBrown <neil@brown.name>,
	Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org, v9fs@lists.linux.dev,
	gfs2@lists.linux.dev, ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/6] vfs: properly deny directory leases on filesystems
 with special lease handling
Message-ID: <aV58kmCAicqTpFhK@infradead.org>
References: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 07, 2026 at 09:20:08AM -0500, Jeff Layton wrote:
> Long term, I think it would be best to change leases/delegations to be
> an opt-in thing, such that leases are always denied by default if the
> method isn't set.

Agreed.

> That's a larger patchset though as we'd need to audit
> all of the file_operations that currently have ->setlease() as NULL.

Initially you can just wire them up everywhere.  But I guess that would
be overkill. 


