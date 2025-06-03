Return-Path: <linux-fsdevel+bounces-50399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC63BACBDE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 02:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D961889837
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 00:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1A0539A;
	Tue,  3 Jun 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnsrcUQh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D7210E5;
	Tue,  3 Jun 2025 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748909622; cv=none; b=Pg/FU4klcOkYD4XaRKSXnth7eKDCCXOJB+BQ54ZQMzTx05BX4wtoHy3GSCswqzm9Y+UycTcu/pMPrnVVzhxqpGBQFbIDClqvvB6E0IMiHHn/MPff6RQdJl/HLupQg/EnZkJilaJEPbLMBnJ4rZs/hd6MiQ/7qHqVR18K4csc0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748909622; c=relaxed/simple;
	bh=sn+OqphyVnji4y6hz1/LMQWPIIpxbEwzosH1g2ZkrkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlX00cOiDiYj9uQ7YylqObv7Fmpz6QUL/qaRsKo7v27Zy2RyJyP+JQZDB9OU9ACH7cFuP7Y9y0JfpRqrXz7WNyRQ3bbds98ujPopp4RgMIC64qznCGHmksBDnQZL41h30lzw9Lb0vLJKnkQ2AQPf0Y0Ipl8ITFXzIEPSCuQdPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnsrcUQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98A0C4CEEB;
	Tue,  3 Jun 2025 00:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748909621;
	bh=sn+OqphyVnji4y6hz1/LMQWPIIpxbEwzosH1g2ZkrkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnsrcUQhGAhCEqKbzwpp5O1n2AsGhpL8HmUArAWwbkxqeLsXizThNCjLxoOpMaQrf
	 NJz15+AbFtq/C5UVtzeC0W+ILrg5GrG/zQtlZKfRi8nsKsD9dPdsFP+C7lXGADeKvM
	 xgjKKueH+8yhcnHKC2/mvzMzhlf46DQ4bP/7fU/g4WH0kCcV0KDLbbfNsEV4RizLmj
	 BFexqy6VAzqewUa+GcufPptw7sea58K26z9MsLC36bShdm91DULtPKvFw0zVerQhpt
	 lLKvREfSrJ0FEv9wiqvWnkgx6if+ScTWJ/fMYiZV20JI9TItP7deeatIUh/wxUaB/7
	 8tIiu5IpHYRww==
Date: Mon, 2 Jun 2025 17:13:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
	linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Subject: Re: [PATCH 03/11] fuse: implement the basic iomap mechanisms
Message-ID: <20250603001341.GN8328@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
 <174787195629.1483178.7917092102987513364.stgit@frogsfrogsfrogs>
 <CAJnrk1ZEtXoMKXMjse-0RtSLjaK1zfadr3zR2tP4gh1WauOUWA@mail.gmail.com>
 <CAJnrk1YDxn0ZMk0BrTnNStkXErjY_LSGYHgdsRjiiZ2dTpftAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YDxn0ZMk0BrTnNStkXErjY_LSGYHgdsRjiiZ2dTpftAA@mail.gmail.com>

