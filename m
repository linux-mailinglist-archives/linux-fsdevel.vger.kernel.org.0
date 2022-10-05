Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF0E5F5BD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 23:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiJEVkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 17:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJEVkx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:40:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6273182742;
        Wed,  5 Oct 2022 14:40:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8EE81F6E6;
        Wed,  5 Oct 2022 21:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665006050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvDPRL3X/Z+TkKSypMGQGSD04xqGO5RubhYnrEX6MMs=;
        b=QgHHXMecqBbSMnfU0knnwzskQDXy4zhWqL4DR/r5H5z1BvLvcZL8Z0NqCf5hQnXLJ9UsJB
        Owwt8GQyQuENDCv6EBp4JN1JSrS+rYhLImoD3cT2n97rMIGPB6pufZuSY+kj2MzhAv1u5f
        ZJyC8y8CdMfYUNq4DZlYs1vM9nKbjE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665006050;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvDPRL3X/Z+TkKSypMGQGSD04xqGO5RubhYnrEX6MMs=;
        b=mtSjx5nrRkv3JWj3hT3OCFo8Bkun3pyYfchcnJzvScIis+p0UMtAEV22XlVgrV46593h3l
        X0iNI1P7ASbpPtCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D09A513ABD;
        Wed,  5 Oct 2022 21:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WNQDItv5PWN+TQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 05 Oct 2022 21:40:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Amir Goldstein" <amir73il@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org,
        brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 8/9] vfs: update times after copying data in
 __generic_file_write_iter
In-reply-to: <66714195b93e05a97c2cd09e5d21ca47203366cf.camel@kernel.org>
References: <20220930111840.10695-1-jlayton@kernel.org>,
 <20220930111840.10695-9-jlayton@kernel.org>,
 <CAOQ4uxgofERYwN7AfYFWqQMpQH5y3LV+6UuGfjU29gZXNf7-vQ@mail.gmail.com>,
 <df91b9ec61bc49aa5330714e3319dcea2531953b.camel@kernel.org>,
 <CAOQ4uxi6pPDexF7Z1wshnpV0kbSKsHUeawaUkhjq4FNGbqWU+A@mail.gmail.com>,
 <166483780286.14457.1388505585556274283@noble.neil.brown.name>,
 <66714195b93e05a97c2cd09e5d21ca47203366cf.camel@kernel.org>
Date:   Thu, 06 Oct 2022 08:40:40 +1100
Message-id: <166500604072.16615.966170222751267937@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 06 Oct 2022, Jeff Layton wrote:
> On Tue, 2022-10-04 at 09:56 +1100, NeilBrown wrote:
> > On Tue, 04 Oct 2022, Amir Goldstein wrote:
> > > On Mon, Oct 3, 2022 at 4:01 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > >=20
> > > > On Sun, 2022-10-02 at 10:08 +0300, Amir Goldstein wrote:
> > > > > On Fri, Sep 30, 2022 at 2:30 PM Jeff Layton <jlayton@kernel.org> wr=
ote:
> > > > > >=20
> > > > > > The c/mtime and i_version currently get updated before the data is
> > > > > > copied (or a DIO write is issued), which is problematic for NFS.
> > > > > >=20
> > > > > > READ+GETATTR can race with a write (even a local one) in such a w=
ay as
> > > > > > to make the client associate the state of the file with the wrong=
 change
> > > > > > attribute. That association can persist indefinitely if the file =
sees no
> > > > > > further changes.
> > > > > >=20
> > > > > > Move the setting of times to the bottom of the function in
> > > > > > __generic_file_write_iter and only update it if something was
> > > > > > successfully written.
> > > > > >=20
> > > > >=20
> > > > > This solution is wrong for several reasons:
> > > > >=20
> > > > > 1. There is still file_update_time() in ->page_mkwrite() so you hav=
en't
> > > > >     solved the problem completely
> > > >=20
> > > > Right. I don't think there is a way to solve the problem vs. mmap.
> > > > Userland can write to a writeable mmap'ed page at any time and we'd
> > > > never know. We have to specifically carve out mmap as an exception he=
re.
> > > > I'll plan to add something to the manpage patch for this.
> > > >=20
> > > > > 2. The other side of the coin is that post crash state is more like=
ly to end
> > > > >     up data changes without mtime/ctime change
> > > > >=20
> > > >=20
> > > > Is this really something filesystems rely on? I suppose the danger is
> > > > that some cached data gets written to disk before the write returns a=
nd
> > > > the inode on disk never gets updated.
> > > >=20
> > > > But...isn't that a danger now? Some of the cached data could get writ=
ten
> > > > out and the updated inode just never makes it to disk before a crash
> > > > (AFAIU). I'm not sure that this increases our exposure to that proble=
m.
> > > >=20
> > > >=20
> > >=20
> > > You are correct that that danger exists, but it only exists for overwri=
ting
> > > to allocated blocks.
> > >=20
> > > For writing to new blocks, mtime change is recorded in transaction
> > > before the block mapping is recorded in transaction so there is no
> > > danger in this case (before your patch).
> > >=20
> > > Also, observing size change without observing mtime change
> > > after crash seems like a very bad outcome that may be possible
> > > after your change.
> > >=20
> > > These are just a few cases that I could think of, they may be filesystem
> > > dependent, but my gut feeling is that if you remove the time update bef=
ore
> > > the operation, that has been like that forever, a lot of s#!t is going =
to float
> > > for various filesystems and applications.
> > >=20
> > > And it is not one of those things that are discovered  during rc or even
> > > stable kernel testing - they are discovered much later when users start=
 to
