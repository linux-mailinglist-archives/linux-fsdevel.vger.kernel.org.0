Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1124F75794F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 12:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGRKdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 06:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjGRKc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F55E52;
        Tue, 18 Jul 2023 03:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5508061500;
        Tue, 18 Jul 2023 10:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9539C433C8;
        Tue, 18 Jul 2023 10:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689676376;
        bh=ENk/cyofyM2gVh6VO7eTOASdn5hRgkrHbAS7Eix53YU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HdbM2phI6adedlNfWv02CY1dd2sbJxkWKmleM2SL8+I+o4PL2mkkq62PMJZNHRBW0
         XvSgopdb6H7H8pVZ6tLtd8KNPqwybfWkB2iDdT31ReHGjZ6b64x0DPpr0S6hoKZ4/a
         xRVYuGPiDEXNlnRzKSMwcJdLEIw7RqG7bZHBmh9suUxBdeXsnE7B6Voh05JaDC1a0n
         j95YG4GQ2Q4OZAHGTVBt5TMPDZ/r3OjdoXL9SUdInANDtkJezIYUw2xtAzBPfQVClJ
         jSJJXP3nxskAHIbmM4p7dONPdWcZM6x9mgZZAf1tL4pTee9RDOLFxjv+Jui0WnSZFi
         9kVttexl54t8g==
Message-ID: <3858cccced2de1b2407d9a03f6628eb4fb2cb0ab.camel@kernel.org>
Subject: Re: linux-next ext4 inode size 128 corrupted
From:   Jeff Layton <jlayton@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 18 Jul 2023 06:32:54 -0400
In-Reply-To: <26cd770-469-c174-f741-063279cdf7e@google.com>
References: <26cd770-469-c174-f741-063279cdf7e@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-07-17 at 20:43 -0700, Hugh Dickins wrote:
> Hi Jeff,
>=20
> I've been unable to run my kernel builds on ext4 on loop0 on tmpfs
> swapping load on linux-next recently, on one machine: various kinds
> of havoc, most common symptoms being ext4_find_dest_de:2107 errors,
> systemd-journald errors, segfaults.  But no problem observed running
> on a more recent installation.
>=20
> Bisected yesterday to 979492850abd ("ext4: convert to ctime accessor
> functions").
>=20
> I've mostly averted my eyes from the EXT4_INODE macro changes there,
> but I think that's where the problem lies.  Reading the comment in
> fs/ext4/ext4.h above EXT4_FITS_IN_INODE() led me to try "tune2fs -l"
> and look at /etc/mke2fs.conf.  It's an old installation, its own
> inodes are 256, but that old mke2fs.conf does default to 128 for small
> FSes, and what I use for the load test is small.  Passing -I 256 to the
> mkfs makes the problems go away.
>=20

Sounds like something is storing timestamp values in the extended part
of the inode when it shouldn't be. The macros look sane to me, but I'll
go over them again.

> (What's most alarming about the corruption is that it appears to extend
> beyond just the throwaway test filesystem: segfaults on bash and libc.so
> from the root filesystem.  But no permanent damage done there.)
>=20
> One oddity I noticed in scrutinizing that commit, didn't help with
> the issues above, but there's a hunk in ext4_rename() which changes
> -	old.dir->i_ctime =3D old.dir->i_mtime =3D current_time(old.dir);
> +	old.dir->i_mtime =3D inode_set_ctime_current(old.inode);
>=20

That actually looks fine. We're just setting the in-memory inode
timestamp there. The problem you're having sounds more like something is
going wrong when storing the values to disk. I'll take a closer look.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
