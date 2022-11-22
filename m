Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97016633C46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 13:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiKVMUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 07:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbiKVMUl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:20:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF86D4AF08;
        Tue, 22 Nov 2022 04:20:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97E89B81A52;
        Tue, 22 Nov 2022 12:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BB3C433C1;
        Tue, 22 Nov 2022 12:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669119638;
        bh=omBfWXmMhLMm+WJGcOqaotuYzo99NcFtkFUjLGTxJkU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lCqeNISkHr5FV5oUA/uF7cCqbH3pbaJZzL0H/JeQImnqkxBP/qna4Vwgxuxwwf4kc
         djCzx51ajPQzJsx7t6fcFaQ3CPrg1HyiCa0H584zbvwYZVAhxyYK9KeJP/cZSm7jN0
         AEQFZIjKudut9Bn5O9uHSqMDAio5e4wG5sa2i3DoX7eTRf+obcb5zEzndUU3Fwo275
         rIYFdUuTfDxxMV446wuHU7u2FLiPhi/QMUcdaTapUWa++/h/6C38Q3lKoDzCYdb8Qd
         YelQN+YEM82ey5KUKNOPaXvgHVIDzs2zei/oxdiPIwrOhlWjLs2M+5ia9+Ld6VGXMR
         y+AjrCDtny9iA==
Message-ID: <a731e688122d1a6fdb2f7bdbd71d403fa110e9f2.camel@kernel.org>
Subject: Re: [PATCH] filelock: move file locking definitions to separate
 header file
From:   Jeff Layton <jlayton@kernel.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org
Date:   Tue, 22 Nov 2022 07:20:35 -0500
In-Reply-To: <0c6a44ff-409e-99b2-eaa9-fd6e87a9e104@linux.alibaba.com>
References: <20221120210004.381842-1-jlayton@kernel.org>
         <0c6a44ff-409e-99b2-eaa9-fd6e87a9e104@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 2022-11-22 at 09:51 +0800, Joseph Qi wrote:
> Hi,
>=20
> On 11/21/22 4:59 AM, Jeff Layton wrote:
> > The file locking definitions have lived in fs.h since the dawn of time,
> > but they are only used by a small subset of the source files that
> > include it.
> >=20
> > Move the file locking definitions to a new header file, and add the
> > appropriate #include directives to the source files that need them. By
> > doing this we trim down fs.h a bit and limit the amount of rebuilding
> > that has to be done when we make changes to the file locking APIs.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/9p/vfs_file.c          |   1 +
> >  fs/afs/internal.h         |   1 +
> >  fs/attr.c                 |   1 +
> >  fs/ceph/locks.c           |   1 +
> >  fs/cifs/cifsfs.c          |   1 +
> >  fs/cifs/cifsglob.h        |   1 +
> >  fs/cifs/cifssmb.c         |   1 +
> >  fs/cifs/file.c            |   1 +
> >  fs/cifs/smb2file.c        |   1 +
> >  fs/dlm/plock.c            |   1 +
> >  fs/fcntl.c                |   1 +
> >  fs/file_table.c           |   1 +
> >  fs/fuse/file.c            |   1 +
> >  fs/gfs2/file.c            |   1 +
> >  fs/inode.c                |   1 +
> >  fs/ksmbd/smb2pdu.c        |   1 +
> >  fs/ksmbd/vfs.c            |   1 +
> >  fs/ksmbd/vfs_cache.c      |   1 +
> >  fs/lockd/clntproc.c       |   1 +
> >  fs/lockd/netns.h          |   1 +
> >  fs/locks.c                |   1 +
> >  fs/namei.c                |   1 +
> >  fs/nfs/nfs4_fs.h          |   1 +
> >  fs/nfs_common/grace.c     |   1 +
> >  fs/nfsd/netns.h           |   1 +
> >  fs/ocfs2/locks.c          |   1 +
> >  fs/ocfs2/stack_user.c     |   1 +
>=20
> Seems it misses the related changes in:
> fs/ocfs2/stackglue.c
>=20

I was able to build ocfs2.ko just fine without any changes to
stackglue.c. What problem do you see here?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
