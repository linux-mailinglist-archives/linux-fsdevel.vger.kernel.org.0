Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3A435A3FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 18:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhDIQuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 12:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234169AbhDIQun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617987030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9iFNTLYUdPzXiA/Mpb6WQlIpHAgPoHtKG/OVLOk4/v0=;
        b=X6BEeKDDMGLSqsLd/bxNHhRikKPDdwAFSvaXa4fAcVaZKsC+GRntdmkvHwLafnjxtzz4L9
        ESVsDUVoGHxDkJL2mzFArnfCEYPOZYDk/OcQEzcFBFLaaZV++2RBpF4mp5t0eiWQPQiut5
        SiMTKWdVJ5iHX/UYLgaYr0pa4aFjr1s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-rHizYBZjNdKIWVzFUMRWtg-1; Fri, 09 Apr 2021 12:50:27 -0400
X-MC-Unique: rHizYBZjNdKIWVzFUMRWtg-1
Received: by mail-qk1-f198.google.com with SMTP id n191so3179522qka.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 09:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9iFNTLYUdPzXiA/Mpb6WQlIpHAgPoHtKG/OVLOk4/v0=;
        b=QxobBcMao95Nh+2T2c2WrJBGVajp1z2vifBuETy0kYcAOJXWU5PNSD7OoS2cXUZB8S
         yxEYxpmy4eKTUdN3JPowwojmVTHXBviCEgwuUQW7v51PrPA6HlOlhqfLhqlYAWoojbZo
         EaUN+C669VwYtiGUbMuuYr7qHUk5mQGpzF+vCNUWLHMfQl3lCS6oz9QTkQXjvhUHFgUR
         A+Dupfj45/5uUmR0fbx7wZ0v+H2yzzlaOfAfqL+Kh/hcULr7aHDT8FMjNdY019MawJx1
         qeB3kX1L038e5hW8MOm/x8U9i2vo4wR6Gwy3LCEBI9CSw69zgAXUS5g4Hd7qK5A9kUpi
         81eA==
X-Gm-Message-State: AOAM531wL8q0G7+qAy7sdmHCWXidt+m8iZoTkLWFVjacIIgp0h9mkx/p
        yR/cLJ2RhB44Z/x3AqUvmWiKStvNMVHpnphdzr4v8SnuL/A+8hWEtqjleIve/yE8ur7GQFcJXP4
        Q0QpCbtS4UhBOtOz9t0gG6/U9Vg==
X-Received: by 2002:ac8:698c:: with SMTP id o12mr13565676qtq.340.1617987027107;
        Fri, 09 Apr 2021 09:50:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9ET8gRIuaxSbZx1jIxLrgNMwEbCyKnI0+eLELufmMdInX+m4v62Vmy9dTudxtDhDqBn9G0g==
X-Received: by 2002:ac8:698c:: with SMTP id o12mr13565637qtq.340.1617987026785;
        Fri, 09 Apr 2021 09:50:26 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id l4sm984629qkd.105.2021.04.09.09.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:50:26 -0700 (PDT)
Date:   Fri, 9 Apr 2021 12:50:24 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 3/9] userfaultfd/shmem: support minor fault registration
 for shmem
Message-ID: <20210409165024.GF792100@xz-x1>
References: <20210408234327.624367-1-axelrasmussen@google.com>
 <20210408234327.624367-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210408234327.624367-4-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 04:43:21PM -0700, Axel Rasmussen wrote:

[...]

> @@ -1820,16 +1821,27 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  
>  	page = pagecache_get_page(mapping, index,
>  					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);
> -	if (xa_is_value(page)) {
> +	swapped = xa_is_value(page);
> +	if (swapped) {
>  		error = shmem_swapin_page(inode, index, &page,
>  					  sgp, gfp, vma, fault_type);
>  		if (error == -EEXIST)
>  			goto repeat;
> -
>  		*pagep = page;
> -		return error;
> +		if (error)
> +			return error;
>  	}
>  
> +	if (page && vma && userfaultfd_minor(vma)) {
> +		unlock_page(page);
> +		put_page(page);
> +		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> +		return 0;
> +	}

If we need to consider swapping for UFFDIO_CONTINUE later (as Hugh pointed out
previously, which looks the right thing to do), it's indeed a bit awkward to
swapin here.  Maybe move this chunk to right after pagecache_get_page()
returns?  Then no need to touch the rest.

> +
> +	if (swapped)
> +		return 0;
> +
>  	if (page)
>  		hindex = page->index;
>  	if (page && sgp == SGP_WRITE)
> -- 
> 2.31.1.295.g9ea45b61b8-goog
> 

-- 
Peter Xu

