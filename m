Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E90E57E277
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 15:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiGVNne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 09:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiGVNnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:43:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B56BC38;
        Fri, 22 Jul 2022 06:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA273B82902;
        Fri, 22 Jul 2022 13:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7494DC341CE;
        Fri, 22 Jul 2022 13:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658497409;
        bh=JNOrMYsPoDL/eg223R4yc86YLW3fK7oVbRQvzymB0mY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bhd5FkYew0GcS8oEu+bqOlnsgnmU+VsNCCMQX2rGAcqZqSuu23bAV4yDtuWpB0BMO
         +QFQl6/sxJEyBtNNz2PN4KAJoiI3Jd8+WZd3m9O28mbsz5fD8PdLcHbSSCXbLkFEKw
         U2MG0GjephE0OZfUbirN3FXsCm2/0YV4UvdwfZspnAZNWau78FR6x31+m3S78N7lMB
         gGNSYlPjPsqJYukTGaZkmMbgZqjhkWxVp90ozL4K6OSRtqaiE2Ls6KEJdY7dgf86OB
         EapUJeYRKYtcI0l+c/fDeJFB4yy604nR/VTRdbTd/zg3exnfMHi/z7RtBI5eEgP7V3
         p970KZAj8XQiQ==
Received: by mail-wr1-f48.google.com with SMTP id d16so6550008wrv.10;
        Fri, 22 Jul 2022 06:43:29 -0700 (PDT)
X-Gm-Message-State: AJIora+DzfumLhVqBzNKXwOxwvszXcrxwBkvjGnDBGgnkytkzKvAo+QV
        +f2WvaGRk0Kr9+QVhvfEd8CAkE+yMGaKjpy+Oa4=
X-Google-Smtp-Source: AGRyM1vQx2VCtZEWRrTofl5EKnzSNMyReww1mgcK2JRaH6XVwUW2DBNhJqClsepr17Mt/rv1Kt3lgg+tuT+R+hynfLQ=
X-Received: by 2002:adf:de0a:0:b0:21e:45b0:e917 with SMTP id
 b10-20020adfde0a000000b0021e45b0e917mr10796wrm.434.1658497407859; Fri, 22 Jul
 2022 06:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220715184433.838521-1-anna@kernel.org> <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com> <20220718011552.GK3600936@dread.disaster.area>
 <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
 <Ytm7e2QHomJICHsO@localhost.localdomain> <CAFX2JfkLW1RC9T45dN5pzfENQ+LXqF=cxDS7hxGUzaheuH07kQ@mail.gmail.com>
 <Ytqm9azcQfrC4vpG@localhost.localdomain>
