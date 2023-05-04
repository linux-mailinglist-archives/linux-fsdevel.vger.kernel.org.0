Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8BB6F70C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 19:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjEDRVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 13:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjEDRVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 13:21:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A01C1722
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 10:21:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0743C62A19
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 17:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B39C433D2;
        Thu,  4 May 2023 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683220903;
        bh=vsQm+9kYmbS+TUkz0VNvPI1q2QeD7+HVGe6nYdvoKps=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hEmK/mQ1KFd2Ogv2d7iqnWOkLXDNwAfDjlXfeA19sCD2DqtTt1y+hWitUa14HcsNu
         32JSpuoCqSQFWKRiMmjFYno1n0Z9a7BhjACOBgtK1g9XbdglXNBfYgK2rh77vLGHap
         xl/9DQK1ep/Vp9OI/1tu3JgInMP3RqEHUTIQmf7akMwFX04Hq6FmwjVoxqQkf+j2gz
         IqMUojE8L9k75lUxassF+TBaB5fcJaCJiohX7ikNJebcLBLomS+dWPqli1xYTaC7F9
         Hu2b1fdoHJgjspCFIuXcRt32XZL1ORm2yVEGJspoKZX//Gb8L+3mAUzSLH9Axhbf63
         wtg0Uu23f0+AQ==
Message-ID: <cbd955c08432a82014cc21f36e42afc67962a718.camel@kernel.org>
Subject: Re: [PATCH v1] shmem: stable directory cookies
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chuck Lever <cel@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Date:   Thu, 04 May 2023 13:21:41 -0400
In-Reply-To: <30E5A657-4005-4126-A962-A8E6D90240AB@oracle.com>
References: <168175931561.2843.16288612382874559384.stgit@manet.1015granger.net>
         <20230502171228.57a906a259172d39542e92fb@linux-foundation.org>
         <30E5A657-4005-4126-A962-A8E6D90240AB@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-05-03 at 00:43 +0000, Chuck Lever III wrote:
>=20
> > On May 2, 2023, at 8:12 PM, Andrew Morton <akpm@linux-foundation.org> w=
rote:
> >=20
> > On Mon, 17 Apr 2023 15:23:10 -0400 Chuck Lever <cel@kernel.org> wrote:
> >=20
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >=20
> > > The current cursor-based directory cookie mechanism doesn't work
> > > when a tmpfs filesystem is exported via NFS. This is because NFS
> > > clients do not open directories: each READDIR operation has to open
> > > the directory on the server, read it, then close it. The cursor
> > > state for that directory, being associated strictly with the opened
> > > struct file, is then discarded.
> > >=20
> > > Directory cookies are cached not only by NFS clients, but also by
> > > user space libraries on those clients. Essentially there is no way
> > > to invalidate those caches when directory offsets have changed on
> > > an NFS server after the offset-to-dentry mapping changes.
> > >=20
> > > The solution we've come up with is to make the directory cookie for
> > > each file in a tmpfs filesystem stable for the life of the directory
> > > entry it represents.
> > >=20
> > > Add a per-directory xarray. shmem_readdir() uses this to map each
> > > directory offset (an loff_t integer) to the memory address of a
> > > struct dentry.
> > >=20
> >=20
> > How have people survived for this long with this problem?
>=20
> It's less of a problem without NFS in the picture; local
> applications can hold the directory open, and that preserves
> the seek cursor. But you can still trigger it.
>=20
> Also, a plurality of applications are well-behaved in this
> regard. It's just the more complex and more useful ones
> (like git) that seem to trigger issues.
>=20
> It became less bearable for NFS because of a recent change
> on the Linux NFS client to optimize directory read behavior:
>=20
> 85aa8ddc3818 ("NFS: Trigger the "ls -l" readdir heuristic sooner")
>=20
> Trond argued that tmpfs directory cookie behavior has always
> been problematic (eg broken) therefore this commit does not
> count as a regression. However, it does make tmpfs exports
> less usable, breaking some tests that have always worked.
>=20
>=20
> > It's a lot of new code -
>=20
> I don't feel that this is a lot of new code:
>=20
> include/linux/shmem_fs.h |    2=20
> mm/shmem.c               |  213 +++++++++++++++++++++++++++++++++++++++++=
++---
> 2 files changed, 201 insertions(+), 14 deletions(-)
>=20
> But I agree it might look a little daunting on first review.
> I am happy to try to break this single patch up or consider
> other approaches.
>=20

I wonder whether you really need an xarray here?

dcache_readdir walks the d_subdirs list. We add things to d_subdirs at
d_alloc time (and in d_move). If you were to assign its dirindex when
the dentry gets added to d_subdirs (maybe in ->d_init?) then you'd have
a list already ordered by index, and could deal with missing indexes
easily.

It's not as efficient as the xarray if you have to seek through a big
dir, but if keeping the changes tiny is a goal then that might be
another way to do this.

> We could, for instance, tuck a little more of this into
> lib/fs. Copying the readdir and directory seeking
> implementation from simplefs to tmpfs is one reason
> the insertion count is worrisome.
>=20
>=20
> > can we get away with simply disallowing
> > exports of tmpfs?
>=20
> I think the bottom line is that you /can/ trigger this
> behavior without NFS, just not as quickly. The threshold
> is high enough that most use cases aren't bothered by
> this right now.
>=20
> We'd rather not disallow exporting tmpfs. It's a very
> good testing platform for us, and disallowing it would
> be a noticeable regression for some folks.
>=20
>=20

Yeah, I'd not be in favor of that either. We've had an exportable tmpfs
for a long time. It's a good way to do testing of the entire NFS server
stack, without having to deal with underlying storage.

> > How can we maintain this?  Is it possible to come up with a test
> > harness for inclusion in kernel selftests?
>=20
> There is very little directory cookie testing that I know of
> in the obvious place: fstests. That would be where this stuff
> should be unit tested, IMO.
>=20

I'd like to see this too. It's easy for programs to get this wrong. In
this case, could we emulate the NFS behavior by doing this in a loop
over a large directory?

opendir
seekdir (to result of last telldir)
readdir
unlink
telldir
closedir

At the end of it, check whether there are any entries left over.
--=20
Jeff Layton <jlayton@kernel.org>
