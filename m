Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B879F541
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 01:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjIMXA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 19:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMXA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:00:27 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2023C1BCB;
        Wed, 13 Sep 2023 16:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MOiOrHKlCFk57aDJS7uuzDy8eC1CT6fuIUA6QAZ4uEw=; b=I/GTS4I67tFhUzXMfyn1f1JtBO
        Tee+9rDXOwQYKql9ziUsZWqnUO5RI5y9FpuFOe/S923YlgIZjp+oOX+F0jGlnABexm/b2RA1kHfEE
        sgxHR26PR0y2VW5grshPakglIM2YqTgEpWxMGbs4AYZULopUruI7ZI4aps6+KNlgXIiwYfeQaYYbX
        Egk+wNb0sMZ58TBqLLNHEmCANytZbtd7cRIeeYf3eWi6pI2vOrAW95t1iIccczBaLFnODgg2S5JrI
        HN5XEK39q8stm8SGVYcyuBvMITVSNjU3xx+aSZZCOKGI3cMEwSzeKkqN0KCvyw1zD3XM+PWiH1cv0
        /fT0sLVg==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qgYqC-003Zf7-8O; Thu, 14 Sep 2023 01:00:12 +0200
Message-ID: <8b629a31-9ee0-80db-0ef9-ade00a31255a@igalia.com>
Date:   Wed, 13 Sep 2023 20:00:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V3 1/2] btrfs-progs: Add the single-dev feature (to both
 mkfs/tune)
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>
Cc:     clm@fb.com, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-2-gpiccoli@igalia.com>
 <9a679809-6e59-d0e2-3dd1-3287a7af5349@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <9a679809-6e59-d0e2-3dd1-3287a7af5349@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/09/2023 06:27, Anand Jain wrote:
> 
>   We may need to fix the command 'btrfs filesystem show' aswell.
>   Could you test having more than one single-devices with
>   the same fsid and running 'btrfs filesystem show' to ensure
>   it can still display all the devices?
> 
> Thx.
> Anand
> 

Hi Anand, thanks for noticing that. I've made this test (with the
patches V4), the result:


$ lsblk | grep nvme
nvme0n1     259:0    0    1G  0 disk
└─nvme0n1p1 259:1    0 1022M  0 part /mnt
nvme1n1     259:2    0    1G  0 disk
└─nvme1n1p1 259:3    0 1022M  0 part /mnt2


$ dmesg | grep TEMP
[  802.818873] BTRFS info: random fsid
(c80a52e3-8f16-4095-bdc2-cc24bd01cf7d) set for TEMP_FSID device
/dev/nvme0n1p1 (real fsid 94b67f81-b51f-479e-9f44-0d33d5cec2d4)
[  805.761222] BTRFS info: random fsid
(5a0a6628-8cd0-4353-8daf-b01ca254c10d) set for TEMP_FSID device
/dev/nvme1n1p1 (real fsid 94b67f81-b51f-479e-9f44-0d33d5cec2d4)


$ btrfs filesystem show
Label: none  uuid: c80a52e3-8f16-4095-bdc2-cc24bd01cf7d
        Total devices 1 FS bytes used 144.00KiB
        devid    1 size 1022.00MiB used 126.12MiB path /dev/nvme0n1p1

Label: none  uuid: 5a0a6628-8cd0-4353-8daf-b01ca254c10d
        Total devices 1 FS bytes used 144.00KiB
        devid    1 size 1022.00MiB used 126.12MiB path /dev/nvme1n1p1

Label: none  uuid: 94b67f81-b51f-479e-9f44-0d33d5cec2d4
        Total devices 1 FS bytes used 144.00KiB
        devid    1 size 1022.00MiB used 126.12MiB path /dev/nvme1n1p1


It seems to me it's correct "enough" right? It shows the mounted
filesystems according to the temporary fsid.

Also, I've noticed that the real fsid is omitted for device nvme0n1p1,
i.e., the command de-duplicates devices with the same fsid - tested here
without the TEMP_FSID feature and it behaves the same way.

In case you think we could improve such output, I appreciate
suggestions, and I'd be glad if that could be considered an improvement
(i.e., not blocking the patch merge on misc-next) since I might not have
the time to work on this for some weeks...

Cheers,


Guilherme
