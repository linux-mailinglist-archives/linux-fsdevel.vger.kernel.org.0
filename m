Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB04A692C75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Feb 2023 02:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBKBNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 20:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBKBN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 20:13:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED475F7C;
        Fri, 10 Feb 2023 17:13:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D1C861EAF;
        Sat, 11 Feb 2023 01:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D79EC433D2;
        Sat, 11 Feb 2023 01:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676078007;
        bh=V7Qb9OAQuHot4T/u40xIQnotrUN3wi0TVhIm5E/8o0w=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=pheCj4N1xCyO9NIh1mcUfgZCkf1uH9u5UIDwu9ZqPSLSlkD2m2nFZEncQd6nOrDEY
         EH1ib6F2IhHQi2Tu0eXp/lxliMGlQxvs3/LZFfMtYziVA6i0yQMF0ctTsKpAlDHRjF
         zp0UTfyr9NERPrHtE7QPQsN3I2DJZaHXcqpolVdaK4j6tyeKdkNQnYLYf3Vm/dGGWo
         bgBxUfQoeRRCblr7B/lbxc88deQu9Tq/T+yWVvy2U/DGRhpEfdnSKIezQxVde40hnH
         3h0MWx5ygVhzzeIHmqTdRcLde/GgbygOtzQu6xiaaPb2NWs6+yJz/GwWRxpCSFPsv6
         tt+fbPzz3PJKA==
Message-ID: <f61aea20-8bbc-8775-3026-6eec459eda3d@kernel.org>
Date:   Sat, 11 Feb 2023 09:13:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/2] proc: fix to check name length in proc_lookup_de()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, adobriyan@gmail.com
References: <20230131155559.35800-1-chao@kernel.org>
 <93c1e281-82a5-d7d0-04b1-67ac2cf3d0fa@kernel.org>
 <20230202154154.64a087a47bbf2210584b1734@linux-foundation.org>
X-Mozilla-News-Host: news://lore.kernel.org
Content-Language: en-US
In-Reply-To: <20230202154154.64a087a47bbf2210584b1734@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/2/3 7:41, Andrew Morton wrote:
> [patch 1/2]: Alexey wasn't keen on the v1 patch.  What changed?

I replied to Alexey's comments on v1, but still didn't get any
feedback, so I just rebase the code to last -next. Sorry, too rush
to missed to add change log on v2.

> 
> [patch 2/2]: What is the benefit from this change?

Block size is mismatch in between results of stat() and statfs(),
this patch tries to fix this issue.

stat  /proc/
    File: /proc/
    Size: 0         	Blocks: 0          IO Block: 1024   directory
Device: 14h/20d	Inode: 1           Links: 310
Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2023-01-28 23:14:20.491937242 +0800
Modify: 2023-01-28 23:14:20.491937242 +0800
Change: 2023-01-28 23:14:20.491937242 +0800
   Birth: -

stat -f  /proc/
    File: "/proc/"
      ID: 0        Namelen: 255     Type: proc
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 0          Free: 0          Available: 0
Inodes: Total: 0          Free: 0

