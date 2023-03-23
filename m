Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B14E6C5CDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 03:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCWCxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 22:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWCxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8731F5F7
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679539940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W0ebE6bgoVx/Mv3B6TcJ7pQSb0U66C3AjGiXsmuMBx4=;
        b=WGrlMBCIHYh8hhVxtHPCCXbdZoWeu/e0DMqETchY3ZR+HmmAYV2zc6yJSZxYb1aadYDFfk
        6cqssZMmDN5TI/yKedZ8fH3a3PkreDE1Fj+G5GuhRIgp+5Xk3Q+qXFBflzGBkIRY8t+KDD
        zu/vpPshKPsvfgqUj1r5CEozFM3GrMU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-Uu42UDlnMkup59I9Lyv7rg-1; Wed, 22 Mar 2023 22:52:15 -0400
X-MC-Unique: Uu42UDlnMkup59I9Lyv7rg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93FFB8828C0;
        Thu, 23 Mar 2023 02:52:14 +0000 (UTC)
Received: from localhost (ovpn-12-97.pek2.redhat.com [10.72.12.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76B4B4021B1;
        Thu, 23 Mar 2023 02:52:13 +0000 (UTC)
Date:   Thu, 23 Mar 2023 10:52:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v7 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <ZBu+2cPCQvvFF/FY@MiWiFi-R3L-srv>
References: <cover.1679511146.git.lstoakes@gmail.com>
 <941f88bc5ab928e6656e1e2593b91bf0f8c81e1b.1679511146.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <941f88bc5ab928e6656e1e2593b91bf0f8c81e1b.1679511146.git.lstoakes@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/22/23 at 06:57pm, Lorenzo Stoakes wrote:
> Having previously laid the foundation for converting vread() to an iterator
> function, pull the trigger and do so.
> 
> This patch attempts to provide minimal refactoring and to reflect the
> existing logic as best we can, for example we continue to zero portions of
> memory not read, as before.
> 
> Overall, there should be no functional difference other than a performance
> improvement in /proc/kcore access to vmalloc regions.
> 
> Now we have eliminated the need for a bounce buffer in read_kcore_iter(),
> we dispense with it, and try to write to user memory optimistically but
> with faults disabled via copy_page_to_iter_nofault(). We already have
> preemption disabled by holding a spin lock. We continue faulting in until
> the operation is complete.

I don't understand the sentences here. In vread_iter(), the actual
content reading is done in aligned_vread_iter(), otherwise we zero
filling the region. In aligned_vread_iter(), we will use
vmalloc_to_page() to get the mapped page and read out, otherwise zero
fill. While in this patch, fault_in_iov_iter_writeable() fault in memory
of iter one time and will bail out if failed. I am wondering why we 
continue faulting in until the operation is complete, and how that is done. 

If we look into the failing point in vread_iter(), it's mainly coming
from copy_page_to_iter_nofault(), e.g page_copy_sane() checking failed,
i->data_source checking failed. If these conditional checking failed,
should we continue reading again and again? And this is not related to
memory faulting in. I saw your discussion with David, but I am still a
little lost. Hope I can learn it, thanks in advance.

......
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 08b795fd80b4..25b44b303b35 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
......
> @@ -507,13 +503,30 @@ read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>  
>  		switch (m->type) {
>  		case KCORE_VMALLOC:
> -			vread(buf, (char *)start, tsz);
> -			/* we have to zero-fill user buffer even if no read */
> -			if (copy_to_iter(buf, tsz, iter) != tsz) {
> -				ret = -EFAULT;
> -				goto out;
> +		{
> +			const char *src = (char *)start;
> +			size_t read = 0, left = tsz;
> +
> +			/*
> +			 * vmalloc uses spinlocks, so we optimistically try to
> +			 * read memory. If this fails, fault pages in and try
> +			 * again until we are done.
> +			 */
> +			while (true) {
> +				read += vread_iter(iter, src, left);
> +				if (read == tsz)
> +					break;
> +
> +				src += read;
> +				left -= read;
> +
> +				if (fault_in_iov_iter_writeable(iter, left)) {
> +					ret = -EFAULT;
> +					goto out;
> +				}
>  			}
>  			break;
> +		}
>  		case KCORE_USER:
>  			/* User page is handled prior to normal kernel page: */
>  			if (copy_to_iter((char *)start, tsz, iter) != tsz) {

