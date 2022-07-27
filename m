Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9246A58290C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 16:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiG0Oxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 10:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiG0Oxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328983E758;
        Wed, 27 Jul 2022 07:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98ED61842;
        Wed, 27 Jul 2022 14:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E513C433D7;
        Wed, 27 Jul 2022 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658933613;
        bh=9yN7/8FPcz9NZnv8pdCtyOeMbgRvggAUjZAmF/EuP+o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gKMHmQntmFgl1LwEnSd9Z55mCHfUMj+OzCMAxFcP8d+Dfs4ChtfP+OVSJTaSABFcY
         PNuYD4b/GEopssPNPm60cpA6e20pu69wyUzOWoGNrmykvYulTKXE4zXbv+bULro6O5
         i1U0C6uPqVI1tfuUfHfJ8/IOmTutCwOW1IV6ld7i87aM73/jZRHXWW9FwuMjPtXrhC
         SCD851UVuBV6yj206MfFxbLasEyqPKLvjV+s2keuAPtSueNJTJbhrJDuGp45JVWA1+
         1rpBLiSPx2StaNj3tfXu8T9Mw05FX3Umk1IT5LXfZCT7tzF3MNOF358J+Br6lQy2iS
         t/J4jYRJoJ/nQ==
Message-ID: <70adb25e0e0d8b3e64f7fd40847f6bd096a705ed.camel@kernel.org>
Subject: Re: [PATCH v2] vfs: bypass may_create_in_sticky check on
 newly-created files if task has CAP_FOWNER
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yongchen Yang <yoyang@redhat.com>,
        Seth Forshee <sforshee@kernel.org>
Date:   Wed, 27 Jul 2022 10:53:31 -0400
In-Reply-To: <20220727143314.to2nx2osnw6zjxrm@wittgenstein>
References: <20220727140014.69091-1-jlayton@kernel.org>
         <20220727143314.to2nx2osnw6zjxrm@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-07-27 at 16:33 +0200, Christian Brauner wrote:
> On Wed, Jul 27, 2022 at 10:00:14AM -0400, Jeff Layton wrote:
> > From: Christian Brauner <brauner@kernel.org>
> >=20
> > NFS server is exporting a sticky directory (mode 01777) with root
> > squashing enabled. Client has protect_regular enabled and then tries to
> > open a file as root in that directory. File is created (with ownership
> > set to nobody:nobody) but the open syscall returns an error. The proble=
m
> > is may_create_in_sticky which rejects the open even though the file has
> > already been created.
> >=20
> > Add a new condition to may_create_in_sticky. If the file was just
> > created, then allow bypassing the ownership check if the task has
> > CAP_FOWNER. With this change, the initial open of a file by root works,
> > but later opens of the same file will fail.
> >=20
> > Note that we can contrive a similar situation by exporting with
> > all_squash and opening the file as an unprivileged user. This patch doe=
s
> > not fix that case. I suspect that that configuration is likely to be
> > fundamentally incompatible with the protect_* sysctls enabled on the
> > clients.
> >=20
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1976829
> > Reported-by: Yongchen Yang <yoyang@redhat.com>
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/namei.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >=20
> > Hi Christian,
> >=20
> > I left you as author here since this is basically identical to the patc=
h
> > you suggested. Let me know if that's an issue.
>=20
> No, that's fine.
>=20

Thanks.

> It feels pretty strange to be able to create a file and then not being
> able to open it fwiw. But we have that basically with nodev already. And
> we implicitly encode this in may_create_in_sticky() for this protected_*
> stuff. Relaxing this through CAP_FOWNER makes sense as it's explicitly
> thought to "Bypass permission checks on operations that normally require
> the filesystem UID of the process to match the UID of the file".
>=20
> One thing that I'm not sure about is something that Seth pointed out
> namely whether there's any NFS server side race window that would render
> FMODE_CREATED provided to may_create_in_sticky() inaccurate.


In general, permissions enforcement in NFS is done on the _server_.
Trying to enforce permissions/ownership on the client is sketchy at best
and subject to a number of potential race windows.

Practically, it probably depends on the server. With NFSv4 the client
looks at the change attr on the dir before and after the open, and if
they are different then it assumes the file was created.

This is usually non-atomic in most general-purpose server
implementations, but with knfsd I *think* we hold the parent's i_rwsem
for write when creating files, and maybe that's enough to prevent that
sort of race. I'm not certain though.

--=20
Jeff Layton <jlayton@kernel.org>