On Thu, May 29, 2025 at 04:15:57PM -0700, Joanne Koong wrote:
> On Thu, May 29, 2025 at 3:15 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Wed, May 21, 2025 at 5:03 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Implement functions to enable upcalling of iomap_begin and iomap_end to
> > > userspace fuse servers.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/fuse_i.h          |   38 ++++++
> > >  fs/fuse/fuse_trace.h      |  258 +++++++++++++++++++++++++++++++++++++++++
> > >  include/uapi/linux/fuse.h |   87 ++++++++++++++
> > >  fs/fuse/Kconfig           |   23 ++++
> > >  fs/fuse/Makefile          |    1
> > >  fs/fuse/file_iomap.c      |  280 +++++++++++++++++++++++++++++++++++++++++++++
> > >  fs/fuse/inode.c           |    5 +
> > >  7 files changed, 691 insertions(+), 1 deletion(-)
> > >  create mode 100644 fs/fuse/file_iomap.c
> > >
> > >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index d56d4fd956db99..aa51f25856697d 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -895,6 +895,9 @@ struct fuse_conn {
> > >         /* Is link not implemented by fs? */
> > >         unsigned int no_link:1;
> > >
> > > +       /* Use fs/iomap for FIEMAP and SEEK_{DATA,HOLE} file operations */
> > > +       unsigned int iomap:1;
> > > +
> > >         /* Use io_uring for communication */
> > >         unsigned int io_uring;
> > >
> > > @@ -1017,6 +1020,11 @@ static inline struct fuse_mount *get_fuse_mount_super(struct super_block *sb)
> > >         return sb->s_fs_info;
> > >  }
> > >
> > > +static inline const struct fuse_mount *get_fuse_mount_super_c(const struct super_block *sb)
> > > +{
> > > +       return sb->s_fs_info;
> > > +}
> > > +
> >
> > Instead of adding this new helper (and the ones below), what about
> > modifying the existing (non-const) versions of these helpers to take
> > in const * input args,  eg
> >
> > -static inline struct fuse_mount *get_fuse_mount_super(struct super_block *sb)
> > +static inline struct fuse_mount *get_fuse_mount_super(const struct
> > super_block *sb)
> >  {
> >         return sb->s_fs_info;
> >  }
> >
> > Then, doing something like "const struct fuse_mount *mt =
> > get_fuse_mount(inode);" would enforce the same guarantees as "const
> > struct fuse_mount *mt = get_fuse_mount_c(inode);" and we wouldn't need
> > 2 sets of helpers that pretty much do the same thing.
> >
> > >  static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
> > >  {
> > >         return get_fuse_mount_super(sb)->fc;
> > > @@ -1027,16 +1035,31 @@ static inline struct fuse_mount *get_fuse_mount(struct inode *inode)
> > >         return get_fuse_mount_super(inode->i_sb);
> > >  }
> > >
> > > +static inline const struct fuse_mount *get_fuse_mount_c(const struct inode *inode)
> > > +{
> > > +       return get_fuse_mount_super_c(inode->i_sb);
> > > +}
> > > +
> > >  static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
> > >  {
> > >         return get_fuse_mount_super(inode->i_sb)->fc;
> > >  }
> > >
> > > +static inline const struct fuse_conn *get_fuse_conn_c(const struct inode *inode)
> > > +{
> > > +       return get_fuse_mount_super_c(inode->i_sb)->fc;
> > > +}
> > > +
> > >  static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
> > >  {
> > >         return container_of(inode, struct fuse_inode, inode);
> > >  }
> > >
> > > +static inline const struct fuse_inode *get_fuse_inode_c(const struct inode *inode)
> > > +{
> > > +       return container_of(inode, struct fuse_inode, inode);
> > > +}
> > > +
> > >  static inline u64 get_node_id(struct inode *inode)
> > >  {
> > >         return get_fuse_inode(inode)->nodeid;
> > > @@ -1577,4 +1600,19 @@ extern void fuse_sysctl_unregister(void);
> > >  #define fuse_sysctl_unregister()       do { } while (0)
> > >  #endif /* CONFIG_SYSCTL */
> > >
> > > +#if IS_ENABLED(CONFIG_FUSE_IOMAP)
> > > +# include <linux/fiemap.h>
> > > +# include <linux/iomap.h>
> > > +
> > > +bool fuse_iomap_enabled(void);
> > > +
> > > +static inline bool fuse_has_iomap(const struct inode *inode)
> > > +{
> > > +       return get_fuse_conn_c(inode)->iomap;
> > > +}
> > > +#else
> > > +# define fuse_iomap_enabled(...)               (false)
> > > +# define fuse_has_iomap(...)                   (false)
> > > +#endif
> > > +
> > >  #endif /* _FS_FUSE_I_H */
> > > diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> > > index ca215a3cba3e31..fc7c5bf1cef52d 100644
> > > --- a/fs/fuse/Kconfig
> > > +++ b/fs/fuse/Kconfig
> > > @@ -64,6 +64,29 @@ config FUSE_PASSTHROUGH
> > >
> > >           If you want to allow passthrough operations, answer Y.
> > >
> > > +config FUSE_IOMAP
> > > +       bool "FUSE file IO over iomap"
> > > +       default y
> > > +       depends on FUSE_FS
> > > +       select FS_IOMAP
> > > +       help
> > > +         For supported fuseblk servers, this allows the file IO path to run
> > > +         through the kernel.
> >
> > I have config FUSE_FS select FS_IOMAP in my patchset (not yet
> > submitted) that changes fuse buffered writes / writeback handling to
> > use iomap. Could we just have config FUSE_FS automatically opt into
> > FS_IOMAP here or do you see a reason that this needs to be a separate
> > config?
> 
> Thinking about it some more, the iomap stuff you're adding also
> requires a "depends on BLOCK", so this will need to be a separate
> config anyways regardless of whether the FUSE_FS will always "select
> FS_IOMAP"

I'll add that, thanks.  I forgot that FS_IOMAP no longer selects BLOCK
all the time. :)

--D

> 
> Thanks,
> Joanne
> 
> >
> >
> > Thanks,
> > Joanne
> > > +
> > > +config FUSE_IOMAP_BY_DEFAULT
> > > +       bool "FUSE file I/O over iomap by default"
> > > +       default n
> > > +       depends on FUSE_IOMAP
> > > +       help
> > > +         Enable sending FUSE file I/O over iomap by default.
> > > +
> > > +config FUSE_IOMAP_DEBUG
> > > +       bool "Debug FUSE file IO over iomap"
> > > +       default n
> > > +       depends on FUSE_IOMAP
> > > +       help
> > > +         Enable debugging assertions for the fuse iomap code paths.
> > > +
> > >  config FUSE_IO_URING
> > >         bool "FUSE communication over io-uring"
> > >         default y

