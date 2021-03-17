Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6033EA8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 08:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhCQH3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 03:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhCQH3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:29:37 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED762C06174A;
        Wed, 17 Mar 2021 00:29:36 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b130so37935786qkc.10;
        Wed, 17 Mar 2021 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=tMAcgoJJTJhR6LVY3stgnaxqqNZ4jxByErqOoVujxrM=;
        b=N9W8KhP8VFNmiag4gQnUgEASPTwh9oSFQ/mJub4EIfxdnR7/c+EboZEyzZS9Dp+2Ql
         d+dGjYFlMDIqkrV7ZaZb2Ilm8DnWyNSfb83NqZ2qbjm/z8FIpLnJLRGykVqmJgZzN7Wr
         NwT5MFDQDwxNzI3+AP3QxsIMb2rKcsyl8WJv0pnIAllb59dyuSj72t4Izkq6PAxZLfXM
         qdU6Dc6NHHYwXAzOSj++08KJG10cr4J5pFUI2DcWECSI/oq4axwbSUlR3WBgWNqmFHAf
         BlCfyWfBwxpB5DLa6bPW9iX765yFIq9/cOjE+8FIf/ba1HGQDzXLzBraM2I9UL826E17
         mQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=tMAcgoJJTJhR6LVY3stgnaxqqNZ4jxByErqOoVujxrM=;
        b=ZV1wJP5OPNXcyt2ynRgenUmclBXmRdKiL6X+JInPd2DjGKvCX5wkv9QD7cdsCd4l/M
         pPeYlxgoic/CwaV28BLMXm5hGyra/HPrlm8vn4gV+33aRLrIXevBpjXJ6U78Jo2y7IGr
         me+1vP2xrOT0zXy48gGW7XRKEzADvBWnnYZsk41eYRNaP6DZ3KZGKp7eYDsf6mHSGFgW
         uGKB8VR0i4iYqWPNsIb5TaUTs6QJqVCu6LxcKnKTOkX+aqKpCYzfYaDnf1TG4mTyPGuI
         YxSinx8kJta23b+DroYBLghI9TngBVGz/K2q2JexQFJC8f6mEpqMFbNau8C0oYcjR0R8
         i2JQ==
X-Gm-Message-State: AOAM530pXtV30ReoyaNtrnYS8RpEF2DXgS5L/vA267JzMcvpc2NgIiLK
        GtPHZ1MsMuFIj5QeTUfA1Yl1jEFMyBlb
X-Google-Smtp-Source: ABdhPJzUq1JcA2D4rtBVNwni7zBZxvtZhALjJXdgK7kbZzVW4iAMnhI6YfzAJym5Fz5Mb64jny9b3Q==
X-Received: by 2002:a37:a390:: with SMTP id m138mr3215155qke.59.1615966175576;
        Wed, 17 Mar 2021 00:29:35 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 18sm17687146qkr.90.2021.03.17.00.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 00:29:35 -0700 (PDT)
Date:   Wed, 17 Mar 2021 03:29:30 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: bcachefs snapshots design doc - RFC
Message-ID: <YFGv2oSQXNbwMZ21@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Snapshots for bcaches are well under way, and I've written a design doc for
them. I'd love to get feedback on anything I might have missed, especially from
the btrfs people.

The current version of this document lives at
  https://bcachefs.org/Snapshots/

and the in-progress code lives at
  https://evilpiepirate.org/git/bcachefs.git/log/?h=snapshots

thanks for reading!

Snapshots & subvolumes:
=======================

The short version:

bcachefs snapshots are a different approach - we're not using COW btrees.
Instead, they're based on extending the key filesystem items (inodes, dirents,
xattrs, extents) with a version number - a snapshot id - for the low bits.

Snapshot IDs form a tree, which will be recorded in the snapshots btree. The
root snapshot ID is `U32_MAX`, and we allocate new snapshot IDs growing down so
that the parent of a given snapshot ID is always larger than that ID.

To create a new writeable snapshot, we allocate two new snapshot IDs. We update
the existing subvolume with one of the new snapshot IDs, and assign the other
snapshot ID to the new snapshot.

