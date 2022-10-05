Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9325F5871
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJEQk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 12:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJEQk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:40:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE7F20356;
        Wed,  5 Oct 2022 09:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0FA0B81DE0;
        Wed,  5 Oct 2022 16:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E3EC433D6;
        Wed,  5 Oct 2022 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664988022;
        bh=PFLhkFtwkoFOvEH1cLHwmK2JKBgWdlPw1bvH2RLTQS8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M+QxPavX/Wlovs2EPzg2SZ1esj4fmGj0ZmvQ3FhBVmGprs3Jxml3XOq95uMdt+Mqz
         VWLkvXn5NHEO2utNC6f31e7iZv9vn8sXdQFmPEjUxmVQyxqHCMLShMv+sjAvulnfE3
         K2aA2/0urEAUWbh/6LGrZFgU3DoMSGPQ6YdsuV15/i8VRuze/1vsTmnKcF45y8DEq+
         QF3/ZwvNUf+LegLBGXsDappNcIHH0BZM5OmwhAPGLEwbdmk/Jyb1xE1MzmyTYJCU+D
         zWi5UEj+zAM5SsH9dZBHc/4GMGziiZwGiiHKAwDEg7lqo2HzbbWQm5Wfd3XEtWE6zK
         RbxSVjsJW0/aw==
Message-ID: <66714195b93e05a97c2cd09e5d21ca47203366cf.camel@kernel.org>
Subject: Re: [PATCH v6 8/9] vfs: update times after copying data in
 __generic_file_write_iter
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Amir Goldstein <amir73il@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Wed, 05 Oct 2022 12:40:18 -0400
In-Reply-To: <166483780286.14457.1388505585556274283@noble.neil.brown.name>
References: <20220930111840.10695-1-jlayton@kernel.org>
        , <20220930111840.10695-9-jlayton@kernel.org>
        , <CAOQ4uxgofERYwN7AfYFWqQMpQH5y3LV+6UuGfjU29gZXNf7-vQ@mail.gmail.com>
        , <df91b9ec61bc49aa5330714e3319dcea2531953b.camel@kernel.org>
        , <CAOQ4uxi6pPDexF7Z1wshnpV0kbSKsHUeawaUkhjq4FNGbqWU+A@mail.gmail.com>
         <166483780286.14457.1388505585556274283@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-10-04 at 09:56 +1100, NeilBrown wrote:
> On Tue, 04 Oct 2022, Amir Goldstein wrote:
> > On Mon, Oct 3, 2022 at 4:01 PM Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > On Sun, 2022-10-02 at 10:08 +0300, Amir Goldstein wrote:
> > > > On Fri, Sep 30, 2022 at 2:30 PM Jeff Layton <jlayton@kernel.org> wr=
ote:
> > > > >=20
> > > > > The c/mtime and i_version currently get updated before the data i=
s
> > > > > copied (or a DIO write is issued), which is problematic for NFS.
> > > > >=20
> > > > > READ+GETATTR can race with a write (even a local one) in such a w=
ay as
> > > > > to make the client associate the state of the file with the wrong=
 change
