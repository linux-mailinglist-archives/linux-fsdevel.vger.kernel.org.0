Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EFC620928
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 06:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiKHFyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 00:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiKHFyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:54:53 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60056395;
        Mon,  7 Nov 2022 21:54:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VUHuOoP_1667886888;
Received: from 30.221.131.213(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VUHuOoP_1667886888)
          by smtp.aliyun-inc.com;
          Tue, 08 Nov 2022 13:54:49 +0800
Message-ID: <084d78a4-6052-f2ec-72f2-af9c4979f5dc@linux.alibaba.com>
Date:   Tue, 8 Nov 2022 13:54:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/2] netfs: Fix dodgy maths
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, willy@infradead.org
Cc:     Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <166757987929.950645.12595273010425381286.stgit@warthog.procyon.org.uk>
 <166757988611.950645.7626959069846893164.stgit@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <166757988611.950645.7626959069846893164.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/5/22 12:38 AM, David Howells wrote:
> Fix the dodgy maths in netfs_rreq_unlock_folios().  start_page could be
> inside the folio, in which case the calculation of pgpos will be come up
> with a negative number (though for the moment rreq->start is rounded down
> earlier and folios would have to get merged whilst locked)

Hi, the patch itself seems fine. Just some questions about the scenario.

1. "start_page could be inside the folio" Is that because
.expand_readahead() called from netfs_readahead()? Since otherwise,
req-start is always aligned to the folio boundary.

2. If start_page is indeed inside the folio, then only the trailing part
of the first folio can be covered by the request, and this folio will be
marked with uptodate, though the beginning part of the folio may have
not been read from the cache. Is that expected? Or correct me if I'm wrong.


-- 
Thanks,
Jingbo
