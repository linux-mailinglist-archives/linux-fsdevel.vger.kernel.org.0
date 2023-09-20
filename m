Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF897A7960
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 12:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjITKff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 06:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjITKfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:35:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBE3AD;
        Wed, 20 Sep 2023 03:35:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04647C433C7;
        Wed, 20 Sep 2023 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695206125;
        bh=K2lTJnCgosym5o0oHZC21PlpMcbDPAGRzGpQMsH+RNE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DQraYbgnbA8u42xIprJlGq919tAZP4oSOdbkdBTrPg4E020AuJU3vm+IxDgIAtub4
         0ualIwtp20Irlnr5UkTgSXB/6dLY+vOyf0EwAPBcmnJdBqIsbV/q8wd+oKJBDukCmC
         /GGkmmgnqoNA7fAJABwddnMG0NDO1gl1EM1jlFcVcGauNmnScyO0k32UToSskpKj7Z
         IDirVhj/0pNpBeARBmUePperJeyjvV4b3EGol9t/AUaUdbdstRRauxjUUZvhy5PZAK
         37rI5uERCd6DxALjpO+Wq3SS9dt0mP5kZEJ0WiE3vmZJqNiMvhEhUe+Cvf5i6voNam
         ksh/5ZQ5h3mdg==
Message-ID: <317d84b1b909b6c6519a2406fcb302ce22dafa41.camel@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc:     Bruno Haible <bruno@clisp.org>,
        Xi Ruoyao <xry111@linuxfromscratch.org>, bug-gnulib@gnu.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Date:   Wed, 20 Sep 2023 06:35:18 -0400
In-Reply-To: <20230920101731.ym6pahcvkl57guto@quack3>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
         <20230919110457.7fnmzo4nqsi43yqq@quack3>
         <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
         <4511209.uG2h0Jr0uP@nimes>
         <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
         <20230920-leerung-krokodil-52ec6cb44707@brauner>
         <20230920101731.ym6pahcvkl57guto@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-09-20 at 12:17 +0200, Jan Kara wrote:
> On Wed 20-09-23 10:41:30, Christian Brauner wrote:
> > > > f1 was last written to *after* f2 was last written to. If the times=
tamp of f1
> > > > is then lower than the timestamp of f2, timestamps are fundamentall=
y broken.
> > > >=20
> > > > Many things in user-space depend on timestamps, such as build syste=
m
> > > > centered around 'make', but also 'find ... -newer ...'.
> > > >=20
> > >=20
> > >=20
> > > What does breakage with make look like in this situation? The "fuzz"
> > > here is going to be on the order of a jiffy. The typical case for mak=
e
> > > timestamp comparisons is comparing source files vs. a build target. I=
f
> > > those are being written nearly simultaneously, then that could be an
> > > issue, but is that a typical behavior? It seems like it would be hard=
 to
> > > rely on that anyway, esp. given filesystems like NFS that can do lazy
> > > writeback.
> > >=20
> > > One of the operating principles with this series is that timestamps c=
an
> > > be of varying granularity between different files. Note that Linux
> > > already violates this assumption when you're working across filesyste=
ms
> > > of different types.
> > >=20
> > > As to potential fixes if this is a real problem:
> > >=20
> > > I don't really want to put this behind a mount or mkfs option (a'la
> > > relatime, etc.), but that is one possibility.
> > >=20
> > > I wonder if it would be feasible to just advance the coarse-grained
> > > current_time whenever we end up updating a ctime with a fine-grained
> > > timestamp? It might produce some inode write amplification. Files tha=
t
> >=20
> > Less than ideal imho.
> >=20
> > If this risks breaking existing workloads by enabling it unconditionall=
y
> > and there isn't a clear way to detect and handle these situations
> > without risk of regression then we should move this behind a mount
> > option.
> >=20
> > So how about the following:
> >=20
> > From cb14add421967f6e374eb77c36cc4a0526b10d17 Mon Sep 17 00:00:00 2001
> > From: Christian Brauner <brauner@kernel.org>
> > Date: Wed, 20 Sep 2023 10:00:08 +0200
> > Subject: [PATCH] vfs: move multi-grain timestamps behind a mount option
> >=20
> > While we initially thought we can do this unconditionally it turns out
> > that this might break existing workloads that rely on timestamps in ver=
y
> > specific ways and we always knew this was a possibility. Move
> > multi-grain timestamps behind a vfs mount option.
> >=20
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
>=20
> Surely this is a safe choice as it moves the responsibility to the sysadm=
in
> and the cases where finegrained timestamps are required. But I kind of
> wonder how is the sysadmin going to decide whether mgtime is safe for his
> system or not? Because the possible breakage needn't be obvious at the
> first sight...
>=20

