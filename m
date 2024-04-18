Return-Path: <linux-fsdevel+bounces-17250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E94A28A9B83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 15:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7260CB2306A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C9161311;
	Thu, 18 Apr 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnIPayUH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC715B961
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447847; cv=none; b=NtFBG/YGnTa96wyWJo1TQrwn4j3dpt0pmQNsVGtWdgh/Q9ckG636qrewkgBZXvm69RjAE7oRA/ZMKL6SPA00FXiOsLXbPUQV86mcD017yOJHpP4eqRymf42pPbxeL6UyO2kPzuicXzlkf/1ZL5cg2gvMA8uEtIpRUp7wUZg8pfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447847; c=relaxed/simple;
	bh=Iwmm4vK6K8VJ12C1Oel8qG6yhGbv1FUmWa6BqBjk/1c=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=d8fXykmpb0ZlXLPtlm3ob7sPwAISdgcrRl1fYaK+8gKLXZqS1/pQ5bgqsjiQqJA3y0+eTE3ep8JHIG1y+Y0QFsog6VSW5OD6IktXf3CjkH6MO3Ck5d4snCkPr62lW7NsicRVl8CHiyERF2NbkHWerkBnu/o2C6idBzYHyDZxeXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnIPayUH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713447845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S0S8YregP25P1OBV5UbC9sms8BvW3U0pJ4XCK6GLxag=;
	b=YnIPayUHqITU2m24NhRVv8T0JbGS7sslBRsgGnFzsNrT56TP5nq1tmO7KZDC42JLeHdOts
	Atejm/YgidaUzZJLJnPATVlabTCb8uHEb45mIvBXJeyNQKiarTCJbw/d2R/nEf+P+V4/Yp
	IPp1eJZelnVYJ7IcxWviNtQu3XOfIeA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-0B34hqk0Pq6zo_RaertJrg-1; Thu, 18 Apr 2024 09:44:01 -0400
X-MC-Unique: 0B34hqk0Pq6zo_RaertJrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56B1B18B1847;
	Thu, 18 Apr 2024 13:44:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36B4E2166B32;
	Thu, 18 Apr 2024 13:44:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <59c322dc49c3cc76a4b6a2de35106c61@manguebit.com>
References: <59c322dc49c3cc76a4b6a2de35106c61@manguebit.com> <1a94a15e6863d3844f0bcb58b7b1e17a@manguebit.com> <14e66691a65e3d05d3d8d50e74dfb366@manguebit.com> <3756406.1712244064@warthog.procyon.org.uk> <2713340.1713286722@warthog.procyon.org.uk> <277920.1713364693@warthog.procyon.org.uk>
To: Paulo Alcantara <pc@manguebit.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix reacquisition of volume cookie on still-live connection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <564519.1713447839.1@warthog.procyon.org.uk>
Date: Thu, 18 Apr 2024 14:43:59 +0100
Message-ID: <564520.1713447839@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Paulo Alcantara <pc@manguebit.com> wrote:

> I don't know why it was designed that way, but the reason we have two
> different superblocks with ${opts} being the same is because cifs.ko
> relies on the value of cifs_sb_info::prepath to build paths out of
> dentries.  See build_path_from_dentry().  So, when you access
> /mnt/2/foo, cifs.ko will build a path like '[optional tree name prefix]
> + cifs_sb_info::prepath + \foo' and then reuse connections
> (server+session+tcon) from first superblock to perform I/O on that file.

Yep.  You don't *need* prepath.  You could always build from the sb->s_root
without a prepath and have mnt->mnt_root offset the place the VFS thinks you
are:

	[rootdir]/	<--- s_root points here
	|
	v
	foo/
	|
	v
	bar/		<--- mnt_root points here
	|
	v
	a

Without prepath, you build back up the tree { a, bar/, foo/, [rootdir] } with
prepath you insert the prepath at the end.

Bind mounts just make the VFS think it's starting midway down, but you build
up back to s_root.

Think of a mount as just referring to a subtree of the tree inside the
superblock.  The prepath is just an optimisation - but possibly one that makes
sense for cifs if you're having to do pathname fabrication a lot.

David


