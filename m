Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8474058C943
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbiHHNTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 09:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242568AbiHHNTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:19:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277715FA9;
        Mon,  8 Aug 2022 06:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7F45DCE1099;
        Mon,  8 Aug 2022 13:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B482AC433C1;
        Mon,  8 Aug 2022 13:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659964747;
        bh=WbW+9qCSkRr5VwrXe92AgJ0Tev43dg13deHgbic44V4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Yh3mbFYzZUnNBxKTPwVezwm6HiAsFsHl5nh1qlT6WKVAvyKnTLsie9XVJ3mifX07k
         VYMusmLxyzuAc7Nc7HK1jWeBytVwnj4PLC3uucfYB9tDslEyU7Z+E5xDlGWpkprpTV
         DnCaWPnU8jTItqadwNDXS/cl140h8pWYlnbtO6XbdfdIiZvve8FSyNwJTs3twYIfLT
         jbIPZAo/WY6HQSxRtv9vY6W0VM0hYJed4l+VKBCB9ZdqrNh/cTUjjlAIC9ZSbPYT+Z
         nCb53y++ylMfbGRnsGYC2Pi17nCbIX3v659yZBDQdNt/PW08Wo3dt3X3CmjhZcZoAJ
         0GnPt+Tsn71PQ==
Message-ID: <33176ee0f896aef889ad1930fb1e008323135a2e.camel@kernel.org>
Subject: Re: [RFC PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        lczerner@redhat.com, bxue@redhat.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, fstests <fstests@vger.kernel.org>
Date:   Mon, 08 Aug 2022 09:19:05 -0400
In-Reply-To: <c10e4aa381aea86bb51b005887533e28f9c7302b.camel@redhat.com>
References: <20220805183543.274352-1-jlayton@kernel.org>
         <20220805183543.274352-2-jlayton@kernel.org>
         <20220805220136.GG3600936@dread.disaster.area>
         <c10e4aa381aea86bb51b005887533e28f9c7302b.camel@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-08-05 at 18:06 -0400, Jeff Layton wrote:
> On Sat, 2022-08-06 at 08:01 +1000, Dave Chinner wrote:
> > On Fri, Aug 05, 2022 at 02:35:40PM -0400, Jeff Layton wrote:
> > > From: Jeff Layton <jlayton@redhat.com>
> > >=20
> > > Claim one of the spare fields in struct statx to hold a 64-bit change
> > > attribute. When statx requests this attribute, do an
> > > inode_query_iversion and fill the result in the field.
> > >=20
> > > Also update the test-statx.c program to fetch the change attribute as
> > > well.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/stat.c                 | 7 +++++++
> > >  include/linux/stat.h      | 1 +
> > >  include/uapi/linux/stat.h | 3 ++-
> > >  samples/vfs/test-statx.c  | 4 +++-
> > >  4 files changed, 13 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/fs/stat.c b/fs/stat.c
> > > index 9ced8860e0f3..976e0a59ab23 100644
> > > --- a/fs/stat.c
> > > +++ b/fs/stat.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/syscalls.h>
> > >  #include <linux/pagemap.h>
> > >  #include <linux/compat.h>
> > > +#include <linux/iversion.h>
> > > =20
> > >  #include <linux/uaccess.h>
> > >  #include <asm/unistd.h>
> > > @@ -118,6 +119,11 @@ int vfs_getattr_nosec(const struct path *path, s=
truct kstat *stat,
> > >  	stat->attributes_mask |=3D (STATX_ATTR_AUTOMOUNT |
> > >  				  STATX_ATTR_DAX);
> > > =20
> > > +	if ((request_mask & STATX_CHGATTR) && IS_I_VERSION(inode)) {
> > > +		stat->result_mask |=3D STATX_CHGATTR;
> > > +		stat->chgattr =3D inode_query_iversion(inode);
> > > +	}
> >=20
> > If you're going to add generic support for it, shouldn't there be a
> > generic test in fstests that ensures that filesystems that advertise
> > STATX_CHGATTR support actually behave correctly? Including across
> > mounts, and most importantly, that it is made properly stable by
> > fsync?
> >=20
> > i.e. what good is this if different filesystems have random quirks
> > that mean it can't be relied on by userspace to tell it changes have
> > occurred?
>=20
> Absolutely. Being able to better test the i_version field for consistent
> behavior is a primary goal. I haven't yet written any yet, but we'd
> definitely want something in xfstests if we decide this is worthwhile.

I started writing some tests for this today, and hit a bit of a chicken-
and-egg problem:

I'd prefer to use xfs_io for easier maintainability, but the STATX_*
constants are defined via UAPI header. Older kernels don't have them and
old xfs_io programs don't understand or report this value.

Should I just write a one-off binary program for xfstests to fetch this
value for now, or are we better off merging the patchset first, and then
fix xfs_io and then write the tests using the updated xfs_io program?

--=20
Jeff Layton <jlayton@kernel.org>
