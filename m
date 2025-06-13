Return-Path: <linux-fsdevel+bounces-51541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D14AD8110
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 04:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F003B18987F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 02:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3D9244691;
	Fri, 13 Jun 2025 02:37:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A16C23AE62;
	Fri, 13 Jun 2025 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749782258; cv=none; b=JFRcd8ImafO22RtFY7KD1QHeg+exLgEPS579ZCm0LEfJwi/AN/KNboFSLRhz82M5Nr9JpT6l8T7xp/Ez4cSfjUgH/z/SGWzq8g5fxXJzgGVUMT7sKk5m+RueZ1ffH9WRCtZhWMKXa5YlaCWhww4nKYYnBCOgrFay9TQvdnOxdVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749782258; c=relaxed/simple;
	bh=LJWAuQOr6gJLtbQ1+3X2NJZqAsFLjMQDr8H9MVFlA3g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PnSSm4vvRUWoFFVSrXYwmEMBZIiNS5EryuAAbRJezfAOFLDh0qNDYL8V4Mbp+tp+xbZQ+p9p61/AtjmXL4HVqloqeiJFik2ofgLYwIxSuTkXIPWdF1wW/iGtCuUdhzqebG/3IuSSinKSKxgYHMbJS37NeD2CWalkvsgqDa/ZYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPuIP-009mxQ-Fe;
	Fri, 13 Jun 2025 02:37:33 +0000
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
Subject: Re: [PATCH] proc_sysctl: Fix up ->is_seen() handling
In-reply-to: <20250613020111.GE1647736@ZenIV>
References: <>, <20250613020111.GE1647736@ZenIV>
Date: Fri, 13 Jun 2025 12:37:33 +1000
Message-id: <174978225309.608730.8864073362569294982@noble.neil.brown.name>

On Fri, 13 Jun 2025, Al Viro wrote:
> On Fri, Jun 13, 2025 at 02:54:21AM +0100, Al Viro wrote:
> > On Fri, Jun 13, 2025 at 10:37:58AM +1000, NeilBrown wrote:
> > > 
> > > Some sysctl tables can provide an is_seen() function which reports if
> > > the sysctl should be visible to the current process.  This is currently
> > > used to cause d_compare to fail for invisible sysctls.
> > > 
> > > This technique might have worked in 2.6.26 when it was implemented, but
> > > it cannot work now.  In particular if ->d_compare always fails for a
> > > particular name, then d_alloc_parallel() will always create a new dentry
> > > and pass it to lookup() resulting in a new inode for every lookup.  I
> > > tested this by changing sysctl_is_seen() to always return 0.  When
> > > all sysctls were still visible and repeated lookups (ls -li) reported
> > > different inode numbers.
> > 
> > What do you mean, "name"?
> 
> The whole fucking point of that thing is that /proc/sys/net contents for
> processes in different netns is not the same.  And such processes should
> not screw each other into the ground by doing lookups in that area.
> 
> Yes, it means multiple children of the same dentry having the same name
> *and* staying hashed at the same time.
> 

If two threads in the same namespace look up the same name at the same
time (which previously didn't exist), they will both enter
d_alloc_parallel() where neither will notice the other, so both will
create and install d_in_lookup() dentries, and then both will call
->lookup, creating two identical inodes.

I suspect that isn't fatal, but it does seem odd.

Maybe proc_sys_compare should return 0 for d_in_lookup() (aka !inode)
dentries, and then proc_sys_revalidate() can perform the is_seen test
and return -EAGAIN if needed, and __lookup_slow() and others could
interpret that as meaning to "goto again" without calling
d_invalidate().

Maybe.

NeilBrown

