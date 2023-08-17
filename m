Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562A477F8CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346830AbjHQOYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351868AbjHQOYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:24:12 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CFB3599;
        Thu, 17 Aug 2023 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EYin4tERQw5jP/YQqBc9N0x0YosX1mC0Wrz87ZiKYcI=; b=sm9yM9Jc0a2uE2amadagi2dbh5
        YtwDrjQGRg0M5zgZGI/ZTFkeBlYWCcR+nKN+rItpsALn7aRyoA9RrJ3Jz01/LM8isfM5qSBmerwei
        UBbOOea+TEE44Vx66ihhJWZN4OyvlrjsiWqG3snqTVkB4yZf/0jOHbTH3YAc5a0eWYU0PYd9DCPrN
        AiQRYan6CGx8kZ2p3s+Rh1ljLTlL7upjjF4qEU4KBCzmERBA+MhWbv9KWaqqSUFK2BRFXDkejsS1A
        NesA69xWdQXRSEStrJmsf+dWap5Zy560rtYuzohy4/ZDJM3Nlh6WkKewuIvoTipRKZrZeUUaIzCKf
        HmrdCLmQ==;
Received: from 201-92-22-215.dsl.telesp.net.br ([201.92.22.215] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qWdub-001wfC-GQ; Thu, 17 Aug 2023 16:23:46 +0200
Message-ID: <6cbec669-b836-e3f3-8067-1df8b9a180ae@igalia.com>
Date:   Thu, 17 Aug 2023 11:23:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 0/3] Supporting same fsid mounting through a compat_ro
 feature
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230817141905.GA2933397@perftesting>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230817141905.GA2933397@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/08/2023 11:19, Josef Bacik wrote:
> [...]
> In general the concept is fine with me, and the implementation seems reasonable.
> 
> With new features we want fstests to accompany them so we know they work
> correctly, and we don't accidentally break them in the future.
> 
> I'd like to see tests that validate all the behaviors you're trying to
> accomplish work as advertised, and that all the failure cases do in fact fail
> properly.
> 
> Ideally a test that creates a single device fs image and mounts it in multiple
> places as would be used in the Steam Deck.
> 
> Then a test that tries to add a device to it, replace, etc.  All the cases that
> you expect to fail, and validate that they actually fail.
> 
> Then any other corner cases you can think of that I haven't thought of.
> 
> Make sure these new tests skip appropriately if the btrfs-progs support doesn't
> exist, I'd likely throw the fstests into our CI before the code is merged to
> make sure it's ready to be tested if/when it is merged.
> 
> Thanks,
> 
> Josef
> 

Hi Josef, thanks a lot for your comprehensive response, it was pretty
helpful for me.

I agree with you, test cases are important indeed and I'll work them,
re-submitting a V3 with tests included.
Cheers,


Guilherme
