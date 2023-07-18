Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FA27584C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 20:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjGRS1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 14:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRS1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:27:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEDFB6;
        Tue, 18 Jul 2023 11:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D1DE616A8;
        Tue, 18 Jul 2023 18:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344B5C433C7;
        Tue, 18 Jul 2023 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689704849;
        bh=uNk0XUkdDBUHQlqednb/jEUGmxpFPqSLJgCZ0SHSywA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ATBHZKnA6K3s7qp0wC9FoKKdLm8GN8TwCjn20vt11Xo/Rp44a3FuZiHkE7kCVFdLF
         Idtw0XGj+HcRZm8frnVjt0aWvAmc1VnRQIG6VQXLEvFTyfIR8Io2HaP9tIpjd8R6iC
         7YrmeydcowvlHarjkWzzu3H9SHpIhineZA0RmgYw/QYq6pjVDsQuYR6X6sM61i0/2F
         DcjtrgQi7XEVLka8acDvqZKcS9t1HFalcCxGsBHyNKFbX2vYQH/YmVMmbOtho6T7t7
         LpMjhcJRvb/fm/nGvdXUPf+umv7L6beeIa20+PqbRIuGdQNhfDsjMl10VHNKblVwcY
         /p0LFfpF3JhTw==
Message-ID: <a77881074b9710399fd2ad43e17fa26bf9b397cb.camel@kernel.org>
Subject: Re: linux-next ext4 inode size 128 corrupted
From:   Jeff Layton <jlayton@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 18 Jul 2023 14:27:26 -0400
In-Reply-To: <a51815d0-16fb-201b-77db-e16af4caa8b0@google.com>
References: <26cd770-469-c174-f741-063279cdf7e@google.com>
         <368e567a3a0a1a21ce37f5fba335068c50ab6f29.camel@kernel.org>
         <a51815d0-16fb-201b-77db-e16af4caa8b0@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-07-18 at 11:03 -0700, Hugh Dickins wrote:
> On Tue, 18 Jul 2023, Jeff Layton wrote:
> > On Mon, 2023-07-17 at 20:43 -0700, Hugh Dickins wrote:
> > > Hi Jeff,
> > >=20
> > > I've been unable to run my kernel builds on ext4 on loop0 on tmpfs
> > > swapping load on linux-next recently, on one machine: various kinds
> > > of havoc, most common symptoms being ext4_find_dest_de:2107 errors,
> > > systemd-journald errors, segfaults.  But no problem observed running
> > > on a more recent installation.
> > >=20
> > > Bisected yesterday to 979492850abd ("ext4: convert to ctime accessor
> > > functions").
> > >=20
> > > I've mostly averted my eyes from the EXT4_INODE macro changes there,
> > > but I think that's where the problem lies.  Reading the comment in
> > > fs/ext4/ext4.h above EXT4_FITS_IN_INODE() led me to try "tune2fs -l"
> > > and look at /etc/mke2fs.conf.  It's an old installation, its own
> > > inodes are 256, but that old mke2fs.conf does default to 128 for smal=
l
> > > FSes, and what I use for the load test is small.  Passing -I 256 to t=
he
> > > mkfs makes the problems go away.
> > >=20
> > > (What's most alarming about the corruption is that it appears to exte=
nd
> > > beyond just the throwaway test filesystem: segfaults on bash and libc=
.so
> > > from the root filesystem.  But no permanent damage done there.)
> > >=20
> > > One oddity I noticed in scrutinizing that commit, didn't help with
> > > the issues above, but there's a hunk in ext4_rename() which changes
> > > -	old.dir->i_ctime =3D old.dir->i_mtime =3D current_time(old.dir);
> > > +	old.dir->i_mtime =3D inode_set_ctime_current(old.inode);
> > >=20
> > >=20
> >=20
> > I suspect the problem here is the i_crtime, which lives wholly in the
> > extended part of the inode. The old macros would just not store anythin=
g
> > if the i_crtime didn't fit, but the new ones would still store the
> > tv_sec field in that case, which could be a memory corruptor. This patc=
h
> > should fix it, and I'm testing it now.
>=20
> That makes sense.
>=20
> >=20
> > Hugh, if you're able to give this a spin on your setup, then that would
> > be most helpful. This is also in the "ctime" branch in my kernel.org
> > tree if that helps. If this looks good, I'll ask Christian to fold this
> > into the ext4 conversion patch.
>=20
> Yes, it's now running fine on the problem machine, and on the no-problem.
>=20
> Tested-by: Hugh Dickins <hughd@google.com>
>=20
> >=20
> > Thanks for the bug report!
>=20
> And thanks for the quick turnaround!
>=20
> But I'm puzzled by your dismissing that
> -	old.dir->i_ctime =3D old.dir->i_mtime =3D current_time(old.dir);
> +	old.dir->i_mtime =3D inode_set_ctime_current(old.inode);
> in ext4_rename() as "actually looks fine".
>=20
> Different issue, nothing to do with the corruption, sure.  Much less
> important, sure.  But updating ctime on the wrong inode is "fine"?

Ahh , sorry I wasn't looking at that properly. I think you're correct.
The right fix is probably to move ext4 to use generic_rename_timestamp.
I'll test and send another patch for that.

Thanks again!
--=20
Jeff Layton <jlayton@kernel.org>
