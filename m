Return-Path: <linux-fsdevel+bounces-73206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1DDD11A67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 725AD3021A57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827B2820A0;
	Mon, 12 Jan 2026 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEU9mwaI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DB027AC4D;
	Mon, 12 Jan 2026 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211802; cv=none; b=FQsqS6EEPO5kuTVmeEiz7iujqupc94xWHTofISjPTBaIS1St+JOLzXbS/gnk/1WSZHik00kA3ZHemkDORFlWM7uHa3BHE1KLTVDqdYYuZ/7BNj/8S49+GgiBO7PHFxkhDDjixDsEq7SRc1+woO6H4wIIdGxzmRefzh0Cryd13+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211802; c=relaxed/simple;
	bh=7FithyIBKaoedpqmHqroS7296muzq9qFftbtMNAIURw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEuNPDliH34Z+TXkLmonoXQHJ8k1LLZWdPuDVkhnnm+7S/Y0Klz1UyZVT6wG01t0C+QFc4G0FbwJfJMukhTcnew/HmGJ2eCn++EEZZcqiGOsLHblqRcONWHEhcS8l2sRfelO+8Q2I8aBJgajEmo/8hteGITKtpSquS5MAEIAJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEU9mwaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E7DC116D0;
	Mon, 12 Jan 2026 09:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768211800;
	bh=7FithyIBKaoedpqmHqroS7296muzq9qFftbtMNAIURw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gEU9mwaIMduY/7UbDRfY3dCfNhfrteaHYYuLXyRnnRx/QJgC20lljrEWUMS7U6O0R
	 FC4KxbfeMIzSr1rRikavC/N+gC8ZfUxStYxTRJJhtfOpS2cGLgj7zxDin23MW6Wb7P
	 1GOMC1no3G/npgBBoc6dk10UcMEW7fSBM4p03vkd1kqbUw8Lw6VvU4ZPPkKi6WPwPs
	 cFsx7BjBlanMei3Mx7O56x77krT1lDMI8Q5IBx6rppzFEkL7VX/wsOGT2lTjE9XE60
	 DtV+U34LS4bSOB3RmY3uhoDoP3WLijr7CMYxfWHp68KquGlaW4jVxNHX1fQyEK5DDo
	 mEN7+/Mr4XdZg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Anders Larsen <al@alarsen.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Jan Kara <jack@suse.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Dave Kleikamp <shaggy@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Carlos Maiolino <cem@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Hans de Goede <hansg@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org,
	ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	gfs2@lists.linux.dev,
	linux-doc@vger.kernel.org,
	v9fs@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to lease support
Date: Mon, 12 Jan 2026 10:56:12 +0100
Message-ID: <20260112-wolldecke-fernhalten-1ed186b0d6d4@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3741; i=brauner@kernel.org; h=from:subject:message-id; bh=7FithyIBKaoedpqmHqroS7296muzq9qFftbtMNAIURw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmHHURP88sMJN9ukDhRhXbqQequdlWvjZyfBfLe1DV5 5jhhU9qHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABcxZfifcM15deTeLVM3FDGZ slyxOp2V1fLaePb0rF9Nh78+em/0gOF/0ZzNd4vlgpU/arScCRCctkFYad0Mv4pHyyuf8rps+VT FBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 08 Jan 2026 12:12:55 -0500, Jeff Layton wrote:
> Yesterday, I sent patches to fix how directory delegation support is
> handled on filesystems where the should be disabled [1]. That set is
> appropriate for v6.19. For v7.0, I want to make lease support be more
> opt-in, rather than opt-out:
> 
> For historical reasons, when ->setlease() file_operation is set to NULL,
> the default is to use the kernel-internal lease implementation. This
> means that if you want to disable them, you need to explicitly set the
> ->setlease() file_operation to simple_nosetlease() or the equivalent.
> 
> [...]

Applied to the vfs-7.0.leases branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.leases branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.leases

[01/24] fs: add setlease to generic_ro_fops and read-only filesystem directory operations
        https://git.kernel.org/vfs/vfs/c/ca4388bf1d9e
[02/24] affs: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/663cdef61a27
[03/24] btrfs: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/f9688474e413
[04/24] erofs: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/f8902d3df893
[05/24] ext2: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/ccdc2e0569f5
[06/24] ext4: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/20747a2a29c6
[07/24] exfat: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/b8ca02667552
[08/24] f2fs: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/9e2ac6ddb397
[09/24] fat: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/a9acc8422ffb
[10/24] gfs2: add a setlease file operation
        https://git.kernel.org/vfs/vfs/c/3b514c333390
[11/24] jffs2: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/c275e6e7c085
[12/24] jfs: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/7dd596bb35e5
[13/24] nilfs2: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/f46bb13dc5d9
[14/24] ntfs3: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/6aaa1d6337b5
[15/24] ocfs2: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/f15d3150279d
[16/24] orangefs: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/136b43aa4b16
[17/24] overlayfs: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/94a3f60af5dc
[18/24] squashfs: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/dfd8676efe43
[19/24] tmpfs: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/f5a3446be277
[20/24] udf: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/dbe8d57d1483
[21/24] ufs: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/545b4144d804
[22/24] xfs: add setlease file operation
        https://git.kernel.org/vfs/vfs/c/6163b5da2f5e
[23/24] filelock: default to returning -EINVAL when ->setlease operation is NULL
        https://git.kernel.org/vfs/vfs/c/2b10994be716
[24/24] fs: remove simple_nosetlease()
        https://git.kernel.org/vfs/vfs/c/51e49111c00b

