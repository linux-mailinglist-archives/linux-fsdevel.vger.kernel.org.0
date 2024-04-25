Return-Path: <linux-fsdevel+bounces-17755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB88B21CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44791F240BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836691494DE;
	Thu, 25 Apr 2024 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmYnxBtw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B571494DA
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048973; cv=none; b=lNOa9sPTnba3Dv8X6oz3k6Ay0+hXXHX7d5eTlRWTJx4OT3LjVrO2NaMXmXHPBqzNBv3U2QN1Vy/NuFvEEJ1a6+RR82s2+4mcLrDTO6+K3Ti7ZBIAfYamUPTmK2d0vJgNz1JPeniGJROvlaA5wWmLhqig6eHP3EoUaowsJxfaA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048973; c=relaxed/simple;
	bh=5f7gvmenUZBkrJRZWL+AToX9QvQCvbJp+mDfyJclySs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPemgAwUAbSWgd/wKsyqD+msvxblGMw1zgA4X66wxCBWSEzR/+N57zlNDuOFlneIQ5EvzK2gkSp51/pUS/BgwnzWYnI6mriBhpc3sDkyHBEgGXdJCzKV0YxruR98w3PwvzNDSDYUbe3F04qWtRwf3+lwYgksMJSIFym3lTaiu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmYnxBtw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714048970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ks83tzRkgwed753odRbdN5YV4JJmKUKmc2dC5CbBan8=;
	b=OmYnxBtw4JfM1sPgVM7tT6hHaC75JIWYoMBBluukNUHL6Z/NTZC5C+1o8JAgtWVjXsbe4I
	NwLZtT9ifnVdgpMjrt7YU91H9JS60ur22DYzEVITwtZq4W1wMkOWRbHzEE8MNp5NIkg+Hi
	bTtKu9sdeAsqKCFZACCGzJ0uUOW26Y4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-TbtsjZWkM0-88richfLD9w-1; Thu, 25 Apr 2024 08:42:48 -0400
X-MC-Unique: TbtsjZWkM0-88richfLD9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90C9F80D6E1
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 12:42:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.242])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3486AEC682;
	Thu, 25 Apr 2024 12:42:48 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id B9819309975; Thu, 25 Apr 2024 08:42:47 -0400 (EDT)
Date: Thu, 25 Apr 2024 08:42:47 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtiofs: include a newline in sysfs tag
Message-ID: <ZipPx7uV49bK2lgP@redhat.com>
References: <20240425104400.30222-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425104400.30222-1-bfoster@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Thu, Apr 25, 2024 at 06:44:00AM -0400, Brian Foster wrote:
> The internal tag string doesn't contain a newline. Append one when
> emitting the tag via sysfs.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> Hi all,
> 
> I just noticed this and it seemed a little odd to me compared to typical
> sysfs output, but maybe it was intentional..? Easy enough to send a
> patch either way.. thoughts?

In my initial patch I had added a newline char. Then someone gave examples
where sysfs output did not have newline char. So I got rid of it. After
that Stefan posted a new patch series that did not include newline. So
yes it was intentional.

I am sitting on the fence on this one. Don't have a strong preference
either way. Others might have good arguments one way or the other.

Thanks
Vivek

> 
> Brian
> 
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 322af827a232..bb3e941b9503 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -170,7 +170,7 @@ static ssize_t tag_show(struct kobject *kobj,
>  {
>  	struct virtio_fs *fs = container_of(kobj, struct virtio_fs, kobj);
>  
> -	return sysfs_emit(buf, fs->tag);
> +	return sysfs_emit(buf, "%s\n", fs->tag);
>  }
>  
>  static struct kobj_attribute virtio_fs_tag_attr = __ATTR_RO(tag);
> -- 
> 2.44.0
> 


