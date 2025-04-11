Return-Path: <linux-fsdevel+bounces-46244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE55A85A0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 12:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE281BA15B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C1B204581;
	Fri, 11 Apr 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrbBPnG2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE6278E5D;
	Fri, 11 Apr 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367490; cv=none; b=X0q3ef0Nmn8IP/Smz+krLcs4xafIgIxW3iosi3NAaoC5RxjZtrCAQl4Xa05zX3dejDpXZ1yk0PdOe4EUNaE52Vm8sgjdeZW7ZPPAEN+i4SdFYbJC294Qr3iXL22W+eaev5fcLxoOO56+7KL7B1dMo9ERxsDKTckyIpevQRTiE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367490; c=relaxed/simple;
	bh=CBOZiEYXaUGZUmNXcnuDFchwctmohPkPCFnb85gsKB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arRCOp+ssGlYLsZnCboZd2nHH+SOUj3rLuE9NqSE3I3ZFpilThWDpGmj2cyF+SmBSQ3oPzz8380ozBNNTeVPX9IwTn2r1ndMc66/3qte+bnI4tfdcTF2Y3TuEFwL5Jdn8N2+y/rvbY8Fs+U5NFrzbto5he7wC9TEXqFzT7iizBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrbBPnG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926F9C4CEE2;
	Fri, 11 Apr 2025 10:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744367490;
	bh=CBOZiEYXaUGZUmNXcnuDFchwctmohPkPCFnb85gsKB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrbBPnG2JVzLo+RNNYgIeV1NjMbBZG93Rs6RrMqDJuP0KPSK3OnxlI2ynUIeWbAgD
	 I6YGMxFDDZkADrhUrj48RmNezo+VvDRIio2aqlpLxW35XOSQWYUJoRJ4SQhocU+Nfb
	 xaew95RAGXN+iOlS5jzrLyFCRBZ6IDAOIWNi/k6UtuZgijrBEm5CpXchcOUFyw7NME
	 1Drr+rwGdeR1t7MRNnVtl7r4Ia9miN2dWj074DvDYpckzdwXvKX/3xJDsL4CKaFf3m
	 TyL6e98Mh1Cq/c/6KrfTDFF72KuAO2HWJMEOp9LfKAAexlP9rd4XdYSdZG2+7pD0q5
	 eB0rmpTyHFtYQ==
Date: Fri, 11 Apr 2025 11:31:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com,
	stable@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH 1/9] anon_inode: use a proper mode internally
Message-ID: <7a1a7076-ff6b-4cb0-94e7-7218a0a44028@sirena.org.uk>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KB8Y40lKK8UbHuHu"
Content-Disposition: inline
In-Reply-To: <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
X-Cookie: Entropy isn't what it used to be.


--KB8Y40lKK8UbHuHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 11:54:15AM +0200, Christian Brauner wrote:
> This allows the VFS to not trip over anonymous inodes and we can add
> asserts based on the mode into the vfs. When we report it to userspace
> we can simply hide the mode to avoid regressions. I've audited all
> direct callers of alloc_anon_inode() and only secretmen overrides i_mode
> and i_op inode operations but it already uses a regular file.

We've been seeing failures in LTP's readadead01 in -next on arm64
platforms:

 4601 07:43:36.192033  tst_test.c:1900: TINFO: LTP version: 20250130-1-g60f=
e84aaf
 4602 07:43:36.201811  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-rc1-ne=
xt-20250410 #1 SMP PREEMPT Thu Apr 10 06:18:38 UTC 2025 aarch64
 4603 07:43:36.208400  tst_kconfig.c:88: TINFO: Parsing kernel config '/pro=
c/config.gz'
 4604 07:43:36.218393  tst_test.c:1722: TINFO: Overall timeout per run is 0=
h 01m 30s
 4605 07:43:36.223886  readahead01.c:36: TPASS: readahead() with fd =3D -1 =
: EBADF (9)
 4606 07:43:36.229370  readahead01.c:43: TPASS: readahead() with invalid fd=
 : EBADF (9)
 4607 07:43:36.234998  readahead01.c:64: TPASS: readahead() on O_PATH file =
: EBADF (9)
 4608 07:43:36.240527  readahead01.c:64: TPASS: readahead() on directory : =
EINVAL (22)
 4609 07:43:36.246118  readahead01.c:64: TPASS: readahead() on /dev/zero : =
EINVAL (22)
 4610 07:43:36.251530  readahead01.c:64: TPASS: readahead() on pipe read en=
d : EINVAL (22)
 4611 07:43:36.260007  readahead01.c:64: TPASS: readahead() on pipe write e=
nd : EBADF (9)
 4612 07:43:36.265581  readahead01.c:64: TPASS: readahead() on unix socket =
: EINVAL (22)
 4613 07:43:36.270928  readahead01.c:64: TPASS: readahead() on inet socket =
: EINVAL (22)
 4614 07:43:36.276754  readahead01.c:64: TFAIL: readahead() on epoll succee=
ded
 4615 07:43:36.279460  readahead01.c:64: TFAIL: readahead() on eventfd succ=
eeded
 4616 07:43:36.285053  readahead01.c:64: TFAIL: readahead() on signalfd suc=
ceeded
 4617 07:43:36.290504  readahead01.c:64: TFAIL: readahead() on timerfd succ=
