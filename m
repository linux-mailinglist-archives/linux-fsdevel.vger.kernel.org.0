Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9952111AE97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 15:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfLKO6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 09:58:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37569 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbfLKO6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:58:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id m188so19888297qkc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 06:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=165huzjGadJNRUS46HL3721A3E8SYY2Tk8rls6r0RDM=;
        b=LC3OIe/1SyyqER9Q7ZR63Ex44I02gRk4PJ1Uf4x9r3O2T31Q9wc1TNVPYUDIy6urpU
         ih5yO8Iptec3hIge4us/XVsP2LQIYe17j72vIIpanEDBNHdixoCytH66b0O0Km50ZE7/
         kTcryTNcEzrzzG7TOMft4xvynb4kLFD5ab2zFAOKmOp3d0udiAfKl95I9S2B4dg8aeW2
         6XBPY1rc2MTqmTHS9Eqc1zZaiW14sJbOeKD/62/iRmbuyR3fjczZBI1p9bjpIy9YkPZc
         BgmlKoyKnxxwD0366qYDl73XN9G7GBxbt/81HsoS4GExRCLNAlakLO0c6DuMSxjns4/W
         Bd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=165huzjGadJNRUS46HL3721A3E8SYY2Tk8rls6r0RDM=;
        b=pyDIfHMOS3u3deB4887Iy4Bz3EM1F3wMQHno6hosZ8hoXhEYfiVeFlw2GIeORFuolI
         ojYRkIe4jBI3S3KDamAsxeKo1GtbybLarLHIHE3vHvfmexuUhIM1dnqU6SGeE2PfuUmF
         7A13DvlSAl/jRqpCpS79msaAmooPscOsnFM4/HHlMYRnQv8kxFoasOfStRgZgjgJU5NJ
         2hBOadjd45ILx5+/iCgjVLw0RX/Kt0w5jqO4CxzooxNcUaEq8RBRZP1PsR8gwxkSirUJ
         HQZc0F2o6ruY/wjpjumiZ+rFI2ELSEx8UlNMu9Fj9cVrN5X7SnJzGO+yCKf35IsjtQ7p
         4bNw==
X-Gm-Message-State: APjAAAXA+oKjD1IBZfupaho5bgxCEXDenHonOWkGwdR9XK3BgkpqA0Fk
        jxYndmVpffCi9FehM8Z71pamIQ==
X-Google-Smtp-Source: APXvYqzpn6yjU8igql0I0rGH3ZRIiRIjMVwySop20kQW00pJ7P7qgj7+6C4Pj4zDxefm29Eid97XIg==
X-Received: by 2002:a37:41d2:: with SMTP id o201mr3485776qka.100.1576076326678;
        Wed, 11 Dec 2019 06:58:46 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4149])
        by smtp.gmail.com with ESMTPSA id x19sm950291qtm.47.2019.12.11.06.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 06:58:45 -0800 (PST)
Subject: Re: 5.5.0-0.rc1 hang, could be zstd compression related
To:     Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <CAJCQCtS_7vjBnqeDsedBQJYuE_ap+Xo6D=MXY=rOxf66oJZkrA@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4eca86cf-65c3-5aba-d0fd-466d779614e6@toxicpanda.com>
Date:   Wed, 11 Dec 2019 09:58:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS_7vjBnqeDsedBQJYuE_ap+Xo6D=MXY=rOxf66oJZkrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/19 11:00 PM, Chris Murphy wrote:
> Could continue to chat in one application, the desktop environment was
> responsive, but no shells worked and I couldn't get to a tty and I
> couldn't ssh into remotely. Looks like the journal has everything up
> until I pressed and held down the power button.
> 
> 
> /dev/nvme0n1p7 on / type btrfs
> (rw,noatime,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=274,subvol=/root)
> 
> dmesg pretty
> https://pastebin.com/pvG3ERnd
> 
> dmesg (likely MUA stomped)
> [10224.184137] flap.local kernel: perf: interrupt took too long (2522
>> 2500), lowering kernel.perf_event_max_sample_rate to 79000
> [14712.698184] flap.local kernel: perf: interrupt took too long (3153
>> 3152), lowering kernel.perf_event_max_sample_rate to 63000
> [17903.211976] flap.local kernel: Lockdown: systemd-logind:
> hibernation is restricted; see man kernel_lockdown.7
> [22877.667177] flap.local kernel: BUG: kernel NULL pointer
> dereference, address: 00000000000006c8
> [22877.667182] flap.local kernel: #PF: supervisor read access in kernel mode
> [22877.667184] flap.local kernel: #PF: error_code(0x0000) - not-present page
> [22877.667187] flap.local kernel: PGD 0 P4D 0
> [22877.667191] flap.local kernel: Oops: 0000 [#1] SMP PTI
> [22877.667194] flap.local kernel: CPU: 2 PID: 14747 Comm: kworker/u8:7
> Not tainted 5.5.0-0.rc1.git0.1.fc32.x86_64+debug #1
> [22877.667196] flap.local kernel: Hardware name: HP HP Spectre
> Notebook/81A0, BIOS F.43 04/16/2019
> [22877.667226] flap.local kernel: Workqueue: btrfs-delalloc
> btrfs_work_helper [btrfs]
> [22877.667233] flap.local kernel: RIP:
> 0010:bio_associate_blkg_from_css+0x1c/0x3b0

This looks like the extent_map bdev cleanup thing that was supposed to be fixed, 
did you send the patch without the fix for it Dave?  Thanks,

Josef