> > > > > attribute. That association can persist indefinitely if the file =
sees no
> > > > > further changes.
> > > > >=20
> > > > > Move the setting of times to the bottom of the function in
> > > > > __generic_file_write_iter and only update it if something was
> > > > > successfully written.
> > > > >=20
> > > >=20
> > > > This solution is wrong for several reasons:
> > > >=20
> > > > 1. There is still file_update_time() in ->page_mkwrite() so you hav=
en't
> > > >     solved the problem completely
> > >=20
> > > Right. I don't think there is a way to solve the problem vs. mmap.
> > > Userland can write to a writeable mmap'ed page at any time and we'd
> > > never know. We have to specifically carve out mmap as an exception he=
re.
> > > I'll plan to add something to the manpage patch for this.
> > >=20
> > > > 2. The other side of the coin is that post crash state is more like=
ly to end
> > > >     up data changes without mtime/ctime change
> > > >=20
> > >=20
> > > Is this really something filesystems rely on? I suppose the danger is
> > > that some cached data gets written to disk before the write returns a=
nd
> > > the inode on disk never gets updated.
> > >=20
> > > But...isn't that a danger now? Some of the cached data could get writ=
ten
> > > out and the updated inode just never makes it to disk before a crash
> > > (AFAIU). I'm not sure that this increases our exposure to that proble=
m.
> > >=20
> > >=20
> >=20
> > You are correct that that danger exists, but it only exists for overwri=
ting
> > to allocated blocks.
> >=20
> > For writing to new blocks, mtime change is recorded in transaction
> > before the block mapping is recorded in transaction so there is no
> > danger in this case (before your patch).
> >=20
> > Also, observing size change without observing mtime change
> > after crash seems like a very bad outcome that may be possible
> > after your change.
> >=20
> > These are just a few cases that I could think of, they may be filesyste=
m
> > dependent, but my gut feeling is that if you remove the time update bef=
ore
> > the operation, that has been like that forever, a lot of s#!t is going =
to float
> > for various filesystems and applications.
> >=20
> > And it is not one of those things that are discovered  during rc or eve=
n
> > stable kernel testing - they are discovered much later when users start=
 to
> > realize their applications got bogged up after crash, so it feels like =
to me
> > like playing with fire.
> >=20
> > > > If I read the problem description correctly, then a solution that i=
nvalidates
> > > > the NFS cache before AND after the write would be acceptable. Right=
?
> > > > Would an extra i_version bump after the write solve the race?
> > > >=20
> > >=20
> > > I based this patch on Neil's assertion that updating the time before =
an
> > > operation was pointless if we were going to do it afterward. The NFS
> > > client only really cares about seeing it change after a write.
> > >=20
> >=20
> > Pointless to NFS client maybe.
> > Whether or not this is not changing user behavior for other application=
s
> > is up to you to prove and I doubt that you can prove it because I doubt
> > that it is true.
> >=20
> > > Doing both would be fine from a correctness standpoint, and in most
> > > cases, the second would be a no-op anyway since a query would have to
> > > race in between the two for that to happen.
> > >=20
> > > FWIW, I think we should update the m/ctime and version at the same ti=
me.
> > > If the version changes, then there is always the potential that a tim=
er
> > > tick has occurred. So, that would translate to a second call to
> > > file_update_time in here.
> > >=20
> > > The downside of bumping the times/version both before and after is th=
at
> > > these are hot codepaths, and we'd be adding extra operations there. E=
ven
> > > in the case where nothing has changed, we'd have to call
> > > inode_needs_update_time a second time for every write. Is that worth =
the
> > > cost?
> >=20
> > Is there a practical cost for iversion bump AFTER write as I suggested?
> > If you NEED m/ctime update AFTER write and iversion update is not enoug=
h
> > then I did not understand from your commit message why that is.
> >=20
> > Thanks,
> > Amir.
> >=20
>=20
> Maybe we should split i_version updates from ctime updates.
>=20
> While it isn't true that ctime updates have happened before the write
> "forever" it has been true since 2.3.43[1] which is close to forever.
>=20
> For ctime there doesn't appear to be a strong specification of when the
> change happens, so history provides a good case for leaving it before.
> For i_version we want to provide clear and unambiguous semantics.
> Performing 2 updates makes the specification muddy.
>=20
> So I would prefer a single update for i_version, performed after the
> change becomes visible.  If that means it has to be separate from ctime,
> then so be it.
>=20
> NeilBrown
>=20
>=20
> [1]:  https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git=
/commit/?id=3D636b38438001a00b25f23e38747a91cb8428af29


Not necessarily. We can document it in such a way that bumping it twice
is allowed, but not required.

My main concern with splitting them up is that we'd have to dirty the
inode twice if both the times and the i_version need updating. If the
inode gets written out in between, then we end up doing twice the I/O.
The interim on-disk metadata would be in sort of a weird state too --
the ctime would have changed but the version would still be old.

It might be worthwhile to just go ahead and continue bumping it in
file_update_time, and then we'd just attempt to bump the i_version again
afterward. The second bump will almost always be a no-op anyway.
--=20
Jeff Layton <jlayton@kernel.org>
