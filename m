Return-Path: <linux-fsdevel+bounces-51540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D21BCAD80E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 04:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813F317FCA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 02:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9B81EF387;
	Fri, 13 Jun 2025 02:18:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B11610C;
	Fri, 13 Jun 2025 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749781104; cv=none; b=IYOwX7CthBTpnDHCPQRUui00OLC3jdZyJLOuUUgNrtXs+I+hw5ZsqnMwH8Lt1wvlMKZoG+EoZhCb+YRDUV2G8KhM+OTQuLeJW8ytYrLEabPXUQ8hgYXhJFMwVSgfQEwbNyC4EcHgFK6hMm2MbruhmfFpdtMYYfe8MtsuTCzp1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749781104; c=relaxed/simple;
	bh=vQZh0BojKe9rNgmmJExHLh+YL6uN/ZsAFvnjSw9pvek=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=c4FYlER+FNDA8M9em6EjIYYnvpqhIaf5lcua5fVFXv+FyNaWadGsYPPAmqXsqoH7LlDw57BdeeqgNOloYvePRBPwjfD8J7yyJ5IMKNnloFiXP4Wk+dgi4EEMbohCztWF9L5NCARigd0+4ACB7vYNXVOH77WeGz7JlYFwHFMQVU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPtzl-009jaA-GO;
	Fri, 13 Jun 2025 02:18:17 +0000
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
Date: Fri, 13 Jun 2025 12:18:17 +1000
Message-id: <174978109711.608730.10518925097265210072@noble.neil.brown.name>

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

Ahh - I misunderstood the meaning of "is_seen".
It means "matches current namespace".
I think I have a slightly better understanding now - thanks.
I'll just remove the rcu stuff, which is pointless.

Thanks,
NeilBrown

