Return-Path: <linux-fsdevel+bounces-56652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D70AAB1A5EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F384F17F500
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E59D1E4A4;
	Mon,  4 Aug 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+1qdxY4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88572040BF;
	Mon,  4 Aug 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321110; cv=none; b=jkIVPHFjhBZTw4r8ErUc9M+SJMA0CRKOHYY8StnPc4nvDtpCKo9W+6sn6ECtWmkc58QHT8UOst9FWTPn1ElUBdIQd9zFzuA0a/Q8/ejfrtobYAxqoVoIuqqZUJ6VLoxKIlx6ckdu/yBGJ3bshSesKUooeNDbb/unrysJwKWkpOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321110; c=relaxed/simple;
	bh=vSLc4JQywzK/kjoCdya8q2sSgv5nDY+hz35GftYJGAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0+YsqzZGjUSqacQSJFxMkNAFk6VPY1FzJJ/wmX4JJ3afeA+x051M74gZ9AD4A7999ofsPGV8lDR4rfzwIHj6PbOJJ04bmHZx0UMVzCP4TG/rr3MTnLWXoCXHN1BTdPzqHXqQhfxgnrYRMxjAUO7G8HVfPFYFsjWiYwLF8SN+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+1qdxY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2212FC4CEE7;
	Mon,  4 Aug 2025 15:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754321110;
	bh=vSLc4JQywzK/kjoCdya8q2sSgv5nDY+hz35GftYJGAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+1qdxY4WBZ3N+pEwdQUuFYR+3LUVKxBPBPaBApqTWzVLVJ1wtMYsyzjC8I9Q/MSS
	 5whZiQixf9/RdQ1/QZD336DrHTvsHQz48ggKFN8zst5E/y2EYyCXeGyB805526Az4q
	 gFSfrwDW6CJcpzEJDxkqIL7lWlZTMR8+HYdto27lkKaE3kMIDDQqGeDkRQo+qZr4Ak
	 iL/08FrMoEvqzWsSczAu2WLsdkGJWlk1AkBEBwxFdM53HA7dqb9iaSZM9jBFB+f+zY
	 oZkLO0VxyCpsVj56yHAlJWn5sL9p7oAvTyi8edHCHT6IMWLNUyo9j9XZEA7IIW/9uD
	 BoeC11VU/sxbQ==
Date: Mon, 4 Aug 2025 11:25:08 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 7/7] iov_iter: remove iov_iter_is_aligned
Message-ID: <aJDQ1GPV5F5MB1kP@kernel.org>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-8-kbusch@meta.com>
 <aI1xySNUdQ2B0dbJ@kernel.org>
 <aJDAx1Ns9Fg7F6iK@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJDAx1Ns9Fg7F6iK@kbusch-mbp>

On Mon, Aug 04, 2025 at 08:16:39AM -0600, Keith Busch wrote:
> On Fri, Aug 01, 2025 at 10:02:49PM -0400, Mike Snitzer wrote:
> > On Fri, Aug 01, 2025 at 04:47:36PM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > No more callers.
> > > 
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > 
> > You had me up until this last patch.
> > 
> > I'm actually making use of iov_iter_is_aligned() in a series of
> > changes for both NFS and NFSD.  Chuck has included some of the
> > NFSD changes in his nfsd-testing branch, see:
> > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=5d78ac1e674b45f9c9e3769b48efb27c44f4e4d3
> > 
> > And the balance of my work that is pending review/inclusion is:
> > https://lore.kernel.org/linux-nfs/20250731230633.89983-1-snitzer@kernel.org/
> > https://lore.kernel.org/linux-nfs/20250801171049.94235-1-snitzer@kernel.org/
> > 
> > I only need iov_iter_aligned_bvec, but recall I want to relax its
> > checking with this patch:
> > https://lore.kernel.org/linux-nfs/20250708160619.64800-5-snitzer@kernel.org/
> > 
> > Should I just add iov_iter_aligned_bvec() to fs/nfs_common/ so that
> > both NFS and NFSD can use it?
> 
> If at all possible, I recommend finding a place that already walks the
> vectors and do an opprotunistic check for the alignments there. This
> will save CPU cycles. For example, nfsd_iter_read already iterates the
> bvec while setting each page. Could you check the alignment while doing
> that instead of iterating a second time immediately after?

Nice goal, I'll see if I can pull it off.

I'm currently using iov_iter_is_aligned() in 3 new call sites (for
READ and WRITE) in both NFS and NFSD: nfs_local_iter_init,
nfsd_iter_read, nfsd_vfs_write

nfsd_vfs_write is the only one that doesn't iterate the bvec as-is,
but it does work that _should_ obviate the need to doable check the
alignment.

