Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7499A3824A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 08:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhEQGpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 02:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233763AbhEQGpt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 02:45:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6480561241;
        Mon, 17 May 2021 06:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621233873;
        bh=T9ZQTSZNUgScjjscUGeUbBchpa/DhX2GQEJ7bdtNzBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObtoQIRNWxRguTgHnVfCVu7AKOk3Iw7wF8fqwXQR/rPc0nGO5+s6yg3D0U2vm3aT7
         XNy69ebRGLwVhrw9OWXJc0sPi4ha8KBWwsP8N1fFaZRMnjxf53cZ73/ij16KbQsw7l
         qZLKTKAD/Y2WbMMKFozt11phpM+mqIuImeNnmHBOt55cZXZ/9Ln9YjnZfxM0uI2IHE
         dpF29d0QZOKhpr05D/dOT1ho7DzutPkIeIrZw0sR6BleZy18PGvtN0RG57oGn8V+uR
         Pyn+1fmOk1a++kAEZEhqjiQGECWaRP/TYpyn+ShcWYJbNSGpgi59bEt9AD/EQ3j0cB
         RDY5jYDTRUnqQ==
Date:   Mon, 17 May 2021 09:44:21 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 6/6] fs/proc/kcore: use page_offline_(freeze|thaw)
Message-ID: <YKIQxXpp6AFGRUQ5@kernel.org>
References: <20210514172247.176750-1-david@redhat.com>
 <20210514172247.176750-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514172247.176750-7-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 07:22:47PM +0200, David Hildenbrand wrote:
> Let's properly synchronize with drivers that set PageOffline().
> Unfreeze/thaw every now and then, so drivers that want to set PageOffline()
> can make progress.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  fs/proc/kcore.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 92ff1e4436cb..982e694aae77 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -313,6 +313,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  {
>  	char *buf = file->private_data;
>  	size_t phdrs_offset, notes_offset, data_offset;
> +	size_t page_offline_frozen = 1;
>  	size_t phdrs_len, notes_len;
>  	struct kcore_list *m;
>  	size_t tsz;
> @@ -322,6 +323,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  	int ret = 0;
>  
>  	down_read(&kclist_lock);
> +	/*
> +	 * Don't race against drivers that set PageOffline() and expect no
> +	 * further page access.
> +	 */
> +	page_offline_freeze();
>  
>  	get_kcore_size(&nphdr, &phdrs_len, &notes_len, &data_offset);
>  	phdrs_offset = sizeof(struct elfhdr);
> @@ -480,6 +486,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  			}
>  		}
>  
> +		if (page_offline_frozen++ % MAX_ORDER_NR_PAGES == 0) {
> +			page_offline_thaw();
> +			cond_resched();
> +			page_offline_freeze();
> +		}
> +
>  		if (&m->list == &kclist_head) {
>  			if (clear_user(buffer, tsz)) {
>  				ret = -EFAULT;
> @@ -565,6 +577,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  	}
>  
>  out:
> +	page_offline_thaw();
>  	up_read(&kclist_lock);
>  	if (ret)
>  		return ret;
> -- 
> 2.31.1
> 

-- 
Sincerely yours,
Mike.
