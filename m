Return-Path: <linux-fsdevel+bounces-68507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A552C5D95E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04D514E69D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB083218CF;
	Fri, 14 Nov 2025 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeLydU5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F5320A32;
	Fri, 14 Nov 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130207; cv=none; b=nqoIpfWvkyAIxroTy4XmG3O8/vasiIsm0ZMZeQKN4/zwXAx0UeEjviToxl1S7tOK9Ol3CTPPEFIH9CEPLQIj58PmUODsdRKIUHJr07Xl/JPb/qW7PXsl19Uxv85y3r9+uFWqEBnC9CZb4FRwXe/mGo7NQOk5iOjXMziECaguPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130207; c=relaxed/simple;
	bh=RGpfqZOq5hHnk/yvgrQYwZa/mUCvahEJHKOaVI69qnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCOHVauHVt9GdVaRG8OvT8QK4IRFFiihfCF0CPHGaUt+yhClNeDeOdIyKi2h7bpMis+o32BIbz+3LKJIuvviBZDCB1aACy0ZmyAEE+mbQz95oSudRdK49GI561C30XIlThX8nguQtylaCkYdwSiAck3mgJ36OJ/dQJ9bsrlcfco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeLydU5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2171C113D0;
	Fri, 14 Nov 2025 14:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763130207;
	bh=RGpfqZOq5hHnk/yvgrQYwZa/mUCvahEJHKOaVI69qnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IeLydU5iP2+4TeKLZKvwnOGTzJo8HZ208jWq0RFqPsO35dRQdxjjoQZqca1Qz7iSy
	 KaBM6yv6CHsCMRygo8SlJ52fMIXUJO2Y5Tj0Z+QKrh0lT3t7dT+Eagsd3BvuezVaW/
	 WTuvxzU2W/PQdvUk+v5FXracx4sUG/Kz1XItFYIbhuscYlarKlv1v+IP9t+QqwD8N8
	 Qyd/+AxbvMcqGKDeQyPVAXLAWGgBRI15tXAMe931FB2U5chFp4krZOLF8WIqzREIZE
	 8Rt3NGZun/K4089Ji3VC0UK8NHlja2X0JAOkgq5mqSokmThJExrZlJDhpSctxipv7p
	 d09yqkGYVvCFQ==
Date: Fri, 14 Nov 2025 15:23:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
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
Message-ID: <20251114-liedgut-eidesstattlich-8c116178202f@brauner>
References: <20251113002050.676694-1-neilb@ownmail.net>
 <20251114-baden-banknoten-96fb107f79d7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251114-baden-banknoten-96fb107f79d7@brauner>

On Fri, Nov 14, 2025 at 01:24:41PM +0100, Christian Brauner wrote:
> On Thu, Nov 13, 2025 at 11:18:23AM +1100, NeilBrown wrote:
> > Following is a new version of this series:
> >  - fixed a bug found by syzbot
> >  - cleanup suggested by Stephen Smalley
> >  - added patch for missing updates in smb/server - thanks Jeff Layton
> 
> The codeflow right now is very very gnarly in a lot of places which
> obviously isn't your fault. But start_creating() and end_creating()
> would very naturally lend themselves to be CLASS() guards.
> 
> Unrelated: I'm very inclined to slap a patch on top that renames
> start_creating()/end_creating() and start_dirop()/end_dirop() to
> vfs_start_creating()/vfs_end_creating() and
> vfs_start_dirop()/vfs_end_dirop(). After all they are VFS level
> maintained helpers and I try to be consistent with the naming in the
> codebase making it very easy to grep.

@Neil, @Jeff, could you please look at:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.all

and specifically at the merge conflict resolution I did for:

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.all&id=f28c9935f78bffe6fee62f7fb9f6c5af7e30d9b2

and tell me whether it all looks sane?

