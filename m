Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70343127733
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 09:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfLTIdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 03:33:02 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44644 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLTIdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:33:01 -0500
Received: by mail-io1-f68.google.com with SMTP id b10so8561971iof.11;
        Fri, 20 Dec 2019 00:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mc3hnn5hKCeoOVS510OSPuXxn8tGB73WNuvnRyQVe8o=;
        b=EUWjw3QZOfM43N/n3wm/xQj8D8jbcbs1ytdMCG8f8gOIauntMnrH4TtZJCt73wMD+p
         0D6mvBb439StZ+7ksUkGEUCEvAK1e2vEyDz08Fm8k54VROHKAAu6IUkeyu2w1G7ToToX
         d2aoVOY6TT36HTgUd+EqGV7dsNm8L9nssqD2AaFrlqXXDTzHYxkHDhujhWz870m8Sq3W
         WudXyDf/hnkfA8C8eM/44C8ezWz+iBaZq49aF4LhdNpgE3ryH/Sw5JC2ETr9ixlli9oj
         XcJBkly+8mSyLoCWbIet+OgD7Vcf1gMJZAH3SWmKAZQTwoEhbw6sm3hxEB2VCkMqbX/I
         2RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mc3hnn5hKCeoOVS510OSPuXxn8tGB73WNuvnRyQVe8o=;
        b=PCL/WDGpXUIX2j/gIqtGxGjP9ZQ/0gSYv83LwnQi3zJ7SuCTbtSO2GCPGuSzWjDRkD
         6duZqf/0M7IxDpLAPLX2G/O6+5I6kWBIaqvZ02COiAp7ieNZpbWmArqQGhAxR9hbyeya
         fFs//Sg2kYzM/fQGQClr1R1CSeG7KvKhYQrhB8ohibAWf7YdTElAuRwBF8dLV8CXeynm
         ORXffQfpA9RQN54iS9G1Oggy1uSmYIzF/F7UqLVFUJk9qpv4ZXiKDGICAQGKMGZhezkG
         Jf5osiDcxm1SnDGv6+RXta5K4vp/7AvHSnfGM65rSNJb3h0DPSwkMDVQdnAr48pslvvI
         8azg==
X-Gm-Message-State: APjAAAWVKTzda1OYwzqHH8cJULOBak6yXyqv++8dk3KqhH5FL3MF61Y2
        BR8y96mBYs6uA5yRhPzd/G0vdVBUQAXl68rRPlo=
X-Google-Smtp-Source: APXvYqxRwiaFhoXimN8yj8j7UhYP3uLXfyasi7aeDZWJfotKP3wtdMX8wZYGOH4VDzxUWyuQtA4RyZIMuUU1htfQmsc=
X-Received: by 2002:a5e:9907:: with SMTP id t7mr9271203ioj.72.1576830780471;
 Fri, 20 Dec 2019 00:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20191220024936.GA380394@chrisdown.name>
In-Reply-To: <20191220024936.GA380394@chrisdown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 20 Dec 2019 10:32:49 +0200
Message-ID: <CAOQ4uxjqSWcrA1reiyit9DRt+aq2tXBxLdPE31RrYw1yr=4hjg@mail.gmail.com>
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 4:50 AM Chris Down <chris@chrisdown.name> wrote:
>
> In Facebook production we are seeing heavy inode number wraparounds on
> tmpfs. On affected tiers, in excess of 10% of hosts show multiple files
> with different content and the same inode number, with some servers even
> having as many as 150 duplicated inode numbers with differing file
> content.
>
> This causes actual, tangible problems in production. For example, we
> have complaints from those working on remote caches that their
> application is reporting cache corruptions because it uses (device,
> inodenum) to establish the identity of a particular cache object, but
> because it's not unique any more, the application refuses to continue
> and reports cache corruption. Even worse, sometimes applications may not
> even detect the corruption but may continue anyway, causing phantom and
> hard to debug behaviour.
>
> In general, userspace applications expect that (device, inodenum) should
> be enough to be uniquely point to one inode, which seems fair enough.
> This patch changes get_next_ino to use up to min(sizeof(ino_t), 8) bytes
> to reduce the likelihood of wraparound. On architectures with 32-bit
> ino_t the problem is, at least, not made any worse than it is right now.
>
> I noted the concern in the comment above about 32-bit applications on a
> 64-bit kernel with 32-bit wide ino_t in userspace, as documented by Jeff
> in the commit message for 866b04fc, but these applications are going to
> get EOVERFLOW on filesystems with non-volatile inode numbers anyway,
> since those will likely be 64-bit. Concerns about that seem slimmer
> compared to the disadvantages this presents for known, real users of
> this functionality on platforms with a 64-bit ino_t.
>
> Other approaches I've considered:
>
> - Use an IDA. If this is a problem for users with 32-bit ino_t as well,
>   this seems a feasible approach. For now this change is non-intrusive
>   enough, though, and doesn't make the situation any worse for them than
>   present at least.
> - Look for other approaches in userspace. I think this is less
>   feasible -- users do need to have a way to reliably determine inode
>   identity, and the risk of wraparound with a 2^32-sized counter is
>   pretty high, quite clearly manifesting in production for workloads
>   which make heavy use of tmpfs.

How about something like this:

/* just to explain - use an existing macro */
shmem_ino_shift = ilog2(sizeof(void *));
inode->i_ino = (__u64)inode >> shmem_ino_shift;

This should solve the reported problem with little complexity,
but it exposes internal kernel address to userspace.

Can we do anything to mitigate this risk?

For example, instead of trying to maintain a unique map of
ino_t to struct shmem_inode_info * in the system
it would be enough (and less expensive) to maintain a unique map of
shmem_ino_range_t to slab.
The ino_range id can then be mixes with the relative object index in
slab to compose i_ino.

The big win here is not having to allocate an id every bunch of inodes
instead of every inode, but the fact that recycled (i.e. delete/create)
shmem_inode_info objects get the same i_ino without having to
allocate any id.

This mimics a standard behavior of blockdev filesystem like ext4/xfs
where inode number is determined by logical offset on disk and is
quite often recycled on delete/create.

I realize that the method I described with slab it crossing module layers
and would probably be NACKED.
Similar result could be achieved by shmem keeping a small stash of
recycled inode objects, which are not returned to slab right away and
retain their allocated i_ino. This at least should significantly reduce the
rate of burning get_next_ino allocation.

Anyway, to add another consideration to the mix, overlayfs uses
the high ino bits to multiplex several layers into a single ino domain
(mount option xino=on).

tmpfs is a very commonly used filesystem as overlayfs upper layer,
so many users are going to benefit from keeping the higher most bits
of tmpfs ino inodes unused.

For this reason, I dislike the current "grow forever" approach of
get_next_ino() and prefer that we use a smarter scheme when
switching over to 64bit values.

Thanks,
Amir.
