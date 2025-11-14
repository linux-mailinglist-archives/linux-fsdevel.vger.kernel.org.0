Return-Path: <linux-fsdevel+bounces-68482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0DFC5D203
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95D884EFA19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B8923278D;
	Fri, 14 Nov 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L88J3kMN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04274BA3D;
	Fri, 14 Nov 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763123092; cv=none; b=M2u5i/QIENyB9GgQz58g43qoBJYxuGR9Wday9Gv0wvi8f0WZTvQxcITPn7qfGLS77BP7dA421w146Tiv77mPFc3t2R2EWcwL/5M5YtZFNOa5nDjT77fjMZvc2jMjo/WPzgjL6FACfmlgqGKX8rp6wx0ZKMKpWOXO35iuqYBZ1Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763123092; c=relaxed/simple;
	bh=+mBDMZqOqXyj1nw2FoUq3hfj9Pq1+bVG+kNKFkCOjGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uncm53JlyQI3sC0uNQ/siFO2d34jb51g2OdTsNckO1Up3EqgIVPiq51Rw7opVrd3tCYaVTwmhhztHrU3GnXRiYbYz/zdXXB3od0WLMH/2xoNY6jnSyTZgN/L9OFbk5Bk8NhCYQZokI84gmzPfKqH+1zM0EaReMHFKhJ91cos8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L88J3kMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B678C4AF09;
	Fri, 14 Nov 2025 12:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763123091;
	bh=+mBDMZqOqXyj1nw2FoUq3hfj9Pq1+bVG+kNKFkCOjGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L88J3kMNXclmlVXvSCh0nwJz3MI/z//UToTodAyB8+hSlNnkgXmt679fqapIropxt
	 TUKtETf1WbcWvQE6SEEa+vxb91ma9o4EiZV0RToOZ4Ov5mPY5b43+Ubt0LW1+fDwfU
	 tLqEQIv5BoWbspBjSFZbeubTeip6wzBqqXljdlL33QtlYekrXKtmNVKynge7yPqMts
	 +QLPN90oTnvZgsDNursj4MM6EYHj2IB3cRa5vnPrY6LbfG/BgI4m2zsEsMemyRtNPJ
	 ymiv896FRZ1UahmIF3bSUq4VROCfN8SABYT93BJyBU6UnvuYE29zdU0f92GFitE8Zk
	 L1O4gixSsAR3g==
Date: Fri, 14 Nov 2025 13:24:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Subject: Re: [PATCH v6 00/15] Create and use APIs to centralise locking for
 directory ops
Message-ID: <20251114-baden-banknoten-96fb107f79d7@brauner>
References: <20251113002050.676694-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113002050.676694-1-neilb@ownmail.net>

On Thu, Nov 13, 2025 at 11:18:23AM +1100, NeilBrown wrote:
> Following is a new version of this series:
>  - fixed a bug found by syzbot
>  - cleanup suggested by Stephen Smalley
>  - added patch for missing updates in smb/server - thanks Jeff Layton

The codeflow right now is very very gnarly in a lot of places which
obviously isn't your fault. But start_creating() and end_creating()
would very naturally lend themselves to be CLASS() guards.

Unrelated: I'm very inclined to slap a patch on top that renames
start_creating()/end_creating() and start_dirop()/end_dirop() to
vfs_start_creating()/vfs_end_creating() and
vfs_start_dirop()/vfs_end_dirop(). After all they are VFS level
maintained helpers and I try to be consistent with the naming in the
codebase making it very easy to grep.

