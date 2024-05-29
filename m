Return-Path: <linux-fsdevel+bounces-20410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477128D2E7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 09:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1891F22DFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD87169363;
	Wed, 29 May 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSIW1bsK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432D167D82;
	Wed, 29 May 2024 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968408; cv=none; b=LSb3NmkJVXP24vd65VULe/SQGFmEBz4MuLFBrnUyOkfzRFbowSOeEg9x2EwZ65gPGuZ2Nn3jGFnsSqTDCmcHviIswJYi0ENhdrGlsRAXW4v7iV5NUYUM8gHSUEzVoddKAZIcFvfkwyMQpWZRkcx06tGV0Uio/zYjWUk/U3oDHxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968408; c=relaxed/simple;
	bh=fYdRJDyAIc+5o5Dbk1DjBWhpxgCjUP+fOk/zHS1zwnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPrZOu5YmbJHc4NYNoCTL0TG4PoNK45Z4mDG5dPRYOmXRZs4anGsCBUOS17jv5qpsQIjuW1zhC7YDYbiedYUPYq/707D787fVEq3UTW8TL8y0OCbXy6SWnDQllaVjm8NHnWvIvQp8Qek8Znq6Wg/vnQUDCTj9WMlMdq5ML1VjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSIW1bsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E99C2BD10;
	Wed, 29 May 2024 07:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716968407;
	bh=fYdRJDyAIc+5o5Dbk1DjBWhpxgCjUP+fOk/zHS1zwnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oSIW1bsKD/EAqn+s8PblXjVl3IuvA6Y/+Dquf8C9YubXIElluFUBcOh+88Dgjzrhy
	 ElRMC+w1kRG/i1gN7A6CAxlRfcsScnfOpPgCh61hrT6lRRPLUgRux8txeNv2FHLA1L
	 GDazokt0/5OANj2uuFXH48I/Ddx4hOxxRh5lrYO6m8RLwGcXAp1U9ttcmuXPE8/fTL
	 k+f7YGUO/BgCulmeNnA7WVTM84Of+1x24JzSSbeeGPEyiSM2T92cssnTl2POyZrY7D
	 p1ni0u9m0i9JYBZZM9WacOw+5LXLnNGnOJhJwv9dJgNFr0wyUN0veMYTL0k7fr8VFF
	 3NH+V2AcRCfcA==
Date: Wed, 29 May 2024 09:40:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240529-marzipan-verspannungen-48b760c2f66b@brauner>
References: <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
 <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org>
 <20240528-gesell-evakuieren-899c08cbfa06@brauner>
 <ZlW4IWMYxtwbeI7I@infradead.org>
 <20240528-gipfel-dilemma-948a590a36fd@brauner>
 <ZlXaj9Qv0bm9PAjX@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlXaj9Qv0bm9PAjX@infradead.org>

On Tue, May 28, 2024 at 06:22:23AM -0700, Christoph Hellwig wrote:
> On Tue, May 28, 2024 at 02:04:16PM +0200, Christian Brauner wrote:
> > Can you please explain how opening an fd based on a handle returned from
> > name_to_handle_at() and not using a mount file descriptor for
> > open_by_handle_at() would work?
> 
> Same as NFS file handles:
> 
> name_to_handle_at returns a handle that includes a file system
> identifier.
> 
> open_by_handle_at looks up the superblock based on that identifier.
> 
> For the identifier I could imagin three choices:
> 
>  1) use the fsid as returned in statfs and returned by fsnotify.
>     The downside is that it is "only" 64-bit.  The upside is that
>     we have a lot of plumbing for it
>  2) fixed 128-bit identifier to provide more entropy
>  3) a variable length identifier, which is more similar to NFS,
>     but also a lot more complicated
> 
> We'd need a global lookup structure to find the sb by id.  The simplest
> one would be a simple linear loop over super_blocks which isn't terribly
> efficient, but probably better than whatever userspace is doing to
> find a mount fd right now.
> 
> Let me cook up a simple prototype for 1) as it shouldn't be more than
> a few hundred lines of code.

Yeah, that's exactly what I figured and no that's not something we
should do.

Not just can have a really large number of superblocks if you have mount
namespaces and large container workloads that interface also needs to be
highly privileged.

Plus, you do have filesystems like btrfs that can be mounted multiple
times with the same uuid.

And in general users will still need to be able to legitimately use a
mount fd and not care about the handle type used with it.

