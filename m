Return-Path: <linux-fsdevel+bounces-1927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB4B7E0549
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E72B7B2144F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700A61A5B3;
	Fri,  3 Nov 2023 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7UEioT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080E1A585
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 15:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBDBC433C8;
	Fri,  3 Nov 2023 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699024217;
	bh=kUdsSQDmfV36S6XCtmL32PMov5sxPf6sY4WpE90ZBPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7UEioT77m8QTMaCSxlBD7ejr5TYl5eO26mTxq7UJ1mFjD5AYslSHpMi3pvu5517k
	 73Tq6U0STGuCfwMYYqU29B0yhj0IwIajq96O8lm3NNHt4oLUEyfFkutJzWIlASxA2s
	 VD5oOqMYlsIi2nEQLIZHzyCuZJLA9prSv+JscKmjVDj4IflsOFlz8M5Z2N/h8ujNo7
	 dTP5fCTLJBJlh/BG1+MnyQDqRv4gPfQ81I+ICKcT/FQzU/TCRjQ+FE5Fv8azBobUK4
	 XmOnXat1EUpeON5dc/0/sGjAY30KnYW6yNVFxRo1QrXRjLxbscN3+3ZGNvPPUbj6SN
	 wOhREusWA66tQ==
Date: Fri, 3 Nov 2023 16:10:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: [PATCH] fs: handle freezing from multiple devices
Message-ID: <20231103-leiht-funkverkehr-48ed8d425fd9@brauner>
References: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231103-vfs-multi-device-freeze-v1-1-fe922b30bfb6@kernel.org>
 <20231103141940.GA3732@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231103141940.GA3732@lst.de>

On Fri, Nov 03, 2023 at 03:19:40PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 03, 2023 at 02:52:27PM +0100, Christian Brauner wrote:
> > Fix this by counting the number of block devices that requested the
> > filesystem to be frozen in @bdev_count in struct sb_writers and only
> > unfreeze once the @bdev_count hits zero. Survives fstests and blktests
> > and makes the reproducer succeed.
> 
> Is there a good reason to not just refcount the freezes in general?

If we start counting freezes in general we break userspace as
freeze_super() is called from ioctl_fsfreeze() and that expects to
return EBUSY on an already frozen filesystem. xfs scrub might be another
user that might break if we change that.

