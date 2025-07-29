Return-Path: <linux-fsdevel+bounces-56239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A75B14B62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 11:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A458854616E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BDB288C34;
	Tue, 29 Jul 2025 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QXNhDOUy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507ED288C2B;
	Tue, 29 Jul 2025 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781766; cv=none; b=o2vLcpZuAixcDbJbRJM2qNlNATaxq3xevznuLnR5m+d1EMhusIbziOcQ+PEZ/npz27oJHILaCaca9xoEFO1AS19fDEBgMrVR7cdRdwh/9Gw0ozUZf2/fStFT1YwOAPNbTq7mzB7ih0BNGNTQlASm1uUYAwWDRbw6raeDPc0MDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781766; c=relaxed/simple;
	bh=8AwUQ9fVpyImxY8loUrEjisDgslKjuHSHNy0Yuacf/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXfopBRUMCwFfX+j9oQliUU4g860RK4rwA/7a+0HyyqjXnhIUPiVwlLt23adcSCVCY9ZqfbHZBKoVu76kST2cm6dzeXue2DXlPUXaW293vGvJ/2kpnC1fAuZfEPsao2fk2R7wdj10Ka5HAZBcWDq2AvmBzcMmYq81l25bJW1bLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QXNhDOUy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vv/tvkE1zh1PRBBPPlYH+kgWupwweG052svNNlKPXuA=; b=QXNhDOUyjVJu6q7u6bMHNP1Wut
	xupn4hIMzM1PWpzilr3rnkTVCj1i6ybPCVRHbrZwnG6q5f7ScSNZ3jtwxkszOmq65jPu1bIr/H9gx
	2/3HjrgQ8iHK26WouYpT9dQWK7FBs4ismvDgEvyYW8/OkVQI/VTfL3nRkr8xz4HfFcvDWOJLfwl9+
	yix1gVX85Wmwbmuk5Ek1jINOthlGh/zjkSCIUnGXVtf/NAw6v7AyHWwmlHCLLXuXNwvSmTX4f838E
	uFhdCAkNKmqQnREIVSBY1vV4SS4cImQdRZgz2xXPky6qrdMRMVBZ4X0aVYjqodjFGjrNvSWCPhh5p
	J9jEOtJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uggkY-00000001cd6-39yn;
	Tue, 29 Jul 2025 09:35:58 +0000
Date: Tue, 29 Jul 2025 10:35:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] fat: Prevent the race of read/write the FAT32 entry
Message-ID: <20250729093558.GG222315@ZenIV>
References: <tencent_341B732549BA50BB6733349E621B0D4B7A08@qq.com>
 <tencent_24D0464B099CEEC72EFD4C95A7FB86DB9206@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_24D0464B099CEEC72EFD4C95A7FB86DB9206@qq.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 29, 2025 at 02:17:10PM +0800, Edward Adam Davis wrote:
> syzbot reports data-race in fat32_ent_get/fat32_ent_put. 
> 
> 	CPU0(Task A)			CPU1(Task B)
> 	====				====
> 	vfs_write
> 	new_sync_write
> 	generic_file_write_iter
> 	fat_write_begin
> 	block_write_begin		vfs_statfs
> 	fat_get_block			statfs_by_dentry
> 	fat_add_cluster			fat_statfs
> 	fat_ent_write			fat_count_free_clusters
> 	fat32_ent_put			fat32_ent_get
> 
> Task A's write operation on CPU0 and Task B's read operation on CPU1 occur
> simultaneously, generating an race condition.
> 
> Add READ/WRITE_ONCE to solve the race condition that occurs when accessing
> FAT32 entry.

	Solve it in which sense?  fat32_ent_get() and fat32_ent_put()
are already atomic wrt each other; neither this nor your previous
variant change anything whatsoever.  And if you are talking about the
results of *multiple* fat32_ent_get(), with some assumptions made by
fat_count_free_clusters() that somehow get screwed by the modifications
from fat_add_cluster(), your patch does not prevent any of that (not
that you explained what kind of assumptions would those be).

	Long story short - accesses to individual entries are already
atomic wrt each other; the fact that they happen simultaneously _might_
be a symptom of insufficient serialization, but neither version of your
patch resolves that in any way - it just prevents the tool from reporting
its suspicions.

	It does not give fat_count_free_clusters() a stable state of
the entire table, assuming it needs one.  It might, at that - I hadn't
looked into that code since way back.  But unless I'm missing something,
the only thing your patch does is making your (rather blunt) tool STFU.

	If there is a race, explain what sequence of events leads to
incorrect behaviour and explain why your proposed change prevents that
incorrect behaviour.

	Note that if that behaviour is "amount of free space reported
by statfs(2) depends upon how far did the ongoing write(2) get", it
is *not* incorrect - that's exactly what the userland has asked for.
If it's "statfs(2) gets confused into reporting an amount of free space
that wouldn't have been accurate for any moment of time (or, worse yet,
crashes, etc.)" - yes, that would be a problem, but it could not be
solved by preventing simultaneous access to *single* entries, if it
happens at all.

