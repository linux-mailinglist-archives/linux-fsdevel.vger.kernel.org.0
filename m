Return-Path: <linux-fsdevel+bounces-756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7F57CFB64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 15:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658451C20A3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F0D2746C;
	Thu, 19 Oct 2023 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cUJ3tDa2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7B2745C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 13:40:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BCD130
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pfcaEjAuwnHmXoQPBfYe8j8OuTLfGNVm13RNJfBu+6s=; b=cUJ3tDa2AJh7mv1hsnmWpFWCvi
	+ULtsBueYh62UGG2iClgUsttun0UMywZg9K6BU1aOVg7etxWSn62k7qK2iUt3bCrafl110l3jvh6U
	xJL4M1eOIcMB14ititY8XLWzpUviKm6hNsydd3CoK8YH2Jr+ynWLfeWCRoaKs2HD23ZNk3l53Hufr
	fwAqH5N8251Ovny1HumBPi358h9KmEipg/rQRmSYe/RPKX52KG+NIENV1kP4SXsbFDI42izix7sMb
	Hoqh5ojLIbBkZDiwAuBay7JDivkzBSrZ4hMkDmH0C1Q0y/vM48uzlUA2pPqfo0Ls/54hRy4zvimod
	4sXVjfhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qtTGF-00HXvB-15;
	Thu, 19 Oct 2023 13:40:27 +0000
Date: Thu, 19 Oct 2023 06:40:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Avoid grabbing sb->s_umount under
 bdev->bd_holder_lock
Message-ID: <ZTExy7YTFtToAOOx@infradead.org>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-galopp-zeltdach-b14b7727f269@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 19, 2023 at 10:33:36AM +0200, Christian Brauner wrote:
> some device removal. I also messed around with the loop code and
> specifically used LOOP_CHANGE_FD to force a disk_force_media_change() on
> a filesystem.

Can you wire that up for either blktests or xfstests as well?

