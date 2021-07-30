Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA353DBD3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 18:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhG3Qox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 12:44:53 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:57584 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhG3Qox (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:44:53 -0400
X-Greylist: delayed 1174 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2021 12:44:52 EDT
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 920883F6B4;
        Fri, 30 Jul 2021 18:25:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.99
X-Spam-Level: 
X-Spam-Status: No, score=-2.99 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-1.091, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iYCBCkGot8cO; Fri, 30 Jul 2021 18:25:10 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id D1D7E3F67A;
        Fri, 30 Jul 2021 18:25:07 +0200 (CEST)
Received: from [192.168.0.10] (port=63860)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1m9VJr-0003Dz-2C; Fri, 30 Jul 2021 18:25:07 +0200
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
To:     Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
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
 <ae85654d-950f-04a2-8fca-145412b31e57@toxicpanda.com>
From:   Forza <forza@tnonline.net>
Message-ID: <f87bb0f7-270c-f79f-bccf-a3ba116ac7f8@tnonline.net>
Date:   Fri, 30 Jul 2021 18:25:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ae85654d-950f-04a2-8fca-145412b31e57@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021-07-30 17:48, Josef Bacik wrote:
> On 7/30/21 11:17 AM, J. Bruce Fields wrote:
>> On Fri, Jul 30, 2021 at 02:23:44PM +0800, Qu Wenruo wrote:
>>> OK, forgot it's an opt-in feature, then it's less an impact.
>>>
>>> But it can still sometimes be problematic.
>>>
>>> E.g. if the user want to put some git code into one subvolume, while
>>> export another subvolume through NFS.
>>>
>>> Then the user has to opt-in, affecting the git subvolume to lose the
>>> ability to determine subvolume boundary, right?
>>
>> Totally naive question: is it be possible to treat different subvolumes
>> differently, and give the user some choice at subvolume creation time
>> how this new boundary should behave?
>>
>> It seems like there are some conflicting priorities that can only be
>> resolved by someone who knows the intended use case.
>>
> 
> This is the crux of the problem.  We have no real interfaces or anything 
> to deal with this sort of paradigm.  We do the st_dev thing because 
> that's the most common way that tools like find or rsync use to 
> determine they've wandered into a "different" volume.  This exists 
> specifically because of usescases like Zygo's, where he's taking 
> thousands of snapshots and manually excluding them from find/rsync is 
> just not reasonable.
> 
> We have no good way to give the user information about what's going on, 
> we just have these old shitty interfaces.  I asked our guys about 
> filling up /proc/self/mountinfo with our subvolumes and they had a heart 
> attack because we have around 2-4k subvolumes on machines, and with 
> monitoring stuff in place we regularly read /proc/self/mountinfo to 
> determine what's mounted and such.
> 
> And then there's NFS which needs to know that it's walked into a new 
> inode space.
> 
> This is all super shitty, and mostly exists because we don't have a good 
> way to expose to the user wtf is going on.
> 
> Personally I would be ok with simply disallowing NFS to wander into 
> subvolumes from an exported fs.  If you want to export subvolumes then 
> export them individually, otherwise if you walk into a subvolume from 
> NFS you simply get an empty directory.
> 
> This doesn't solve the mountinfo problem where a user may want to figure 
> out which subvol they're in, but this is where I think we could address 
> the issue with better interfaces.  Or perhaps Neil's idea to have a 
> common major number with a different minor number for every subvol.
> 
> Either way this isn't as simple as shoehorning it into automount and 
> being done with it, we need to take a step back and think about how 
> should this actually look, taking into account we've got 12 years of 
> having Btrfs deployed with existing usecases that expect a certain 
> behavior.  Thanks,
> 
> Josef


As a user and sysadmin I really appreciate the way Btrfs currently works.

We use hourly snapshots which are exposed over Samba as "Previous 
Versions" to Windows users. This amounts to thousands of snapshots, all 
user serviceable. A great feature!

In Samba world we have a mount option[1] called "noserverino" which lets 
the client generate unique inode numbers, rather than using the server 
provided inode numbers. This allows Linux clients to work well against 
servers exposing subvolumes and snapshots.

NFS has really old roots and had to make choices that we don't really 
have to make today. Can we not provide something similar to mount.cifs 
that generate unique inode numbers for the clients. This could be either 
an nfsd export option (such as /mnt/foo *(rw,uniq_inodes)) or a mount 
option on the clients.

One worry I have with making subvolumes automountpoints is that it might 
affect the possibility to cp --reflink across that boundary.



[1] https://www.samba.org/~ab/output/htmldocs/manpages-3/mount.cifs.8.html



