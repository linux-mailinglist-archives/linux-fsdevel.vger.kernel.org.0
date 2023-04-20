Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F087D6E9557
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 15:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjDTNFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 09:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDTNFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:05:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B63EB;
        Thu, 20 Apr 2023 06:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3472B60B4F;
        Thu, 20 Apr 2023 13:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3055C433D2;
        Thu, 20 Apr 2023 13:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681995949;
        bh=ZS++EC2ddHGw6CtXpFobrGkExenVq2f7jO1x6BrTC8A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MzsvpLBG4B5g1plf4D+9aF6l1cITnitV2Vjklv60EHSq34ar34bVZIzMpNjlxAFiI
         xa1mQLyAcpZpFhjxmpC3/PzIzGQFTwRGd8DqWqkN3eEsp4xaUosmKAXrh8fYJtr22R
         jN5S+OLIhPKmqbz4VTTXGpBSrwreE+QyjBN9enEBSCWB+kfKr+SWhlj8tZrj3Q64p9
         y+Ofql4AUUjwJ1++f6ZzNEB60PmbzEIcyriEsMkGZMLBpntvyP70I41dtE0AIlxjHa
         zl73acFBcV7SAIRNjmerpUY2xIVhSbtTDguVK6xXPLC+qydlnItWQEfZ9omSz2JF6h
         5HVwzsjxT9RDw==
Message-ID: <94b793956c464ccccbaf064f6d18f1821801c140.camel@kernel.org>
Subject: Re: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info
 whenever possible.
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Andreas Dilger <adilger@dilger.ca>
Cc:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Karel Zak <kzak@redhat.com>
Date:   Thu, 20 Apr 2023 09:05:47 -0400
In-Reply-To: <20230418-windrad-bezahlbar-0ef93bef8f3f@brauner>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
         <168168683217.24821.6260957092725278201@noble.neil.brown.name>
         <20230417-beisein-investieren-360fa20fb68a@brauner>
         <6c08ad94ca949d0f3525f7e1fc24a72c50affd59.camel@kernel.org>
         <20230417-relaxen-selektiert-4b4b4143d7f6@brauner>
         <85774a5de74b2b7828c8b8f7e041f0e9e2bc6094.camel@kernel.org>
         <1AC965F2-BAC6-4D0F-A2A6-C414CDF110AF@dilger.ca>
         <20230418-windrad-bezahlbar-0ef93bef8f3f@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-04-18 at 10:04 +0200, Christian Brauner wrote:
> On Mon, Apr 17, 2023 at 09:25:20PM -0600, Andreas Dilger wrote:
> >=20
> > > On Apr 17, 2023, at 9:21 AM, Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > On Mon, 2023-04-17 at 16:24 +0200, Christian Brauner wrote:
> > > > And I'm curious why is it obvious that we don't want to revalidate =
_any_
> > > > path component and not just the last one? Why is that generally saf=
e?
> > > > Why can't this be used to access files and directories the caller
> > > > wouldn't otherwise be able to access? I would like to have this spe=
lled
> > > > out for slow people like me, please.
> > > >=20
> > > > From my point of view, this would only be somewhat safe _generally_=
 if
> > > > you'd allow circumvention for revalidation and permission checking =
if
> > > > MNT_FORCE is specified and the caller has capable(CAP_DAC_READ_SEAR=
CH).
> > > > You'd still mess with overlayfs permission model in this case thoug=
h.
> > > >=20
> > > > Plus, there are better options of solving this problem. Again, I'd
> > > > rather build a separate api for unmounting then playing such potent=
ially
> > > > subtle security sensitive games with permission checking during pat=
h
> > > > lookup.
> > >=20
> > > umount(2) is really a special case because the whole intent is to det=
ach
> > > a mount from the local hierarchy and stop using it. The unfortunate b=
it
> > > is that it is a path-based syscall.
> > >=20
> > > So usually we have to:
> > >=20
> > > - determine the path: Maybe stat() it and to validate that it's the
> > >   mountpoint we want to drop
> >=20
> > The stat() itself may hang because a remote server, or USB stick is
> > inaccessible or having media errors.
> >=20
> > I've just been having a conversation with Karel Zak to change
> > umount(1) to use statx() so that it interacts minimally with the fs.
>=20
> So we're talking about this commit:
> https://github.com/util-linux/util-linux/commit/42e141d20505a0deb969c2e58=
3a463c26aadc62f
> and the patch we discussed here:
> https://github.com/util-linux/util-linux/issues/2049
>=20
> >=20
> > In particular, nfs_getattr() skips revalidate if only minimal attrs
> > are fetched (STATX_TYPE | STATX_INO), and also skips revalidate if
> > locally-cached attrs are still valid (STATX_MODE), so this will
> > avoid yet one more place that unmount can hang.
> >=20
> > In theory, vfs_getattr() could get all of these attributes directly
> > from the vfs_inode in the unmount case.
>=20
> We don't really need that. As pointed out in that discussion and as
> Karel did we just want to pass AT_STATX_DONT_SYNC.
>=20
> An api that would allow unmounting by mount id can safely check and
> retrieve AT_STATX_DONT_SYNC with STATX_ATTR_MOUNT_ROOT and STATX_MNT_ID
> without ever syncing with the server.

Unfortunately, I don't think that flag trickles down to the ->permission
checks for the pathwalk down to the point you're stat'ing. That turns
out to be a big part of the problem when trying to umount things that
are stuck down in inaccessible trees.

I'm not opposed at all to new APIs that allow for more reliable
unmounting. I think that's a good idea, and something worth hashing out.

But...we're stuck with umount() in perpetuity. Even if you were to merge
a new API for unmounting today, it'll be a decade or more until the
ecosystem catches up. I think we have a responsibility to make the
umount syscall work as well as we can. In this case, that means giving
it as light a footprint as possible on the pathwalk down.

If we need to gate this behavior behind existing or new flags to
umount2(), then so be it, but lets not dismiss this idea in favor of
some new unmounting interface that may never materialize. Improving
umount has the potential to help a lot of our users.

--=20
Jeff Layton <jlayton@kernel.org>
