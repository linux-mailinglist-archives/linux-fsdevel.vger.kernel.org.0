Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE7622373
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 06:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKIFfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 00:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIFfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 00:35:32 -0500
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B91DDE9;
        Tue,  8 Nov 2022 21:35:30 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VUMLLG8_1667972125;
Received: from 30.221.129.114(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VUMLLG8_1667972125)
          by smtp.aliyun-inc.com;
          Wed, 09 Nov 2022 13:35:26 +0800
Message-ID: <af8490c5-524c-69a8-d128-d0c70a3deb76@linux.alibaba.com>
Date:   Wed, 9 Nov 2022 13:35:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [Linux-cachefs] [PATCH v2 2/2] netfs: Fix dodgy maths
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
References: <166757987929.950645.12595273010425381286.stgit@warthog.procyon.org.uk>
 <166757988611.950645.7626959069846893164.stgit@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <166757988611.950645.7626959069846893164.stgit@warthog.procyon.org.uk>
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



On 11/5/22 12:38 AM, David Howells wrote:
> Fix the dodgy maths in netfs_rreq_unlock_folios().  start_page could be
> inside the folio, in which case the calculation of pgpos will be come up
> with a negative number (though for the moment rreq->start is rounded down
> earlier and folios would have to get merged whilst locked)
> 
> Alter how this works to just frame the tracking in terms of absolute file
> positions, rather than offsets from the start of the I/O request.  This
> simplifies the maths and makes it easier to follow.
> 
> Fix the issue by using folio_pos() and folio_size() to calculate the end
> position of the page.
> 
> Fixes: 3d3c95046742 ("netfs: Provide readahead and readpage netfs helpers")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/Y2SJw7w1IsIik3nb@casper.infradead.org/

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
