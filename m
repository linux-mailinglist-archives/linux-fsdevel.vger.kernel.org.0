Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F3964443D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 14:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiLFNMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 08:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiLFNMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:12:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6942C0;
        Tue,  6 Dec 2022 05:11:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE348B81974;
        Tue,  6 Dec 2022 13:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76B1C433C1;
        Tue,  6 Dec 2022 13:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670332312;
        bh=VVHMOEJUAAOA/RtsQv7QMpPJdj1/u6S3jZMKl5TJ8GI=;
        h=Subject:From:To:Cc:Date:From;
        b=F5UWSOaEDoHnHXcU43B6TM2774yeZtYXZDnrTEFERzcizLauw+q4z7w0sFjdCwgEM
         huAj5OJJFPWgQSasfmi4uSSS0OEX+Y/vxsmi7RfTQRerMNS7IXQxgC9+IHe2N0OqIZ
         bykRXwyVOVqRyoc2ZEZQLSZORUpf+x/W73Tp2mH5y4C+h+qTI4v1cI/UEl5NH7CyA3
         KziTvZKgDn8+FDKW1SwLaWiaZj2iBzMLqBurHa2fwOVe++oPEQ7ja2MDh/VmYHn9OY
         l/sKhKiPELag18Tz4hheNehfCMFkjfrdaMTT5UjiZ1sVXJx2riaWScvR+0WdK7fEH+
         a3gv6qN6lIAkQ==
Message-ID: <d3ba2c7f26958242c0a31b8f966e7c3d251a9e0f.camel@kernel.org>
Subject: [GIT PULL] file locking changes for v6.2-rc1
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 06 Dec 2022 08:11:43 -0500
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-U/x8SEMmkxi22ZtjFzj9"
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-U/x8SEMmkxi22ZtjFzj9
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa=
:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/lock=
s-v6.2

for you to fetch changes up to f2f2494c8aa3cc317572c4674ef256005ebc092b:

  Add process name and pid to locks warning (2022-11-30 05:08:10 -0500)

----------------------------------------------------------------
The main change here is to add the new locks_inode_context helper, and
convert all of the places that dereference inode->i_flctx directly to
use that instead.

There a new helper to indicate whether any locks are held on an inode.
This is mostly for Ceph but may be usable elsewhere too.

Andi Kleen requested that we print the PID when the LOCK_MAND warning
fires, to help track down applications trying to use it.

Finally, we added some new warnings to some of the file locking
functions that fire when the ->fl_file and filp arguments differ. This
helped us find some long-standing bugs in lockd. Patches for those are
in Chuck Lever's tree and should be in his v6.2 PR. After that patch,
people using NFSv2/v3 locking may see some warnings fire until those go
in.

Happy Holidays!
----------------------------------------------------------------
Andi Kleen (1):
      Add process name and pid to locks warning

Jeff Layton (9):
      filelock: WARN_ON_ONCE when ->fl_file and filp don't match
      filelock: new helper: vfs_inode_has_locks
      filelock: add a new locks_inode_context accessor function
      ceph: use locks_inode_context helper
      cifs: use locks_inode_context helper
      ksmbd: use locks_inode_context helper
      lockd: use locks_inode_context helper
      nfs: use locks_inode_context helper
      nfsd: use locks_inode_context helper

 fs/ceph/locks.c     |  4 ++--
 fs/cifs/file.c      |  2 +-
 fs/ksmbd/vfs.c      |  2 +-
 fs/lockd/svcsubs.c  |  4 ++--
 fs/locks.c          | 50 ++++++++++++++++++++++++++++++++++++++-----------=
-
 fs/nfs/delegation.c |  2 +-
 fs/nfs/nfs4state.c  |  2 +-
 fs/nfs/pagelist.c   |  2 +-
 fs/nfs/write.c      |  4 ++--
 fs/nfsd/nfs4state.c |  6 +++---
 include/linux/fs.h  | 20 ++++++++++++++++++++
 11 files changed, 72 insertions(+), 26 deletions(-)

--=20
Jeff Layton <jlayton@kernel.org>

--=-U/x8SEMmkxi22ZtjFzj9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAmOPP48THGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFfJND/4p6X6SWmAXSzBgZ7EOT/dnC66PllS1
KO50o2DfeiIapxkvqzOo49YyGovbFMcdQqWNXcBJ3TdSZ2v18FRcrnp47UU/MnPU
pz3bgdqDteDwsEEQPPSSpgFZr4CpokiwoFiHARKz0DdbJFRefN7CcL99whaNDioR
VS6w0bysdNxesED9asHOl8MzzmKvbiOQV7/SHLOjIrxm+FwrSFkkC4ReO3UMZp72
HxK80v4IF1Aarw2rd/+8jUsEiwWHRpWkYS1mxT6pIUqJrwFkBue6kkoUlmd5GaUl
fqsQE8EQcuQHACHPd07MiH/VLgnNyOpY9KbHZoLf1JFDEWuXapVrIlg9iNuR/oT4
wLJbC5U5HaOJlG5mcnOsg6KFc3+6Gf9BGuD8SPKhlGroHTPlb78+Xh8jPAdeOwn+
nsEO9njtMdt7uR1AAJIyv8SvrC/ZuPc0kR3rQ3CVkG4yIBrnjsgul5MkBVjsImwF
jYT7oQwDokTFGryROOt9nzW6O2bmcwin1NfUCA80iVaIm0JXW8IXii5/RT5vxmei
4bNqNkQLrHU48OBtW3yz5YG/g9lZme71f+M8QUzRfSkGk1lTcDDMtjIZAK6OphpJ
baITwvncNSkq7zmf03SpaN+l1GYK9A20BVdA1gu59qmanF/Fy532qbrotFEpLbJY
yNqzj5LP4OrxJQ==
=1wv0
-----END PGP SIGNATURE-----

--=-U/x8SEMmkxi22ZtjFzj9--
