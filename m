Return-Path: <linux-fsdevel+bounces-51702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91537ADA676
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 04:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB7616D730
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9A7288510;
	Mon, 16 Jun 2025 02:50:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F28AD58;
	Mon, 16 Jun 2025 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042199; cv=none; b=Kurp4+1XRusrQhmGwDeI02Fo3CMl5sPsgyecljy4eFNDkgnOPQ9s9shwn5N9zrDHBDNqebDdF7jA9jjfdR4IcmE+PwErrrcy7Ba322tAvvBzYenpyjvx3HeS4o/mpkXCXx5Yx58gZ6B+tcHRby5iPcK9hs0RsYQu2PRjvaxKU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042199; c=relaxed/simple;
	bh=DYO+VmXbSPl0n+XcYwRnDBRDmHRWSTPQ63i0cRGdqws=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WcVr4zKR9//CSfKD2lABl0QjtUhjlPikXm6uT1I458VIXVq/AfCxqJ/+fjeF0GnaoQIS3SvPujqdKuwjVkUAUJ0Xb9UG1IbEQ2RZCR3HNpMKu+iCBnXuD4EyFT8dygCXmXpgDCzZgrjupcrjlQqqZDyI5xPWjwQR3vTP0mvSVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uQzuy-00FfCx-Fe;
	Mon, 16 Jun 2025 02:49:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Kees Cook" <kees@kernel.org>, "Joel Granados" <joel.granados@kernel.org>,
 linux-fsdevel@vger.kernel.org, "LKML" <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH v3?] proc_sysctl: remove rcu_dereference() for accessing ->sysctl
In-reply-to: <20250615235714.GG1880847@ZenIV>
References: <175002843966.608730.14640390628578526912@noble.neil.brown.name>,
 <20250615235714.GG1880847@ZenIV>
Date: Mon, 16 Jun 2025 12:49:51 +1000
Message-id: <175004219130.608730.907040844486871388@noble.neil.brown.name>

On Mon, 16 Jun 2025, Al Viro wrote:
> On Mon, Jun 16, 2025 at 09:00:39AM +1000, NeilBrown wrote:
> > 
> > The rcu_dereference() call in proc_sys_compare() is problematic as
> > ->d_compare is not guaranteed to be called with rcu_read_lock() held and
> > rcu_dereference() can cause a warning when used without that lock.
> > 
> > Specifically d_alloc_parallel() will call ->d_compare() without
> > rcu_read_lock(), but with ->d_lock to ensure stability.  In this case
> > ->d_inode is usually NULL so the rcu_dereference() will normally not be
> > reached, but it is possible that ->d_inode was set while waiting for
> > ->d_lock which could lead to the warning.
> 
> Huh?
> 
> There are two call sites of d_same_name() in d_alloc_parallel() - one
> in the loop (under rcu_read_lock()) and another after the thing we
> are comparing has ceased to be in-lookup.  The latter is under ->d_lock,
> stabilizing everything (and it really can't run into NULL ->d_inode
> for /proc/sys/ stuff).

Ok, so ->d_inode will always be non-NULL here, so the rcu_dereference()
will always cause a warning if that code is reached for a proc_sysctl dentry.

> 
> ->d_compare() instances are guaranteed dentry->d_lock or rcu_read_lock();
> in the latter case we'll either recheck or validate on previously sampled
> ->d_seq.  And the second call in d_alloc_parallel() is just that - recheck
> under ->d_lock.
> 
> Just use rcu_dereference_check(...., spin_is_locked(&dentry->d_lock)) and
> be done with that...

We could - but that would be misleading.  And it would still cause a
sparse warning because ->sysctl isn't marked __rcu.

The reality is that ->sysctl does not need rcu protection.  There is no
concurrent update except that it can be set to NULL which is pointless.

For the entire public life of the inode - whenever ->d_compare could
possibly run - there is precisely one "struct ctl_table_header"
associated with the inode.

Once we remove the unnecessary RCU_INIT_POINTER, the ->sysctl pointer is
completely stable and not needing any protection at all.  So it would be
misleading to leave the rcu_dereference{_check}() there.

> 
> The part where we have a somewhat wrong behaviour is not the second call
> in d_alloc_parallel() - it's the first one.  Something like this
> 
> static int proc_sys_compare(const struct dentry *dentry,
> 		unsigned int len, const char *str, const struct qstr *name)
> {
> 	struct ctl_table_header *head;
> 	struct inode *inode;
> 
> 	if (name->len != len)
> 		return 1;
> 	if (memcmp(name->name, str, len))
> 		return 1;
> 
> 	// false positive is fine here - we'll recheck anyway
> 	if (d_in_lookup(dentry))
> 		return 0;

I wonder if it would be good to document that d_compare on a
d_in_lookup() dentry will always be re-checked.  I agree this is a good
way to avoid the possible duplicate dentries.

But this is fixing a different problem than the one I'm trying to fix.
I'm just trying to remove a possible warning and to do so in a way the
makes the code consistent.

Thanks,
NeilBrown


> 
> 	inode = d_inode_rcu(dentry);
> 	// we just might have run into dentry in the middle of __dentry_kill()
> 	if (!inode)
> 		return 1;
> 	head = rcu_dereference_check(PROC_I(inode)->sysctl,
> 				     spin_is_locked(&dentry->d_lock));
> 	return !head || !sysctl_is_seen(head);
> }
> 


