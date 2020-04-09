Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCCE51A3334
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 13:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDIL3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 07:29:00 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:33278 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgDIL3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:29:00 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 0E5E72E16E7;
        Thu,  9 Apr 2020 14:28:57 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 5lUyqieNuU-SuniUutc;
        Thu, 09 Apr 2020 14:28:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1586431737; bh=9qN0UrsZamcCgWaV/doKgSgygFN+sXYsJ573Xbur0/E=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=oOLu1u4+0u68oJOckWescsmBiACtvaT0QhDCeMI3G185iNZSD1x38DgzxM2Bxky70
         NajiDJpTV880omNpA4AplHz7sj9u+Xedsfo3T6XLybr2fe5gdW1IkVAwvCMPUHSp1P
         GQiKBwgKYMfw1eBCkAjkxiixJrqNC34MTZIwuvhk=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8808::1:4])
        by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id RC5avSOGS4-SuWaedcB;
        Thu, 09 Apr 2020 14:28:56 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] ovl: skip overlayfs superblocks at global sync
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Theodore Tso <tytso@mit.edu>
References: <158642098777.5635.10501704178160375549.stgit@buzz>
 <CAOQ4uxgTtbb-vDQNnY1_7EzQ=p5p2MqkfyZo2zkFQ1Wv29uqCA@mail.gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <67bdead3-a29f-a8af-5e7b-193a72cd4b86@yandex-team.ru>
Date:   Thu, 9 Apr 2020 14:28:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgTtbb-vDQNnY1_7EzQ=p5p2MqkfyZo2zkFQ1Wv29uqCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/04/2020 13.23, Amir Goldstein wrote:
> On Thu, Apr 9, 2020 at 11:30 AM Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
>>
>> Stacked filesystems like overlayfs has no own writeback, but they have to
>> forward syncfs() requests to backend for keeping data integrity.
>>
>> During global sync() each overlayfs instance calls method ->sync_fs()
>> for backend although it itself is in global list of superblocks too.
>> As a result one syscall sync() could write one superblock several times
>> and send multiple disk barriers.
>>
>> This patch adds flag SB_I_SKIP_SYNC into sb->sb_iflags to avoid that.
>>
>> Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
> 
> Seems reasonable.
> You may add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> +CC: containers list

Thanks

> 
> This bring up old memories.
> I posted this way back to fix handling of emergency_remount() in the
> presence of loop mounted fs:
> https://lore.kernel.org/linux-ext4/CAA2m6vfatWKS1CQFpaRbii2AXiZFvQUjVvYhGxWTSpz+2rxDyg@mail.gmail.com/
> 
> But seems to me that emergency_sync() and sync(2) are equally broken
> for this use case.
> 
> I wonder if anyone cares enough about resilience of loop mounted fs to try
> and change the iterate_* functions to iterate supers/bdevs in reverse order...

Now I see reason behind "sync; sync; sync; reboot" =)

Order old -> new allows to not miss new items if list modifies.
Might be important for some users.

bdev iteration seems already reversed: inode_sb_list_add adds to the head

> 
> Thanks,
> Amir.
> 
