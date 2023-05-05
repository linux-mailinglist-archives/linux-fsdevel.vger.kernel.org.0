Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92AE6F8632
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjEEPv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjEEPv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 11:51:56 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BAB19B3;
        Fri,  5 May 2023 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D3eQNN+vnOPT9R19W492S4vuaEu+35M7RtDV7XczIYg=; b=MeZjr3d0iFRlF+pPnv4sE+ANOQ
        OkAItowNJrYfdfCtTjna3CFNHCy9a4hMMbQlXSKj3aXaWDoCF1yVhEKpEmHJdMAcILnSslrqacZxZ
        jWqyB0xfwHenaJn5b+ypP3jJIm2yuHRBPSHOrt8HCHJreXX+RiuHYWVRq+xKrCUTIz9TiqmE4oQ+W
        Tl2NXBQ1VwUEV1gAASJ+hChoQx3tmLTqlGOSny/AwkTV+Ddre46TcmzQczx1TAcKu9Wpjxje0K/VM
        yHP31fvmYDkxcwLSWbMnLvmAY63uaQXV9Iy3Ieda4qXI/yAnbSqg8HvhdeYWoz8oQ99jurqK5wy4M
        ni+IeCyg==;
Received: from [177.189.3.64] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1puxil-001weL-Bp; Fri, 05 May 2023 17:51:48 +0200
Message-ID: <12aa446b-39c7-c9fb-c3a4-70bfb57d9bbc@igalia.com>
Date:   Fri, 5 May 2023 12:51:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
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

On 05/05/2023 04:21, Qu Wenruo wrote:
> [...]
> Exactly, the biggest problem is the multi-device support.
> 
> Btrfs needs to search and assemble all devices of a multi-device
> filesystem, which is normally handled by things like LVM/DMraid, thus
> other traditional fses won't need to bother that.

Hi Qu, thanks a bunch for your feedback, and for validating my
understanding of the issue!


>  [...]
> 
> I would prefer a much simpler but more explicit method.
> 
> Just introduce a new compat_ro feature, maybe call it SINGLE_DEV.
> 
> By this, we can avoid multiple meanings of the same super member, nor
> need any special mount option.
> Remember, mount option is never a good way to enable/disable a new feature.
> 
> The better method to enable/disable a feature should be mkfs and btrfstune.
> 
> Then go mostly the same of your patch, but maybe with something extra:
> 
> - Disbale multi-dev code
>    Include device add/replace/removal, this is already done in your
>    patch.
> 
> - Completely skip device scanning
>    I see no reason to keep btrfs with SINGLE_DEV feature to be added to
>    the device list at all.
>    It only needs to be scanned at mount time, and never be kept in the
>    in-memory device list.
> 

This seems very interesting, but I'm a bit confused on how that would
work with 2 identical filesystem images mounted at the same time.

Imagine you have 2 devices, /dev/sda1 and /dev/sda2 holding the exact
same image, with the SINGLE_DEV feature set. They are identical, and
IIUC no matter if we skip scanning or disable any multi-device approach,
in the end both have the *same* fsid. How do we track this in the btrfs
code now? Once we try to mount the second one, it'll try to add the same
entity to the fs_uuids list...

That's the problem I faced when investigating the code and why the
proposal is to "spoof" the fsid with some random generated one.

Also, one more question: why do you say "Remember, mount option is never
a good way to enable/disable a new feature"? I'm not expert in
filesystems (by far heh), so I'm curious to fully understand your
point-of-view.

From my naive viewpoint, seems a mount option is "cheaper" than
introducing a new feature in the OS that requires changes on btrfs
userspace applications as well as to track incompatibilities in
different kernel versions.

Thanks again,


Guilherme
