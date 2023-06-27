Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A6573FFD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjF0PgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0PgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6F2D4B
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687880122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G1ALzO/wFiWKSePyymH4fMjBT5VyA413q3eqPcghorU=;
        b=S0zYvqXmyS67WS4awvnZvKr2EiUcWTYsvZpKITIEeau2ykzlWNNG8a3h4kMKwKmIrp869y
        AxpY/3mfbMb3PIul8v8eDq/qVED/mXkBlPfyHTD/Vx6uOpegVyaubGUEPa2vQE2D06zoFe
        KqwkWEpXhh0+QMgGu3ji/3OnamgpT+A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-gi6F-kbNNS2lUpRR1hdc2g-1; Tue, 27 Jun 2023 11:33:01 -0400
X-MC-Unique: gi6F-kbNNS2lUpRR1hdc2g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40234d83032so2252831cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 08:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687879957; x=1690471957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1ALzO/wFiWKSePyymH4fMjBT5VyA413q3eqPcghorU=;
        b=lVyfZ6ycowLpHG6OwUHy3trxoBuUbFKXoiiFCxeVEQl4qXGkNcmAPYQA3Lw6Yx66ul
         yIWqErB0W9V5G9Y1qJx4szZP619XEHits04GiM5CYEAq4m4N/zoi+rBhMyZNKZqG1dhQ
         gI/Uv077PrxptrwFbldW3XFYMfCbIAl/fkliY2lJ39I6rTGM+arFazf9WZsQoxh6eGhX
         VYW16hMeM0+q97em8WTlO4+81DTf7fqyewshBcKfXIw1gvKymP4+1KIw/L2Hj57j0PFo
         q/FSvljp9epWvv3ks1owgl25O/ppiRRijr07LirsRcNBnvXUhB3dUrLZ8721/Kqd987Z
         wVAg==
X-Gm-Message-State: AC+VfDz3Zi7B8182PMU8+Xv1AQrLabTJ342inXyWTyxLTq/fSQSW+uP3
        fYsELV0BsRPXkOkwupXjNUSvFRgbT/S28PQIqd2I2aVCIyVYtMbk2Sd+y0HFpvRAXqwUFt7saaT
        9TSMeXs25xGY9JFPUERFbxdAVWg==
X-Received: by 2002:a05:622a:cd:b0:400:7965:cfe with SMTP id p13-20020a05622a00cd00b0040079650cfemr21655401qtw.4.1687879957095;
        Tue, 27 Jun 2023 08:32:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zPzMhz4REkPK/MBYPYe5SrH6d3O3dbP7Q5ElYBJDoHZfw+Ezf8WGzTdhTD7wkJOjvplAZ+Q==
X-Received: by 2002:a05:622a:cd:b0:400:7965:cfe with SMTP id p13-20020a05622a00cd00b0040079650cfemr21655381qtw.4.1687879956819;
        Tue, 27 Jun 2023 08:32:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id w22-20020ac843d6000000b003fb6cd74482sm4656322qtn.50.2023.06.27.08.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:32:36 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:32:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 5/8] mm: make folio_lock_fault indicate the state of
 mmap_lock upon return
Message-ID: <ZJsBEk4OHlp39vEK@x1n>
References: <20230627042321.1763765-1-surenb@google.com>
 <20230627042321.1763765-6-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230627042321.1763765-6-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:23:18PM -0700, Suren Baghdasaryan wrote:
> folio_lock_fault might drop mmap_lock before returning and to extend it
> to work with per-VMA locks, the callers will need to know whether the
> lock was dropped or is still held. Introduce new fault_flag to indicate
> whether the lock got dropped and store it inside vm_fault flags.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm_types.h | 1 +
>  mm/filemap.c             | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 79765e3dd8f3..6f0dbef7aa1f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1169,6 +1169,7 @@ enum fault_flag {
>  	FAULT_FLAG_UNSHARE =		1 << 10,
>  	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
>  	FAULT_FLAG_VMA_LOCK =		1 << 12,
> +	FAULT_FLAG_LOCK_DROPPED =	1 << 13,
>  };
>  
>  typedef unsigned int __bitwise zap_flags_t;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 87b335a93530..8ad06d69895b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1723,6 +1723,7 @@ vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
>  			return VM_FAULT_RETRY;
>  
>  		mmap_read_unlock(mm);
> +		vmf->flags |= FAULT_FLAG_LOCK_DROPPED;
>  		if (vmf->flags & FAULT_FLAG_KILLABLE)
>  			folio_wait_locked_killable(folio);
>  		else
> @@ -1735,6 +1736,7 @@ vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
>  		ret = __folio_lock_killable(folio);
>  		if (ret) {
>  			mmap_read_unlock(mm);
> +			vmf->flags |= FAULT_FLAG_LOCK_DROPPED;
>  			return VM_FAULT_RETRY;
>  		}
>  	} else {

IIRC we've discussed about this bits in previous version, and the consensus
was that we don't need yet another flag?  Just to recap: I think relying on
RETRY|COMPLETE would be enough for vma lock, as NOWAIT is only used by gup
while not affecting vma lockings, no?

As mentioned in the other reply, even COMPLETE won't appear for vma lock
path yet afaict, so mostly only RETRY matters here and it can 100% imply a
lock release happened.  It's just that it's very easy to still cover
COMPLETE altogether in this case, being prepared for any possible shared
support on vma locks, IMHO.

Thanks,

-- 
Peter Xu

