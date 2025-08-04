Return-Path: <linux-fsdevel+bounces-56694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CE2B1AAE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 00:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEDBE18A2EEA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 22:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52469291142;
	Mon,  4 Aug 2025 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0EdUzlC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FCF23AE62;
	Mon,  4 Aug 2025 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346417; cv=none; b=ilDarvU6brsHoIMvXufoc43V7vmbdO+FwjMpXwSkFouRXBlxMPihpBJiZ8ikCMaGlYhPPj1J03BXVFT0foxthlJY7ty+bxa4c1hN7IJgunsSGH8INVcISFnN8NSZhtowMGUUWW7omUEhS4pRM7mEtYuJBlQWnZA+B/mJtwx4h8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346417; c=relaxed/simple;
	bh=PwprX4EyfK/VT3xHfVyUmEUoFBs60ejBb81bAI6dNXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFP8ZbJU85/HAMUJIt7UbZajGu8AEAWMnCw4aZETZvmigfqiEiALZR/iq9vgK+SxT8bzfnnKYILyO6m6K/wL/Bh/doEZy74wcUgezzdmrpSUBjZQ3EPHWxvbI6s2YX//hetIDgUQ4NT+DXOx/OxCdOwzJsqlxbaj5s3oMf9Dp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0EdUzlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AC7C4CEE7;
	Mon,  4 Aug 2025 22:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346417;
	bh=PwprX4EyfK/VT3xHfVyUmEUoFBs60ejBb81bAI6dNXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0EdUzlC+x+Qrebl/FyIJXHmPCK5ueU6NGei0aBv67u1fdy+l4a12OC9+gCW+wLcu
	 BBfp8wIa8CEKDWxcHneg88KQXHj6gPJQTvlnW3ThKXn+UpFc5YGz59fHm5hl0/1St7
	 PNnY4tshWWlxr4oyUWQsjksW0IKqWQAr03SjjBfXDsEjijMbs9+2msXCqtE5QiZSPi
	 wH0MSHhDki7QR5sYPtLN6PnGKfk36Seb68L8nQt2eNUvzkutIel1o7AxO102/BYG6Z
	 DErSE9EkGc5wtCY4YA/qwqvbS50spvYn6yyLwdKipJLicQf+3/sTHu3SX1PBTOsVHF
	 YubX/l6r+7blg==
Date: Mon, 4 Aug 2025 18:26:55 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 7/7] iov_iter: remove iov_iter_is_aligned
Message-ID: <aJEzrzWgso2TwRaX@kernel.org>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-8-kbusch@meta.com>
 <aI1xySNUdQ2B0dbJ@kernel.org>
 <aJDAx1Ns9Fg7F6iK@kbusch-mbp>
 <aJDQ1GPV5F5MB1kP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJDQ1GPV5F5MB1kP@kernel.org>

On Mon, Aug 04, 2025 at 11:25:08AM -0400, Mike Snitzer wrote:
> On Mon, Aug 04, 2025 at 08:16:39AM -0600, Keith Busch wrote:
> > On Fri, Aug 01, 2025 at 10:02:49PM -0400, Mike Snitzer wrote:
> > > On Fri, Aug 01, 2025 at 04:47:36PM -0700, Keith Busch wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > No more callers.
> > > > 
> > > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > 
> > > You had me up until this last patch.
> > > 
> > > I'm actually making use of iov_iter_is_aligned() in a series of
> > > changes for both NFS and NFSD.  Chuck has included some of the
> > > NFSD changes in his nfsd-testing branch, see:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=5d78ac1e674b45f9c9e3769b48efb27c44f4e4d3
> > > 
> > > And the balance of my work that is pending review/inclusion is:
> > > https://lore.kernel.org/linux-nfs/20250731230633.89983-1-snitzer@kernel.org/
> > > https://lore.kernel.org/linux-nfs/20250801171049.94235-1-snitzer@kernel.org/
> > > 
> > > I only need iov_iter_aligned_bvec, but recall I want to relax its
> > > checking with this patch:
> > > https://lore.kernel.org/linux-nfs/20250708160619.64800-5-snitzer@kernel.org/
> > > 
> > > Should I just add iov_iter_aligned_bvec() to fs/nfs_common/ so that
> > > both NFS and NFSD can use it?
> > 
> > If at all possible, I recommend finding a place that already walks the
> > vectors and do an opprotunistic check for the alignments there. This
> > will save CPU cycles. For example, nfsd_iter_read already iterates the
> > bvec while setting each page. Could you check the alignment while doing
> > that instead of iterating a second time immediately after?
> 
> Nice goal, I'll see if I can pull it off.
> 
> I'm currently using iov_iter_is_aligned() in 3 new call sites (for
> READ and WRITE) in both NFS and NFSD: nfs_local_iter_init,
> nfsd_iter_read, nfsd_vfs_write
> 
> nfsd_vfs_write is the only one that doesn't iterate the bvec as-is,
> but it does work that _should_ obviate the need to doable check the
> alignment.

FYI, I was able to avoid using iov_iter_is_aligned() in favor of
checks in earlier code (in both NFSD and NFS).

Thanks,
Mike

