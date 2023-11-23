Return-Path: <linux-fsdevel+bounces-3563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F667F68BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 22:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C501C20B2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 21:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D4818057;
	Thu, 23 Nov 2023 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V/sOzXqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBABD68;
	Thu, 23 Nov 2023 13:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3YrLjUsJBUZ/bf9EaibULjJMkvXQZ6F4MemzMTeG2xs=; b=V/sOzXqbleSNlNvhcFnifsfTSi
	LlpDm5blpb37lUsF0cxNGOlevEPrYSj+W0nDw5f71OEBej2S1XdNBcMGk45KrF3eMrH9tmGWfbC4o
	hdFEnuJXXiW70XHQokbDrwUP2kEHSks+adeTf3jkvN/ud6qKju8/Tp55UB7P4lmiRirr3FmDLwLqz
	Arg1zOnwLhCFVZ3ZzKnUAobBwMlckYxIZSiFNpEGyt88azwPTmXxypcLLkSbMEmAPNwCxGebrpWUC
	jztkZ5uRhna9SX/x0le6tswJQzWOfPWxjY6V0bQkfZe5ZDENuNOy1ZkJ02WHQzYsfCxRs4qDOY3cR
	Y2ZX5wow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Hcg-002GWu-2Z;
	Thu, 23 Nov 2023 21:52:34 +0000
Date: Thu, 23 Nov 2023 21:52:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231123215234.GQ38156@ZenIV>
References: <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <87bkbki91c.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkbki91c.fsf@>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 23, 2023 at 02:06:39PM -0500, Gabriel Krisman Bertazi wrote:

> >
> > 4. d_move() and d_exchange() would ignore the value returned by __d_move();
> > __d_unalias() turn
> >         __d_move(alias, dentry, false);
> > 	ret = 0;
> > into
> > 	ret = __d_move(alias, dentry, Splice);
> > d_splice_alias() turn
> > 				__d_move(new, dentry, false);
> > 				write_sequnlock(&rename_lock);
> > into
> > 				err = __d_move(new, dentry, Splice);
> > 				write_sequnlock(&rename_lock);
> > 				if (unlikely(err)) {
> > 					dput(new);
> > 					new = ERR_PTR(err);
> > 				}
> > (actually, dput()-on-error part would be common to all 3 branches
> > in there, so it would probably get pulled out of that if-else if-else).
> >
> > I can cook a patch doing that (and convert the obvious beneficiaries already
> > in the tree to it) and throw it into dcache branch - just need to massage
> > the series in there for repost...
> 
> if you can write that, I'll definitely appreciate it. It will surely
> take me much longer to figure it out myself.

Speaking of other stuff in the series - passing the expected name to
->d_revalidate() is definitely the right thing to do, for a lot of
other reasons.  We do have ->d_name UAF issues in ->d_revalidate()
instances, and that allows to solve them nicely.

It's self-contained (your 2/9 and 3/9), so I'm going to grab that
into a never-rebased branch, just to be able to base the followups
propagating the use of stable name into instances.

Anyway, need to finish writing up the description of existing dcache
series first...

