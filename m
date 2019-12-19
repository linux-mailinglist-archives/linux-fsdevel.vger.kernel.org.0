Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 281C6125976
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 03:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfLSCFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 21:05:31 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42163 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSCFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 21:05:30 -0500
Received: by mail-io1-f65.google.com with SMTP id n11so2590216iom.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 18:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAfhMEDbVZFIGn0Rgn56LzyhKv2ZJxYqjPylhW3ZNtk=;
        b=pqHpsWMn4hsA+rxqYGq3Au6nAvhoEqYy48MBsmNVu5PU/05VgMX/sBHa1O2G5y5j20
         pNNjCi6lV1p8mnQAB+48RTGxDkuCsrd27VO5CN15fe/8fOUEgfJPVrcLrwpZ7Fm2ROUU
         3I9dkXLc/Ah3xjailEuoZfJdRv3LFjZRPqUIfICGZjeu7Hj/BFc8Q/UXrqO5ZtEkIt6x
         fItTR2PC0ZM2ItmszRBXX85eOCu4iDX32nnkOwwqz8HYqgTsJErhbP5qz7p5Mm4P7F7y
         qqlGEU7G/euH27feHbMfIzC5EplR9vzupA3d6rIe+PQYWnoC2ZmQaswg0IMez3eH3uK6
         E9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAfhMEDbVZFIGn0Rgn56LzyhKv2ZJxYqjPylhW3ZNtk=;
        b=anrnzYtYtuv68bmISmq/ssZisRFpjvRn3mSdLCLnw5QbpZUHa1EC9t5Ys0qjCQsXGI
         NoIn8prmQzcAaGqChM7vnHDHovuySYIDCk3+AU+KwqW4Fm0FcKKpA961AuLc6E8qaLu9
         5TpPkEN0HnlZmqKAjyrH/9jRslXNygH1J8UkyvuMSeoITK4ar8fc1K9SLOafOZWbpkOD
         6vrHC/mretfvp+uRXmc5aYOSRuns1jK7+bheLSf8GUB7XfKYczULpqh6uYD2yH91a5LP
         +HItBMxObd1pw9x70/0LBzjBsc7JMyt6Ivu79dnsq6Bd9r6Z0wIHE1kND2ids5R732Xl
         mN2g==
X-Gm-Message-State: APjAAAUFS1hwXDoA1b08v+OO0SmndaUzED+EeG86o7g3VWBtZZi2puDV
        DPZr3JVIP0Xybi+ZQLVIlZu3gCiCIEhNbamAmB4=
X-Google-Smtp-Source: APXvYqz4fAKo6S+WQv3ZPup7eJEyeoXhH7ln09BD0CsBk1Et+DyGDx8dBqRVaoeCAOiMZutNoipQy+aLW/lhW6gE+e0=
X-Received: by 2002:a02:b615:: with SMTP id h21mr5036597jam.109.1576721129499;
 Wed, 18 Dec 2019 18:05:29 -0800 (PST)
MIME-Version: 1.0
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <20191217115603.GA10016@dhcp22.suse.cz> <CALOAHbBQ+XkQk6HN53O4e1=qfFiow2kvQO3ajDj=fwQEhcZ3uw@mail.gmail.com>
 <20191217165422.GA213613@cmpxchg.org> <20191218015124.GS19213@dread.disaster.area>
 <20191218043727.GA4877@cmpxchg.org> <20191218101626.GV19213@dread.disaster.area>
 <20191218213832.GA230750@cmpxchg.org>
