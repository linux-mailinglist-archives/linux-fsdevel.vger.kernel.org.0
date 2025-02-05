Return-Path: <linux-fsdevel+bounces-40905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D80EBA2868A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 10:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7FC1604D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DD922A7EE;
	Wed,  5 Feb 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg6yHtoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37022A800;
	Wed,  5 Feb 2025 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738747752; cv=none; b=CK/ivgleUJJM3z4ZChYRStZ27VghI4oqmOmh4UpNoxQEMFJdsvZEBFfIeVeQUySLJVxkKyWIp2jer/wxnLg9ObRNhBTY3NcNMlqNmeFztcX1CRD9zNH0v07VaRm+YZiRSaYvnWsS6fl3Y/czABDdOelIZDBaqD8jI4qDLQNhID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738747752; c=relaxed/simple;
	bh=Ms21WWQxt0hgCHNGn7VoI88OcIK4i02A5VsFEvG24mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2qd4Jq2g1ITHYa3B5Ozu6lbiOl/WV3Md34Z9T+47oJnvRcGjvFKMOy5+fTjoeJA1HBzwyUZfPWMsffkeD9IiG3T4BM8nPzEUcC78jo4mBgAbu6NrSO7eWzdIWBJ/+uCE2ysJfu2ThisPeUoCvVONREI/1pPG+88Iu+f0Nbx+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg6yHtoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8972C4CEE3;
	Wed,  5 Feb 2025 09:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738747751;
	bh=Ms21WWQxt0hgCHNGn7VoI88OcIK4i02A5VsFEvG24mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eg6yHtoIaP23lOBbUoIZktLdaXSm0/rQFB+Gu8dr+q6+oDohpMbSz2yg63hKd5qcR
	 JIEQigQOx6zSCL8PfwFDkT74//d+oqTy+g/WnEeE9UP5rDeXqV9BLxGh+S9eSB5FCQ
	 0EH4OaodiU249ytvGjb03wGCsyxxcB6ysVIfWcaagRWsD3RQE40qXgte1c/SSodkak
	 STW8sPJ3yqHfZTCbEMSHiStohjiCgW6+p701EXd/PQ3EyNGW8ToP6boCW+4mBJYH6M
	 9GZOR6yUYN177p9P2oqWDE9hTWfwmjDylNbdW650fOmV8bB+tmA0ieFWuJ9AWuGJmk
	 SqgS9GzJbdTnQ==
Date: Wed, 5 Feb 2025 10:29:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Koutny <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Elliott Hughes <enh@google.com>
Subject: Re: [PATCH v7 0/6] introduce PIDFD_SELF* sentinels
Message-ID: <20250205-gewahrsam-einnahmen-9b580054f501@brauner>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <20250204-joggen-buddeln-29e5ca75abb7@brauner>
 <7a8a1719-466f-4e10-b1eb-9e9e1ef8ad52@lucifer.local>
 <CAJuCfpEUusRt_ss7RtxRPP9q_LRwi+Lw+SOq32EUA58s3JOx1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEUusRt_ss7RtxRPP9q_LRwi+Lw+SOq32EUA58s3JOx1A@mail.gmail.com>

On Tue, Feb 04, 2025 at 09:43:31AM -0800, Suren Baghdasaryan wrote:
> On Tue, Feb 4, 2025 at 2:01 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Feb 04, 2025 at 10:46:35AM +0100, Christian Brauner wrote:
> > > On Thu, 30 Jan 2025 20:40:25 +0000, Lorenzo Stoakes wrote:
> > > > If you wish to utilise a pidfd interface to refer to the current process or
> > > > thread it is rather cumbersome, requiring something like:
> > > >
> > > >     int pidfd = pidfd_open(getpid(), 0 or PIDFD_THREAD);
> > > >
> > > >     ...
> > > >
> > > > [...]
> > >
> > > Updated merge message. I've slightly rearranged pidfd_send_signal() so
> > > we don't have to call CLASS(fd, f)(pidfd) unconditionally anymore.
> >
> > Sounds good and thank you! Glad to get this in :)
> 
> Sorry, a bit late to the party...
> 
> We were discussing MADV_GUARD_INSTALL use with Android Bionic team and
> the possibility of caching pidfd_open() result for reuse when
> installing multiple guards, however doing that in libraries would pose
> issues as we can't predict the user behavior, which can fork() in
> between such calls. That would be an additional reason why having
> these sentinels is beneficial.

Ok, added this to the cover letter as well.

Note that starting with v6.14 pidfs supports file handles.
This works because pidfs provides each pidfd with a unique 64bit inode
number that is exposed in statx(). On 64-bit the ->st_ino simply is the
inode number. On 32-bit the unique identifier can be reconstructed using
->st_ino and the inode generation number which can be retrieved via the
FS_IOC_GETVERSION ioctl. So the 64-bit identifier on 32-bit is
reconstructed by using ->st_ino as the lower 32-bits and the 32-bit
generation number as the upper 32-bits.

