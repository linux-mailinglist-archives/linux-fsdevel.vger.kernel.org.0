Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C063D36675D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhDUI4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 04:56:34 -0400
Received: from 9.mo52.mail-out.ovh.net ([87.98.180.222]:41262 "EHLO
        9.mo52.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbhDUI4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:56:34 -0400
X-Greylist: delayed 2402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2021 04:56:34 EDT
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.148])
        by mo52.mail-out.ovh.net (Postfix) with ESMTPS id D494125D488;
        Wed, 21 Apr 2021 09:39:07 +0200 (CEST)
Received: from kaod.org (37.59.142.102) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Apr
 2021 09:39:07 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-102R0045a37fe6d-0f6a-4455-830b-97ba067ccd67,
                    50F065E079F855668D79ED56DF61EE5F1F64E411) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date:   Wed, 21 Apr 2021 09:39:04 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Vivek Goyal <vgoyal@redhat.com>
CC:     Miklos Szeredi <miklos@szeredi.hu>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <virtio-fs@redhat.com>, <linux-fsdevel@vger.kernel.org>,
        Robert Krawitz <rlk@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofs: propagate sync() to file server
Message-ID: <20210421093904.68653e3e@bahia.lan>
In-Reply-To: <20210420184226.GC1529659@redhat.com>
References: <20210419150848.275757-1-groug@kaod.org>
        <20210420184226.GC1529659@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 2aca8e0f-1894-41d3-9307-bb5aac34cad9
X-Ovh-Tracer-Id: 15463953748017584489
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvddtjedguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepiedtudeuvdfgtdeliefgvedutddtjedtfefhlefgteevueduudfhheffhfduvefgnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehrlhhksehrvgguhhgrthdrtghomh
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Apr 2021 14:42:26 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, Apr 19, 2021 at 05:08:48PM +0200, Greg Kurz wrote:
> > Even if POSIX doesn't mandate it, linux users legitimately expect
> > sync() to flush all data and metadata to physical storage when it
> > is located on the same system. This isn't happening with virtiofs
> > though : sync() inside the guest returns right away even though
> > data still needs to be flushed from the host page cache.
> > 
> > This is easily demonstrated by doing the following in the guest:
> > 
> > $ dd if=/dev/zero of=/mnt/foo bs=1M count=5K ; strace -T -e sync sync
> > 5120+0 records in
> > 5120+0 records out
> > 5368709120 bytes (5.4 GB, 5.0 GiB) copied, 5.22224 s, 1.0 GB/s
> > sync()                                  = 0 <0.024068>
> > +++ exited with 0 +++
> > 
> > and start the following in the host when the 'dd' command completes
> > in the guest:
> > 
> > $ strace -T -e fsync sync virtiofs/foo
> 		       ^^^^
> That "sync" is not /usr/bin/sync and its your own binary to call fsync()?
> 

This is /usr/bin/sync. I should have put the full path, sorry for that.

This is the expected behavior when a file is specified as stated in the
sync(1) manual page:

"If one or more files are specified, sync only them, or their containing
 file systems.

