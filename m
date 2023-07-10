Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0115C74D7B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 15:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjGJNdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjGJNdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B68019F;
        Mon, 10 Jul 2023 06:32:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5933560FE9;
        Mon, 10 Jul 2023 13:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E3BC433C9;
        Mon, 10 Jul 2023 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688995962;
        bh=ypo6EEC/a10vTp0LME1omXwBE1UiKK/mReyAl6l5UHQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J7Z7W1QfjLNRfgVQcSdKnYFRxtD+3fk+fVeHY9xuci1TKV61DCMVSYVvDG9kwuCBX
         g+QpzC0XDkSjeL9nV9+lGdPbp68Q96EXBiPlDNXBynN9HrAz4Y+E89ZYAnFm4gMFob
         SGwQAd+JWX6wsLqjr9V4UXCKsBkrO6/s1MT1FJcjDjR0RhV1HnH8M/padgIYfYI3iT
         50AKfuQ1Ba3eH+A3TeCdkft2SWR53hIVATzxttJnSld1dtaOLY6XNcMPkiIrdtp3w+
         UMgZy7XJf81pa8iQgs3v7vGfymFo80jGgmK2T6kIjmEHcqRaAvCUmLi8QnIHmVmDpT
         pZFJemBst7t+w==
Message-ID: <c4eaff9389fe63ec4e29404ec0d1181b74935426.camel@kernel.org>
Subject: Re: [PATCH v2 00/89] fs: new accessors for inode->i_ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     jk@ozlabs.org, arnd@arndb.de, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, cmllamas@google.com,
        surenb@google.com, dennis.dalessandro@cornelisnetworks.com,
        jgg@ziepe.ca, leon@kernel.org, bwarrum@linux.ibm.com,
        rituagar@linux.ibm.com, ericvh@kernel.org, lucho@ionkov.net,
        asmadeus@codewreck.org, linux_oss@crudebyte.com, dsterba@suse.com,
        dhowells@redhat.com, marc.dionne@auristor.com,
        viro@zeniv.linux.org.uk, raven@themaw.net, luisbg@kernel.org,
        salah.triki@gmail.com, aivazian.tigran@gmail.com,
        ebiederm@xmission.com, keescook@chromium.org, clm@fb.com,
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
Date:   Mon, 10 Jul 2023 09:32:23 -0400
In-Reply-To: <20230710-zudem-entkam-bb508cbd8c78@brauner>
References: <20230705185812.579118-1-jlayton@kernel.org>
         <5e40891f6423feb5b68f025e31f26e9a50ae9390.camel@kernel.org>
         <20230710-zudem-entkam-bb508cbd8c78@brauner>
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

On Mon, 2023-07-10 at 14:35 +0200, Christian Brauner wrote:
> On Fri, Jul 07, 2023 at 08:42:31AM -0400, Jeff Layton wrote:
> > On Wed, 2023-07-05 at 14:58 -0400, Jeff Layton wrote:
> > > v2:
> > > - prepend patches to add missing ctime updates
> > > - add simple_rename_timestamp helper function
> > > - rename ctime accessor functions as inode_get_ctime/inode_set_ctime_=
*
> > > - drop individual inode_ctime_set_{sec,nsec} helpers
> > >=20
> >=20
> > After review by Jan and others, and Jan's ext4 rework, the diff on top
> > of the series I posted a couple of days ago is below. I don't really
> > want to spam everyone with another ~100 patch v3 series, but I can if
> > you think that's best.
> >=20
> > Christian, what would you like me to do here?
>=20
> I picked up the series from the list and folded the fixups you posted
> here into the respective fs conversion patches. I hope that helps you
> avoid a resend. You should have received a separate "thank you" mail for
> all of this.
>=20
> To each patch that I folded one of the fixlets from below into I added a
> git note that records a link to your mail here and the respective patch
> hunk from this mail that I folded into the patch. git.kernel.org will
> show notes by default. For example,
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dv=
fs.ctime&id=3D8b0e3c2e99004609a16ba145bcbdfdddb78e220e
> should show you the note I added. You can also fetch them via
> git fetch $remote refs/notes/*:refs/notes/*
> (You probably know that ofc but jic.) if you're interested.
>=20
> Based on v6.5-rc1 as of today.
>=20

Many thanks!!! I'll get to work rebasing the multigrain timestamp series
on top of that.

> Btw, both b4 and patchwork somehow treat the series in weird was.
> IOW, based on the message id of the cover letter I was able to pull most
> messages except for:
>=20
> [07/92] fs: add ctime accessors infrastructure
> [08/92] fs: new helper: simple_rename_timestamp
> [92/92] fs: rename i_ctime field to __i_ctime
>=20
> which I pulled in separately. Not sure what the cause of=A0
>=20
> this is.

Good to know.

I ended up doing the send in two phases: one for the cover letter and
infrastructure patches that went to everyone, and one for the per-
subsystem patches that went do individual maintainers and lists.

I suspect that screwed up the message IDs somehow. Hopefully I won't
need to do a posting like that again soon, but I'll pay closer attention
to the message id handling next time.

Thanks again!
--=20
Jeff Layton <jlayton@kernel.org>
