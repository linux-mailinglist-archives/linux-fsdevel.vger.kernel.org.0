Return-Path: <linux-fsdevel+bounces-54727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265EFB0259B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 22:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BB5178B21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 20:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286DD1F30A9;
	Fri, 11 Jul 2025 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="jHTUQYxe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4EF8F7D;
	Fri, 11 Jul 2025 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264548; cv=none; b=MFoCFTS270HFFKAp4Sx0t9wq53v1tkIB73GNzUDXTEp3/MtaM2y79Jd9ESUbL69zgQnX5jhY2sxMMAWQvVfBd65nN5w1laGljEiVydHbPCVazjPJy4vmZmZwcUwTuJzJT1S1k8p4M6yjNHLaO5y/ap3VRqWyqWSkXMSlBpKazuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264548; c=relaxed/simple;
	bh=6h/mcLhWqqut85OKQY6Yqctl6Sa1aZmeXgj3nQ/jkfw=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=GYL8Kzn76mYjPJqNi+mcukVOr+/9WszY7dFRyMKramCdK4T3ePjeQe3cjWKBdM9/EPahlnJaCG4qyvFBuEl1oaQjIpmra7ae2znKln3alrXSuF1c+3biJX8N0PUWmXDja5GV7s63SI0ggPiD54PDRQYrfxJFZzvsZOloCuLrDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=jHTUQYxe; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DsiOyJzl5rAze08Vdd69h90iHyoqEgMKeaMkDWcKedk=; b=jHTUQYxeU3SDdsLUDEhQ369GcI
	H4dkcXwmkAedq9NHqHlSZrTQkUurtpL/bIykm79q7jbkzEZAjmdw+3r8yehCrONtbjX0M2656dzzx
	12tfDC7CDRme4NRqQ7wOYYwR6t2j2aYb27PgO+AI4m0QJnUsri1p9rfLfuXmXkVdWNx7lpFFCUa8a
	HscxWLQ9umfhoIa0XKhKgSYZ6gD/ADhqisjfoEArvx6zDgnvZKPKo9eKZ625k324dxlr2UsPGSC2i
	Mjp2GTiEdTa2KYDJlW3batgvDvjBjax8wvfYwWBZOCpVMvn5plSL3XdoS3ptpx918yMcKPAtfxs+/
	e4ecF6qw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.98.2)
	id 1uaK3J-00000000CAX-2MbS;
	Fri, 11 Jul 2025 17:09:01 -0300
Message-ID: <617b207a7cf0b21a2aff2c05c36bfed2@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>, Max Kellermann
 <max.kellermann@ionos.com>, Viacheslav Dubeyko <slava@dubeyko.com>, Alex
 Markuze <amarkuze@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
 netfs@lists.linux.dev, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] netfs: Fix use of fscache with ceph
In-Reply-To: <20250711151005.2956810-1-dhowells@redhat.com>
References: <20250711151005.2956810-1-dhowells@redhat.com>
Date: Fri, 11 Jul 2025 17:09:00 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Hi Christian,
>
> Here are a couple of patches that fix the use of fscaching with ceph:
>
>  (1) Fix the read collector to mark the write request that it creates to copy
>      data to the cache with NETFS_RREQ_OFFLOAD_COLLECTION so that it will run
>      the write collector on a workqueue as it's meant to run in the background
>      and the app isn't going to wait for it.
>
>  (2) Fix the read collector to wake up the copy-to-cache write request after
>      it sets NETFS_RREQ_ALL_QUEUED if the write request doesn't have any
>      subrequests left on it.  ALL_QUEUED indicates that there won't be any
>      more subreqs coming and the collector should clean up - except that an
>      event is needed to trigger that, but it only gets events from subreq
>      termination and so the last event can beat us to setting ALL_QUEUED.
>
> The patches can also be found here:
>
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes
>
> Thanks,
> David
>
> David Howells (2):
>   netfs: Fix copy-to-cache so that it performs collection with
>     ceph+fscache
>   netfs: Fix race between cache write completion and ALL_QUEUED being
>     set
>
>  fs/netfs/read_pgpriv2.c      |  5 +++++
>  include/trace/events/netfs.h | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

