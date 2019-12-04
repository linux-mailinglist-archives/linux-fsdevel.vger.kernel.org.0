Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D6C113734
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 22:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfLDVoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 16:44:32 -0500
Received: from mail.phunq.net ([66.183.183.73]:47326 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbfLDVoc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 16:44:32 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1iccRi-0007lz-Dk; Wed, 04 Dec 2019 13:44:30 -0800
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
 <20191128022817.GE22921@mit.edu>
 <3b5f28e5-2b88-47bb-1b32-5c2fed989f0b@phunq.net>
 <20191130175046.GA6655@mit.edu>
 <76ddbdba-55ba-3426-2e29-0fa17db9b6d8@phunq.net>
 <23F33101-065E-445A-AE5C-D05E35E2B78B@dilger.ca>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <f385445b-4941-cc48-e05d-51480a01f4aa@phunq.net>
Date:   Wed, 4 Dec 2019 13:44:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <23F33101-065E-445A-AE5C-D05E35E2B78B@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-12-04 10:31 a.m., Andreas Dilger wrote:
> One important use case that we have for Lustre that is not yet in the
> upstream ext4[*] is the ability to do parallel directory operations.
> This means we can create, lookup, and/or unlink entries in the same
> directory concurrently, to increase parallelism for large directories.

This is a requirement for an upcoming transactional version of user space
Shardmap. In the database world they call it "row locking". I am working
on a hash based scheme with single record granularity that maps onto the
existing shard buckets, which should be nice and efficient, maybe a bit
tricky with respect to rehash but looks not too bad.

Per-shard rw locks are a simpler alternative, but might get a bit fiddly
if you need to lock multiple entries in the same directory at the same
time, which is required for mv is it not?

> This is implemented by progressively locking the htree root and index
> blocks (typically read-only), then leaf blocks (read-only for lookup,
> read-write for insert/delete).  This provides improved parallelism
> as the directory grows in size.

This will be much easier and more efficient with Shardmap because there
are only three levels: top level shard array; shard hash bucket; record
block. Locking applies only to cache, so no need to worry about possible
upper tier during incremental "reshard".

I think Shardmap will also split more cleanly across metadata nodes than
HTree.

> Will there be some similar ability in Shardmap to have parallel ops?

This work is already in progress for user space Shardmap. If there is
also a kernel use case then we can just go forward assuming that this
work or some variation of it applies to both.

We need VFS changes to exploit parallel dirops in general, I think,
confirmed by your comment below. Seems like a good bit of work for
somebody. I bet the benchmarks will show well, suitable grist for a
master's thesis I would think.

Fine-grained directory locking may have a small enough footprint in
the Shardmap kernel port that there is no strong argument for getting
rid of it, just because VFS doesn't support it yet. Really, this has
the smell of a VFS flaw (interested in Al's comments...)

> Also, does Shardmap have the ability to shrink as entries are removed?

No shrink so far. What would you suggest? Keeping in mind that POSIX+NFS
semantics mean that we cannot in general defrag on the fly. I planned to
just hole_punch blocks that happen to become completely empty.

This aspect has so far not gotten attention because, historically, we
just never shrink a directory except via fsck/tools. What would you
like to see here? Maybe an ioctl to invoke directory defrag? A mode
bit to indicate we don't care about persistent telldir cookies?

How about automatic defrag that only runs when directory open count is
zero, plus a flag to disable?

> [*] we've tried to submit the pdirops patch a couple of times, but the
> main blocker is that the VFS has a single directory mutex and couldn't
> use the added functionality without significant VFS changes.

How significant would it be, really nasty or just somewhat nasty? I bet
the resulting efficiencies would show up in some general use cases.

> Patch at https://git.whamcloud.com/?p=fs/lustre-release.git;f=ldiskfs/kernel_patches/patches/rhel8/ext4-pdirop.patch;hb=HEAD

This URL gives me git://git.whamcloud.com/fs/lustre-release.git/summary,
am I missing something?

Regards,

Daniel
