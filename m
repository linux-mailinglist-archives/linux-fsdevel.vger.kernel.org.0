Return-Path: <linux-fsdevel+bounces-50597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CB0ACD8DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA22166F05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D702323BF9C;
	Wed,  4 Jun 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d9Cw1JBr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184F222156D;
	Wed,  4 Jun 2025 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023842; cv=none; b=bN2+4YYlvYlti3147SXpoyOMiOleHMQoZzSySJiWEKs7rNsz/AeL0JA82H+NMX5abpzovuxdWKH5458bozdq+e5xxoNiCodZJ6XZvobpzx6fQ6R5XuCNu1crSDKUE0E6HCm9hMh+/wDAesDDWDpbL3e3eY7Px8RQ+n63OvcS7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023842; c=relaxed/simple;
	bh=qqXORfCf8lPBMiOZCUYt33T8QCKYNzuaFABaZ6NrO1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAgaOuBLs5SyZeEKt7Rsp1VtgcPPCi2goVB2HIqsZ82y0zp3fl8/stuxirtUtIgz/7qMhDYyMwVfdTrJ5OHb8TVwDSYWBltBCMIP9CLzgsiqe7BQbpFLHGrGynbvIo1vgz348Wxpj/DR1V4bc7vHimoy0ygecOqWtSTSqZRaMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d9Cw1JBr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yu595sUdwjNC7h8GDMGhlMievs+ha1ubKBwewnHzPxA=; b=d9Cw1JBrCEos2zWIIIi4P9xV7v
	4bPmfPQSn633HqbNV5q0l3PPsFQjThEz6xRmPSG3EDTnYeQIt0VYSXETSOoPMVzd/QqdCTzBBAgOt
	RHSNIJL2y+VJHx0IWCZxPOOnCH08tTHKO/SXUUNC3rpKsYN5roFNKEAzmCJQe46616Upc2U1QL90n
	WYE3aBK0OiI3T7t3Boc3oeQqMsIhkCOeOzyb408JiDf9Kn3zjIO5QabMrQJf77MmPWQLGCdwXqIk3
	o81yumUdqQsnypJqrYv2xVRohq2PU3vaKj1TmzjM9S7ZfYIDzCgiXQlfd88UzHT2G3SfnXv6NHdvq
	IgR88kPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMizu-0000000CoRH-1L5p;
	Wed, 04 Jun 2025 07:57:18 +0000
Date: Wed, 4 Jun 2025 00:57:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Anuj gupta <anuj1072538@gmail.com>, hch@infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, jack@suse.cz,
	axboe@kernel.dk, viro@zeniv.linux.org.uk,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com
Subject: Re: [RFC] fs: add ioctl to query protection info capabilities
Message-ID: <aD_8XsD7gDbURr-M@infradead.org>
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>
 <20250527104237.2928-1-anuj20.g@samsung.com>
 <yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>
 <fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com>
 <20250529175934.GB3840196@google.com>
 <20250530-raumakustik-herren-962a628e1d21@brauner>
 <CACzX3Av0uR5=zOXuTvcu2qovveYSmeVPnsDZA1ZByx2KLNJzEA@mail.gmail.com>
 <20250604-notgedrungen-korallen-5ffd76cb7329@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250604-notgedrungen-korallen-5ffd76cb7329@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 04, 2025 at 09:53:10AM +0200, Christian Brauner wrote:
> On Wed, Jun 04, 2025 at 12:13:38AM +0530, Anuj gupta wrote:
> > > Hm, I wonder whether we should just make all of this an extension of the
> > > new file_getattr() system call we're about to add instead of adding a
> > > separate ioctl for this.
> > 
> > Hi Christian,
> > Thanks for the suggestion to explore file_getattr() for exposing PI
> > capabilities. I spent some time evaluating this path.
> > 
> > Block devices don’t implement inode_operations, including fileattr_get,
> > so invoking file_getattr() on something like /dev/nvme0n1 currently
> > returns -EOPNOTSUPP.  Supporting this would require introducing
> > inode_operations, and then wiring up fileattr_get in the block layer.
> > 
> > Given that, I think sticking with an ioctl may be the cleaner approach.
> > Do you see this differently?
> 
> Would it be so bad to add custom inode operations?
> It's literally just something like:

That doesn't help as the inode operations for the underlying block device
inode won't ever be called.  The visible inode is the block device node
in the containing file system.

Given fileattr get/set seems to be about the actual files in the file
system, using them for something that affects the I/O path for block
device nodes does not feel like a good fit.  And I think the reason they
are inode and not file operations is exactly to be able to cover
attributes always controlled by the containing file system.


