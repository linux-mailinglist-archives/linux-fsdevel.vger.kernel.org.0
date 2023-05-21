Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D62370ADB5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 13:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjEULrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjEULqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 07:46:05 -0400
Received: from out28-62.mail.aliyun.com (out28-62.mail.aliyun.com [115.124.28.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A47E58;
        Sun, 21 May 2023 04:40:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1352782|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0462248-0.00033699-0.953438;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.T87AWYB_1684669252;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.T87AWYB_1684669252)
          by smtp.aliyun-inc.com;
          Sun, 21 May 2023 19:40:53 +0800
Date:   Sun, 21 May 2023 19:40:54 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 0/3] Create large folios in iomap buffered write path
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
In-Reply-To: <20230520163603.1794256-1-willy@infradead.org>
References: <20230520163603.1794256-1-willy@infradead.org>
Message-Id: <20230521194053.8CD1.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> Wang Yugui has a workload which would be improved by using large folios.
> Until now, we've only created large folios in the readahead path,
> but this workload writes without reading.  The decision of what size
> folio to create is based purely on the size of the write() call (unlike
> readahead where we keep history and can choose to create larger folios
> based on that history even if individual reads are small).
> 
> The third patch looks like it's an optional extra but is actually needed
> for the first two patches to work in the write path, otherwise it limits
> the length that iomap_get_folio() sees to PAGE_SIZE.
> 
> Matthew Wilcox (Oracle) (3):
>   filemap: Allow __filemap_get_folio to allocate large folios
>   iomap: Create large folios in the buffered write path
>   iomap: Copy larger chunks from userspace

The [PATCH 2/3] is a little difficult to backport to 6.1.y(LTS),
it need some patches as depency.

so please provide those patches based on 6.1.y(LTS)  and depency list?
then we can do more test on 6.1.y(LTS) too.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/05/21



>  fs/gfs2/bmap.c          |  2 +-
>  fs/iomap/buffered-io.c  | 32 ++++++++++++++++++------------
>  include/linux/iomap.h   |  2 +-
>  include/linux/pagemap.h | 29 ++++++++++++++++++++++++---
>  mm/filemap.c            | 44 ++++++++++++++++++++++++++++-------------
>  mm/folio-compat.c       |  2 +-
>  mm/readahead.c          | 13 ------------
>  7 files changed, 78 insertions(+), 46 deletions(-)
> 
> -- 
> 2.39.2


