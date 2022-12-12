Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BF664A586
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 18:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiLLRGe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 12:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiLLRGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:06:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D35A263C;
        Mon, 12 Dec 2022 09:06:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBE94B80DB0;
        Mon, 12 Dec 2022 17:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A492C433D2;
        Mon, 12 Dec 2022 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670864764;
        bh=XTRsuIYAEgT1gquTzsuV5sUHTMNWmSiPqFHKWQsG3ek=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G83ic7eb0L1iw75wMI0w9TqHE5sg2mBtd0vfxemt8JMbw49dLPbuKotbUpOJAHoRw
         hUZzqmt4BNBE3dF8hFyBTSZebIWYtEIZgELKBvPL+jY6Z+r9qPiYRlwdcfyhM0cg4D
         I5GYLciugHNkI6BZwTTtVlAyUj2kaeefOS6xdvP2VTkQeOaHR31KqT5u3B5kZOV11O
         CUYtD4ia00dPx1b8xkisZJDunIBTKaff9MMvw0A1E0dOLj6BS1p1FlyBNMywPfUQG1
         pqTbh/N4y3avsIQpWJUHJ+lQmL9eUa9JquoBAQNPQNDv0a3wZ8+IOf/DCiN1Est8L9
         RBtqHVfaxeyIQ==
Message-ID: <2de81c537335da895bafcd9f50a239c439fb0439.camel@kernel.org>
Subject: Re: [PATCH 0/3 v2] NFS: NFSD: Allow crossing mounts when
 re-exporting
From:   Jeff Layton <jlayton@kernel.org>
To:     Richard Weinberger <richard@nod.at>, linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        chuck.lever@oracle.com, anna@kernel.org,
        trond.myklebust@hammerspace.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, chris.chilvers@appsbroker.com,
        david.young@appsbroker.com, luis.turcitu@appsbroker.com,
        david@sigma-star.at, benmaynard@google.com
Date:   Mon, 12 Dec 2022 12:06:01 -0500
In-Reply-To: <20221207084309.8499-1-richard@nod.at>
References: <20221207084309.8499-1-richard@nod.at>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-12-07 at 09:43 +0100, Richard Weinberger wrote:
> Currently when re-exporting a NFS share the NFS cross mount feature does
> not work [0].
> This patch series outlines an approach to address the problem.
>=20
> Crossing mounts does not work for two reasons:
>=20
> 1. As soon the NFS client (on the re-exporting server) sees a different
> filesystem id, it installs an automount. That way the other filesystem
> will be mounted automatically when someone enters the directory.
> But the cross mount logic of KNFS does not know about automount.
> This patch series addresses the problem and teach both KNFSD
> and the exportfs logic of NFS to deal with automount.
>=20
> 2. When KNFSD detects crossing of a mount point, it asks rpc.mountd to in=
stall
> a new export for the target mount point. Beside of authentication rpc.mou=
ntd
> also has to find a filesystem id for the new export. Is the to be exporte=
d
> filesystem a NFS share, rpc.mountd cannot derive a filesystem id from it =
and
> refuses to export. In the logs you'll see errors such as:
>=20
> mountd: Cannot export /srv/nfs/vol0, possibly unsupported filesystem or f=
sid=3D required
>=20
> To deal with that I've changed rpc.mountd to use generate and store fsids=
 [1].
> Since the kernel side of my changes did change for a long time I decided =
to
> try upstreaming it first.
> A 3rd iteration of my rpc.mountd will happen soon.
>=20
> [0] https://marc.info/?l=3Dlinux-nfs&m=3D161653016627277&w=3D2
> [1] https://lore.kernel.org/linux-nfs/20220217131531.2890-1-richard@nod.a=
t/
>=20
> Changes since v1:
> https://lore.kernel.org/linux-nfs/20221117191151.14262-1-richard@nod.at/
>=20
> - Use LOOKUP_AUTOMOUNT only when NFSEXP_CROSSMOUNT is set (Jeff Layton)
>=20
> Richard Weinberger (3):
>   NFSD: Teach nfsd_mountpoint() auto mounts
>   fs: namei: Allow follow_down() to uncover auto mounts
>   NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
>=20
>  fs/namei.c            | 6 +++---
>  fs/nfs/export.c       | 2 +-
>  fs/nfsd/vfs.c         | 8 ++++++--
>  include/linux/namei.h | 2 +-
>  4 files changed, 11 insertions(+), 7 deletions(-)
>=20

This set looks reasonable to me.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
