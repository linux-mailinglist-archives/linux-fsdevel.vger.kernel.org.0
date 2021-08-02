Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589443DD2AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 11:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhHBJLa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 2 Aug 2021 05:11:30 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:31726 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhHBJL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:11:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id E07893F6CC;
        Mon,  2 Aug 2021 11:11:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Cy0qVDvQK-Ic; Mon,  2 Aug 2021 11:11:16 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1CDAC3F4E5;
        Mon,  2 Aug 2021 11:11:14 +0200 (CEST)
Received: from [192.168.0.126] (port=33408)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mATyc-0000KC-Rr; Mon, 02 Aug 2021 11:11:13 +0200
Date:   Mon, 2 Aug 2021 11:11:13 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Amir Goldstein <amir73il@gmail.com>, NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <697c3b9.eed85c8a.17b0621a43a@tnonline.net>
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number
 issues.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



---- From: Amir Goldstein <amir73il@gmail.com> -- Sent: 2021-08-02 - 09:54 ----

> On Mon, Aug 2, 2021 at 8:41 AM NeilBrown <neilb@suse.de> wrote:
>>
>> On Mon, 02 Aug 2021, Al Viro wrote:
>> > On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:
>> >
>> > > It think we need to bite-the-bullet and decide that 64bits is not
>> > > enough, and in fact no number of bits will ever be enough.  overlayfs
>> > > makes this clear.
>> >
>> > Sure - let's go for broke and use XML.  Oh, wait - it's 8 months too
>> > early...
>> >
>> > > So I think we need to strongly encourage user-space to start using
>> > > name_to_handle_at() whenever there is a need to test if two things are
>> > > the same.
>> >
>> > ... and forgetting the inconvenient facts, such as that two different
>> > fhandles may correspond to the same object.
>>
>> Can they?  They certainly can if the "connectable" flag is passed.
>> name_to_handle_at() cannot set that flag.
>> nfsd can, so using name_to_handle_at() on an NFS filesystem isn't quite
>> perfect.  However it is the best that can be done over NFS.
>>
>> Or is there some other situation where two different filehandles can be
>> reported for the same inode?
>>
>> Do you have a better suggestion?
>>
> 
> Neil,
> 
> I think the plan of "changing the world" is not very realistic.
> Sure, *some* tools can be changed, but all of them?
> 
> I went back to read your initial cover letter to understand the
> problem and what I mostly found there was that the view of
> /proc/x/mountinfo was hiding information that is important for
> some tools to understand what is going on with btrfs subvols.
> 
> Well I am not a UNIX history expert, but I suppose that
> /proc/PID/mountinfo was created because /proc/mounts and
> /proc/PID/mounts no longer provided tool with all the information
> about Linux mounts.
> 
> Maybe it's time for a new interface to query the more advanced
> sb/mount topology? fsinfo() maybe? With mount2 compatible API for
> traversing mounts that is not limited to reporting all entries inside
> a single page. I suppose we could go for some hierarchical view
> under /proc/PID/mounttree. I don't know - new API is hard.
> 
> In any case, instead of changing st_dev and st_ino or changing the
> world to work with file handles, why not add inode generation (and
> maybe subvol id) to statx().
> filesystem that care enough will provide this information and tools that
> care enough will use it.
> 
> Thanks,
> Amir.

I think it would be better and easier if nfs provided clients with virtual inodes and kept an internal mapping to actual filesystem inodes. Samba does this with the mount.cifs -o noserverino option, and as far as I know it works pretty well. 

This  could be made either as an export option (/mnt/foo *(noserverino) or like in the Samba case, a mount option. 

This way existing tools will continue to work and we don't have to reinvent various Linux subsystems. Because it's an option, users that don't use btrfs or other filesystems with snapshots, can simply skip it. 

Thanks, 
Forza 

