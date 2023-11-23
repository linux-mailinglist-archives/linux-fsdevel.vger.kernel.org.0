Return-Path: <linux-fsdevel+bounces-3504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFDF7F57AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 06:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B02C1C20C91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 05:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BDDBA34;
	Thu, 23 Nov 2023 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ib38JnkE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1467AD8;
	Wed, 22 Nov 2023 21:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iITGfQea8BxCiD9vKqR4Ix99Hb6hdNI5sOzOQogEaHk=; b=Ib38JnkE8qFEfCsu6aaCR/9lHx
	SMAuzxYNMe57P3S2yZ+Jw3sFPbIN2FDzhDJdjTipjmREeWsMJMU9bz/9gtgibiJOz/22oIQewboOf
	tG2X8/Hjx6DGB/GY+Z2gUUevGHcPgAZrRYpzFj9XC62UIchkqR/KHWqJl8ykOShhPoW3iPAxomT5j
	CGPvkfO5sRHRlLYG5LvHSi6OYIYamRv9t9bv/o+P8+wu+pRxlbE9kc7VpS2zAqgQoujiADDzQpxdF
	yTTiXRP3iC1vH3WjCFTtCwdHZb+peIKUQnpEYL2xZRTRzD6/RbZt9kzOoTN4K+Vl2iW+65S153WS+
	pArIhMlw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r61yB-001vUi-2H;
	Thu, 23 Nov 2023 05:09:43 +0000
Date: Thu, 23 Nov 2023 05:09:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Gabriel Krisman Bertazi <krisman@suse.de>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231123050943.GM38156@ZenIV>
References: <20230816050803.15660-1-krisman@suse.de>
 <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 22, 2023 at 04:18:56PM -0800, Linus Torvalds wrote:
> On Wed, 22 Nov 2023 at 13:19, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > The serious gap, AFAICS, is the interplay with open-by-fhandle.
> 
> So I'm obviously not a fan of igncase filesystems, but I don't think
> this series actually changes any of that.
> 
> > It's not unfixable, but we need to figure out what to do when
> > lookup runs into a disconnected directory alias.  d_splice_alias()
> > will move it in place, all right, but any state ->lookup() has
> > hung off the dentry that had been passed to it will be lost.
> 
> I guess this migth be about the new DCACHE_CASEFOLDED_NAME bit.
> 
> At least for now, that is only used by generic_ci_d_revalidate() for
> negative dentries, so it shouldn't matter for that d_splice_alias()
> that only does positive dentries. No?
> 
> Or is there something else you worry about?

Dentries created by d_obtain_alias() will never go anywhere near
generic_set_encrypted_ci_d_ops().  They do *not* get ->d_op set
that way.  When ext4_lookup() does a lookup in c-i directory it
does have ->d_op set on dentry it got from the caller.  Which is
promptly discarded when d_splice_alias() finds a preexisting
alias for it.

Positive dentries eventually become negative; not invalidating them
when that happens is a large part of the point of this series.
->d_revalidate() is taught to check if they are marked with that
bit, but... they won't have that ->d_revalidate() associated with
them, will they?  ->d_hash() and ->d_compare() come from the
parent, but ->d_revalidate() comes from dentry itself.

In other words, generic_ci_d_revalidate() won't see the lack of
that bit on dentry, etc. - it won't be called for that dentry
in the first place.

