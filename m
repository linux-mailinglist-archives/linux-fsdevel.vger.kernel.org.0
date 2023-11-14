Return-Path: <linux-fsdevel+bounces-2874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1967EB90B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 22:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE08DB20B7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 21:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A285E3307D;
	Tue, 14 Nov 2023 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PwRAaMjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611BD33077
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 21:57:29 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A0B114;
	Tue, 14 Nov 2023 13:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=pnFA1ftTCLqo/Al693oDHXbFuOCwAIyULahEa0sRMus=; b=PwRAaMjPAUBWnwGJIQ8enPcf0G
	oEW4MS0EVUs9ZI6b8hA0vKIqOJ/KKki3VQDer8oQwOG5s5+VlmizUFJwVuyVFTUJDBY9W0D/45eWE
	vyDGN028skNK0I/u6gXb/gyaZDCPJzSNCNVQyPLT7H0tgNwhl8Xhch41Qmp5jPDui4DsVzScD7VnU
	9ssAvwdZmkYYwFIx9ERsJIhV18CECcjz9uneZg59JQ8XBfqywcDBgEULBxD06boUDlcCwLU2w19O3
	dSRKuwHlaPysZJ0jJv2vDYC3yQkX8c9lmcypIDjttg0O8bYkUwKtBz/0WkUq+bU8Nk5v7Ykexvyk7
	YsxoVYeg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r31PQ-00FqeT-2n;
	Tue, 14 Nov 2023 21:57:24 +0000
Date: Tue, 14 Nov 2023 21:57:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>, selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
Message-ID: <20231114215724.GV1957730@ZenIV>
References: <20231016220835.GH800259@ZenIV>
 <CAHC9VhTzEiKixwpKuit0CBq3S5F-CX3bT1raWdK8UPuN3xS-Bw@mail.gmail.com>
 <CAEjxPJ4FD4m7wEO+FcH+=LyH2inTZqxi1OT5FkUH485s+cqM2Q@mail.gmail.com>
 <20231114215341.GU1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114215341.GU1957730@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 14, 2023 at 09:53:41PM +0000, Al Viro wrote:
> On Tue, Nov 14, 2023 at 03:57:35PM -0500, Stephen Smalley wrote:
> > On Mon, Nov 13, 2023 at 11:19 AM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Mon, Oct 16, 2023 at 6:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > [
> > > > That thing sits in viro/vfs.git#work.selinuxfs; I have
> > > > lock_rename()-related followups in another branch, so a pull would be more
> > > > convenient for me than cherry-pick.  NOTE: testing and comments would
> > > > be very welcome - as it is, the patch is pretty much untested beyond
> > > > "it builds".
> > > > ]
> > >
> > > Hi Al,
> > >
> > > I will admit to glossing over the comment above when I merged this
> > > into the selinux/dev branch last night.  As it's been a few weeks, I'm
> > > not sure if the comment above still applies, but if it does let me
> > > know and I can yank/revert the patch in favor of a larger pull.  Let
> > > me know what you'd like to do.
> > 
> > Seeing this during testsuite runs:
> 
> Interesting...  i_nlink decrement hitting an inode already with zero
> nlink...
> 
> <pokes around>
> 
> Could you add
>         inc_nlink(sb->s_root->d_inode);
> in sel_make_swapover_dir() right before
>         inode_unlock(sb->s_root->d_inode);
> 
> and check if that fixes the problem?

See git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #for-selinux

