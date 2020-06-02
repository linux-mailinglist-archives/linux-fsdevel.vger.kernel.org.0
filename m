Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359941EB43E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 06:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgFBEWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 00:22:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34725 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725957AbgFBEWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591071755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDfsRlwfRR1nDcp4wd5hK1KujxFVRibBNSbBOaOrz2Q=;
        b=X8FnC/x9SCa5vJY15Os/NgB6nawcFpKJaDXreIB8m84EPDlTy9XHLAWv/Zny3K0FHi4Nb3
        8LdpUU/8m/eOLIxkEiiX9UFoTyhOTFaK/KJFTZMPWNZ3Let1L3FvT3iSJVQSnPTVqcc4R7
        i1c1lgV4k52xxGtwe+/HGiSPJXPtk+c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-ke-FVvXQOJi2LjjeUPm_Dg-1; Tue, 02 Jun 2020 00:22:30 -0400
X-MC-Unique: ke-FVvXQOJi2LjjeUPm_Dg-1
Received: by mail-wm1-f70.google.com with SMTP id h25so498402wmb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2020 21:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDfsRlwfRR1nDcp4wd5hK1KujxFVRibBNSbBOaOrz2Q=;
        b=Z9caD32gkn74SS3fbh5oZjr4lt2KxgShALa7ktLkcSM0fZNs5Ci6++ipHwqNCctXV9
         BcaZLgW6lKXi+nek4TIkSsYenBL8Oocec7KfjPiOYYp4Xrj7ZVKsPSiRZky9CDCe9Nkg
         o0Qh28NUjjpS4rHXEnEZeBMs9xq44LcXdgz5eVKp8zo9+FeKSCMpadPsluL+pLGSG+eX
         wrkH0DhPsG2rJaNb4ClpSN4rWn3B7kscsavoOCMR5hdU+1vP+f7eI/S6pJCOlTkTBcMV
         UZESDDJUiN7De45Usz+XJyjfWy3LA1rkSjrBW0qHcvnhH/UTt/NmKX4IKVjjlPehqYoc
         z+VA==
X-Gm-Message-State: AOAM53224LhD2cqb6LMRCSndXBQJ4SIqBlis6Qu6rAYUp7ftyWcqNPen
        3ypTKd1O2z5ETEZ4NKo7F+//dSeNqsPi0FV2XDgxY90wAkLGiemgwEjbuK7IMUv2fkobtsi+NUs
        r/anceiQ05OdsOmZljteLNOF9KA==
X-Received: by 2002:a05:6000:1083:: with SMTP id y3mr23714190wrw.425.1591071749222;
        Mon, 01 Jun 2020 21:22:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2SKrCnIib4b4OHp9esqIfnn8bX4FrOHyf8lEFnkhypfH/4sW2rsrN9doierFMkcN8evfSkA==
X-Received: by 2002:a05:6000:1083:: with SMTP id y3mr23714174wrw.425.1591071749030;
        Mon, 01 Jun 2020 21:22:29 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id z2sm1731263wrs.87.2020.06.01.21.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:22:28 -0700 (PDT)
Date:   Tue, 2 Jun 2020 00:22:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] vhost: convert get_user_pages() --> pin_user_pages()
Message-ID: <20200602002212-mutt-send-email-mst@kernel.org>
References: <20200529234309.484480-1-jhubbard@nvidia.com>
 <20200529234309.484480-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529234309.484480-3-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 04:43:09PM -0700, John Hubbard wrote:
> This code was using get_user_pages*(), in approximately a "Case 5"
> scenario (accessing the data within a page), using the categorization
> from [1]. That means that it's time to convert the get_user_pages*() +
> put_page() calls to pin_user_pages*() + unpin_user_pages() calls.
> 
> There is some helpful background in [2]: basically, this is a small
> part of fixing a long-standing disconnect between pinning pages, and
> file systems' use of those pages.
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>     https://lwn.net/Articles/807108/
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/vhost.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 21a59b598ed8..596132a96cd5 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1762,15 +1762,14 @@ static int set_bit_to_user(int nr, void __user *addr)
>  	int bit = nr + (log % PAGE_SIZE) * 8;
>  	int r;
>  
> -	r = get_user_pages_fast(log, 1, FOLL_WRITE, &page);
> +	r = pin_user_pages_fast(log, 1, FOLL_WRITE, &page);
>  	if (r < 0)
>  		return r;
>  	BUG_ON(r != 1);
>  	base = kmap_atomic(page);
>  	set_bit(bit, base);
>  	kunmap_atomic(base);
> -	set_page_dirty_lock(page);
> -	put_page(page);
> +	unpin_user_pages_dirty_lock(&page, 1, true);
>  	return 0;
>  }
>  
> -- 
> 2.26.2

