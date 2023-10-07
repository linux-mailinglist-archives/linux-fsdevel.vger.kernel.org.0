Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866607BC9AD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 22:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbjJGUHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjJGUHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:07:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AC0BC;
        Sat,  7 Oct 2023 13:07:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3226b8de467so3096130f8f.3;
        Sat, 07 Oct 2023 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696709270; x=1697314070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frrbQG1KV2zBsqrzA92ZI0bBTicwEVY0Ipaf/Vo55cE=;
        b=L6t3Av0rBzphkX/hjyoj1JtXgEBl1CIVThXsar2HFpDEPOjnYbnPGUEygmx/EbkC3O
         DQYEjihW62EMSUynCZ/k0uvCSa4nZlgAxooEYSViejtE7zf/vwvdN2XNnZR+cBMFmbNW
         hzGcjN6K9SukJ+FJ1XHFnzOafIyN5zUd0Y4vNbwLyURtg2TRkd+ZxUCRDD+lFAUoFHaq
         C4fmaGLG5i4DGlSh2NJCaME2NeFHMc99RrOVEVx2XXg8ndWPlyrYdE7kS7dKK72JVe7t
         ZcFKiqFNsP/TgRR7OUVdsW2h7/vUFDkDeOD3UO5gz+Vfad1jOMG5vmSQ1rFxf1eIfcyo
         /Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696709270; x=1697314070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frrbQG1KV2zBsqrzA92ZI0bBTicwEVY0Ipaf/Vo55cE=;
        b=b8RNORVr2T4vW17turovDLtj2wYG7VGwO24Ms5kzAuBTqq0pdtoPhnKL0yy7pIZIIo
         R6p4Df3US9CH/mohZ0WW6GTGf/BMKjusukT9J+XikW+4ENQtCZGfUkaGS7hLtTMkuT8k
         Y3QEUEWhpWuXQHEQpybtbydSaO/2RxeWzVgpm/xpiNPHI4e7LZHHdVH+hA2LmFAUtWFI
         ahMcGcuBdMwqwl/Bemt8tzDshqIUvm3C9E8sE/skg8SDoODP+cdDV0JmEo2p9BvaoRMk
         LUOAo54jCdfATnMI+5nTFS9Mzkf6u6SGCAaSUr0NupIdriUAF2rAsNrfrEtLuT/oLZPf
         TTOA==
X-Gm-Message-State: AOJu0Yzb0kNW2Gv82ayREAbS4IParK2Le5yZw/lout/am3flxbyEm1Ds
        PUCC8GoTeFP3YYBi6PxOnww=
X-Google-Smtp-Source: AGHT+IGWQk6Kxejzx5y3Pu20Y6dY8/NNiXN6Z/O1O3DHsuExWlc4MtA1UfAL4KQLOm0NSOgL9MlAmw==
X-Received: by 2002:adf:cd0a:0:b0:320:5f:c249 with SMTP id w10-20020adfcd0a000000b00320005fc249mr9265591wrm.30.1696709270256;
        Sat, 07 Oct 2023 13:07:50 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d4a8e000000b003197b85bad2sm5052534wrq.79.2023.10.07.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 13:07:48 -0700 (PDT)
Date:   Sat, 7 Oct 2023 21:07:48 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2 3/3] mm: perform the mapping_map_writable() check
 after call_mmap()
Message-ID: <87e0d5f2-7d64-41ec-8a7c-920d5d1ca947@lucifer.local>
References: <6f3aea05c9cc46094b029cbd1138d163c1ae7f9d.1682890156.git.lstoakes@gmail.com>
 <202305161044.bba89e76-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305161044.bba89e76-yujie.liu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 01:52:06PM +0800, kernel test robot wrote:
> Hello,
>
> kernel test robot noticed "assertion_failure" on:
>
> commit: a0e22a91f487957346732c6613eb6bd1b7c72ab1 ("[PATCH v2 3/3] mm: perform the mapping_map_writable() check after call_mmap()")
> url: https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-drop-the-assumption-that-VM_SHARED-always-implies-writable/20230501-062815
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> patch link: https://lore.kernel.org/all/6f3aea05c9cc46094b029cbd1138d163c1ae7f9d.1682890156.git.lstoakes@gmail.com/
> patch subject: [PATCH v2 3/3] mm: perform the mapping_map_writable() check after call_mmap()
>
> in testcase: igt
> version: igt-x86_64-9e9cd7e6-1_20230506
> with following parameters:
>
> 	group: group-11
>
> compiler: gcc-11
> test machine: 20 threads 1 sockets (Commet Lake) with 16G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202305161044.bba89e76-yujie.liu@intel.com
>
>
> 2023-05-11 12:29:38 build/tests/gem_mmap_gtt --run-subtest basic-copy
> IGT-Version: 1.27.1-g9e9cd7e6 (x86_64) (Linux: 6.3.0-10673-ga0e22a91f487 x86_64)
> Starting subtest: basic-copy
> (gem_mmap_gtt:1138) i915/gem_mman-CRITICAL: Test assertion failure function gem_mmap__gtt, file ../lib/i915/gem_mman.c:146:
> (gem_mmap_gtt:1138) i915/gem_mman-CRITICAL: Failed assertion: ptr
> (gem_mmap_gtt:1138) i915/gem_mman-CRITICAL: Last errno: 1, Operation not permitted
> Subtest basic-copy failed.
[snip]

I don't have the hardware to test this (the repro steps don't work and
manually running the test indicates the actual hardware is required) but I
suspect it's a result of i915_gem_mmap() somehow causing
mapping_unmap_writable() to be invoked, which sets mapping->i_mmap_writable
negative, and thus the check after call_mmap() is performed reports the error.

In v3 I will change this to continue to mark the file writable before
invoking call_mmap() which should fix this issue.
