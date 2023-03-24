Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C846C8488
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCXSLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCXSLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:11:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0C15C81;
        Fri, 24 Mar 2023 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gnerbpCPsPLVCcKOjYr9IDYevUX0qSWzWV6ueg4TeJI=; b=I6qos94qsOkjPfh25S2EXs0EEw
        kAriqRKGUCL+rq7FwvkPTaOKDGAkyKTXMpp464X8uHCrl7zZXsAY9j3bdYdAmGO3OSXDWqnq8Npy4
        8b2SN2yLnvFkxzB4LAIfEIWwb+i/GrFapFYGHyoHkjPSfocGhxM8IvUeEIupFbk1WfK3Ne+OpBibY
        5A23eQcv8T96dzpYb2V96rWPc8+IHxSnHL2au6i3WuJxsn1pPdC0Air3yC042qxp+pHRjzdai1q1r
        It0Li1iOkF7qcMRScRPQlnrzPGwABos/hCnvCfjgFKiz9riaUq8u0bmGqXt1VU3bzY5yl2WJEu2/3
        NDw/DdpQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pflt0-005GES-1Z;
        Fri, 24 Mar 2023 18:11:34 +0000
Date:   Fri, 24 Mar 2023 11:11:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ye xingchen <yexingchen116@gmail.com>
Cc:     akpm@linux-foundation.org, chi.minghao@zte.com.cn,
        hch@infradead.org, keescook@chromium.org, linmiaohe@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, willy@infradead.org,
        ye.xingchen@zte.com.cn, yzaikin@google.com
Subject: Re: [PATCH V5 1/2] mm: compaction: move compaction sysctl to its own
 file
Message-ID: <ZB3n1pJZsOK+E/Zk@bombadil.infradead.org>
References: <ZByq/TcnxYbeReJZ@bombadil.infradead.org>
 <20230324062408.49217-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324062408.49217-1-ye.xingchen@zte.com.cn>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 06:24:08AM +0000, ye xingchen wrote:
> >$ ./scripts/bloat-o-meter vmlinux.old vmlinux
> >add/remove: 1/0 grow/shrink: 1/2 up/down: 346/-350 (-4)
> >Function                                     old     new   delta
> >vm_compaction                                  -     320    +320
> >kcompactd_init                               167     193     +26
> >proc_dointvec_minmax_warn_RT_change          104      10     -94
> >vm_table                                    2112    1856    -256
> >Total: Before=19287558, After=19287554, chg -0.00%
> >
> >So I don't think we need to pause this move or others where are have savings.
> >
> >Minghao, can you fix the commit log, and explain how you are also saving
> >4 bytes as per the above bloat-o-meter results?
> 
> $ ./scripts/bloat-o-meter vmlinux vmlinux.new
> add/remove: 1/0 grow/shrink: 1/1 up/down: 350/-256 (94)
> Function                                     old     new   delta
> vm_compaction                                  -     320    +320
> kcompactd_init                               180     210     +30
> vm_table                                    2112    1856    -256
> Total: Before=21104198, After=21104292, chg +0.00%
> 
> In my environment, kcompactd_init increases by 30 instead of 26.
> And proc_dointvec_minmax_warn_RT_change No expansion.

How about a defconfig + compaction enabled? Provide that information
and let Vlastimal ACK/NACK the patch.

  Luis