eeded
 4618 07:43:36.296220  readahead01.c:64: TFAIL: readahead() on fanotify suc=
ceeded
 4619 07:43:36.301605  readahead01.c:64: TFAIL: readahead() on inotify succ=
eeded
 4620 07:43:36.307327  tst_fd.c:170: TCONF: Skipping userfaultfd: ENOSYS (3=
8)
 4621 07:43:36.312806  readahead01.c:64: TFAIL: readahead() on perf event s=
ucceeded
 4622 07:43:36.318534  readahead01.c:64: TFAIL: readahead() on io uring suc=
ceeded
 4623 07:43:36.321511  readahead01.c:64: TFAIL: readahead() on bpf map succ=
eeded
 4624 07:43:36.325711  readahead01.c:64: TFAIL: readahead() on fsopen succe=
eded
 4625 07:43:36.331073  readahead01.c:64: TFAIL: readahead() on fspick succe=
eded
 4626 07:43:36.336608  readahead01.c:64: TPASS: readahead() on open_tree : =
EBADF (9)
 4627 07:43:36.336903 =20
 4628 07:43:36.339354  Summary:
 4629 07:43:36.339641  passed   10
 4630 07:43:36.342132  failed   11
 4631 07:43:36.342420  broken   0
 4632 07:43:36.342648  skipped  1
 4633 07:43:36.344768  warnings 0

which bisected down to this patch, which is cfd86ef7e8e7b9e01 in -next:

git bisect start
# status: waiting for both good and bad commits
# bad: [29e7bf01ed8033c9a14ed0dc990dfe2736dbcd18] Add linux-next specific f=
iles for 20250410
git bisect bad 29e7bf01ed8033c9a14ed0dc990dfe2736dbcd18
# status: waiting for good commit(s), bad commit known
# good: [1785a3a7b96a52fae13880a5ba880a5f473eacb1] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect good 1785a3a7b96a52fae13880a5ba880a5f473eacb1
# bad: [793874436825ebf3dfeeac34b75682c234cf61ef] Merge branch 'for-linux-n=
ext' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect bad 793874436825ebf3dfeeac34b75682c234cf61ef
# bad: [f8b5c1664191e453611f77d36ba21b09bc468a2d] Merge branch 'next' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
git bisect bad f8b5c1664191e453611f77d36ba21b09bc468a2d
# good: [100ac6e209fce471f3ff4d4e92f9d192fcfa7637] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
git bisect good 100ac6e209fce471f3ff4d4e92f9d192fcfa7637
# bad: [143ced925e31fe24e820866403276492f05efaa5] Merge branch 'vfs.all' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
git bisect bad 143ced925e31fe24e820866403276492f05efaa5
# good: [b087fb728fdda75e1d3e83aa542d3aa025ac6c4a] Merge branch 'nfsd-next'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect good b087fb728fdda75e1d3e83aa542d3aa025ac6c4a
# good: [7ee85aeee98e85f72a663672267180218d1510db] Merge branch 'vfs-6.16.s=
uper' into vfs.all
git bisect good 7ee85aeee98e85f72a663672267180218d1510db
# bad: [d57e6ea6671b1ef0fcb09ccc52952c8a6bfb83c8] Merge branch 'vfs-6.16.mi=
sc' into vfs.all
git bisect bad d57e6ea6671b1ef0fcb09ccc52952c8a6bfb83c8
# bad: [25a6cc9a630b4b1b783903b23a3a97c5bf16bf41] selftests/filesystems: ad=
d open() test for anonymous inodes
git bisect bad 25a6cc9a630b4b1b783903b23a3a97c5bf16bf41
# bad: [c83b9024966090fe0df92aab16975b8d00089e1f] pidfs: use anon_inode_set=
attr()
git bisect bad c83b9024966090fe0df92aab16975b8d00089e1f
# bad: [cfd86ef7e8e7b9e015707e46479a6b1de141eed0] anon_inode: use a proper =
mode internally
git bisect bad cfd86ef7e8e7b9e015707e46479a6b1de141eed0
# good: [418556fa576ebbd644c7258a97b33203956ea232] docs: initramfs: update =
compression and mtime descriptions
git bisect good 418556fa576ebbd644c7258a97b33203956ea232
# first bad commit: [cfd86ef7e8e7b9e015707e46479a6b1de141eed0] anon_inode: =
use a proper mode internally

--KB8Y40lKK8UbHuHu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf473wACgkQJNaLcl1U
h9C0mwf/Z6VumgdQekkgPeD7AJwWUiJAB0jgYh9xQWY++SYlNvknam/nnhWZCS/l
Oiszm6xnrjLIlgMjwdmURtNFhZS1Zq53TLiAgYdLzjIYLNZcLJWVUiPFjjREcErN
FX2C6sIhO7SBFyJJWFJM+/BH6O7EayofwJtJ+mQHOSdiT7OzB+XMJsDQBo24n2Qp
NpkfyucI891v8ZaW3pzTuN9QlcO5P/0BqxbCT2NBWzqJJE5SsQzKha+aDbdZZj9U
1qF3GClKuh58jqOvq3RmU8yto1pLcA6yTQUAoZpD/yiJ4vTLiWZ6y5cVeLitCU/N
qyjP53gugsYdaYIqeucK8EAh9QBbqQ==
=p9J/
-----END PGP SIGNATURE-----

--KB8Y40lKK8UbHuHu--

