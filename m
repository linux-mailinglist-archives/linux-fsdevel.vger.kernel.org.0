Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDEA10C338
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 05:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfK1E2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 23:28:01 -0500
Received: from mail.phunq.net ([66.183.183.73]:34312 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfK1E2B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 23:28:01 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1iaBPL-0000xi-IQ; Wed, 27 Nov 2019 20:27:59 -0800
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
 <20191128022817.GE22921@mit.edu>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <3b5f28e5-2b88-47bb-1b32-5c2fed989f0b@phunq.net>
Date:   Wed, 27 Nov 2019 20:27:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191128022817.GE22921@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-11-27 6:28 p.m., Theodore Y. Ts'o wrote:
> On Wed, Nov 27, 2019 at 02:27:27PM -0800, Daniel Phillips wrote:
>>> (2) It's implemented as userspace code (e.g., it uses open(2),
>>> mmap(2), et. al) and using C++, so it would need to be reimplemented
>>> from scratch for use in the kernel.
>>
>> Right. Some of these details, like open, are obviously trivial, others
>> less so. Reimplementing from scratch is an overstatement because the
>> actual intrusions of user space code are just a small portion of the code
>> and nearly all abstracted behind APIs that can be implemented as needed
>> for userspace or kernel in out of line helpers, so that the main source
>> is strictly unaware of the difference.
> 
> The use of C++ with templates is presumably one of the "less so"
> parts, and it was that which I had in mind when I said,
> "reimplementing from scratch".

Ah, I see what you mean. To be honest, C++ has now become so natural for
me that I don't even think about it. You and Linus really ought to get
some of that :-)

If you look closely, you will notice that my C++ is largely just "C
compiled by C++", and I cheerfully undertake to convert away the few
places where I have simplified my life and sped up development by using
actual idiomatic C++ constructs.

By way of anecdote, coding the current user space version of Shardmap
in C++ cut my development time to go from the pure C prototype to the
world record persistent memory demonstration by a factor of roughly 3.
I now find it far faster to develop in C++ and then translate mindlessly
back to C as necessary, than to slog through the entire development
process using nothing but classic C, a language that really ought to
have done the right thing and stayed back in the century for which it
was created.

But to each his own. Ask for a pure C version licensed under GPLv2
and you shall receive. Note that we already have one here:

   https://github.com/OGAWAHirofumi/tux3/blob/master/user/devel/shard.c

Perhaps this will be easier on your eyes. It is essentially the same
thing less the persistent memory support and plus a bug or two.

Ah, one more anecdote. Shardmap implements polymorphic record block
operations, so that low level record format can be uniquely tailored
to the kind of data being stored. Overlooking the fact that we can
simply remove that mechanism for the kernel port because Ext4 does
not need more than one kind of record format, I can cheerfully
report that the official C++ way of implementing polymorphism using
virtual functions turned out to suck donkey dung compared to the
classic C/kernel way, where function vectors are handled as first
class data objects.

I actually implemented it both ways, but the virtual function way
turned out to be unspeakably painful for various reasons, hard to
read, and hard to modify without having it regularly blow up into
zillions of itty bitty little insane pieces. One day, after sinking
a couple of weeks into getting it finally working the official C++
way, I just threw this all out and recoded in kernel style, which
took about 3 hours and the result was not only much easier to read
and write, it generated better machine code.

So there you have it, ammunition to use against C++ if you want it.
But oh wait, it's still C++ isn't it? Why yes it is. C++, just try
it, you'll like it, and nobody is too late to learn it.

But once again, let's be very clear about it: I'm going to remove
*all* the C++ from Shardmap in aid of integrating with Tux3 and
Ext4. So there is no need at all to stay awake at night worrying
about this question.

>> Also, most of this work is already being done for Tux3,
> 
> Great, when that work is done, we can take a look at the code and
> see....

Surely there is much to discuss even before the Tux3 kernel port is
completed. Discussing and planning being cheap compared to leaving
things to the last minute as usual, then rushing them.

>>> (5) The claim is made that readdir() accesses files sequentially; but
>>> there is also mention in Shardmap of compressing shards (e.g.,
>>> rewriting them) to squeeze out deleted and tombstone entries.  This
>>> pretty much guarantees that it will not be possible to satisfy POSIX
>>> requirements of telldir(2)/seekdir(3) (using a 32-bit or 64-bitt
>>> cookie), NFS (which also requires use of a 32-bit or 64-bit cookie
>>> while doing readdir scan), or readdir() semantics in the face of
>>> directory entries getting inserted or removed from the directory.
>>
>> No problem, the data blocks are completely separate from the index so
>> readdir just walks through them in linear order a la classic UFS/Ext2.
>> What could possibly be simpler, faster or more POSIX compliant?
> 
> OK, so what you're saying then is for every single directory entry
> addition or removal, there must be (at least) two blocks which must be
> modified, an (at least one) index block, and a data block, no?  That
> makes it worse than htree, where most of the time we only need to
> modify a single leaf node.  We only have to touch an index block when
> a leaf node gets full and it needs to be split.

The operative word above is "single". Usually when we modify a single
entry in a directory we do not care whether the file system touches one
block or two, because a typical minimum commit involves many more than
that.

It may be that you were really thinking about mass instances of single
updates, which Shardmap handles much more efficiently than HTree. Under
mass insert, Shardmap repeatedly updates the same record block whereas
HTree updates some random, usually different leaf block per insert.

You are right that Shardmap also must update the shard fifo tail block,
however there is only one index shard up to 64K entries, so all the new
index entries go into the same tail block(s). Shardmap wins this one by
a mile.

As far as deletes go, of course you know how bad HTree is at that. Sure,
HTree only needs to update a single block to remove an entry, but then
it does unspeakable things to the inode table that tend to cause serious
performance losses in not-so-rare corner cases. Shardmap definitely
fixes that.

For O_SYNC operation you have more of a point, however again I doubt
that one directory block versus two will move the needle, and if it did
to the point of somebody actually caring about it, we can easily finesse
away one or both of those updates using journal techniques. More likely,
nobody will ever notice or care about this single extra block per sync
commit.

> Anyway, let's wait and see how you and Hirofumi-san work out those
> details for Tux3

We need to discuss those details up front in order to avoid duplicating
work or heading off in costly design directions that you may reject
later. And who would dream of depriving the LKML viewing public of their
weekly kernel design discussion entertainment? Not me.

Important example: how is atomic directory commit going to work for
Ext4? What can we do in the immediate future to make that work easier
for Ext4 devs? And many other details. The atomic commit discussion
alone is essential, and is a long lead item as we have all
experienced.

Bottom line: let's keep talking, it's better, and there is much of
interest to discuss. Surely you would at least like to know what
happened to your suggestion back in New Orleans about how to track
free records in huge directories?

Regards,

Daniel
