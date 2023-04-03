Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF86D4B12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjDCOxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjDCOxa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:53:30 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723F8113C4
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 07:53:00 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id t13so21298149qvn.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 07:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680533579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUO/KjMRf7ccJa58/ksmOm78AxORGxzl+O/+LUACmVM=;
        b=iEQPySr4AvS2/y19Q8XQChnc8kEE6OKeQBoO/ux+vRpC4bSqWh9jxf646NwjiGwl0c
         +P1SkvpwR8fp03ZQfQjoDOMsJs2mWhSAGOwBrAj39YVwLGScCRdb6VM8mRSnG3vSP+mf
         5hWNcXFejUK1jETlnB2WXyq26k5DUY3rz4kb2DfwMuQgT7w8sInyi5LB7rneB/hrj3vt
         uC7q+rqPfn/azR5QPx5J5tdH+stdF37ftRkf69idQZQlKNGBhAd6Wm/MYh5c8TwyU+3l
         8eBqbEIX+6M5AJHR2RDda2+PmjjQxuBQi3MsQf48HEjOVxTDu/BkpEtJBbwot6EG19j0
         W+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUO/KjMRf7ccJa58/ksmOm78AxORGxzl+O/+LUACmVM=;
        b=lz90rv/fBpFRDt0OKN2rkUMIkSHzpbUNJxvdRvVv+rCdqvIrYE34ZNFBlW0/Tz4bZE
         m3Xe7rZtSKico6hWQ13mRllMarApo+MQ5ZNFexvvyRhPl8jo8vh1cBnQuFzNlna4IyQt
         WV/db4USilnn/ayE1ZWSeQkfIUNx8ZUGKxqtaSU2owuqUTSscIJw0cMSdIqwinSrxnnR
         0JB/RWFmGGjFEESQzs2cawFIjnyaAVsX2BcQ8h1hxuQuEsH9lZKbD3HPPixd37L0LP51
         t6Oa07G/hL2Gh89O/r4RTxVsB3BLrB+qFoDwz8sHqywQVmoXVA+yXmlWCY3GkHH3v6oE
         OzUA==
X-Gm-Message-State: AAQBX9fCkKO0TWRuyEbjpx7Pos39Ap5Gg5sU5Vpyjk2SATHIxg+OzfSi
        rBZvN2/q8E9nCcATVHyHUwun8g==
X-Google-Smtp-Source: AKy350Z/o+tPlLNvTbsM001xQWI9G0TJ9RcF3+LkMsE21GwUwGyBHbbQjAvEWF7Lm/ODUr1cvcHuZQ==
X-Received: by 2002:a05:6214:2528:b0:537:6416:fc2b with SMTP id gg8-20020a056214252800b005376416fc2bmr63124779qvb.52.1680533579550;
        Mon, 03 Apr 2023 07:52:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id z7-20020a0cf007000000b005e3d3cafc16sm211260qvk.73.2023.04.03.07.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:52:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pjLYI-006MBH-Bu;
        Mon, 03 Apr 2023 11:52:58 -0300
Date:   Mon, 3 Apr 2023 11:52:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Price <steven.price@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] smaps: Fix defined but not used smaps_shmem_walk_ops
Message-ID: <ZCroShx7wdvYW2lS@ziepe.ca>
References: <20230403111255.141623-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403111255.141623-1-steven.price@arm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 03, 2023 at 12:12:55PM +0100, Steven Price wrote:
> When !CONFIG_SHMEM smaps_shmem_walk_ops is defined but not used,
> triggering a compiler warning. Surround the definition with an #ifdef to
> keep the compiler happy.
> 
> Fixes: 7b86ac3371b7 ("pagewalk: separate function pointers from iterator data")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304031749.UiyJpxzF-lkp@intel.com/
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  fs/proc/task_mmu.c | 2 ++
>  1 file changed, 2 insertions(+)

I think it would be better to enclose the definition of
shmem_swap_usage() in its header with a stub like shmem_mapping and
remove the ifdef completely. shmem_mapping() is already compile time
false.

#ifdef CONFIG_SHMEM
        if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
                /*
                 * For shared or readonly shmem mappings we know that all
                 * swapped out pages belong to the shmem object, and we can
                 * obtain the swap value much more efficiently. For private
                 * writable mappings, we might have COW pages that are
                 * not affected by the parent swapped out pages of the shmem
                 * object, so we have to distinguish them during the page walk.
                 * Unless we know that the shmem object (or the part mapped by
                 * our VMA) has no swapped out pages at all.
                 */
                unsigned long shmem_swapped = shmem_swap_usage(vma);

                if (!start && (!shmem_swapped || (vma->vm_flags & VM_SHARED) ||
                                        !(vma->vm_flags & VM_WRITE))) {
                        mss->swap += shmem_swapped;
                } else {
                        ops = &smaps_shmem_walk_ops;
                }
        }
#endif


Jason
