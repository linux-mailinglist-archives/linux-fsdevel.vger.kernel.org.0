Return-Path: <linux-fsdevel+bounces-66289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE46FC1A873
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519631898FBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33251A9FAB;
	Wed, 29 Oct 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTz0xeft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C3A611E;
	Wed, 29 Oct 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741957; cv=none; b=U0iZ7nzFCv8ox1mQBW6gRBUVchkf3+P+c9Qb9tnVwy7J26zCZdZssEZKlmWvobt0B7e3+sTWf+zy6SuBBGZvTWMKYdS3tTXwVbktBELeKMtr3UZ/O0npJbbtAA9ehSunLVBhrFC0RtO+1cU8xRzZsTx7FXgqUP4VKLeZyLz1ni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741957; c=relaxed/simple;
	bh=IS0yothOSs8gp45qhnmrkPm97mFydRmHsnJT1EXqKgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6jVNamfihEf8FQ9a2W21wf3sG6/cO8tPkDI1s7Skdw0+QZAsdfe9dWqYppzZoP3loeD2+ZzhcMnGvBVaJSVY+jn6ABz8J3yuI2k2MTuXdr1UzvfHNXFBo4u6gUFAINc2FOUWqkPCKRRUaz9ZScOeuwjUpzrOAxwXBzNwhsBAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTz0xeft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DDEC4CEF7;
	Wed, 29 Oct 2025 12:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761741956;
	bh=IS0yothOSs8gp45qhnmrkPm97mFydRmHsnJT1EXqKgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTz0xeftDnVr3AL5S7r4Xcmpp+pKVc3nCN1WzBXJjgoNHTzxj4OunMAtCR2rT6qlm
	 7y+EXq8M21BSWM9pvRyTJTJzt0GF8VGEmwNPLEHrQPK5OvPQ9TJFprUsJzhKjrVdqm
	 pB4rkAr8y8RcbR2nhSdjfbRLempEVTa5CYqgAEBaT/xm7JmEfslwhi19KJbXb51oH8
	 u1UL+fEQxkFjm+XdL66+tlnUUXKQfTeXXY46yO4koJ9VpC3pWtXy/nZ2UqW/RnFZZz
	 9TWezdYAWWE9maQix8tq6S+dN1w1+HnemREOzXEvS1iS4XSZjBC6e5KwBzHUtjYbMv
	 jdTXZg5Rqftrg==
Date: Wed, 29 Oct 2025 13:45:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>, 
	djwong@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Message-ID: <20251029-lernprogramm-neukunden-dee8eea07597@brauner>
References: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
 <20251021-leber-dienlich-0bee81a049e1@brauner>
 <aPiGVJTpM8aohQpk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPiGVJTpM8aohQpk@infradead.org>

On Wed, Oct 22, 2025 at 12:23:00AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 21, 2025 at 03:03:08PM +0200, Christian Brauner wrote:
> > On Mon, 13 Oct 2025 19:35:16 +1030, Qu Wenruo wrote:
> > > Btrfs requires all of its bios to be fs block aligned, normally it's
> > > totally fine but with the incoming block size larger than page size
> > > (bs > ps) support, the requirement is no longer met for direct IOs.
> > > 
> > > Because iomap_dio_bio_iter() calls bio_iov_iter_get_pages(), only
> > > requiring alignment to be bdev_logical_block_size().
> > > 
> > > [...]
> > 
> > Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.19.iomap branch should appear in linux-next soon.
> 
> I'm not seeing it yet.

Sorry, I got lost in some work. Pushed.

