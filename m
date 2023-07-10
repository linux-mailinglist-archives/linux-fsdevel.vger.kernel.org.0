Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2DB74D5A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 14:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjGJMgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGJMgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD37DB;
        Mon, 10 Jul 2023 05:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52A8360FE9;
        Mon, 10 Jul 2023 12:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3A7C433CB;
        Mon, 10 Jul 2023 12:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688992570;
        bh=H2xgbjqXpjCIL1YrRX5e2Lm0dCE6nhNpxkhLzNT5ua0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYBFwi445q0lt0ZphYZpLmOt5wR+meJbqPSRhxet7P0iiPRYgnHSi9LobGg38wRHk
         YRw3H+QXcyvvByqsJ+4wCmkCN6cf2UfzMYa1sqxLulNzp2UeGTyc0ij28Jne5oQ1T1
         3RwWXPXG0ww5I/wkFqIbXj1fKOk/tlA6pnousvcLf4fNGPnso9ohJABAD43u0T4XNZ
         4qx5bhLf1Dg7cYvF3ikt77ixrICUwaQpwn/PA/WiTF+kWZvjsjd1ey6AFXxc5U5x4u
         9w1gOuNArxobHqFss0Ukd6pKRPqY5GTMTdaOCIUwXl2G+JmZTqpL3AJhz3XT+Fb/gm
         tN6yuNjSBVu7g==
Date:   Mon, 10 Jul 2023 14:35:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
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
Subject: Re: [PATCH v2 00/89] fs: new accessors for inode->i_ctime
Message-ID: <20230710-zudem-entkam-bb508cbd8c78@brauner>
References: <20230705185812.579118-1-jlayton@kernel.org>
 <5e40891f6423feb5b68f025e31f26e9a50ae9390.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e40891f6423feb5b68f025e31f26e9a50ae9390.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 07, 2023 at 08:42:31AM -0400, Jeff Layton wrote:
> On Wed, 2023-07-05 at 14:58 -0400, Jeff Layton wrote:
> > v2:
> > - prepend patches to add missing ctime updates
> > - add simple_rename_timestamp helper function
> > - rename ctime accessor functions as inode_get_ctime/inode_set_ctime_*
> > - drop individual inode_ctime_set_{sec,nsec} helpers
> > 
> 
> After review by Jan and others, and Jan's ext4 rework, the diff on top
> of the series I posted a couple of days ago is below. I don't really
> want to spam everyone with another ~100 patch v3 series, but I can if
> you think that's best.
> 
> Christian, what would you like me to do here?

I picked up the series from the list and folded the fixups you posted
here into the respective fs conversion patches. I hope that helps you
avoid a resend. You should have received a separate "thank you" mail for
all of this.

To each patch that I folded one of the fixlets from below into I added a
git note that records a link to your mail here and the respective patch
hunk from this mail that I folded into the patch. git.kernel.org will
show notes by default. For example,
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.ctime&id=8b0e3c2e99004609a16ba145bcbdfdddb78e220e
should show you the note I added. You can also fetch them via
git fetch $remote refs/notes/*:refs/notes/*
(You probably know that ofc but jic.) if you're interested.

Based on v6.5-rc1 as of today.

Btw, both b4 and patchwork somehow treat the series in weird was.
IOW, based on the message id of the cover letter I was able to pull most
messages except for:

[07/92] fs: add ctime accessors infrastructure
[08/92] fs: new helper: simple_rename_timestamp
[92/92] fs: rename i_ctime field to __i_ctime

which I pulled in separately. Not sure what the cause of this is.
