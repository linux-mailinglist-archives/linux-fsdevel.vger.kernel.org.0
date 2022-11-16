Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5962BAA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 12:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiKPLBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 06:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbiKPLBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:01:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC44B45EEC
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:49:00 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id i10so34417377ejg.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSCwvxDUrivspPm0mWYSEKkrMB19obOv39RUwyA0PH0=;
        b=VJ17UkTNHUXDMc38lOye7y2paGd4FOYHBRYpe2vgelPuC55Z4g5rnX+xNi0NFRGTrN
         mdMUVKijrbkJJfn3y8Tm8vf3pLdF4omxIOM6UM8S6CVz2p3NrVUPvz4FNRN3RF3rQ/lN
         9z9ibLXy5LDPJfO5cF7QIpPDKsW5E+659K7gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSCwvxDUrivspPm0mWYSEKkrMB19obOv39RUwyA0PH0=;
        b=DNg6QtqVAdjNR8IL05efLsWEjaGrVnQgE3O+UDcX/0ri7F1MAdvUddiFK361syV98M
         JMmEFFyAl5N3g2G3WdqHYi82TUAb7ofAftT44cJfHB0RdTjgGEGOf6HAhx1XYFvKQz9h
         ImqJO00A6O8Sd/wIRMhLlUfA2QEXof+/OfZzmloNzwyDeUqE0iOt2bARt8FzLQrODqt2
         fHRZwAYauK9oYRYe8yKM1Orc7imS7ES8nvXKsJwHj47Or11Qf3ec5tWbrwJS4+XUtOzv
         lUJ97wr+0mSFmLQmpYMsbEXoVIBWdMDSfuuxmjMFLQB1tQnh0xLUMiDsqnViflWRvyQI
         HRWQ==
X-Gm-Message-State: ANoB5pkVKhVimkim8Vn2S29PJx9aKbPQ6VdKx9z2VWOV8IqmN1L9qUsc
        AwSUJ4ZrYTIRx8hatqu52CLCKA==
X-Google-Smtp-Source: AA0mqf6lc5lrEzUlEqYgu67h96R4r19JtBnDlqqKBl9ey0VuIf1EYIOTKVPSxvCTipQmxuaB88n35Q==
X-Received: by 2002:a17:906:970e:b0:7ad:ccae:a30d with SMTP id k14-20020a170906970e00b007adccaea30dmr18079730ejx.704.1668595739329;
        Wed, 16 Nov 2022 02:48:59 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id g13-20020a50ec0d000000b0045b3853c4b7sm7352935edr.51.2022.11.16.02.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:48:58 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:48:56 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Nadav Amit <namit@vmware.com>, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vlastimil Babka <vbabka@suse.cz>, linux-media@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Oded Gabbay <ogabbay@kernel.org>,
        linux-mips@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH mm-unstable v1 13/20] media: videobuf-dma-sg: remove
 FOLL_FORCE usage
Message-ID: <Y3TAGAUIo/IR+tAa@phenom.ffwll.local>
Mail-Followup-To: David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Nadav Amit <namit@vmware.com>, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>,
        linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        Oded Gabbay <ogabbay@kernel.org>, linux-mips@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-14-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-14-david@redhat.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:26:52AM +0100, David Hildenbrand wrote:
> GUP now supports reliable R/O long-term pinning in COW mappings, such
> that we break COW early. MAP_SHARED VMAs only use the shared zeropage so
> far in one corner case (DAXFS file with holes), which can be ignored
> because GUP does not support long-term pinning in fsdax (see
> check_vma_flags()).
> 
> Consequently, FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM is no longer required
> for reliable R/O long-term pinning: FOLL_LONGTERM is sufficient. So stop
> using FOLL_FORCE, which is really only for ptrace access.
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I looked at this a while ago when going through some of the follow_pfn
stuff, so

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/media/v4l2-core/videobuf-dma-sg.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/videobuf-dma-sg.c b/drivers/media/v4l2-core/videobuf-dma-sg.c
> index f75e5eedeee0..234e9f647c96 100644
> --- a/drivers/media/v4l2-core/videobuf-dma-sg.c
> +++ b/drivers/media/v4l2-core/videobuf-dma-sg.c
> @@ -151,17 +151,16 @@ static void videobuf_dma_init(struct videobuf_dmabuf *dma)
>  static int videobuf_dma_init_user_locked(struct videobuf_dmabuf *dma,
>  			int direction, unsigned long data, unsigned long size)
>  {
> +	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long first, last;
> -	int err, rw = 0;
> -	unsigned int flags = FOLL_FORCE;
> +	int err;
>  
>  	dma->direction = direction;
>  	switch (dma->direction) {
>  	case DMA_FROM_DEVICE:
> -		rw = READ;
> +		gup_flags |= FOLL_WRITE;
>  		break;
>  	case DMA_TO_DEVICE:
> -		rw = WRITE;
>  		break;
>  	default:
>  		BUG();
> @@ -177,14 +176,11 @@ static int videobuf_dma_init_user_locked(struct videobuf_dmabuf *dma,
>  	if (NULL == dma->pages)
>  		return -ENOMEM;
>  
> -	if (rw == READ)
> -		flags |= FOLL_WRITE;
> -
>  	dprintk(1, "init user [0x%lx+0x%lx => %lu pages]\n",
>  		data, size, dma->nr_pages);
>  
> -	err = pin_user_pages(data & PAGE_MASK, dma->nr_pages,
> -			     flags | FOLL_LONGTERM, dma->pages, NULL);
> +	err = pin_user_pages(data & PAGE_MASK, dma->nr_pages, gup_flags,
> +			     dma->pages, NULL);
>  
>  	if (err != dma->nr_pages) {
>  		dma->nr_pages = (err >= 0) ? err : 0;
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
