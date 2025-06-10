Return-Path: <linux-fsdevel+bounces-51111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F0AD2D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 07:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AFC18919E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 05:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B961025E823;
	Tue, 10 Jun 2025 05:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bb0qM6NG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E4380;
	Tue, 10 Jun 2025 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749533503; cv=none; b=GNhze7LL2+kRBaxXHi//rE6AUtuysQRkP5BMTObrQYJP2FDp+bILZX717zN2VD9X67sEYCsDDqRRcOHGkMK6v6NsWJVn7BadC8i3ZVObU+kPHmwXNUUWvxDI5OAIaTf77Yxk7ct9El7emYLJ1AMfp6zQfEKF/vWF0ykI8mO/QFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749533503; c=relaxed/simple;
	bh=A7J17tIMHTS8owTe6UCmolFvFnnuVS6D2z1d2mx3Sf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWRHzaghDQUZc+Ctyue2+RZaJI9cYC53Dz+BXnwx7IjCvosBtQtpFyD0Txi9UE/EyLMhEEaq70QJFMqdBokQO7eYXpLS5QTqu7s0AQmuFfC9bwTLvmjB+p/1LSfk5MTk+aodZrGHLV+gs7DthlSBKOAopGyeb3yN4uOZA8GfZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bb0qM6NG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9SHhfbEoDjVgyYW4lLm++eh8T2DnNraeYU972KkooNw=; b=bb0qM6NGmgxmsBi5D+yoFmMusx
	hq7LOgtgAQtuiYBF4uf5G48UHtTRX1QGio4KwJR2aOnx9Fl5G7buwXVr9xDB0F1BNdmJX/aOHdgmk
	j8FdgSCW3MWK6HpCiGNUQ0Udr95afMDODJsVrjR8ta8D5C0GqfgLsxhbAoNI2iQJ7sQ26T96om49e
	3K3W0BaF/Tjv+Dgybt4PLoPBDMzoKj19EOzwUTJ+Zi6kBDoa+CqKLmVDyaGYJ2VVzGL781zTcchH9
	m2p67kqBmmW3LdZJDYAaZvUN615k5lNexF0kwF1IFDc1bzA96PuBd2Gatzqktm2cf2uljoDj7N9Nw
	ePUs/iMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOraD-00000005qJA-2nFt;
	Tue, 10 Jun 2025 05:31:37 +0000
Date: Mon, 9 Jun 2025 22:31:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	ebiggers@kernel.org, adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH for-next v2 2/2] fs: add ioctl to query protection info
 capabilities
Message-ID: <aEfDOfnSq7AtiFI5@infradead.org>
References: <20250605150729.2730-1-anuj20.g@samsung.com>
 <CGME20250605150746epcas5p1cf96907472d8a27b0d926b9e2f943e70@epcas5p1.samsung.com>
 <20250605150729.2730-3-anuj20.g@samsung.com>
 <yq1a56lbpsc.fsf@ca-mkp.ca.oracle.com>
 <aEZe79nes2fmJs6N@infradead.org>
 <e044bbcf-bfd6-48da-a7cf-e5993287f288@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e044bbcf-bfd6-48da-a7cf-e5993287f288@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 11:14:42AM +0530, Anuj Gupta/Anuj Gupta wrote:
> On 6/9/2025 9:41 AM, Christoph Hellwig wrote:
> > On Thu, Jun 05, 2025 at 10:07:00PM -0400, Martin K. Petersen wrote:
> >>
> >> Hi Anuj!
> >>
> >>> A new structure struct fs_pi_cap is introduced, which contains the
> >>> following fields:
> >>
> >> Maybe fs_metadata_cap and then fmd_ as prefix in the struct?
> > 
> > Yeah, that does sound better.
> > 
> > 
> Based on the recent discussion and suggestion from Martin [1] I was
> planning to use logical_block_metadata_cap instead. Does that idea sound
> fine to you?

It's okay.  I find the name a little long, but at least it describes
what is going on.


