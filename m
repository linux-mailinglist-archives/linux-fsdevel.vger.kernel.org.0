Return-Path: <linux-fsdevel+bounces-34881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813219CDB9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 10:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398451F233DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4FA18FDC9;
	Fri, 15 Nov 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvhZklWI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F518D620
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663030; cv=none; b=EqG7NgcUS30IURBgvhvhp9+VvDRnF290gAqhgXqEkDkJC7usa/w210NURYRMXt/w2ZTGmViEowchGlhfHGpaNDi9jG6ZA8x0ckSzIMRH+Jy7Klfyzlmp89D1oxleXAutljKqV/wMX4Bh2eka5sjUirKB7H522fEZhZUftqtHu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663030; c=relaxed/simple;
	bh=HACz/QQAr11ooTsGg0yA/ndqu5JRoocgtgxYM6gKyDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXYjZn0FNpuMZid8hZiB/at1pUeYRLE+G7N51JWXnOQCVcqjVzJOcBrOJMlPSY0TJmXTciHmBoCPdPG/cx407I/sxvCTSOOfnDAFpCyBVQdTwWfF/EAEBAsRFgroZ8INQSgF+Q/uSMzLXRhzzWgFfnPvHKfCAGk61o/uERccYIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvhZklWI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731663027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYyixuKVzYBcQTLRFxXlHciXBG+s7v14S0hRbAQwaNI=;
	b=GvhZklWI02VHm6AuA3mrXnHTmJTyXQMmHd7mECnaKQdN5vUYpo6IQEex+8kNXIJwBuONAw
	ppxkBklfqsqQq1AWOlJMG8T+u3M/dFnsjRunqdq9miAXm1TZ7Bkr4L5B8oVi6ZzHHv7Pam
	QRoBMqBU4dg/tDlxjXpUnDPUes4SBKA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-pEcRDYRUN_6afERbkTTXPQ-1; Fri,
 15 Nov 2024 04:30:23 -0500
X-MC-Unique: pEcRDYRUN_6afERbkTTXPQ-1
X-Mimecast-MFC-AGG-ID: pEcRDYRUN_6afERbkTTXPQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AF361945114;
	Fri, 15 Nov 2024 09:30:20 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2783F1956089;
	Fri, 15 Nov 2024 09:30:17 +0000 (UTC)
Date: Fri, 15 Nov 2024 17:30:14 +0800
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
Subject: Re: [PATCH v1 01/11] fs/proc/vmcore: convert vmcore_cb_lock into
 vmcore_mutex
Message-ID: <ZzcUpoDJ2xPc3FzF@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025151134.1275575-2-david@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> We want to protect vmcore modifications from concurrent opening of
> the vmcore, and also serialize vmcore modiciations. Let's convert the


> spinlock into a mutex, because some of the operations we'll be
> protecting might sleep (e.g., memory allocations) and might take a bit
> longer.

Could you elaborate this a little further. E.g the concurrent opening of
vmcore is spot before this patchset or have been seen, and in which place
the memory allocation is spot. Asking this becasue I'd like to learn and
make clear if this is a existing issue and need be back ported into our
old RHEL distros. Thanks in advance.


> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/proc/vmcore.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index b52d85f8ad59..110ce193d20f 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -62,7 +62,8 @@ core_param(novmcoredd, vmcoredd_disabled, bool, 0);
>  /* Device Dump Size */
>  static size_t vmcoredd_orig_sz;
>  
> -static DEFINE_SPINLOCK(vmcore_cb_lock);
> +static DEFINE_MUTEX(vmcore_mutex);
> +
>  DEFINE_STATIC_SRCU(vmcore_cb_srcu);
>  /* List of registered vmcore callbacks. */
>  static LIST_HEAD(vmcore_cb_list);
> @@ -72,7 +73,7 @@ static bool vmcore_opened;
>  void register_vmcore_cb(struct vmcore_cb *cb)
>  {
>  	INIT_LIST_HEAD(&cb->next);
> -	spin_lock(&vmcore_cb_lock);
> +	mutex_lock(&vmcore_mutex);
>  	list_add_tail(&cb->next, &vmcore_cb_list);
>  	/*
>  	 * Registering a vmcore callback after the vmcore was opened is
> @@ -80,13 +81,13 @@ void register_vmcore_cb(struct vmcore_cb *cb)
>  	 */
>  	if (vmcore_opened)
>  		pr_warn_once("Unexpected vmcore callback registration\n");
> -	spin_unlock(&vmcore_cb_lock);
> +	mutex_unlock(&vmcore_mutex);
>  }
>  EXPORT_SYMBOL_GPL(register_vmcore_cb);
>  
>  void unregister_vmcore_cb(struct vmcore_cb *cb)
>  {
> -	spin_lock(&vmcore_cb_lock);
> +	mutex_lock(&vmcore_mutex);
>  	list_del_rcu(&cb->next);
>  	/*
>  	 * Unregistering a vmcore callback after the vmcore was opened is
> @@ -95,7 +96,7 @@ void unregister_vmcore_cb(struct vmcore_cb *cb)
>  	 */
>  	if (vmcore_opened)
>  		pr_warn_once("Unexpected vmcore callback unregistration\n");
> -	spin_unlock(&vmcore_cb_lock);
> +	mutex_unlock(&vmcore_mutex);
>  
>  	synchronize_srcu(&vmcore_cb_srcu);
>  }
> @@ -120,9 +121,9 @@ static bool pfn_is_ram(unsigned long pfn)
>  
>  static int open_vmcore(struct inode *inode, struct file *file)
>  {
> -	spin_lock(&vmcore_cb_lock);
> +	mutex_lock(&vmcore_mutex);
>  	vmcore_opened = true;
> -	spin_unlock(&vmcore_cb_lock);
> +	mutex_unlock(&vmcore_mutex);
>  
>  	return 0;
>  }
> -- 
> 2.46.1
> 


