Return-Path: <linux-fsdevel+bounces-9622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9F843683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 07:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8A82894FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 06:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5170A3EA67;
	Wed, 31 Jan 2024 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EeBfOmAf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A13E48E;
	Wed, 31 Jan 2024 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706681888; cv=none; b=IkxtB277GkbL7tYcVwUL551sMZGVlKvTK3tMzLAILU8v4CPJyLEOe7y7UyrkJWdsrY6fPtGSidWvZA+N+UeIaBRQrUDZDgS8uZT1QR3S2edB1T+AvWgrqixjR/ml/KIb3zG+uGw6cMkKBkaesGou3/6F6FXF++IIdbjTJB6YtmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706681888; c=relaxed/simple;
	bh=w3D/s0j2doF3zwzpY1z9z6nuXxX4WiecNK9wpzgOcnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tipl8EQux0TcJ0UVPoEi/Aefi6Sq/uIdXgjFlnWuXpcYLSc3fTsWG0HC4/XbAibhngdyBAPg35DuPnr5xNE4GrufhAEhIbxKPOQe0Ffw1wrlOAfXDxFFy1a7STn6QhcXWXZr+2SWayIZz67dP47pWmLHaG6WKzQRYHs5E8yk9lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EeBfOmAf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NIDqFzAxt4YZhctftXJOdlnjyHvxqbwYfAJo9MG22ew=; b=EeBfOmAfrFbOhPnrE2ZDIiIlng
	7d43LAKcT5snLNncF7joHHJWKu+g19gwKbl5GDQLPzo0dp5yhNNgcYbUxlFLsRf/2BRF1MIvU+W8o
	XlnwX4U7mXYFOchn1OuRh7YJbTOJhdkZUgkEgvcrTPZLpVtiWgkXeVQop7xVwtAsdmlS0agD/xHgM
	8SIZgzZ/X6jtvrBdsLYTMEKkBhjX16QlNeeK80zrkJhJkMnJ0UXR92MO6JqOgIPl9HQZYFYXpIX4s
	55dyv071AGkM32E8C1K/kUa2nCLKD4SEGukVR4Trok4EIRjwS6RtxLMG3U0Vo5Tc1oz5Jt8u6gNz6
	Lm5iPkmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV3v5-00000001cb4-078E;
	Wed, 31 Jan 2024 06:17:59 +0000
Date: Tue, 30 Jan 2024 22:17:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
	syzbot <syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com>,
	adilger.kernel@dilger.ca, chandan.babu@oracle.com, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: current->journal_info got nested! (was Re: [syzbot] [xfs?]
 [ext4?] general protection fault in jbd2__journal_start)
Message-ID: <ZbnmFo0_dh-2Sgwl@infradead.org>
References: <000000000000e98460060fd59831@google.com>
 <000000000000d6e06d06102ae80b@google.com>
 <ZbmILkfdGks57J4a@dread.disaster.area>
 <20240131045822.GA2356784@mit.edu>
 <ZbnYitvLz7sWi727@casper.infradead.org>
 <Zbnicfk+JHIlG2WC@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbnicfk+JHIlG2WC@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 31, 2024 at 05:02:25PM +1100, Dave Chinner wrote:
> This may not be true for other filesystems, but I don't think we
> can really say "page faults in any filesystem transaction are unsafe
> and should be banned"....

I think the point is page faults with current->journal_info set is
unsafe, as the can recurse into another file system using it.  If we
don't set current->journal_info (and your ideas for that sound sensible
to me), the question of page faults in transactions is decoupled from
that.  We just need to ensure we never recurse into a transaction in
the same or a dependent fs, which ot me suggest we'd better avoid it
if we easily can.


