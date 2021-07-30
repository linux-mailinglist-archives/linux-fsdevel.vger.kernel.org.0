Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277DC3DBCA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhG3PsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 11:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhG3PsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:48:24 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EDDC0613C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 08:48:19 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 129so9829701qkg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wsj/Pez/9epYa0hBXbqjfBiQqpTk+YWXSs2MW1qmBqw=;
        b=Hy91ASehghHCgZZDIsSoxj4lJjkdmriEMvJaXHxmI5YyvnCAOjVkD/QGeQVvZ4s9C0
         1Yqwcl92x4TH5WtPcb3GOZzF5qo7yfTBUk6tcXMCkfp6K0T5R6w3sY1I+VDN+2t4Owwp
         L3VeF/W13n0e1CKMjDNv8Mvy+eQwklJ3tPivXIbEHhoH60MLKmTyFaEfOvT0H7b2nm0R
         UqjAEU0ObrF7PoMmEcjQswMjEW5cIrgl/MKCibakwHsyHC2VvifJOtIV7mFJy2tigvAf
         rzgPCXA1G5AbhRPtV4UPCUZ4pERZInzHOhT1/H1330736WuUsDeyl+ynSjTKLf0ppduA
         KFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wsj/Pez/9epYa0hBXbqjfBiQqpTk+YWXSs2MW1qmBqw=;
        b=EsS85czV5gHqNrIoH2qc7QRWLgtBBLBe5QDdWhCc1LE85AHY5AeT0b661Le+nku9G7
         CHeOVzsRBL2D9VfD3QJRUE62hHaOY3vBgGYKzxK/xN0X79MgcT1+jjPnjuvsI8Eq8Azb
         5VyXwv/HPfqKWuQjEXxQby9rcEL9NPdLMtXEUvTL4STyjoIr6uKDbqAZHoTUuUN9LVHq
         qkDaICHwfxIPkPH1CKiOwBfceXosodc80Fofac8eEKXVHq9aiY+RJnH6mVVq4aATDCGT
         nm8Bzo40N3VR6wBj+HnSysqrqAWcKnVNbDcrl+p4qceEYVS1Pavs1SK9fSGzHQKlAAiB
         cpRA==
X-Gm-Message-State: AOAM533JLLpyia1kJrguDwBHB2SMXAYua6t7L3qJA2Ca1tD+HQnmTgdE
        NQo2dt/M6HYAG+EX1lHQpZjZlQ==
X-Google-Smtp-Source: ABdhPJyHq1Kfnhcm73bWh/gXpWFFmKV7iLEvKuIiUogqyUSigXBYsaj8t1xtE6arwcrn6R6cpZR9rw==
X-Received: by 2002:a37:8a44:: with SMTP id m65mr2971594qkd.72.1627660098177;
        Fri, 30 Jul 2021 08:48:18 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l4sm1102787qkd.77.2021.07.30.08.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 08:48:17 -0700 (PDT)
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     NeilBrown <neilb@suse.de>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Neal Gompa <ngompa13@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <162745567084.21659.16797059962461187633@noble.neil.brown.name>
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>
 <20210729023751.GL10170@hungrycats.org>
 <162752976632.21659.9573422052804077340@noble.neil.brown.name>
 <20210729232017.GE10106@hungrycats.org>
 <162761259105.21659.4838403432058511846@noble.neil.brown.name>
 <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com>
 <162762468711.21659.161298577376336564@noble.neil.brown.name>
 <bcde95bc-0bb8-a6e9-f197-590c8a0cba11@gmx.com>
 <20210730151748.GA21825@fieldses.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ae85654d-950f-04a2-8fca-145412b31e57@toxicpanda.com>
Date:   Fri, 30 Jul 2021 11:48:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210730151748.GA21825@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/30/21 11:17 AM, J. Bruce Fields wrote:
> On Fri, Jul 30, 2021 at 02:23:44PM +0800, Qu Wenruo wrote:
>> OK, forgot it's an opt-in feature, then it's less an impact.
>>
>> But it can still sometimes be problematic.
>>
>> E.g. if the user want to put some git code into one subvolume, while
>> export another subvolume through NFS.
>>
>> Then the user has to opt-in, affecting the git subvolume to lose the
>> ability to determine subvolume boundary, right?
> 
> Totally naive question: is it be possible to treat different subvolumes
> differently, and give the user some choice at subvolume creation time
> how this new boundary should behave?
> 
> It seems like there are some conflicting priorities that can only be
> resolved by someone who knows the intended use case.
> 

This is the crux of the problem.  We have no real interfaces or anything to deal 
with this sort of paradigm.  We do the st_dev thing because that's the most 
common way that tools like find or rsync use to determine they've wandered into 
a "different" volume.  This exists specifically because of usescases like 
Zygo's, where he's taking thousands of snapshots and manually excluding them 
from find/rsync is just not reasonable.

We have no good way to give the user information about what's going on, we just 
have these old shitty interfaces.  I asked our guys about filling up 
/proc/self/mountinfo with our subvolumes and they had a heart attack because we 
have around 2-4k subvolumes on machines, and with monitoring stuff in place we 
regularly read /proc/self/mountinfo to determine what's mounted and such.

And then there's NFS which needs to know that it's walked into a new inode space.

This is all super shitty, and mostly exists because we don't have a good way to 
expose to the user wtf is going on.

Personally I would be ok with simply disallowing NFS to wander into subvolumes 
from an exported fs.  If you want to export subvolumes then export them 
individually, otherwise if you walk into a subvolume from NFS you simply get an 
empty directory.

This doesn't solve the mountinfo problem where a user may want to figure out 
which subvol they're in, but this is where I think we could address the issue 
with better interfaces.  Or perhaps Neil's idea to have a common major number 
with a different minor number for every subvol.

Either way this isn't as simple as shoehorning it into automount and being done 
with it, we need to take a step back and think about how should this actually 
look, taking into account we've got 12 years of having Btrfs deployed with 
existing usecases that expect a certain behavior.  Thanks,

Josef
