Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B273DA03B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 11:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhG2J3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 05:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbhG2J3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:29:08 -0400
X-Greylist: delayed 71107 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jul 2021 02:29:05 PDT
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7269CC061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 02:29:05 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 705449C3BC; Thu, 29 Jul 2021 10:29:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1627550943;
        bh=Iim5E1MebJGyexk5Ad4jyZr9JL9smuusi4CzEQP17Io=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=VmsFWVb8QxjLXwmxVrD0bAdzhJ++mKP4SScH2A4T7mz1W4q4LxAeKTqPQogpZCcli
         0Vu4GB34WqxwTOEWS9B2kql/oWGaJR/locKV3MuQ/syAVVKccP+yZA0SqhtHLh4O0v
         ykAKuJK/MWyneN1AbsEPUjYvFR6cn6qB/c6m6BaCAWmhMVT0LPptC6wNp6twN/IcU0
         OTxUROFQ5vTw1sGAK4o1/xt/5lMqHIMGfhpb6hPHdURJb7DyJPCvnPKXahAXjEF2r2
         KBzBn60yXfKf8ArvXO1C6Rbb6Ialy9WsE1eSy/8rQYdNhyrpeC+P8BOjPkUM/uZwS9
         A25jzf4KoQsFA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.1 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 68BDC9BC8E;
        Thu, 29 Jul 2021 10:28:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1627550936;
        bh=Iim5E1MebJGyexk5Ad4jyZr9JL9smuusi4CzEQP17Io=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=obpt+7/NgX/yoTjv+CSTPZXgsqanl2bIxZ3eppRGHUoUBft615lNQvL/jcPJ8OIBQ
         GZzWNzSCPQhZ1qW4HRMkUTfSDNyrsN3881cxb00PcShRNx8zx37Fd0/KqwAuIva9fS
         K7pzAclQAkFDOdFOqPq2GDKblx9zXEodliWbWy6ueJXgfXtICV81oHtfuC/ro/SENI
         m2RFLCxpAi9BwmzrpLtIjl0PLmkAqjgenfkGU259FEI2njyr2PbUGMX0HB3Cw3Pq4s
         DI/ie9WiSp+mC3lzI+v3jW76AQccDuKr+abrI8BpYVrTYb4RYrr3twwgI9UnX78qoj
         UbHb09Murd+lQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id E5D61275AD0;
        Thu, 29 Jul 2021 10:28:55 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728125819.6E52.409509F4@e16-tech.com>
 <20210728140431.D704.409509F4@e16-tech.com>
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>
 <2cb6455c-7b9f-9ac3-fd9d-9121eb1aa109@cobb.uk.net>
 <162752278855.21659.8220794370174720381@noble.neil.brown.name>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <3830b42b-2b76-6953-111f-d21ec3f0528e@cobb.uk.net>
Date:   Thu, 29 Jul 2021 10:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162752278855.21659.8220794370174720381@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/07/2021 02:39, NeilBrown wrote:
> On Wed, 28 Jul 2021, g.btrfs@cobb.uk.net wrote:
>> On 28/07/2021 08:01, NeilBrown wrote:
>>> On Wed, 28 Jul 2021, Wang Yugui wrote:
>>>> Hi,
>>>>
>>>> This patchset works well in 5.14-rc3.
>>>
>>> Thanks for testing.
>>>
>>>>
>>>> 1, fixed dummy inode(255, BTRFS_FIRST_FREE_OBJECTID - 1 )  is changed to
>>>> dynamic dummy inode(18446744073709551358, or 18446744073709551359, ...)
>>>
>>> The BTRFS_FIRST_FREE_OBJECTID-1 was a just a hack, I never wanted it to
>>> be permanent.
>>> The new number is ULONG_MAX - subvol_id (where subvol_id starts at 257 I
>>> think).
>>> This is a bit less of a hack.  It is an easily available number that is
>>> fairly unique.
>>>
>>>>
>>>> 2, btrfs subvol mount info is shown in /proc/mounts, even if nfsd/nfs is
>>>> not used.
>>>> /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test
>>>> /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub1
>>>> /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub2
>>>>
>>>> This is a visiual feature change for btrfs user.
>>>
>>> Hopefully it is an improvement.  But it is certainly a change that needs
>>> to be carefully considered.
>>
>> Would this change the behaviour of findmnt? I have several scripts that
>> depend on findmnt to select btrfs filesystems. Just to take a couple of
>> examples (using the example shown above): my scripts would depend on
>> 'findmnt --target /mnt/test/sub1 -o target' providing /mnt/test, not the
>> subvolume; and another script would depend on 'findmnt -t btrfs
>> --mountpoint /mnt/test/sub1' providing no output as the directory is not
>> an /etc/fstab mount point for a btrfs filesystem.
> 
> Yes, I think it does change the behaviour of findmnt.
> If the sub1 automount has not been triggered,
>   findmnt --target /mnt/test/sub1 -o target
> will report "/mnt/test".
> After it has been triggered, it will report "/mnt/test/sub1"
> 
> Similarly "findmnt -t btrfs --mountpoint /mnt/test/sub1" will report
> nothing if the automount hasn't been triggered, and will report full
> details of /mnt/test/sub1 if it has.
> 
>>
>> Maybe findmnt isn't affected? Or maybe the change is worth making
>> anyway? But it needs to be carefully considered if it breaks existing
>> user interfaces.
>>
> I hope the change is worth making anyway, but breaking findmnt would not
> be a popular move.

I agree. I use findmnt, but I also use NFS mounted btrfs disks so I am
keen to see this deployed. But people who don't maintain their own
scripts and need a third party to change them might disagree!

> This is unfortunate....  btrfs is "broken" and people/code have adjusted
> to that breakage so that "fixing" it will be traumatic.
> 
> The only way I can find to get findmnt to ignore the new entries in
> /proc/self/mountinfo is to trigger a parse error such as by replacing the 
> " - " with " -- "
> but that causes a parse error message to be generated, and will likely
> break other tools.
> (...  or I could check if current->comm is "findmnt", and suppress the
> extra entries, but that is even more horrible!!)
> 
> A possible option is to change findmnt to explicitly ignore the new
> "internal" mounts (unless some option is given) and then delay the
> kernel update until that can be rolled out.

That sounds good as a permanent fix for findmnt. Some sort of
'--include-subvols' option. Particularly if it were possible to default
it using an environment variable so a script can be written to work with
both the old and the new versions of findmnt.

Unfortunately it won't help any other program which does similar
searches through /proc/self/mountinfo.

How about creating two different files? Say, /proc/self/mountinfo and
/proc/self/mountinfo.internal (better filenames may be available!). The
.internal file could be just the additional internal mounts, or it could
be the complete list. Or something like
/proc/self/mountinfo.without-subvols and
/proc/self/mountinfo.with-subvols and a sysctl setting to choose which
is made visible as /proc/self/mountinfo.

Graham


