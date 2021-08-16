Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FEA3EDF1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 23:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhHPVPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 17:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231726AbhHPVPH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:15:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 135D760F41;
        Mon, 16 Aug 2021 21:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629148475;
        bh=/QMER6iVz8hvkcgI2BgLmz0aB5+YOiNa3ziUyYkzPhE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=HlYzICEDwcSrgoRkOL65KtNdYqBgTPgDvPAMAOr3oFdQq89q+1jxCuJxwDBRy6Agl
         tfD394s0R5ZPiuLC6rDWeZHWm4+TB2d7qL91GKarzv2KogzgmQ1uhFzKiU9eDDHuZW
         Z1Sbl9oHdkDpgHhSYCvOhfVEZTVM1UQN2byrGnCsduuiVHUckse5mgJha/HRb3t/Dq
         TTc3C6RIYqULmF0s++nhjkG9VycKG2nzcOEePGxB3Q6s9FTgcIKnrXW397Wm5jpGTM
         jr2AulD7zQPVd9KtITP1/PSQFrB66tYGX0p3yeD6fmmzywWdxrdKEDmIA/uHKCGoFi
         cqIGc1DYLYFkg==
Date:   Mon, 16 Aug 2021 14:14:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-xfs@vger.kernel.org, jane.chu@oracle.com,
        willy@infradead.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sandeen@sandeen.net
Subject: Re: [PATCHSET 0/2] dax: fix broken pmem poison narrative
Message-ID: <20210816211434.GB12640@magnolia>
References: <162914791879.197065.12619905059952917229.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162914791879.197065.12619905059952917229.stgit@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 02:05:18PM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> Our current "advice" to people using persistent memory and FSDAX who
> wish to recover upon receipt of a media error (aka 'hwpoison') event
> from ACPI is to punch-hole that part of the file and then pwrite it,
> which will magically cause the pmem to be reinitialized and the poison
> to be cleared.
> 
> Punching doesn't make any sense at all -- we don't allow userspace to
> allocate from specific parts of the storage, and another writer could
> grab the poisoned range in the meantime.  In other words, the advice is
> seriously overfitted to incidental xfs and ext4 behavior and can
> completely fail.  Worse yet, that concurrent writer now has to deal with
> the poison that it didn't know about, and someone else is trying to fix.
> 
> AFAICT, the only reason why the "punch and write" dance works at all is
> that the XFS and ext4 currently call blkdev_issue_zeroout when
> allocating pmem as part of a pwrite call.  A pwrite without the punch
> won't clear the poison, because pwrite on a DAX file calls
> dax_direct_access to access the memory directly, and dax_direct_access
> is only smart enough to bail out on poisoned pmem.  It does not know how
> to clear it.  Userspace could solve the problem by calling FIEMAP and
> issuing a BLKZEROOUT, but that requires rawio capabilities.
> 
> The whole pmem poison recovery story is is wrong and needs to be
> corrected ASAP before everyone else starts doing this.  Therefore,
> create a dax_zeroinit_range function that filesystems can call to reset
> the contents of the pmem to a known value and clear any state associated
> with the media error.  Then, connect FALLOC_FL_ZERO_RANGE to this new
> function (for DAX files) so that unprivileged userspace has a safe way
> to reset the pmem and clear media errors.

This is a sample copy of a SIGBUS handler that will dump out the siginfo
data, call ZERO_RANGE to clear the poison, and then simulates being
fortunate enough to be able to reconstruct the file contents from
scratch.

Note that I haven't tested this even with simulated pmem because I
cannot figure out how to inject a poison error into the pmem in such a
way that the nvdimm driver records it in the badblocks table.
madvise(HWPOISON) calls the SIGBUS handler, but that code path never
goes outside of the memory manager.

int fd = open(...);
char *data = mmap(fd, ... MAP_SYNC);

static void handle_sigbus(int signal, siginfo_t *info, void *dontcare)
{
	char *buf;
	loff_t err_offset = (char *)info->si_addr - data;
	loff_t err_len = (1ULL << info->si_addr_lsb);
	ssize_t ret;

	printf("RECEIVED SIGBUS (POISON HANDLER)!\n");
	printf("    signal %d\n", info->si_signo);
	printf("    errno %d\n", info->si_errno);
	printf("    addr %p\n", info->si_addr);
	printf("    addr_lsb %d\n", info->si_addr_lsb);

	if (info->si_signo != SIGBUS) {
		printf("    code 0x%x\n", info->si_code);
		return;
	}

	switch (info->si_code) {
	case BUS_ADRALN:
		printf("    code: BUS_ADRALN\n");
		break;
	case BUS_ADRERR:
		printf("    code: BUS_ADRERR\n");
		break;
	case BUS_OBJERR:
		printf("    code: BUS_OBJERR\n");
		break;
	case BUS_MCEERR_AR:
		printf("    code: BUS_MCEERR_AR\n");
		break;
	case BUS_MCEERR_AO:
		printf("    code: BUS_MCEERR_AO\n");
		break;
	default:
		printf("    code 0x%x\n", info->si_code);
		break;
	}

	printf("    err_offset %lld\n", (unsigned long long)err_offset);
	printf("    err_len %lld\n", (unsigned long long)err_len);

	if (info->si_code != BUS_MCEERR_AR)
		return;

	/* clear poison and reset pmem to initial value */
	ret = fallocate(fd, FALLOC_FL_ZERO_RANGE, err_offset, err_len);
	if (ret) {
		perror("fallocate");
		exit(9);
	}

	/* simulate being lucky enough to be able to reconstruct the data */
	buf = malloc(err_len);
	if (!buf) {
		perror("malloc pwrite buf");
		exit(10);
	}

	memset(buf, 0x59, err_len);

	ret = pwrite(fd, buf, err_len, err_offset);
	if (ret < 0) {
		perror("pwrite");
		exit(11);
	}
	if (ret != err_len) {
		fprintf(stderr, "short write %zd bytes, wanted %lld\n",
				ret, (long long)err_len);
		exit(12);
	}

	free(buf);
}

--D

> 
> If you're going to start using this mess, you probably ought to just
> pull from my git trees, which are linked below.
> 
> This is an extraordinary way to destroy everything.  Enjoy!
> Comments and questions are, as always, welcome.
> 
> --D
> 
> kernel git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=dax-zeroinit-clear-poison-5.15
> ---
>  fs/dax.c            |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ext4/extents.c   |   19 +++++++++++++
>  fs/xfs/xfs_file.c   |   20 ++++++++++++++
>  include/linux/dax.h |    7 +++++
>  4 files changed, 118 insertions(+)
> 