In-Reply-To: <Ytqm9azcQfrC4vpG@localhost.localdomain>
From:   Anna Schumaker <anna@kernel.org>
Date:   Fri, 22 Jul 2022 09:43:11 -0400
X-Gmail-Original-Message-ID: <CAFX2Jf=W+1EuWHm=9AhEAYvnjZ45970sNnaYghUBFP-MoDfkWw@mail.gmail.com>
Message-ID: <CAFX2Jf=W+1EuWHm=9AhEAYvnjZ45970sNnaYghUBFP-MoDfkWw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS implementation
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 9:32 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Fri, Jul 22, 2022 at 08:45:13AM -0400, Anna Schumaker wrote:
> > On Thu, Jul 21, 2022 at 4:48 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > >
> > > On Tue, Jul 19, 2022 at 04:46:50PM -0400, Anna Schumaker wrote:
> > > > On Sun, Jul 17, 2022 at 9:16 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > >
> > > > > On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
> > > > > > > On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
> > > > > > >
> > > > > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > > > >
> > > > > > > Rather than relying on the underlying filesystem to tell us where hole
> > > > > > > and data segments are through vfs_llseek(), let's instead do the hole
> > > > > > > compression ourselves. This has a few advantages over the old
> > > > > > > implementation:
> > > > > > >
> > > > > > > 1) A single call to the underlying filesystem through nfsd_readv() means
> > > > > > >   the file can't change from underneath us in the middle of encoding.
> > > > >
> > > > > Hi Anna,
> > > > >
> > > > > I'm assuming you mean the vfs_llseek(SEEK_HOLE) call at the start
> > > > > of nfsd4_encode_read_plus_data() that is used to trim the data that
> > > > > has already been read out of the file?
> > > >
> > > > There is also the vfs_llseek(SEEK_DATA) call at the start of
> > > > nfsd4_encode_read_plus_hole(). They are used to determine the length
> > > > of the current hole or data segment.
> > > >
> > > > >
> > > > > What's the problem with racing with a hole punch here? All it does
> > > > > is shorten the read data returned to match the new hole, so all it's
> > > > > doing is making the returned data "more correct".
> > > >
> > > > The problem is we call vfs_llseek() potentially many times when
> > > > encoding a single reply to READ_PLUS. nfsd4_encode_read_plus() has a
> > > > loop where we alternate between hole and data segments until we've
> > > > encoded the requested number of bytes. My attempts at locking the file
> > > > have resulted in a deadlock since vfs_llseek() also locks the file, so
> > > > the file could change from underneath us during each iteration of the
> > > > loop.
> > > >
> > > > >
> > > > > OTOH, if something allocates over a hole that the read filled with
> > > > > zeros, what's the problem with occasionally returning zeros as data?
> > > > > Regardless, if this has raced with a write to the file that filled
> > > > > that hole, we're already returning stale data/hole information to
> > > > > the client regardless of whether we trim it or not....
> > > > >
> > > > > i.e. I can't see a correctness or data integrity problem here that
> > > > > doesn't already exist, and I have my doubts that hole
> > > > > punching/filling racing with reads happens often enough to create a
> > > > > performance or bandwidth problem OTW. Hence I've really got no idea
> > > > > what the problem that needs to be solved here is.
> > > > >
> > > > > Can you explain what the symptoms of the problem a user would see
> > > > > that this change solves?
> > > >
> > > > This fixes xfstests generic/091 and generic/263, along with this
> > > > reported bug: https://bugzilla.kernel.org/show_bug.cgi?id=215673
> > > > >
> > > > > > > 2) A single call to the underlying filestem also means that the
> > > > > > >   underlying filesystem only needs to synchronize cached and on-disk
> > > > > > >   data one time instead of potentially many speeding up the reply.
> > > > >
> > > > > SEEK_HOLE/DATA doesn't require cached data to be sync'd to disk to
> > > > > be coherent - that's only a problem FIEMAP has (and syncing cached
> > > > > data doesn't fix the TOCTOU coherency issue!).  i.e. SEEK_HOLE/DATA
> > > > > will check the page cache for data if appropriate (e.g. unwritten
> > > > > disk extents may have data in memory over the top of them) instead
> > > > > of syncing data to disk.
> > > >
> > > > For some reason, btrfs on virtual hardware has terrible performance
> > > > numbers when using vfs_llseek() with files that are already in the
> > > > server's cache. I think it had something to do with how they lock
> > > > extents, and some extra work that needs to be done if the file already
> > > > exists in the server's memory but it's been  a few years since I've
> > > > gone into their code to figure out where the slowdown is coming from.
> > > > See this section of my performance results wiki page:
> > > > https://wiki.linux-nfs.org/wiki/index.php/Read_Plus_May_2022#BTRFS_3
> > > >
> > >
> > > I just did this locally, once in my test vm's and once on my continuous
> > > performance testing hardware and I'm not able to reproduce the numbers, so I
> > > think I'm doing something wrong.
> > >
> > > My test is stupid, I just dd a 5gib file, come behind it and punch holes every
> > > other 4k.  Then I umount and remount, SEEK_DATA+SEEK_HOLE through the whole
> > > file, and then do it again so I have uncached and cached.  The numbers I'm
> > > seeing are equivalent to ext4/xfs.  Granted on my VM I had to redo the test
> > > because I had lockdep and other debugging on which makes us look stupid because
> > > of the extent locking stuff, but with it off everything appears normal.
> > >
> > > Does this more or less mirror your testing?  Looking at our code we're not doing
> > > anything inherently stupid, so I'm not entirely sure what could be the problem.
> > > Thanks,
> >
> > I think that's pretty close to what the server is doing with the
> > current code, except the NFS server would also do a read for every
> > data segment it found. I've been using `vmtouch` to make sure the file
> > doesn't get evicted from the server's page cache for my cached data.
> >
>
> I messed with it some more and I can't get it to be slow.  If you trip over
> something like this again just give a shout and I'd be happy to dig in.  Thanks,

Interesting. The only other suggestion I can think of is to try it
over NFS, could be some interaction with how the server is opening
files.

Anna

>
> Josef
