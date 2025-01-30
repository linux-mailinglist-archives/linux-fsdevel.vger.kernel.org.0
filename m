Return-Path: <linux-fsdevel+bounces-40391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46438A2304A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 15:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84F1168EF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1181E5020;
	Thu, 30 Jan 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLWnpGyf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86198BFF
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247447; cv=none; b=A7RSR307BkMxfqqvIpRTcJ6nHh5dmicpmJ+maJispYRKi/V56kMBWI6DzJR8idr5sAHxZi95LRRP7eZUp3vhP2k+FTkZLBr+xyaJeNKi4pn6wwI980sUnDHMgqHX+IMnu6j3lBq/+OJDa1m3kuL6q81YViDHAc+R16n8AyxW+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247447; c=relaxed/simple;
	bh=XIUHc9EIO9gnv+/Qx1QF3VjBQiy0o82ITQYvSu6UdPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYT6Z9/GmX7c/2XuabKclWegaSpq9U8YPwq7CfhP3Ry/+iMmzXYSXXv6m8RujWyfMDtrPN+g3CchdrSKkpWCvK9wLWvjneMIV9eLnr18qQ812tP7rfYG4RWvKeMnmWo7DT+QhtSC1NYChg9ipDnHEvQByDLx9purkmj669bwpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLWnpGyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B729C4CED2;
	Thu, 30 Jan 2025 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738247447;
	bh=XIUHc9EIO9gnv+/Qx1QF3VjBQiy0o82ITQYvSu6UdPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLWnpGyfwEpNX5V19XaJjR2/1bMygP+r44bAguZtiqnH+eZvgUZQFcK3E8PnuO/Bp
	 2zhMELvGj16usVBotQXIsBIuoiowaceCURfMRMpTVesoHQf2KK8Pa43L582kO3Ce9Q
	 YbrAPsNbtsriBCPRWWFQDorWejKObJgQDmEFnVSYyNma841tgEdgYovTKgqbhcz6rl
	 zta76z4YxP+tKOIMEVLhPwrmzV/caPzt2WYRWZcrO7kHfu8Hm0mObCmP/p0LbAYVKh
	 FQLyQ3emC3s+bnAxkIalOo+4WDmwTF5T64AIgvFSXqsffaggA8yjioRGTT5sceCWV5
	 wQ2oc1OPXSByg==
Date: Thu, 30 Jan 2025 08:30:46 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] fs: allow changing idmappings
Message-ID: <Z5uNFoz_wMUVU4da@do-x1carbon>
References: <20250128-work-mnt_idmap-update-v2-v1-0-c25feb0d2eb3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-work-mnt_idmap-update-v2-v1-0-c25feb0d2eb3@kernel.org>

On Tue, Jan 28, 2025 at 11:33:38AM +0100, Christian Brauner wrote:
> /* solution */
> 
> So, to avoid all of these pitfalls creating an idmapped mount from an
> already idmapped mount will be done atomically, i.e., a new detached
> mount is created and a new set of mount properties applied to it without
> it ever having been exposed to userspace at all.
> 
> This can be done in two ways. A new flag to open_tree() is added
> OPEN_TREE_CLEAR_IDMAP that clears the old idmapping and returns a mount
> that isn't idmapped. And then it is possible to set mount attributes on
> it again including creation of an idmapped mount.
> 
> This has the consequence that a file descriptor must exist in userspace
> that doesn't have any idmapping applied and it will thus never work in
> unpriviledged scenarios. As a container would be able to remove the
> idmapping of the mount it has been given. That should be avoided.
> 
> Instead, we add open_tree_attr() which works just like open_tree() but
> takes an optional struct mount_attr parameter. This is useful beyond
> idmappings as it fills a gap where a mount never exists in userspace
> without the necessary mount properties applied.
> 
> This is particularly useful for mount options such as
> MOUNT_ATTR_{RDONLY,NOSUID,NODEV,NOEXEC}.
> 
> To create a new idmapped mount the following works:
> 
> // Create a first idmapped mount
> struct mount_attr attr = {
>         .attr_set = MOUNT_ATTR_IDMAP
>         .userns_fd = fd_userns
> };
> 
> fd_tree = open_tree(-EBADF, "/", OPEN_TREE_CLONE, &attr, sizeof(attr));
> move_mount(fd_tree, "", -EBADF, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> 
> // Create a second idmapped mount from the first idmapped mount
> attr.attr_set = MOUNT_ATTR_IDMAP;
> attr.userns_fd = fd_userns2;
> fd_tree2 = open_tree(-EBADF, "/mnt", OPEN_TREE_CLONE, &attr, sizeof(attr));
> 
> // Create a second non-idmapped mount from the first idmapped mount:
> memset(&attr, 0, sizeof(attr));
> attr.attr_clr = MOUNT_ATTR_IDMAP;
> fd_tree2 = open_tree(-EBADF, "/mnt", OPEN_TREE_CLONE, &attr, sizeof(attr));

This approach seems reasonable to me, and the patches look good.

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>

