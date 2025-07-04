Return-Path: <linux-fsdevel+bounces-53872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1A4AF853E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 03:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4A44A83C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828819F48D;
	Fri,  4 Jul 2025 01:40:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5218DF80;
	Fri,  4 Jul 2025 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751593221; cv=none; b=WrSozTh5BNCT/GQeS33nPT3fC3l255thQZTYehtln2ZyF2G4WvI73CnIDYRVa4klvNS0OrCPb6aFpbSHP19Qr6/xJB9pYw5nSqbwHHW/iOLRmJCgM4J6TngpRnNm9Dt/Usqm+P7d53kY5Olr7gg3nTdBVSpG17QyByCuejZsXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751593221; c=relaxed/simple;
	bh=OGTvTBOp6xDBWmqgcMuRz4SoHTb8KMn3mwjf01V44hc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZxJ0n9XkkxL47v8aFjkv1JI80w7zW6uK03GkPFhLcPepxnsxJosf6rp8Fctxw3mujwRZizSDNaRzDdcChCN5z3wCkzAU10DZbvbXqCHOAbp2EBRMTy8399Qrq7Sp4ZUdqGPioRDCLPBDkQH8i62sqiWfI1kMP7z63dO2TPS0rEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uXVOb-001KdI-3V;
	Fri, 04 Jul 2025 01:39:22 +0000
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
In-reply-to: <20250703234313.GM1880847@ZenIV>
References: <>, <20250703234313.GM1880847@ZenIV>
Date: Fri, 04 Jul 2025 11:39:16 +1000
Message-id: <175159315670.565058.128329102948224076@noble.neil.brown.name>

On Fri, 04 Jul 2025, Al Viro wrote:
> On Mon, Jun 16, 2025 at 12:49:51PM +1000, NeilBrown wrote:
> 
> > The reality is that ->sysctl does not need rcu protection.  There is no
> > concurrent update except that it can be set to NULL which is pointless.
> 
> I would rather *not* leave a dangling pointer there, and yes, it can
> end up being dangling.  kfree_rcu() from inside the ->evict_inode()
> may very well happen earlier than (also RCU-delayed) freeing of struct
> inode itself.

In that case could we move the proc_sys_evict_inode() call from
proc_evict_inode() to proc_free_inode(), and replace kfree_rcu() with
kfree()?
Or does the inode need to be deleted from ->sibling_inodes earlier than
free_inode?

> 
> What we can do is WRITE_ONCE() to set it to NULL on the evict_inode
> side and READ_ONCE() in the proc_sys_compare().

That is likely the simplest change.

Thanks,
NeilBrown

> 
> The reason why the latter is memory-safe is that ->d_compare() for
> non-in-lookup dentries is called either under rcu_read_lock() (in which
> case observing non-NULL means that kfree_rcu() couldn't have gotten to
> freeing the sucker) *or* under ->d_lock, in which case the inode can't
> reach ->evict_inode() until we are done.
> 
> So this predicate is very much relevant.  Have that fucker called with
> neither rcu_read_lock() nor ->d_lock, and you might very well end up
> with dereferencing an already freed ctl_table_header.
> 


