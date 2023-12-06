Return-Path: <linux-fsdevel+bounces-4932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B24C380674C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 07:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57281B210C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A4910A28
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FWmgbgJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258E218F;
	Tue,  5 Dec 2023 21:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=viavlKHXn79anQsa71fh6/Zjw/GhSsUuZjWSRNFZRVQ=; b=FWmgbgJZA7GUPMbXEOfUKiGSVw
	ovD6MSFQOIBPXdYn84y/Kekx3CfcSzCj6FisfiZGZg8JPDqBWRmEhcpSJLyrZgPR05TvGFWPttz6n
	pwb8kP6YB45MlCf0bt5CuCJk9CJ2XVqChSyAJDpRTpa4IJP4cYfsEMvr4q1eHzRBrPThSaKay7kCF
	ukHhCpenorfO31s30YO7jM+fGg7WfN/COTKrRujSR+Gmi1R/LWZq6HfXVjGs/I3B8wSlOugEmmF2X
	EMoyttS9HBXgOsquiAeCJicVhkklahRYdMvH/8TmI2l9OpNiEWLQ2a6b20/8M4e9VI9b9MkErEs6K
	3a/XGeBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAkn4-007c4m-0J;
	Wed, 06 Dec 2023 05:49:46 +0000
Date: Wed, 6 Dec 2023 05:49:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, linux-doc@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()]  1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
Message-ID: <20231206054946.GM1674809@ZenIV>
References: <202311300906.1f989fa8-oliver.sang@intel.com>
 <20231130075535.GN38156@ZenIV>
 <ZWlBNSblpWghkJyW@xsang-OptiPlex-9020>
 <20231201040951.GO38156@ZenIV>
 <20231201065602.GP38156@ZenIV>
 <20231201200446.GA1431056@ZenIV>
 <ZW3WKV9ut7aFteKS@xsang-OptiPlex-9020>
 <20231204195321.GA1674809@ZenIV>
 <ZW/fDxjXbU9CU0uz@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW/fDxjXbU9CU0uz@xsang-OptiPlex-9020>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 06, 2023 at 10:40:15AM +0800, Oliver Sang wrote:
> hi, Al Viro,

> > Oh, well - let's see what profiles show...  I still hope that it's not where
> > the trouble comes from - it would've lead the extra cycles in shrink_dcache_parent()
> > or d_walk() called from it and profiles you've posted do not show that, so...
> > 
> 
> our auto-bisect pointed to
> 3f99656f7bc2f step 5: call __dentry_kill() without holding a lock on parent

Nuts.  All that commit is doing is
	* don't bother with taking parent's ->d_lock in lock_for_kill()
	* don't bother with dropping it in __dentry_kill(), since now we don't have it
	  taken.

And that somehow manages to give a 30% performance drop on that test?

Seriously, not touching parent's ->d_lock aside, there is only one change
I see in there.  Namely,
	having failed trylock on inode
	unlocked dentry
	locked inode
	relocked dentry
	noticed that inode does not match ->d_inode
	... and it turns out that ->d_inode is NULL now
In that situation new variant treats goes "OK, unlock the old
inode and we are done".  The old one unlocked old inode,
unlocked dentry, relocked it, checked that its ->d_inode has
not become non-NULL while we had it unlocked and only then
succeeded.  If ->d_inode has changed, it repeated the whole
loop (unlocked dentry, etc.)

Let's try to isolate that; step 5 split in two and branch
force-pushed.  Instead of
dc3cf789eb259 step 4: make shrink_kill() keep the parent pinned until after __dentry_kill() of victim
3f99656f7bc2f step 5: call __dentry_kill() without holding a lock on parent
we have
dc3cf789eb259 step 4: make shrink_kill() keep the parent pinned until after __dentry_kill() of victim
854e9f938aafe step 4.5: call __dentry_kill() without holding a lock on parent
e2797564725a5 step 5: clean lock_for_kill()
;  git diff e2797564725a5 3f99656f7bc2f
;

Intermediate step preserves the control flow in lock_for_kill() -
the only change in that one is "don't bother with parent's ->d_lock".

The step after it does the change in lock_for_kill() described above.

Could you profile 854e9f938aafe and see where does it fall - is it like
dc3cf789eb259 or like 3f99656f7bc2f?

I really don't get it...

