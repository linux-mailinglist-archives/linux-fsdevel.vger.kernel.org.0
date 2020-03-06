Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84EDC17B732
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 08:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgCFHLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 02:11:11 -0500
Received: from hr2.samba.org ([144.76.82.148]:56764 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgCFHLK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Date:Message-ID:From:Cc:To;
        bh=6QPYRrmXg5zVDYQiNmpupY1dvEtoH2L7qRd7PuW6OLM=; b=WYZAvwZTAW9AAGX41fR0coySUF
        YqRxJxPPuX56gHT2yKRFaasUrEd9xIxei2naoAzQAMBtOwIut1wzpal4pKmKKFpgw7a2JHKwgDjnx
        nNO9j9+A3K+fc1s1I3rINrZAL9gFS+F1T7oRF1He+X+X8v39oOSD0znozc6+fldaJRM/sDFyLosi3
        PgAoGfDsypT1ot2nbo2ZjXtHAvA8XJ9APH1B9buF8zGU1gzM2PGrFzHaPa1edUJgnlucd+hlRYazH
        SCL3o6+/y4AnuhjcrPYFisYfUYxfzmJm/adjcaXbFGI10H2xGqLQVuxIU2Ya7+vAyasYbBnwCP4Ee
        PW64eWBNrBAEgWyjmXQQfIe3hgD25atXIDl1KZLpVLECO25dt3ki8fzXQdWodvbaTLpWnU4ZQNf9z
        OWvCuP0CbFmHzX22AwUoeHCiaftbzFFLza3tWAcT6SAlL0nZSB3NQe4sFbNbK/9Mj3Z+JC+XWMvv4
        BnzIWoCcpnJJ8/DBqtVa2R26;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1jA78R-0003Pw-Sm; Fri, 06 Mar 2020 07:11:04 +0000
Subject: Re: [LSF/MM/BPF TOPIC] How to make disconnected operation work?
To:     Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>,
        lsf-pc@lists.linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <14196.1575902815@warthog.procyon.org.uk>
 <8d872ab39c590dbfc6f02230dddb8740630f1444.camel@redhat.com>
From:   Steven French <sfrench@samba.org>
Message-ID: <9d5d8081-9c41-aa9d-1ae4-0b09c3a940d4@samba.org>
Date:   Fri, 6 Mar 2020 01:11:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8d872ab39c590dbfc6f02230dddb8740630f1444.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As discussed in hallway discussions at Linux Storage Conference - this 
would make a good topic for LSF/MM

On 12/9/19 5:14 PM, Jeff Layton wrote:
> On Mon, 2019-12-09 at 14:46 +0000, David Howells wrote:
>> I've been rewriting fscache and cachefiles to massively simplify it and make
>> use of the kiocb interface to do direct-I/O to/from the netfs's pages which
>> didn't exist when I first did this.
>>
>> 	https://lore.kernel.org/lkml/24942.1573667720@warthog.procyon.org.uk/
>> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter
>>
>> I'm getting towards the point where it's working and able to do basic caching
>> once again.  So now I've been thinking about what it'd take to support
>> disconnected operation.  Here's a list of things that I think need to be
>> considered or dealt with:
>>
> I'm quite interested in this too. I see that you've already given a lot
> of thought to potential interfaces here. I think we'll end up having to
> add a fair number of new interfaces to make something like this work.
>
>>   (1) Making sure the working set is present in the cache.
>>
>>       - Userspace (find/cat/tar)
>>       - Splice netfs -> cache
>>       - Metadata storage (e.g. directories)
>>       - Permissions caching
>>
>>   (2) Making sure the working set doesn't get culled.
>>
>>       - Pinning API (cachectl() syscall?)
>>       - Allow culling to be disabled entirely on a cache
>>       - Per-fs/per-dir config
>>
>>   (3) Switching into/out of disconnected mode.
>>
>>       - Manual, automatic
>>       - On what granularity?
>>         - Entirety of fs (eg. all nfs)
>>         - By logical unit (server, volume, cell, share)
>>
>>   (4) Local changes in disconnected mode.
>>
>>       - Journal
>>       - File identifier allocation
> Yep, necessary if you want to allow disconnected creates. By coincidence
> I'm working an (experimental) patchset now to add async create support
> to kcephfs, and part of that involves delegating out ranges of inode
> numbers. I may have some experience to report with it by the time LSF
> rolls around.
>
>>       - statx flag to indicate provisional nature of info
>>       - New error codes
>> 	- EDISCONNECTED - Op not available in disconnected mode
>> 	- EDISCONDATA - Data not available in disconnected mode
>> 	- EDISCONPERM - Permission cannot be checked in disconnected mode
>> 	- EDISCONFULL - Disconnected mode cache full
>>       - SIGIO support?
>>
>>   (5) Reconnection.
>>
>>       - Proactive or JIT synchronisation
>>         - Authentication
>>       - Conflict detection and resolution
>> 	 - ECONFLICTED - Disconnected mode resolution failed
> ECONFLICTED sort of implies that reconnection will be manual. If it
> happens automagically in the background you'll have no way to report
> such errors.
>
> Also, you'll need some mechanism to know what inodes are conflicted.
> This is the real difficult part of this problem, IMO.
>
>
>>       - Journal replay
>>       - Directory 'diffing' to find remote deletions
>>       - Symlink and other non-regular file comparison
>>
>>   (6) Conflict resolution.
>>
>>       - Automatic where possible
>>         - Just create/remove new non-regular files if possible
>>         - How to handle permission differences?
>>       - How to let userspace access conflicts?
>>         - Move local copy to 'lost+found'-like directory
>>         	 - Might not have been completely downloaded
>>         - New open() flags?
>>         	 - O_SERVER_VARIANT, O_CLIENT_VARIANT, O_RESOLVED_VARIANT
>>         - fcntl() to switch variants?
>>
> Again, conflict resolution is the difficult part. Maybe the right
> solution is to look at snapshotting-style interfaces -- i.e., handle a
> disconnected mount sort of like you would a writable snapshot. Do any
> (local) fs' currently offer writable snapshots, btw?
>
>>   (7) GUI integration.
>>
>>       - Entering/exiting disconnected mode notification/switches.
>>       - Resolution required notification.
>>       - Cache getting full notification.
>>
>> Can anyone think of any more considerations?  What do you think of the
>> proposed error codes and open flags?  Is that the best way to do this?
>>
>> David
>>
