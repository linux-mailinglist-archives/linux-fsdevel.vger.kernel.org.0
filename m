Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5306B5A9D19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 18:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiIAQab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiIAQa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288F54054F;
        Thu,  1 Sep 2022 09:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B533C61FA4;
        Thu,  1 Sep 2022 16:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED73BC433C1;
        Thu,  1 Sep 2022 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662049824;
        bh=IJ0PCR/aHRiRVBBTIlB2iYhCXtiktwtTDXekHNHskb8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ag+0p/y9MHRUC6ul4TWQLjIrJ+7XAHSbClMDLdLD9e/Huey6Weo5MYuoX/3mugA8X
         0k12yUDgSByRh22zychlAHEV3/q5J+hDBBb+SNSGusbGhr2SoxVqwW3Se1GFECa0Rb
         /hbHFqRNJsPkNmgZydl/Sa4lCR9tprV6kXjW3f6sE5LrZNyfvrqXjxV/fBrhz2qaq9
         Yr+MwcBrLcLT5ia5nhq2C2d0km7Mp8ywszbpYXLNMHzSQCm+S48owcryMD6DdWjRE7
         PQlyGD8bVFJM5NN1qVzOZNbP5miip9A6N3bC8nYHHSovbBhipoRpW7VCC3cWkGMpEn
         VYaGqsFDmIJmw==
Message-ID: <81e57e81e4570d1659098f2bbc7c9049a605c5e8.camel@kernel.org>
Subject: Re: [RFC PATCH v2] statx, inode: document the new STATX_INO_VERSION
 field
From:   Jeff Layton <jlayton@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Thu, 01 Sep 2022 12:30:20 -0400
In-Reply-To: <874jxrqdji.fsf@oldenburg.str.redhat.com>
References: <20220901121714.20051-1-jlayton@kernel.org>
         <874jxrqdji.fsf@oldenburg.str.redhat.com>
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

On Thu, 2022-09-01 at 18:12 +0200, Florian Weimer wrote:
> * Jeff Layton:
>=20
> > @@ -411,6 +413,21 @@ and corresponds to the number in the first field i=
n one of the records in
> >  For further information on the above fields, see
> >  .BR inode (7).
> >  .\"
> > +.TP
> > +.I stx_ino_version
> > +The inode version, also known as the inode change attribute. This
> > +value must change any time there is an inode status change. Any
> > +operation that would cause the
> > +.I stx_ctime
> > +to change must also cause
> > +.I stx_ino_version
> > +to change, even when there is no apparent change to the
> > +.I stx_ctime
> > +due to coarse timestamp granularity.
> > +.IP
> > +An observer cannot infer anything about the nature or magnitude of the=
 change
> > +from the value of this field. A change in this value only indicates th=
at
> > +there has been an explicit change in the inode.
>=20
> What happens if the file system does not support i_version?
>=20

The STATX_INO_VERSION bit will not be set in stx_mask field of the
response.

> > diff --git a/man7/inode.7 b/man7/inode.7
> > index 9b255a890720..d5e0890a52c0 100644
> > --- a/man7/inode.7
> > +++ b/man7/inode.7
> > @@ -184,6 +184,18 @@ Last status change timestamp (ctime)
> >  This is the file's last status change timestamp.
> >  It is changed by writing or by setting inode information
> >  (i.e., owner, group, link count, mode, etc.).
> > +.TP
> > +Inode version (i_version)
> > +(not returned in the \fIstat\fP structure); \fIstatx.stx_ino_version\f=
P
> > +.IP
> > +This is the inode change attribute. Any operation that would result in=
 a change
> > +to \fIstatx.stx_ctime\fP must result in a change to this value. The va=
lue must
> > +change even in the case where the ctime change is not evident due to c=
oarse
> > +timestamp granularity.
> > +.IP
> > +An observer cannot infer anything from the returned value about the na=
ture or
> > +magnitude of the change. If the returned value is different from the l=
ast time
> > +it was checked, then something has made an explicit change to the inod=
e.
>=20
> What is the wraparound behavior for i_version?  Does it use the full
> 64-bit range?
>=20

All of the existing implementations use all 64 bits. If you were to
increment a 64 bit value every nanosecond, it will take >500 years for
it to wrap. I'm hoping that's good enough. ;)

The implementation that all of the local Linux filesystems use track
whether the value has been queried using one bit, so there you only get
63 bits of counter.

My original thinking here was that we should leave the spec "loose" to
allow for implementations that may not be based on a counter. E.g. could
some filesystem do this instead by hashing certain metadata?

It's arguable though that the NFSv4 spec requires that this be based on
a counter, as the client is required to increment it in the case of
write delegations.

> If the system crashes without flushing disks, is it possible to observe
> new file contents without a change of i_version?

Yes, I think that's possible given the current implementations.

We don't have a great scheme to combat that at the moment, other than
looking at this in conjunction with the ctime. As long as the clock
doesn't jump backward after the crash and it takes more than one jiffy
to get the host back up, then you can be reasonably sure that
i_version+ctime should never repeat.

Maybe that's worth adding to the NOTES section of the manpage?
--=20
Jeff Layton <jlayton@kernel.org>
