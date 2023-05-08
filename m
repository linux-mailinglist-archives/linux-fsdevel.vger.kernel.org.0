Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EF66FBB29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 00:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjEHWtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 18:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEHWts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 18:49:48 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60B07ED2;
        Mon,  8 May 2023 15:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rrzvNmc45EPtlwPtRTJz4hiS8irgdSiTJDkUJPTYZ1M=; b=WX30lwFq/QJQd5r72zdx9g2zTW
        Ikw/T59HGtYcnF+fFnruWdPGtP7S9ci/Cn7vSGPP8aMqsaerPbzqe8+dKeX6gQ9hPowmAkeZ7YIou
        /U78jSUclsDXYOTbL/XLDTqZ6ZspqR8w93cLeOmT/O7z78pvmI0o579BEgmZSpHwAdflCiHxEbcI5
        zwAEnxmtVjD4GAhvUVITr3kZ25j2cf8z6HEKf209rOn9u0TayMblLUK/CtaIZ3LtFg/9b7o07Mc1J
        CX2xssMh6HUJhPPDx1WMZ1Bs7bhbspw2QcDJmJqbda5EQfgIkla0GNchwRunru47YhZspjU9a5v4y
        8LQQFizw==;
Received: from [177.189.3.64] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pw9fr-004H9K-TP; Tue, 09 May 2023 00:49:44 +0200
Message-ID: <e492df43-a623-479f-9f1b-b4af6e506ca5@igalia.com>
Date:   Mon, 8 May 2023 19:49:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     clm@fb.com, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
 <12aa446b-39c7-c9fb-c3a4-70bfb57d9bbc@igalia.com>
 <4b9b1a6e-fce0-4371-980b-497400582e37@suse.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <4b9b1a6e-fce0-4371-980b-497400582e37@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/05/2023 19:15, Qu Wenruo wrote:
> [...] 
>> Imagine you have 2 devices, /dev/sda1 and /dev/sda2 holding the exact
>> same image, with the SINGLE_DEV feature set. They are identical, and
>> IIUC no matter if we skip scanning or disable any multi-device approach,
>> in the end both have the *same* fsid. How do we track this in the btrfs
>> code now? Once we try to mount the second one, it'll try to add the same
>> entity to the fs_uuids list...
> 
> My bad, I forgot to mention that, if we hit such SINGLE_DEV fses, we 
> should also not add them to the fs_uuids list either.
> 
> So the fs_uuids list conflicts would not be a problem at all.

Awesome, thanks for clarifying Qu! Now I understand it =)

> [...]
>> Also, one more question: why do you say "Remember, mount option is never
>> a good way to enable/disable a new feature"? I'm not expert in
>> filesystems (by far heh), so I'm curious to fully understand your
>> point-of-view.
> 
> We had a bad example in the past, free space tree (aka, v2 space cache).
> 
> It's initially a pretty convenient way to enable the new feature, but 
> now it's making a lot of new features, which can depend on v2 cache, 
> more complex to handle those old mount options.
> 
> The compatibility matrix would only grow, and all the (mostly one-time) 
> logic need to be implemented in kernel.
> 
> So in the long run, we prefer offline convert tool.

OK, I understand your point. I guess I could rewrite it to make use of
such compat_ro flag, it'd be fine. *Personally* (thinking as an user), I
much rather have mount options, I think it's consistent with other
filesystems and doesn't require specific btrfs tooling usage...

But of course I'll defer the decision to the maintainers!

Cheers,


Guilherme
