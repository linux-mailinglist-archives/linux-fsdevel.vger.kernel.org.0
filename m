Return-Path: <linux-fsdevel+bounces-20310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D18D1510
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10A01C208FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 07:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCCB7316F;
	Tue, 28 May 2024 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRTN5emJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09126AE7;
	Tue, 28 May 2024 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880360; cv=none; b=p/EtfjFiUJ0gSJVPmeuIC6HU3HLTAaXJhtgyPuEZqVxsi7OMGEYao8Ra4+qVDRoqAWMdVWq5WqXsmGoJzXuwWH6QqOfurFwdLaDnUk872u2h6RJPBV36iCyQtseJ0CzhaZSID/Rlfisvrl2YwZu48Fkl1q2e6iy5tdIvnCZmlJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880360; c=relaxed/simple;
	bh=s5LXjhdG/tOFAjHbokqLAlt1q4Hh3ZREFJN0r4H4gPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMkL14nmcAf6b7sqWTsBpIzUjipMyfyX+BYrrtlXXPBiQCXP+TOgvZBp7qKInbnZoE2SdeQMSujMfkfTVn0ZFnLoqZMuJzEBCZsJIFJBhpybLRWnfux5udcCw5+QobiBXcxeTQONHQ+EIs68f3h1zLctmdYNIhwJ9mV2KV+7YA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRTN5emJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F62EC3277B;
	Tue, 28 May 2024 07:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716880359;
	bh=s5LXjhdG/tOFAjHbokqLAlt1q4Hh3ZREFJN0r4H4gPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRTN5emJERfn4+pZMe90zu3qCgJMMr7Bq9Vwf43xanoRW3P6Vct1HurpDByatTCO+
	 wet9rSfBSovb06LdXe69jgHt/ZO6tEVb6HTpQyfFNhqam3hgF3WVambUhGn71rAOI8
	 D/8UdED/xPZzCnaQ2iQw0LkumuX7AameCfYNXEKsDtvGBpRvTFbm+MIrAtvmr5O67o
	 Oq6/OpMJ4ASMwFv0c6vFpZ9D9xDQ9Ck7Hvqp4hgOn/kupNYuo3lZjfN5D6LQXyx+g3
	 njm41sUWCxQArqFlq4vp298k/KjfuDgU0qcWcnznDJankQhal3k4+1XcQcTJxkLoyj
	 UPzuYhRFXCBOw==
Date: Tue, 28 May 2024 09:12:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: "hch@infradead.org" <hch@infradead.org>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
	"jack@suse.cz" <jack@suse.cz>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alex.aring@gmail.com" <alex.aring@gmail.com>, 
	"cyphar@cyphar.com" <cyphar@cyphar.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, "amir73il@gmail.com" <amir73il@gmail.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240528-fraglich-abmildern-cca211d1791c@brauner>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <30137c868039a3ae17f4ae74d07383099bfa4db8.camel@hammerspace.com>
 <ZlRzNquWNalhYtux@infradead.org>
 <86065f6a4f3d2f3d78f39e7a276a2d6e25bfbc9d.camel@hammerspace.com>
 <ZlS0_DWzGk24GYZA@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlS0_DWzGk24GYZA@infradead.org>

On Mon, May 27, 2024 at 09:29:48AM -0700, hch@infradead.org wrote:
> On Mon, May 27, 2024 at 03:38:40PM +0000, Trond Myklebust wrote:
> > > It
> > > does not matter what mount you use to access it.
> > 
> > Sure. However if you are providing a path argument, then presumably you
> > need to know which file system (aka super_block) it eventually resolves
> > to.
> 
> Except that you can't, at least not without running into potential
> races.  The only way to fix a race vs unmount/remount is to include
> the fsid part in the kernel generated file handle.
> 
> > 
> > If your use case isn't NFS servers, then what use case are you
> > targeting, and how do you expect those applications to use this API?
> 
> The main user of the open by handle syscalls seems to be fanotify
> magic.

It's also used by userspace for uniquely identifying cgroups via handles
as cgroups and - even without open_by_handle_at() - to check whether a
file is still valid.

And again a 64bit mount is is a simple way to race-free go to whatever
superblock uuid you want. They cannot be recycled and are unique for the
lifetime of the system.

