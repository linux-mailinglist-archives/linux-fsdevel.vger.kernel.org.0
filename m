Return-Path: <linux-fsdevel+bounces-66978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5BBC32965
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 19:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E16C4F7FD6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 18:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231E8341644;
	Tue,  4 Nov 2025 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwaX63na"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C398329C5D;
	Tue,  4 Nov 2025 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279907; cv=none; b=deIpzYfJ6DyaoAHRlot/4wDF4FmltnWXapJRyTgJLE+Rgiy1FWRTJNFgb8dZ8qVRftlNGrZjH96wP+Bvp+BKU2KPzNlNixuQluAoJ406IOUhIvsapt34Vq9msSV0w7QSDGOb6OJpMHinJsW+UWpGSjwkpPQmkGSVT8gReyPS0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279907; c=relaxed/simple;
	bh=QtVuO/Lf5mKvZSCkZXHHEdaFVDQtNaMjrLQ1Azzoy7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNRx10+Z7gNUioxpWvpCxkUM4KmdwBzpydw2s27XfP1bwBver4+51dYnz4j+My9vguo4kzJaOqmFfFH1AyyuP3ILnlHaGvGAp/t2+tRoFsVo77v7I3GmIcflxHuljy5p0kvSnrjiZqjHVVjrFnvqMZV1qfXchx2Z/hxTMNH/5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwaX63na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6459C116B1;
	Tue,  4 Nov 2025 18:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762279907;
	bh=QtVuO/Lf5mKvZSCkZXHHEdaFVDQtNaMjrLQ1Azzoy7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwaX63naGOYkkOJYXih0b1FJh5pTybSDihXd9NpVsdYQKhaeOtOvWDuJde0k0or+c
	 AV8qY1mkPNdsAtUSHOnQNSEvRlPg9yF34dX+vRlVwQYQnChSbAY7QITh1BO0SLw9Hd
	 moIoD0cq9RHwdPSJsU0Ac9nD0Coa0KL+OEzZXY4PCnSmFKbV6MinVdc6E1JzE5ngE+
	 ER0kJ2udvfghV/b4L/HZcJ2RN8bzjqJdg71z6T9PTqnqEOIR1uvO0Lrhd+pXuf2lqe
	 GWm/viqUZ2vJt7E+Q6urimYbGgNEriABb9R4a+QAo7P0RCH8C7aWurFvn+FkW4ya0+
	 P3VoQ9ElmdNMA==
Date: Tue, 4 Nov 2025 10:10:06 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	linux-fscrypt@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] fscrypt: fix left shift underflow when
 inode->i_blkbits > PAGE_SHIFT
Message-ID: <20251104181006.GC1780@sol>
References: <20251030072956.454679-1-yangyongpeng.storage@gmail.com>
 <20251103164829.GC1735@sol>
 <aQnftXAg93-4FbaO@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQnftXAg93-4FbaO@infradead.org>

On Tue, Nov 04, 2025 at 03:12:53AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 03, 2025 at 08:48:29AM -0800, Eric Biggers wrote:
> > >  	*inode_ret = inode;
> > > -	*lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - inode->i_blkbits)) +
> > > +	*lblk_num_ret = (((u64)folio->index << PAGE_SHIFT) >> inode->i_blkbits) +
> 
> This should be using folio_pos() instead of open coding the arithmetics.

Well, folio_pos() doesn't work with sizes greater than S64_MAX, and it
uses multiplication rather than a shift.

Probably doesn't matter, but I always feel like I have to actually check
that.

It looks like the size of block device can come from several different
places, including set_capacity(), bdev_resize_partition(), and
add_partition().  The first has a size check.  I don't immediately see a
size check in the other two.  Maybe it's there and I need to look
closer.  Also can the size of a block device be set in other ways?

Then I have to remember whether a multiplication of a signed value gets
reliably optimized to a shift on all architectures or not.  I think so.

Anyway, the trivial version avoids having to consider any of this...

- Eric

