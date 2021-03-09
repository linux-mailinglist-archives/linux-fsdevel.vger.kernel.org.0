Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ABE332BEE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 17:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCIQ0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 11:26:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230435AbhCIQ0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615307191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QDc/X1+87E7IT2HUEvNRCZ2BjXCFrZE0D42derxTKz0=;
        b=Rj7megbT3ZnaJVu6v6GHR7ErBpdzGK9gcEME3OT9GH38vrvkdTj/gik6bGImow//XcHgXx
        mz/avtYQXbVNNdI841QJp/AJtSVBL4Jfw8s4xNEAPAPPA5Mn2sAWkl/OM1Da2zRrs3ScHE
        sTAgY19wj3yWf6WTGLTbOAr2tMEmuTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-Q3Hdf_Q4ODeKumoAfx1BcQ-1; Tue, 09 Mar 2021 11:26:24 -0500
X-MC-Unique: Q3Hdf_Q4ODeKumoAfx1BcQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 374F7108BD08;
        Tue,  9 Mar 2021 16:26:22 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1707A19C59;
        Tue,  9 Mar 2021 16:26:18 +0000 (UTC)
Subject: Re: [PATCH 3/9] powerpc/pseries: remove the ppc-cmm file system
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
 <20210309155348.974875-4-hch@lst.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <001be2e1-995c-d5d9-734f-06f75c702b42@redhat.com>
Date:   Tue, 9 Mar 2021 17:26:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309155348.974875-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.03.21 16:53, Christoph Hellwig wrote:
> Just use the generic anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/powerpc/platforms/pseries/cmm.c | 27 ++-------------------------
>   1 file changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 6d36b858b14df1..9d07e6bea7126c 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -6,6 +6,7 @@
>    * Author(s): Brian King (brking@linux.vnet.ibm.com),
>    */
>   
> +#include <linux/anon_inodes.h>
>   #include <linux/ctype.h>
>   #include <linux/delay.h>
>   #include <linux/errno.h>
> @@ -502,19 +503,6 @@ static struct notifier_block cmm_mem_nb = {
>   };
>   
>   #ifdef CONFIG_BALLOON_COMPACTION
> -static struct vfsmount *balloon_mnt;
> -
> -static int cmm_init_fs_context(struct fs_context *fc)
> -{
> -	return init_pseudo(fc, PPC_CMM_MAGIC) ? 0 : -ENOMEM;
> -}
> -
> -static struct file_system_type balloon_fs = {
> -	.name = "ppc-cmm",
> -	.init_fs_context = cmm_init_fs_context,
> -	.kill_sb = kill_anon_super,
> -};
> -
>   static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>   			   struct page *newpage, struct page *page,
>   			   enum migrate_mode mode)
> @@ -573,19 +561,10 @@ static int cmm_balloon_compaction_init(void)
>   	balloon_devinfo_init(&b_dev_info);
>   	b_dev_info.migratepage = cmm_migratepage;
>   
> -	balloon_mnt = kern_mount(&balloon_fs);
> -	if (IS_ERR(balloon_mnt)) {
> -		rc = PTR_ERR(balloon_mnt);
> -		balloon_mnt = NULL;
> -		return rc;
> -	}
> -
> -	b_dev_info.inode = alloc_anon_inode_sb(balloon_mnt->mnt_sb);
> +	b_dev_info.inode = alloc_anon_inode();
>   	if (IS_ERR(b_dev_info.inode)) {
>   		rc = PTR_ERR(b_dev_info.inode);
>   		b_dev_info.inode = NULL;
> -		kern_unmount(balloon_mnt);
> -		balloon_mnt = NULL;
>   		return rc;
>   	}
>   
> @@ -597,8 +576,6 @@ static void cmm_balloon_compaction_deinit(void)
>   	if (b_dev_info.inode)
>   		iput(b_dev_info.inode);
>   	b_dev_info.inode = NULL;
> -	kern_unmount(balloon_mnt);
> -	balloon_mnt = NULL;
>   }
>   #else /* CONFIG_BALLOON_COMPACTION */
>   static int cmm_balloon_compaction_init(void)
> 

I always wondered why that was necessary after all (with my limited fs 
knowledge :) ).

a) I assume you want to remove PPC_CMM_MAGIC from 
include/uapi/linux/magic.h as well?

b) Do we still need #include <linux/magic.h>, #include <linux/mount.h> 
and #include <linux/pseudo_fs.h>?

Apart from that looks much cleaner.

-- 
Thanks,

David / dhildenb

