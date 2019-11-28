Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0810C654
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 11:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfK1KD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 05:03:59 -0500
Received: from mail.phunq.net ([66.183.183.73]:34700 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfK1KD7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:03:59 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1iaGeR-00021r-7l; Thu, 28 Nov 2019 02:03:55 -0800
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Darrick J. Wong" <djwong@kernel.org>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <8ece0424ceeeffbc4df5d52bfa270a9522f81cda.camel@dubeyko.com>
 <5c9b5bd3-028a-5211-30a6-a5a8706b373e@phunq.net>
 <B9F8658C-B88F-44A1-BBEF-98A8259E0712@dubeyko.com>
 <5e909ace-b5c9-9bf2-616f-018b52e065de@phunq.net>
 <A94F595C-462B-456C-ADBE-809C61886A2D@dilger.ca>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <0da770cb-07ce-2b81-8eae-64d32ad80c3f@phunq.net>
Date:   Thu, 28 Nov 2019 02:03:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <A94F595C-462B-456C-ADBE-809C61886A2D@dilger.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-11-28 1:15 a.m., Andreas Dilger wrote:
> On Nov 27, 2019, at 7:54 PM, Daniel Phillips <daniel@phunq.net> wrote:
>>
>> On 2019-11-27 11:35 a.m., Viacheslav Dubeyko wrote:
>>> So, it looks like that Shardmap could be better for the case of billion files in one folder.  But what’s about the regular case when it could be
>>> dozens/hundreds of files in one folder? Will Shardmap be better than HTree?
>>
>> Yes, Shardmap is also faster than HTree in that case. Both Shardmap and
>> HTree are unindexed in that range, however Shardmap is faster because of
>> two things:
>>
>> 1) Shardmap uses a more efficient record block format that incorporates
>> a single byte hash code that avoids 99% of failed string compares.
>>
>> 2) Shardmap "pins" the current target block in which new entries are
>> created, avoiding repeated radix tree lookups for insert under load.
>>
>> As soon as you get into thousands of files, the difference between
>> Shardmap and HTree widens dramatically so that Shardmap ends up faster
>> by a factor of 2, 3, 4, etc as directory size increases. Not just
>> faster than HTree, but faster than any tree based scheme, because of
>> the O(1) / O(log N) equation.
>>
>> Up in the millions and billions of files, HTree just drops out of the
>> running, but if it were actually improved to operate in that range then
> 
> Actually, 3-level htree was implemented for ext4 several years ago, but
> was held back because there was no e2fsck support for it.  That was
> finished and the 3-level htree support was landed to ext4 in 2017 in
> commit v4.12-rc2-15-ge08ac99.  In theory it could allow ~5B entries in
> a single directory (the 2GB size limit was also removed at the same time).
> 
> The code change for this was relatively straight forward,

Let's clarify: straightforward for you. The fact that HTree sat for 15
years with my lame, coded-in-a-day two level scheme suggests that this
would not be straightforward for everyone. In my defence, I plead that
at the time I regarded 10 millions files as essentially infinite. This
makes me think of "640K ought to be enough for anyone" naturally.

Some day somebody will have a use case for billion file directories.
Until that day comes, I am ok with regarding this capability as a mere
stunt, or proof of scalability. Scaling 2 orders of magnitude higher is
just one of the improvements Shardmap offers, and in some sense, the
least important of them.

> but as you
> wrote elsewhere the big problem is each htree insert/lookup/remove
> operation degrades to random 4KB IOPS for every change (for the
> directory leaf blocks on insert/remove, and for the itable blocks on
> readdir), so has about 4096 / 64 = 64x write inflation or more.

Right. Shardmap linearizes pretty much everything, which seems to be
pretty much a necessity to achieve optimal performance with lowest
cache pressure, particularly with machines that are only marginally
capable of the load they are attempting.

> A log-structured directory insert/remove feature is appealing to me
> if it can avoid this overhead in practise.

The main problem with pure log structured updates is reading back the
log, which is randomly interleaved if written out in strict creation
order. This is the issue that LSM (as used by RocksDB and friends)
attempts to address:

   https://en.wikipedia.org/wiki/Log-structured_merge-tree

Unfortunately, these solutions tend to be complex and top heavy on the
read side. In practice Shardmap won solidly in all of insert, lookup
and delete benchmarks when we benchmarked it. I am not sure why that
is, but it seems to be trying to do a lot of fancy stuff.

Shardmap uses a far simpler update technique: each new index entry is
simply appended to the end of the appropriate shard. The fewer the
shards, the more efficient that is. However, even when there are 1K
or up to 8K shards as we use for our 1 billion file benchmark, this
algorithm still works well in practice. The key trick is, include
enough updates in the commit so that each shard receives enough to
reduce the tail block write multiplication to a dull roar.

On my not very spectacular Ryzen 7 workstation backed by SSD, we
create 1 billion directory entries in a bit less than 12 minutes. Is
this fast enough? On spinning rust it takes two or three minutes
longer. Clearly Ext4 plus the block layer are doing a nice job of
minimizing seeks for this load.

>> lookups would be at least 4 times slower due to index block probes, and
>> heavy insert loads would be orders of magnitude slower due to write
>> multiplication on commit. Of course I hear you when you say that you
>> don't have any million file directories to worry about, but some folks
>> do. (Any comment, Andreas?)
> 
> We regularly have directories in the 1M+ size, because of users can easily
> run many thousands of processes concurrently creating files in the same
> directory.  The 2-level htree topped out around 10-12M entries, which was
> hit occasionally.  At the same time, we also put in directory size limits
> so that admins could *prevent* users from doing this, because it also can
> cause problems for the user/admin when they need to process such large
> directories ("ls -l" will of course never finish).

OK, this confirms my impression of the sort of loads you feed to HTree.
In this range, I promise that you will see a solid speedup from Shardmap
for the directory ops alone, plus far better cache coherency with respect
to the inode table, and of course, a readdir that does not verge on
brilliant insanity.

Thanks for the comments Andreas, and I hope it is clear that I am also
offering Shardmap for Lustre. Not that you would even need to ask.

Regards,

Daniel
