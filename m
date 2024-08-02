Return-Path: <linux-fsdevel+bounces-24875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874AA945F97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 16:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E48F285F82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B522101B7;
	Fri,  2 Aug 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzIfzPbq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DFD1171C;
	Fri,  2 Aug 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609852; cv=none; b=YTqOhBFEQ97fPvYvP+ogXao6LQrsmHRlS1zklG/i0KCrZeXp8uAj/K/JxvPmN8ZC1eUqnFd4lB9uGBeWVvKcWwYcN/gRkaFSvC4x0EV6Iv7FXaazYx9nFXcbt+bpuvwaRP7kw5CbSUXEb9rNOSZAWHT+W+pthpERDE+jO3plDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609852; c=relaxed/simple;
	bh=x8gmfjyvWGUc0bCINyn9NBAMXGuzcpTpCIJEd8Maaqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4BsSTXGghbtJluwou74V6KEfZZqXKooHVZNjZNClxC11h8g4nWDIitjGL/d1DVb/Bt6My39RMobunIY81obv2E7jqxgm9xw6DTGJ4kQTrbUHllxur1vEG+sHHilU7qDq/jjYkgur1SswWGQRrxNZAmFdG9NC3RsoK0W+DNOa+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzIfzPbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55967C32782;
	Fri,  2 Aug 2024 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722609851;
	bh=x8gmfjyvWGUc0bCINyn9NBAMXGuzcpTpCIJEd8Maaqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzIfzPbqeWDSXjHiBgkEJnEtvR/x00pI80yfMOPspsqu8FySfDHUqzDYaUa33dMPa
	 9VuWj+8Sla/wxa6LgFUP4mUw5Uqld7oPO/Rc7VTvnZTkP4QUsX0WNIBJRfMKEbOm5E
	 0O3SbfpH6tCZjpWaiiD1fNODTiZvR3ChGvm1WdEivsVrn36vxh5q5dSLX0Bq7q6TW/
	 ZIfiaLlaRb/QTv1p8yRpvlyNCDsCx+PAndbRntFM/P58FfzqAwLyMhP9mXUnvR6Pti
	 auvyf2mCECPYJDUbbakovkI3Q9PN8/kFR339yvIkgqaDOFi20gDtMTllo/pWmelP5F
	 gBuJs50KKDLcA==
Date: Fri, 2 Aug 2024 15:44:05 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/24] netfs: Speed up buffered reading
Message-ID: <20240802144405.GD2504122@kernel.org>
References: <20240731190742.GS1967603@kernel.org>
 <20240729162002.3436763-1-dhowells@redhat.com>
 <20240729162002.3436763-19-dhowells@redhat.com>
 <117846.1722608282@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117846.1722608282@warthog.procyon.org.uk>

On Fri, Aug 02, 2024 at 03:18:02PM +0100, David Howells wrote:
> Simon Horman <horms@kernel.org> wrote:
> 
> > If the code ever reaches this line, then slice will be used
> > uninitialised below.
> 
> It can't actually happen (or, at least, it shouldn't).  There are only three
> ways of obtaining data: downloading from the server
> (NETFS_DOWNLOAD_FROM_SERVER), reading from the cache (NETFS_READ_FROM_CACHE)
> and just clearing space (NETFS_FILL_WITH_ZEROES); each of those has its own
> if-statement that will set 'slice' or will switch the source to a different
> type that will set 'slice'.
> 
> The problem is that the compiler doesn't know this.
> 
> The check for NETFS_INVALID_READ is there just in case.  Possibly:
> 
> 		if (source == NETFS_INVALID_READ)
> 			break;
> 
> could be replaced with a WARN_ON_ONCE() and an unconditional break.

Thanks, I think that should make the compiler happy without
significantly altering the flow or readability of the code.

