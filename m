Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072DC16C394
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 15:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgBYONo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 09:13:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45526 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgBYONo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:13:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so14864417wrs.12;
        Tue, 25 Feb 2020 06:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jxubRze50o1F8gM76cssrAcVTC+kj7bPygK0ClbrEFQ=;
        b=BZ8YTJ5QErOJ/y+jWt4D7dZix2s5LSqv9Mv10h+54eL+2avNFQYA9zenWsdvxayHa6
         sarBknWHzQvqcd6+4SeczyEULQlA1O4RzUBjBLkYUWyh95J7OWazHQZ05C9VJ2yHqDVb
         qD2CvNn3ZDw5DLOfptoMQpYGDnuffoWAm0HsCRF8sPW+swsoUcMe3gEJalR/zlxuEmLo
         NMJVO/PfQ8jOtJcKz3k/DWxpISbsPFPGf2Lw0/ojhLq8JAPelyx8y0LVvztttpYcaZw9
         FpbUnlhWfF8ckKm3k3hE8L8lr5PJ0+SavrA6eneKZ+et/YUbbNy/ovZghuqyA4n8CRwN
         t5gg==
X-Gm-Message-State: APjAAAU+FQgAnm9qoaXRRKben0d/48wW808hTqdHfWQDEPXIyjL5dfz/
        dxKJGpUk2FqSaCUzbF/0/hs=
X-Google-Smtp-Source: APXvYqzZDJ3iAatx+c1W9QUy0WfZcIu4vrV7Thvn1lJDb6r3o5K5088UhtDeqAbWOuXq8UUYWOou1g==
X-Received: by 2002:a5d:55c1:: with SMTP id i1mr79044434wrw.347.1582640020664;
        Tue, 25 Feb 2020 06:13:40 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id b10sm4161691wmj.48.2020.02.25.06.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 06:13:40 -0800 (PST)
Date:   Tue, 25 Feb 2020 15:13:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v4 11/13] mm/vmscan: Move count_vm_event(DROP_SLAB)
 into drop_slab()
Message-ID: <20200225141339.GV22443@dhcp22.suse.cz>
References: <20191212171137.13872-1-david@redhat.com>
 <20191212171137.13872-12-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212171137.13872-12-david@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-12-19 18:11:35, David Hildenbrand wrote:
> Let's count within the function itself, so every invocation (of future
> users) will be counted.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Slight inconsistency with the page cache droppint but nothing earth
shattering.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/drop_caches.c | 4 +---
>  mm/vmscan.c      | 1 +
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index d31b6c72b476..a042da782fcd 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -61,10 +61,8 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
>  			iterate_supers(drop_pagecache_sb, NULL);
>  			count_vm_event(DROP_PAGECACHE);
>  		}
> -		if (sysctl_drop_caches & 2) {
> +		if (sysctl_drop_caches & 2)
>  			drop_slab();
> -			count_vm_event(DROP_SLAB);
> -		}
>  		if (!stfu) {
>  			pr_info("%s (%d): drop_caches: %d\n",
>  				current->comm, task_pid_nr(current),
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5a6445e86328..c3e53502a84a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -726,6 +726,7 @@ void drop_slab(void)
>  
>  	for_each_online_node(nid)
>  		drop_slab_node(nid);
> +	count_vm_event(DROP_SLAB);
>  }
>  
>  static inline int is_page_cache_freeable(struct page *page)
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
