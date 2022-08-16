Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E657595FD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbiHPQJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 12:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiHPQIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:08:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8933F7B293;
        Tue, 16 Aug 2022 09:05:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D448B818DF;
        Tue, 16 Aug 2022 16:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEDCC433D7;
        Tue, 16 Aug 2022 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660665950;
        bh=e3S03XYYIb59wftUp90e9c4/E544yR+7n3TEKoflUtQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ICTYXoPIa40yAetKp+Bw96/taRKf/GDT1/zVBSYCrHZqd5JgBWMd0hxjGwrk2TOow
         Ax1yV0F+Po6OCDB0cXdHEMrB+iBnX5+iohcYzHSt2Fq4Vnv1uRolJWEbUFGW8pqMzx
         mvkNODMEkdHRNwcwG+vJX9zBl9NnO7D+UsdG4gn1diQeZucLUpSVQXq17WHAV2r4DW
         u9Sqx05uf8dWw0858Ec4LXkVAUV4ftb02XADs8nB1CI1sVN9/h5HSO96pvAlg9aEO1
         Kt7TY6gQGsoEWQso2Jn8yzI04wrH8e749KS8Isj7xXs+BhFhLxxfBcW7KDfrIKabPU
         NumcVsYY6riZg==
Message-ID: <d741f144c798c3ef877b9d5e5d0c37d028245915.camel@kernel.org>
Subject: Re: [PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        viro@zeniv.linux.org.uk, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org,
        "trond.myklebust" <trond.myklebust@hammerspace.com>
Date:   Tue, 16 Aug 2022 12:05:48 -0400
In-Reply-To: <Yvu9HsCgzwpEYhPc@magnolia>
References: <ef692314ada01fd2117b730ef0afae50102974f5.camel@kernel.org>
         <20220816134419.xra4krb3jwlm4npk@wittgenstein>
         <20220816132759.43248-1-jlayton@kernel.org>
         <20220816132759.43248-2-jlayton@kernel.org>
         <4066396.1660658141@warthog.procyon.org.uk>
         <12637.1660662903@warthog.procyon.org.uk>
         <83d07cc4f7fe2ca9976d3f418e5137f354e933a4.camel@kernel.org>
         <Yvu9HsCgzwpEYhPc@magnolia>
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

On Tue, 2022-08-16 at 08:51 -0700, Darrick J. Wong wrote:
> On Tue, Aug 16, 2022 at 11:32:24AM -0400, Jeff Layton wrote:
> > On Tue, 2022-08-16 at 16:15 +0100, David Howells wrote:
> > > Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > > I think we'll just have to ensure that before we expose this for an=
y
> > > > filesystem that it conforms to some minimum standards. i.e.: it mus=
t
> > > > change if there are data or metadata changes to the inode, modulo a=
time
> > > > changes due to reads on regular files or readdir on dirs.
> > > >=20
> > > > The local filesystems, ceph and NFS should all be fine. I guess tha=
t
> > > > just leaves AFS. If it can't guarantee that, then we might want to =
avoid
> > > > exposing the counter for it.
> > >=20
> > > AFS monotonically increments the counter on data changes; doesn't mak=
e any
> > > change for metadata changes (other than the file size).
> > >=20
> > > But you can't assume NFS works as per your suggestion as you don't kn=
ow what's
> > > backing it (it could be AFS, for example - there's a converter for th=
at).
> > >=20
> >=20
> > In that case, the NFS server must synthesize a proper change attr. The
> > NFS spec mandates that it change on most metadata changes.
> >=20
> > > Further, for ordinary disk filesystems, two data changes may get elid=
ed and
> > > only increment the counter once.
> > >=20
> >=20
> > Not a problem as long as nothing queried the counter in between the
> > changes.
> >=20
> > > And then there's mmap...
> > >=20
> >=20
> > Not sure how that matters here.
> >=20
> > > It might be better to reduce the scope of your definition and just sa=
y that it
> > > must change if there's a data change and may also be changed if there=
's a
> > > metadata change.
> > >=20
> >=20
> > I'd prefer that we mandate that it change on metadata changes as well.
>=20
> ...in that case, why not leave the i_version bump in
> xfs_trans_log_inode?  That will capture all changes to file data,
> attribues, and metadata. ;)
>=20
>=20

Because that includes changes to the atime due to reads which should be
specifically omitted. We could still keep that callsite instead, if you
can see some way to exclude those.

In practice, we are using a change to i_version to mean that "something
changed" in the inode, which usually implies a change to the ctime and
mtime.

Trond pointed out that the NFSv4 spec implies that time_access updates
should be omitted from what we consider to be "metadata" here:

https://mailarchive.ietf.org/arch/msg/nfsv4/yrRBMrVwWWDCrgHPAzq_yAEc7BU/

IMA (which is the only other in-kernel consumer of i_version) also wants
the same behavior.

> > That's what most of the in-kernel users want, and what most of the
> > existing filesystems provide. If AFS can't give that guarantee then we
> > can just omit exposing i_version on it.


--=20
Jeff Layton <jlayton@kernel.org>