When we do a lookup for a filesystem item, we have to check if the snapshot ID
of the key we found is an ancestor of the snapshot ID we're searching for, and
filter out items that aren't.

Subvolumes:
===========

Subvolumes are needed for two reasons:

* They're the mechanism for accessing snapshots

* Also, they're a way of isolating different parts of the filesystem hierarchy
  from snapshots, or taking snapshots that aren't global. I.e. you'd create a
  subvolume for your database so that filesystem snapshots don't COW it, or
  create subvolumes for each home directory so that users can snapshot their
  own home directories.

The functionality and userspace interface for snapshots and subvolumes are
roughly modelled after btrfs, but simplified.

Subvolumes in bcachefs are just fancy directories. We introduce internally a new
dirent type that can point to subvolumes, instead of inodes, and the subvolume
has a pointer to the root inode. Subvolumes get their own table (btree), and
subvolume keys have fields for root inode number and snapshot ID.

Subvolumes have no name outside of the filesystem heirarchy. This means that, in
order to enumerate and list subvolumes, we need to be able to reconstruct their
path.

To reconstruct paths, we're adding inode backpointers - two new inode fields for
the inode number of the directory they're in, and the dirent offset. We're only
adding fields for a single backpointer, i.e. we're not handling hardlinks yet -
we set an inode flag indicating the backpointer fields are untrusted whenever we
create a hardlink. If we do ever want to add multiple backpointers for files
with hardlinks, we'll need to add another btree where each backpointer gets its
own key. This should be good enough for now.

Subvolume root inodes have two more fields: one for the subvolume ID, and
another for the parent subvolume ID. The subvolume ID field is only set for
subvolume roots because otherwise taking a snapshot would require updating every
inode in that subvolume. With these fields and inode backpointers, we'll be able
to reconstruct a path to any directory, or any file that hasn't been hardlinked.

Snapshots:
==========

We're also adding another table (btree) for snapshot keys. Snapshot keys form a
tree where each node is just a u32. The btree iterator code that filters by
snapshot ID assumes that a parent IDs are always larger than child IDs, so the
root starts at `U32_MAX`. And, there will be multiple trees - creating a new
empty subvolume will allocate a new snapshot ID that has no parent node.

Any filesystem operation that's within a subvolume starts by looking up the key
for that subvolume to get the current snapshot ID, to be used for both lookups
and updates. This means we have to remember what subvolume we're in, in the in
memory `bch_inode_info` - as mentioned previously only subvolume root inodes
have this field in the btree.

The btree iterator code is getting two new flags - `BTREE_ITER_ALL_SNAPSHOTS`
and `BTREE_ITER_FILTER_SNAPSHOTS`, that controls how iteration handles the
snapshot field of the key. One of these flags should be specified for iterators
for a btree that uses the snapshots field. `BTREE_ITER_ALL_SNAPSHOTS` means
don't handle the snapshot field specially: it returns every key, and
advancing/rewinding the iterator position increments/decrements the snapshot
field. `BTREE_ITER_FILTER_SNAPSHOTS` means incrementing/decrementing the
iterator position does not include the snapshot field - there's only one
iterator position for each inode number:offset - and we return the key that
matches the specified snapshot ID, or the first ancestor if not found.

The update path, `bch2_trans_commit()` now has more work to do:

* When deleting, we have to check if there's another key at the same position
  in an ancestor snapshot that would become visible - if so, we need to insert
  a whiteout instead.

* When there was a key at the current position in an ancestor snapshot ID
  that's being overwritten (i.e. it will no longer be visible in the current
  snapshot) - we should also check if it's visible in any other snapshots, and
  if not, delete it.

Extents turn out to not require much special handling: extent handling has
already been moved out of the core btree code, and there's now a pass at the top
of `bch2_trans_commit()` for extents that walks the list of updates and compares
them to what's being overwritten, and for extents being partially overwritten
generates more updates for the existing extents. This all does basically what we
want for snapshots and won't have to change much.

