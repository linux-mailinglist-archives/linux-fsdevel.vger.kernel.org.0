Return-Path: <linux-fsdevel+bounces-50715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B35BAACEBC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 10:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04F17A27F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834DA205AB2;
	Thu,  5 Jun 2025 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKbtyPUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0752B9BC;
	Thu,  5 Jun 2025 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111857; cv=none; b=ANXWBYyZ+a/A5PQJbfMrLTu8/Vf43l/fXhHGvbvcy+TfFwcHkl+gq2tIRIDlEHbe5OFKGcXVicQaA4bqfLnvjVF3mEszB81oAGM/Xr6L3Q925CDIltnBde6xlGbn8zEB0kq914ew1k2IQbFAzWjYfBIGuHFyTq1eB9dLffwUhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111857; c=relaxed/simple;
	bh=Oi2rlfzJJgvutjviF7CtviMQJJXkwwntx0F2Th4hIrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5EamgEc1nZpUgLDL5eTAkwJXezpQiy8rhOoWHcxKNxbfSetMx1uniX64lpRB22R7QdlTr9kC74nm1PTEns4f1zQGOPUJh6MKuZ0MSQpLpIUDRdmXQRAEptr9SG2OVr1VCSTz/hgl7nIvAYfTnQ2dqU5oROKW0hoAYomo+BKs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKbtyPUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D56CC4CEE7;
	Thu,  5 Jun 2025 08:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749111856;
	bh=Oi2rlfzJJgvutjviF7CtviMQJJXkwwntx0F2Th4hIrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKbtyPUWg4ISAUfid5J3p4kDoNoSkv5YEYfwuJYUFU2epQyFbv8HDWaSFHnY8McHC
	 i3/1p1WCEptUSoloGkYtkk9jwmhlGU32L0bqgR4UVsduddaVfEh5zLoN8nFMgg8301
	 DAQ2hR9swlPjykrkj5OZ0MaWYRH68ZGvEDparVzZI2T6/zd1FpB+TiPz67jKyZCyC9
	 rzEiEC8dQ6OlN1fkDWV9QjvnxubSPsODCFP8gxiB7qxWzZNAIkzYQHaJJqkfC44QLg
	 ox92IRBVCXCQm0tFthr9RNdAAB1+TkgNuqjAYlI0KtChSygnw9ZTPD/xymThh+vefc
	 vFQlrNr+jg6PA==
Date: Thu, 5 Jun 2025 10:24:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Anuj gupta <anuj1072538@gmail.com>, Eric Biggers <ebiggers@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, jack@suse.cz, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [RFC] fs: add ioctl to query protection info capabilities
Message-ID: <20250605-zersetzen-bareinlage-649c5f93ac43@brauner>
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>
 <20250527104237.2928-1-anuj20.g@samsung.com>
 <yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>
 <fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com>
 <20250529175934.GB3840196@google.com>
 <20250530-raumakustik-herren-962a628e1d21@brauner>
 <CACzX3Av0uR5=zOXuTvcu2qovveYSmeVPnsDZA1ZByx2KLNJzEA@mail.gmail.com>
 <20250604-notgedrungen-korallen-5ffd76cb7329@brauner>
 <aD_8XsD7gDbURr-M@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aD_8XsD7gDbURr-M@infradead.org>

On Wed, Jun 04, 2025 at 12:57:18AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 04, 2025 at 09:53:10AM +0200, Christian Brauner wrote:
> > On Wed, Jun 04, 2025 at 12:13:38AM +0530, Anuj gupta wrote:
> > > > Hm, I wonder whether we should just make all of this an extension of the
> > > > new file_getattr() system call we're about to add instead of adding a
> > > > separate ioctl for this.
> > > 
> > > Hi Christian,
> > > Thanks for the suggestion to explore file_getattr() for exposing PI
> > > capabilities. I spent some time evaluating this path.
> > > 
> > > Block devices don’t implement inode_operations, including fileattr_get,
> > > so invoking file_getattr() on something like /dev/nvme0n1 currently
> > > returns -EOPNOTSUPP.  Supporting this would require introducing
> > > inode_operations, and then wiring up fileattr_get in the block layer.
> > > 
> > > Given that, I think sticking with an ioctl may be the cleaner approach.
> > > Do you see this differently?
> > 
> > Would it be so bad to add custom inode operations?
> > It's literally just something like:
> 
> That doesn't help as the inode operations for the underlying block device
> inode won't ever be called.  The visible inode is the block device node
> in the containing file system.

Ah, it's the same thing as with sockets, I forgot about that. Thanks.

> Given fileattr get/set seems to be about the actual files in the file
> system, using them for something that affects the I/O path for block
> device nodes does not feel like a good fit.  And I think the reason they
> are inode and not file operations is exactly to be able to cover
> attributes always controlled by the containing file system.

Yes, that seems fine then.

