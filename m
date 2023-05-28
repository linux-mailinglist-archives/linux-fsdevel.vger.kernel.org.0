Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D11713A6D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 May 2023 17:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjE1PxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 May 2023 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjE1PxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 May 2023 11:53:21 -0400
Received: from out28-84.mail.aliyun.com (out28-84.mail.aliyun.com [115.124.28.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26575B2;
        Sun, 28 May 2023 08:53:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1322099|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0385983-0.000103678-0.961298;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.TEnfwM8_1685289193;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.TEnfwM8_1685289193)
          by smtp.aliyun-inc.com;
          Sun, 28 May 2023 23:53:14 +0800
Date:   Sun, 28 May 2023 23:53:15 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: gfs2 write bandwidth regression on 6.4-rc3 compareto 5.15.y
In-Reply-To: <20230523085929.614A.409509F4@e16-tech.com>
References: <20230523085929.614A.409509F4@e16-tech.com>
Message-Id: <20230528235314.7852.409509F4@e16-tech.com>
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

> Hi,
> 
> gfs2 write bandwidth regression on 6.4-rc3 compare to 5.15.y.
> 
> we added  linux-xfs@ and linux-fsdevel@ because some related problem[1]
> and related patches[2].
> 
> we compared 6.4-rc3(rather than 6.1.y) to 5.15.y becasue some related patches[2]
> work only for 6.4 now.
> 
> [1] https://lore.kernel.org/linux-xfs/20230508172406.1CF3.409509F4@e16-tech.com/
> [2] https://lore.kernel.org/linux-xfs/20230520163603.1794256-1-willy@infradead.org/
> 
> 
> test case:
> 1) PCIe3 SSD *4 with LVM
> 2) gfs2 lock_nolock
>     gfs2 attr(T) GFS2_AF_ORLOV
>    # chattr +T /mnt/test
> 3) fio
> fio --name=global --rw=write -bs=1024Ki -size=32Gi -runtime=30 -iodepth 1
> -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 -numjobs=1 \
> 	-name write-bandwidth-1 -filename=/mnt/test/sub1/1.txt \
> 	-name write-bandwidth-2 -filename=/mnt/test/sub2/1.txt \
> 	-name write-bandwidth-3 -filename=/mnt/test/sub3/1.txt \
> 	-name write-bandwidth-4 -filename=/mnt/test/sub4/1.txt
> 4) patches[2] are applied to 6.4-rc3.
> 
> 
> 5.15.y result
> 	fio WRITE: bw=5139MiB/s (5389MB/s),
> 6.4-rc3 result
> 	fio  WRITE: bw=2599MiB/s (2725MB/s)

more test result:

5.17.0	WRITE: bw=4988MiB/s (5231MB/s)
5.18.0	WRITE: bw=5165MiB/s (5416MB/s)
5.19.0	WRITE: bw=5511MiB/s (5779MB/s)
6.0.5	WRITE: bw=3055MiB/s (3203MB/s),	WRITE: bw=3225MiB/s (3382MB/s)
6.1.30	WRITE: bw=2579MiB/s (2705MB/s)

so this regression  happen in some code introduced in 6.0,
and maybe some minor regression in 6.1 too?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/05/28

