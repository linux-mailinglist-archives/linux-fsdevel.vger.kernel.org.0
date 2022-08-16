Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70B595F14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiHPPc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 11:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbiHPPc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:32:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E16B2E9D0;
        Tue, 16 Aug 2022 08:32:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECDCC611CD;
        Tue, 16 Aug 2022 15:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA5EC433C1;
        Tue, 16 Aug 2022 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660663946;
        bh=E681lvYqctY/XBN4hr4Xk2egcoITFoQ28F444btzAgc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N4E61JQMQPzsnHcXXe1PpK1kduWkzL/J2iEYEyxlwW86dfPfXOxAEwgqlbiDPVRDD
         hyDyibz0T+FlWWAX29UpeVWDIt0qz/h0rsJdH6nB6X7urJIUlif+YhD+V0nlwwWHXF
         R0EXggcdcAmN/K9JOS1RZk3fsn0+EXaY4r1oGyDopSApodERVBRPNe0UYCXGkz/LgJ
         O8hLapGbX9PTdFnMVYIJOZQRqRNFjj7LIN5i6bkgE4BK/lWZpFrQGRMzhaVR35tW4v
         IaQ9JLn/klhYz+oulf3JrKkvQSG9IgcrpyFbTJmTuUgyHlVrF6EbS8PtvLUm+ZtE5y
         Q90ASOoQzSx9g==
Message-ID: <83d07cc4f7fe2ca9976d3f418e5137f354e933a4.camel@kernel.org>
Subject: Re: [PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org
Date:   Tue, 16 Aug 2022 11:32:24 -0400
In-Reply-To: <12637.1660662903@warthog.procyon.org.uk>
References: <ef692314ada01fd2117b730ef0afae50102974f5.camel@kernel.org>
         <20220816134419.xra4krb3jwlm4npk@wittgenstein>
         <20220816132759.43248-1-jlayton@kernel.org>
         <20220816132759.43248-2-jlayton@kernel.org>
         <4066396.1660658141@warthog.procyon.org.uk>
         <12637.1660662903@warthog.procyon.org.uk>
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

On Tue, 2022-08-16 at 16:15 +0100, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
>=20
> > I think we'll just have to ensure that before we expose this for any
> > filesystem that it conforms to some minimum standards. i.e.: it must
> > change if there are data or metadata changes to the inode, modulo atime
> > changes due to reads on regular files or readdir on dirs.
> >=20
> > The local filesystems, ceph and NFS should all be fine. I guess that
> > just leaves AFS. If it can't guarantee that, then we might want to avoi=
d
> > exposing the counter for it.
>=20
> AFS monotonically increments the counter on data changes; doesn't make an=
y
> change for metadata changes (other than the file size).
>=20
> But you can't assume NFS works as per your suggestion as you don't know w=
hat's
> backing it (it could be AFS, for example - there's a converter for that).
>=20

In that case, the NFS server must synthesize a proper change attr. The
NFS spec mandates that it change on most metadata changes.

> Further, for ordinary disk filesystems, two data changes may get elided a=
nd
> only increment the counter once.
>=20

Not a problem as long as nothing queried the counter in between the
changes.

> And then there's mmap...
>=20

Not sure how that matters here.

> It might be better to reduce the scope of your definition and just say th=
at it
> must change if there's a data change and may also be changed if there's a
> metadata change.
>=20

I'd prefer that we mandate that it change on metadata changes as well.
That's what most of the in-kernel users want, and what most of the
existing filesystems provide. If AFS can't give that guarantee then we
can just omit exposing i_version on it.
--=20
Jeff Layton <jlayton@kernel.org>
