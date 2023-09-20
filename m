Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CA07A7654
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjITIvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjITIvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:51:04 -0400
Received: from rivendell.linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7840F93;
        Wed, 20 Sep 2023 01:50:56 -0700 (PDT)
Received: from [192.168.3.211] (unknown [36.44.137.238])
        by rivendell.linuxfromscratch.org (Postfix) with ESMTPSA id 1EF0B1C1DCD;
        Wed, 20 Sep 2023 08:50:31 +0000 (GMT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.0 at rivendell.linuxfromscratch.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfromscratch.org;
        s=cert4; t=1695199854;
        bh=3Z1+GidcJMavvwBcREoqn7oXqIoMxeJ9etaya6Fu9M0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=eObk1KcHIFgyOq0PM0GHhNP2/hul2wPtxGcaRxEcqFDCkKZIPj2t/9TxEWDmhO6YZ
         aezBQiQYv28rq2gmvKDO1vLC0cjJ4lkZqX+AWhOX80av065LcuDU/dQQlCUdAz+F5v
         EMnFKjI7RQ2SB6tMDzdbLxzYFo10Nqo0SoW1H1a/NoxdCJZXpxyBoREnlKsc2adPNi
         tbCaBepclPdYSRgGsku+r9JOsLdUStV6efcHtTldH9x3uUyad5uMYo/g4osBB/tLJ8
         12slT1IuoRsY1p0CjzdaDH1JpjFGWIS5aueo9MwBbmOsZYKMRjHoGNDe8fOb9NSvgA
         Jjo932cwggiGw==
Message-ID: <34d45270efccc44b64af835e73c1d1e111ce5098.camel@linuxfromscratch.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
From:   Xi Ruoyao <xry111@linuxfromscratch.org>
To:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Bruno Haible <bruno@clisp.org>, Jan Kara <jack@suse.cz>,
        bug-gnulib@gnu.org, Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Bo b Peterson <rpeterso@redhat.com>,
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
        Amir Goldstein <l@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Wed, 20 Sep 2023 16:50:26 +0800
In-Reply-To: <20230920-leerung-krokodil-52ec6cb44707@brauner>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
         <20230919110457.7fnmzo4nqsi43yqq@quack3>
         <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
         <4511209.uG2h0Jr0uP@nimes>
         <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
         <20230920-leerung-krokodil-52ec6cb44707@brauner>
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

On Wed, 2023-09-20 at 10:41 +0200, Christian Brauner wrote:
> > > f1 was last written to *after* f2 was last written to. If the timesta=
mp of f1
> > > is then lower than the timestamp of f2, timestamps are fundamentally =
broken.
> > >=20
> > > Many things in user-space depend on timestamps, such as build system
> > > centered around 'make', but also 'find ... -newer ...'.
> > >=20
> >=20
> >=20
> > What does breakage with make look like in this situation? The "fuzz"
> > here is going to be on the order of a jiffy. The typical case for make
> > timestamp comparisons is comparing source files vs. a build target. If
> > those are being written nearly simultaneously, then that could be an
> > issue, but is that a typical behavior? It seems like it would be hard t=
o
> > rely on that anyway, esp. given filesystems like NFS that can do lazy
> > writeback.
> >=20
> > One of the operating principles with this series is that timestamps can
> > be of varying granularity between different files. Note that Linux
> > already violates this assumption when you're working across filesystems
> > of different types.
> >=20
> > As to potential fixes if this is a real problem:
> >=20
> > I don't really want to put this behind a mount or mkfs option (a'la
> > relatime, etc.), but that is one possibility.
> >=20
> > I wonder if it would be feasible to just advance the coarse-grained
> > current_time whenever we end up updating a ctime with a fine-grained
> > timestamp? It might produce some inode write amplification. Files that
>=20
> Less than ideal imho.
>=20
> If this risks breaking existing workloads by enabling it unconditionally
> and there isn't a clear way to detect and handle these situations
> without risk of regression then we should move this behind a mount
> option.
>=20
> So how about the following:
>=20
> From cb14add421967f6e374eb77c36cc4a0526b10d17 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Wed, 20 Sep 2023 10:00:08 +0200
> Subject: [PATCH] vfs: move multi-grain timestamps behind a mount option
>=20
> While we initially thought we can do this unconditionally it turns out
> that this might break existing workloads that rely on timestamps in very
> specific ways and we always knew this was a possibility. Move
> multi-grain timestamps behind a vfs mount option.

