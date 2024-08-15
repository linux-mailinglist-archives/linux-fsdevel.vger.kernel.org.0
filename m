Return-Path: <linux-fsdevel+bounces-26058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF99952E8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 14:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15E31F21C9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1394F19CD1E;
	Thu, 15 Aug 2024 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCrqLpYr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A546143888;
	Thu, 15 Aug 2024 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726324; cv=none; b=RnSEPHlVBjyP3njp8XVwwHFZh+luSbKKGx0DR09x3krxZdXhhSACxBmlOiWZxgoxeH0EJ1Xqjx9xuMpa5NIQicVEWi+rauslkqtbq0LNugWjvTGIKCzJZyyjnoTWI/e7NMLdT4Jt38lJSqMX09Exbftcb9D5mU5weEftUud1vYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726324; c=relaxed/simple;
	bh=fmAaJecgka9DtD3tycYfxWFmq7Wq+S8jNV0j+zS0T9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioTeJGdjlzVikoyYexFbfoONpPvhSeLQsVqIxHiAZALrZnSvcyGfRYWfZB1nvkDrp/PiHsNfgkTl5ukzkfs6nAb16OShdbf5Yy47PT9iZor9ThIpbKN8qijXD05pOzf1HchPD1Nj24nEC+OFH+GkErHiKNoXC3rOoKfQBFXsXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCrqLpYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A72DC32786;
	Thu, 15 Aug 2024 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723726324;
	bh=fmAaJecgka9DtD3tycYfxWFmq7Wq+S8jNV0j+zS0T9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCrqLpYrUKSUV4NpK5XZNazZdoJIu5QrDwMTOjSqEKEXJN9l7hJ12jYtbT3ZJM4Tj
	 buXE6UCmk9Q0isaJvAHJ/6sGwjIz8S9NC5uZNkHc3shRfJTzgttQO8WK3CRWAn1uie
	 mrrXKbEszrW8q/x6+z7Ygfbogv2HmwQLIhYJiawPr0oy6/Vqw9+wjafwVmGT9i2YKS
	 sMpD69ZVFWbs67KBUYRwv+1uIRxju3SKls77GX2g9vEVxO80EBoXsFxw+YUqeLX2vZ
	 KPFdUnSDRQ8cGDprINzne9L4j4hHpYmJ8BhvHrCdqOL8YkLT2HHvIKvHT87J7MQNop
	 GbZ4qAZZq2MWw==
Date: Thu, 15 Aug 2024 14:51:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Max Kellermann <max.kellermann@ionos.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	tools@kernel.org
Subject: Re: [PATCH] netfs, ceph: Partially revert "netfs: Replace PG_fscache
 by setting folio->private and marking dirty"
Message-ID: <20240815-seiten-vorteil-168ac82432a7@brauner>
References: <2181767.1723665003@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2181767.1723665003@warthog.procyon.org.uk>

On Wed, Aug 14, 2024 at 08:50:03PM GMT, David Howells wrote:
>     
> This partially reverts commit 2ff1e97587f4d398686f52c07afde3faf3da4e5c.
> 
> In addition to reverting the removal of PG_private_2 wrangling from the
> buffered read code[1][2], the removal of the waits for PG_private_2 from
> netfs_release_folio() and netfs_invalidate_folio() need reverting too.
> 
> It also adds a wait into ceph_evict_inode() to wait for netfs read and
> copy-to-cache ops to complete.
> 
> Fixes: 2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio->private and marking dirty")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Max Kellermann <max.kellermann@ionos.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Xiubo Li <xiubli@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: ceph-devel@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> Link: https://lore.kernel.org/r/3575457.1722355300@warthog.procyon.org.uk [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e5ced7804cb9184c4a23f8054551240562a8eda [2]
> ---

Now in vfs.fixes.

@Konstantin, for some reason I keep having issues with this patch
series. It confuses b4 to no end. When I try to shazam this single patch
here using 2181767.1723665003@warthog.procyon.org.uk it pull down a 26
patch series. And with -P _ it complains that it can't find the messag
id.

