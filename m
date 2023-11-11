Return-Path: <linux-fsdevel+bounces-2755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB747E8C36
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 19:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066FF1F20F98
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 18:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BBE1C2A0;
	Sat, 11 Nov 2023 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uD2fZaas"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27818E23
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Nov 2023 18:50:38 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAAD386F;
	Sat, 11 Nov 2023 10:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SG8fPIFozBbMpkML4WzGjjItf6rcjkTSfGyUBdfRR0w=; b=uD2fZaas6I/cHqge5VRIKujNVg
	q4DqzkLYFO4N6q7zVcEUvNKkByvaBC/1cznprFGu8e2RxmwwIBV0XHQKeFv9ZrkuGZgdHXHe/kdh1
	JqbzlyXqeJ9kGrhe1bYfeplyNdNJRDRRuC2U7S1Eb6E17F63x2kl78A2W+zwiujLD7zOd6OYi5zU5
	fXE/AbMp60vTTUhYH1b06gyh/4ME1rLXKhcS1d9oqkkBcBsK53o3H65VmR65WXhGTPTrZW6ZfmohM
	6A9lLVVunIcCwqaJAtQQlEF0JHW6r/polS/GtKi5RQo5Haty1GtmiOZDmeKkwINZwiHaImF5wknwa
	uKiop1yQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r1t3y-00ERzy-1t;
	Sat, 11 Nov 2023 18:50:34 +0000
Date: Sat, 11 Nov 2023 18:50:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][overlayfs] do we still need d_instantiate_anon() and
 export of d_alloc_anon()?
Message-ID: <20231111185034.GP1957730@ZenIV>
References: <20231111080400.GO1957730@ZenIV>
 <CAOQ4uxhQdHsegbwdqy_04eHVG+wkntA2g2qwt9wH8hb=-PtT2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhQdHsegbwdqy_04eHVG+wkntA2g2qwt9wH8hb=-PtT2A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 11, 2023 at 08:31:11PM +0200, Amir Goldstein wrote:
> > in ovl_lookup(), and in case we have d_splice_alias() return a non-NULL
> > dentry we can simply copy it there.  Sure, somebody might race with
> > us, pick dentry from hash and call ->d_revalidate() before we notice that
> > DCACHE_OP_REVALIDATE could be cleaned.  So what?  That call of ->d_revalidate()
> > will find nothing to do and return 1.  Which is the effect of having
> > DCACHE_OP_REVALIDATE cleared, except for pointless method call.  Anyone
> > who finds that dentry after the flag is cleared will skip the call.
> > IOW, that race is harmless.
> 
> Just a minute.
> Do you know that ovl_obtain_alias() is *only* used to obtain a disconnected
> non-dir overlayfs dentry?

D'oh...

> I think that makes all the analysis regarding race with d_splice_alias()
> moot. Right?

Right you are.

> Do DCACHE_OP_*REVALIDATE even matter for a disconnected
> non-dir dentry?

As long as nothing picks it via d_find_any_alias() and moves it somewhere
manually.  The former might happen, the latter, AFAICS, doesn't - nothing
like d_move() anywhere in sight...

> You are missing that the OVL_E_UPPER_ALIAS flag is a property of
> the overlay dentry, not a property of the inode.
> 
> N lower hardlinks, the first copy up created an upper inode
> all the rest of the N upper aliases to that upper inode are
> created lazily.
> 
> However, for obvious reasons, OVL_E_UPPER_ALIAS is not
> well defined for a disconnected overlay dentry.
> There should not be any code (I hope) that cares about
> OVL_E_UPPER_ALIAS for a disconnected overlay dentry,
> so I *think* ovl_dentry_set_upper_alias() in this code is moot.
> 
> I need to look closer to verify, but please confirm my assumption
> regarding the irrelevance of  DCACHE_OP_*REVALIDATE for a
> disconnected non-dir dentry.

Correct; we only care if it gets reconnected to the main tree.
The fact that it's only for non-directories simplifies life a lot
there.  Sorry, got confused by the work you do with ->d_flags
and hadn't stopped to ask whether it's needed in the first place
in there.

OK, so... are there any reasons why simply calling d_obtain_alias()
wouldn't do the right thing these days?

