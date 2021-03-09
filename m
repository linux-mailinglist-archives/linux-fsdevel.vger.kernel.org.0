Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36093332BFF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 17:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhCIQ2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 11:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230242AbhCIQ2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615307312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Iv7BBIxQ8+W8sz1TqvejVKfcifyHSm+wQDXMt7okOA=;
        b=BOYqXhuTDVLs6z/NFxBWkic1NlUbZFgL7E7llk+r8WWAykhK5TuIXNRHoiapge6mi5GoTf
        Ojw1604x0HgOz09Hd8cFk7bUa+ghkjnGol8bDUmkqoqYxgw7mrE8StJJjWkIjRvWFa1nuG
        C2kvj4IvJ8r9PooqU/WP0sE8ROEWOrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-2LKAOAxWMcKIauY_Ng6y0g-1; Tue, 09 Mar 2021 11:28:28 -0500
X-MC-Unique: 2LKAOAxWMcKIauY_Ng6y0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90CCD108BD0B;
        Tue,  9 Mar 2021 16:28:26 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E403E10023AE;
        Tue,  9 Mar 2021 16:28:16 +0000 (UTC)
Subject: Re: [PATCH 5/9] vmw_balloon: remove the balloon-vmware file system
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-6-hch@lst.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8bdd6f30-3cd1-ad7f-df95-bbb85623ae64@redhat.com>
Date:   Tue, 9 Mar 2021 17:28:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309155348.974875-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.03.21 16:53, Christoph Hellwig wrote:
> Just use the generic anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/misc/vmw_balloon.c | 24 ++----------------------
>   1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 5d057a05ddbee8..be4be32f858253 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -16,6 +16,7 @@
>   //#define DEBUG
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
> +#include <linux/anon_inodes.h>
>   #include <linux/types.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> @@ -1735,20 +1736,6 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
>   
>   
>   #ifdef CONFIG_BALLOON_COMPACTION
> -
> -static int vmballoon_init_fs_context(struct fs_context *fc)
> -{
> -	return init_pseudo(fc, BALLOON_VMW_MAGIC) ? 0 : -ENOMEM;
> -}
> -
> -static struct file_system_type vmballoon_fs = {
> -	.name           	= "balloon-vmware",
> -	.init_fs_context	= vmballoon_init_fs_context,
> -	.kill_sb        	= kill_anon_super,
> -};
> -
> -static struct vfsmount *vmballoon_mnt;
> -
>   /**
>    * vmballoon_migratepage() - migrates a balloon page.
>    * @b_dev_info: balloon device information descriptor.
> @@ -1878,8 +1865,6 @@ static void vmballoon_compaction_deinit(struct vmballoon *b)
>   		iput(b->b_dev_info.inode);
>   
>   	b->b_dev_info.inode = NULL;
> -	kern_unmount(vmballoon_mnt);
> -	vmballoon_mnt = NULL;
>   }
>   
>   /**
> @@ -1895,13 +1880,8 @@ static void vmballoon_compaction_deinit(struct vmballoon *b)
>    */
>   static __init int vmballoon_compaction_init(struct vmballoon *b)
>   {
> -	vmballoon_mnt = kern_mount(&vmballoon_fs);
> -	if (IS_ERR(vmballoon_mnt))
> -		return PTR_ERR(vmballoon_mnt);
> -
>   	b->b_dev_info.migratepage = vmballoon_migratepage;
> -	b->b_dev_info.inode = alloc_anon_inode_sb(vmballoon_mnt->mnt_sb);
> -
> +	b->b_dev_info.inode = alloc_anon_inode();
>   	if (IS_ERR(b->b_dev_info.inode))
>   		return PTR_ERR(b->b_dev_info.inode);
>   
> 

Same comment regarding BALLOON_VMW_MAGIC and includes (mount.h, 
pseudo_fs.h).

Apart from that looks good.

-- 
Thanks,

David / dhildenb

