Return-Path: <linux-fsdevel+bounces-821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E887D0E4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 13:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6003E282469
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3454B18E04;
	Fri, 20 Oct 2023 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICtfLaEG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D618C24
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 11:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FECEC433C8;
	Fri, 20 Oct 2023 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697800726;
	bh=7LMkhwAnISurWBIJkOGvJQmIwQJ1MgdA3oGoHmCYmwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICtfLaEGF3xbyXu4EubB2zm8oPViJlVrwb3QKoNIQ6RPHFo4dOiO9WrOUbjz/oaKZ
	 cN6QVA22BhfOmFkkwxk184U37redRRfYjKeEB94up+MAKmPYm7Q9gE93IOBfd3wkN+
	 TEkK/dlMY4rRqHpN8TNbEA05M5f4+N2MX3xqpWRtuxC7ofQ6pDzKC1iy0SebsXllqZ
	 NwwX/E3Bcnr7XhVNy4xgWkZGeVr8nkz7PGi7MzIG3m4Q9L8eAIBCMpqvpaNmG9ndRK
	 2pwQquzKqrxVqZ7YYH95FKAHVo1wDXtFvxg3hyUMnhxs1/ym53THmic48nsOQ1iCAB
	 P7Y1qpfChjo3g==
Date: Fri, 20 Oct 2023 13:18:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Avoid grabbing sb->s_umount under
 bdev->bd_holder_lock
Message-ID: <20231020-alibi-funkanstalt-75d796ad7ff3@brauner>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
 <20231019105717.s35ahlgflx2rk3nj@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019105717.s35ahlgflx2rk3nj@quack3>

On Thu, Oct 19, 2023 at 12:57:17PM +0200, Jan Kara wrote:
> On Thu 19-10-23 10:33:36, Christian Brauner wrote:
> > On Wed, Oct 18, 2023 at 05:29:24PM +0200, Jan Kara wrote:
> > > The implementation of bdev holder operations such as fs_bdev_mark_dead()
> > > and fs_bdev_sync() grab sb->s_umount semaphore under
> > > bdev->bd_holder_lock. This is problematic because it leads to
> > > disk->open_mutex -> sb->s_umount lock ordering which is counterintuitive
> > > (usually we grab higher level (e.g. filesystem) locks first and lower
> > > level (e.g. block layer) locks later) and indeed makes lockdep complain
> > > about possible locking cycles whenever we open a block device while
> > > holding sb->s_umount semaphore. Implement a function
> > 
> > This patches together with my series that Christoph sent out for me
> > Link: https://lore.kernel.org/r/20231017184823.1383356-1-hch@lst.de
> > two days ago (tyvm!) the lockdep false positives are all gone and we
> > also eliminated the counterintuitive ordering requirement that forces us
> > to give up s_umount before opening block devices.
> > 
> > I've verified that yesterday and did a bunch of testing via sudden
> > device removal.
> > 
> > Christoph had thankfully added generic/730 and generic/731 to emulate
> > some device removal. I also messed around with the loop code and
> > specifically used LOOP_CHANGE_FD to force a disk_force_media_change() on
> > a filesystem.
> 
> Ah, glad to hear that! So now we can also slowly work on undoing the unlock
> s_umount, open bdev, lock s_umount games we have introduced in several
> places. But I guess let's wait a bit for the dust to settle :)

Yeah, I had thought about this right away as well. And agreed, that can
happen later. :)

