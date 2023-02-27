Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F966A3FA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 11:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjB0Kp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 05:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB0Kpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:45:55 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89697B772
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 02:45:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VcdB.eA_1677494750;
Received: from 30.97.48.235(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcdB.eA_1677494750)
          by smtp.aliyun-inc.com;
          Mon, 27 Feb 2023 18:45:51 +0800
Message-ID: <5958ef1a-b635-96f8-7840-0752138e75e8@linux.alibaba.com>
Date:   Mon, 27 Feb 2023 18:45:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Alexander Larsson <alexl@redhat.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


(+cc Jingbo Xu and Christian Brauner)

On 2023/2/27 17:22, Alexander Larsson wrote:
> Hello,
> 
> Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
> Composefs filesystem. It is an opportunistically sharing, validating
> image-based filesystem, targeting usecases like validated ostree
> rootfs:es, validated container images that share common files, as well
> as other image based usecases.
> 
> During the discussions in the composefs proposal (as seen on LWN[3])
> is has been proposed that (with some changes to overlayfs), similar
> behaviour can be achieved by combining the overlayfs
> "overlay.redirect" xattr with an read-only filesystem such as erofs.
> 
> There are pros and cons to both these approaches, and the discussion
> about their respective value has sometimes been heated. We would like
> to have an in-person discussion at the summit, ideally also involving
> more of the filesystem development community, so that we can reach
> some consensus on what is the best apporach.
> 
> Good participants would be at least: Alexander Larsson, Giuseppe
> Scrivano, Amir Goldstein, David Chinner, Gao Xiang, Miklos Szeredi,
> Jingbo Xu
I'd be happy to discuss this at LSF/MM/BPF this year. Also we've addressed
the root cause of the performance gap is that

composefs read some data symlink-like payload data by using
cfs_read_vdata_path() which involves kernel_read() and trigger heuristic
readahead of dir data (which is also landed in composefs vdata area
together with payload), so that most composefs dir I/O is already done
in advance by heuristic  readahead.  And we think almost all exist
in-kernel local fses doesn't have such heuristic readahead and if we add
the similar stuff, EROFS could do better than composefs.

Also we've tried random stat()s about 500~1000 files in the tree you shared
(rather than just "ls -lR") and EROFS did almost the same or better than
composefs.  I guess further analysis (including blktrace) could be shown by
Jingbo later.

Not sure if Christian Brauner would like to discuss this new stacked fs
with on-disk metadata as well (especially about userns stuff since it's
somewhat a plan in the composefs roadmap as well.)

Thanks,
Gao Xiang

> 
> [1] https://github.com/containers/composefs
> [2] https://lore.kernel.org/lkml/cover.1674227308.git.alexl@redhat.com/
> [3] https://lwn.net/SubscriberLink/922851/45ed93154f336f73/
> 