There are implications for splitting and merging of existing extents. If we have
to split an existing extent (i.e. when copygc is moving around existing data and
the write path had to fragment it) - for each child snapshot ID of the extent's
snapshot ID, if the extent is not visible in that snapshot emit a whiteout for
the fragment.

Conversely, existing extents may not be merged if one of them is visible in a
child snapshot and the other is not.

Snapshot deletion:
==================

In the current design, deleting a snapshot will require walking every btree that
has snapshots (extents, inodes, dirents and xattrs) to find and delete keys with
the given snapshot ID.

We could improve on this if we had a mechanism for "areas of interest" of the
btree - perhaps bloom filter based, and other parts of bcachefs might be able to
benefit as well - e.g. rebalance.

Other performance considerations:
=================================

Snapshots seem to exist in one of those design spaces where there's inherent
tradeoffs and it's almost impossible to design something that doesn't have
pathological performance issues in any use case scenario. E.g. btrfs snapshots
are known for being inefficient with sparse snapshots.

bcachefs snapshots should perform beautifully when taking frequent periodic (and
thus mostly fairly sparse) snapshots. The one thing we may have to watch out for
is part of the keyspace becoming too dense with keys from unrelated snapshots -
e.g. if we start with a 1 GB file, snapshot it 100 or 1000 times, and then have
fio fully overwrite the file with 4k random writes in every snapshot - that
would not be good, reading that file sequentially will require more or less
sequentially scanning through all the extents from every snapshot.

I expect this to be a fairly uncommon issue though, because when we allocate new
inode numbers we'll be picking an inode number that's unused in any snapshot -
most files in a filesystem are created, written to once, and then some time
later a new version is created and then renamed over the old file. The only way
to trigger this issue is by doing steady random writes to a large existing file
that's never recreated - which is mostly just databases and virtual machine
images. For virtual machine images people would be better off using reflink,
which we already support and won't have this issue at all.

But, if this does turn out to be a real issue for people (and if someone's
willing to fund this area), it should be perfectly solvable: we first need to
track number of keys for a given inode (extents/dirents/xattrs) in a given
snapshot, and in all snapshots. When that ratio crosses some threshhold, we'll
allocate a new inode and move all the keys for that inode number and snapshot ID
to the new inode, and mark the original inode to redirect to the new inode so
that the user visible inode number doesn't change. A bit tedious to implement,
but straightforward enough.

Locking overhead:
=================

Every btree transaction that operates within a subvolume (every filesystem level
operation) will need to start by looking up the subvolume in the btree key cache
and taking a read lock on it. Cacheline contention for those locks will
certainly be an issue, so we'll need to add an optional mode to SIX locks that
use percpu counters for taking read locks. Interior btree node locks will also
be able to benefit from this mode.

The btree key cache uses the rhashtable code for indexing items: those hash
table lookups are expected to show up in profiles and be worth optimizing. We
can probably switch to using a flat array to index btree key cache items for the
subvolume btree.

Permissions:
============

Creating a new empty subvolume can be done by untrusted users anywhere they
could call mkdir().

Creating a snapshot will also be an untrusted operation - the only additional
requirement being that untrusted users must own the root of the subvolume being
snapshotted.

Disk space accounting:
======================

We definitely want per snapshot/subvolume disk space accounting. The disk space
accounting code is going to need some major changes in order to make this
happen, though: currently, accounting information only lives in the journal
(it's included in each journal entry), and we'll need to change it to live in
keys in the btree first. This is going to take a major rewrite as the disk space
accounting code uses an intricate system of percpu counters that are flushed
just prior to journal writes, but we should be able to extend the btree key
cache code to accommodate this.

Recursive snapshots:
====================

Taking recursive snapshots atomically should be fairly easy, with the caveat
that right now there's a limit on the number of btree iterators that can be used
simultaneously (64) which will limit the number of subvolumes we can snapshot at
once. Lifting this limit would be useful for other reasons though, so will
probably happen eventually.

Fsck:
=====

The fsck code is going to have to be reworked to use `BTREE_ITER_ALL_SNAPSHOTS`
and check keys in all snapshots all at once, in order to have acceptable
performance. This has not been started on yet, and is expected to be the
trickiest and most complicated part.
