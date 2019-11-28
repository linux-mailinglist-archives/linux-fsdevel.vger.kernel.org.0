Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0071E10C2A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 03:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfK1CzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 21:55:00 -0500
Received: from mail.phunq.net ([66.183.183.73]:34250 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfK1Cy7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 21:54:59 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1ia9xG-0000l7-Ll; Wed, 27 Nov 2019 18:54:54 -0800
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Dilger <adilger@dilger.ca>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <8ece0424ceeeffbc4df5d52bfa270a9522f81cda.camel@dubeyko.com>
 <5c9b5bd3-028a-5211-30a6-a5a8706b373e@phunq.net>
 <B9F8658C-B88F-44A1-BBEF-98A8259E0712@dubeyko.com>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <5e909ace-b5c9-9bf2-616f-018b52e065de@phunq.net>
Date:   Wed, 27 Nov 2019 18:54:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <B9F8658C-B88F-44A1-BBEF-98A8259E0712@dubeyko.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-11-27 11:35 a.m., Viacheslav Dubeyko wrote:
> So, it looks like that Shardmap could be better for the case of billion files in one folder.
> But what’s about the regular case when it could be dozens/hundreds of files in one
> folder? Will Shardmap be better than HTree?

Yes, Shardmap is also faster than HTree in that case. Both Shardmap and
HTree are unindexed in that range, however Shardmap is faster because of
two things:

 1) Shardmap uses a more efficient record block format that incorporates
 a single byte hash code that avoids 99% of failed string compares.

 2) Shardmap "pins" the current target block in which new entries are
 created, avoiding repeated radix tree lookups for insert under load.

As soon as you get into thousands of files, the difference between
Shardmap and HTree widens dramatically so that Shardmap ends up faster
by a factor of 2, 3, 4, etc as directory size increases. Not just
faster than HTree, but faster than any tree based scheme, because of
the O(1) / O(log N) equation.

Up in the millions and billions of files, HTree just drops out of the
running, but if it were actually improved to operate in that range then
lookups would be at least 4 times slower due to index block probes, and
heavy insert loads would be orders of magnitude slower due to write
multiplication on commit. Of course I hear you when you say that you
don't have any million file directories to worry about, but some folks
do. (Any comment, Andreas?)

> If the ordinary user hasn’t visible
> performance improvement then it makes sense to consider Shardmap like the
> optional feature. What do you think?

I am confident that a significant number of users will perceive the
performance improvement, and that few if any will perceive a slowdown for
any reason short of an outright bug.

> Does it mean that Shardmap is ext4 oriented only? Could it be used for another
> file systems?

Shardmap is not Ext4-only. In fact, Shardmap is firstly the directory
index for Tux3, and I am now proposing that Shardmap should also be
the new directory index for Ext4.

I also heard a suggestion that Shardmap could/should become a generic
kernel library facility that could be used by any file system or
kernel subsystem that requires a high performance persistent
associative string mapping.

Shardmap is also well on its way to being released as a generic high
performance KVS, including supporting persistent memory, a role it
performs in a highly satisfactory way. There will be a post about
this later, but for today, a spoiler: atomic, durable KVS database
transactions at a rate in excess of three per microsecond(!)

>> See the recommendation that is sometimes offered to work around
>> HTree's issues with processing files in hash order. Basically, read
>> the entire directory into memory, sort by inode number, then process
>> in that order. As an application writer do you really want to do this,
>> or would you prefer that the filesystem just take care of for you so
>> the normal, simple and readable code is also the most efficient code?
> 
> I slightly missed the point here. To read the whole directory sounds like to read
> the dentries tree from the volume. As far as I can see, the dentries are ordered
> by names or by hashes. But if we are talking about inode number then we mean
> the inodes tree. So, I have misunderstanding here. What do you mean?

It's a bit of a horror show. Ted is the expert on it, I was largely a
bystander at the time this was implemented. Basically, the issue is that
HTree is a hash-ordered BTree (the H in HTree) and the only way to
traverse it for readdir that can possibly satisfy POSIX requirements is
by hash order. If you try to traverse in linear block order then a
simultaneous insert could split a block and move some entries to other
blocks, which then may be returned by readdir twice or not at all. So
hash order traversal is necessary, but this is not easy because hashes
can collide. So what Ted did is, create a temporary structure that
persists for some period of time, to utilize a higher resolution hash
code which is used to resolve collisions and provide telldir cookies
for readdir. Basically. This is even more tricky than it sounds for
various horrifying reasons.

If you want the whole story you will have to ask Ted. Suffice to say that
it takes a special kind of mind to even conceive of such a mechanism, let
alone get it working so well that we have not seen a single complaint
about it for years. However, this code is by any standard, scary and only
marginally maintainable. It further seems likely that a sufficiently
determined person could construct a case where it fails, though I cannot
swear to that one way or the other.

Why did we go to all this effort as opposed to just introducing some
additional ordering metadata as XFS does? Because HTree is faster
without that additional metadata to maintain, and more compact. The
user perceives this; the user does not perceive the pain suffered by
implementors to get this working, nor does the user need to confront
the full horror of the source code. The user cares only about how it
works, and it does work pretty darn well. That said, deprecating this
code will still be immensely satisfying from where I sit. It is more
than likely that Ted shares the same view, though I certainly cannot
speak for him.

In summary, we should all just be happy that this readdir hack worked
well enough over the last 15 years or so to run the world's internet
and phones so reliably. Now let's retire it please, and move on to
something with a sounder design basis, and which is far easier to
understand and maintain, and runs faster to boot. Now, with Shardmap,
readdir runs at media transfer speed, with near zero cpu, unlike
HTree.

