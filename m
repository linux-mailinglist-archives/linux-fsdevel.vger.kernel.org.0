Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465A17180F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 15:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbjEaNGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 09:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbjEaNGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 09:06:15 -0400
X-Greylist: delayed 717 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 06:05:53 PDT
Received: from out-25.mta1.migadu.com (out-25.mta1.migadu.com [IPv6:2001:41d0:203:375::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3610E69
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 06:05:53 -0700 (PDT)
Message-ID: <a6449457-2dc6-e6db-2fe9-2a12edf934b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685537575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ShbrEgfZy4By4UohTrcklSg54xQgs+3EWdpTAp00z8=;
        b=dw0p9yEqwoJ68IFZtmHffnZ4wp5USwQvnVqn94n4syCGENhdaRtT6IT3dXPhuhB7GeFZby
        EAm7yyWAoZ/WouPfjlyTwCg8ijHHlTofAXILbmW8dr+3eq6i1kiBqjx+Bf12QjXhBPbBb7
        iUpHJKOu/PagvVxpglm0N+Kntq3mIHM=
Date:   Wed, 31 May 2023 20:52:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/8] mm: vmscan: move shrinker_debugfs_remove() before
 synchronize_srcu()
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org,
        hughd@google.com, paulmck@kernel.org, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
 <20230531095742.2480623-2-qi.zheng@linux.dev>
 <20230531-notlage-ankommen-93022623b74b@brauner>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20230531-notlage-ankommen-93022623b74b@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/31 18:49, Christian Brauner wrote:
> On Wed, May 31, 2023 at 09:57:35AM +0000, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> The debugfs_remove_recursive() will wait for debugfs_file_put()
>> to return, so there is no need to put it after synchronize_srcu()
>> to wait for the rcu read-side critical section to exit.
>>
>> Just move it before synchronize_srcu(), which is also convenient
>> to put the heavy synchronize_srcu() in the delayed work later.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
> 
> Afaict, should be a patch independent of this series.

OK, will resend as an independent patch.

Thanks,
Qi
