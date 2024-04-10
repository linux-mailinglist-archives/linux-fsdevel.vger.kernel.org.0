Return-Path: <linux-fsdevel+bounces-16614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2511389FEC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 19:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8207AB2478A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 17:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D88517F385;
	Wed, 10 Apr 2024 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQ6nQCFO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9AA176FB8;
	Wed, 10 Apr 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770702; cv=none; b=kDIyoroN9dyfrlx5m8dBgr3MJ7Y4FYNWobGkefM6+xQzeUQJFo6hyQfV5GWKXZWlJL+ZvMEf/z46KzVMfbTPfUGAD7ih9BaBLUm6V7h4JyiKHI/fm0a9tVRdTKK7Vbfd3i7nKoFCddzm6p94axZGiTtu1dbvFYCokFBMjZx34xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770702; c=relaxed/simple;
	bh=8bk8QbWwBjxogV8sulrsLmw3J8c/0qzWYceZvwMmUOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZNQX0W25romjm+lFnJA3TvFx09FOCf8ygzLccDcN2TAWuO+sgS5ttBLqEuHDQWQs4OYQCpZ3pTIrzk25+pSFBvhZsRTTu7hmprUcJbr1oSywyaSm+nFV8iqSPFumwRpCWpcwJ/a96qIeCPnb00hUOMNv6jcqHw6oqHC3NeeSAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQ6nQCFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935F7C433C7;
	Wed, 10 Apr 2024 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712770702;
	bh=8bk8QbWwBjxogV8sulrsLmw3J8c/0qzWYceZvwMmUOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQ6nQCFOxjCTOgr5FktkEvhBwT+60FB9SznvO+NovCDxX/VDbZy9GldL1pityvO9m
	 RzvIh1Yb9KHL+608nk7G0c8nyN1iHLVZTbiHooVXwZyBBl+UVILDZfCaTMA7y7WuGJ
	 hYRVDbFDPZSh+h3NBoz5DqRO5zF6wap442xwxF/OeoX9BRgHi+LEnorn28rcGC3xL5
	 SEd2FWO0t3xP65ddc+HvYOG+4apVIy0CsGeoyHyd7KXMBPFy9e3zoe7Gue7qZxTwOn
	 oFxukrXWAYyHVkIdv86hSbPooOQQs+Swdk8bG+PThkIevqoOd7KST9sX9vZAS3Df02
	 Dm3soaO/TIdaw==
Date: Wed, 10 Apr 2024 18:38:15 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/26] netfs, afs: Use writeback retry to deal with
 alternate keys
Message-ID: <20240410173815.GA514426@kernel.org>
References: <20240401135351.GD26556@kernel.org>
 <20240328163424.2781320-1-dhowells@redhat.com>
 <20240328163424.2781320-27-dhowells@redhat.com>
 <3002686.1712046757@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3002686.1712046757@warthog.procyon.org.uk>

On Tue, Apr 02, 2024 at 09:32:37AM +0100, David Howells wrote:
> Simon Horman <horms@kernel.org> wrote:
> 
> > > +	op->store.size		= len,
> > 
> > nit: this is probably more intuitively written using len;
> 
> I'm not sure it makes a difference, but switching 'size' to 'len' in kafs is a
> separate thing that doesn't need to be part of this patchset.

Sorry, I meant, using ';' rather than ',' at the end of the line.

