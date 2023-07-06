Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8C374A20B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 18:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjGFQPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 12:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGFQPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:15:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79750DC;
        Thu,  6 Jul 2023 09:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBCAB602F1;
        Thu,  6 Jul 2023 16:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD63C433C7;
        Thu,  6 Jul 2023 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688660118;
        bh=r5Eqjb/koo4X65bgDBYxDesIkgsRAdhnfATQ4gt2Esk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uOgU9evq5o16T6L6tpJH1n8YSQl4p50BjR5wiJPLoKkMzHgO7DWjFII6ePLp5KpdE
         3SlBOVBQ0Ayb1Ck5njyhQkfK/lBmsjOnzq7A/dE1stN3VqJX7pH6IQsgFKtN1DalJo
         E+zh6oq4S0OPw7rIh8zXpFwi+8/fexgoqLXDvhFUUOG0TWnPj5LM1mmg7dIC7PaCB3
         IOEyQDVn/tGwcs+s3mZaJELn1kEqbOemjyG66rmihhs9u/EaGnd4WvmH/942idbgOQ
         fgiPtHR0C+lrv0o8CzKEzOTX/CaJMpmdnCKaL0ZpaSmvJsFgbp9PEliTkXRbGZddzd
         Fm4yxVau37qTQ==
Message-ID: <3948ae7653d1cb7c51febcca26a35775e71a53b4.camel@kernel.org>
Subject: Re: [PATCH v2 00/89] fs: new accessors for inode->i_ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     jk@ozlabs.org, arnd@arndb.de, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
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
        aivazian.tigran@gmail.com, keescook@chromium.org, clm@fb.com,
        josef@toxicpanda.com, xiubli@redhat.com, idryomov@gmail.com,
        jaharkes@cs.cmu.edu, coda@cs.cmu.edu, jlbec@evilplan.org,
        hch@lst.de, nico@fluxnic.net, rafael@kernel.org, code@tyhicks.com,
        ardb@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linkinjeon@kernel.org, sj1557.seo@samsung.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
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
        hdegoede@redhat.com, djwong@kernel.org, dlemoal@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, hughd@google.com, akpm@linux-foundation.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, john.johansen@canonical.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
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
Date:   Thu, 06 Jul 2023 12:14:58 -0400
In-Reply-To: <87ilaxgjek.fsf@email.froward.int.ebiederm.org>
References: <20230705185812.579118-1-jlayton@kernel.org>
         <a4e6cfec345487fc9ac8ab814a817c79a61b123a.camel@kernel.org>
         <87ilaxgjek.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-07-06 at 10:16 -0500, Eric W. Biederman wrote:
> Jeff Layton <jlayton@kernel.org> writes:
>=20
> > On Wed, 2023-07-05 at 14:58 -0400, Jeff Layton wrote:
> > > v2:
> > > - prepend patches to add missing ctime updates
> > > - add simple_rename_timestamp helper function
> > > - rename ctime accessor functions as inode_get_ctime/inode_set_ctime_=
*
> > > - drop individual inode_ctime_set_{sec,nsec} helpers
> > >=20
> > > I've been working on a patchset to change how the inode->i_ctime is
> > > accessed in order to give us conditional, high-res timestamps for the
> > > ctime and mtime. struct timespec64 has unused bits in it that we can =
use
> > > to implement this. In order to do that however, we need to wrap all
> > > accesses of inode->i_ctime to ensure that bits used as flags are
> > > appropriately handled.
> > >=20
> > > The patchset starts with reposts of some missing ctime updates that I
> > > spotted in the tree. It then adds a new helper function for updating =
the
> > > timestamp after a successful rename, and new ctime accessor
> > > infrastructure.
> > >=20
> > > The bulk of the patchset is individual conversions of different
> > > subsysteme to use the new infrastructure. Finally, the patchset renam=
es
> > > the i_ctime field to __i_ctime to help ensure that I didn't miss
> > > anything.
> > >=20
> > > This should apply cleanly to linux-next as of this morning.
> > >=20
> > > Most of this conversion was done via 5 different coccinelle scripts, =
run
> > > in succession, with a large swath of by-hand conversions to clean up =
the
> > > remainder.
> > >=20
> >=20
> > A couple of other things I should note:
> >=20
> > If you sent me an Acked-by or Reviewed-by in the previous set, then I
> > tried to keep it on the patch here, since the respun patches are mostly
> > just renaming stuff from v1. Let me know if I've missed any.
> >=20
> > I've also pushed the pile to my tree as this tag:
> >=20
> >     https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/t=
ag/?h=3Dctime.20230705
> >=20
> > In case that's easier to work with.
>=20
> Are there any preliminary patches showing what you want your introduced
> accessors to turn into?  It is hard to judge the sanity of the
> introduction of wrappers without seeing what the wrappers are ultimately
> going to do.
>=20
> Eric

I have a draft version of the multigrain patches on top of the wrapper
conversion I've already posted in my "mgctime-experimental" branch:

    https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/log/?=
h=3Dmgctime-experimental

The rationale is best explained in this changelog:

    https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commi=
t/?h=3Dmgctime-experimental&id=3Dface437a144d3375afb7f70c233b0644b4edccba

The idea will be to enable this on a per-fs basis.
--=20
Jeff Layton <jlayton@kernel.org>
