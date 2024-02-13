Return-Path: <linux-fsdevel+bounces-11439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA1F853D35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0822E1C27BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEB66169E;
	Tue, 13 Feb 2024 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOYgYhqa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233446167D
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859934; cv=none; b=IUXczvGZyBtfSQ4rmAqlSzbKZycLVPnYx2k2Px642BD22ZEJYhyxl4ElW2ZKzUYsJVo4kGEQ+XRZUyfeuoOo5alB30JdPu8SPnFgZEGzZH5ASdt4ZubxcGIVPwCvPY/5wSZ2Dv6cq+NrbJ1gyEyJmO1dyfasVR0KDTpVheNom0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859934; c=relaxed/simple;
	bh=qmExrAn076mpV2/aLHehXiaMgZryxuul4io3LmPbhhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aer8Q0DJ7yUlsi4jZp4PJVgKsZgrsXNnDEM+4LNJ1fJxC7iMnOLb7sw3DBOiasBDR0JJULY3isPoOSF6n73cvus7CKzuQuNPU1v8NGUKvyibAYeivCFfKHzR9Jd79jtSPLLLRAO7hCtASeA04U0nNZx3p6fSREWUboIqWJ65cmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOYgYhqa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707859931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESmGu/KjNT5swP3McsKQDzSN8tDqKh4A84KZR8XtnGU=;
	b=JOYgYhqaA3oFzWicX6XDZyQekZUmDbUfLHCLMOJx7vF/XRUz73D3EwfFLRzEHP904XUWed
	raTHNB8D3YY+fA7X89awMRs0kCA1YJEySfJk3FTrJmX8sknZf1rxYUlHw6pN5+Po5RINIb
	/YRKB0wq6H/98K3hA20xStgnzBLxnQ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-Rz_Ipd4BM8i30zKiwK1VKQ-1; Tue, 13 Feb 2024 16:32:07 -0500
X-MC-Unique: Rz_Ipd4BM8i30zKiwK1VKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6AE6185A783;
	Tue, 13 Feb 2024 21:32:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.238])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 65C88AC07;
	Tue, 13 Feb 2024 21:32:05 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id A8A522AED60; Tue, 13 Feb 2024 16:32:04 -0500 (EST)
Date: Tue, 13 Feb 2024 16:32:04 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
	Greg KH <gregkh@linuxfoundation.org>, Alyssa Ross <hi@alyssa.is>,
	mzxreary@0pointer.de, gmaglione@redhat.com,
	virtio-fs@lists.linux.dev
Subject: Re: [PATCH v4 0/3] virtiofs: export filesystem tags through sysfs
Message-ID: <Zcvf1Cbvtjwz2WMy@redhat.com>
References: <20240213001149.904176-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213001149.904176-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Mon, Feb 12, 2024 at 07:11:46PM -0500, Stefan Hajnoczi wrote:
> v4:
> - Create kset before registering virtio driver because the kset needed in
>   virtio_fs_probe(). Solves the empty /sys/fs/virtiofs bug. [Vivek]
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

Hi Stefan,

Thanks a lot for this patch series. It looks good to me. I also tested
and now I can see entries in /sys/fs/virtiofs/. I also wrote a udev rule
and a mount unit file to automatically mount virtiofs instance and unmount
when device is unplugged. Everything seems to work. Hence..

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

> 
>  fs/fuse/virtio_fs.c                         | 137 ++++++++++++++++----
>  Documentation/ABI/testing/sysfs-fs-virtiofs |  11 ++
>  2 files changed, 126 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-fs-virtiofs
> 
> -- 
> 2.43.0
> 


