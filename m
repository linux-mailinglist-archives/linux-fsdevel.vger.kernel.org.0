Return-Path: <linux-fsdevel+bounces-11000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8623584FAF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 18:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8911F2927B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030FD7BAF7;
	Fri,  9 Feb 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yxj0duxB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEC57B3D4
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499310; cv=none; b=DWk9Ww19FKgt0MFoDHE5/w4QdccyIxbENWpNxiUVEkxOFlp/koV6/EWQtsrPQSoQ68DPCvcFMlqBpwzBHmHF4ekL0kMD3ZogUZd1kfzMZ2zltdoCl7xjh9HZHa0uuyKtr0qEN8tGAWmGnDy3kxyOqZiceaIkuYwR9zO3q7yvOuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499310; c=relaxed/simple;
	bh=6DQYA6WL40qK4OCrQRw2oarxqXcLsmuTrKyrxJZbLVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/H6hva3nvujUHYZlO4ihlTnykszqg3edQTnckSm1ZJV7DoUCK8XBrC3hufQ5lHaumk0Jjp4/duo4soahwYEiKeiFUfKOAp4CaNZc1GOGYTwuVzjZXK12yb71uP8gIVWRju076Gv2EvrokJEu46ijCZdRJHRjmTblnA6V4vuWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yxj0duxB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707499307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1DyMa0OwRCuoEiLNBlCTz+pggew/ko3ryQ4Q/4k4Y4=;
	b=Yxj0duxBTha6fMegxlfAts6xunuUCP0dwE0PvDjdGUK3Fki9s1eMcAKuPNPtFwByJvAoK+
	Uwf6dWC3e30ZZsy7GGeOA3mp+Qa2om4mczuCBv0CdqzkXHl7fkyDKRktmQa5Zx0/wvk89T
	7Y3Krevl+DV5v5H0yPbPfepsG5AfkXE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-UFCLKMTHN6K1aW20edLNPQ-1; Fri, 09 Feb 2024 12:21:43 -0500
X-MC-Unique: UFCLKMTHN6K1aW20edLNPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B1221005055;
	Fri,  9 Feb 2024 17:21:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D744A111FF;
	Fri,  9 Feb 2024 17:21:42 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id 4EBB72AE542; Fri,  9 Feb 2024 12:21:42 -0500 (EST)
Date: Fri, 9 Feb 2024 12:21:42 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, gmaglione@redhat.com,
	Greg KH <gregkh@linuxfoundation.org>, virtio-fs@lists.linux.dev,
	Alyssa Ross <hi@alyssa.is>, mzxreary@0pointer.de
Subject: Re: [PATCH v3 0/3] virtiofs: export filesystem tags through sysfs
Message-ID: <ZcZfJmfyU7haGtDY@redhat.com>
References: <20240209121820.755722-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209121820.755722-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Fri, Feb 09, 2024 at 07:18:17AM -0500, Stefan Hajnoczi wrote:
> v3:
> - Use dev_dbg() to avoid spamming logs [Greg]
> - Fix 644 mode on "tag" attr and use __ATTR_RO() [Greg]
> - Use kset_uevent_ops and eliminate explicit KOBJ_REMOVE [Greg]
> v2:
> - Vivek mentioned that he didn't have time to work on this patch series
>   recently so I gave it a shot.
> - Information is now exposed in /sys/fs/virtiofs/ whereas before it was part of
>   the generic virtio device kobject, which didn't really fit.
> 
> Userspace needs a way to enumerate available virtiofs filesystems and detect
> when they are hotplugged or unplugged. This would allow systemd to wait for a
> virtiofs filesystem during boot, for example.
> 
> This patch series adds the following in sysfs:
> 
>   /sys/fs/virtiofs/<n>/tag    - unique identifier for mount(8)
>   /sys/fs/virtiofs/<n>/device - symlink to virtio device

Hi Stefan,

Thanks for the patches. I am glad you are solving this problem.

I am testing your patches. After boot, I see /sys/fs/virtiofs/ directory
but that directory is empty. No entries for any tags. I do have one
tag exported named "myfs" to the VM. And I can mount it.

Thanks
Vivek

> 
> A uevent is emitted when virtiofs devices are hotplugged or unplugged:
> 
>   KERNEL[111.113221] add      /fs/virtiofs/2 (virtiofs)
>   ACTION=add
>   DEVPATH=/fs/virtiofs/2
>   SUBSYSTEM=virtiofs
>   TAG=test
> 
>   KERNEL[165.527167] remove   /fs/virtiofs/2 (virtiofs)
>   ACTION=remove
>   DEVPATH=/fs/virtiofs/2
>   SUBSYSTEM=virtiofs
>   TAG=test
> 
> Stefan Hajnoczi (3):
>   virtiofs: forbid newlines in tags
>   virtiofs: export filesystem tags through sysfs
>   virtiofs: emit uevents on filesystem events
> 
>  fs/fuse/virtio_fs.c                         | 135 +++++++++++++++++---
>  Documentation/ABI/testing/sysfs-fs-virtiofs |  11 ++
>  2 files changed, 125 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-fs-virtiofs
> 
> -- 
> 2.43.0
> 


