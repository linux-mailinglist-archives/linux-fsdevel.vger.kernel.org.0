Return-Path: <linux-fsdevel+bounces-18926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED568BE965
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE66292B5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370E1A0AE2;
	Tue,  7 May 2024 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJpJxWFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192116E871
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099727; cv=none; b=CORVYkzOOFxXZH5P6fsKNZjKuVJk+a9oUwnmZXMRG1vYk5imqcJxUfdq9tNrYWCAto0qDDYItbTiRtLft+19d1UjDusNVqh2ZNqpb+ONuDipwJUAF1uFu+VfV5VYyzCDjSP+qNbAKuz44+ayRJe7yMq/b+iLq6Qn0YzR7kF6Q8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099727; c=relaxed/simple;
	bh=B+zdrdE7xUpnuWE76C9wLH8+IClGrBaPAMZH9cVWsYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVe9Rl/Z2pJBROSERLgM2VnEZODNyJGFcGdEHB4maulSuYoPJMWQRPUsABSz4kilwMblvV5l+/Yi3KHN0qhonZ4Cg1x3LZn18v9OgErYD4cASe7X2GXj9bEgP+SEV1XE04y5UAsl6xFQAbRS+/QH0tPdeQsVnAfcs2APzMxnu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJpJxWFA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715099724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxNiQbwFKKqw5/RIMv+u7n6wvwjO6n2nq0uyLlFC+p4=;
	b=PJpJxWFA+Kn0/KAAde4w5aBteQaB0IVwlkDVXEjHorjO2bo1stNs5rOxlsDmOvPmnz0lmM
	WXC5GVDRAqe7JIYTvBfH5cl7JB3he4RkWCatxV/Rx+m3cV0Xj4kqALgvKPUc87gy7D+Jqe
	ikmgXuV14Z9l4k/nHl6TrX8NXIJCDCg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-9Cx6YtcgOOWnzKxXk5EB2w-1; Tue,
 07 May 2024 12:35:23 -0400
X-MC-Unique: 9Cx6YtcgOOWnzKxXk5EB2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5897E3802126
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 16:35:23 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.146])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 243FE200C7E6;
	Tue,  7 May 2024 16:35:22 +0000 (UTC)
Date: Tue, 7 May 2024 12:35:41 -0400
From: Brian Foster <bfoster@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mszeredi@redhat.com, linux-fsdevel@vger.kernel.org, vgoyal@redhat.com
Subject: Re: [PATCH v2] virtiofs: use string format specifier for sysfs tag
Message-ID: <ZjpYXTerz3opEmHm@bfoster>
References: <20240506185713.58678-1-bfoster@redhat.com>
 <20240507135419.GB105913@fedora.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507135419.GB105913@fedora.redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Tue, May 07, 2024 at 09:54:19AM -0400, Stefan Hajnoczi wrote:
> On Mon, May 06, 2024 at 02:57:13PM -0400, Brian Foster wrote:
> > The existing emit call is a vector for format string injection. Use
> > the string format specifier to avoid this problem.
> > 
> > Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > v2:
> > - Drop newline.
> > v1: https://lore.kernel.org/linux-fsdevel/20240425104400.30222-1-bfoster@redhat.com/
> > 
> >  fs/fuse/virtio_fs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 322af827a232..d5cb300367ed 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -170,7 +170,7 @@ static ssize_t tag_show(struct kobject *kobj,
> >  {
> >  	struct virtio_fs *fs = container_of(kobj, struct virtio_fs, kobj);
> >  
> > -	return sysfs_emit(buf, fs->tag);
> > +	return sysfs_emit(buf, "%s", fs->tag);
> >  }
> 
> Miklos: Would it be possible to change the format string to "%s\n" (with
> a newline) in this patch and merged for v6.9?
> 
> v6.9 will be the first kernel release with this new sysfs attr and I'd
> like to get the formatting right. Once a kernel is released I would
> rather not change the sysfs attr's format to avoid breaking userspace,
> hence the urgency.
> 

It might be worth including the following tag in this as well:

Fixes: a8f62f50b4e4 ("virtiofs: export filesystem tags through sysfs")

... re: the discussion on v1.

I'd also advocate for including the newline either way, but again I
defer to Stefan if he feels strongly about it. FWIW, if we do go that
route I can also send a v3 with the tag and combined v1/v2 commit log if
that is helpful.

Brian

> Thank you,
> Stefan



