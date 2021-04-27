Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C96136CB7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhD0TKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 15:10:09 -0400
Received: from 9.mo52.mail-out.ovh.net ([87.98.180.222]:45181 "EHLO
        9.mo52.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0TKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:10:08 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.44])
        by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 7316E25F92F;
        Tue, 27 Apr 2021 21:09:23 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 27 Apr
 2021 21:09:22 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-96R0016748756b-27ba-4d80-b967-2b218d0bbe7e,
                    B6AA52F3D5CB607530F59D2ADE64727CB37F7539) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date:   Tue, 27 Apr 2021 21:09:21 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Vivek Goyal <vgoyal@redhat.com>
CC:     Miklos Szeredi <miklos@szeredi.hu>,
        <virtualization@lists.linux-foundation.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <virtio-fs@redhat.com>, Robert Krawitz <rlk@redhat.com>
Subject: Re: [PATCH v2] virtiofs: propagate sync() to file server
Message-ID: <20210427210921.7b01c661@bahia.lan>
In-Reply-To: <20210427171206.GA1805363@redhat.com>
References: <20210426151011.840459-1-groug@kaod.org>
        <20210427171206.GA1805363@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 592c65e6-63ae-471f-93ed-402196ac499b
X-Ovh-Tracer-Id: 7017452647084824940
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvddvtddgudefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheprhhlkhesrhgvughhrghtrdgtohhm
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 27 Apr 2021 13:12:06 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, Apr 26, 2021 at 05:10:11PM +0200, Greg Kurz wrote:
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
> > $ strace -T -e fsync /usr/bin/sync virtiofs/foo
> > fsync(3)                                = 0 <10.371640>
> > +++ exited with 0 +++
> > 
> > There are no good reasons not to honor the expected behavior of
> > sync() actually : it gives an unrealistic impression that virtiofs
> > is super fast and that data has safely landed on HW, which isn't
> > the case obviously.
> > 
> > Implement a ->sync_fs() superblock operation that sends a new
> > FUSE_SYNC request type for this purpose. Provision a 64-bit
> > flags field for possible future extensions. Since the file
> > server cannot handle the wait == 0 case, we skip it to avoid a
> > gratuitous roundtrip.
> > 
> > Like with FUSE_FSYNC and FUSE_FSYNCDIR, lack of support for
> > FUSE_SYNC in the file server is treated as permanent success.
> > This ensures compatibility with older file servers : the client
> > will get the current behavior of sync() not being propagated to
> > the file server.
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
> > v2: - clarify compatibility with older servers in changelog (Vivek)
> >     - ignore the wait == 0 case (Miklos)
> >     - 64-bit aligned argument structure (Vivek, Miklos)
> > 
> >  fs/fuse/fuse_i.h          |  3 +++
> >  fs/fuse/inode.c           | 35 +++++++++++++++++++++++++++++++++++
> >  fs/fuse/virtio_fs.c       |  1 +
> >  include/uapi/linux/fuse.h | 10 +++++++++-
> >  4 files changed, 48 insertions(+), 1 deletion(-)
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
> > index b0e18b470e91..ac184069b40f 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -506,6 +506,40 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
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
> > +	/*
> > +	 * Userspace cannot handle the wait == 0 case. Avoid a
> > +	 * gratuitous roundtrip.
> > +	 */
> > +	if (!wait)
> > +		return 0;
> > +
> > +	if (!fc->sync_fs)
> > +		return 0;
> > +
> > +	memset(&inarg, 0, sizeof(inarg));
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
> > +
> > +	return err;
> > +}
> > +
> >  enum {
> >  	OPT_SOURCE,
> >  	OPT_SUBTYPE,
> > @@ -909,6 +943,7 @@ static const struct super_operations fuse_super_operations = {
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
> > index 54442612c48b..1265ca17620c 100644
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
> > @@ -957,4 +961,8 @@ struct fuse_removemapping_one {
> >  #define FUSE_REMOVEMAPPING_MAX_ENTRY   \
> >  		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
> >  
> > +struct fuse_syncfs_in {
> > +	uint64_t flags;
> > +};
> > +
> 
> Hi Greg,
> 
> Will it be better if 32bits are for flags and reset 32 are
> padding and can be used in whatever manner.
> 
> struct fuse_syncfs_in {
> 	uint32_t flags;
> 	uint32_t padding;
> };
> 
> This will increase the flexibility if we were to send more information
> in future.
> 
> I already see bunch of structures where flags are 32 bit and reset
> are padding bits. fuse_read_in, fuse_write_in, fuse_rename2_in etc.
> 
> Thanks
> Vivek
> 

Yes, it makes sense. I'll wait a few more days and roll out a v3.

Thanks !

--
Greg

> >  #endif /* _LINUX_FUSE_H */
> > -- 
> > 2.26.3
> > 
> 

