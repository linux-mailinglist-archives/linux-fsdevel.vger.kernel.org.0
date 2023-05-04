Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F36F77E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 23:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjEDVQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 17:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEDVQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 17:16:38 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6457D102;
        Thu,  4 May 2023 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H2w8memc8vlnNlnL4GWfqfaYcnoRE13mNRcGmM/vKBg=; b=evBjarf2yvUJRJWH4cCIeUVoT5
        fl5mvMGX+MXPYtoPV9KN0sX0QDM1qMAQegcFCzhJwcBDPVN1T92oTGem62s7KC0Jc56Kcmsr34n/E
        2EkLZMnOHPQD6ppIvv0kk8xt0lg7344ISyx1istDW5ObB9McEPJNe1ZkSpzHI2LzlsRoTwxC8vJDs
        ze+v/4gHQgEu+dYYIJwna5Ns2+5cZtHnCtKv3rusIMBSpsakxN7sj/aqfBm8Ldlw27ZsWxZDFLri+
        yG1v9oe4uSjJSO8UWIc73kPt/6vnIMDJOTdGCgv6Wo9CI9VzI1xjQF/4lmUNK1BgHO9pIoeHLlWQd
        mjKu7TPA==;
Received: from [177.189.3.64] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pufHj-001Nge-Ie; Thu, 04 May 2023 22:10:39 +0200
Message-ID: <1818142b-ec3a-323d-7a8d-0b93c33756fc@igalia.com>
Date:   Thu, 4 May 2023 17:10:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] Supporting same fsid filesystems mounting on btrfs
To:     kreijack@inwind.it
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <5056b834-077c-d1bb-4c46-3213bf6da74b@libero.it>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <5056b834-077c-d1bb-4c46-3213bf6da74b@libero.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/05/2023 16:28, Goffredo Baroncelli wrote:
> [...]
> Hi Guilherme,
> 
> did you tried to run "btrfs dev scan --forget /dev/sd.." before
> mount the filesystem ?
> 
> Assuming that you have two devices /dev/sdA and /dev/sdB with two btrfs
> filesystem with the same uuid, you should mount /dev/sdA
> 
> btrfs dev scan --forget /dev/sdB # you can use event /dev/sdA
> mount /dev/sdA /mnt/target
> 
> and to mount /dev/sdB
> 
> btrfs dev scan --forget /dev/sdA # you can use event /dev/sdB
> mount /dev/sdB /mnt/target
> 
> I made a quick test using two loop devices and it seems that it works
> reliably.

Hi Goffredo, thanks for your suggestion!

This seems interesting with regards the second patch here..indeed, I can
mount any of the 2 filesystems if I use the forget option - interesting
option, wasn't aware of that.

But unfortunately it seems limited to mounting one device at a time, and
we need to be able to mount *both* of them, due to an installation step.
If I try to forget the device that is mounted, it gets (obviously) a
"busy device" error.

Is there any missing step from my side, or mounting both devices is
really a limitation when using the forget option?


> 
> Another option should be make a kernel change that "forget" the device
> before mounting *if* the filesystem is composed by only one device (
> and another few exceptions like the filesystem is already mounted).
> 
> This would avoid all the problem related to make a "temporary" uuid.

I guess again this would be useful in the scope of the second patch
here...we could check the way you're proposing instead of having the
module parameter. In a way this is similar to the forget approach,
right? But it's kind of an "automatic" forget heh

How btrfs would know it is a case for single-device filesystem? In other
words: how would we distinguish between the cases we want to auto-forget
before mounting, and the cases in which this behavior is undesired?

Thanks again for your feedback, it is much appreciated.
Cheers,


Guilherme
