Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E16749121
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 00:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjGEWwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 18:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGEWwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 18:52:40 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264411980;
        Wed,  5 Jul 2023 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v/H0ia4XY9FX+KKV07hagWAF0RFAmtwx/D8EZihrFRE=; b=XbgHMsmx0aBmIwOpRMbDR/jW4w
        IILkBJ9ryaKWmEJ9aaLwaeUeGJbL9NkBQLPurMz7udWt2N11FqWNtI31ZDgNqq/2B/8svlz1rVnD2
        R4+X1UNO7WJZk7rTrU6D9Go/Ld7HCo9La9VXm5ZJMx9kxe9x3RqBTigF4IjA2H4Ntyj3DaKUcXUO6
        KVAJCUzlrtZrRoud1bQINwJ8I4cNg9QcM+6db2xbmPMkqs6aee3dRsKtwNgaZTOw/HxMKZJvU70sU
        ilKYGgwW3MuNRuhzJrgLmBQYTyK95kAKNtMMMNAxwKU55EH3wLwRy95xCOODjc7w3NviBUlyYFknn
        xa40713w==;
Received: from [191.205.188.225] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qHBMJ-008xul-3e; Thu, 06 Jul 2023 00:52:27 +0200
Message-ID: <bc897780-2c81-fe1f-a8d4-148a08962a20@igalia.com>
Date:   Wed, 5 Jul 2023 19:52:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/05/2023 04:21, Qu Wenruo wrote:
> [...]
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

Hi Qu, I'm implementing this compat_ro idea of yours, but I'd like to
ask your input in some "design decisions" I'm facing here.

(a) I've skipped the device_list_add() step of adding the recent created
fs_devices struct to fs_uuids list, but I kept the btrfs_device creation
step. With that, the mount of two filesystems with same fsid fails..at
sysfs directory creation!

Of course - because it tries to add the same folder name to
/sys/fs/btrfs/ !!! I have some options here:

(I) Should I keep using a random generated fsid for single_dev devices,
in order we can mount many of them while not messing too much with the
code? I'd continue "piggybacking" on metadata_uuid idea if (I) is the
proper choice.

(II) Or maybe track down all fsid usage in the code (like this sysfs
case) and deal with that? In the sysfs case, we could change that folder
name to some other format, like fsid.NUM for single_dev devices, whereas
NUM is an incremental value for devices mounted with same fsid.

I'm not too fond of this alternative due to its complexity and "API"
breakage - userspace already expects /sys/fs/btrfs/ entries to be the fsid.

(III) Should we hide the filesystem from sysfs (and other potential
conflicts that come from same fsid mounting points)? Seems a hideous
approach, due to API breakage and bug potentials.

Maybe there are other choices, better than mine - lemme know if you have
some ideas!

Also, one last question/confirmation: you mentioned that "The better
method to enable/disable a feature should be mkfs" - you mean the same
way mkfs could be used to set features like "raid56" or "no-holes"?

By checking "mkfs.btrfs -O list-all", I don't see metadata_uuid for
example, which is confined to btrfstune it seems. I'm already modifying
btrfs-progs/mkfs, but since I'm emailing you, why not confirm, right? heh

Thanks again for the advice and suggestions - much appreciated!
Cheers,


Guilherme
