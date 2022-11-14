Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C0F6283F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 16:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiKNPb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 10:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiKNPbl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:31:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FBC2CE28;
        Mon, 14 Nov 2022 07:31:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E59F361242;
        Mon, 14 Nov 2022 15:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D896BC433C1;
        Mon, 14 Nov 2022 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668439899;
        bh=j5bYmKSHl95aTPkTV+iwqapudR0oFc78D0tvarS2piY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LTCaLEwwi99BWx/HMWUtKNIGRiWJb6e9GLCIvExR2UDkyZAQdlq/BvuwfYtUAwxt3
         vUqqCFSDSgsdMayK1CJ/+QWdsJ9o7jrysf5qZf9CFOAQJAv+BhOhv6Y2dpVKkkRK1j
         IskzlWSyJG0t9jvnK/B0iUF93gV2urF+w9JP8ir1tNWHMmnFKnpsq9RymG9flK4fDh
         AuVfFFpkja0bjaIcnmHFxVs2wmpbyovyMbBpYQFXJpy+amtO7vOOYd5F2Xp9bFIsT2
         pjRBLa4Tq+Ycuo/s17D0DbUviy+3o9r3wVjDGpQTr6ecvaCG1sd0iFXxw0m9FymlfL
         j6Rsu5M440NKA==
Message-ID: <a2a3a6a3eaa433f7d38086e6d0623e0ef91f0c9f.camel@kernel.org>
Subject: Re: [PATCH 0/3] filelock: remove redundant filp arguments from API
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 14 Nov 2022 10:31:37 -0500
In-Reply-To: <3C490193-AFF8-479E-ACEF-ADD02E3E15D5@oracle.com>
References: <20221114150240.198648-1-jlayton@kernel.org>
         <3C490193-AFF8-479E-ACEF-ADD02E3E15D5@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-11-14 at 15:08 +0000, Chuck Lever III wrote:
>=20
> > On Nov 14, 2022, at 10:02 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > Some of the exported functions in fs/locks.c take both a struct file
> > argument and a struct file_lock. struct file_lock has a dedicated field
> > to record which file it was set on (fl_file). This is redundant, and
> > there have been some cases where the two didn't match [1], leading to
> > bugs.
>=20
> Hi Jeff, doesn't the same argument apply to f_ops->lock ? Do you
> have a plan for updating that API as well?
>=20
>=20

It does apply to fops->lock. I don't have a real plan as of yet. I
figure we'll get this set in first and then we can look at changing that
API as well.

> > This patchset is intended to remove this ambiguity by eliminating the
> > separate struct file argument from vfs_lock_file, vfs_test_lock and
> > vfs_cancel_lock.
> >=20
> > Most callers are easy to vet to ensure that they set this correctly, bu=
t
> > lockd had a few places where it wasn't doing the right thing. This
> > series depends on the lockd patches I sent late last week [2].
> >=20
> > I'm targeting this series for v6.3. I'll plan to get it into linux-next
> > soon unless there are objections.
> >=20
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D216582
> > [2]: https://lore.kernel.org/linux-nfs/20221111215538.356543-1-jlayton@=
kernel.org/T/#t
> >=20
> > Jeff Layton (3):
> >  filelock: remove redundant filp argument from vfs_lock_file
> >  filelock: remove redundant filp argument from vfs_test_lock
> >  filelock: remove redundant filp arg from vfs_cancel_lock
> >=20
> > fs/ksmbd/smb2pdu.c  |  4 ++--
> > fs/lockd/svclock.c  | 21 +++++++--------------
> > fs/lockd/svcsubs.c  |  4 ++--
> > fs/locks.c          | 29 ++++++++++++++---------------
> > fs/nfsd/nfs4state.c |  6 +++---
> > include/linux/fs.h  | 14 +++++++-------
> > 6 files changed, 35 insertions(+), 43 deletions(-)
> >=20
> > --=20
> > 2.38.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
