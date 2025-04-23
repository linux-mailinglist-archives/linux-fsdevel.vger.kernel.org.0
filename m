Return-Path: <linux-fsdevel+bounces-47142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6284A99BAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 00:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F234611C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 22:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF262223DCF;
	Wed, 23 Apr 2025 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="dkEyF2Ls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3571F584E;
	Wed, 23 Apr 2025 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745448607; cv=none; b=AbGK23Yb35hxhLVoC4xuKf2sgCcOloGKkD6hCh0zW0ej9+3qahHOzXhHfJuPhmYFcBh/JXlPTpSFKrHJHdyr2s4Xz/wb4biPGKWxO00etoQKQ0ZUR8gG+3ME2XP/gclBqQpsWFsXb5XZ6t1OuZAFs5aguERVBEU46jCQlobUQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745448607; c=relaxed/simple;
	bh=gurGA5DvPR7ijUfbURSFtgXSMzhd2JubECzI5/j0278=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=KzHBzRnIEUbx0cRyAj0j/vC0dTK0coLr1oFfaYum7AUa6L+ex8lK1kbSi080XCNEqN8Jjp8hfAUQc5yedkO40mmw5yeevxbzk1jMJZ313It/SWFOfvTpyCfmpfbrcPT+Eb6/EzRTaDpvh+3O+G9jSTrA4SnNG9OSk811lb8Ra1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=dkEyF2Ls; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <2d912187be794438cf6a9f6e7e0d694b@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1745448598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yqDLqDkzfCLD1y/XctMlv7d7M9f1SUafflmNfC4nFOA=;
	b=dkEyF2Lsci/dhbHFGy4dWOMBdiFrKc9PedskRLUQLJi2b/Q2vug4emf2t1VJNax0kzDlvC
	IFL0yZqs7OeB1MEPwwzXvLEfsyc1cMJVXp1OigwCnjnS6t5KBMXPzMPkGDT5sQEIRpEsm/
	8GbfEg1A6VfuJb3Pn9BupnoKAg5RT5PPMODCpkZzSrf1N8+gwnndBplVOADvF5Q7v/LF2j
	Tl7RMRyI8Y8Zvy/lkQkQQEDmgk97ivdkj5SOvOUIaKZafS4NSEVWU+aY6WVOkniQeqhf/m
	v5H2gYdVtNpG9ZB2z3lMkyL5OkDRcrZiVHslzCRS0PmKHbkUaZBpFsw+IGCREQ==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>, Christian Brauner
 <brauner@kernel.org>, netfs@lists.linux.dev, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix undifferentiation of DIO reads from
 unbuffered reads
In-Reply-To: <3064919.1745444289@warthog.procyon.org.uk>
References: <3064919.1745444289@warthog.procyon.org.uk>
Date: Wed, 23 Apr 2025 19:49:49 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> On cifs, "DIO reads" (specified by O_DIRECT) need to be differentiated from
> "unbuffered reads" (specified by cache=none in the mount parameters).  The
> difference is flagged in the protocol and the server may behave
> differently: Windows Server will, for example, mandate that DIO reads are
> block aligned.
>
> Fix this by adding a NETFS_UNBUFFERED_READ to differentiate this from
> NETFS_DIO_READ, parallelling the write differentiation that already exists.
>
> A further patch will be required to make cifs do something different,
> depending on the rreq->origin set.
>
> Fixes: 016dc8516aec ("netfs: Implement unbuffered/DIO read support")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Steve French <sfrench@samba.org>
> cc: netfs@lists.linux.dev
> cc: v9fs@lists.linux.dev
> cc: linux-afs@lists.infradead.org
> cc: linux-cifs@vger.kernel.org
> cc: ceph-devel@vger.kernel.org
> cc: linux-nfs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/9p/vfs_addr.c             |    3 ++-
>  fs/afs/write.c               |    1 +
>  fs/ceph/addr.c               |    4 +++-
>  fs/netfs/direct_read.c       |    3 ++-
>  fs/netfs/main.c              |    1 +
>  fs/netfs/misc.c              |    1 +
>  fs/netfs/objects.c           |    1 +
>  fs/netfs/read_collect.c      |    7 +++++--
>  fs/nfs/fscache.c             |    1 +
>  fs/smb/client/file.c         |    3 ++-
>  include/linux/netfs.h        |    1 +
>  include/trace/events/netfs.h |    1 +
>  12 files changed, 21 insertions(+), 6 deletions(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>

