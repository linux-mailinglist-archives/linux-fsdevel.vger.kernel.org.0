Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317D570ABED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 03:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjEUBjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 21:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEUBjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 21:39:05 -0400
Received: from out28-60.mail.aliyun.com (out28-60.mail.aliyun.com [115.124.28.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345EF124;
        Sat, 20 May 2023 18:39:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1184889|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.102211-0.00036233-0.897427;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.T7rs1wW_1684633137;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.T7rs1wW_1684633137)
          by smtp.aliyun-inc.com;
          Sun, 21 May 2023 09:38:59 +0800
Date:   Sun, 21 May 2023 09:38:59 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/3] Create large folios in iomap buffered write path
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
In-Reply-To: <ZGls826bw3WeVG7L@casper.infradead.org>
References: <20230521084952.0BCC.409509F4@e16-tech.com> <ZGls826bw3WeVG7L@casper.infradead.org>
Message-Id: <20230521093858.06CA.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> On Sun, May 21, 2023 at 08:49:53AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > > Wang Yugui has a workload which would be improved by using large folios.
> > > Until now, we've only created large folios in the readahead path,
> > > but this workload writes without reading.  The decision of what size
> > > folio to create is based purely on the size of the write() call (unlike
> > > readahead where we keep history and can choose to create larger folios
> > > based on that history even if individual reads are small).
> > > 
> > > The third patch looks like it's an optional extra but is actually needed
> > > for the first two patches to work in the write path, otherwise it limits
> > > the length that iomap_get_folio() sees to PAGE_SIZE.
> > 
> > very good test result on 6.4.0-rc2. 
> > # just drop ';' in 'if (bytes > folio_size(folio) - offset);' of [PATCH 3/3].
> > 
> > fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30 -iodepth 1
> > -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 -numjobs=4
> > -directory=/mnt/test
> > fio WRITE: bw=7655MiB/s (8027MB/s).
> > 
> > Now it is the same as 5.15.y
> 
> Great!  How close is that to saturating the theoretical write bandwidth
> of your storage?

SSD:  PCIe3  SSD U.2 *4 (1.6T/3.2T/3.2T/3.2T, just 800G used) through a NVMe
adapater.
CPU: E5-2680 v2 @ 2.80GHz *2
memory: DDR3 * 3 channel

so theoretical write bandwidth maybe over 12GB/s,
but 8GB/s maybe the in fact bandwidth because of 
- write depth limit
- NVMe adapther limit
- CPU/memory limit

I also noticed a huge improvement for single thread dd.

# 6.4.0-rc2 with this patch
#dd-9.1 conv=fsync bs=1024K count=32K if=/dev/zero of=/mnt/test/dd.txt
34359738368 bytes (34 GB, 32 GiB) copied, 6.96108 s, 4.6 GiB/s

But it is about 2.2GiB/s in xfs/5.15.y.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/05/21


