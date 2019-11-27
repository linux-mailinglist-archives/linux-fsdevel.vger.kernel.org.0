Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D123810A89C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 03:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfK0CHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 21:07:30 -0500
Received: from mail.phunq.net ([66.183.183.73]:58330 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfK0CH3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 21:07:29 -0500
X-Greylist: delayed 1204 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Nov 2019 21:07:29 EST
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1iZmQN-0002Ed-42; Tue, 26 Nov 2019 17:47:23 -0800
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
From:   Daniel Phillips <daniel@phunq.net>
Subject: [RFC] Thing 1: Shardmap fox Ext4
Message-ID: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
Date:   Tue, 26 Nov 2019 17:47:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

Here is my somewhat tardy followup to my Three Things post from earlier
this fall. I give you Thing 1, Shardmap. What I hope to accomplish today
is to initiate a conversation with Ext4 developers, and other interested
observers, which will eventually result in merging the new Shardmap
directory index code into Ext4, thereby solving a number of longstanding
issues with the venerable and somewhat problematic HTree.

HTree is the most used directory index in the known universe. HTree does
some things fantastically well, particularly in the most common range of
directory sizes, but also exhibits some well known flaws and at least one
previously unknown flaw, explained below. Shardmap is a new index design,
just seven years old, an O(1) extensible hash table, meant to address all
of HTree's flaws while improving performance and scaling into the
previously inaccessible billion file per directory range. Subject to
verifying these claims, it would seem to be logical to move on to the
logistics of porting Shardmap to Ext4 as an optional index algorithm,
eventually deprecating HTree.

Shardmap equals or outperforms HTree at all scales, with the single
exception of one theoretical case with a likewise theoretical solution.
Shardmap is O(1) in all operations - insert, delete, lookup and readdir,
while HTree is O(log N) in the first three and suffers from a relatively
large constant readdir overhead. This is not the only reason Shardmap is
faster than HTree, far from it.

I will break performance discussion down into four ranges:
   1) unindexed single block, to about 300 entries
   2) indexed up to 30 thousand entries
   3) indexed up to 3 million entries
   4) indexed up to 1 billion entries.

In theory, Shardmap and HTree are exactly tied in the common single
block case, because creating the index is delayed in both cases until
there are at least two blocks to index. However, Shardmap broke away
from the traditional Ext2 entry block format in order to improve block
level operation efficiency and to prevent record fragmentation under
heavy aging, and is therefore significantly faster than HTree even in
the single block case.

Shardmap does not function at all in the fourth range, up to 1 billion
entries, because its Btree has at most 2 levels. This simple flaw could be
corrected without much difficulty but Shardmap would remain superior for
a number of reasons.

The most interesting case is the 300 to 30 thousand entry range, where
Htree and Shardmap should theoretically be nearly equal, each requiring
two accesses per lookup. However, HTree does two radix tree lookups while
Shardmap does one, and the other lookup is in a cached memory object.
Coupled with the faster record level operations, Shardmap is significantly
faster in this range. In the 30 thousand to 3 million range, Shardmap's
performance advantage further widens in accordance with O(1) / O(log N).

For inserts, Shardmap's streaming update strategy is far superior to
HTree's random index block write approach. HTree will tend to dirty every
index block under heavy insert load, so that every index block must be
written to media per commit, causing serious write multiplication
issues. In fact, all Btree schemes suffer from this issue, which on the
face of it appears to be enough reason to eliminate the Btree as a
realistic design alternative. Shardmap dramatically reduces such per
commit write multiplication by appending new index entries linearly to
the tail blocks of a small number of index shards. For delete,
Shardmap avoids write multiplication by appending tombstone entries to
index shards, thereby addressing a well known HTree delete performance
issue.

HTree has always suffered from a serious mismatch between name storage
order and inode storage order, greatly exacerbated by the large number
of directory entries and inodes stored per block (false sharing). In
particular, a typical HTree hash order directory traversal accesses the
inode table randomly, multiplying both the cache footprint and write
traffic. Historically, this was the cause of many performance complaints
about HTree, though to be sure, such complaints have fallen off with
the advent of solid state storage. Even so, this issue will continue rear
its ugly head when users push the boundaries of cache and directory size
(google telldir+horror). Shardmap avoids this issue entirely by storing
and traversing directory entries in simple, classic linear order.

This touches on the single most significant difference between Shardmap
and HTree: Shardmap strictly separates its index from record entry blocks,
while HTree embeds entries directly in the BTree index. The HTree
strategy performs impressively well at low to medium directory scales,
but at higher scales it causes significantly more cache pressure, due to
the fact that the cache footprint of any randomly accessed index is
necessarily the entire index. In contrast, Shardmap stores directory
entries permanently in creation order, so that directory traversal is
in simple linear order with effectively zero overhead. This avoids
perhaps HTree's most dubious design feature, its arcane and not completely
reliable hash order readdir traversal, which miraculously has avoided
serious meltdown over these past two decades due to a legendary hack by
Ted and subsequent careful adaptation to handle various corner cases.
Nowhere in Shardmap will you find any such arcane and marginally
supportable code, which should be a great relief to Ext4 maintainers.
Or to put it another way, if somebody out there wishes to export a
billion file directory using NFSv2, Shardmap will not be the reason
why that does not work whereas HTree most probably would be.

Besides separating out the index from entry records and accessing those
records linearly in most situations, Shardmap also benefits from a very
compact index design. Even if a directory has a billion entries, each
index entry is only eight bytes in size. This exercise in structure
compaction proved possible because the number of hash bits needed for the
hash code decreases as the number of index shards increases, freeing up
bits for larger block numbers as the directory expands. Shardmap
therefore implements an index entry as several variable sized fields.
This strategy works well up to the billion entry range, above which the
number of hash index collisions (each of which must be resolved by
accessing an underlying record block) starts to increase noticeably.
This is really the only factor that limits Shardmap performance above
a billion entries. Should we wish Shardmap to scale to trillions of
entries without losing performance, we will need to increase the index
entry size to ten bytes or so, or come up with some as yet unknown
clever improvement (potential thesis project goes here).

There are many additional technical details of Shardmap that ought to be
explained, however today my primary purpose is simply to introduce what
I view as a compelling case for obsoleting HTree. To that end, fewer
words are better and this post is already quite long enough. I would love
to get into some other interesting details, for example, the Bigmap free
space mapping strategy, but that really needs its own post to do it
justice, as do a number of other subjects.

Wrapping up, what about that theoretical case where HTree outperforms
Shardmap? This is theoretical because one needs to operate on a huge
directory with tiny cache to trigger it. Both Shardmap and HTree will
exhibit read multiplication under such conditions, due to frequent
cache evictions, however the Shardmap read multiplication will be many
times higher than HTree because of its coarser cache granularity. In the
unlikely event that we ever need to fix this, one viable solution is to
add paging support for Shardmap's in-memory cache structure, a standard
technique sometimes called "anticache".

That is it for today. There remains much to explain about Shardmap both
within and beyond the Ext4 context. For example, Shardmap has proved to
work very well as a standalone key value store, particularly with
persistent memory. In fact, we have benchmarked Shardmap at over three
million atomic, durable database operations per second on an Intel
Optane server, which might well be a new world record. The details of
how this was done are fascinating, however this post is far too small to
contain them today. Perhaps this should be thing 1(b) for next week.

Regards,

Daniel
