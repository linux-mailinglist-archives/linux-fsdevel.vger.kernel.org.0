Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C1B4E2AC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 15:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348952AbiCUOam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 10:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349242AbiCUO11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:27:27 -0400
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A5E11A23;
        Mon, 21 Mar 2022 07:20:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V7r08HY_1647872438;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7r08HY_1647872438)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Mar 2022 22:20:40 +0800
Date:   Mon, 21 Mar 2022 22:20:38 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, joseph.qi@linux.alibaba.com,
        torvalds@linux-foundation.org, chao@kernel.org,
        tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        bo.liu@linux.alibaba.com, gregkh@linuxfoundation.org,
        luodaowen.backend@bytedance.com, xiang@kernel.org,
        gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
        eguan@linux.alibaba.com
Subject: Re: [Linux-cachefs] [PATCH v5 03/22] cachefiles: introduce on-demand
 read mode
Message-ID: <YjiJtrOEBa7p/8M2@B-P7TQMD6M-0146.local>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, joseph.qi@linux.alibaba.com,
        torvalds@linux-foundation.org, chao@kernel.org,
        tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        bo.liu@linux.alibaba.com, gregkh@linuxfoundation.org,
        luodaowen.backend@bytedance.com, xiang@kernel.org,
        gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
        eguan@linux.alibaba.com
References: <YjiAVezd5B9auhcP@casper.infradead.org>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <1029982.1647872043@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1029982.1647872043@warthog.procyon.org.uk>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:14:03PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > Why do you have a separate rwlock when the xarray already has its own
> > spinlock?  This is usually a really bad idea.
> 
> Jeffle wants to hold a lock across the CACHEFILES_DEAD check and the xarray
> access.
> 
> However, he tells xarray to do a GFP_KERNEL alloc whilst holding the rwlock:-/

Yeah, sorry, there are trivial mistakes due to sleep in atomic
contexts (sorry that I didn't catch them earlier..)

Thanks,
Gao Xiang

> 
> David
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
