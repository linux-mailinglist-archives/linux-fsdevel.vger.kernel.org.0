Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35076CC994
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjC1Rqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjC1Rqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:46:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C45D1;
        Tue, 28 Mar 2023 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y9+w3S5J3Vw2FuGbI9EqpsTol39UocOltTUjYy56Ws4=; b=H4RJjAuNFBRkz6dH6ykqU0ih3r
        NQsUFwJozFJ1SE0+eYgfPSdIWrRdNZSw1w0jQ2D6YSBSQ5lB6BibYdrSonVIO6sBOU7vAZhZ2+JxZ
        Yqv2GfSj3MsuHi3kIyJOq1jOQeG1codlZUTC4wTbkof/pbBDsyKy5bdpS+Rbsppv/KlnlsblBCETg
        d3by0muu5JlA5BgXtSKEMJDu7XJgmkrFcCxr3Y2DI9A9IlYjrNNuO9RDLx+V9Tz6DA0mlRJiTx/HT
        D/yx0NZlaPGnISqiFVnl2qQunqS4WXNHEbGDzq6UUtZlMrHkSIAFbW5fjemrbafOppGey6U1fPLFZ
        Mf/VpBBA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phDP6-00FMVR-1L;
        Tue, 28 Mar 2023 17:46:40 +0000
Date:   Tue, 28 Mar 2023 10:46:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     ye.xingchen@zte.com.cn, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, chi.minghao@zte.com.cn,
        linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V8 1/2] mm: compaction: move compaction sysctl to its own
 file
Message-ID: <ZCMoAKgGj3PnOtMw@bombadil.infradead.org>
References: <202303281446280457758@zte.com.cn>
 <a231f05c-b157-f495-bf06-8aca903c7e17@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a231f05c-b157-f495-bf06-8aca903c7e17@suse.cz>
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

On Tue, Mar 28, 2023 at 10:56:52AM +0200, Vlastimil Babka wrote:
> On 3/28/23 08:46, ye.xingchen@zte.com.cn wrote:
> > From: Minghao Chi <chi.minghao@zte.com.cn>
> > 
> > This moves all compaction sysctls to its own file.
> > 
> > Move sysctl to where the functionality truly belongs to improve
> > readability, reduce merge conflicts, and facilitate maintenance.
> > 
> > I use x86_defconfig and linux-next-20230327 branch
> > $ make defconfig;make all -jn
> > CONFIG_COMPACTION=y
> > 
> > add/remove: 1/0 grow/shrink: 1/1 up/down: 350/-256 (94)
> > Function                                     old     new   delta
> > vm_compaction                                  -     320    +320
> > kcompactd_init                               180     210     +30
> > vm_table                                    2112    1856    -256
> > Total: Before=21119987, After=21120081, chg +0.00%
> > 
> > Despite the addition of 94 bytes the patch still seems a worthwile
> > cleanup.
> > 
> > Link: https://lore.kernel.org/lkml/067f7347-ba10-5405-920c-0f5f985c84f4@suse.cz/
> > Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks, queued up on sysctl-next.

  Luis