I agree with this solution.

You can add some metainfo:

Reported-by: Ken Moffat <ken@linuxfromscratch.org>
Bisected-by: Xi Ruoyao <xry111@linuxfromscratch.org>
Link: https://lists.linuxfromscratch.org/sympa/arc/lfs-dev/2023-09/msg00036=
.html

> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> =C2=A0fs/fs_context.c=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++++++++++++++++
> =C2=A0fs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 ++--
> =C2=A0fs/proc_namespace.c |=C2=A0 1 +
> =C2=A0fs/stat.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +-
> =C2=A0include/linux/fs.h=C2=A0 |=C2=A0 4 +++-
> =C2=A05 files changed, 25 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index a0ad7a0c4680..dd4dade0bb9e 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -44,6 +44,7 @@ static const struct constant_table common_set_sb_flag[]=
 =3D {
> =C2=A0	{ "mand",	SB_MANDLOCK },
> =C2=A0	{ "ro",		SB_RDONLY },
> =C2=A0	{ "sync",	SB_SYNCHRONOUS },
> +	{ "mgtime",	SB_MGTIME },
> =C2=A0	{ },
> =C2=A0};
> =C2=A0
> @@ -52,18 +53,32 @@ static const struct constant_table common_clear_sb_fl=
ag[] =3D {
> =C2=A0	{ "nolazytime",	SB_LAZYTIME },
> =C2=A0	{ "nomand",	SB_MANDLOCK },
> =C2=A0	{ "rw",		SB_RDONLY },
> +	{ "nomgtime",	SB_MGTIME },
> =C2=A0	{ },
> =C2=A0};
> =C2=A0
> +static inline int check_mgtime(unsigned int token, const struct fs_conte=
xt *fc)
> +{
> +	if (token !=3D SB_MGTIME)
> +		return 0;
> +	if (!(fc->fs_type->fs_flags & FS_MGTIME))
> +		return invalf(fc, "Filesystem doesn't support multi-grain timestamps")=
;
> +	return 0;
> +}
> +
> =C2=A0/*
> =C2=A0 * Check for a common mount option that manipulates s_flags.
> =C2=A0 */
> =C2=A0static int vfs_parse_sb_flag(struct fs_context *fc, const char *key=
)
> =C2=A0{
> =C2=A0	unsigned int token;
> +	int ret;
> =C2=A0
> =C2=A0	token =3D lookup_constant(common_set_sb_flag, key, 0);
> =C2=A0	if (token) {
> +		ret =3D check_mgtime(token, fc);
> +		if (ret)
> +			return ret;
> =C2=A0		fc->sb_flags |=3D token;
> =C2=A0		fc->sb_flags_mask |=3D token;
> =C2=A0		return 0;
> @@ -71,6 +86,9 @@ static int vfs_parse_sb_flag(struct fs_context *fc, con=
st char *key)
> =C2=A0
> =C2=A0	token =3D lookup_constant(common_clear_sb_flag, key, 0);
> =C2=A0	if (token) {
> +		ret =3D check_mgtime(token, fc);
> +		if (ret)
> +			return ret;
> =C2=A0		fc->sb_flags &=3D ~token;
> =C2=A0		fc->sb_flags_mask |=3D token;
> =C2=A0		return 0;
> diff --git a/fs/inode.c b/fs/inode.c
> index 54237f4242ff..fd1a2390aaa3 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2141,7 +2141,7 @@ EXPORT_SYMBOL(current_mgtime);
> =C2=A0
> =C2=A0static struct timespec64 current_ctime(struct inode *inode)
> =C2=A0{
> -	if (is_mgtime(inode))
> +	if (IS_MGTIME(inode))
> =C2=A0		return current_mgtime(inode);
> =C2=A0	return current_time(inode);
> =C2=A0}
> @@ -2588,7 +2588,7 @@ struct timespec64 inode_set_ctime_current(struct in=
ode *inode)
> =C2=A0		now =3D current_time(inode);
> =C2=A0
> =C2=A0		/* Just copy it into place if it's not multigrain */
> -		if (!is_mgtime(inode)) {
> +		if (!IS_MGTIME(inode)) {
> =C2=A0			inode_set_ctime_to_ts(inode, now);
> =C2=A0			return now;
> =C2=A0		}
> diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> index 250eb5bf7b52..08f5bf4d2c6c 100644
> --- a/fs/proc_namespace.c
> +++ b/fs/proc_namespace.c
> @@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct supe=
r_block *sb)
> =C2=A0		{ SB_DIRSYNC, ",dirsync" },
> =C2=A0		{ SB_MANDLOCK, ",mand" },
> =C2=A0		{ SB_LAZYTIME, ",lazytime" },
> +		{ SB_MGTIME, ",mgtime" },
> =C2=A0		{ 0, NULL }
> =C2=A0	};
> =C2=A0	const struct proc_fs_opts *fs_infop;
> diff --git a/fs/stat.c b/fs/stat.c
> index 6e60389d6a15..2f18dd5de18b 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -90,7 +90,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 requ=
est_mask,
> =C2=A0	stat->size =3D i_size_read(inode);
> =C2=A0	stat->atime =3D inode->i_atime;
> =C2=A0
> -	if (is_mgtime(inode)) {
> +	if (IS_MGTIME(inode)) {
> =C2=A0		fill_mg_cmtime(stat, request_mask, inode);
> =C2=A0	} else {
> =C2=A0		stat->mtime =3D inode->i_mtime;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4aeb3fa11927..03e415fb3a7c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1114,6 +1114,7 @@ extern int send_sigurg(struct fown_struct *fown);
> =C2=A0#define SB_NODEV=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(2)	/=
* Disallow access to device special files */
> =C2=A0#define SB_NOEXEC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(3)	/* Dis=
allow program execution */
> =C2=A0#define SB_SYNCHRONOUS=C2=A0 BIT(4)	/* Writes are synced at once */
> +#define SB_MGTIME	BIT(5)	/* Use multi-grain timestamps */
> =C2=A0#define SB_MANDLOCK=C2=A0=C2=A0=C2=A0=C2=A0 BIT(6)	/* Allow mandato=
ry locks on an FS */
> =C2=A0#define SB_DIRSYNC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(7)	/* Director=
y modifications are synchronous */
> =C2=A0#define SB_NOATIME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(10)	/* Do not =
update access times. */
> @@ -2105,6 +2106,7 @@ static inline bool sb_rdonly(const struct super_blo=
ck *sb) { return sb->s_flags
> =C2=A0					((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
> =C2=A0#define IS_MANDLOCK(inode)	__IS_FLG(inode, SB_MANDLOCK)
> =C2=A0#define IS_NOATIME(inode)	__IS_FLG(inode, SB_RDONLY|SB_NOATIME)
> +#define IS_MGTIME(inode)	__IS_FLG(inode, SB_MGTIME)
> =C2=A0#define IS_I_VERSION(inode)	__IS_FLG(inode, SB_I_VERSION)
> =C2=A0
> =C2=A0#define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
> @@ -2366,7 +2368,7 @@ struct file_system_type {
> =C2=A0 */
> =C2=A0static inline bool is_mgtime(const struct inode *inode)
> =C2=A0{
> -	return inode->i_sb->s_type->fs_flags & FS_MGTIME;
> +	return inode->i_sb->s_flags & SB_MGTIME;
> =C2=A0}
> =C2=A0
> =C2=A0extern struct dentry *mount_bdev(struct file_system_type *fs_type,

