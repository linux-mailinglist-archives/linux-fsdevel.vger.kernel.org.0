Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5535B047C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiIGM6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 08:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIGM60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E7B726A3;
        Wed,  7 Sep 2022 05:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04364618D9;
        Wed,  7 Sep 2022 12:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D42C433D7;
        Wed,  7 Sep 2022 12:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662555504;
        bh=tnWjtscBr1iju0x5maeHzqeJywQFydfQoFg86LROAMI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ajaFuOOK6mbkWRbqz1kq1RN9dl7hA1dDMLwcmdFVVRCk/Qp9WESIgYX/KYV7UrD0v
         7hqoIG1CwoRNIQVUgNnDwXcFGHihXJJgbbUzHJwG+Hw+H5Ar4hc4mbKDL8TrPc7IUc
         lhSFko+Fuk5H4DPBaUBZX3xYQaMC0ScKGiA9QHPBY3OqOgfmb09/Kivz1fiWW6XjHs
         3UCcEXlEGlCeVA1KZJfRBQpIFrd486CgoO9gdiNucz3fJNy8bzL7mQ/HagxnmlENW5
         EijrR5GwK3FqCXab1oMQOxjtiiY8meWLWNxBJ9c4yqwZnfo7f5v472jmJJK0l+F5v+
         skW4ovgx6O5/w==
Message-ID: <c11babc93b5feadc77da3dd3eecd535e90ead844.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>, NeilBrown <neilb@suse.de>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        brauner@kernel.org, fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Wed, 07 Sep 2022 08:58:20 -0400
In-Reply-To: <20220907122033.GA17729@fieldses.org>
References: <20220907111606.18831-1-jlayton@kernel.org>
         <166255065346.30452.6121947305075322036@noble.neil.brown.name>
         <20220907122033.GA17729@fieldses.org>
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

On Wed, 2022-09-07 at 08:20 -0400, J. Bruce Fields wrote:
> On Wed, Sep 07, 2022 at 09:37:33PM +1000, NeilBrown wrote:
> > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > +The change to \fIstatx.stx_ino_version\fP is not atomic with respect=
 to the
> > > +other changes in the inode. On a write, for instance, the i_version =
it usually
> > > +incremented before the data is copied into the pagecache. Therefore =
it is
> > > +possible to see a new i_version value while a read still shows the o=
ld data.
> >=20
> > Doesn't that make the value useless?  Surely the change number must
> > change no sooner than the change itself is visible, otherwise stale dat=
a
> > could be cached indefinitely.
>=20
> For the purposes of NFS close-to-open, I guess all we need is for the
> change attribute increment to happen sometime between the open and the
> close.
>=20
> But, yes, it'd seem a lot more useful if it was guaranteed to happen
> after.  (Or before and after both--extraneous increments aren't a big
> problem here.)
>=20
>=20

For NFS I don't think they would be.

We don't want increments due to reads that may happen well after the
initial write, but as long as the second increment comes in fairly soon
after the initial one, the extra invalidations shouldn't be _too_ bad.

You might have a reader race in and see the interim value, but we'd
probably want the reader to invalidate the cache soon after that anyway.
The file was clearly in flux at the time of the read.

Allowing for this sort of thing is why I've been advocating against
trying to define this value too strictly. If we were to confine
ourselves to "one bump per change" then it'd be hard to pull this off.

Maybe this is what we should be doing?

> >=20
> > If currently implementations behave this way, surely they are broken.
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
