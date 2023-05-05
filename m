Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720AD6F86B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjEEQ1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 12:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjEEQ1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 12:27:39 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573DF26B7;
        Fri,  5 May 2023 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x6LTHdhqKFFcOO2jWWNGqQsscmvzxS5CyvFoUXcATxw=; b=Z41Nbv2mQbTafKayl3hpv3Gmqf
        Ml55C5ExUNuMa1cgMcm9uPCXPOwdVslZmmc0rAzHIKz+I3PTd83LRWdFIPTdGPhzQumpwb8UIDpR+
        LGOGhgoRUNQHaYGozkBKHdjnfCH7ymYF2YlrWUGRCvFShTIr1HypG/88aqzxkI19NfZE2+xHui63K
        CJ5cBbUaCZFLcVZ+kxGJg2Toram2k+oKBi9XoaVMiHa/1PV/W7ka4nyXLbYhlArl85z4IwB46PAzx
        bxwfRi9kWDhf7Nj6+YMyxIQjyXAum6OZa4JKeQAjnKwL7tkYAeA0M3GIoSRRoWSgA5Cbr0lXhaWcr
        6g/m9wxw==;
Received: from [177.189.3.64] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1puyHH-001xlK-6t; Fri, 05 May 2023 18:27:27 +0200
Message-ID: <7320368b-fd62-1482-1043-2f9cb1e2a5b9@igalia.com>
Date:   Fri, 5 May 2023 13:27:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] Supporting same fsid filesystems mounting on btrfs
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, johns@valvesoftware.com,
        vivek@collabora.com, ludovico.denittis@collabora.com
Cc:     clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <b8f55fc3-80b3-be46-933a-4cfbd3c76a71@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <b8f55fc3-80b3-be46-933a-4cfbd3c76a71@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/05/2023 02:16, Anand Jain wrote:
> [...]
>>
>> https://lore.kernel.org/linux-btrfs/c702fe27-8da9-505b-6e27-713edacf723a@igalia.com/
> 
> Confused about your requirement: 2 identical filesystems mounted 
> simultaneously or just one at a time? Latter works. Bugs were fixed.

Hi Anand, apologies - in fact, in this old-ish thread I mentioned we
need to mount one at a time, and this corresponds for the majority of
the use case. BUT...it seems that for the installing step we require to
have *both* mounted at the same time for a while, so it was a change in
the requirement since last analysis, and this is really what we
implemented here.


> 
> Have you considered using the btrfs seed device feature to avoid 
> sacrificing 50% capacity? Create read-only seed device as golden image, 
> add writable device on top. Example:
> 
>    $ btrfstune -S1 /dev/rdonly-golden-img
>    $ mount /dev/rdonly-golden-img /btrfs
>    $ btrfs dev add /dev/rw-dev /btrfs
>    $ mount -o remount,rw /dev/rw-dev /btrfs
> 
> To switch golden image:
> 
>    $ btrfs dev del /dev/rdonly-golden-img /btrfs
>    $ umount /btrfs
>    $ btrfstune -S1 /dev/rw-dev
> 

Yeah, I'm aware that btrfs has some features that might fit and could
even save space, but due to some requirements on Deck it's not possible
to use them.

I'll defer a more detailed response for John / Vivek / Ludovico, that
are aware of the use case in a detail level I'm not, since they designed
the installation / update path from the ground up.

Cheers,


Guilherme
