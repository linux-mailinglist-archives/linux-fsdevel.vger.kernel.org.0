Return-Path: <linux-fsdevel+bounces-48293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40344AACE5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8176A3B6984
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A8B20E030;
	Tue,  6 May 2025 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OmlsrX6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F0120CCC9;
	Tue,  6 May 2025 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560934; cv=none; b=j1lj7DKskVFYYoEbXR+c6U8PFyifm5UDelbl4nRKUspp+5raiwbvqLEpEan55m0oXhMl6pwjA7xu7yhzoxqFE30aTuI4ZJ1nj+a81pN0Bd9KhyPgdXCcUXzLuYFXobhY3LBKtsKP/DTdf+RjOuXSOgP5nm/YvDD4RqgjXjzboo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560934; c=relaxed/simple;
	bh=MOpqwhBmL84ktvflsNGotPKNyN3JovNc0XIRmZ9dr3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB0SsLs4Hwc6OriVge9HYh2qX8jc23QUWTUDvd6PqKZNwjZQiYyq52acQm9bje2VKsP1MGQ4dXQRe1xD8WMa9x2QF1xQ3F2Ynjgz1q4o0kYfUv+mx2XHiMuq8aO3FBseq5j41VnkfbmzwBjXze1R7Wr7orveUDBKSFBI3o//ftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OmlsrX6c; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/4vDrddZbD83/HsMao5TSO+wLyzPvUkoUxAbhxnpMuQ=; b=OmlsrX6c/99XBiwJuhh9j/3NhR
	0VT3ZHiifw7vG9B2RzpBLK7g1Q4YAvsbMEd8VSSW4x5vm4ZMitkEPUM03igMc+EdUU5FSkUrn2KiU
	IRT/Ej5Qqe3rB6Rxag9jxr4eli4lbQeOOeuazdIm33INrEOlMKBJ7Ljh6iV9qZONEziHIlzTQnQzn
	2oM/i9oUo1di9UVUor/no4m0tUMUJKdjF11F+kkbxeqn7rzsm2C33VaSsn3LVxQSyRgDky8MKvd0E
	GthJEwCIDPsSfDRSk/JpKJgvek62TEV9dWz4JQapyAcKgyX7mUa9z6cKmUDI1oTQhBNqszEiEkWrq
	+WVGwcqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOHZ-0000000CQD4-1S4A;
	Tue, 06 May 2025 19:48:49 +0000
Date: Tue, 6 May 2025 20:48:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Klara Modin <klarasmodin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250506194849.GT2023217@ZenIV>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
 <20250506172539.GN2023217@ZenIV>
 <j2tom2y6562wa7r6wjsxwgc25t3uoine45ills367o4y2booxr@3jdyomwkvt6w>
 <20250506175104.GO2023217@ZenIV>
 <4pg5rjsoxzxjgcx2wzucw2wr7uvaxws423stdlv75t2udfkash@jff3ci54z35u>
 <20250506181604.GP2023217@ZenIV>
 <juv6ldm6i53onsz355znrhcivf6bmog25spdkvnlvydhansmao@bpzxifunwl2n>
 <20250506190513.GQ2023217@ZenIV>
 <ukytl7lwaprjovct6qvkgdqaou6kt3pxpjdocv5r45r6unpjbx@qjq6ffj4x3x7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ukytl7lwaprjovct6qvkgdqaou6kt3pxpjdocv5r45r6unpjbx@qjq6ffj4x3x7>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 06, 2025 at 09:20:47PM +0200, Klara Modin wrote:

> I then get:
> 
> [    0.881616] absolute root
> [    0.881618] our namespace, at that

OK, so that's a combination of braino (times 2) in that patch
with quiet regression in clone_private_mount() from back in
January.

Reposted with fixes folded in and yes, you are absolutely
correct about the second 'fc' instead of 'dup_fc' in there.

As for the clone_private_mount() issues...  Christian has
taught it to allow roots of anon namespaces in addition to
mounts in our namespace, but did the tests in wrong order.

It's not a rare pattern - "do something to mount in our namespace
or the root of anon one" and for things like move_mount()
we absolutely do *not* want to allow it for root of our namespace,
so there this logics is fine - first split on whether it has
a parent, then for parented ones require the namespace to be
ours and for roots - require it to be anon.

In case of clone_private_mount(), though, there's nothing wrong
with "clone me a subtree of absolute root", so it has to be
done other way round - check if it's ours first, then in "not
ours" case check that it's a root of anon namespace.

Failing btrfs mount has ended up with upper layer pathname
pointing to initramfs directory where btrfs would've been
mounted, which had walked into that corner case.  In your
case the problem has already happened by that point, but on
a setup a-la X Terminal it would cause trouble...

