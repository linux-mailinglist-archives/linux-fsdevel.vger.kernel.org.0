Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863A15B04D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 15:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIGNMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 09:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiIGNMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:12:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2022E688;
        Wed,  7 Sep 2022 06:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3E01B81CAB;
        Wed,  7 Sep 2022 13:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457FEC433C1;
        Wed,  7 Sep 2022 13:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662556358;
        bh=V132xHGgL1w8NHdBoiYyAL47s8tfLlop3oD1g1fj82U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G1Jm4lJM23B3IaP893itjGYX74m99ASPpvW2J4WhPcn/YmxsxbxA3Qu8Q1WTBBOod
         3oQ7NyGRNn9EC4E7ywA0efUlS5RaH51RNfrhInHxVLRQtqvaPQmTE0FNXCKdkOT4fq
         hkfTcYv8lixZeuNOAKOujT24sSlMKFaPnO6Q+vw0gOlPYBGKl5UwqfYVZjThZe7B6W
         3mzVasOKwgCIpWc3kCktbm1g06RbSMBBKbVC8OCqFvDySzCLlz5+tfdKtcyqmv72MS
         BPibXbvvVwhBG/7CPQjwHJj98CsPU5n+dzw1m1ZgJKMUBtDa6CzGdsf1h4j2G5I2Mu
         m6WkYDXixYGeA==
Message-ID: <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.de>, tytso@mit.edu, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        brauner@kernel.org, fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Wed, 07 Sep 2022 09:12:34 -0400
In-Reply-To: <20220907125211.GB17729@fieldses.org>
References: <20220907111606.18831-1-jlayton@kernel.org>
         <166255065346.30452.6121947305075322036@noble.neil.brown.name>
         <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
         <20220907125211.GB17729@fieldses.org>
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

On Wed, 2022-09-07 at 08:52 -0400, J. Bruce Fields wrote:
> On Wed, Sep 07, 2022 at 08:47:20AM -0400, Jeff Layton wrote:
> > On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> > > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > > +The change to \fIstatx.stx_ino_version\fP is not atomic with respe=
ct to the
> > > > +other changes in the inode. On a write, for instance, the i_versio=
n it usually
> > > > +incremented before the data is copied into the pagecache. Therefor=
e it is
> > > > +possible to see a new i_version value while a read still shows the=
 old data.
> > >=20
> > > Doesn't that make the value useless?
> > >=20
> >=20
> > No, I don't think so. It's only really useful for comparing to an older
> > sample anyway. If you do "statx; read; statx" and the value hasn't
> > changed, then you know that things are stable.=20
>=20
> I don't see how that helps.  It's still possible to get:
>=20
> 		reader		writer
> 		------		------
> 				i_version++
> 		statx
> 		read
> 		statx
> 				update page cache
>=20
> right?
>=20

Yeah, I suppose so -- the statx wouldn't necessitate any locking. In
that case, maybe this is useless then other than for testing purposes
and userland NFS servers.

Would it be better to not consume a statx field with this if so? What
could we use as an alternate interface? ioctl? Some sort of global
virtual xattr? It does need to be something per-inode.

> >=20
> > > Surely the change number must
> > > change no sooner than the change itself is visible, otherwise stale d=
ata
> > > could be cached indefinitely.
> > >=20
> > > If currently implementations behave this way, surely they are broken.
> >=20
> > It's certainly not ideal but we've never been able to offer truly atomi=
c
> > behavior here given that Linux is a general-purpose OS. The behavior is
> > a little inconsistent too:
> >=20
> > The c/mtime update and i_version bump on directories (mostly) occur
> > after the operation. c/mtime updates for files however are mostly drive=
n
> > by calls to file_update_time, which happens before data is copied to th=
e
> > pagecache.
> >=20
> > It's not clear to me why it's done this way. Maybe to ensure that the
> > metadata is up to date in the event that a statx comes in? Improving
> > this would be nice, but I don't see a way to do that without regressing
> > performance.
> > --=20
> > Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>
