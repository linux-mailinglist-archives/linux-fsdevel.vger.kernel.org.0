Return-Path: <linux-fsdevel+bounces-39156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AC3A10B9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 17:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9415E7A5898
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9521ADC88;
	Tue, 14 Jan 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="SJ9FN+Q/";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="SJ9FN+Q/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C64190077
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870391; cv=none; b=IVN/Iv5lffgV6+OBjHh1eDCsw3QeswfGendoQMV2NTp2gKRsKr+JjT1aUQCt63f1aobDPsG4BE+4bUK016Qkud4zIxEKOFnXEi5JTPRZj2RlswlZKJoUD2fAfij3YS8rCtemaVjSUxynhmuswVDDePae9iKOAZkcI+97yxw8smQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870391; c=relaxed/simple;
	bh=aDMf0Oz6JrVFSS1OF87mdIRWcjKT4Mpu785y4e96QRA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=frTjDiSZEumz2UmA643nREbflBwkcSwHekwu9E1oLU3r3bi173+zmxXZAFTtWN3bMW057fyrKpCcCBLkkI6Heahi3LZyXtYwWiAmde7rl1z1B1JYPgn+2/zWB6j34bYc9KEQhecyhajJjtRwxxJiuO5xRI8F3vcGF9Osu3GnwVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=SJ9FN+Q/; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=SJ9FN+Q/; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736870388;
	bh=aDMf0Oz6JrVFSS1OF87mdIRWcjKT4Mpu785y4e96QRA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=SJ9FN+Q/LEex9sIUvLX/j2Lkuv6ou02LtfdY3g1Fd/KQUyDIfq9myy3cLADd3pT6P
	 1nMv6VnwQzcAQzzeeNqVUJhhJ+emqxJMfatPlOIuc/umx0xxjRvxljFoTg61SjzwxE
	 33Szp2l6X/CAF9LWkd2K0uEh62vfH71Gfk0YUt6U=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6FEEA1287756;
	Tue, 14 Jan 2025 10:59:48 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Z2d66Q_SSJ9B; Tue, 14 Jan 2025 10:59:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736870388;
	bh=aDMf0Oz6JrVFSS1OF87mdIRWcjKT4Mpu785y4e96QRA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=SJ9FN+Q/LEex9sIUvLX/j2Lkuv6ou02LtfdY3g1Fd/KQUyDIfq9myy3cLADd3pT6P
	 1nMv6VnwQzcAQzzeeNqVUJhhJ+emqxJMfatPlOIuc/umx0xxjRvxljFoTg61SjzwxE
	 33Szp2l6X/CAF9LWkd2K0uEh62vfH71Gfk0YUt6U=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5EE241287243;
	Tue, 14 Jan 2025 10:59:47 -0500 (EST)
Message-ID: <a143314b5751bc437fd16765ac1608b1210671fa.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Predictive readahead of dentries
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Shyam Prasad N <nspmangalore@gmail.com>, 
 lsf-pc@lists.linux-foundation.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>,  linux-mm@kvack.org, brauner@kernel.org,
 Matthew Wilcox <willy@infradead.org>,  David Howells <dhowells@redhat.com>,
 Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, 
 trondmy@kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>
Date: Tue, 14 Jan 2025 10:59:46 -0500
In-Reply-To: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
References: 
	<CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2025-01-14 at 09:08 +0530, Shyam Prasad N wrote:
> The Linux kernel does buffered reads and writes using the page cache
> layer, where the filesystem reads and writes are offloaded to the
> VM/MM layer. The VM layer does a predictive readahead of data by
> optionally asking the filesystem to read more data asynchronously
> than what was requested.
> 
> The VFS layer maintains a dentry cache which gets populated during
> access of dentries (either during readdir/getdents or during lookup).
> This dentries within a directory actually forms the address space for
> the directory, which is read sequentially during getdents. For
> network filesystems, the dentries are also looked up during
> revalidate.
> 
> During sequential getdents, it makes sense to perform a readahead
> similar to file reads. Even for revalidations and dentry lookups,
> there can be some heuristics that can be maintained to know if the
> lookups within the directory are sequential in nature. With this, the
> dentry cache can be pre-populated for a directory, even before the
> dentries are accessed, thereby boosting the performance. This could
> give even more benefits for network filesystems by avoiding costly
> round trips to the server.

If your theory were correct, especially the bit about using the dentry
cache to retain the readahead information, wouldn't a precursor
actually be populating the dentry cache on iterate_dir() which is the
engine for both the readdir() and getdents() syscalls?  It strikes me
the reason we don't do dentry population here is partly because the
lookup() on each name would slow everything down (iterate_dir is very
locking light weight because it needs to be fast) and partly because
whatever is doing the directory read may only be interested in a single
name.  The only userspace operation you can guarantee is going to do a
lookup() for every name is ls -l, but that doesn't seem to be a good
one to optimize for.

Regards,

James