Also note that since the introduction of pidfs each struct pid will
refer to a different inode but the same struct pid will refer to the
same inode if it's opened multiple times. In contrast to pre-pidfs
pidfds where each struct pid refered to the same inode.

IOW, with pidfs statx() is sufficient to compare to pidfds whether they
refer to the same process. On 64-bit it's sufficient to do the usual
st1->st_dev == st2->st_dev && st1->st_ino == st2->st_ino and on 32-bit
you will want to also compare the generation number:

TEST_F(pidfd_bind_mount, reopen)
{
        int pidfd;
        char proc_path[PATH_MAX];

        sprintf(proc_path, "/proc/self/fd/%d", self->pidfd);
        pidfd = open(proc_path, O_RDONLY | O_NOCTTY | O_CLOEXEC);
        ASSERT_GE(pidfd, 0);

        ASSERT_GE(fstat(self->pidfd, &self->st2), 0);
        ASSERT_EQ(ioctl(self->pidfd, FS_IOC_GETVERSION, &self->gen2), 0);

        ASSERT_TRUE(self->st1.st_dev == self->st2.st_dev && self->st1.st_ino == self->st2.st_ino);
        ASSERT_TRUE(self->gen1 == self->gen2);

        ASSERT_EQ(close(pidfd), 0);
}

Plus, you can bind-mount them now.

In any case, this allows us to create file handles that are unique for
the lifetime of the system. Please see

tools/testing/selftests/pidfd/pidfd_file_handle_test.c

for how that works. The gist is that decoding and encoding for pidfs is
unprivileged and the only requirement we have is that the process the
file handle resolves to must be valid in the caller's pid namespace
hierarchy:

TEST_F(file_handle, file_handle_child_pidns)
{
        int mnt_id;
        struct file_handle *fh;
        int pidfd = -EBADF;
        struct stat st1, st2;

        fh = malloc(sizeof(struct file_handle) + MAX_HANDLE_SZ);
        ASSERT_NE(fh, NULL);
        memset(fh, 0, sizeof(struct file_handle) + MAX_HANDLE_SZ);
        fh->handle_bytes = MAX_HANDLE_SZ;

        ASSERT_EQ(name_to_handle_at(self->child_pidfd2, "", fh, &mnt_id, AT_EMPTY_PATH), 0);

        ASSERT_EQ(fstat(self->child_pidfd2, &st1), 0);

        pidfd = open_by_handle_at(self->pidfd, fh, 0);
        ASSERT_GE(pidfd, 0);

        ASSERT_EQ(fstat(pidfd, &st2), 0);
        ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);

        ASSERT_EQ(close(pidfd), 0);

        pidfd = open_by_handle_at(self->pidfd, fh, O_CLOEXEC);
        ASSERT_GE(pidfd, 0);

        ASSERT_EQ(fstat(pidfd, &st2), 0);
        ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);

        ASSERT_EQ(close(pidfd), 0);

        pidfd = open_by_handle_at(self->pidfd, fh, O_NONBLOCK);
        ASSERT_GE(pidfd, 0);

        ASSERT_EQ(fstat(pidfd, &st2), 0);
        ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);

        ASSERT_EQ(close(pidfd), 0);

        free(fh);
}

So you don't need to keep the fd open.

> 
> 
> >
> > >
> > > ---
> > >
> > > Applied to the vfs-6.15.pidfs branch of the vfs/vfs.git tree.
> > > Patches in the vfs-6.15.pidfs branch should appear in linux-next soon.
> > >
> > > Please report any outstanding bugs that were missed during review in a
> > > new review to the original patch series allowing us to drop it.
> > >
> > > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > > patch has now been applied. If possible patch trailers will be updated.
> > >
> > > Note that commit hashes shown below are subject to change due to rebase,
> > > trailer updates or similar. If in doubt, please check the listed branch.
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > > branch: vfs-6.15.pidfs
> > >
> > > [1/6] pidfd: add PIDFD_SELF* sentinels to refer to own thread/process
> > >       https://git.kernel.org/vfs/vfs/c/e6e4ed42f8d8
> > > [2/6] selftests/pidfd: add missing system header imcludes to pidfd tests
> > >       https://git.kernel.org/vfs/vfs/c/c9f04f4a251d
> > > [3/6] tools: testing: separate out wait_for_pid() into helper header
> > >       https://git.kernel.org/vfs/vfs/c/fb67fe44116e
> > > [4/6] selftests: pidfd: add pidfd.h UAPI wrapper
> > >       https://git.kernel.org/vfs/vfs/c/ac331e56724d
> > > [5/6] selftests: pidfd: add tests for PIDFD_SELF_*
> > >       https://git.kernel.org/vfs/vfs/c/881a3515c191
> > > [6/6] selftests/mm: use PIDFD_SELF in guard pages test
> > >       https://git.kernel.org/vfs/vfs/c/b4703f056f42

