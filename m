Return-Path: <linux-fsdevel+bounces-35551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4F29D5BC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 10:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9932E2883E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1634D1DDA15;
	Fri, 22 Nov 2024 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/L5RWgB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F1015B149
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267022; cv=none; b=rsCTWsD3cUTQQ9coY/wyf/TSbrOWPAb7ev6GMCgdT3b+FOh0jxpEVofB+xijLQ9wONj8mZRFHY6beC70CU/KzO9cmDqHcqm4qarfKpRRZ+yxUTAt5uCBuRrMrrCY6E8RFU53dSsRO9FtUJNaG+b1SyyDUaQ950Q1FkkmWQZRmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267022; c=relaxed/simple;
	bh=pfDeka+wDs610l+yfP6uYMmifgUfnr/ZLDWOPuzEEKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwNgpoDkGNgRSwyk3gUUXDtqGEB0O8KVUyLOV5OqV36paC+bknKH8bGl240egnIoUXwGjy14w7KAj5AubTych+F6Yhzj97NWFJJ9N8KICt8wcy/sP3LhLwZnX8nz2cj8h6HcXM6Q3cnzf4wnWXsF2OejvxZ610Q/5ufYi1RXmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/L5RWgB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732267018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTleGtvdq1osypVXWqisdoYoTofXyVXhiRbJdgp9AcQ=;
	b=D/L5RWgBB1ePlQzM9yDy+frh0QxAgxvWzEZGwDhzDwdH3pPI3TzGHkgPLmbrihry76z4Hx
	91FUAqPlGcxuimCrgBXmqFbvOjUn5hZxVpw+t6SLmMxiBqqY//CeuBW5ZJnDBFsFZ6SE7v
	vGH2U7CQ8qCipC9udn0qplUbTTVM/Yc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-yqNZKyvGM92oYIoNe2PX8A-1; Fri,
 22 Nov 2024 04:16:55 -0500
X-MC-Unique: yqNZKyvGM92oYIoNe2PX8A-1
X-Mimecast-MFC-AGG-ID: yqNZKyvGM92oYIoNe2PX8A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23FF01955BF4;
	Fri, 22 Nov 2024 09:16:52 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E86D01955E9E;
	Fri, 22 Nov 2024 09:16:49 +0000 (UTC)
Date: Fri, 22 Nov 2024 17:16:45 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 03/11] fs/proc/vmcore: disallow vmcore modifications
 after the vmcore was opened
Message-ID: <Z0BL/UopaH5Xg5jS@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025151134.1275575-4-david@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 10/25/24 at 05:11pm, David Hildenbrand wrote:
......snip...
> @@ -1482,6 +1470,10 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  		return -EINVAL;
>  	}
>  
> +	/* We'll recheck under lock later. */
> +	if (data_race(vmcore_opened))
> +		return -EBUSY;

As I commented to patch 7, if vmcore is opened and closed after
checking, do we need to give up any chance to add device dumping
as below? 

fd = open(/proc/vmcore);
...do checking;
close(fd);

quit any device dump adding;

run makedumpfile on s390;
  ->fd = open(/proc/vmcore);
    -> try to dump;
  ->close(fd);

> +
>  	if (!data || !strlen(data->dump_name) ||
>  	    !data->vmcoredd_callback || !data->size)
>  		return -EINVAL;
> @@ -1515,12 +1507,16 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	dump->buf = buf;
>  	dump->size = data_size;
>  
> -	/* Add the dump to driver sysfs list */
> +	/* Add the dump to driver sysfs list and update the elfcore hdr */
>  	mutex_lock(&vmcore_mutex);
> -	list_add_tail(&dump->list, &vmcoredd_list);
> -	mutex_unlock(&vmcore_mutex);
> +	if (vmcore_opened) {
> +		ret = -EBUSY;
> +		goto out_err;
> +	}
>  
> +	list_add_tail(&dump->list, &vmcoredd_list);
>  	vmcoredd_update_size(data_size);
> +	mutex_unlock(&vmcore_mutex);
>  	return 0;
>  
>  out_err:
> -- 
> 2.46.1
> 


