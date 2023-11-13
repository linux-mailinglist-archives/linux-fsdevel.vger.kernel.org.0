Return-Path: <linux-fsdevel+bounces-2807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA907EA474
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 21:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7791F2262B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 20:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFCD2420F;
	Mon, 13 Nov 2023 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8BAaJn4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9582C24207
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 20:11:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4E5D5D
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 12:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l2g0BFIb+e/acjg8/FV7u7nWSHqvw3fPr5ELp3ST0hQ=;
	b=O8BAaJn48ub7jawunXdi/Cg6dq8FkqnUFSh6PFMcuzPR3thmakzzIffcBg/zwZ0pUlOTAm
	pVnXITjjo0OJDDQU8N/IZYnNlmpVw3i4773pOpbHd+LZAGDLcvKDIydIGLlEka95xO1vUw
	wlCHBuNe0IeFZWMwo0Ca+wKcxEhU/jY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-D-2DbDoKP6GA32Vzh4tbQw-1; Mon, 13 Nov 2023 15:11:29 -0500
X-MC-Unique: D-2DbDoKP6GA32Vzh4tbQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A434685A5BD;
	Mon, 13 Nov 2023 20:11:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.17.204])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 950871C060B9;
	Mon, 13 Nov 2023 20:11:27 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id 9EB8722CDCA; Mon, 13 Nov 2023 15:11:26 -0500 (EST)
Date: Mon, 13 Nov 2023 15:11:26 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
	stefanha@redhat.com, mzxreary@0pointer.de, gmaglione@redhat.com,
	hi@alyssa.is
Subject: Re: [PATCH v2] virtiofs: Export filesystem tags through sysfs
Message-ID: <ZVKC7obmBhCF0hRg@redhat.com>
References: <20231108213333.132599-1-vgoyal@redhat.com>
 <2023111104-married-unstaffed-973e@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023111104-married-unstaffed-973e@gregkh>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Sat, Nov 11, 2023 at 06:55:18AM -0500, Greg KH wrote:
> On Wed, Nov 08, 2023 at 04:33:33PM -0500, Vivek Goyal wrote:
> > virtiofs filesystem is mounted using a "tag" which is exported by the
> > virtiofs device. virtiofs driver knows about all the available tags but
> > these are not exported to user space.
> > 
> > People have asked these tags to be exported to user space. Most recently
> > Lennart Poettering has asked for it as he wants to scan the tags and mount
> > virtiofs automatically in certain cases.
> > 
> > https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
> > 
> > This patch exports tags through sysfs. One tag is associated with each
> > virtiofs device. A new "tag" file appears under virtiofs device dir.
> > Actual filesystem tag can be obtained by reading this "tag" file.
> > 
> > For example, if a virtiofs device exports tag "myfs", a new file "tag"
> > will show up here. Tag has a newline char at the end.
> > 
> > /sys/bus/virtio/devices/virtio<N>/tag
> > 
> > # cat /sys/bus/virtio/devices/virtio<N>/tag
> > myfs
> > 
> > Note, tag is available at KOBJ_BIND time and not at KOBJ_ADD event time.
> > 
> > v2:
> > - Add a newline char at the end in tag file. (Alyssa Ross)
> > - Add a line in commit logs about tag file being available at KOBJ_BIND
> >   time and not KOBJ_ADD time.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> 
> No documentation for your new sysfs file?  :(

Hi Greg,

My bad. I forgot about it while posting V2.

As per your comment in another email, I will include some documentation
in Documentation/ABI/. Not very sure what file name to choose. I will
probably start with "sysfs-bus-virtio-devices-virtiofs".

Thanks
Vivek


