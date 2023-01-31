Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7C3682C20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 13:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAaMDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 07:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAaMDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:03:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BAEA26A;
        Tue, 31 Jan 2023 04:02:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 158D2614DA;
        Tue, 31 Jan 2023 12:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EA8C433EF;
        Tue, 31 Jan 2023 12:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675166578;
        bh=O4jn1ROgjCGd5cTUgGaKd96V0XhiaJ98M03oi8hs864=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qKbCElccjpVmjq9BfXw7OAEY5lDFIIzbwSuxpAtO5UlDJ7NQaX5a6nXwCawBoqlVc
         5UP+Jz0dhrjCPLXlSp57eIU3TXXtLpNJnn2kRPYhwskRYIQLKXNRhyUfdUMtYxqY/o
         zb5HXA7l7OmTb+IdW5YZpD7etGJ+jjTcRhlh7g1xD8Y44582exD6lfwCtu3b/m5jWv
         lJQ+Hr0t8NwUX8iGw7zHQK+Bdoh4egysD2OlcdlmuSlk2Z2z3ynzY0WJ9oqdRDpTwT
         uQdTsiKUNS4aGQLHCJfkrmVq6kDD4EjoP4jM5GNb4Btneg8KBd2qxAqhNFmLMNpPCz
         HGHb6OtyAtGow==
Message-ID: <619f0cd76d739ade3249ea4433943264d1737ab2.camel@kernel.org>
Subject: Re: replacement i_version counter for xfs
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 31 Jan 2023 07:02:56 -0500
In-Reply-To: <20230130020525.GO360264@dread.disaster.area>
References: <57c413ed362c0beab06b5d83b7fc4b930c7662c4.camel@kernel.org>
         <20230125000227.GM360264@dread.disaster.area>
         <86f993a69a5be276164c4d3fc1951ff4bde881be.camel@kernel.org>
         <Y9FZupBCyPGCMFBd@magnolia>
         <4d16f9f9eb678f893d4de695bd7cbff6409c3c5a.camel@kernel.org>
         <20230130020525.GO360264@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-01-30 at 13:05 +1100, Dave Chinner wrote:
> On Wed, Jan 25, 2023 at 12:58:08PM -0500, Jeff Layton wrote:
> > On Wed, 2023-01-25 at 08:32 -0800, Darrick J. Wong wrote:
> > > On Wed, Jan 25, 2023 at 06:47:12AM -0500, Jeff Layton wrote:
> > > > Note that there are two other lingering issues with i_version. Neit=
her
> > > > of these are xfs-specific, but they may inform the changes you want=
 to
> > > > make there:
> > > >=20
> > > > 1/ the ctime and i_version can roll backward on a crash.
> > > >=20
> > > > 2/ the ctime and i_version are both currently updated before write =
data
> > > > is copied to the pagecache. It would be ideal if that were done
> > > > afterward instead. (FWIW, I have some draft patches for btrfs and e=
xt4
> > > > for this, but they need a lot more testing.)
> > >=20
> > > You might also want some means for xfs to tell the vfs that it alread=
y
> > > did the timestamp update (because, say, we had to allocate blocks).
> > > I wonder what people will say when we have to run a transaction befor=
e
> > > the write to peel off suid bits and another one after to update ctime=
.
> > >=20
> >=20
> > That's a great question! There is a related one too once I started
> > looking at this in more detail:
> >=20
> > Most filesystems end up updating the timestamp via a the call to
> > file_update_time in __generic_file_write_iter. Today, that's called ver=
y
> > early in the function and if it fails, the write fails without changing
> > anything.
> >=20
> > What do we do now if the write succeeds, but update_time fails? We don'=
t
>=20
> On XFS, the timestamp update will either succeed or cause the
> filesystem to shutdown as a failure with a dirty transaction is a
> fatal, unrecoverable error.
>=20

Ok. So for xfs, we could move all of this to be afterward. Clearing
setuid bits is quite rare, so that would only rarely require a
transaction (in principle).

> > want to return an error on the write() since the data did get copied in=
.
> > Ignoring it seems wrong too though. There could even be some way to
> > exploit that by changing the contents while holding the timestamp and
> > version constant.
>=20
> If the filesystem has shut down, it doesn't matter that the data got
> copied into the kernel - it's never going to make it to disk and
> attempts to read it back will also fail. There's nothing that can be
> exploited by such a failure on XFS - it's game over for everyone
> once the fs has shut down....
>=20
> > At this point I'm leaning toward leaving the ctime and i_version to be
> > updated before the write, and just bumping the i_version a second time
> > after. In most cases the second bump will end up being a no-op, unless
> > an i_version query races in between.
>=20
> Why not also bump ctime at write completion if a query races with
> the write()? Wouldn't that put ns-granularity ctime based change
> detection on a par with i_version?
>=20
> Userspace isn't going to notice the difference - the ctime they
> observe indicates that it was changed during the syscall. So
> who/what is going to care if we bump ctime twice in the syscall
> instead of just once in this rare corner case?
>=20

We could bump the ctime too in this situation, but it would be more
costly. In most cases the i_version bump will be a no-op. The only
exception would be when a query of i_version races in between the two
bumps. That wouldn't be the case with the ctime, which would almost
always require a second transaction.

--=20
Jeff Layton <jlayton@kernel.org>
