Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685BD51E909
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 19:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446750AbiEGSDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 14:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385126AbiEGSDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 14:03:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4001462C5;
        Sat,  7 May 2022 10:59:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6B91B80B56;
        Sat,  7 May 2022 17:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487CDC385A5;
        Sat,  7 May 2022 17:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651946367;
        bh=lXqB3A0Ad6dE9qPBilXIn9VTJGcwZvnO4dUBZTdEwzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sDLtH8ryLVHB6nT6SoVTpwvMsKXjWCzTHhDgA2pMAyYiqBjYXVVQC4jAQv21uXYbK
         J6eXrC00K8tA3TrBE443Vx2GjLPqE/7wX6hV3j9pWv4AK0/ceC0fEw0WWxxDJYf/Ir
         ehBDbZHpvvcpAk1CQ9uR5ZhB9FkCELD0/0KzWm1g=
Date:   Sat, 7 May 2022 10:59:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     cgel.zte@gmail.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH v3] mm/ksm: introduce ksm_force for each process
Message-Id: <20220507105926.d4423601230f698b0f5228d1@linux-foundation.org>
In-Reply-To: <20220507054702.687958-1-xu.xin16@zte.com.cn>
References: <20220507054702.687958-1-xu.xin16@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat,  7 May 2022 05:47:02 +0000 cgel.zte@gmail.com wrote:

> To use KSM, we must explicitly call madvise() in application code,
> which means installed apps on OS needs to be uninstall and source
> code needs to be modified. It is inconvenient.
> 
> In order to change this situation, We add a new proc 'ksm_force'
> under /proc/<pid>/ to support turning on/off KSM scanning of a
> process's mm dynamically.
> 
> If ksm_force is set as 1, force all anonymous and 'qualified' vma
> of this mm to be involved in KSM scanning without explicitly
> calling madvise to make vma MADV_MERGEABLE. But It is effctive only
> when the klob of '/sys/kernel/mm/ksm/run' is set as 1.
> 
> If ksm_enale is set as 0, cancel the feature of ksm_force of this
> process and unmerge those merged pages which is not madvised as
> MERGEABLE of this process, but leave MERGEABLE areas merged.
> 

There are quite a lot of typos here.  Please proof-read it.

>  fs/proc/base.c           | 99 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mm_types.h |  9 ++++
>  mm/ksm.c                 | 32 ++++++++++++-

And please update the appropriate places under Documentation/ - all
user-facing interfaces should be well documented.