That's the main reason I really didn't want to go with a mount option.
Documenting that may be difficult. While there is some pessimism around
it, I may still take a stab at just advancing the coarse clock whenever
we fetch a fine-grained timestamp. It'd be nice to remove this option in
the future if that turns out to be feasible.

> If I were a sysadmin, I'd rather opt for something like
> finegrained timestamps + lazytime (if I needed the finegrained timestamps
> functionality). That should avoid the IO overhead of finegrained timestam=
ps
> as well and I'd know I can have problems with timestamps only after a
> system crash.

> I've just got another idea how we could solve the problem: Couldn't we
> always just report coarsegrained timestamp to userspace and provide acces=
s
> to finegrained value only to NFS which should know what it's doing?
>=20

I think that'd be hard. First of all, where would we store the second
timestamp? We can't just truncate the fine-grained ones to come up with
a coarse-grained one. It might also be confusing having nfsd and local
filesystems present different attributes.


> > ---
> >  fs/fs_context.c     | 18 ++++++++++++++++++
> >  fs/inode.c          |  4 ++--
> >  fs/proc_namespace.c |  1 +
> >  fs/stat.c           |  2 +-
> >  include/linux/fs.h  |  4 +++-
> >  5 files changed, 25 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/fs_context.c b/fs/fs_context.c
> > index a0ad7a0c4680..dd4dade0bb9e 100644
> > --- a/fs/fs_context.c
> > +++ b/fs/fs_context.c
> > @@ -44,6 +44,7 @@ static const struct constant_table common_set_sb_flag=
[] =3D {
> >  	{ "mand",	SB_MANDLOCK },
> >  	{ "ro",		SB_RDONLY },
> >  	{ "sync",	SB_SYNCHRONOUS },
> > +	{ "mgtime",	SB_MGTIME },
> >  	{ },
> >  };
> > =20
> > @@ -52,18 +53,32 @@ static const struct constant_table common_clear_sb_=
flag[] =3D {
> >  	{ "nolazytime",	SB_LAZYTIME },
> >  	{ "nomand",	SB_MANDLOCK },
> >  	{ "rw",		SB_RDONLY },
> > +	{ "nomgtime",	SB_MGTIME },
> >  	{ },
> >  };
> > =20
> > +static inline int check_mgtime(unsigned int token, const struct fs_con=
text *fc)
> > +{
> > +	if (token !=3D SB_MGTIME)
> > +		return 0;
> > +	if (!(fc->fs_type->fs_flags & FS_MGTIME))
> > +		return invalf(fc, "Filesystem doesn't support multi-grain timestamps=
");
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Check for a common mount option that manipulates s_flags.
> >   */
> >  static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
> >  {
> >  	unsigned int token;
> > +	int ret;
> > =20
> >  	token =3D lookup_constant(common_set_sb_flag, key, 0);
> >  	if (token) {
> > +		ret =3D check_mgtime(token, fc);
> > +		if (ret)
> > +			return ret;
> >  		fc->sb_flags |=3D token;
> >  		fc->sb_flags_mask |=3D token;
> >  		return 0;
> > @@ -71,6 +86,9 @@ static int vfs_parse_sb_flag(struct fs_context *fc, c=
onst char *key)
> > =20
> >  	token =3D lookup_constant(common_clear_sb_flag, key, 0);
> >  	if (token) {
> > +		ret =3D check_mgtime(token, fc);
> > +		if (ret)
> > +			return ret;
> >  		fc->sb_flags &=3D ~token;
> >  		fc->sb_flags_mask |=3D token;
> >  		return 0;
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 54237f4242ff..fd1a2390aaa3 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -2141,7 +2141,7 @@ EXPORT_SYMBOL(current_mgtime);
> > =20
> >  static struct timespec64 current_ctime(struct inode *inode)
> >  {
> > -	if (is_mgtime(inode))
> > +	if (IS_MGTIME(inode))
> >  		return current_mgtime(inode);
> >  	return current_time(inode);
> >  }
> > @@ -2588,7 +2588,7 @@ struct timespec64 inode_set_ctime_current(struct =
inode *inode)
> >  		now =3D current_time(inode);
> > =20
> >  		/* Just copy it into place if it's not multigrain */
> > -		if (!is_mgtime(inode)) {
> > +		if (!IS_MGTIME(inode)) {
> >  			inode_set_ctime_to_ts(inode, now);
> >  			return now;
> >  		}
> > diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> > index 250eb5bf7b52..08f5bf4d2c6c 100644
> > --- a/fs/proc_namespace.c
> > +++ b/fs/proc_namespace.c
> > @@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct su=
per_block *sb)
> >  		{ SB_DIRSYNC, ",dirsync" },
> >  		{ SB_MANDLOCK, ",mand" },
> >  		{ SB_LAZYTIME, ",lazytime" },
> > +		{ SB_MGTIME, ",mgtime" },
> >  		{ 0, NULL }
> >  	};
> >  	const struct proc_fs_opts *fs_infop;
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 6e60389d6a15..2f18dd5de18b 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -90,7 +90,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 re=
quest_mask,
> >  	stat->size =3D i_size_read(inode);
> >  	stat->atime =3D inode->i_atime;
> > =20
> > -	if (is_mgtime(inode)) {
> > +	if (IS_MGTIME(inode)) {
> >  		fill_mg_cmtime(stat, request_mask, inode);
> >  	} else {
> >  		stat->mtime =3D inode->i_mtime;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 4aeb3fa11927..03e415fb3a7c 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1114,6 +1114,7 @@ extern int send_sigurg(struct fown_struct *fown);
> >  #define SB_NODEV        BIT(2)	/* Disallow access to device special fi=
les */
> >  #define SB_NOEXEC       BIT(3)	/* Disallow program execution */
> >  #define SB_SYNCHRONOUS  BIT(4)	/* Writes are synced at once */
> > +#define SB_MGTIME	BIT(5)	/* Use multi-grain timestamps */
> >  #define SB_MANDLOCK     BIT(6)	/* Allow mandatory locks on an FS */
> >  #define SB_DIRSYNC      BIT(7)	/* Directory modifications are synchron=
ous */
> >  #define SB_NOATIME      BIT(10)	/* Do not update access times. */
> > @@ -2105,6 +2106,7 @@ static inline bool sb_rdonly(const struct super_b=
lock *sb) { return sb->s_flags
> >  					((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
> >  #define IS_MANDLOCK(inode)	__IS_FLG(inode, SB_MANDLOCK)
> >  #define IS_NOATIME(inode)	__IS_FLG(inode, SB_RDONLY|SB_NOATIME)
> > +#define IS_MGTIME(inode)	__IS_FLG(inode, SB_MGTIME)
> >  #define IS_I_VERSION(inode)	__IS_FLG(inode, SB_I_VERSION)
> > =20
> >  #define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
> > @@ -2366,7 +2368,7 @@ struct file_system_type {
> >   */
> >  static inline bool is_mgtime(const struct inode *inode)
> >  {
> > -	return inode->i_sb->s_type->fs_flags & FS_MGTIME;
> > +	return inode->i_sb->s_flags & SB_MGTIME;
> >  }
> > =20
> >  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
> > --=20
> > 2.34.1
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
