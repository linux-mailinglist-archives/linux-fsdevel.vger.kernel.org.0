Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7651787D0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 03:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjHYBTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 21:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243184AbjHYBSq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:18:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2226619B4;
        Thu, 24 Aug 2023 18:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB1CB60916;
        Fri, 25 Aug 2023 01:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9110FC433C8;
        Fri, 25 Aug 2023 01:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692926324;
        bh=DapHkQT8X84yWNvGu8oqRCoyMLM4nfpncPTa+wsDc9E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O8F3+JLyUJBelWixtfLPasTBEJs5UvdebGcBmQ58wEViQF0gncFfL3DBtYFsQVNxF
         WR/z99kIEVDjOSN6c7XC5hfg/hE2tAr9Pudud0O5yPUZ6ZuKZoeDS14J1MEAkKVgdv
         lgzAEuAcBkJGpmnluJaAtxY6A44LsH71MJVsl7ZUNzVtt5Ax9VwaUXQljF72oNeC34
         GbBm7A4Sc70cxf0wPX62cLK9IiJPMhc5Acjj6jLTGTlCTkyQCCQbPYF1R/TQ8Cv6CH
         xBlNEQwN9z421lKSDy+6LEEoAXMA37jjy1rNMOgXxTN3lNR1lmeNiG3StQN1YBOfbM
         G207gAVdnZxOw==
Message-ID: <96ffa54c-84e1-c953-23cd-ce68dd9350df@kernel.org>
Date:   Fri, 25 Aug 2023 09:18:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 06/45] erofs: dynamically allocate the erofs-shrinker
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Gao Xiang <xiang@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
 <20230824034304.37411-7-zhengqi.arch@bytedance.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230824034304.37411-7-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/8/24 11:42, Qi Zheng wrote:
> Use new APIs to dynamically allocate the erofs-shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> CC: Gao Xiang <xiang@kernel.org>
> CC: Chao Yu <chao@kernel.org>
> CC: Yue Hu <huyue2@coolpad.com>
> CC: Jeffle Xu <jefflexu@linux.alibaba.com>
> CC: linux-erofs@lists.ozlabs.org

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
