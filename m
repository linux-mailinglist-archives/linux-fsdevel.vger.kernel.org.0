Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9759F8A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 13:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbiHXLdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 07:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbiHXLdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:33:36 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284927E83D;
        Wed, 24 Aug 2022 04:33:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VN7Iwjc_1661340812;
Received: from 30.227.73.144(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VN7Iwjc_1661340812)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 19:33:32 +0800
Message-ID: <c6fd70dd-2b0b-ea9f-f0f8-9d727cde2718@linux.alibaba.com>
Date:   Wed, 24 Aug 2022 19:33:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v3] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Sun Ke <sunke32@huawei.com>
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220818125038.2247720-1-sunke32@huawei.com>
 <3700079.1661336363@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <3700079.1661336363@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On 8/24/22 6:19 PM, David Howells wrote:
> 	/* fail OPEN request if copen format is invalid */
> 	ret = kstrtol(psize, 0, &size);
> 	if (ret) {
> 		req->error = ret;
> 		goto out;
> 	}
> 
> 	/* fail OPEN request if daemon reports an error */
> 	if (size < 0) {
> 		if (!IS_ERR_VALUE(size))
> 			ret = size = -EINVAL;
> 		req->error = size;
> 		goto out;
> 	}
> 
> Should ret get set to the error in size?


The user daemon completes the OPEN request by replying with the "copen"
command.  The format of "copen" is like: "copen <id>,<cache_size>",
where <cache_size> specifies the size of the backing file. Besides,
<cache_size> is also reused for specifying the error code when the user
daemon thinks it should fail the OPEN request. In this case, the OPEN
request will fail, while the copen command (i.e.
cachefiles_ondemand_copen()) shall return 0, since the format of the
input "copen" command has no problem at all. After all, the error code
inside <cache_size> is specified by the user daemon itself, and the fact
that the OPEN request will fail totally lies in the expectation of the
user daemon.


On the other hand, cachefiles_ondemand_copen() needs to return error
code when the user daemon specifies the "copen" command in a wrong
format, e.g. specifying an invalid error code in <cache_size>. This is
exactly what this patch fixes.


-- 
Thanks,
Jingbo
