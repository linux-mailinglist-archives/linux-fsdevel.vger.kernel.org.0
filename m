Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BB9622D22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 15:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiKIOFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 09:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKIOFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:05:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE3B1658A
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Nov 2022 06:05:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC96461A35
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Nov 2022 14:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5197CC433C1;
        Wed,  9 Nov 2022 14:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668002704;
        bh=vBn2fEDaoudFrydSipyR3+m1csUoY+FwJ8d+5n10xrk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gt3MezR3O/dgVapaEtq3XhBVIYbTqbcQzGASlN8KHyDpfEcPuyiVoZ31qShh1q0PU
         rLtY7LARe67GqeO7wv7RtqxCS17GiFOIBL65mRw2t4Swzn49MgrcLv6m5e3HaSmEma
         5WyDZR1ZFbVnHea3eMFe5VzA4KDUFWoJt1V1tdOhyFT74+nR3GTphCVccEwMAGX6XY
         PqYb6R8J67afJL1gKAtFtXN/OkKgLQYtuADVDLPSBsKIQWImD44i4UuOhFpNZcAARR
         9KbzA+wiS1c78IlXgAzjf0A+CaZ7WesM6kIvZX7WgkApuNBqcV455x24VtbhgGa9EV
         lram04sAqy7aw==
Message-ID: <85ec05a7-b8bc-3f1a-ee61-01f505a0c0ad@kernel.org>
Date:   Wed, 9 Nov 2022 22:04:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] erofs: fix use-after-free of fsid and domain_id string
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org, zhujia.zj@bytedance.com
Cc:     huyue2@coolpad.com, linux-fsdevel@vger.kernel.org
References: <20221021023153.1330-1-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221021023153.1330-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/10/21 10:31, Jingbo Xu wrote:
> When erofs instance is remounted with fsid or domain_id mount option
> specified, the original fsid and domain_id string pointer in sbi->opt
> is directly overridden with the fsid and domain_id string in the new
> fs_context, without freeing the original fsid and domain_id string.
> What's worse, when the new fsid and domain_id string is transferred to
> sbi, they are not reset to NULL in fs_context, and thus they are freed
> when remount finishes, while sbi is still referring to these strings.
> 
> Reconfiguration for fsid and domain_id seems unusual. Thus clarify this
> restriction explicitly and dump a warning when users are attempting to
> do this.
> 
> Besides, to fix the use-after-free issue, move fsid and domain_id from
> erofs_mount_opts to outside.
> 
> Fixes: c6be2bd0a5dd ("erofs: register fscache volume")
> Fixes: 8b7adf1dff3d ("erofs: introduce fscache-based domain")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
