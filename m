Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0A31139DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 03:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfLEC1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 21:27:24 -0500
Received: from mail.phunq.net ([66.183.183.73]:47780 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbfLEC1Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:27:24 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1icgrR-0000dq-Qv; Wed, 04 Dec 2019 18:27:21 -0800
Subject: Re: [RFC] Thing 1: Shardmap for Ext4
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
 <20191128022817.GE22921@mit.edu>
 <3b5f28e5-2b88-47bb-1b32-5c2fed989f0b@phunq.net>
 <20191130175046.GA6655@mit.edu>
 <76ddbdba-55ba-3426-2e29-0fa17db9b6d8@phunq.net>
 <23F33101-065E-445A-AE5C-D05E35E2B78B@dilger.ca>
 <f385445b-4941-cc48-e05d-51480a01f4aa@phunq.net>
 <13F44A87-CAAE-4090-B26C-73EC2AF56765@dilger.ca>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <f6c4b7e1-a891-fd84-9e59-9f25267e01e2@phunq.net>
Date:   Wed, 4 Dec 2019 18:27:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <13F44A87-CAAE-4090-B26C-73EC2AF56765@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(finally noticed the gross error in the subject line)

On 2019-12-04 4:36 p.m., Andreas Dilger wrote:
> On Dec 4, 2019, at 2:44 PM, Daniel Phillips <daniel@phunq.net> wrote:
>>
>> On 2019-12-04 10:31 a.m., Andreas Dilger wrote:
>>> One important use case that we have for Lustre that is not yet in the
>>> upstream ext4[*] is the ability to do parallel directory operations.
>>> This means we can create, lookup, and/or unlink entries in the same
>>> directory concurrently, to increase parallelism for large directories.
>>
>> This is a requirement for an upcoming transactional version of user space
>> Shardmap. In the database world they call it "row locking". I am working
>> on a hash based scheme with single record granularity that maps onto the
>> existing shard buckets, which should be nice and efficient, maybe a bit
>> tricky with respect to rehash but looks not too bad.
>>
>> Per-shard rw locks are a simpler alternative, but might get a bit fiddly
>> if you need to lock multiple entries in the same directory at the same
>> time, which is required for mv is it not?
> 
> We currently have a "big filesystem lock" (BFL) for rename(), as rename
> is not an operation many people care about the performance.  We've
> discussed a number of times to optimize this for the common cases of
> rename a regular file within a single directory and rename a regular
> file between directories, but no plans at all to optimize rename of
> directories between parents.
> 
>>> This is implemented by progressively locking the htree root and index
>>> blocks (typically read-only), then leaf blocks (read-only for lookup,
>>> read-write for insert/delete).  This provides improved parallelism
>>> as the directory grows in size.
>>
>> This will be much easier and more efficient with Shardmap because there
>> are only three levels: top level shard array; shard hash bucket; record
>> block. Locking applies only to cache, so no need to worry about possible
>> upper tier during incremental "reshard".
>>
>> I think Shardmap will also split more cleanly across metadata nodes than
>> HTree.
> 
> We don't really split "htree" across metadata nodes, that is handled by
> Lustre at a higher level than the underlying filesystem.  Hash filename
> with per-directory hash type, modulo number of directory shards to find
> index within that directory, then map index to a directory shard on a
> particular server.  The backing filesystem directories are normal from
> the POV of the local filesystem.

OK, Lustre's higher level seems to somewhat resemble Shardmap, though
your extensibility scheme must be quite different. It does lend weight
to the proposition that hash sharding is the technique of choice at high
scale.

>>> Will there be some similar ability in Shardmap to have parallel ops?
>>
>> This work is already in progress for user space Shardmap. If there is
>> also a kernel use case then we can just go forward assuming that this
>> work or some variation of it applies to both.
>>
>> We need VFS changes to exploit parallel dirops in general, I think,
>> confirmed by your comment below. Seems like a good bit of work for
>> somebody. I bet the benchmarks will show well, suitable grist for a
>> master's thesis I would think.
>>
>> Fine-grained directory locking may have a small enough footprint in
>> the Shardmap kernel port that there is no strong argument for getting
>> rid of it, just because VFS doesn't support it yet. Really, this has
>> the smell of a VFS flaw (interested in Al's comments...)
> 
> I think that the VFS could get 95% of the benefit for 10% of the effort
> would be by allowing only rename of regular files within a directory
> with only a per-directory mutex.  The only workload that I know which
> does a lot of rename is rsync, or parallel versions of it, that create
> temporary files during data transfer, then rename the file over the
> target atomically after the data is sync'd to disk.

MTA is another rename-heavy workload, and I seem to recall, KDE config
update. I agree that parallel cross directory rename locking would be
basically nuts.

>>> Also, does Shardmap have the ability to shrink as entries are removed?
>>
>> No shrink so far. What would you suggest? Keeping in mind that POSIX+NFS
>> semantics mean that we cannot in general defrag on the fly. I planned to
>> just hole_punch blocks that happen to become completely empty.
>>
>> This aspect has so far not gotten attention because, historically, we
>> just never shrink a directory except via fsck/tools. What would you
>> like to see here? Maybe an ioctl to invoke directory defrag? A mode
>> bit to indicate we don't care about persistent telldir cookies?
> 
> There are a few patches floating around to shrink ext4 directories which
> I'd like to see landed at some point.  The current code is sub-optimal,
> in that it only tries to shrink "easy" blocks from the end of directory,
> but hopefully there can be more aggressive shrinking in later patches.

I intend to add some easy ones like that to Shardmap, in particular so
deleting every entry leaves the directory with a single block containing
just the header.

BTW, in Tux3 we plan to add a special Shardmap inode attribute to hold
the header information, so that an empty directory will have zero blocks
instead of one. I am still fussing about this detail, because it seems
a bit odd to not have at least the record block count present in the
dir file itself. Maybe the inode attr should just hold the tuning
parameters and the file header can hold the essential geometry details,
like record block count and logical index position.

>> How about automatic defrag that only runs when directory open count is
>> zero, plus a flag to disable?
> 
> As long as the shrinking doesn't break POSIX readdir ordering semantics.
> I'm obviously not savvy on the Shardmap details, but I'd think that the
> shards need to be garbage collected/packed periodically since they are
> log structured (write at end, tombstones for unlinks), so that would be
> an opportunity to shrink the shards?

Shardmap already does that. Every time a new tier is added, all shards
are incrementally compacted. Any shard that fills up because is compacted
instead of forcing a new index level.

Shards are not currently compacted if they have tombstones but still have
room for more entries. We could add some more logic there, so that shards
are automatically compacted according to heuristics based on the ratio of
tombstones to shard size. Mass delete creates a lot of tombstones however,
and we probably do not want to spend resources compacting under this load,
except when shards actually fill up. Such logic could be tricky to tune
for all loads.

We are always able to compact the index without affecting POSIX semantics,
so a lot of flexibility exists in what can be done there. However, if
there are sparse blocks near the top of the directory, we can't do much
about them without breaking POSIX.

We will hole_punch any completely empty record blocks, which should help
avoid wasting media space for very sparse directories. But we could still
end up with ten bytes in use per directory block, giving a fragmentation
ratio of 400 to one. For this, maybe we better provide the user with a
way to indicate that compaction should be done irrespective of POSIX
considerations, or at least slightly relaxing them.

>>> [*] we've tried to submit the pdirops patch a couple of times, but the
>>> main blocker is that the VFS has a single directory mutex and couldn't
>>> use the added functionality without significant VFS changes.
>>
>> How significant would it be, really nasty or just somewhat nasty? I bet
>> the resulting efficiencies would show up in some general use cases.
> 
> As stated above, I think the common case could be implemented relatively
> easily (rename within a directory), then maybe rename files across
> directories, and maybe never rename subdirectories across directories.

It seems parallel directory ops are now in play, according to Ted. Will
you refresh your patch?

>>> Patch at https://git.whamcloud.com/?p=fs/lustre-release.git;f=ldiskfs/kernel_patches/patches/rhel8/ext4-pdirop.patch;hb=HEAD
>>
>> This URL gives me git://git.whamcloud.com/fs/lustre-release.git/summary,
>> am I missing something?
> 
> Just walk down the tree for the "f=ldiskfs/..." pathname...

Got it. Not sure what the issue was before, this time the patch pops up
as expected.

BTW, Ted, Microsoft seems to have implemented a nefarious scheme to
bounce your direct emails so you have no choice but to read them from
the internet:

==========
A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  <you>@mit.edu
    host mit-edu.mail.protection.outlook.com [104.47.41.36]
    SMTP error from remote mail server after RCPT TO:<tytso@mit.edu>:
    550 5.7.606 Access denied, banned sending IP [66.183.183.73]. To request removal from this list please visit https://sender.office.com/ and follow the directions. For more information please go to  http://go.microsoft.com/fwlink/?LinkID=526655 (AS16012609)
==========

And of course requesting removal as suggested fails with some sort of "we
suck and had some kind of internal bug so please just keep trying so we
can waste more of your time" message. Malice or incompetence? We need to
know. And MIT+Outlook? I'm shocked. Shocked, I tell you.

Regards,

Daniel
