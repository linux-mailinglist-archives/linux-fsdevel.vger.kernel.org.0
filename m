Return-Path: <linux-fsdevel+bounces-54097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE67AFB30E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2457171889
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EF529AB07;
	Mon,  7 Jul 2025 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsqE5vsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AC275AF8;
	Mon,  7 Jul 2025 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890770; cv=none; b=CxIzARMKlgcVCZw8isbasmqUsiFrBiWp1S+FEOodVWcgDiac26Pa/BRjG/+JyAVQIxjJt8IHaBDRhz+YXCdMNhbllXNwi1C+wNZCWlulJFR2nXDfa9jfm0pB8LxhxTZmnGBLa+njAAkJFsDm3NzIIzK6Y0+yNu3GPKGkjXPgK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890770; c=relaxed/simple;
	bh=+UwwoB4PbjenD/PmjKn1gPCPu9Ps4pWn8AtgJo3xjtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpEJJl8OGgITGhSC3yDD3OuXKU6qt9p4Dv6Q6Cv8JDYbNGp1BZ6MzeL98YsAJdgn4GVI91lSfXnXynjIJqjE7wPI1Fq4gXgPYxw8pCt8WVDNG13izkGnm82Ql6fzUucRA9oH3bRRGzCBUHpnlrzwJw4ma2p3TOEpNGL5LqDA83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsqE5vsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C379C4CEE3;
	Mon,  7 Jul 2025 12:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751890770;
	bh=+UwwoB4PbjenD/PmjKn1gPCPu9Ps4pWn8AtgJo3xjtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AsqE5vsSQmvtD1fuyZBm4xPCu8gPp4e2v7n7T6kf7o7L6hWV2JkUOkY0SnyND9XHc
	 jlWbxpJaBrgbdehcgRP8oLKQL5xhRWLymt36lzXwceVTzEG/M/reAmwD1ek2bCyUMs
	 1fZ1vjsNZ4a1P0uV3pi2PkheBopuYzAjcrjDTslibWXVXG7SBH0jKfJq+OEPJN0lZy
	 jnMCswisWKLhJiAHaTR4dpC5IY0LI0YM8YOrLgtkJK6FWCLSHsXrbdFoMxAsxw3FP0
	 w+jhMEv4zHkpD+cpIvyYYBtp/UvhLyf4TIVnEt0KlhaXVizw3Vh+LIADaE6Njwvvh3
	 1u6RlDRtr4trg==
Date: Mon, 7 Jul 2025 14:19:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 0/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250707-alben-kaffee-da62c14bb5c3@brauner>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250701-quittung-garnieren-ceaf58dcb762@brauner>
 <uzx3pdg2hz44n7qej5rlxejdmb25jny6tbv43as7dos4dit5nv@fyyvminolae6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <uzx3pdg2hz44n7qej5rlxejdmb25jny6tbv43as7dos4dit5nv@fyyvminolae6>

On Mon, Jul 07, 2025 at 02:05:10PM +0200, Andrey Albershteyn wrote:
> On 2025-07-01 14:29:42, Christian Brauner wrote:
> > On Mon, Jun 30, 2025 at 06:20:10PM +0200, Andrey Albershteyn wrote:
> > > This patchset introduced two new syscalls file_getattr() and
> > > file_setattr(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
> > > except they use *at() semantics. Therefore, there's no need to open the
> > > file to get a fd.
> > > 
> > > These syscalls allow userspace to set filesystem inode attributes on
> > > special files. One of the usage examples is XFS quota projects.
> > > 
> > > XFS has project quotas which could be attached to a directory. All
> > > new inodes in these directories inherit project ID set on parent
> > > directory.
> > > 
> > > The project is created from userspace by opening and calling
> > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> > > with empty project ID. Those inodes then are not shown in the quota
> > > accounting but still exist in the directory. This is not critical but in
> > > the case when special files are created in the directory with already
> > > existing project quota, these new inodes inherit extended attributes.
> > > This creates a mix of special files with and without attributes.
> > > Moreover, special files with attributes don't have a possibility to
> > > become clear or change the attributes. This, in turn, prevents userspace
> > > from re-creating quota project on these existing files.
> > 
> > Only small nits I'm going to comment on that I can fix myself.
> > Otherwise looks great.
> > 
> 
> Hi Christian,
> 
> Let me know if you would like a new revision with all the comments
> included (and your patch on file_kattr rename) or you good with
> applying them while commit

It's all been in -next for a few days already. :)

