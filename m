Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF35981E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 13:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbiHRLDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 07:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244250AbiHRLDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1F932D8E;
        Thu, 18 Aug 2022 04:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96B5614A9;
        Thu, 18 Aug 2022 11:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E66C433D7;
        Thu, 18 Aug 2022 11:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660820624;
        bh=o2Ny5UVyamhrQDusoaKLIxn3yy1wtvQZpQSM8GQ/8n4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QZsgOlKXomMKTY7guD6pHV5RzkU65A0+anpcrqcTDb9Q9mQX38LEck7WXo8wNGxb+
         mXTlC0yiHxiDlHPfeAw8c1XobYvO8uJuJ2AVJtcy/uXQsj3wyHhza7X3hpUHcuQ1Mm
         PXotXrAh1WJtvkC8gridz8a4weHvZTnkDv+T2DsiFmNeiMNZ/TC8K8Hn39D5dRE64d
         DEsbaCwVIA2f02amo6AAOHcA5CqIJ99qDPhiFR3k+IeyQHF/KslX5CCirMayzjeDiH
         R53V5TNcGrXX1BL+Isly3IxhIcKQkz5HZFJJgY2q/2B2q3ArbRoTPt6N5SEdQGUb3p
         g7VVMH/AXFBCA==
Message-ID: <b8cf4464cc31dc262a2d38e66265c06bf1e35751.camel@kernel.org>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Cc:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Date:   Thu, 18 Aug 2022 07:03:42 -0400
In-Reply-To: <0e41fb378e57794ab2a8a714b44ef92733598e8e.camel@hammerspace.com>
References: <20220816131736.42615-1-jlayton@kernel.org>
         <Yvu7DHDWl4g1KsI5@magnolia>
         <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
         <20220816224257.GV3600936@dread.disaster.area>
         <c61568de755fc9cd70c80c23d63c457918ab4643.camel@hammerspace.com>
         <20220818033731.GF3600936@dread.disaster.area>
         <0e41fb378e57794ab2a8a714b44ef92733598e8e.camel@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-08-18 at 04:15 +0000, Trond Myklebust wrote:
> On Thu, 2022-08-18 at 13:37 +1000, Dave Chinner wrote:
> > On Thu, Aug 18, 2022 at 01:11:09AM +0000, Trond Myklebust wrote:
> > > On Wed, 2022-08-17 at 08:42 +1000, Dave Chinner wrote:
> > > >=20
> > > > In XFS, we've defined the on-disk i_version field to mean
> > > > "increments with any persistent inode data or metadata change",
> > > > regardless of what the high level applications that use i_version
> > > > might actually require.
> > > >=20
> > > > That some network filesystem might only need a subset of the
> > > > metadata to be covered by i_version is largely irrelevant - if we
> > > > don't cover every persistent inode metadata change with
> > > > i_version,
> > > > then applications that *need* stuff like atime change
> > > > notification
> > > > can't be supported.
> > >=20
> > > OK, I'll bite...
> > >=20
> > > What real world application are we talking about here, and why
> > > can't it
> > > just read both the atime + i_version if it cares?
> >=20
> > The whole point of i_version is that the aplication can skip the
> > storage and comparison of individual metadata fields to determine if
> > anythign changed. If you're going to store multiple fields and
> > compare them all in addition to the change attribute, then what is
> > the change attribute actually gaining you?
>=20
> Information that is not contained in the fields themselves. Such as
> metadata about the fact that they were explicitly changed by an
> application.
>=20
> >=20
> > > The value of the change attribute lies in the fact that it gives
> > > you
> > > ctime semantics without the time resolution limitation.
> > > i.e. if the change attribute has changed, then you know that
> > > someone
> > > has explicitly modified either the file data or the file metadata
> > > (with
> > > the emphasis being on the word "explicitly").
> > > Implicit changes such as the mtime change due to a write are
> > > reflected
> > > only because they are necessarily also accompanied by an explicit
> > > change to the data contents of the file.
> > > Implicit changes, such as the atime changes due to a read are not
> > > reflected in the change attribute because there is no explicit
> > > change
> > > being made by an application.
> >=20
> > That's the *NFSv4 requirements*, not what people were asking XFS to
> > support in a persistent change attribute 10-15 years ago. What NFS
> > required was just one of the inputs at the time, and what we
> > implemented has kept NFSv4 happy for the past decade. I've mentioned
> > other requirements elsewhere in the thread
>=20
> NFS can work with a change attribute that tells it to invalidate its
> cache on every read. The only side effect will be that the performance
> graph will act as if you were filtering it through a cow's digestive
> system...
>=20
> > The problem we're talking about here is essentially a relatime
> > filtering issue; it's triggering an filesystem update because the
> > first access after a modification triggers an on-disk atime update
> > rahter than just storing it in memory.
>=20
> No. It's not... You appear to be discarding valuable information about
> why the attributes changed. I've been asking you for reasons why, and
> you're avoiding the question.
>=20
> > This is not a filesystem issue - the VFS controls when the on-disk
> > updates occur, and that what NFSv4 appears to need changed.
> > If NFS doesn't want the filesystem to bump change counters for
> > on-disk atime updates, then it should be asking the VFS to keep the
> > atime updates in memory. e.g. use lazytime semantics.
> >=20
> > This way, every filesystem will have the same behaviour, regardless
> > of how they track/store persistent change count metadata.
>=20
> Right now, the i_version updates are not exported via any common API,
> so any piss poor performance side-effects of the implementation are
> pretty much limited to the kernel users (NFS and... ???)
>=20
> Who do you expect to use this attribute if it were to be exported via
> statx() as Jeff is proposing, and why is the XFS behaviour appropriate?
> It already differs from the behaviour of both btrfs and NFS, so the
> argument that this will magically consolidate behaviour can be ignored.
>=20

Thanks Trond,

That's been exactly the point I've been trying to make. The _only_
consumers of i_version at this time are the kernel's NFS server and IMA.
Both of them will still work with the i_version being updated due to
atime updates, but their performance suffers.

The change I'm proposing should bring xfs in line with other providers
of i_version as well. btrfs already behaves correctly, and I have a
proposed patch for ext4 which should fix it. The ext4 devs seem amenable
to it so far.

Dave, you keep talking about the xfs i_version counter as if there are
other applications already relying on its behavior, but I don't see how
that can be. There is no way for userland applications to fetch the
counter currently.
--=20
Jeff Layton <jlayton@kernel.org>
