Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445F350A54F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiDUQ1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 12:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiDUQR0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:17:26 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519462B241;
        Thu, 21 Apr 2022 09:14:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VAgYtNo_1650557669;
Received: from 30.15.235.48(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VAgYtNo_1650557669)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Apr 2022 00:14:31 +0800
Message-ID: <2067a5c7-4e24-f449-4676-811d12e9ab72@linux.alibaba.com>
Date:   Fri, 22 Apr 2022 00:14:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: EMFILE/ENFILE mitigation needed in erofs?
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
        tianzichen@kuaishou.com, fannaihao@baidu.com,
        zhangjiachen.jaycee@bytedance.com
References: <20220415123614.54024-3-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1447543.1650552898@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1447543.1650552898@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/21/22 10:54 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	fd_install(fd, file);
> 
> Do you need to mitigate potential EMFILE/ENFILE problems?  You're potentially
> trebling up the number of accounted systemwide fds: one for erofs itself, one
> anonfd per cache object file to communicate with the daemon and one in the
> daemon to talk to the server.  Cachefiles has a fourth internally, but it's
> kept off the books - further, cachefiles closes them fairly quickly after a
> period of nonuse.
> 

Hi, thanks for pointing it out.

1. Actually in our using scenarios, one erofs filesystem is formed of
several chunk-deduplicated blobs (which are really cached by
Cachefiles), while each blob can contain many files of erofs. For
example, one container image for node.js will correspond to ~20 blob
files in total. Only these blob files are cached by Cachefiles. In
densely employed environment, there could be hundreds of containers and
thus thousands of backing files on one machine. That is, only tens of
thousands of fds/files is needed in this case.

2. Our user daemon will configure rlimit-nofile to a reasonably large
(e.g. 1 million) value, so that it won't fail when trying to allocate fds.

https://github.com/dragonflyoss/image-service/blob/master/src/bin/nydusd/main.rs#L152

3. Our user daemon will close the anonymous fd once the corresponding
backing file has fully downloaded, to free the fd resources.

4. Even if fd/file allocation fails (in cachefiles_ondemand_get_fd()),
the INIT request will fail, and thus the erofs mount will fail then.
That is, it won't break the upper erofs in this case.

5. If later we find that the number of fds/files is indeed an issue,
then we also plan to make the user daemon close some fds to spare some
free resources. And then the Cachefiles kernel module needs to
reallocate an anonymous fd for the backing file when cache miss. But it
remains to be done later if it's really needed.


-- 
Thanks,
Jeffle
