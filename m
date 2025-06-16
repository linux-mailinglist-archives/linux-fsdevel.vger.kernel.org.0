Return-Path: <linux-fsdevel+bounces-51766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E746ADB337
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 615817A1347
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549191DB924;
	Mon, 16 Jun 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfJ2D+YM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850842A99;
	Mon, 16 Jun 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083194; cv=none; b=Vq9HqksIg8TLA96YeiooN6Xv+MoSlvQEpp7Be7xzXH5Vvh0Ct+Z7WI3jMviL18AP+3x4Y4scFc3GWeQ9T3SIKN1+22Fxaw28nn82SxdxMcb+aca7/KzZufhA8M3AVjOd14+jPmCWVcku2J/p1DzAQrx5plL6FQJZvTQW5JIuOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083194; c=relaxed/simple;
	bh=K9lGYE1jC13GQlRKSFKfI1egBgg+0AaxtQyIvBUOSSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP7q62dW1LMeRTamqmot9wE77T+kmVqtYnPKpoCLHdLIKV0BxyRV61KaEiK6pNlvOdAXVJ8dDddkHOoQXIMPHRh5tK+xhyqa1qQmMEWsVRnvdp+yyFj3ZZ7JVb7Q2XkSg62oK5uVChExToczbQhwFjvxSG2Ad83iZbhmgDlz93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfJ2D+YM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12393C4CEEA;
	Mon, 16 Jun 2025 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750083194;
	bh=K9lGYE1jC13GQlRKSFKfI1egBgg+0AaxtQyIvBUOSSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfJ2D+YM+/jAdZB7kow/k66QuxCaiA+KCGIIKdTXAScDkWBvkf8euzyYoAkXXmvI7
	 0ZSy1McdEnIfG0vu1Prz3YVK8s82g8UvKp/jyZzlb/P7hJ9F7VcpUGtP+AVWXDNj+z
	 ki4CpttRg2hw8I0zmq0rgMQz1kFDX5mU+G0nOfitIdZj+EQTXtZJ3IUn2DQdN5Tl1C
	 4V3b7v3o1aSanESBDIXG96bOFRft3hWUgF7OgjqwiCRFag50WI5cSALvf/saEWDogn
	 gpXvMOc10qkFuDSsZtDSP5LNnsKde+Pb2pAedkEWi5n0UBpfcTxzg3YAOuU4f3xALm
	 AsCXz1KkoizWg==
Date: Mon, 16 Jun 2025 16:13:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Collin Funk <collin.funk1@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	eggert@cs.ucla.edu, bug-gnulib@gnu.org
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
Message-ID: <20250616-flitzen-barmherzigen-e30c63f9e8ba@brauner>
References: <20250605164852.2016-1-stephen.smalley.work@gmail.com>
 <CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
 <CAHC9VhRUqpubkuFFVCfiMN4jDiEhXQvJ91vHjrM5d9e4bEopaw@mail.gmail.com>
 <87plfhsa2r.fsf@gmail.com>
 <CAHC9VhRSAaENMnEYXrPTY4Z4sPO_s4fSXF=rEUFuEEUg6Lz21Q@mail.gmail.com>
 <20250611-gepunktet-umkurven-5482b6f39958@brauner>
 <CAHC9VhTWEWq_rzZnjbYrS6MCb5_gSBDAjUoYQY4htQ5MaY2o_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTWEWq_rzZnjbYrS6MCb5_gSBDAjUoYQY4htQ5MaY2o_w@mail.gmail.com>

On Mon, Jun 16, 2025 at 10:03:52AM -0400, Paul Moore wrote:
> On Wed, Jun 11, 2025 at 6:05 AM Christian Brauner <brauner@kernel.org> wrote:
> > On Tue, Jun 10, 2025 at 07:50:10PM -0400, Paul Moore wrote:
> > > On Fri, Jun 6, 2025 at 1:39 AM Collin Funk <collin.funk1@gmail.com> wrote:
> > > > Paul Moore <paul@paul-moore.com> writes:
> > > > >> <stephen.smalley.work@gmail.com> wrote:
> > > > >> >
> > > > >> > commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always
> > > > >> > include security.* xattrs") failed to reset err after the call to
> > > > >> > security_inode_listsecurity(), which returns the length of the
> > > > >> > returned xattr name. This results in simple_xattr_list() incorrectly
> > > > >> > returning this length even if a POSIX acl is also set on the inode.
> > > > >> >
> > > > >> > Reported-by: Collin Funk <collin.funk1@gmail.com>
> > > > >> > Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com/
> > > > >> > Reported-by: Paul Eggert <eggert@cs.ucla.edu>
> > > > >> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2369561
> > > > >> > Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always include security.* xattrs")
> > > > >> >
> > > > >> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > >> > ---
> > > > >> >  fs/xattr.c | 1 +
> > > > >> >  1 file changed, 1 insertion(+)
> > > > >>
> > > > >> Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > > >
> > > > > Resending this as it appears that Stephen's original posting had a
> > > > > typo in the VFS mailing list.  The original post can be found in the
> > > > > SELinux archives:
> > > > >
> > > > > https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.work@gmail.com/
> > > >
> > > > Hi, responding to this message since it has the correct lists.
> > > >
> > > > I just booted into a kernel with this patch applied and confirm that it
> > > > fixes the Gnulib tests that were failing.
> > > >
> > > > Reviewed-by: Collin Funk <collin.funk1@gmail.com>
> > > > Tested-by: Collin Funk <collin.funk1@gmail.com>
> > > >
> > > > Thanks for the fix.
> > >
> > > Al, Christian, are either of you going to pick up this fix to send to
> > > Linus?  If not, any objection if I send this up?
> >
> > It's been in vfs.fixes for some time already and it'll go out with the
> > first round of post -rc1 fixes this week.
> 
> Checking on the status of this patch as we are at -rc2 and I don't see
> it in Linus' tree?

Sent this morning with some other fixes.

