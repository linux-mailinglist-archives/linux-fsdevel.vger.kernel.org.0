Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7646210E10F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2019 09:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfLAIVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 03:21:50 -0500
Received: from mail.phunq.net ([66.183.183.73]:38372 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfLAIVu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 03:21:50 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1ibKUG-0007z8-4U; Sun, 01 Dec 2019 00:21:48 -0800
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
 <20191128022817.GE22921@mit.edu>
 <3b5f28e5-2b88-47bb-1b32-5c2fed989f0b@phunq.net>
 <20191130175046.GA6655@mit.edu>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <76ddbdba-55ba-3426-2e29-0fa17db9b6d8@phunq.net>
Date:   Sun, 1 Dec 2019 00:21:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191130175046.GA6655@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-11-30 9:50 a.m., Theodore Y. Ts'o wrote:
> On Wed, Nov 27, 2019 at 08:27:59PM -0800, Daniel Phillips wrote:
>> You are right that Shardmap also must update the shard fifo tail block,
>> however there is only one index shard up to 64K entries, so all the new
>> index entries go into the same tail block(s).
> 
> So how big is an index shard?  If it is 64k entries, and each entry is
> 16 bytes (8 bytes hash, 8 bytes block number), then a shard is a
> megabyte, right?  Are entries in an index shard stored in sorted or
> unsorted manner?  If they are stored in an unsorted manner, then when
> trying to do a lookup, you need to search all of the index shard ---
> which means for a directory that is being frequently accessed, the
> entire index shard has to be kept in memory, no?  (Or paged in as
> necessary, if you are using mmap in userspace).

Exactly correct, except that in cache a shard is a hash table, while
on media it is just an unordered collection that is entered into hash
buckets at shard load time.

This is actually the main defining characteristic of Shardmap, both
giving rise to the theoretical read multiply issue alluded to above
and on the positive side, acting as a kind of cache read ahead due to
the coarse demand read granularity. In other words, each time we hit
a not present shard, we read multiple blocks of the given shard into
cache all at once, instead of loading blocks piecemeal with lots of
inefficient little reads. This is especially beneficial for spinning
disk, which we Tux3 devs still worry about, and I would think, you
also. Paraphrasing the immortal bard, "it's not dead yet".

Shard size is tunable at directory creation time. A shard entry is
actually 8 bytes, not 16, because block number can initially be very
small, just 10 bits by default, leaving 53 bits for the hash and one
bit to indicate tombstone or not. As the directory size increases,
the block number field size increases to accommodate more record
blocks and the hash field size decreases, however number of shards
increases at the same rate (more or less linear, enforced by logic)
so that, together with the hash bits implied by the shard number,
the hash resolution stays constant. Isn't that nice?

The importance of hash resolution is that, at high scale any hash
collision within a bucket must be resolved by accessing the record
block and resolving it there. So high collision rate corresponds to
significant slowdown in operations, getting worse linearly as the
directory expands. This is N**2 behavior in the sense that the time
to perform N operations increases as N**2 (IOW our usual definition
of file system performance.) It turns out that 53 hash bits are
sufficient to hold the collision rate to a few tens in one billion
inserts, insignificant at that scale, even more so at typical scale.

The question of cache footprint is indeed central, as you imply. 8
bytes per entry cuts the cache footprint in half, so that is nice.
But would it be better if we could hold only the pieces of index
in cache that we actually need? This question is far more subtle
than it first seems. Here is a possibly surprising mathematical
fact: when number of accesses is similar to the number of cache
blocks the cache footprint of any randomly accessed index is the
entire cache. This entirely independent of the index algorithm in
use: you see exactly the same behavior with BTrees. The best and
possibly only remedy is to make the index as compact as possible,
hence the impact of 8 byte vs 16 byte entries.

This highlights another significant advantage that Shardmap has
over HTree: HTree embeds its entries directly in the index while
Shardmap separates them out into traditional record entry blocks.
The HTree strategy does save significant CPU by avoiding one
block level deference, however as mentioned earlier, this merely
allows HTree to tie Shardmap in block accesses at the lowest
index scale, because Shardmap does one of its accesses into a
cache object, this avoiding radix tree overhead. The cost of
HTree's strategy at high scale, or with a large number of
directories open, is large, a factor of 2 or more greater cache
pressure depending on average name size.

So Shardmap is significantly more cache friendly than HTree, however,
as you deduced, if cache thrashing does happen then Shardmap with
shard size in the 256K to 1 Mbyte range might have to read a hundred
times as many blocks to reload an evicted shard than HTree does to
load a single btree block. On the other hand, the thrashing knee 
occurs with 3-5 times less cache for Shardmap than HTree, so which
one wins here? I say Shardmap, because Shardmap does more with less
cache. If you are thrashing that badly then your machine must be
grossly misconfigured for its load.

Now suppose you wanted to fix this theoretical read multiplication,
then how? An emerging technique aimed at precisely the kind of dual
format caching scheme that Shardmap uses has been dubbed "anticache".
Instead of evicting and reloading the cache object, page the cache
to swap, or any available backing store (e.g., to the file system
volume itself). Then the cache object can be reloaded at your choice
of granularity, for example, 4K pages, loaded in via the hash table
walk algorithm. This will be one or more steps: 1) look up hash chain
head in table possibly loading a page; 2+) if entry not already found
then look up in next chain entry, possibly loading a page.

