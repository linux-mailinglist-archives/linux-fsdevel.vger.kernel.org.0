Return-Path: <linux-fsdevel+bounces-7487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A3A825BDB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 21:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897C3B22770
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 20:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FD9364BB;
	Fri,  5 Jan 2024 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPvHm4cA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922B2E826
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704487313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXoAVCkoEpEA5h3FLI3eSkWAzRef2kLAyGV2xcy6gn4=;
	b=jPvHm4cAU6yszFGbmeHtvbrrPdDCk3k/sl2oaaE35IIY+4radox2nREI0p3u9G2+Jbwwv/
	WrWmfAa8/3d+f0fzGJCgKvU5WTV3MEVIYewcHVIFLUU5ylCjdAWppz5ORINTG9sSUxfdzW
	FyrgaJXjPT+S7fJPGyL7dKB5sfiEKZc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-4KEFV3L1NWaTJfcbAeu1bw-1; Fri, 05 Jan 2024 15:41:50 -0500
X-MC-Unique: 4KEFV3L1NWaTJfcbAeu1bw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86F16845DC3;
	Fri,  5 Jan 2024 20:41:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 52B8BC15A0C;
	Fri,  5 Jan 2024 20:41:49 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id 9D37728EBDA; Fri,  5 Jan 2024 15:41:48 -0500 (EST)
Date: Fri, 5 Jan 2024 15:41:48 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, houtao1@huawei.com
Subject: Re: [PATCH v2] virtiofs: use GFP_NOFS when enqueuing request through
 kworker
Message-ID: <ZZhpjEwDwMS_mq-u@redhat.com>
References: <20240105105305.4052672-1-houtao@huaweicloud.com>
 <ZZhjzwnQUEJhNJiq@redhat.com>
 <ZZhkrOdbau2O/B59@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZhkrOdbau2O/B59@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Fri, Jan 05, 2024 at 08:21:00PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 05, 2024 at 03:17:19PM -0500, Vivek Goyal wrote:
> > On Fri, Jan 05, 2024 at 06:53:05PM +0800, Hou Tao wrote:
> > > From: Hou Tao <houtao1@huawei.com>
> > > 
> > > When invoking virtio_fs_enqueue_req() through kworker, both the
> > > allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
> > > Considering the size of both the sg array and the bounce buffer may be
> > > greater than PAGE_SIZE, use GFP_NOFS instead of GFP_ATOMIC to lower the
> > > possibility of memory allocation failure.
> > > 
> > 
> > What's the practical benefit of this patch. Looks like if memory
> > allocation fails, we keep retrying at interval of 1ms and don't
> > return error to user space.
> 
> You don't deplete the atomic reserves unnecessarily?

Sounds reasonable. 

With GFP_NOFS specificed, can we still get -ENOMEM? Or this will block
indefinitely till memory can be allocated. 

I am trying to figure out with GFP_NOFS, do we still need to check for
-ENOMEM while requeuing the req and asking worker thread to retry after
1ms. 

Thanks
Vivek


