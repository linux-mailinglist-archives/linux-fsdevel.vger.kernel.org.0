Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4CD74A576
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 23:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjGFVDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 17:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGFVC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:02:57 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8619A7;
        Thu,  6 Jul 2023 14:02:55 -0700 (PDT)
Received: from localhost (2.general.sarnold.us.vpn [10.172.64.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EC65D3F31B;
        Thu,  6 Jul 2023 21:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688677359;
        bh=wL7I+1AkkXlsdAXc0IgIVs00VMlkDlPzLoO7HtCH8Yo=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=UigHgg1tEN+F2JYmBK+lUOcRBpRtdrNgGbqup1NnaXOwyODWf/TTOdnjSM3EJKV2r
         nSVjFudDceCGObMlTU+uma1muY2uaIkS7sazvVomlUh2z4Cx6T6ypWSOKoKTLr1e7n
         Ld2z62ONf1z9dg8T10Z72Jl2h0B3vIxrVCycmYrM1jOwV4H0NyvFgu4GNfgDT4ln1d
         cD6OBnHOJHdcMdNwqptcYXDLv4IErHsYENHamhLEH+hxLeB02yXRDCQTTC0JuBjK6l
         ZNgX1V/W8Fy+2Orhx/aZTqqWjx/zv/bYCRboXEZa1I0V5mrDoaohFkaxDrb57pylVz
         OTISOPjT4Hs9A==
Date:   Thu, 6 Jul 2023 21:02:36 +0000
From:   Seth Arnold <seth.arnold@canonical.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>, jk@ozlabs.org, arnd@arndb.de,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        cmllamas@google.com, surenb@google.com,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org, bwarrum@linux.ibm.com, rituagar@linux.ibm.com,
        ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, dsterba@suse.com, dhowells@redhat.com,
        marc.dionne@auristor.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, luisbg@kernel.org, salah.triki@gmail.com,
        aivazian.tigran@gmail.com, ebiederm@xmission.com,
        keescook@chromium.org, clm@fb.com, josef@toxicpanda.com,
        xiubli@redhat.com, idryomov@gmail.com, jaharkes@cs.cmu.edu,
        coda@cs.cmu.edu, jlbec@evilplan.org, hch@lst.de, nico@fluxnic.net,
        rafael@kernel.org, code@tyhicks.com, ardb@kernel.org,
        xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, linkinjeon@kernel.org,
        sj1557.seo@samsung.com, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        hirofumi@mail.parknet.co.jp, miklos@szeredi.hu,
        rpeterso@redhat.com, agruenba@redhat.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        mikulas@artax.karlin.mff.cuni.cz, mike.kravetz@oracle.com,
        muchun.song@linux.dev, dwmw2@infradead.org, shaggy@kernel.org,
        tj@kernel.org, trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, konishi.ryusuke@gmail.com,
        anton@tuxera.com, almaz.alexandrovich@paragon-software.com,
        mark@fasheh.com, joseph.qi@linux.alibaba.com, me@bobcopeland.com,
        hubcap@omnibond.com, martin@omnibond.com, amir73il@gmail.com,
        mcgrof@kernel.org, yzaikin@google.com, tony.luck@intel.com,
        gpiccoli@igalia.com, al@alarsen.net, sfrench@samba.org,
        pc@manguebit.com, lsahlber@redhat.com, sprasad@microsoft.com,
        senozhatsky@chromium.org, phillip@squashfs.org.uk,
        rostedt@goodmis.org, mhiramat@kernel.org, dushistov@mail.ru,
        hdegoede@redhat.com, djwong@kernel.org, naohiro.aota@wdc.com,
        jth@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        hughd@google.com, akpm@linux-foundation.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        jgross@suse.com, stern@rowland.harvard.edu, lrh2000@pku.edu.cn,
        sebastian.reichel@collabora.com, wsa+renesas@sang-engineering.com,
        quic_ugoswami@quicinc.com, quic_linyyuan@quicinc.com,
        john@keeping.me.uk, error27@gmail.com, quic_uaggarwa@quicinc.com,
        hayama@lineo.co.jp, jomajm@gmail.com, axboe@kernel.dk,
        dhavale@google.com, dchinner@redhat.com, hannes@cmpxchg.org,
        zhangpeng362@huawei.com, slava@dubeyko.com, gargaditya08@live.com,
        penguin-kernel@I-love.SAKURA.ne.jp, yifeliu@cs.stonybrook.edu,
        madkar@cs.stonybrook.edu, ezk@cs.stonybrook.edu,
        yuzhe@nfschina.com, willy@infradead.org, okanatov@gmail.com,
        jeffxu@chromium.org, linux@treblig.org, mirimmad17@gmail.com,
        yijiangshan@kylinos.cn, yang.yang29@zte.com.cn,
        xu.xin16@zte.com.cn, chengzhihao1@huawei.com, shr@devkernel.io,
        Liam.Howlett@Oracle.com, adobriyan@gmail.com,
        chi.minghao@zte.com.cn, roberto.sassu@huawei.com,
        linuszeng@tencent.com, bvanassche@acm.org, zohar@linux.ibm.com,
        yi.zhang@huawei.com, trix@redhat.com, fmdefrancesco@gmail.com,
        ebiggers@google.com, princekumarmaurya06@gmail.com,
        chenzhongjin@huawei.com, riel@surriel.com,
        shaozhengchao@huawei.com, jingyuwang_vip@163.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        autofs@vger.kernel.org, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [apparmor] [PATCH v2 08/92] fs: new helper:
 simple_rename_timestamp
Message-ID: <20230706210236.GB3244704@millbarge>
References: <20230705185812.579118-1-jlayton@kernel.org>
 <20230705185812.579118-3-jlayton@kernel.org>
 <3b403ef1-22e6-0220-6c9c-435e3444b4d3@kernel.org>
 <7c783969641b67d6ffdfb10e509f382d083c5291.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <7c783969641b67d6ffdfb10e509f382d083c5291.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2023 at 08:04:41PM -0400, Jeff Layton wrote:
>=20
> I don't believe it's an issue. I've seen nothing in the POSIX spec that
> mandates that timestamp updates to different inodes involved in an
> operation be set to the _same_ value. It just says they must be updated.
>=20
> It's also hard to believe that any software would depend on this either,
> given that it's very inconsistent across filesystems today. AFAICT, this
> was mostly done in the past just as a matter of convenience.

I've seen this assumption in several programs:

mutt buffy.c
https://sources.debian.org/src/mutt/2.2.9-1/buffy.c/?hl=3D625#L625

  if (mailbox->newly_created &&
      (sb->st_ctime !=3D sb->st_mtime || sb->st_ctime !=3D sb->st_atime))
    mailbox->newly_created =3D 0;


neomutt mbox/mbox.c
https://sources.debian.org/src/neomutt/20220429+dfsg1-4.1/mbox/mbox.c/?hl=
=3D1820#L1820

  if (m->newly_created && ((st.st_ctime !=3D st.st_mtime) || (st.st_ctime !=
=3D st.st_atime)))
    m->newly_created =3D false;


screen logfile.c
https://sources.debian.org/src/screen/4.9.0-4/logfile.c/?hl=3D130#L130

  if ((!s->st_dev && !s->st_ino) ||             /* stat failed, that's new!=
 */
      !s->st_nlink ||                           /* red alert: file unlinked=
 */
      (s->st_size < o.st_size) ||               /*           file truncated=
 */
      (s->st_mtime !=3D o.st_mtime) ||            /*            file modifi=
ed */
      ((s->st_ctime !=3D o.st_ctime) &&           /*     file changed (move=
d) */
       !(s->st_mtime =3D=3D s->st_ctime &&          /*  and it was not a ch=
ange */
         o.st_ctime < s->st_ctime)))            /* due to delayed nfs write=
 */
  {

nemo libnemo-private/nemo-vfs-file.c
https://sources.debian.org/src/nemo/5.6.5-1/libnemo-private/nemo-vfs-file.c=
/?hl=3D344#L344

		/* mtime is when the contents changed; ctime is when the
		 * contents or the permissions (inc. owner/group) changed.
		 * So we can only know when the permissions changed if mtime
		 * and ctime are different.
		 */
		if (file->details->mtime =3D=3D file->details->ctime) {
			return FALSE;
		}


While looking for more examples, I found a perl test that seems to suggest
that at least Solaris, AFS, AmigaOS, DragonFly BSD do as you suggest:
https://sources.debian.org/src/perl/5.36.0-7/t/op/stat.t/?hl=3D158#L140


Thanks

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEQVAQ8bojyMcg37H18yFyWZ2NLpcFAmSnK+gACgkQ8yFyWZ2N
Lpd3gQf6AtE8sBL09BSTvT1P5I8tCXnJ4U7VbzQxWTcKAQHRpyZn8IRSdWuxiPEU
soaBmSx6jov+kkZYX5uP1LSM1INMYpJTJELGas9A7wenNppBGS07LjwAL40wouPm
UfcVWQqOgM8eoseMKBKePv5TkTJFn/M3cPK9Wy31E+qF1IPMNtxz9JKz109YlDOO
FxVTwBGGxxKvx3SsUl6hdaqBCK3omZlbWCzqSyqBzzvjgZ01VC5ktw5FuuTABbu8
TScNnT5GtO5AE8RV0T3TKISm19xD69JHQt/etFeU2yKwiBsn89pY4Xut3CrxbSQm
prQ7ssP3/fi41WxFFDQzO/oQok/b+A==
=/KNl
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
