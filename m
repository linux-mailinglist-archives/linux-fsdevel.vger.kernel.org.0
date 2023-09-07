Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77D079758E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 17:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjIGPwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 11:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjIGPkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:40:42 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D1E2D4F;
        Thu,  7 Sep 2023 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6HmUFeZF+Q6UUkcy/eG2UGDdY6MrCEZfBGvoDAaPTbI=; b=HfaCSpB3HkANGecSG7CONE79FP
        qTicW6NhNeO+v6kLh5SYgaIcLTz9xtRgYro9ArZGmRQa4XUGCJVsOay8pkcwHTpp2fGs84t+pNKJV
        nWh0wOvWYkLnbpP8aWi+rNL9tXjp6KCFQ9YTVUoqgXHF2rdO+u7wA98joDOJk2t4rLH2MTvL6P5m9
        xGvTdxqjiWA9nXkyaaLzII7G/7xMHY513xJkdXHA8pOyKfbfoXOKpx2mY1NtPCR9lv83zg5vu5jlH
        oFcfjsXzD7jOILVH04K0Ti6+BCAC8UkxFyHhHBRwDy3i3YXOvmPFDRhvgOdyw57kPJWs+SXKO33YD
        ADDKpxKA==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qeFVI-000WiK-Kw; Thu, 07 Sep 2023 15:57:04 +0200
Message-ID: <632393f6-b49a-ca37-c6db-1352dbe1b294@igalia.com>
Date:   Thu, 7 Sep 2023 10:56:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230905165041.GF14420@twin.jikos.cz>
 <5a9ca846-e72b-3ee1-f163-dd9765b3b62e@igalia.com>
 <fe879df8-c493-e959-0f45-6a3621c128e7@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <fe879df8-c493-e959-0f45-6a3621c128e7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/09/2023 06:49, Anand Jain wrote:
> [...]
>> Hi David, thanks for your feedback! I agree with you that this name is a
>> bit confusing, we can easily change that! How about virtual-fsid?
>> I confess I'm not the best (by far!) to name stuff, so I'll be glad to
>> follow a suggestion from anyone here heheh
>>
> 
> This feature might also be expanded to support multiple devices, so 
> removing 'single' makes sense.
> 
> virtual-fsid is good.
> or
> random-fsid
> 
> Thanks, Anand
> 

Thanks Anand!

David / Josef, what do you think? 'virtual-fsid' makes sense for you?
Thanks,


Guilherme