In-Reply-To: <20191218213832.GA230750@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 19 Dec 2019 10:04:53 +0800
Message-ID: <CALOAHbBmLEwBfsSMt=SO5j+NMJspbqD1kZW5x7497FhcnjPkbQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 19, 2019 at 5:38 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Dec 18, 2019 at 09:16:26PM +1100, Dave Chinner wrote:
> > On Tue, Dec 17, 2019 at 11:37:27PM -0500, Johannes Weiner wrote:
> > > On Wed, Dec 18, 2019 at 12:51:24PM +1100, Dave Chinner wrote:
> > > > On Tue, Dec 17, 2019 at 11:54:22AM -0500, Johannes Weiner wrote:
> > > > > This problem exists independent of cgroup protection.
> > > > >
> > > > > The inode shrinker may take down an inode that's still holding a ton
> > > > > of (potentially active) page cache pages when the inode hasn't been
> > > > > referenced recently.
> > > >
> > > > Ok, please explain to me how are those pages getting repeated
> > > > referenced and kept active without referencing the inode in some
> > > > way?
> > > >
> > > > e.g. active mmap pins a struct file which pins the inode.
> > > > e.g. open fd pins a struct file which pins the inode.
> > > > e.g. open/read/write/close keeps a dentry active in cache which pins
> > > > the inode when not actively referenced by the open fd.
> > > >
> > > > AFAIA, all of the cases where -file pages- are being actively
> > > > referenced require also actively referencing the inode in some way.
> > > > So why is the inode being reclaimed as an unreferenced inode at the
> > > > end of the LRU if these are actively referenced file pages?
> > > >
> > > > > IMO we shouldn't be dropping data that the VM still considers hot
> > > > > compared to other data, just because the inode object hasn't been used
> > > > > as recently as other inode objects (e.g. drowned in a stream of
> > > > > one-off inode accesses).
> > > >
> > > > It should not be drowned by one-off inode accesses because if
> > > > the file data is being actively referenced then there should be
> > > > frequent active references to the inode that contains the data and
> > > > that should be keeping it away from the tail of the inode LRU.
> > > >
> > > > If the inode is not being frequently referenced, then it
> > > > isn't really part of the current working set of inodes, is it?
> > >
> > > The inode doesn't have to be currently open for its data to be used
> > > frequently and recently.
> >
> > No, it doesn't have to be "open", but it has to be referenced if
> > pages are being added to or accessed from it's mapping tree.
> >
> > e.g. you can do open/mmap/close, and the vma backing the mmap region
> > holds a reference to the inode via vma->vm_file until munmap is
> > called and the vma is torn down.
> >
> > So:
> >
> > > Executables that run periodically come to mind.
> >
> > this requires mmap, hence an active inode reference, and so when the
> > vma is torn down, the inode is moved to the head of the inode cache
> > LRU. IF we keep running that same executable, the inode will be
> > repeatedly relocated to the head of the LRU every time the process
> > running the executable exits.
> >
> > > An sqlite file database that is periodically opened and queried, then
> > > closed again.
> >
> > dentry pins inode on open, struct file pins inpde until close,
> > dentry reference pins inode until shrinker reclaims dentry. Inode
> > goes on head of LRU when dentry is reclaimed. Repeated cycles will
> > hit either the dentry cache or if that's been reclaimed the inode
> > cache will get hit.
> >
> > > A git repository.
> >
> > same as sqlite case, just with many files.
> >
> > IOWs, all of these data references take an active reference to the
> > inode and reset it's position in the inode cache LRU when the last
> > reference is dropped. If it's a dentry, it may not get dropped until
> > memory presure relaims the dentry. Hence inode cache LRU order does
> > not reflect the file data page LRU order in any way.
> >
> > But my question still stands: how do you get page LRU references
> > without inode references? And if you can't, why should having cached
> > pages on the oldest unused, unreferenced inode in the LRU prevent
> > it's reclaim?
>
> One of us is missing something really obvious here.
>
> Let's say I'm routinely working with a git tree and the objects are
> cached by active pages. I'm using a modified mincore() that reports
> page active state, so the output here is active/present/filesize:
>
> [hannes@computer linux]$ ~/src/mincore .git/objects/pack/*
> 17/17/17 .git/objects/pack/pack-1993efac574359d041b010c84d04eb0f05275bfd.idx
> 97/97/1168 .git/objects/pack/pack-1993efac574359d041b010c84d04eb0f05275bfd.pack
> 21/21/21 .git/objects/pack/pack-1d4bf264156bee8558b290123af0755292452520.idx
> 69/69/1487 .git/objects/pack/pack-1d4bf264156bee8558b290123af0755292452520.pack
> 223/223/243 .git/objects/pack/pack-1f7fde0cd5444aca2bad22d9f1f782f7b5fc5b7c.idx
> 261/261/25012 .git/objects/pack/pack-1f7fde0cd5444aca2bad22d9f1f782f7b5fc5b7c.pack
> 48/48/66 .git/objects/pack/pack-2d05108aa7d7542c3faff7b456bfa4c33aa49ddb.idx
> 0/0/8306 .git/objects/pack/pack-2d05108aa7d7542c3faff7b456bfa4c33aa49ddb.pack
> 40/40/40 .git/objects/pack/pack-4430a9ced8123449669b25879f7d4cd3f23c2df7.idx
> 16/16/5020 .git/objects/pack/pack-4430a9ced8123449669b25879f7d4cd3f23c2df7.pack
> 28/28/29 .git/objects/pack/pack-4d783e29b97258d679490f899be09d0a7fc73cf4.idx
> 4/4/3755 .git/objects/pack/pack-4d783e29b97258d679490f899be09d0a7fc73cf4.pack
> 46/46/46 .git/objects/pack/pack-5d66c70e90371495b5f1a35770e3c092347a2362.idx
> 166/166/2689 .git/objects/pack/pack-5d66c70e90371495b5f1a35770e3c092347a2362.pack
> 12/12/12 .git/objects/pack/pack-5e2d63c26589c42286cd7f15d3b076f1a0a2e895.idx
> 42/42/1083 .git/objects/pack/pack-5e2d63c26589c42286cd7f15d3b076f1a0a2e895.pack
> 38/38/38 .git/objects/pack/pack-6f7a49bdbcfd2ea4b64d57458a4f04df518a55eb.idx
> 129/129/2652 .git/objects/pack/pack-6f7a49bdbcfd2ea4b64d57458a4f04df518a55eb.pack
> 8/8/8 .git/objects/pack/pack-7053184528af47c7edacccbdbc2de25e627ea8e3.idx
> 4/4/743 .git/objects/pack/pack-7053184528af47c7edacccbdbc2de25e627ea8e3.pack
> 62/62/63 .git/objects/pack/pack-7463fe2f036d011a79a31bacb9da58455982ee4b.idx
> 96/96/7023 .git/objects/pack/pack-7463fe2f036d011a79a31bacb9da58455982ee4b.pack
> 129/129/130 .git/objects/pack/pack-7644e9848940f15642b4efebb8e4ccdcb9b2024e.idx
> 333/333/5060 .git/objects/pack/pack-7644e9848940f15642b4efebb8e4ccdcb9b2024e.pack
> 6487/6487/7557 .git/objects/pack/pack-8347268f4d6fa0f763c7d1690dcee8f933be253f.idx
> 12260/12260/285090 .git/objects/pack/pack-8347268f4d6fa0f763c7d1690dcee8f933be253f.pack
> 603/603/683 .git/objects/pack/pack-c51831234bf615a2b47a49c31f10ae480fa482dd.idx
> 1450/1450/23000 .git/objects/pack/pack-c51831234bf615a2b47a49c31f10ae480fa482dd.pack
> 657/657/757 .git/objects/pack/pack-d793ea6b319c4d19eb281f5ca2e368c24e10d91a.idx
> 1658/1658/21055 .git/objects/pack/pack-d793ea6b319c4d19eb281f5ca2e368c24e10d91a.pack
> 46037/46037/53690 .git/objects/pack/pack-ee31400e588e715113b665d7313d570553133d71.idx
> 105772/105772/367275 .git/objects/pack/pack-ee31400e588e715113b665d7313d570553133d71.pack
>
> Now something like updatedb, a find or comparable goes off and in a
> short amount of time creates a ton of one-off dentries, inodes, and
> file cache:
>
> $ find /usr -type f -exec grep -q dave {} \;
>
> LRU reclaim recognizes that the file cache produced by this operation
> is not used repeatedly and lets an infinite amount of it pass through
> the inactive list without disturbing my git tree workingset.
>
> The inode/dentry reclaim doesn't do the same thing. It looks at the
> references and delays the inevitable for a few more items coming
> through the LRU, but eventually it lets a bunch of objects that are
> only used once push out data that has been used over and over right
> before this burst of metadata objects came along.
>
> The VM goes through a ridiculous effort to implement scan resistance:
> we split the LRUs into inactive/active lists, we track non-resident
> cache information to tell stable states from transitions and carefully
> balance the lists agains each other. All in an effort to protect
> established workingsets that have proven to benefit from caching from
> bursts of one-off entries that do not.
>
> Thousands of lines of complexity, years of labor, to make this work.
>
> And then the inode shrinker just goes and drops it all on the floor:
>
> [hannes@computer linux]$ ~/src/mincore .git/objects/pack/*
> 0/0/17 .git/objects/pack/pack-1993efac574359d041b010c84d04eb0f05275bfd.idx
> 0/0/1168 .git/objects/pack/pack-1993efac574359d041b010c84d04eb0f05275bfd.pack
> 0/0/21 .git/objects/pack/pack-1d4bf264156bee8558b290123af0755292452520.idx
> 0/0/1487 .git/objects/pack/pack-1d4bf264156bee8558b290123af0755292452520.pack
> 0/0/243 .git/objects/pack/pack-1f7fde0cd5444aca2bad22d9f1f782f7b5fc5b7c.idx
> 0/0/25012 .git/objects/pack/pack-1f7fde0cd5444aca2bad22d9f1f782f7b5fc5b7c.pack
> 0/0/66 .git/objects/pack/pack-2d05108aa7d7542c3faff7b456bfa4c33aa49ddb.idx
> 0/0/8306 .git/objects/pack/pack-2d05108aa7d7542c3faff7b456bfa4c33aa49ddb.pack
> 0/0/40 .git/objects/pack/pack-4430a9ced8123449669b25879f7d4cd3f23c2df7.idx
> 0/0/5020 .git/objects/pack/pack-4430a9ced8123449669b25879f7d4cd3f23c2df7.pack
> 0/0/29 .git/objects/pack/pack-4d783e29b97258d679490f899be09d0a7fc73cf4.idx
> 0/0/3755 .git/objects/pack/pack-4d783e29b97258d679490f899be09d0a7fc73cf4.pack
> 0/0/46 .git/objects/pack/pack-5d66c70e90371495b5f1a35770e3c092347a2362.idx
> 0/0/2689 .git/objects/pack/pack-5d66c70e90371495b5f1a35770e3c092347a2362.pack
> 0/0/12 .git/objects/pack/pack-5e2d63c26589c42286cd7f15d3b076f1a0a2e895.idx
> 0/0/1083 .git/objects/pack/pack-5e2d63c26589c42286cd7f15d3b076f1a0a2e895.pack
> 0/0/38 .git/objects/pack/pack-6f7a49bdbcfd2ea4b64d57458a4f04df518a55eb.idx
> 0/0/2652 .git/objects/pack/pack-6f7a49bdbcfd2ea4b64d57458a4f04df518a55eb.pack
> 0/0/8 .git/objects/pack/pack-7053184528af47c7edacccbdbc2de25e627ea8e3.idx
> 0/0/743 .git/objects/pack/pack-7053184528af47c7edacccbdbc2de25e627ea8e3.pack
> 0/0/63 .git/objects/pack/pack-7463fe2f036d011a79a31bacb9da58455982ee4b.idx
> 0/0/7023 .git/objects/pack/pack-7463fe2f036d011a79a31bacb9da58455982ee4b.pack
> 0/0/130 .git/objects/pack/pack-7644e9848940f15642b4efebb8e4ccdcb9b2024e.idx
> 0/0/5060 .git/objects/pack/pack-7644e9848940f15642b4efebb8e4ccdcb9b2024e.pack
> 0/0/7557 .git/objects/pack/pack-8347268f4d6fa0f763c7d1690dcee8f933be253f.idx
> 0/0/285090 .git/objects/pack/pack-8347268f4d6fa0f763c7d1690dcee8f933be253f.pack
> 0/0/683 .git/objects/pack/pack-c51831234bf615a2b47a49c31f10ae480fa482dd.idx
> 0/0/23000 .git/objects/pack/pack-c51831234bf615a2b47a49c31f10ae480fa482dd.pack
> 0/0/757 .git/objects/pack/pack-d793ea6b319c4d19eb281f5ca2e368c24e10d91a.idx
> 0/0/21055 .git/objects/pack/pack-d793ea6b319c4d19eb281f5ca2e368c24e10d91a.pack
> 0/0/53690 .git/objects/pack/pack-ee31400e588e715113b665d7313d570553133d71.idx
> 0/0/367275 .git/objects/pack/pack-ee31400e588e715113b665d7313d570553133d71.pack
>
> This isn't a theoretical issue. The reason people keep coming up with
> the same patch is because they hit exactly this problem in real life.
>

BTW, we can protect these page caches with memory.min after the issues
found by me is fixed
(and I'm working on it :-) ).

> > > I don't want a find or an updatedb, which doesn't produce active
> > > pages, and could be funneled through the cache with otherwise no side
> > > effects, kick out all my linux tree git objects via the inode shrinker
> > > just because I haven't run a git command in a few minutes.
> >
> > That has nothing to do with this patch. updatedb and any file
> > traversal that touches data are going to be treated identically to
> > you precious working set because they all have nr_pages > 0.
> >
> > IOWs, this patch does nothing to avoid the problem of single use
> > inodes streaming through the inode cache causing the reclaim of all
> > inodes. It just changes the reclaim behaviour and how quickly single
> > use inodes can be reclaimed. i.e. we now can't reclaim single use
> > inodes when they reach the end of the LRU, we have to wait for page
> > cache reclaim to free it's pages before the inode can be reclaimed.
>
> Of course it does. LRU reclaim will clean out the single-use pages,
> after which those inodes will have !nr_pages and can be reclaimed.
>
> > Further, because inode LRU order is going to be different to page LRU
> > order, there's going to be a lot more useless scanning trying to
> > find inodes that can be reclaimed. Hence this changes cache balance,
> > reduces reclaim efficiency, increases reclaim priority windup as
> > less gets freed per scan, and this all ends up causing performance
> > and behavioural regressions in unexpected places.
>
> It would be better to keep the inodes off the LRU entirely as long as
> they are not considered for reclaim. That would save some CPU churn.
>
> > i.e. this makes the page cache pin the inode in memory and that's a
> > major change in bheaviour. that's what caused all the performance
> > regressions with workloads that traverse a large single-use file set
> > such as a kernel compile - most files and their data are accessed
> > just once, and when they get to the end of the inode LRU we really
> > want to reclaim them immediately as they'll never get accessed
> > again.
> >
> > To put it simply, if your goal is to avoid single use inodes from
> > trashing a long term working set of cached inodes, then this
> > patch does not provide the reliable or predictable object
> > management algorithm you are looking for.
> >
> > If you want to address use-once cache trashing, how about working
> > towards a *smarter LRU algorithm* for the list_lru infrastructure?
> > Don't hack naive heuristics that "work for me" into the code, go
> > back to the algorithm and select something that is provent to
> > be resilient against use-once object storms.
> >
> > i.e. The requirement is we retain quasi-LRU behaviour, but
> > allow use-once objects to cycle through the LRU without disturbing
> > frequently/recently referenced/active objects.  The
> > per-object reference bit we currently use isn't resilient against
> > large-scale use-once object cycling, so we have to improve on that.
> >
> > Experience tells me we've solved this problem before, and it's right
> > in your area or expertise, too. We could modify the list-lru to use
> > a different LRU algorithm that is resilient against the sort of
> > flooding you are worried about. We could simply use a double clock
> > list like the page LRU uses - we promote frequently referenced
> > inodes to the active list when instead of setting a reference bit
> > when a reference is dropped and the indoe is on the inactive list.
> > And a small part of each shrinker scan count can be used to demote
> > the tail of the active list to keep it slowly cycling. This way
> > single use inodes will only ever pass through the inactive list
> > without perturbing the active list, and we've solved the problem of
> > single use inode streams trashing the working cache for all use
> > cases, not just one special case....
>
> I'm not opposed to any of this work, but I don't see how it would be a
> prerequisite to fixing the aging inversion we're talking about here -
> throwing out "unused" containers without looking at what's inside.
>
> On the contrary, the inode scanner would already make better decisions
> by simply not discarding all the usage information painstakingly
> gathered by the VM.
>
> We can talk about the implementation, of course. Repeatedly skipping
> over inodes rather than physically taking them off the list can be a
> scalability problem; pushing the shrinker into dirty inodes can be a
> problem for certain filesystems. I didn't submit a patch for
> upstreaming, I sent a diff hunk to propose an aging hierarchy.
>
> If you agree with my concern about aging decisions here, but think
> it's the best we can do given our constraints, we can talk about this
> too - but we should at least document the hack currently in place.
>
> If you disagree that the reclaim layering here is fundamentally
> problematic, I'm not sure I need to move on with this discussion.
>
> > > > commit 69056ee6a8a3d576ed31e38b3b14c70d6c74edcc
> > > > Author: Dave Chinner <dchinner@redhat.com>
> > > > Date:   Tue Feb 12 15:35:51 2019 -0800
> > > >
> > > >     Revert "mm: don't reclaim inodes with many attached pages"
> > > >
> > > >     This reverts commit a76cf1a474d7d ("mm: don't reclaim inodes with many
> > > >     attached pages").
> > > >
> > > >     This change causes serious changes to page cache and inode cache
> > > >     behaviour and balance, resulting in major performance regressions when
> > > >     combining worklaods such as large file copies and kernel compiles.
> > > >
> > > >       https://bugzilla.kernel.org/show_bug.cgi?id=202441
> > >
> > > I don't remember this, but reading this bugzilla thread is immensely
> > > frustrating.
> >
> > So you're shooting the messenger as well, eh?
> >
> > We went through this whole "blame XFS" circus sideshow when I found
> > the commits that caused the regression. It went on right up until
> > people using ext4 started reporting similar problems.
> >
> > Yes, XFS users were the first to notice the issue, but that does
> > not make it an XFS problem!
>
> I cannot find details on the other filesystems in the bug report or
> the changelog. Where was the time going? Was it the CPU churn of
> skipping over the inodes?
>
> > > We've been carrying this patch here in our tree for over half a decade
> > > now to work around this exact stalling in the xfs shrinker:
> > >
> > > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > > index d53a316162d6..45b3a4d07813 100644
> > > --- a/fs/xfs/xfs_icache.c
> > > +++ b/fs/xfs/xfs_icache.c
> > > @@ -1344,7 +1344,7 @@ xfs_reclaim_inodes_nr(
> > >         xfs_reclaim_work_queue(mp);
> > >         xfs_ail_push_all(mp->m_ail);
> > >
> > > -       return xfs_reclaim_inodes_ag(mp, SYNC_TRYLOCK | SYNC_WAIT, &nr_to_scan);
> > > +       return xfs_reclaim_inodes_ag(mp, SYNC_TRYLOCK, &nr_to_scan);
> > >  }
> > >
> > > Because if we don't, our warmstorage machines lock up within minutes,
> > > long before Roman's patch.
> >
> > Oh, go cry me a river. Poor little FB, has to carry an out-of-tree
> > hack that "works for them" because they don't care enough about
> > fixing it to help upstream address the underlying memory reclaim
> > problems that SYNC_WAIT flag avoids.
> >
> > Indeed, we (XFS devs) have repeatedly provided evidence that this
> > patch makes it relatively trivial for users to DOS systems via
> > OOM-killer rampages. It does not survive my trivial "fill memory
> > with inodes" test without the oom-killer killing the machine, and
> > any workload that empties the page cache before the inode cache is
> > prone to oom kill because nothing throttles reclaim anymore and
> > there are no pages left to reclaim or swap.
> >
> > It is manifestly worse than what we have now, and that means it is
> > not a candidate for merging. We've told FB engineers this
> > *repeatedly*, and yet this horrible, broken, nasty, expedient hack
> > gets raised every time "shrinker" and "XFS" are mentioned in the
> > same neighbourhood.  Just stop it, please.
>
> You don't need to be privileged to cause OOM kills in a myriad of ways
> if you tried to.
>
> You don't need to run a malicious workload to have the xfs shrinker
> stall out reclaimers in the presence of gigabytes of clean, easy to
> reclaim cache.
>
> We fundamentally disagree on what the horrible, broken, nasty,
> expedient hack is.
>
> > > The fact that xfs stalls on individual inodes while there might be a
> > > ton of clean cache on the LRUs is an xfs problem, not a VM problem.
> >
> > No, at it's core it is a VM problem, because if we don't stall on
> > inode reclaim in XFS then memory reclaim does far worse things to
> > your machine than incur an occasional long tail latency.
> >
> > You're free to use some other filesystem if you can't wait for
> > upstream XFS developers to fix it properly or you can't be bothered
> > to review the patches that actually attempt to fix the problem
> > properly...
>
> I'm not worried about xfs. I'm worried about these design decisions
> bleeding into other parts of reclaim.
>
> > > The right thing to do to avoid stalls in the inode shrinker is to skip
> > > over the dirty inodes and yield back to LRU reclaim; not circumvent
> > > page aging and drop clean inodes on the floor when those may or may
> > > not hold gigabytes of cache data that the inode shrinker knows
> > > *absolutely nothing* about.
> >
> > *cough* [*]
> >
> > https://lore.kernel.org/linux-mm/20191031234618.15403-1-david@fromorbit.com/
> >
> > This implements exactly what you suggest - shrinkers that can
> > communicate the need for backoffs to the core infrastructure and
> > work deferral to kswapd rather than doing it themselves. And it uses
> > that capability to implement non-blocking inode reclaim for XFS.
>
> Does that series end in the shrinkers leaving page reclaim to the page
> LRU order?
>
> I'm asking facetiously. Don't get me wrong, I'm interested in what
> your patchset promises to implement. However, I'm extremely reluctant
> to dive into a series of 28 patches if this is how the discussions go.
