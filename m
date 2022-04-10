Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE9B4FADF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Apr 2022 14:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbiDJMyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Apr 2022 08:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiDJMyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Apr 2022 08:54:06 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DFE65D01;
        Sun, 10 Apr 2022 05:51:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V9eO7PR_1649595108;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V9eO7PR_1649595108)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 10 Apr 2022 20:51:50 +0800
Date:   Sun, 10 Apr 2022 20:51:47 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: Re: [PATCH v8 00/20] fscache,erofs: fscache-based on-demand read
 semantics
Message-ID: <YlLS47A9TpHyZJQi@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:55:52PM +0800, Jeffle Xu wrote:
> changes since v7:
> - rebased to 5.18-rc1
> - include "cachefiles: unmark inode in use in error path" patch into
>   this patchset to avoid warning from test robot (patch 1)
> - cachefiles: rename [cookie|volume]_key_len field of struct
>   cachefiles_open to [cookie|volume]_key_size to avoid potential
>   misunderstanding. Also add more documentation to
>   include/uapi/linux/cachefiles.h. (patch 3)
> - cachefiles: valid check for error code returned from user daemon
>   (patch 3)
> - cachefiles: change WARN_ON_ONCE() to pr_info_once() when user daemon
>   closes anon_fd prematurely (patch 4/5)
> - ready for complete review
> 
> 
> Kernel Patchset
> ---------------
> Git tree:
> 
>     https://github.com/lostjeffle/linux.git jingbo/dev-erofs-fscache-v8
> 
> Gitweb:
> 
>     https://github.com/lostjeffle/linux/commits/jingbo/dev-erofs-fscache-v8
> 
> 
> User Daemon for Quick Test
> --------------------------
> Git tree:
> 
>     https://github.com/lostjeffle/demand-read-cachefilesd.git main
> 
> Gitweb:
> 
>     https://github.com/lostjeffle/demand-read-cachefilesd
> 

Btw, we've also finished a preliminary end-to-end on-demand download
daemon in order to test the fscache on-demand kernel code as a real
end-to-end workload for container use cases:

User guide: https://github.com/dragonflyoss/image-service/blob/fscache/docs/nydus-fscache.md
Video: https://youtu.be/F4IF2_DENXo

Thanks,
Gao Xiang
