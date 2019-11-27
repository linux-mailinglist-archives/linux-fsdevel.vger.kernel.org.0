Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E91610C02D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 23:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfK0W1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 17:27:31 -0500
Received: from mail.phunq.net ([66.183.183.73]:33890 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfK0W1a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:27:30 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1ia5mS-00083g-5q; Wed, 27 Nov 2019 14:27:28 -0800
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
Date:   Wed, 27 Nov 2019 14:27:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127142508.GB5143@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

I trust you will find your initial points satisfactorily addressed below.

On 2019-11-27 6:25 a.m., Theodore Y. Ts'o wrote:
> A couple of quick observations about Shardmap.
> 
> (1) It's licensed[1] under the GPLv3, so it's not compatible with the
> kernel license.  That doesn't matter much for ext4, because...
> 
> [1] https://github.com/danielbot/Shardmap/blob/master/LICENSE

The kernel port of Shardmap will (necessarily) be licensed under GPLv2.

> (2) It's implemented as userspace code (e.g., it uses open(2),
> mmap(2), et. al) and using C++, so it would need to be reimplemented
> from scratch for use in the kernel.

Right. Some of these details, like open, are obviously trivial, others
less so. Reimplementing from scratch is an overstatement because the
actual intrusions of user space code are just a small portion of the code
and nearly all abstracted behind APIs that can be implemented as needed
for userspace or kernel in out of line helpers, so that the main source
is strictly unaware of the difference. That said, we can just fork off a
kernel version and not worry about keeping compatiblity with user space
if you wish, though putting in the extra effort to make it dual mode
would probably be helpful for e2fsck.

Also, most of this work is already being done for Tux3, so the only
Ext4-specific work needing doing may well be the differences in atomic
commit required to accommodate Ext4's ordered journaling, versus Tux3's
(more precise) delta commit. To that end, we could discuss the atomic
commit strategy that we use for the persistent memory implementation of
Shardmap, which may turn out to be largely applicable to Ext4's journal
transaction model.

> (3) It's not particularly well documented, making the above more
> challenging, but it appears to be a variation of an extensible hashing
> scheme, which was used by dbx and Berkley DB.

Sorry about that. There is this post from a few years back:

   https://lkml.org/lkml/2013/6/18/869

And there is a paper in the works. I can also follow up here with a post
on Shardmap internals, a number of which are interesting and unique.

Shardmap (introduced above as an "an O(1) extensible hash table") is indeed
an extensible hashing scheme. Fixed size hash tables are impractical for
databases and file system directories because small data sets waste too
much table space and large data sets have too many collisions. Therefore
every such design must incorporate some form of extensibility. Shardmap's
extension scheme is unique, and worthy of note in its own right as a
contribution to hash table technology. We did benchmark against Berkeley
DB and found Shardmap to be markedly faster. I will hunt around for those
numbers.

Very briefly, the Shardmap index has two distinct forms, one optimized
for media and the other for cache. These are bijective, each being
constructable from the other. The media form (the backing store) only
has a single purpose: to reconstruct the cache form on demand, one shard
at a time.

The cache form is the main source of Shardmap's efficiency. This is a
two level hash table with each entry in the top level table being a
pointer to a self contained hash table object. In contrast to other
extensible hashing schemes, these cache shard are not themselves
extensible. Rather, we simply rewrite entire shards into subshards
as needed.

The top level hash table is where the extensibility happens. At some
threshold, the top level table is expanded by duplicating the pointers
to the hash objects so that multiple buckets may reference the same
hash object. When any of those objects passes a threshold number of
entries, it is split into multiple, smaller hash objects, each with a
unique pointer from the top level table. Traversing this two level
table for lookup or existence tests takes just a few nanoseconds.

Extending the hash in cache is mirrored by extending the media form,
by serializing the cache shard into multiple linear regions on media.
Now here is the key idea: even taking the cost of this media rewrite
into account, insert performance remains O(1), just with a slightly
higher constant factor. Shardmap exploits this subtle mathematical
fact to get the best of both worlds: O(1) performance like a hash and
extensibility like a BTree.

In fact, if you wish to avoid that constant media rewrite factor
entirely, Shardmap lets you do it, by allowing you to specify the
number and size of shards at directory creation time. I have not
benchmarked this, but it could improve average create performance by 20%
or so. However, even with the "extra" media copy, Shardmap still has
impressively high insert performance, in fact it is significantly
faster than any of the high performance key value stores we have tried
so far.

> (4) Because of (2), we won't be able to do any actual benchmarks for a
> while.

(2) is not an issue, the copyright is entirely mine and the license can
be retuned as convenient. Just indicate where the GPLv2 version should
be posted and I will make it so. Perhaps a new Github repo, or Gitlab?

> I just checked the latest version of Tux3[2], and it appears
> to be be still using a linear search scheme for its directory ---
> e.g., an O(n) lookup ala ext2.  So I'm guessing Shardmap may have been
> *designed* for Tux3, but it has not yet been *implemented* for Tux3?
> 
> [2] https://github.com/OGAWAHirofumi/linux-tux3/blob/hirofumi/fs/tux3/dir.c#L283

Correct, not yet ported to Tux3, however this work is in progress. There
are some sticky little points to work out such as how to implement the
largish cache shard objects without using virtual memory. The PAGEMAP
compilation option in the current source breaks those objects up into
pages, essentially doing virtual memory by hand, which will add some
small amount of additional overhead to the kernel version versus the
user space version, nothing to worry about. However it does make me wish
that we had better kernel support for virtual memory.

There are various other kernel porting details that are maybe a bit too
fine grained for this post. Example: Shardmap is a memory mapped db but
we don't have mmap in kernel, so must do this by hand also.

> (5) The claim is made that readdir() accesses files sequentially; but
> there is also mention in Shardmap of compressing shards (e.g.,
> rewriting them) to squeeze out deleted and tombstone entries.  This
> pretty much guarantees that it will not be possible to satisfy POSIX
> requirements of telldir(2)/seekdir(3) (using a 32-bit or 64-bitt
> cookie), NFS (which also requires use of a 32-bit or 64-bit cookie
> while doing readdir scan), or readdir() semantics in the face of
> directory entries getting inserted or removed from the directory.

No problem, the data blocks are completely separate from the index so
readdir just walks through them in linear order a la classic UFS/Ext2.
What could possibly be simpler, faster or more POSIX compliant?

> (To be specific, POSIX requires readdir returns each entry in a
> directory once and only once, and in the case of a directory entry
> which is removed or inserted, that directory entry must be returned
> exactly zero or one times.  This is true even if telldir(2) ort
> seekdir(2) is used to memoize a particular location in the directory,
> which means you have a 32-bit or 64-bit cookie to define a particular
> location in the readdir(2) stream.  If the file system wants to be
> exportable via NFS, it must meet similar requirements ---- except the
> 32-bit or 64-bit cookie MUST survive a reboot.)

So we finally get to fix this nagging HTree defect after all these
years. Thank you once again for that sweet hack, but with luck we
will be able to obsolete it by this time next year.

Regards,

Daniel
