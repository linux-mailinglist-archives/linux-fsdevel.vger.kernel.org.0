Return-Path: <linux-fsdevel+bounces-2873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F3A7EB8F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 22:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495EF28137B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 21:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8B13307D;
	Tue, 14 Nov 2023 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I6BCkjyb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2B533070
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 21:53:47 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3978DD3;
	Tue, 14 Nov 2023 13:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=ppjYE1d3QkWcZ8CAaowSn9OBfnppTpUC7M+SM8z+qE4=; b=I6BCkjybDzRsVHubRxMs6MalDS
	08xS5CWMlgX59YnftYWepX8gyBrNmOWUrfpSIJEQDE1Hds5yJCMoL7psvrGTE1bbb0rQTKdeK9FMN
	eq0ft+ICAnsk9Y4j92OvJlVC0b8L/Q1n/ZUJxmp23GE2ZTCZZHEJh3j2OaKSKlEcmeiWWHjHEpZuB
	h1/XbBCk5NB4lqWE4osTZ8tgXYAwTfCmr+cNeU3b+t5vmj5TqoJDoKg0T9PtPkRB+xoxN8+Sg55Zb
	42v7mxGhsuoWADiHE1P/Zbdn3J4MWprCGz54k0JBdPHfltmvU3Bb9vHVhJ80OZ6eoukcBN4iYB19n
	5f+jTv3Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r31Lp-00FqaI-1B;
	Tue, 14 Nov 2023 21:53:41 +0000
Date: Tue, 14 Nov 2023 21:53:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>, selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
Message-ID: <20231114215341.GU1957730@ZenIV>
References: <20231016220835.GH800259@ZenIV>
 <CAHC9VhTzEiKixwpKuit0CBq3S5F-CX3bT1raWdK8UPuN3xS-Bw@mail.gmail.com>
 <CAEjxPJ4FD4m7wEO+FcH+=LyH2inTZqxi1OT5FkUH485s+cqM2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ4FD4m7wEO+FcH+=LyH2inTZqxi1OT5FkUH485s+cqM2Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 14, 2023 at 03:57:35PM -0500, Stephen Smalley wrote:
> On Mon, Nov 13, 2023 at 11:19 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Mon, Oct 16, 2023 at 6:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > [
> > > That thing sits in viro/vfs.git#work.selinuxfs; I have
> > > lock_rename()-related followups in another branch, so a pull would be more
> > > convenient for me than cherry-pick.  NOTE: testing and comments would
> > > be very welcome - as it is, the patch is pretty much untested beyond
> > > "it builds".
> > > ]
> >
> > Hi Al,
> >
> > I will admit to glossing over the comment above when I merged this
> > into the selinux/dev branch last night.  As it's been a few weeks, I'm
> > not sure if the comment above still applies, but if it does let me
> > know and I can yank/revert the patch in favor of a larger pull.  Let
> > me know what you'd like to do.
> 
> Seeing this during testsuite runs:

Interesting...  i_nlink decrement hitting an inode already with zero
nlink...

<pokes around>

Could you add
        inc_nlink(sb->s_root->d_inode);
in sel_make_swapover_dir() right before
        inode_unlock(sb->s_root->d_inode);

and check if that fixes the problem?

