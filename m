Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06176620761
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 04:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiKHD2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 22:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKHD2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:28:47 -0500
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8581913F3A;
        Mon,  7 Nov 2022 19:28:45 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VUHTXsX_1667878119;
Received: from 30.221.131.213(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VUHTXsX_1667878119)
          by smtp.aliyun-inc.com;
          Tue, 08 Nov 2022 11:28:41 +0800
Message-ID: <f0627b05-1f51-8683-75ad-17e5899efb2b@linux.alibaba.com>
Date:   Tue, 8 Nov 2022 11:28:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [Linux-cachefs] [PATCH v2 1/2] netfs: Fix missing xas_retry()
 calls in xarray iteration
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, willy@infradead.org
Cc:     George Law <glaw@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <166757987929.950645.12595273010425381286.stgit@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <166757987929.950645.12595273010425381286.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/5/22 12:37 AM, David Howells wrote:
> netfslib has a number of places in which it performs iteration of an xarray
> whilst being under the RCU read lock.  It *should* call xas_retry() as the
> first thing inside of the loop and do "continue" if it returns true in case
> the xarray walker passed out a special value indicating that the walk needs
> to be redone from the root[*].
> 
> Fix this by adding the missing retry checks.
> 
> [*] I wonder if this should be done inside xas_find(), xas_next_node() and
>     suchlike, but I'm told that's not an simple change to effect.
> 
> This can cause an oops like that below.  Note the faulting address - this
> is an internal value (|0x2) returned from xarray.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000402
> ...
> RIP: 0010:netfs_rreq_unlock+0xef/0x380 [netfs]
> ...
> Call Trace:
>  netfs_rreq_assess+0xa6/0x240 [netfs]
>  netfs_readpage+0x173/0x3b0 [netfs]
>  ? init_wait_var_entry+0x50/0x50
>  filemap_read_page+0x33/0xf0
>  filemap_get_pages+0x2f2/0x3f0
>  filemap_read+0xaa/0x320
>  ? do_filp_open+0xb2/0x150
>  ? rmqueue+0x3be/0xe10
>  ceph_read_iter+0x1fe/0x680 [ceph]
>  ? new_sync_read+0x115/0x1a0
>  new_sync_read+0x115/0x1a0
>  vfs_read+0xf3/0x180
>  ksys_read+0x5f/0xe0
>  do_syscall_64+0x38/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Fixes: 3d3c95046742 ("netfs: Provide readahead and readpage netfs helpers")
> Reported-by: George Law <glaw@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> ---

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
