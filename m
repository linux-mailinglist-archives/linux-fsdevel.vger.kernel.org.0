Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5741674AEF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 12:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjGGKvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGGKvC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:51:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F221172B;
        Fri,  7 Jul 2023 03:51:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF33561728;
        Fri,  7 Jul 2023 10:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1904CC433C7;
        Fri,  7 Jul 2023 10:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688727060;
        bh=YY2+JZ9K159BEA5iSbeX62sRGYZcpbUaLjQvLugmLbE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jXdQbiZ5Du/aIdze7VeTdm89AeKeYW1m4/7P1K420P54fp2uTq7aOaGBMwqlLnw11
         5T+jXE1w9xr2TFIydSymIs59E5/D60tiQwOrG5t4hwTmZ4+DNTLa0LgW/JlS7C6Rg0
         Mzl7zZGaHcBNbE8fs+RYzBh/pLfQTiwpAzbqUwnaVBq4Wks4CGEmJGniuijWbkznN9
         yKSAP4Wd0VGwzQyH6kGj1b/zaEVMosXLl47jzHBi50p2AWNvdkuhe4kCPVw/2GfwLp
         PcUD4QVeNETkqKyUuCjgzrA8gjstIliNy9GhxSwhdsoWExJoMegiOtBnIsuS31XbZX
         flM91ZzrsjFeA==
Message-ID: <ff1f471a9d33ae01ad570644273e4e579204a3b6.camel@kernel.org>
Subject: Re: [apparmor] [PATCH v2 08/92] fs: new helper:
 simple_rename_timestamp
From:   Jeff Layton <jlayton@kernel.org>
To:     Seth Arnold <seth.arnold@canonical.com>
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
Date:   Fri, 07 Jul 2023 06:50:40 -0400
In-Reply-To: <20230706210236.GB3244704@millbarge>
References: <20230705185812.579118-1-jlayton@kernel.org>
         <20230705185812.579118-3-jlayton@kernel.org>
         <3b403ef1-22e6-0220-6c9c-435e3444b4d3@kernel.org>
         <7c783969641b67d6ffdfb10e509f382d083c5291.camel@kernel.org>
         <20230706210236.GB3244704@millbarge>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Thu, 2023-07-06 at 21:02 +0000, Seth Arnold wrote:
> On Wed, Jul 05, 2023 at 08:04:41PM -0400, Jeff Layton wrote:
> >=20
> > I don't believe it's an issue. I've seen nothing in the POSIX spec that
> > mandates that timestamp updates to different inodes involved in an
> > operation be set to the _same_ value. It just says they must be updated=
.
> >=20
> > It's also hard to believe that any software would depend on this either=
,
> > given that it's very inconsistent across filesystems today. AFAICT, thi=
s
> > was mostly done in the past just as a matter of convenience.
>=20
> I've seen this assumption in several programs:
>=20

Thanks for looking into this!

To be clear, POSIX doesn't require that _different_ inodes ever be set
to the same timestamp value. IOW, it certainly doesn't require that the
source and target directories on a rename() end up with the exact same
timestamp value.

Granted, POSIX is rather vague on timestamps in general, but most of the
examples below involve comparing different timestamps on the _same_
inode.


> mutt buffy.c
> https://sources.debian.org/src/mutt/2.2.9-1/buffy.c/?hl=3D625#L625
>=20
>   if (mailbox->newly_created &&
>       (sb->st_ctime !=3D sb->st_mtime || sb->st_ctime !=3D sb->st_atime))
>     mailbox->newly_created =3D 0;
>=20

This should be fine with this patchset. Note that this is comparing
a/c/mtime on the same inode, and our usual pattern on inode
instantiation is:

    inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_current(inode);

...which should result in all of inode's timestamps being synchronized.

>=20
> neomutt mbox/mbox.c
> https://sources.debian.org/src/neomutt/20220429+dfsg1-4.1/mbox/mbox.c/?hl=
=3D1820#L1820
>=20
>   if (m->newly_created && ((st.st_ctime !=3D st.st_mtime) || (st.st_ctime=
 !=3D st.st_atime)))
>     m->newly_created =3D false;
>=20

Ditto here.

>=20
> screen logfile.c
> https://sources.debian.org/src/screen/4.9.0-4/logfile.c/?hl=3D130#L130
>=20
>   if ((!s->st_dev && !s->st_ino) ||             /* stat failed, that's ne=
w! */
>       !s->st_nlink ||                           /* red alert: file unlink=
ed */
>       (s->st_size < o.st_size) ||               /*           file truncat=
ed */
>       (s->st_mtime !=3D o.st_mtime) ||            /*            file modi=
fied */
>       ((s->st_ctime !=3D o.st_ctime) &&           /*     file changed (mo=
ved) */
>        !(s->st_mtime =3D=3D s->st_ctime &&          /*  and it was not a =
change */
>          o.st_ctime < s->st_ctime)))            /* due to delayed nfs wri=
te */
>   {
>=20

This one is really weird. You have two different struct stat's, "o" and
"s". I assume though that these should be stat values from the same
inode, because otherwise this comparison would make no sense:

      ((s->st_ctime !=3D o.st_ctime) &&           /*     file changed (move=
d) */

In general, we can never contrive to ensure that the ctime of two
different inodes are the same, since that is always set by the kernel to
the current time, and you'd have to ensure that they were created within
the same jiffy (at least with today's code).

> nemo libnemo-private/nemo-vfs-file.c
> https://sources.debian.org/src/nemo/5.6.5-1/libnemo-private/nemo-vfs-file=
.c/?hl=3D344#L344
>=20
> 		/* mtime is when the contents changed; ctime is when the
> 		 * contents or the permissions (inc. owner/group) changed.
> 		 * So we can only know when the permissions changed if mtime
> 		 * and ctime are different.
> 		 */
> 		if (file->details->mtime =3D=3D file->details->ctime) {
> 			return FALSE;
> 		}
>=20

Ditto here with the first examples. This involves comparing timestamps
on the same inode, which should be fine.

>=20
> While looking for more examples, I found a perl test that seems to sugges=
t
> that at least Solaris, AFS, AmigaOS, DragonFly BSD do as you suggest:
> https://sources.debian.org/src/perl/5.36.0-7/t/op/stat.t/?hl=3D158#L140
>=20

(I kinda miss Perl. I wrote a bunch of stuff in it in the 90's and early
naughties)

I think this test is supposed to be testing whether the mtime changes on
link() ?

-----------------8<----------------
    my($nlink, $mtime, $ctime) =3D (stat($tmpfile))[$NLINK, $MTIME, $CTIME]=
;

[...]


        skip "Solaris tmpfs has different mtime/ctime link semantics", 2
                                     if $Is_Solaris and $cwd =3D~ m#^/tmp# =
and
                                        $mtime && $mtime =3D=3D $ctime;
-----------------8<----------------

...again, I think this would be ok too since it's just comparing the
mtime and ctime of the same inode. Granted this is a Solaris-specific
test, but Linux would be fine here too.

So in conclusion, I don't think this patchset will cause problems with
any of the above code.
--=20
Jeff Layton <jlayton@kernel.org>
