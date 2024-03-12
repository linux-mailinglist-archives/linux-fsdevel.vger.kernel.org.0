Return-Path: <linux-fsdevel+bounces-14221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C07508798EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 17:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AF69B22178
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0B67E108;
	Tue, 12 Mar 2024 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUA2qTtp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD57D061;
	Tue, 12 Mar 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260850; cv=none; b=AgjQKK4A2u6Sry8yZCR3xVd392Py1h/QHFqfz5dmC48xTZ65cEqnuMH2cdmJpYlUVa3YFtAgi0AH3KB4yPuwiKQ2e8vJRT7F4dKstPmQ0qYgNh/l1Ly6cN5GaPQ+8M2PNlgc7ZWHr9R8JowsB7+3X2g3XhDvLJQZiSuo6/9qZ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260850; c=relaxed/simple;
	bh=bQoWq/6+bcHprCwW2/+jS2zNePeJe7HHQPpgUGVy3qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge4bUxKMGTkAbTAjaO6Hl0C9BBu35mSNI+i0p6YrA3RvjkSvJuF72ErwXjem33So+nbU4352rlTJVPLQR4fnESsVMyf8AAsg/hbAduDSvl6nxYVRyKmzTlI0KIEFKFhkOtLp0vjCf6V1Z+V6dvh8jIjwS0unQM0PeaCcUWbPVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUA2qTtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B42C433F1;
	Tue, 12 Mar 2024 16:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710260849;
	bh=bQoWq/6+bcHprCwW2/+jS2zNePeJe7HHQPpgUGVy3qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUA2qTtpfJJz5uX4W61PKsMFFSsROKdnjMinEpf3IgDtboS660mW/Cdbokh0PDCPZ
	 Fv3ShLIHSfwgmiFKTR49RVe9BHB8QIQaNsQKQezzaZh+QXsl6Mo1wzUN8xOxNtw7om
	 IjOdoTk2r068jTtJle1wv7SFmzbe0gbhCKDKDD+1GT8kpkC6WJU79XV8oe7xjM94bW
	 NN6zTlx9hf+IET6MzFy2SS0HdP3kDBZRmT14Pb1XSiMvFMQEtpBv8uRRUhahjd6Ook
	 rfglCi2YS7usTPOpBU/WQKDvX9XJ0prQLfeFTp9jriD/cwNZBsSH0KafnuNH48BXnH
	 3pZFp0youJ5+Q==
Date: Tue, 12 Mar 2024 09:27:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, tytso@mit.edu,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH 4/4] iomap: cleanup iomap_write_iter()
Message-ID: <20240312162729.GD1927156@frogsfrogsfrogs>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-5-yi.zhang@huaweicloud.com>
 <20240311160739.GV1927156@frogsfrogsfrogs>
 <ZfBJYG5OHgLGewHv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfBJYG5OHgLGewHv@infradead.org>

On Tue, Mar 12, 2024 at 05:24:00AM -0700, Christoph Hellwig wrote:
> On Mon, Mar 11, 2024 at 09:07:39AM -0700, Darrick J. Wong wrote:
> > If at some point iomap_write_end actually starts returning partial write
> > completions (e.g. you wrote 250 bytes, but for some reason the pagecache
> > only acknowledges 100 bytes were written) then this code no longer
> > reverts the iter or truncates posteof pagecache correctly...
> 
> I don't think it makes sense to return a partial write from
> iomap_write_end.  But to make that clear it really should not return
> a byte count by a boolean.  I've been wanting to make that cleanup
> for a while, but it would reach all the way into buffer.c.

For now, can we change the return types of iomap_write_end_inline and
__iomap_write_end?  Then iomap can WARN_ON if the block_write_end return
value isn't 0 or copied:

	bool ret;

	if (srcmap->type == IOMAP_INLINE) {
		ret = iomap_write_end_inline(iter, folio, pos, copied);
	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
		size_t bh_written;

		bh_written = block_write_end(NULL, iter->inode->i_mapping,
				pos, len, copied, &folio->page, NULL);

		WARN_ON(bh_written != copied && bh_written != 0);
		ret = bh_written == copied;
	} else {
		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
	}

	...

	return ret;

Some day later we can circle back to bufferheads, or maybe they'll die
before we get to it. ;)

--D

