Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39BB6C7128
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 20:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCWTjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 15:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCWTjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:39:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEBACC11;
        Thu, 23 Mar 2023 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ypydtE3oLX+IwCXZSmMkIoAHUeP4gcZHNPrwfPH1AHw=; b=Ra4fYq2gIVui3gAYJPzljk6ney
        ozIA/8+lHf8luaaSnU12u3/ZPdY8cp3PruOv8aWuyrklYjMXuD3z0iTOz/nQ5GvUlVJN1u4yk51tt
        3AyuICQ0P7lhZSUFHJoaiRw3B8da21yRXFpDmUAZvN0lc2G+xRc0dbhoTcEL0N3DWsbfBcPTljXma
        kscTH7nLk5NOic0Cbcoq6KcWnoeECfe8p31GTtmirU60N9zG27mFVinYT28WAASiDdbFEdjvKjZog
        nvXTMQnhfalezDMAqMsW4KmNpxnIDOdDm403yYWJW2m/JE0V+xWf+BOBcPbXCswnp08eoK4WXlxRz
        MSkjlr7w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfQmj-002qcr-1b;
        Thu, 23 Mar 2023 19:39:41 +0000
Date:   Thu, 23 Mar 2023 12:39:41 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, ye.xingchen@zte.com.cn,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V5 1/2] mm: compaction: move compaction sysctl to its own
 file
Message-ID: <ZByq/TcnxYbeReJZ@bombadil.infradead.org>
References: <202303221046286197958@zte.com.cn>
 <ZBq9uO6wLI1fX1x/@infradead.org>
 <8ff68064-3ec6-4aa2-2389-3568483a1bd4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff68064-3ec6-4aa2-2389-3568483a1bd4@suse.cz>
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

On Thu, Mar 23, 2023 at 05:19:15PM +0100, Vlastimil Babka wrote:
> On 3/22/23 09:35, Christoph Hellwig wrote:
> > On Wed, Mar 22, 2023 at 10:46:28AM +0800, ye.xingchen@zte.com.cn wrote:
> >> From: Minghao Chi <chi.minghao@zte.com.cn>
> >> 
> >> This moves all compaction sysctls to its own file.
> > 
> > So there's a whole lot of these 'move sysctrls to their own file'
> > patches, but no actual explanation of why that is desirable.  Please
> 
> I think Luis started this initiative, maybe he can provide the canonical
> reasoning :)

The kernel/sysctl.c is flooded now with commit log entries which
describe a proper rationale, however some folks forget to also include
similar rationale in new patches. I try to remind folks when I can,
thanks for reminding them to continue to do that. That needs to be fixed
in this patch. The summary is its hard to coordiante merge conflicts
with all the syctls in one place, best to just put them where they are
used.

There is a small hidden penalty increase in size to the kernel with the
sysctls moves today though and one for which Matthew Wilcox has recently asked
for us to pause these moves until we can save more memory. The extra memory
is caused by the extra empty struct ctl_table added to the end of the new
array. The way to avoid that penalty is to deprecate all APIs in sysctl
registation which deal with complex array structures. I have some some
of that addressed on my sysctl-next tree (and merged on linux-next) but
much more work is required to deprecate the older APIs. I was ready to
pause the kernel/sysctl.c moves until those APIs are deprecated and we
start having sysctl APIs which allow us to not have the empty array at
the end. But as I thought about this just now, the use cases that move
the sysctls where __init is used could benefit already in size.

For this patch there seems to be a savings of 4 bytes:

$ ./scripts/bloat-o-meter vmlinux.old vmlinux
add/remove: 1/0 grow/shrink: 1/2 up/down: 346/-350 (-4)
Function                                     old     new   delta
vm_compaction                                  -     320    +320
kcompactd_init                               167     193     +26
proc_dointvec_minmax_warn_RT_change          104      10     -94
vm_table                                    2112    1856    -256
Total: Before=19287558, After=19287554, chg -0.00%

So I don't think we need to pause this move or others where are have savings.

Minghao, can you fix the commit log, and explain how you are also saving
4 bytes as per the above bloat-o-meter results?

> > explain why we'd want to split code that is closely related, and now
> > requires marking symbols non-static just to create a new tiny source
> > file.
> 
> Hmm? I can see the opposite, at least in the compaction patch here. Related
> code and variables are moved closer together, made static, declarations
> removed from headers. It looks like an improvement to me.

Glad this helps.

  Luis
