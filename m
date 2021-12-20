Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C104547A5C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 09:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbhLTIKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:10:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237844AbhLTIKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639987851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zxVKzNF0cgW394JRMHP12IXVI+3E1hxn9KxUG4k3b/M=;
        b=Ow8uN5JugWgapuGiMbr1Rq2lnm9AOS3ZzUiprq4Ymj2ZKZE8PfxSjf3fKQlFaNeswNG4cG
        7c27TIAbkLRQ8Ix7xPAURs+IK/CtapyCUXAGe9f+AOkYwKgSSK4Sq5zmPhVfnMAPUQKFCc
        2Yqp8zv3YeZrF8cjs5covsDtEugVjqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-qtsvmVCYMnOrSGlbLXOTyg-1; Mon, 20 Dec 2021 03:10:50 -0500
X-MC-Unique: qtsvmVCYMnOrSGlbLXOTyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9D48101AFA7;
        Mon, 20 Dec 2021 08:10:48 +0000 (UTC)
Received: from localhost (ovpn-12-142.pek2.redhat.com [10.72.12.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C158A6107F;
        Mon, 20 Dec 2021 08:10:47 +0000 (UTC)
Date:   Mon, 20 Dec 2021 16:10:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        akpm@linux-foundation.org, kexec@lists.infradead.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] vmcore: Convert copy_oldmem_page() to take an
 iov_iter
Message-ID: <20211220081045.GC31681@MiWiFi-R3L-srv>
References: <20211213143927.3069508-1-willy@infradead.org>
 <20211213143927.3069508-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213143927.3069508-2-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/21 at 02:39pm, Matthew Wilcox (Oracle) wrote:
> Instead of passing in a 'buf' and 'userbuf' argument, pass in an iov_iter.
> s390 needs more work to pass the iov_iter down further, or refactor,
> but I'd be more comfortable if someone who can test on s390 did that work.
> 
> It's more convenient to convert the whole of read_from_oldmem() to
> take an iov_iter at the same time, so rename it to read_from_oldmem_iter()
> and add a temporary read_from_oldmem() wrapper that creates an iov_iter.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>


Thanks for making this to do an awesome clean up. This one looks good to
me.

Acked-by: Baoquan He <bhe@redhat.com>

...... 
> -/**
> - * copy_oldmem_page() - copy one page from old kernel memory
> - * @pfn: page frame number to be copied
> - * @buf: buffer where the copied page is placed
> - * @csize: number of bytes to copy
> - * @offset: offset in bytes into the page
> - * @userbuf: if set, @buf is int he user address space
> - *
> - * This function copies one page from old kernel memory into buffer pointed by
> - * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
> - * copied or negative error in case of failure.
> - */
> -ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> -			 size_t csize, unsigned long offset,
> -			 int userbuf)
> +ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
> +			 size_t csize, unsigned long offset)
                                ^^^^^^
I am curious why this parameter is called 'csize', but not 'size' directly.
This is not related to this patch, it's an old naming.

>  {
>  	void *vaddr;
>  
> @@ -40,14 +28,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>  	if (!vaddr)
>  		return -ENOMEM;
>  
> -	if (userbuf) {
> -		if (copy_to_user(buf, vaddr + offset, csize)) {
> -			iounmap(vaddr);
> -			return -EFAULT;
> -		}
> -	} else {
> -		memcpy(buf, vaddr + offset, csize);
> -	}
> +	csize = copy_to_iter(vaddr + offset, csize, iter);
>  
>  	iounmap(vaddr);
>  	return csize;

