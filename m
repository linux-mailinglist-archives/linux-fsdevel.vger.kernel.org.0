Return-Path: <linux-fsdevel+bounces-38561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F472A03E7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 13:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2270A18803A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8641E25FE;
	Tue,  7 Jan 2025 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="J4lkPJBO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378898C1E;
	Tue,  7 Jan 2025 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251406; cv=none; b=E7azBj4QLjVsN16h+rkgMO+eFbZQtxTNQ2659pOpk8wXaSuL/Pdlz+BQV+KimvOiOkR4J7botBQheJ8zndCCA/pQCTEbAgkCYn/tO5uO9Hcw5CxNji47K9u2rMieUbfQxwckK1V/0FA5OexlaW1wltS4NjSbxjLk1a1+EILZ6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251406; c=relaxed/simple;
	bh=Q3AsT43SmSRP+nitd8Ran57PP3jfeFUiHGozaUyhrX4=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=pzOMR5Aij0Spl5+vOCvwvXqhtrVm6bou3UdZyEAUVRyg+Vwra+M3ySw3ZjooFPhz9ro8ZNbyVZSPmBBCnYBHW5Hd9/vESVv8uEcYVCk4zwh0MlI2gOiqOWjKPJbm2YZ6fMMFvYMk60h/S7rsM151q0HRQVRgJlZpVb0U0AzP3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=J4lkPJBO; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <14271ed82a5be7fcc5ceea5f68a10bbd@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1736251394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3XYQZjfmPw1rESA4PsPNxtkwfMccg6wZ10QaSbm/jqE=;
	b=J4lkPJBO1KxqKqv3nXlPb6286rFUlxCe5kR5gAYbQvQdE+Y1v2dU//WJ6ivo3K1LYNt1oJ
	loW8KTIT+8q4VP1hFC7UL9zjM8ByqiTnFyLpPsO1d3ZKyBDHrampcJvHRndGQxzUI1dAsI
	lSb3N3rNj04Xd4As4hmpBDrw+9pEbvcKCk4W1rRg8cHFphvB5IFzwhkND2K3peeQBmAxce
	i8E12TML8VcIEyssxIHODKFIQRS4wf8f5uAX5OoegYq9IpEk3OB4Y2QzKoY/eRhw0YOb9R
	uwoLpjZ5UA3baT1J6hqP+YXHU+HzibOsUq7b95blVE9Axh89qTtesZ73tryqQw==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>, nicolas.baranger@3xo.fr
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>, Christian
 Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix kernel async DIO
In-Reply-To: <286638.1736163444@warthog.procyon.org.uk>
References: <fedd8a40d54b2969097ffa4507979858@3xo.fr>
 <669f22fc89e45dd4e56d75876dc8f2bf@3xo.fr>
 <286638.1736163444@warthog.procyon.org.uk>
Date: Tue, 07 Jan 2025 09:03:11 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> netfs: Fix kernel async DIO
>
> Netfslib needs to be able to handle kernel-initiated asynchronous DIO that
> is supplied with a bio_vec[] array.  Currently, because of the async flag,
> this gets passed to netfs_extract_user_iter() which throws a warning and
> fails because it only handles IOVEC and UBUF iterators.  This can be
> triggered through a combination of cifs and a loopback blockdev with
> something like:
>
>         mount //my/cifs/share /foo
>         dd if=/dev/zero of=/foo/m0 bs=4K count=1K
>         losetup --sector-size 4096 --direct-io=on /dev/loop2046 /foo/m0
>         echo hello >/dev/loop2046
>
> This causes the following to appear in syslog:
>
>         WARNING: CPU: 2 PID: 109 at fs/netfs/iterator.c:50 netfs_extract_user_iter+0x170/0x250 [netfs]
>
> and the write to fail.
>
> Fix this by removing the check in netfs_unbuffered_write_iter_locked() that
> causes async kernel DIO writes to be handled as userspace writes.  Note
> that this change relies on the kernel caller maintaining the existence of
> the bio_vec array (or kvec[] or folio_queue) until the op is complete.
>
> Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
> Reported by: Nicolas Baranger <nicolas.baranger@3xo.fr>
> Closes: https://lore.kernel.org/r/fedd8a40d54b2969097ffa4507979858@3xo.fr/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <smfrench@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/direct_write.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

LGTM.  Feel free to add:

Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>

Thanks Christoph and Dave!