> > > realize their applications got bogged up after crash, so it feels like =
to me
> > > like playing with fire.
> > >=20
> > > > > If I read the problem description correctly, then a solution that i=
nvalidates
> > > > > the NFS cache before AND after the write would be acceptable. Right?
> > > > > Would an extra i_version bump after the write solve the race?
> > > > >=20
> > > >=20
> > > > I based this patch on Neil's assertion that updating the time before =
an
> > > > operation was pointless if we were going to do it afterward. The NFS
> > > > client only really cares about seeing it change after a write.
> > > >=20
> > >=20
> > > Pointless to NFS client maybe.
> > > Whether or not this is not changing user behavior for other applications
> > > is up to you to prove and I doubt that you can prove it because I doubt
> > > that it is true.
> > >=20
> > > > Doing both would be fine from a correctness standpoint, and in most
> > > > cases, the second would be a no-op anyway since a query would have to
> > > > race in between the two for that to happen.
> > > >=20
> > > > FWIW, I think we should update the m/ctime and version at the same ti=
me.
> > > > If the version changes, then there is always the potential that a tim=
er
> > > > tick has occurred. So, that would translate to a second call to
> > > > file_update_time in here.
> > > >=20
> > > > The downside of bumping the times/version both before and after is th=
at
> > > > these are hot codepaths, and we'd be adding extra operations there. E=
ven
> > > > in the case where nothing has changed, we'd have to call
> > > > inode_needs_update_time a second time for every write. Is that worth =
the
> > > > cost?
> > >=20
> > > Is there a practical cost for iversion bump AFTER write as I suggested?
> > > If you NEED m/ctime update AFTER write and iversion update is not enough
> > > then I did not understand from your commit message why that is.
> > >=20
> > > Thanks,
> > > Amir.
> > >=20
> >=20
> > Maybe we should split i_version updates from ctime updates.
> >=20
> > While it isn't true that ctime updates have happened before the write
> > "forever" it has been true since 2.3.43[1] which is close to forever.
> >=20
> > For ctime there doesn't appear to be a strong specification of when the
> > change happens, so history provides a good case for leaving it before.
> > For i_version we want to provide clear and unambiguous semantics.
> > Performing 2 updates makes the specification muddy.
> >=20
> > So I would prefer a single update for i_version, performed after the
> > change becomes visible.  If that means it has to be separate from ctime,
> > then so be it.
> >=20
> > NeilBrown
> >=20
> >=20
> > [1]:  https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git=
/commit/?id=3D636b38438001a00b25f23e38747a91cb8428af29
>=20
>=20
> Not necessarily. We can document it in such a way that bumping it twice
> is allowed, but not required.
>=20
> My main concern with splitting them up is that we'd have to dirty the
> inode twice if both the times and the i_version need updating. If the
> inode gets written out in between, then we end up doing twice the I/O.
> The interim on-disk metadata would be in sort of a weird state too --
> the ctime would have changed but the version would still be old.
>=20
> It might be worthwhile to just go ahead and continue bumping it in
> file_update_time, and then we'd just attempt to bump the i_version again
> afterward. The second bump will almost always be a no-op anyway.

I"m probably starting to sound like a scratched record here, but this is
why I think it should be up to the filesystem to bump i_version when it
determines that it should.  It should be in a position to include the
i_version update any time that it writes the inode and so avoid a double
write.

Having that vfs/mm do so much of the work makes it hard for the
filesystem to do the right amount of work.  The common code should
provide libraries of useful code, the filesystems should call that as
appropriate. Some of our code is structured that way, some of it isn't.

Most callers of file_update_time() are inside filesystems and that is
good - they are in control.
There are 3 in mm/*.c.  Those are all in callbacks from the filesystem,
so the fs could avoid them, but only by duplicating lots of code to
avoid using the callback.  Instead these file_update_time() calls should
become more explicit calls into the filesystem telling the filesystem
what has just happened, or is about to happen.  Then the filesystem can
do the right thing, rather than having something done to it.

See also https://lwn.net/Articles/336262/ and the "midlayer mistake".

But yes, doing the bump afterwards as well is likely to be a no-op most
of the time and is probably the easy solution.  Ugly, but easy.

NeilBrown
