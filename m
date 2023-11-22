Return-Path: <linux-fsdevel+bounces-3489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52DE7F5273
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C852281669
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6D1C686;
	Wed, 22 Nov 2023 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mI/nBUzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF71E1A5;
	Wed, 22 Nov 2023 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GbGgxXd0D6P3kK6eEYEOVB7NqqPtigeykui8LfkWNZM=; b=mI/nBUzbuLRl8y71pGzGwG3AqE
	9nwjsJ2gz+NhHF9XD6iYO4i+9WjMVuzBqAY16Wd/yrssV0AaFAv02ZkujqU5S78p8rOPo/SUuyk4W
	8/nT5AO6eLxpRd56238mkk7z92XdfpSyf1N4qCYODg2gNDegCwfS36EIdJMnpzbyg7jIOIqlm60a2
	cN+L44mlhZcn4bOy1TdDvE3F2HyesD2+3TOjf/yriqIuoujbwk+Nw4r8tfbC6bs0khIm3iyEeR0VO
	hr8fiUavTzkDlQHsYuue1vVtFUt9QBG1qUpXfi8yRo5l95o54GwvPikZo1kq4tHNgUWZHJcpxjlAn
	H3hu8bYw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5ucf-001mtu-1r;
	Wed, 22 Nov 2023 21:19:01 +0000
Date: Wed, 22 Nov 2023 21:19:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Gabriel Krisman Bertazi <krisman@suse.de>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231122211901.GJ38156@ZenIV>
References: <20230816050803.15660-1-krisman@suse.de>
 <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121022734.GC38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 21, 2023 at 02:27:34AM +0000, Al Viro wrote:

> I will review that series; my impression from the previous iterations
> had been fairly unpleasant, TBH, but I hadn't rechecked since April
> or so.

The serious gap, AFAICS, is the interplay with open-by-fhandle.
It's not unfixable, but we need to figure out what to do when
lookup runs into a disconnected directory alias.  d_splice_alias()
will move it in place, all right, but any state ->lookup() has
hung off the dentry that had been passed to it will be lost.

And I seriously suspect that we want to combine that state
propagation with d_splice_alias() (or its variant to be used in
such cases), rather than fixing the things up afterwards.

In particular, propagating ->d_op is really not trivial at that
point; it is safe to do to ->lookup() argument prior to d_splice_alias()
(even though that's too subtle and brittle, IMO), but after
d_splice_alias() has succeeded, the damn thing is live and can
be hit by hash lookups, revalidate, etc.

The only things that can't happen to it are ->d_delete(), ->d_prune(),
->d_iput() and ->d_init().  Everything else is fair game.

And then there's an interesting question about the interplay with
reparenting.  It's OK to return an error rather than reparent,
but we need some way to tell if we need to do so.

