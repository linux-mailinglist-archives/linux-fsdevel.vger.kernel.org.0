Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC10D67AFD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 11:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbjAYKkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 05:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjAYKki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:40:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3578228870
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 02:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674643188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rhbmWEFdYq3vCAExuufIQ+qo5uHVpM4cptZz8xdZoh4=;
        b=Dk+y41C6vuNLoF5+NmN/PhR93V+5Fu3tHfHMByqmKGCSid+ILNZtcR3/ioZbbn7/k+ZOEw
        5dobJY5DgQbYjIjOKOz9gzAPTZChzINLkwzXP6qO5UoP9NeHTZfl9084UJYVAwB03cNgzi
        M8xBk513kX6YJUPvQc7O56qfB7ylOjY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-LpqEe98WNyaWfdVpx-tqhQ-1; Wed, 25 Jan 2023 05:39:45 -0500
X-MC-Unique: LpqEe98WNyaWfdVpx-tqhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9223F857F40;
        Wed, 25 Jan 2023 10:39:44 +0000 (UTC)
Received: from localhost (unknown [10.39.195.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9177C39DCA;
        Wed, 25 Jan 2023 10:39:43 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
References: <cover.1674227308.git.alexl@redhat.com>
        <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
        <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
        <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
        <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
        <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
        <20230125041835.GD937597@dread.disaster.area>
        <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
Date:   Wed, 25 Jan 2023 11:39:41 +0100
In-Reply-To: <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
        (Amir Goldstein's message of "Wed, 25 Jan 2023 10:32:26 +0200")
Message-ID: <87wn5ac2z6.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Wed, Jan 25, 2023 at 6:18 AM Dave Chinner <david@fromorbit.com> wrote:
>>
>> On Tue, Jan 24, 2023 at 09:06:13PM +0200, Amir Goldstein wrote:
>> > On Tue, Jan 24, 2023 at 3:13 PM Alexander Larsson <alexl@redhat.com> wrote:
>> > > On Tue, 2023-01-24 at 05:24 +0200, Amir Goldstein wrote:
>> > > > On Mon, Jan 23, 2023 at 7:56 PM Alexander Larsson <alexl@redhat.com>
>> > > > wrote:
>> > > > > On Fri, 2023-01-20 at 21:44 +0200, Amir Goldstein wrote:
>> > > > > > On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson
>> > > > > > <alexl@redhat.com>
>> > > > > > wrote:
>> > > I'm not sure why the dentry cache case would be more important?
>> > > Starting a new container will very often not have cached the image.
>> > >
>> > > To me the interesting case is for a new image, but with some existing
>> > > page cache for the backing files directory. That seems to model staring
>> > > a new image in an active container host, but its somewhat hard to test
>> > > that case.
>> > >
>> >
>> > ok, you can argue that faster cold cache ls -lR is important
>> > for starting new images.
>> > I think you will be asked to show a real life container use case where
>> > that benchmark really matters.
>>
>> I've already described the real world production system bottlenecks
>> that composefs is designed to overcome in a previous thread.
>>
>> Please go back an read this:
>>
>> https://lore.kernel.org/linux-fsdevel/20230118002242.GB937597@dread.disaster.area/
>>
>
> I've read it and now re-read it.
> Most of the post talks about the excess time of creating the namespace,
> which is addressed by erofs+overlayfs.
>
> I guess you mean this requirement:
> "When you have container instances that might only be needed for a
> few seconds, taking half a minute to set up the container instance
> and then another half a minute to tear it down just isn't viable -
> we need instantiation and teardown times in the order of a second or
> two."
>
> Forgive for not being part of the containers world, so I have to ask -
> Which real life use case requires instantiation and teardown times in
> the order of a second?
>
> What is the order of number of files in the manifest of those ephemeral
> images?
>
> The benchmark was done on a 2.6GB centos9 image.
>
> My very minimal understanding of containers world, is that
> A large centos9 image would be used quite often on a client so it
> would be deployed as created inodes in disk filesystem
> and the ephemeral images are likely to be small changes
> on top of those large base images.
>
> Furthermore, the ephmeral images would likely be composed
> of cenos9 + several layers, so the situation of single composefs
> image as large as centos9 is highly unlikely.
>
> Am I understanding the workflow correctly?
>
> If I am, then I would rather see benchmarks with images
> that correspond with the real life use case that drives composefs,
> such as small manifests and/or composefs in combination with
> overlayfs as it would be used more often.
>
>> Cold cache performance dominates the runtime of short lived
>> containers as well as high density container hosts being run to
>> their container level memory limits. `ls -lR` is just a
>> microbenchmark that demonstrates how much better composefs cold
>> cache behaviour is than the alternatives being proposed....
>>
>> This might also help explain why my initial review comments focussed
>> on getting rid of optional format features, straight lining the
>> processing, changing the format or search algorithms so more
>> sequential cacheline accesses occurred resulting in less memory
>> stalls, etc. i.e. reductions in cold cache lookup overhead will
>> directly translate into faster container workload spin up.
>>
>
> I agree that this technology is novel and understand why it results
> in faster cold cache lookup.
> I do not know erofs enough to say if similar techniques could be
> applied to optimize erofs lookup at mkfs.erofs time, but I can guess
> that this optimization was never attempted.

As Dave mentioned, containers in a cluster usually run with low memory
limits to increase density of how many containers can run on a single
host.  I've done some tests to get some numbers on the memory usage.

Please let me know if you've any comment on the method I've used to read
the memory usage, if you've any better suggestion please let me know.

I am using a Fedora container image, but I think the image used is not
relevant, as the memory used should increase linearly to the image size
for both setups.

I am using systemd-run --scope to get a new cgroup, the system uses
cgroupv2.

For this first test I am using a RO mount both for composefs and
erofs+overlayfs.

# echo 3 > /proc/sys/vm/drop_caches
# \time systemd-run --scope sh -c 'ls -lR /mnt/composefs > /dev/null; cat $(cat /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
Running scope as unit: run-r482ec1c3024a4a8b9d2a369bf5dc6df3.scope
16367616
0.03user 0.54system 0:00.71elapsed 80%CPU (0avgtext+0avgdata 7552maxresident)k
10592inputs+0outputs (28major+1273minor)pagefaults 0swaps

# echo 3 > /proc/sys/vm/drop_caches
# \time systemd-run --scope sh -c 'ls -lR /mnt/erofs-overlay > /dev/null; cat $(cat /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
Running scope as unit: run-r5f0f599053c349669e5c1ecacaa037b6.scope
48390144
0.04user 1.03system 0:01.81elapsed 59%CPU (0avgtext+0avgdata 7552maxresident)k
30776inputs+0outputs (28major+1269minor)pagefaults 0swaps

the erofs+overlay setup takes 2.5 times to complete and it uses 3 times
the memory used by composefs.

The second test involves a RW mount for composefs.

For the erofs+overlay setup I've just added an upperdir and workdir to
the overlay mount, while for composefs I create a completely new overlay
mount that uses the composefs mount as the lower layer.

# echo 3 > /proc/sys/vm/drop_caches
# \time systemd-run --scope sh -c 'ls -lR /mnt/composefs-overlay > /dev/null; cat $(cat /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
Running scope as unit: run-r23519c8048704e5b84a1355f131d9d93.scope
31014912
0.05user 1.15system 0:01.38elapsed 87%CPU (0avgtext+0avgdata 7552maxresident)k
10944inputs+0outputs (28major+1282minor)pagefaults 0swaps

# echo 3 > /proc/sys/vm/drop_caches
# \time systemd-run --scope sh -c 'ls -lR /mnt/erofs-overlay > /dev/null; cat $(cat /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
Running scope as unit: run-rdbccf045f3124e379cec00273638db08.scope
48308224
0.07user 2.04system 0:03.22elapsed 65%CPU (0avgtext+0avgdata 7424maxresident)k
30720inputs+0outputs (28major+1273minor)pagefaults 0swaps

so the erofs+overlay setup still takes more time (almost 2.5 times) and
uses more memory (slightly more than 1.5 times)

>> > > > > This isn't all that strange, as overlayfs does a lot more work for
>> > > > > each lookup, including multiple name lookups as well as several
>> > > > > xattr
>> > > > > lookups, whereas composefs just does a single lookup in a pre-
>> > > > > computed
>> > > >
>> > > > Seriously, "multiple name lookups"?
>> > > > Overlayfs does exactly one lookup for anything but first level
>> > > > subdirs
>> > > > and for sparse files it does the exact same lookup in /objects as
>> > > > composefs.
>> > > > Enough with the hand waving please. Stick to hard facts.
>> > >
>> > > With the discussed layout, in a stat() call on a regular file,
>> > > ovl_lookup() will do lookups on both the sparse file and the backing
>> > > file, whereas cfs_dir_lookup() will just map some page cache pages and
>> > > do a binary search.
>> > >
>> > > Of course if you actually open the file, then cfs_open_file() would do
>> > > the equivalent lookups in /objects. But that is often not what happens,
>> > > for example in "ls -l".
>> > >
>> > > Additionally, these extra lookups will cause extra memory use, as you
>> > > need dentries and inodes for the erofs/squashfs inodes in addition to
>> > > the overlay inodes.
>> >
>> > I see. composefs is really very optimized for ls -lR.
>>
>> No, composefs is optimised for minimal namespace and inode
>> resolution overhead. 'ls -lR' does a lot of these operations, and
>> therefore you see the efficiency of the design being directly
>> exposed....
>>
>> > Now only need to figure out if real users start a container and do ls -lR
>> > without reading many files is a real life use case.
>>
>> I've been using 'ls -lR' and 'find . -ctime 1' to benchmark cold
>> cache directory iteration and inode lookup performance for roughly
>> 20 years. The benchmarks I run *never* read file data, nor is that
>> desired - they are pure directory and inode lookup micro-benchmarks
>> used to analyse VFS and filesystem directory and inode lookup
>> performance.
>>
>> I have been presenting such measurements and patches improving
>> performance of these microbnechmarks to the XFS and fsdevel lists
>> over 15 years and I have *never* had to justify that what I'm
>> measuring is a "real world workload" to anyone. Ever.
>>
>> Complaining about real world relevancy of the presented benchmark
>> might be considered applying a double standard, wouldn't you agree?
>>
>
> I disagree.
> Perhaps my comment was misunderstood.
>
> The cold cache benchmark is certainly relevant for composefs
> comparison and I expect to see it in future submissions.
>
> The point I am trying to drive is this:
> There are two alternatives on the table:
> 1. Add fs/composefs
> 2. Improve erofs and overlayfs
>
> Functionally, I think we all agree that both alternatives should work.
>
> Option #1 will take much less effort from composefs authors, so it is
> understandable that they would do their best to argue in its favor.
>
> Option #2 is prefered for long term maintenance reasons, which is
> why vfs/erofs/overlayfs developers argue in favor of it.
>
> The only factor that remains that could shift the balance inside
> this gray area are the actual performance numbers.
>
> And back to my point: the not so simple decision between the
> two options, by whoever makes this decision, should be based
> on a real life example of performance improvement and not of
> a microbenchamk.
>
> In my limited experience, a real life example means composefs
> as a layer in overlayfs.
>
> I did not see those numbers and it is clear that they will not be
> as impressive as the bare composefs numbers, so proposing
> composefs needs to include those numbers as well.
>
> Alexander did claim that he has real life use cases for bare readonly
> composefs images, but he did not say what the size of the manifests
> in those images are and he did not say whether these use cases
> also require startup and teardown in orders of seconds.
>
> It looks like the different POV are now well understood by all parties
> and that we are in the process of fine tuning the information that
> needs to be presented for making the best decision based on facts.
>
> This discussion, which was on a collision course at the beginning,
> looks like it is in a converging course - this makes me happy.
>
> Thanks,
> Amir.

