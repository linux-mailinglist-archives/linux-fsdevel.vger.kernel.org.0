Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148005A2D52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbiHZRTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 13:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238718AbiHZRTm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:19:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C68D87F3;
        Fri, 26 Aug 2022 10:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EF53B8320B;
        Fri, 26 Aug 2022 17:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C497C433D6;
        Fri, 26 Aug 2022 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661534379;
        bh=vuEokndF506qRdyhDYmaWg4LZphgo/7UF9f2EnSu4xo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uRV4ZO47e1JugjRw4RVdrrpCHpR5bO4DvYgEkHIvcIjZ+lXuT1cBKl/AuPb6guZUs
         QDU296S9F4xsGChwu2sswCDeANzItTmyiRPDt6L/ni7NfFynjd6RN0vlCwH3F/fc3f
         Z7QIZ8FofXlaZRyedQNWiiJWSr7mo/69bslYAgkEK6/ZTwfbW5WEqidCS4+rh06SXl
         uR6fLYO46w9SsnXWQkpOf/CXGbw+yUMdxsKsyu7+e2IoLr1PpifubP3Z7lS5cInr3b
         lCgvHJstqBOvz0YgwjFkINWO/qDNOg0Bsi4POKI573SdJdMEwyHTJNhufBaI8tlffl
         iZpkxUmjkk3jw==
Message-ID: <3543250c8157c3e0e7e410b268121e4d7d3e9bc2.camel@kernel.org>
Subject: Re: [PATCH v4 0/9] make statx() return DIO alignment information
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Date:   Fri, 26 Aug 2022 13:19:37 -0400
In-Reply-To: <20220722071228.146690-1-ebiggers@kernel.org>
References: <20220722071228.146690-1-ebiggers@kernel.org>
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

On Fri, 2022-07-22 at 00:12 -0700, Eric Biggers wrote:
> This patchset makes the statx() system call return direct I/O (DIO)
> alignment information.  This allows userspace to easily determine
> whether a file supports DIO, and if so with what alignment restrictions.
>=20
> Patch 1 adds the basic VFS support for STATX_DIOALIGN.  Patch 2 wires it
> up for all block device files.  The remaining patches wire it up for
> regular files on ext4, f2fs, and xfs.  Support for regular files on
> other filesystems can be added later.
>=20
> I've also written a man-pages patch, which I'm sending separately.
>=20
> Note, f2fs has one corner case where DIO reads are allowed but not DIO
> writes.  The proposed statx fields can't represent this.  My proposal
> (patch 6) is to just eliminate this case, as it seems much too weird.
> But I'd appreciate any feedback on that part.
>=20
> This patchset applies to v5.19-rc7.
>=20
> Changed v3 =3D> v4:
>    - Added xfs support.
>=20
>    - Moved the helper function for block devices into block/bdev.c.
>   =20
>    - Adjusted the ext4 patch to not introduce a bug where misaligned DIO
>      starts being allowed on encrypted files when it gets combined with
>      the patch "iomap: add support for dma aligned direct-io" that is
>      queued in the block tree for 5.20.
>=20
>    - Made a simplification in fscrypt_dio_supported().
>=20
> Changed v2 =3D> v3:
>    - Dropped the stx_offset_align_optimal field, since its purpose
>      wasn't clearly distinguished from the existing stx_blksize.
>=20
>    - Renamed STATX_IOALIGN to STATX_DIOALIGN, to reflect the new focus
>      on DIO only.
>=20
>    - Similarly, renamed stx_{mem,offset}_align_dio to
>      stx_dio_{mem,offset}_align, to reflect the new focus on DIO only.
>=20
>    - Wired up STATX_DIOALIGN on block device files.
>=20
> Changed v1 =3D> v2:
>    - No changes.
>=20
> Eric Biggers (9):
>   statx: add direct I/O alignment information
>   vfs: support STATX_DIOALIGN on block devices
>   fscrypt: change fscrypt_dio_supported() to prepare for STATX_DIOALIGN
>   ext4: support STATX_DIOALIGN
>   f2fs: move f2fs_force_buffered_io() into file.c
>   f2fs: don't allow DIO reads but not DIO writes
>   f2fs: simplify f2fs_force_buffered_io()
>   f2fs: support STATX_DIOALIGN
>   xfs: support STATX_DIOALIGN
>=20
>  block/bdev.c              | 25 ++++++++++++++++++++
>  fs/crypto/inline_crypt.c  | 49 +++++++++++++++++++--------------------
>  fs/ext4/ext4.h            |  1 +
>  fs/ext4/file.c            | 37 ++++++++++++++++++++---------
>  fs/ext4/inode.c           | 36 ++++++++++++++++++++++++++++
>  fs/f2fs/f2fs.h            | 45 -----------------------------------
>  fs/f2fs/file.c            | 45 ++++++++++++++++++++++++++++++++++-
>  fs/stat.c                 | 14 +++++++++++
>  fs/xfs/xfs_iops.c         |  9 +++++++
>  include/linux/blkdev.h    |  4 ++++
>  include/linux/fscrypt.h   |  7 ++----
>  include/linux/stat.h      |  2 ++
>  include/uapi/linux/stat.h |  4 +++-
>  13 files changed, 190 insertions(+), 88 deletions(-)
>=20
> base-commit: ff6992735ade75aae3e35d16b17da1008d753d28

Hi Eric,

Can I ask what your plans are with this set? I didn't see it in
linux-next yet, so I wasn't sure when you were looking to get it merged.
I'm working on patches to add a new statx field for the i_version
counter as well and I want to make sure that our work doesn't collide.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
