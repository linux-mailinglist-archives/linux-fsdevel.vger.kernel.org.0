Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10655198C88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 08:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgCaGvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 02:51:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36277 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgCaGvO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 02:51:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48s0NF5DDKz9sPg;
        Tue, 31 Mar 2020 17:51:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585637472;
        bh=bGCLt/u6mOmUcDFcwsOBrb7E8bHaVai/HaineZ9vnQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RFTXfi3a/QD4BHKbMQz1QjLLSFQLtuPI1Jvrlq//aBBWgGkgNa4bAgt3b0DVzBVCE
         JnS7hmzcQMlxRmbfH2udYJ/ecshDMElI2LZ1XHWd1TlVw6A46EXof95e3seIjRG92B
         BtY+PbdrN6X8y5jMu7KsnmDJtKSDOz/Q31s/FD9pqIw72njcBSQQ8EdDRXeQuIiAXn
         ZE2In8clMaU+8P0vLcAFpqOpvsR3kDgy8sstS7ftm4C2jsISPcaS/QvBNmS9MWEL59
         b+18qS4cctQ6K+Xfwa10d+hgaI0HdxAlzlFWSSOVTobbArpLoAhW1ZF98fvLTmBUFV
         0+gt9CjUNhnqQ==
Date:   Tue, 31 Mar 2020 17:51:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        dray@redhat.com, kzak@redhat.com, mszeredi@redhat.com,
        swhiteho@redhat.com, jlayton@redhat.com, raven@themaw.net,
        andres@anarazel.de, christian.brauner@ubuntu.com,
        jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-ID: <20200331175108.588b80c0@canb.auug.org.au>
In-Reply-To: <1449138.1585578664@warthog.procyon.org.uk>
References: <1445647.1585576702@warthog.procyon.org.uk>
        <1449138.1585578664@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ADYCqD70cxQvyKWhrdsW12R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/ADYCqD70cxQvyKWhrdsW12R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 30 Mar 2020 15:31:04 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
>       pipe: Add general notification queue support

This commit has a (reasonably simple) conflict against commit

  6551d5c56eb0 ("pipe: make sure to wake up everybody when the last reader/=
writer closes")

from Linus' tree.

Also a semantic conflict against commit

  52b31bc9aabc ("io_uring: add splice(2) support")

from the block tree needing this fix up (white space damaged)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index fb8fe0bd5e18..8cdd3870cd4e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2470,7 +2470,7 @@ static int io_splice_prep(struct io_kiocb *req, const=
 struct io_uring_sqe *sqe)
=20
 static bool io_splice_punt(struct file *file)
 {
-	if (get_pipe_info(file))
+	if (get_pipe_info(file, true))
 		return false;
 	if (!io_file_supports_async(file))
 		return true;
>	security: Add hooks to rule on setting a watch
>	security: Add a hook for the point of notification insertion

And these have a conflict against commitinclude/linux/lsm_hooks.h

  98e828a0650f ("security: Refactor declaration of LSM hooks")

from the bpf-next tree (will be in the net-next tree pull).  That
requires taking the net-next version of include/linux/lsm_hooks.h and
then applying the following patch:

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9cd4455528e5..4f8d63fd1327 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -252,6 +252,16 @@ LSM_HOOK(int, 0, inode_notifysecctx, struct inode *ino=
de, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ct=
xlen)
 LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
 	 u32 *ctxlen)
+#ifdef CONFIG_KEY_NOTIFICATIONS
+LSM_HOOK(int, 0, watch_key, struct key *key)
+#endif
+#ifdef CONFIG_DEVICE_NOTIFICATIONS
+LSM_HOOK(int, 0, watch_devices, void)
+#endif
+#ifdef CONFIG_WATCH_QUEUE
+LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
+	 const struct cred *cred, struct watch_notification *n)
+#endif
=20
 #ifdef CONFIG_SECURITY_NETWORK
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *othe=
r,

--=20
Cheers,
Stephen Rothwell

--Sig_/ADYCqD70cxQvyKWhrdsW12R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6C6FwACgkQAVBC80lX
0Gzu0wf+LiRwTbiERIhH0CCtMDGKGwnN9AytVinsNAuHxXdlMgmLpMKKkO6Y45CJ
xJtvK/JAkBX1Hmt21jmbuWIMKpQQ+Egz/9J1ZrivaOLsPcFo6nXAuMHXQD/6g4/y
7Knm4iGOMAAOG5fgI/vujVmgFCABaH4V5qOYAnS5iZhV91JtQlnIsHpUe9gFzCMb
JdoOaQHIJqSYZUnDxgRZ9w3qXtnor2dBLZUrD2xtGp6XmHj/1aOv42cP47VyC4P9
yiXHpoGyQ/w6b2fqmvUHd0AY1ThM/4EL1fgS6DWeoXAQPzLa4ppj3i2R+354fjO1
EwHWYnPAMmDpWOO0BPFiW3yA9R10mQ==
=EyQE
-----END PGP SIGNATURE-----

--Sig_/ADYCqD70cxQvyKWhrdsW12R--
