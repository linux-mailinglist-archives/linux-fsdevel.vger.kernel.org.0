Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9D1E5761
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 08:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgE1GOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 02:14:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:46002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgE1GOy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 02:14:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 39F5DAB3D;
        Thu, 28 May 2020 06:14:55 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>
Date:   Thu, 28 May 2020 16:14:44 +1000
Subject: The file_lock_operatoins.lock API seems to be a BAD API.
cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Message-ID: <87a71s8u23.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain


How many times does an API need to be misused before we throw it out?

When a file is closed, locks_remove_posix() is called and this
*must* remove all locks.  The 'struct file' will be removed, so
->fl_file will become a dangling link.
But the 'struct file_lock' will still be on the global lock list
and will trigger and oops if anyone reads /proc/locks.

However, locks_remove_posix() will call filp->f_op->lock() if it exists,
and there are one or two (or more) filesystems which seem to think that
it is OK for unlock to fail due to a signal or network error etc.

It isn't that long ago since this sort of problem was fixed in cifs and
cephfs (well... it isn't that long since the fix was backported to a SLE
kernel and I noticed - I don't recall when the fix hit mainline).
It was (partly) fixed in NFS a few years back (f30cb757f) - I just
tripped over this again for an SLE-LTS kernel.

Just this week I've seen the NFS bug and and also a gpfs (out-of-tree
GPL code) bug.
I just wandered through the current code and found ....

orangefs:  This won't remove locks if ORANGEFS_OPT_LOCK_LOCK is not
  set.  It won't add them either so maybe that is OK .... except that I
  think "mount -o remount" can clear that flag.  If you clear it while a
  lock is held - badness results.

fuse - if fc->no_lock is zero - seems to assume that sending a
   request to the daemon - fuse_simple_request() - *will* be
   sufficient.  I wouldn't trust any daemon not to trigger an oops.
   It also assumes that "locking is restartable" - (ok to return
   ERESTARTSYS), but 'locks_remove_posix()' isn't.

gfs2, oscfs both use dlk_posix_lock which will fail if kmalloc() fails
  (which is certainly possible if the close is happening because the
  process was killed by the OOM killer).  I'm not sure if there are
  other failure modes.

NFSv2 and NFSv3 use nlmclnt_proc which can also fail on kmalloc failure.

NFSv4 can nominally fail if 'ctx->state' is NULL - but that is probably
    impossible.  A WARN() might no go astray there.

NFS will allow do_unlk() to fail if a fatal signal is pending, but not
in the FL_CLOSE case, so that protects locks_remove_posix() and
locks_remove_flock().  Maybe other calls to unlock don't matter ... if
there is a fatal signal pending they definitely don't - which makes the
speical-casing of FL_CLOSE rather pointless.

locks_remove_posix() and locks_remove_flock() aren't the only problem
areas.  nfsd will call vfs_setlease(.. F_UNLCK..) and assume that the
lease is gone.  If the filesystem messes up and doesn't remove the
lease, then when the lease subsequently gets broken, it will access some
nfsd data structure that has been freed.  Oops.

I don't think we should just fix all those bugs in those filesystems.
I think that F_UNLCK should *always* remove the lock/lease.
I imaging this happening by  *always* calling posix_lock_file() (or
similar) in the unlock case - after calling f_op->lock() first if that
is appropriate.

What do people think?  It there on obvious reason that is a non-starter?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl7PVtUACgkQOeye3VZi
gblj1g/+LXXisqY51qxu1SIcE909dmuBQD2tXfzj5xJLyiPr9ckOv5aJa6KEbGl4
2+3rdEGFADYCwLbaeZTl30IFJxfSA+WtLLXrFzHQzwMQ5ioAmZEumboYDBg8P2VO
VnHyMieLJXvfRZR1otiNrFsD3vq92YIPDxuHesris7i+9wpG3D7pnPTv/Ltc+92Y
Pjrr/zk0pO8AWadZkSZGRWmtiRN+eaSM8mZoZsD4I3ywFl3+hbbHViKamsgFtAqA
7YSyf+u3x8Xmh6ariEelKtxNIQ7ZCJfbADvYqj+ITHOV4zxAYCIgsciVNLFDDGKd
vF6ihke11FRRfGwQhnLw1YqbsLexZB415gUo3YntYxrrdNx7Tb1CuCh7o7BFeaaG
5zn99ilx1skWetfVamTqp7e4bIte5m8zvRSJpPdPJ/qvQp4mOBWJ3/BwuvjpQaxt
+LRhnpj5HKcj25kBH0/tDkHGnlBbQSVpXhDA1vwHglhl+MxFNT6HRaaW9CMiW4XQ
S0/a62mi5gsomxcgtEOqPvMHkIOz/Xo59T818ARkJ0tB6ircIbnXgIQOnf/4EbMc
NduwGGsLvGUMX55t9LjsV5tWMcXmyq3QTm0pY2HdWwkOZ6lPT74HarjLgECSrVqi
bUgSiKT3iLukkIwCdesTmqAe/G3uML0C5vtA2lWxDQW1YddHYCI=
=t2sC
-----END PGP SIGNATURE-----
--=-=-=--
