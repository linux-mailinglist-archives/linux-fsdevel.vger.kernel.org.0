Return-Path: <linux-fsdevel+bounces-3211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6F67F16B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 16:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC7D1F24E7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C9B1CABF;
	Mon, 20 Nov 2023 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EF6Z/rtE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0331854;
	Mon, 20 Nov 2023 15:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8025FC433C9;
	Mon, 20 Nov 2023 15:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700492774;
	bh=7t2WZjjvqByOeMC7OwZNB8LTlJ8j6xY5BoTSVtlNVBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EF6Z/rtEhniaZrtGdJKsW3utjme11UiwENJ1Z56AsfL/01wu3w5rMsL48SRnxZZiG
	 RXc6n24Hx6Nmbb8WwlcLcn0uKdVOGFV2go577Weg30nzhj7P+G0No5F59K+986q93d
	 ++ji5ZXgDOju8wFsv3dAijcRlJJQruSMJsK1o3hhA6w954eVj3HPYsJDeM9eF2gI/6
	 PrD2G9xqJQsF2ZR2CQwHumlIBDHpeJFmq9g0h1YEYKjhHdHhhFjEzYnJYoljtcP19w
	 DNwM3t9vM4Bo/ZRsGQt9j41wn62PVmfCHID1frEQJsTGtDpcfBWT4BCF1PulMnEH1G
	 ecbbA15TmOplw==
Date: Mon, 20 Nov 2023 16:06:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231120-nihilismus-verehren-f2b932b799e0@brauner>
References: <20230816050803.15660-1-krisman@suse.de>
 <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>

On Sun, Nov 19, 2023 at 06:11:39PM -0500, Gabriel Krisman Bertazi wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Wed, 16 Aug 2023 01:07:54 -0400, Gabriel Krisman Bertazi wrote:
> >> This is v6 of the negative dentry on case-insensitive directories.
> >> Thanks Eric for the review of the last iteration.  This version
> >> drops the patch to expose the helper to check casefolding directories,
> >> since it is not necessary in ecryptfs and it might be going away.  It
> >> also addresses some documentation details, fix a build bot error and
> >> simplifies the commit messages.  See the changelog in each patch for
> >> more details.
> >> 
> >> [...]
> >
> > Ok, let's put it into -next so it sees some testing.
> > So it's too late for v6.7. Seems we forgot about this series.
> > Sorry about that.
> 
> Christian,
> 
> We are approaching -rc2 and, until last Friday, it didn't shown up in
> linux-next. So, to avoid turning a 6 month delay into 9 months, I pushed
> your signed tag to linux-next myself.
> 
> That obviously uncovered a merge conflict: in v6.6, ceph added fscrypt,
> and the caller had to be updated.  I fixed it and pushed again to
> linux-next to get more testing.
> 
> Now, I don't want to send it to Linus myself. This is 100% VFS/FS code,
> I'm not the maintainer and it will definitely raise eyebrows.  Can you
> please requeue and make sure it goes through this time?  I'm happy to

My current understanding is that core dcache stuff is usually handled by
Al. And he's got a dcache branches sitting in his tree.

So this isn't me ignoring you in any way. My hands are tied and so I
can't sort this out for you easily.

> drop my branch from linux-next once yours shows up.
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git/log/?h=negative-dentries
> 
> This branch has the latest version with the ceph conflict folded in.  I
> did it this way because I'd consider it was never picked up and there is
> no point in making the history complex by adding a fix on top of your
> signed tag, since it already fails to build ceph.
> 
> I can send it as a v7; but I prefer you just pull from the branch
> above. Or you can ack and I'll send to Linus.

