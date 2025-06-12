Return-Path: <linux-fsdevel+bounces-51401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31915AD6729
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 07:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20A97AD67D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4701DF974;
	Thu, 12 Jun 2025 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D+FmT6dI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37F3199FAF;
	Thu, 12 Jun 2025 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705344; cv=none; b=WsSYHCGtMP3h03isSM9vtjUauW75QYlhDiBe6EFF0GLmzH/LN5ptiMULr6gC2xiE17VcszQ/K7IrSOsD/oHN3rYzn29MYezBudl9orN0UJy2GESiHcfAyrXM1netQg/CCZRPQO8K3GlqMJQwebyOR+AShCT3gIknCXbEQUCFBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705344; c=relaxed/simple;
	bh=SOVSZfo5Qf9+mBMYg3p9lnyLnkljpzougApSLwVkQlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPHvoCJHusjBcQKjDpLD1CWygo7p7EKJ0fmVPJivNEFmnTWmKuhTEAV5j4wPT8krTJRsXa/S/5VO3YIhGQkDhcxBy8JvfNFhT7xQBRi+PiEhZhtlnaZwa25D2uiL3yQSfKS2ZeEv+HSnpQyQ3TIrLYx+PUDToasMVuUxYUxRhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D+FmT6dI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2zfPL53srt4hjqHDKpqbfkF1OaUAzZsGZkqD6Xa9kOk=; b=D+FmT6dIXGVYjZp+Nva9JtrcSC
	8uNqqxSQcIBisf6WH+EvrTaGX3JPtea0NxbFe53BpKNrjd6uRe4bFj/55MAKkZM2P1PrhOJsQEdwg
	Bq1RSMRJ1zI2qsz4Icj7W9wAPI/Qnl8+5MjjmIQGV1gW/9p3+AszzSSvAo0ZUzqLO8F6pFSyyO/Cq
	HaN40wqqlFjl+TrmLBfEjNApONuRiq9jAh5S9rk/Hi+465bybTXhq7k97P18S3KlbdbtWyps5DMAq
	o1PemB6ogWLH5IoTJHJnGj9+i5WAYSy7y4WuASGdIKRF5akYyNb7QAlhUjItXUFif6o5Jx9bqReBM
	yoj/xcag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPaHp-0000000CDDK-0oiV;
	Thu, 12 Jun 2025 05:15:37 +0000
Date: Wed, 11 Jun 2025 22:15:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Anuj Gupta <anuj20.g@samsung.com>, vincent.fu@samsung.com, jack@suse.cz,
	anuj1072538@gmail.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH for-next v3 2/2] fs: add ioctl to query metadata and
 protection info capabilities
Message-ID: <aEpieXeQ-ow3k1ke@infradead.org>
References: <20250610132254.6152-1-anuj20.g@samsung.com>
 <CGME20250610132317epcas5p442ce20c039224fb691ab0ba03fcb21e7@epcas5p4.samsung.com>
 <20250610132254.6152-3-anuj20.g@samsung.com>
 <20250611-saufen-wegfielen-487ca3c70ba6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-saufen-wegfielen-487ca3c70ba6@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 12:23:00PM +0200, Christian Brauner wrote:
> > +struct logical_block_metadata_cap {
> > +	__u32	lbmd_flags;
> > +	__u16	lbmd_interval;
> > +	__u8	lbmd_size;
> > +	__u8	lbmd_opaque_size;
> > +	__u8	lbmd_opaque_offset;
> > +	__u8	lbmd_pi_size;
> > +	__u8	lbmd_pi_offset;
> > +	__u8	lbmd_guard_tag_type;
> > +	__u8	lbmd_app_tag_size;
> > +	__u8	lbmd_ref_tag_size;
> > +	__u8	lbmd_storage_tag_size;
> > +	__u8	lbmd_rsvd[17];
> 
> Don't do this hard-coded form of extensiblity. ioctl()s are inherently
> extensible because they encode the size. Instead of switching on the
> full ioctl, switch on the ioctl number. See for example fs/pidfs:

Umm, yes and no.  The size encoding in the ioctl is great.  But having
a few fields in a structure that already has flags allows for much
easier extensions for small amounts of data.  Without the reserved
fields, this structure is 15 bytes long.  So we'll need at least 1
do pad to a natural alignment.  I think adding another 16 (aka
two u64s) seems pretty reasonable for painless extensions.

---end quoted text---