> > fsync(3)                                = 0 <10.371640>
> > +++ exited with 0 +++
> > 
> > There are no good reasons not to honor the expected behavior of
> > sync() actually : it gives an unrealistic impression that virtiofs
> > is super fast and that data has safely landed on HW, which isn't
> > the case obviously.
> > 
> > Implement a ->sync_fs() superblock operation that sends a new
> > FUSE_SYNC request type for this purpose. The FUSE_SYNC request
> > conveys the 'wait' argument of ->sync_fs() in case the file
> > server has a use for it. Like with FUSE_FSYNC and FUSE_FSYNCDIR,
> > lack of support for FUSE_SYNC in the file server is treated as
> > permanent success.
> > 
> > Note that such an operation allows the file server to DoS sync().
> > Since a typical FUSE file server is an untrusted piece of software
> > running in userspace, this is disabled by default.  Only enable it
> > with virtiofs for now since virtiofsd is supposedly trusted by the
> > guest kernel.
> > 
> > Reported-by: Robert Krawitz <rlk@redhat.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > 
> > Can be tested using the following custom QEMU with FUSE_SYNCFS support:
> > 
> > https://gitlab.com/gkurz/qemu/-/tree/fuse-sync
> > 
> > ---
> >  fs/fuse/fuse_i.h          |  3 +++
> >  fs/fuse/inode.c           | 29 +++++++++++++++++++++++++++++
> >  fs/fuse/virtio_fs.c       |  1 +
> >  include/uapi/linux/fuse.h | 11 ++++++++++-
> >  4 files changed, 43 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 63d97a15ffde..68e9ae96cbd4 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -755,6 +755,9 @@ struct fuse_conn {
> >  	/* Auto-mount submounts announced by the server */
> >  	unsigned int auto_submounts:1;
> >  
> > +	/* Propagate syncfs() to server */
> > +	unsigned int sync_fs:1;
> > +
> >  	/** The number of requests waiting for completion */
> >  	atomic_t num_waiting;
> >  
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index b0e18b470e91..425d567a06c5 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -506,6 +506,34 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
> >  	return err;
> >  }
> >  
> > +static int fuse_sync_fs(struct super_block *sb, int wait)
> > +{
> > +	struct fuse_mount *fm = get_fuse_mount_super(sb);
> > +	struct fuse_conn *fc = fm->fc;
> > +	struct fuse_syncfs_in inarg;
> > +	FUSE_ARGS(args);
> > +	int err;
> > +
> > +	if (!fc->sync_fs)
> > +		return 0;
> > +
> > +	memset(&inarg, 0, sizeof(inarg));
> > +	inarg.wait = wait;
> > +	args.in_numargs = 1;
> > +	args.in_args[0].size = sizeof(inarg);
> > +	args.in_args[0].value = &inarg;
> > +	args.opcode = FUSE_SYNCFS;
> > +	args.out_numargs = 0;
> > +
> > +	err = fuse_simple_request(fm, &args);
> > +	if (err == -ENOSYS) {
> > +		fc->sync_fs = 0;
> > +		err = 0;
> > +	}
> 
> I was wondering what will happen if older file server does not support
> FUSE_SYNCFS. So we will get -ENOSYS and future syncfs commmands will not
> be sent.
> 

Yes and it is consistent with what we already do with FUSE_FSYNC and
FUSE_FSYNCDIR. Note that -ENOSYS is turned into a permanent success.
This ensures compatibility with older file servers : the client will
get the current behavior of sync() not being propagated to the file
server. I'll mention that explicitely in the changelog.

> > +
> > +	return err;
> 
> Right now we don't propagate this error code all the way to user space.
> I think I should post my patch to fix it again.
> 
> https://lore.kernel.org/linux-fsdevel/20201221195055.35295-2-vgoyal@redhat.com/
> 

Makes sense even if this seems to be broader issue since it
requires careful auditing of all ->sync_fs() variants.

> > +}
> > +
> >  enum {
> >  	OPT_SOURCE,
> >  	OPT_SUBTYPE,
> > @@ -909,6 +937,7 @@ static const struct super_operations fuse_super_operations = {
> >  	.put_super	= fuse_put_super,
> >  	.umount_begin	= fuse_umount_begin,
> >  	.statfs		= fuse_statfs,
> > +	.sync_fs	= fuse_sync_fs,
> >  	.show_options	= fuse_show_options,
> >  };
> >  
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 4ee6f734ba83..a3c025308743 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -1441,6 +1441,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
> >  	fc->release = fuse_free_conn;
> >  	fc->delete_stale = true;
> >  	fc->auto_submounts = true;
> > +	fc->sync_fs = true;
> >  
> >  	fsc->s_fs_info = fm;
> >  	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 54442612c48b..6e8c3cf3207c 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -179,6 +179,9 @@
> >   *  7.33
> >   *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_SUIDGID
> >   *  - add FUSE_OPEN_KILL_SUIDGID
> > + *
> > + *  7.34
> > + *  - add FUSE_SYNCFS
> >   */
> >  
> >  #ifndef _LINUX_FUSE_H
> > @@ -214,7 +217,7 @@
> >  #define FUSE_KERNEL_VERSION 7
> >  
> >  /** Minor version number of this interface */
> > -#define FUSE_KERNEL_MINOR_VERSION 33
> > +#define FUSE_KERNEL_MINOR_VERSION 34
> 
> I have always wondered what's the usage of minor version and when should
> it be bumped up. IIUC, it is there to group features into a minor
> version. So that file server (and may be client too) can deny to not
> suppor client/server if a certain minimum version is not supported.
> 
> So looks like you want to have capability to say it does not support
> an older client (<34) beacuse it wants to make sure SYNCFS is supported.
> Is that the reason to bump up the minor version or something else.
> 

Ah... file history seemed to indicate that minor version was
bumped up each time a new request was added but I might be
wrong.

Hopefully, Miklos can shed some light here ?

> >  
> >  /** The node ID of the root inode */
> >  #define FUSE_ROOT_ID 1
> > @@ -499,6 +502,7 @@ enum fuse_opcode {
> >  	FUSE_COPY_FILE_RANGE	= 47,
> >  	FUSE_SETUPMAPPING	= 48,
> >  	FUSE_REMOVEMAPPING	= 49,
> > +	FUSE_SYNCFS		= 50,
> >  
> >  	/* CUSE specific operations */
> >  	CUSE_INIT		= 4096,
> > @@ -957,4 +961,9 @@ struct fuse_removemapping_one {
> >  #define FUSE_REMOVEMAPPING_MAX_ENTRY   \
> >  		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
> >  
> > +struct fuse_syncfs_in {
> > +	/* Whether to wait for outstanding I/Os to complete */
> > +	uint32_t wait;
> > +};
> > +
> 
> Will it make sense to add a flag and use only one bit to signal whether
> wait is required or not. Then rest of the 31bits in future can potentially
> be used for something else if need be.
> 

I don't envision much changes in this API but yes, we can certainly
do that.

> Looks like most of the fuse structures are 64bit aligned (except
> fuse_removemapping_in and now fuse_syncfs_in). I am wondering does
> it matter if it is 64bit aligned or not.
> 

I don't know the required alignment but we already have a 32bit
aligned fuse structure:

struct fuse_removemapping_in {
	/* number of fuse_removemapping_one follows */
	uint32_t        count;
};

which is sent like this:

static int fuse_send_removemapping(struct inode *inode,
				   struct fuse_removemapping_in *inargp,
				   struct fuse_removemapping_one *remove_one)
{
...
	args.in_args[0].size = sizeof(*inargp);
	args.in_args[0].value = inargp;

Again, maybe Miklos can clarify this ?

> Vivek
> 

Cheers,

--
Greg
