Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312AD7A5AA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 09:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjISHO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 03:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjISHO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:14:26 -0400
X-Greylist: delayed 501 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 00:14:19 PDT
Received: from rivendell.linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF4CB119;
        Tue, 19 Sep 2023 00:14:19 -0700 (PDT)
Received: from [192.168.3.211] (unknown [36.44.140.33])
        by rivendell.linuxfromscratch.org (Postfix) with ESMTPSA id 26A431C1DD6;
        Tue, 19 Sep 2023 07:05:30 +0000 (GMT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.0 at rivendell.linuxfromscratch.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfromscratch.org;
        s=cert4; t=1695107155;
        bh=9wNEeAzCOPg0mCdyHRKNEVbZmXBmTaugcI3ERiby3k0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=aqoK/Ilc8LvyUE+Xk4kK0TbIhFHarWsn2uBwrCvOIBF6xZoiA1f4tJ9dbKWFKRiu6
         paL+GBbo9SPpEBIbiWrsPB0XfpKTd2+G50VtbF86FGHEVOMJSrRDmkMaTUMORk6h/3
         qLapgrTCCQmetnyxXQd0oMfEVgIT+/HKvVoU4IKX272amD2+FjwGF7/9QSILQuggfV
         BI6kNxpQvUY/+hAogUxC35kr9T5IahyPaFtyYIDE5cZir6pdZggqKuZtpzkHOubZ1J
         isHMMtWcQM3xaSsKJn5GsqEfCinyGk71Ww3uWLHV11gy8ssXk8BO2mWnXKo2ok/N19
         WGA2g3mo4aO4w==
Message-ID: <bf0524debb976627693e12ad23690094e4514303.camel@linuxfromscratch.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
From:   Xi Ruoyao <xry111@linuxfromscratch.org>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jan Kara <jack@suse.cz>, bug-gnulib@gnu.org
Date:   Tue, 19 Sep 2023 15:05:24 +0800
In-Reply-To: <20230807-mgctime-v7-12-d1dec143a704@kernel.org>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
         <20230807-mgctime-v7-12-d1dec143a704@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-08-07 at 15:38 -0400, Jeff Layton wrote:
> Enable multigrain timestamps, which should ensure that there is an
> apparent change to the timestamp whenever it has been written after
> being actively observed via getattr.
>=20
> For ext4, we only need to enable the FS_MGTIME flag.

Hi Jeff,

This patch causes a gnulib test failure:

$ ~/sources/lfs/grep-3.11/gnulib-tests/test-stat-time
test-stat-time.c:141: assertion 'statinfo[0].st_mtime < statinfo[2].st_mtim=
e || (statinfo[0].st_mtime =3D=3D statinfo[2].st_mtime && (get_stat_mtime_n=
s (&statinfo[0]) < get_stat_mtime_ns (&statinfo[2])))' failed
Aborted (core dumped)

The source code of the test:
https://git.savannah.gnu.org/cgit/gnulib.git/tree/tests/test-stat-time.c

Is this an expected change?

> Acked-by: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> =C2=A0fs/ext4/super.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b54c70e1a74e..cb1ff47af156 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -7279,7 +7279,7 @@ static struct file_system_type ext4_fs_type =3D {
> =C2=A0	.init_fs_context	=3D ext4_init_fs_context,
> =C2=A0	.parameters		=3D ext4_param_specs,
> =C2=A0	.kill_sb		=3D kill_block_super,
> -	.fs_flags		=3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +	.fs_flags		=3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP |
> FS_MGTIME,
> =C2=A0};
> =C2=A0MODULE_ALIAS_FS("ext4");
> =C2=A0
>=20