The thing is, I can't imagine any Linux configuration that could hit
this, short of an artificial construction. Take the case of a 1M file
directory. The shardmap media fifos for that will be 8MB, there will
be 16 of them (depending on tuning) and each cache shard will be
somewhere around 640K or 160 pages per shard for a total of 1280
cache pages, or 5 MB cache footprint. If this is going to put your
system into thrash then I submit that the real problem is not
Shardmap.

So this theoretical read multiplication issue is essentially just a
question of how fast can we thrash. If somebody does come up with a
valid use case where we need to thrash faster than now, we can always
implement anticache or something similar, and maybe make that a
generic facility while at it, because again, the real problem is not
Shardmap, it is somebody feeding in an inappropriate load for their
machine configuration.

>> Important example: how is atomic directory commit going to work for
>> Ext4?
> 
> The same way all metadata updates work in ext4.  Which is to say, you
> need to declare the maximum number of 4k metadata blocks that an
> operation might need to change when calling ext4_journal_start() to
> create a handle; and before modifying a 4k block, you need to call
> ext4_journal_get_write_access(), passing in the handle and the block's
> buffer_head.  After modifying the block, you must call
> ext4_handle_dirty_metadata() on the buffer_head.  And when you are
> doing with the changes in an atomic metadata operation, you call
> ext4_journal_stop() on the handle.
> 
> This hasn't changed since the days of ext3 and htree.

OK good. And I presume that directory updates are prevented until
the journal transaction is at least fully written to buffers. Maybe
delayed until the journal transaction is actually committed?

In Tux3 we don't block directory updates during backend commit, and I
just assumed that Ext4 and others also do that now, so thanks for the
correction. As far I can see, there will be no new issue with Shardmap,
as you say. My current plan is that user space mmap will become kmap in
kernel. I am starting on this part for Tux3 right now. My goal is to
refine the current Shardmap data access api to hide the fact that mmap
is used in user space but kmap in kernel. Again, I wish we actually had
mmap in kernel and maybe we should consider properly supporting it in
the future, perhaps by improving kmalloc.

One thing we do a bit differently frou our traditional fs is, in the
common, unfragmented case, mass inserts go into the same block until
the block is full. So we get a significant speedup by avoiding a page
cache lookup and kmap per insert. Borrowing a bit of mechanism from
the persistent memory version of Shardmap, we create the new entries
in a separate cache page. Then, on commit, copy this "front buffer" to
the page cache. I think that will translate pretty well to Ext4 also.

Regards,

Daniel
