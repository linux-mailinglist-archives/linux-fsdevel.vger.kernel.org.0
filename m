Return-Path: <linux-fsdevel+bounces-45585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E868A79986
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 03:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CA67A5500
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 01:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF3555897;
	Thu,  3 Apr 2025 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBRX+Koh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9CDD530;
	Thu,  3 Apr 2025 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743642128; cv=none; b=L8N1nUfLPdPvZTRIIvHp6zIBaQkytxNGyqUNHwLBqBSgni4WnvZoD9Up0McOAxBr2VkUSDhDxG1k7Keu5rE0FVcX73vP9VyygjSa0nUqwZSrEpck4GJJ4+4Fta19FJlUYxXwQCLjeX5PUMVXZGeRFUAn/kU1qy4Rc7V+KARZ1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743642128; c=relaxed/simple;
	bh=o7pQYrBcmvTVq4sglRg6uQV8FAzg+148v3QVsWCZaxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLiNOjcidDzPF4fxJzZVJJESbdHQV2XKTA1w7A2D7uig+Grc70C/0gBC5nkWKBeU4PlVJfUgk13dkuz6eBd/GfDDwwMHALeK0G7obSMrMYYw0VzLTwLYCviNO8FzgiLXq6LQmUuNqQi2Qfv0gJwWxui9QKEj8LWnwRg+E/dAAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBRX+Koh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A138C4CEDD;
	Thu,  3 Apr 2025 01:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743642127;
	bh=o7pQYrBcmvTVq4sglRg6uQV8FAzg+148v3QVsWCZaxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBRX+Koh7WcZBHXOpfa3OnkSGgM2W32Agea71Iv7jFYkqGDqyceCKtM7zfZiUwseu
	 /CQ9jXfiYpIXNuLlT58tEWkIYDmFUsGw7CkROCqPz3otdwnqUxO6X/5HqvQD6g00cK
	 QDyCOKrUuKod61GeP02OiBW6WeaBrxAEtPaamM1ob/0HkrRHYiXjjN61WPnDL3/qEf
	 O8dR3E4RZXskm5fVpG3vAs29z6Y9LDJnzbOYiVKQyk7J7VT0gsjV2fqzTbXVucTvE7
	 BNHViop4QCQ35Sqpvxe8lmD9hedEzKes+dogSa/9EMeyrlp0aHH4+KZKc3We2Q/B+v
	 NPNtKcr/oogGw==
Date: Wed, 2 Apr 2025 18:02:04 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, riel@surriel.com, willy@infradead.org,
	hannes@cmpxchg.org, oliver.sang@intel.com, dave@stgolabs.net,
	david@redhat.com, axboe@kernel.dk, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com
Subject: Re: [PATCH 2/3] fs/buffer: avoid races with folio migrations on
 __find_get_block_slow()
Message-ID: <Z-3eDEBFK8md46-7@bombadil.infradead.org>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-3-mcgrof@kernel.org>
 <lj6o73q6nev776uvy7potqrn5gmgtm4o2cev7dloedwasxcsmn@uanvqp3sm35p>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lj6o73q6nev776uvy7potqrn5gmgtm4o2cev7dloedwasxcsmn@uanvqp3sm35p>

On Tue, Apr 01, 2025 at 12:57:37PM +0200, Jan Kara wrote:
> On Sat 29-03-25 23:47:31, Luis Chamberlain wrote:
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index c7abb4a029dc..a4e4455a6ce2 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -208,6 +208,15 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
> >  	head = folio_buffers(folio);
> >  	if (!head)
> >  		goto out_unlock;
> > +
> > +	if (folio->mapping->a_ops->migrate_folio &&
> > +	    folio->mapping->a_ops->migrate_folio == buffer_migrate_folio_norefs) {
> 
> This is always true for bdev mapping we have here, isn't it?

Yes, thanks!

> > +		if (folio_test_lru(folio) &&
> 
> Do you expect bdev page cache to contain non-LRU folios? I thought every
> pagecache folio is on LRU so this seems pointless as well? But I may be
> missing something here.
> 
> > +		    folio_test_locked(folio) &&
> > +		    !folio_test_writeback(folio))
> > +			goto out_unlock;
> 
> I find this problematic. It fixes the race with migration, alright
> (although IMO we should have a comment very well explaining the interplay
> of folio lock and mapping->private_lock to make this work - probably in
> buffer_migrate_folio_norefs() - and reference it from here), but there are
> places which expect that if __find_get_block() doesn't return anything,
> this block is not cached in the buffer cache. And your change breaks this
> assumption. 

Yup agreed!

  Luis

