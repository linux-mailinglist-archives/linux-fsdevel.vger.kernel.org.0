Return-Path: <linux-fsdevel+bounces-1293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FA37D8E48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 07:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BB6B213C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 05:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B1D883C;
	Fri, 27 Oct 2023 05:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qyJ8G3O4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBBD79DC
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 05:46:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3271AC;
	Thu, 26 Oct 2023 22:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZLuxSxaXZXtmhz2kwBSLdfxZZzeqNXY/Bo+Zf+OGNgA=; b=qyJ8G3O4Dj3NfjB2h8bnWTkn0e
	k/vcocf321CswfwoIv7sEelvUBP9ncfxx91zquNUCO5KhlEt4YCmxepP9oZEi/Gg5C25DTm1c91Vf
	2Yn/SISlJ89tJ6gxEgggXC4RffyUOMHnHulm2zdYxCR2bv46pY2WJ5kR6M/UKdaArYv3I7GsAjuv+
	RGT56YSnzO0jKA2eo9+WvkCMICd7YaHjLiTZ5r/E5uSC/fni/5DTG7IXWso/n1HVsMGhiWrzK6H1u
	QlwhI8a5JAczPxK680Ekvc/csjFlzQe6SmYqacjIKGBDRFPxWqbbiWmtgyNdjmRQR4Fd4PHP6FyBL
	upxl3dNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwFfV-00FdHN-1L;
	Fri, 27 Oct 2023 05:46:01 +0000
Date: Thu, 26 Oct 2023 22:46:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZTtOmWEx5neNKkez@infradead.org>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025210654.GA2892534@perftesting>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I think you're missing the point.  A bunch of statx fields might be
useful, but they are not solving the problem.  What you need is
a separate vfsmount per subvolume so that userspace sees when it
is crossing into it.  We probably can't force this onto existing
users, so it needs a mount, or even better on-disk option but without
that we're not getting anywhere.


