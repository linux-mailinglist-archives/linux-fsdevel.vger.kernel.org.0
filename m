Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CD42277A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 06:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgGUEcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 00:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgGUEcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:32:41 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4484C061794;
        Mon, 20 Jul 2020 21:32:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B9m0f3SVBz9sRR;
        Tue, 21 Jul 2020 14:32:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595305959;
        bh=w4Xy1OgH4XG7gHLmS4cliPvXoO5Wdfn568mqok1NPAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X/TV8w6MxL0/pdF660WExLs8QnY78mVX37uAVGP8YwhJmpVc/cd2ONOi2Eqb6xpqN
         8tR+HCEEfKsyIDxQm6kgelL0AWd4IgISGHxncpZEa5u6u5LdL2iIP7HceBmK6Ftife
         aU+CnFPjx4DrzopWsIvXKh2T06M2tXo4Xd8IOuyo3wE3EDkoJ9wPN8EFNyEJLJRR+n
         Bxs0dH05MsfQaOLpj12TgdsobhkNKMKtnC9rYmrvCnGesLxVrk2kUC6mcGhyVJP96O
         SyuJ071yfB/ROvr8C9HSkQiq6MvwUfg6uZMtQynnRpBd7ed7ELBqVAuwIw9rwaRx3I
         ZkpE8y1ckMpkw==
Date:   Tue, 21 Jul 2020 14:32:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Qian Cai <cai@lca.pw>
Cc:     syzbot <syzbot+75867c44841cb6373570@syzkaller.appspotmail.com>,
        Markus.Elfring@web.de, casey@schaufler-ca.com, dancol@google.com,
        hdanton@sina.com, jmorris@namei.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stephen.smalley.work@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        yanfei.xu@windriver.com, linux-next@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in userfaultfd_release (2)
Message-ID: <20200721143233.23c89f2a@canb.auug.org.au>
In-Reply-To: <20200720155024.GC7354@lca.pw>
References: <0000000000001bbb6705aa49635a@google.com>
        <000000000000cfc8ff05aa546b84@google.com>
        <20200717150540.GB31206@lca.pw>
        <20200720155024.GC7354@lca.pw>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/toEnhpP1bjnOrholb_30qUQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/toEnhpP1bjnOrholb_30qUQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Jul 2020 11:50:25 -0400 Qian Cai <cai@lca.pw> wrote:
>
> On Fri, Jul 17, 2020 at 11:05:41AM -0400, Qian Cai wrote:
> > On Mon, Jul 13, 2020 at 08:34:06AM -0700, syzbot wrote: =20
> > > syzbot has bisected this bug to:
> > >=20
> > > commit d08ac70b1e0dc71ac2315007bcc3efb283b2eae4
> > > Author: Daniel Colascione <dancol@google.com>
> > > Date:   Wed Apr 1 21:39:03 2020 +0000
> > >=20
> > >     Wire UFFD up to SELinux
> > >=20
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14a79d=
13100000
> > > start commit:   89032636 Add linux-next specific files for 20200708
> > > git tree:       linux-next
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D16a79d=
13100000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12a79d131=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D64a250eba=
bc6c320
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D75867c44841=
cb6373570
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13c4c8d=
b100000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12cbb68f1=
00000
> > >=20
> > > Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
> > > Fixes: d08ac70b1e0d ("Wire UFFD up to SELinux")
> > >=20
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bi=
section =20
> >=20
> > This is rather easy to reproduce here, =20
>=20
> James, Stephen, can you drop this patch? Daniel's email was bounced, and =
Viro
> mentioned the patch could be quite bad,
>=20
> https://lore.kernel.org/lkml/20200719165746.GJ2786714@ZenIV.linux.org.uk/

I have reverted that commit in linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/toEnhpP1bjnOrholb_30qUQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8Wb+EACgkQAVBC80lX
0Gy4hQgAiOpVA7CVmdcLFC4iyaKl2GvE7+P5ZLPCSOXHu8si0xdVJwvtuOZiuGbT
bSaV/lX5SM1e75PovM+I474GF8kxEPHDtvOA1tN6SUNgtuDTuIPtPbYD/a7anhSt
0FCmj2qQrEEAPgoO2o5Ccuq1RYkBA5P+stEYPzjWg/64OSNSP68R0vfjJfQYOUYU
U9JyXx3psiVlS118+srxeLjjohVjjd3jN09cS+Xwp3AR6ltbdKFIz3uS2VO11pZZ
4lBgRFlqvLX6UE/aY8ky3+2zjSJbAJbZer6unQtoNvEOXNfVK8dDy0V/thZigMkH
+ljiwrUO/tALZNF4ykpcS0Gt0626eA==
=H813
-----END PGP SIGNATURE-----

--Sig_/toEnhpP1bjnOrholb_30qUQ--
