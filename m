Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E79150A7EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 20:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391070AbiDUSTf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 14:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377142AbiDUSTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:19:34 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBF53E0D5;
        Thu, 21 Apr 2022 11:16:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VAh.Br2_1650564996;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VAh.Br2_1650564996)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Apr 2022 02:16:38 +0800
Date:   Fri, 22 Apr 2022 02:16:36 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     David Howells <dhowells@redhat.com>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: Re: EMFILE/ENFILE mitigation needed in erofs?
Message-ID: <YmGfhFQshWOkAqNG@B-P7TQMD6M-0146.local>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        JeffleXu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
References: <2067a5c7-4e24-f449-4676-811d12e9ab72@linux.alibaba.com>
 <20220415123614.54024-3-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1447543.1650552898@warthog.procyon.org.uk>
 <1484181.1650563860@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1484181.1650563860@warthog.procyon.org.uk>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Thu, Apr 21, 2022 at 06:57:40PM +0100, David Howells wrote:
> JeffleXu <jefflexu@linux.alibaba.com> wrote:
> 
> > 2. Our user daemon will configure rlimit-nofile to a reasonably large
> > (e.g. 1 million) value, so that it won't fail when trying to allocate fds.
> 
> There's a system-wide limit also; simply increasing the rlimit won't override
> that.

Yes, I suggest that we should add some words to document this
to system administrators to take care of `/proc/sys/fs/file-max',
but I think it's typically not a problem about our on-demand cases.

Since each cookie equals to an erofs device, so not too many erofs
devices (much like docker layers) for one erofs images and they
are all handled when mounting (which needs privilege permissions.)

And due to this, fscache dir can be easily backed up, restored, and
transfered since they are really golden erofs image files.

Thanks,
Gao Xiang

> 
> David
