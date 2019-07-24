Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B2C72987
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 10:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfGXIII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 04:08:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36219 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGXIII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:08:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so33107607qkl.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2019 01:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/MFYQFzENwHk5G46kOvOVKTzaxjp4jXpKM7WypPWBDc=;
        b=Nhzy9AzVS0KSK0Xg9KN9bhUaRnRGluMjXgnDkQ4yrYC2HE+JNwhUq65X2pzq+Kdti/
         G7brW544C7c8cn333l7AKguxZ6OGHb4G61jTwi12YB/WlWc274wwW3IjpUnZsVo5UMbD
         jClktlUx3l2yvesLtFsZBUr04vpNK0zntQWid2mZNktYZpaZJDTiU2cIfQMD0oknVrfc
         gqBtM2oB459pCTTWV64X1lVgIWgIzuS0CF/zrvQI5xoW1obtphlQHnUXZagatZuNyLF0
         bk660kmucWKxUKD6RyDFjz8MlERx5UZ2rBYAO0QEd52cFeQ+WZNniGb2aNnZ9n9wZOZH
         6W/A==
X-Gm-Message-State: APjAAAWpGDOeq7v/2KcM4056LrQa8/eZle0lJLEQnXmVfqme1bnxT+L2
        phaOOGhF8AkgxZohCPNpKWGY/g==
X-Google-Smtp-Source: APXvYqyqOJ7xj5WyBSGnSKw6r+fHzKSSQgggyWILPC/N5KbhyvrIGi3wpGDnO2q6i0xNWsrtSCd37A==
X-Received: by 2002:a05:620a:31b:: with SMTP id s27mr17648521qkm.264.1563955687250;
        Wed, 24 Jul 2019 01:08:07 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id t26sm23203051qtc.95.2019.07.24.01.07.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 01:08:06 -0700 (PDT)
Date:   Wed, 24 Jul 2019 04:07:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org,
        kvm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, samba-technical@lists.samba.org,
        v9fs-developer@lists.sourceforge.net,
        virtualization@lists.linux-foundation.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Boaz Harrosh <boaz@plexistor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 07/12] vhost-scsi: convert put_page() to put_user_page*()
Message-ID: <20190724040745-mutt-send-email-mst@kernel.org>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
 <20190724042518.14363-8-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190724042518.14363-8-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 23, 2019 at 09:25:13PM -0700, john.hubbard@gmail.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> Changes from Jérôme's original patch:
> 
> * Changed a WARN_ON to a BUG_ON.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-block@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Boaz Harrosh <boaz@plexistor.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/scsi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index a9caf1bc3c3e..282565ab5e3f 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -329,11 +329,11 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
>  
>  	if (tv_cmd->tvc_sgl_count) {
>  		for (i = 0; i < tv_cmd->tvc_sgl_count; i++)
> -			put_page(sg_page(&tv_cmd->tvc_sgl[i]));
> +			put_user_page(sg_page(&tv_cmd->tvc_sgl[i]));
>  	}
>  	if (tv_cmd->tvc_prot_sgl_count) {
>  		for (i = 0; i < tv_cmd->tvc_prot_sgl_count; i++)
> -			put_page(sg_page(&tv_cmd->tvc_prot_sgl[i]));
> +			put_user_page(sg_page(&tv_cmd->tvc_prot_sgl[i]));
>  	}
>  
>  	vhost_scsi_put_inflight(tv_cmd->inflight);
> @@ -630,6 +630,13 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
>  	size_t offset;
>  	unsigned int npages = 0;
>  
> +	/*
> +	 * Here in all cases we should have an IOVEC which use GUP. If that is
> +	 * not the case then we will wrongly call put_user_page() and the page
> +	 * refcount will go wrong (this is in vhost_scsi_release_cmd())
> +	 */
> +	WARN_ON(!iov_iter_get_pages_use_gup(iter));
> +
>  	bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
>  				VHOST_SCSI_PREALLOC_UPAGES, &offset);
>  	/* No pages were pinned */
> @@ -681,7 +688,7 @@ vhost_scsi_iov_to_sgl(struct vhost_scsi_cmd *cmd, bool write,
>  			while (p < sg) {
>  				struct page *page = sg_page(p++);
>  				if (page)
> -					put_page(page);
> +					put_user_page(page);
>  			}
>  			return ret;
>  		}
> -- 
> 2.22.0
