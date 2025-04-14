Return-Path: <linux-fsdevel+bounces-46411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C1EA88D93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 23:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA03A66C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 21:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55361EE007;
	Mon, 14 Apr 2025 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzC/R4mY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB91ACED9;
	Mon, 14 Apr 2025 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664987; cv=none; b=JN/o2QCZpmme6ARghU5W3unHdgDo7s4BtvHUjtbZjkCy4BKz7BtDkDJcwJCD/ihGnQ75Sx6xSDjLMabKAWyV9jVzAEKGjLJj5q8VGcpkx3wG9HHszkrDxoecpg4wA7usL2qjopbtsYPVKh71mcJzVaYn424gl8s6vfrJF56ZkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664987; c=relaxed/simple;
	bh=lpeU+VFs+tWFECGqdRhNzhVUdyxBl1OuFLG5In2vUnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sol9Ir4i2ntatuF9OIFWwPtJO7isZxdgNpC+9VI1DkyXwU3Okq0XNi0VnsYAEQ3jyddke4zWv4iGm/wqqGv2Vmr2kOu1n3IkYHcczGjxlVDZWpwQBm5JaG3uXTCBVwjhQJuWQ2SkFaewt+lZMpKm5lE3IEp8Pso6MUCboJPHoUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzC/R4mY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7397C4CEE2;
	Mon, 14 Apr 2025 21:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744664986;
	bh=lpeU+VFs+tWFECGqdRhNzhVUdyxBl1OuFLG5In2vUnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BzC/R4mYs4Y+P7ux5R++T+87e2owZZFUgudssORXGInbwYHTNgHjmbrEsgpFDdLS7
	 zKOZpKTa7OhJuOt6mvz2rUkfKlCO9UuniKcc2FnivCKZSaPg9f1n7V7j9CmrIRUsZ9
	 Lvb9Al6iTA4fuIqkZJbPeD/QmWEY+LhBNS7cdyiQ8FONDkK/cbZsDd/IKsxqmLqTWP
	 zxwuv0EEgK0DkOnPFMJae45Hx1/nl4s33YVI5RwvELzomYfi4GL1SqWcrmybN45dt/
	 KazJmTbfCtJoB4TB+KJoNAAcl8SNVD4EusMyjQvAbeH/i2MuHptwltKaBTHHPz74ui
	 SLpETUqb0Rl9Q==
Date: Mon, 14 Apr 2025 14:09:44 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, riel@surriel.com, dave@stgolabs.net,
	willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com,
	david@redhat.com, axboe@kernel.dk, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <Z_15mCAv6nsSgRTf@bombadil.infradead.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>

On Thu, Apr 10, 2025 at 02:05:38PM +0200, Jan Kara wrote:
> > @@ -859,12 +862,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
> >  			}
> >  			bh = bh->b_this_page;
> >  		} while (bh != head);
> > +		spin_unlock(&mapping->i_private_lock);
> 
> No, you've just broken all simple filesystems (like ext2) with this patch.
> You can reduce the spinlock critical section only after providing
> alternative way to protect them from migration. So this should probably
> happen at the end of the series.

So you're OK with this spin lock move with the other series in place?

And so we punt the hard-to-reproduce corruption issue as future work
to do? Becuase the other alternative for now is to just disable
migration for jbd2:

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1dc09ed5d403..ef1c3ef68877 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3631,7 +3631,6 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_journalled_invalidate_folio,
 	.release_folio		= ext4_release_folio,
-	.migrate_folio		= buffer_migrate_folio_norefs,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_folio	= generic_error_remove_folio,
 	.swap_activate		= ext4_iomap_swap_activate,

