Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40859177C81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 17:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgCCQz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 11:55:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55223 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727064AbgCCQz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:55:26 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 023Gt5ss026775
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Mar 2020 11:55:06 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6CE5442045B; Tue,  3 Mar 2020 11:55:05 -0500 (EST)
Date:   Tue, 3 Mar 2020 11:55:05 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        dmonakhov@gmail.com, mbobrowski@mbobrowski.org, enwlinux@gmail.com,
        sblbir@amazon.com, khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] fs, ext4: Physical blocks placement hint for
 fallocate(0): fallocate2(). TP defrag.
Message-ID: <20200303165505.GA61444@mit.edu>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <20200302165637.GA6826@mit.edu>
 <2b2bb85f-8062-648a-1b6e-7d655bf43c96@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b2bb85f-8062-648a-1b6e-7d655bf43c96@virtuozzo.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:57:15PM +0300, Kirill Tkhai wrote:
> The practice shows it's not so. Your suggestion was the first thing we tried,
> but it works bad and just doubles/triples IO.
> 
> Let we have two files of 512Kb, and they are placed in separate 1Mb clusters:
> 
> [[512Kb file][512Kb free]][[512Kb file][512Kb free]]
> 
> We want to pack both of files in the same 1Mb cluster. Packed together on block device,
> they will be in the same server of underlining distributed storage file system.
> This gives a big performance improvement, and this is the price I aimed.
> 
> In case of I fallocate a large hunk for both of them, I have to move them
> both to this new hunk. So, instead of moving 512Kb of data, we will have to move
> 1Mb of data, i.e. double size, which is counterproductive.
> 
> Imaging another situation, when we have 
> [[1020Kb file]][4Kb free]][[4Kb file][1020Kb free]]
> 
> Here we may just move [4Kb file] into [4Kb free]. But your suggestion again forces
> us to move 1Mb instead of 4Kb, which makes IO 256 times worse! This is terrible!
> And this is the thing I try prevent with finding a suitable new interface.

OK, so you aren't trying to *defragment*.  You want to have files
placed "properly" ab initio.

It sounds like what you *think* is the best way to go is to simply
have files backed tightly together.  So effectively what you want as a
block allocation strategy is something which just finds the next free
space big enough for the requested fallocate space, and just plop it
down right there.

OK, so what happens once you've allocated all of the free space, and
the pattern of deletes leaves the file system with a lot of holes?

I could imagine trying to implement this as a mount option which uses
an alternate block allocation strategy, but it's not clear what your
end game is after all of the "easy" spaces have been taken.  It's much
like proposals I've seen for a log-structured file system, where the
garbage collector is left as a "we'll get to it later" TODO item.  (If
I had a dollar each time I've read a paper proposing a log structured
file system which leaves out the garbage collector as an
implementation detail....)

> It's powerful, but it does not allow to create an effective defragmentation
> tool for my usecase. See the examples above. I do not want to replace
> EXT4_IOC_MOVE_EXTENT I just want an interface to be able to allocate
> a space close to some existing file and reduce IO at defragmentation time.
> This is just only thing I need in this patchset.

"At defragmentation time"?   So you do want to run a defragger?

It might be helpful to see the full design of what you have in mind,
and not just a request for interfaces....

> I can't climb into maintainers heads and find a thing, which will be suitable
> for you. I did my try and suggested the interface. In case of it's not OK
> for you, could you, please, suggest another one, which will work for my usecase?
> The thesis "EXT4_IOC_MOVE_EXTENT is enough for everything" does not work for me :(
> Are you OK with interface suggested by Andreas?

Like you, I can't climb into your head and figure out exactly how your
entire system design is going to work.  And I'd really rather not
proposal or bless an interface until I do, since it may be that it's
better to make some minor changes to your system design, instead of
trying to twist ext4 for your particular use case....

       	  	     	      		     - Ted