>>> If you are talking about improving the performance then do you mean
>>> some special open-source implementation?
>>
>> I mean the same kind of kernel filesystem implementation that HTree
>> currently has. Open source of course, GPLv2 to be specific.
> 
> I meant the Shardmap implementation. As far as I can see, the
> user-space implementation is available only now. So, my question is
> still here. It’s hard to say how efficient the Shardmap could be on> kernel side as ext4 subsystem, for example.

That is actually quite easy to predict. All of our benchmarking so far
has been with user space Shardmap running on top of Ext4, so we already
have a pretty accurate picture of the overheads involved. That said,
there will be two main differences between the user space code and the
kernel code:

   1) We don't have virtual memory in kernel in any practical form, so
   we need to simulate it with explicit lookups in a vector of page
   pointers, costing a tiny but likely measurable amount of cpu compared
   to the hardware implementation that user space enjoys.

   2) We don't know the overhead of atomic commit for Ext4 yet. We do
   have a pretty good picture for Tux3: near zero. And we have a very
   clear picture of the atomic commit overhead for persistent memory,
   which is nonzero but much less than annoying. So atomic commit
   overhead for Ext4 should be similar. This is really where the skill
   of Ext4 developers kicks in, and of course I expect great things
   in that regard, as has been the case consistently to date.

>>>> For delete, Shardmap avoids write multiplication by appending tombstone
>>>> entries to index shards, thereby addressing a well known HTree delete
>>>> performance issue.
>>>
>>> Do you mean Copy-On-Write policy here or some special technique?
>>
>> The technique Shardmap uses to reduce write amplication under heavy
>> load is somewhat similar to the technique used by Google's Bigtable to
>> achieve a similar result for data files. (However, the resemblance to
>> Bigtable ends there.)
>>
>> Each update to a Shardmap index is done twice: once in a highly
>> optimized hash table shard in cache, then again by appending an
>> entry to the tail of the shard's media "fifo". Media writes are
>> therefore mostly linear. I say mostly, because if there is a large
>> number of shards then a single commit may need to update the tail
>> block of each one, which still adds up to vastly fewer blocks than
>> the BTree case, where it is easy to construct cases where every
>> index block must be updated on every commit, a nasty example of
>> n**2 performance overhead.
> 
> It sounds like adding updates in log-structured manner. But what’s about
> the obsolete/invalid blocks? Does it mean that it need to use some GC technique
> here? I am not completely sure that it could be beneficial for the ext4.

This is vaguely similar to log structured updating, but then again, it
is more different than similar. A better term might be "streaming
updates". This is a popular theme of modern file system and database
design, and the basis of many recent performance breakthroughs.

Shardmap never garbage collects. Instead, when a shard fifo gets too
many tombstones, it is just compacted by writing out the entire cache
shard on top of the old, excessively fluffy shard fifo. This is both
efficient and rare, for various reasons that require detailed analysis
of the data structures involved. I will get to that eventually, but now
is probably not the best time. The source code makes it clear.

> By the way, could the old index blocks be used like the snapshots in the case
> of corruptions or other nasty issues?

My feeling is, that is not a natural fit. However, rescuing Shardmap from
index corruption is easy: just throw away the entire index and construct
a new one by walking the entry record blocks. Maybe there are cute ways
to make that incremental, but the simplest easiest way should actually be
enough for the long term.

>>> Let's imagine that it needs to implement the Shardmap approach. Could
>>> you estimate the implementation and stabilization time? How expensive
>>> and long-term efforts could it be?
>>
>> Shardmap is already implemented and stable, though it does need wider
>> usage and testing. Code is available here:
>>
>>    https://github.com/danielbot/Shardmap
>>
>> Shardmap needs to be ported to kernel, already planned and in progress
>> for Tux3. Now I am proposing that the Ext4 team should consider porting
>> Shardmap to Ext4, or at least enter into a serious discussion of the
>> logistics.
>>
>> Added Darrick to cc, as he is already fairly familiar with this subject,
>> once was an Ext4 developer, and perhaps still is should the need arise.
>> By the way, is there a reason that Ted's MIT address bounced on my
>> original post?
> 
> It’s hard to talk about stability because we haven’t kernel-side implementation
> of Shardmap for ext4. I suppose that it needs to spend about a year for the porting
> and twice more time for the stabilization.

Agreed, my best guess is roughly similar.

> To port a user-space code to the kernel could be the tricky task.

Sometimes true, however not in this case. Shardmap is broadly similar to
other code we have ported from user space to kernel in the past, with the
two exceptions I noted above. All just part of a kernel hacker's normal day
in my humble opinion.

> Could you estimate how many lines of code the core
> part of Shardmap contains?

The finished Ext4 code should be somewhere between 2k and 3k lines, about
the same as HTree.

> Does it need to change the ext4 on-disk layout for this feature?

No, this new form of index would be a mount option, and only used for
new directories. The HTree code will necessarily remain part of Ext4
forever, for compatibility with existing volumes. By "deprecate HTree"
I meant, eventually make the Shardmap index the default after it has
gone through its stabilization period of who knows how long? Three
years? Five? It's hard to know the future in that regard.

This would be roughly similar to the transition we did from unindexed
to HTree index some 18 years ago. (Deja vu all over again!) Last time it
went smoothly and this time we additionally have the benefit of having
done it before.

How easy ext4 functionality can be modified for Shardmap support?

From the user's point of view, completely trivial. Initially just a mount
option, and later, no action at all. From the sysadmin's point of view,
something new to learn about, some new procedures in case things go wrong,
but essentially all in a day's work. From the developer's point of view,
one of the easier major hacks that one could contemplate, I expect.
Technical risk is nearly nil because Shardmap is already already quite
mature, being seven years old as it is, and having had the benefit of
considerable earlier design experience.

Regards,

Daniel
