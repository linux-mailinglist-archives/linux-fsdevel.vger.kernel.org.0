Return-Path: <linux-fsdevel+bounces-71266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C52CBBB8E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 15:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE9D33001E19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15BB2701DA;
	Sun, 14 Dec 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XSpmqRRn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A1239085;
	Sun, 14 Dec 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765723260; cv=none; b=YVWY+gcrQRE5bCGq0DSPjg8RzlayT3ob0gvJpM4BctDIq/E3g1PSk3+OvcUO/j5SJBkvv5s/A3n6FQK/db3bDIae+DKAgmqWOYPyj/1AuSkTTK9f5oegMva3TmP1BxNQt/Xpx1CVoo85kvVWSUawEFOmX5LYqYZuxcwIHcDgB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765723260; c=relaxed/simple;
	bh=146KBGCg7o3/dc/tflI3pPdn0VUNBeI4RTnRKhfkP2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaeDrf1fFqjg7AFGESZurQOfHGWWJkAMQsQQZG/c9mKRPrgUUrAc8R6HolGk2ZuJToA/YB2JLJ6f/IfCGng7tUjISOb+KMOvVMG/um7Jjf9pMYUes2/wq96dmQ51g7Kt1LWbdY9MPnqwr5LFgiMv0zXiCSa7IWcZ3Qd1RSiNZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XSpmqRRn; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=XKAespUOYboTSfbngcUd09WwtT+EjDuDc++HUrhPKVc=; b=XSpmqRRnm5Tt26iwkoZn47CYXN
	AIa5Z0g0hM26XwJqDHYF3x8SQwM4bI8Iyj+lXlybcSVkNfwwvvcTVx1SKzS04NTYMyaOglD4bn1eE
	k/tmD5dD6TY4d5XnRj/IQs5mwKE5FStrmugYDXesP5Sp0xrUNkZ9umxY1Uj0XDb4iX2QkCKpb1Jwe
	37WVFbr2Sa7UcU3cxfVWEvcKACxsUefrmRNbWUJZWR+uUmCCGFG5Tx3P/fwm179hxqmF/6RUWHJMN
	yDzA22kvijLb2EfROXxQvWaS/V8jM0ic4BLR1ecSjKYLaNt4d5HyIG5Ot4RqQJbBYYfU5kNjBKhuc
	2UhAawmQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1vUn4B-00BFJn-2y; Sun, 14 Dec 2025 14:27:19 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 190F6BE2EE7; Sun, 14 Dec 2025 15:27:18 +0100 (CET)
Date: Sun, 14 Dec 2025 15:27:18 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	1120058@bugs.debian.org, Joanne Koong <joannelkoong@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [regression] 0c58a97f919c ("fuse: remove tmp folio for writebacks
 and internal rb tree") results in suspend-to-RAM hang on AMD Ryzen 5 5625U
 on test scenario involving podman containers, x2go and openjdk workload
Message-ID: <aT7JRqhUvZvfUQlV@eldamar.lan>
References: <176227232774.2636.13973205036417925311.reportbug@probook>
 <aQrcFyO7tlFF0TyD@lorien.valinor.li>
 <176227232774.2636.13973205036417925311.reportbug@probook>
 <aSl-iAefeJJfjPJB@probook>
 <aSoBsX5MZXYCq2qZ@eldamar.lan>
 <176227232774.2636.13973205036417925311.reportbug@probook>
 <aSxCcapas1biHwBk@probook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSxCcapas1biHwBk@probook>
X-Debian-User: carnil

Hi Joanne,

In Debian J. Neuschäfer reported an issue where after 0c58a97f919c
("fuse: remove tmp folio for writebacks and internal rb tree") a
specific, but admittely not very minimal workload, involving podman
contains, x2goserver and a openjdk application restults in
suspend-to-ram hang.

The report is at https://bugs.debian.org/1120058 and information on
bisection and the test setup follows:

On Sun, Nov 30, 2025 at 02:11:13PM +0100, J. Neuschäfer wrote:
> On Fri, Nov 28, 2025 at 09:10:25PM +0100, Salvatore Bonaccorso wrote:
> > Control: found -1 6.17.8-1
> > 
> > Hi,
> > 
> > On Fri, Nov 28, 2025 at 11:50:48AM +0100, J. Neuschäfer wrote:
> > > On Wed, Nov 05, 2025 at 06:09:43AM +0100, Salvatore Bonaccorso wrote:
> [...]
> > > I can reproduce the bug fairly reliably on 6.16/17 by running a specific
> > > podman container plus x2go (not entirely sure which parts of this is
> > > necessary).
> > 
> > Okay if you have a very reliable way to reproduce it, would you be
> > open to make "your hands bit dirty" and do some bisecting on the
> > issue?
> 
> Thank you for your detailed instructions! I've already started and completed
> the git bisect run in the meantime. I had to restart a few times due to
> mistakes, but I was able to identify the following upstream commit as the
> commit that introduced the issue:
> 
> https://git.kernel.org/linus/0c58a97f919c24fe4245015f4375a39ff05665b6
> 
>     fuse: remove tmp folio for writebacks and internal rb tree
> 
> The relevant commit history is as follows:
> 
>   *   2619a6d413f4c3 Merge tag 'fuse-update-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse  <-- bad
>   |\  
>   | * dabb9039102879 fuse: increase readdir buffer size
>   | * 467e245d47e666 readdir: supply dir_context.count as readdir buffer size hint
>   | * c31f91c6af96a5 fuse: don't allow signals to interrupt getdents copying
>   | * f3cb8bd908c72e fuse: support large folios for writeback
>   | * 906354c87f4917 fuse: support large folios for readahead
>   | * ff7c3ee4842d87 fuse: support large folios for queued writes
>   | * c91440c89fbd9d fuse: support large folios for stores
>   | * cacc0645bcad3e fuse: support large folios for symlinks
>   | * 351a24eb48209b fuse: support large folios for folio reads
>   | * d60a6015e1a284 fuse: support large folios for writethrough writes
>   | * 63c69ad3d18a80 fuse: refactor fuse_fill_write_pages()
>   | * 3568a956932621 fuse: support large folios for retrieves
>   | * 394244b24fdd09 fuse: support copying large folios
>   | * f09222980d7751 fs: fuse: add dev id to /dev/fuse fdinfo
>   | * 18ee43c398af0b docs: filesystems: add fuse-passthrough.rst
>   | * 767c4b82715ad3 MAINTAINERS: update filter of FUSE documentation
>   | * 69efbff69f89c9 fuse: fix race between concurrent setattrs from multiple nodes
>   | * 0c58a97f919c24 fuse: remove tmp folio for writebacks and internal rb tree              <-- first bad commit
>   | * 0c4f8ed498cea1 mm: skip folio reclaim in legacy memcg contexts for deadlockable mappings
>   | * 4fea593e625cd5 fuse: optimize over-io-uring request expiration check
>   | * 03a3617f92c2a7 fuse: use boolean bit-fields in struct fuse_copy_state
>   | * a5c4983bb90759 fuse: Convert 'write' to a bit-field in struct fuse_copy_state
>   | * 2396356a945bb0 fuse: add more control over cache invalidation behaviour
>   | * faa794dd2e17e7 fuse: Move prefaulting out of hot write path
>   | * 0486b1832dc386 fuse: change 'unsigned' to 'unsigned int'
>   *   0fb34422b5c223 Merge tag 'vfs-6.16-rc1.netfs' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs   <-- good
> 
> The first and last commits shown are merge commits done by Linus Torvalds. The
> fuse-update branch was based on v6.15-rc1, under which I can't run my test due
> to an unrelated bug, so I ended up merging in 0fb34422b5c223 to test the
> commits within the fuse-update branch. e.g.:
> 
>   git reset --hard 394244b24fdd09 && git merge 0fb34422b5c223 && make clean && make
> 
> 
> I have also verified that the issue still happens on v6.18-rc7 but I wasn't
> able to revert 0c58a97f919 on top of this release, because a trivial revert
> is not possible.
> 
> My test case consists of a few parts:
> 
>  - A podman container based on the "debian:13" image (which points to
>    docker.io/library/debian via /etc/containers/registries.conf.d/shortnames.conf),
>    where I installed x2goserver and a openjdk-21-based application; It runs the
>    OpenSSH server and port 22 is exposed as localhost:2001
>  - x2goclient to start a desktop session in the container
> 
> Source code: https://codeberg.org/neuschaefer/re-workspace
> 
> I suspect, but haven't verified, that the X server in the container somehow
> uses the FUSE-emulated filesystem in the container to create a file that is
> used with mmap (perhaps to create shared pages as frame buffers).
> 
> 
> Raw bisect notes:
> 
> good:
> - v6.12.48+deb13-amd64
> - v6.12.59
> - v6.12
> - v6.14
> - v6.15-1304-g14418ddcc2c205
> - v6.15-10380-gec71f661a572
> - v6.15-10888-gb509c16e1d7cba
> - v6.15-rc7-357-g8e86e73626527e
> - v6.15-10933-g4c3b7df7844340
> - v6.15-10954-gd00a83477e7a8f
> - v6.15-rc7-366-g438e22801b1958 (CONFIG_X86_5LEVEL=y)
> - v6.15-rc4-126-g07212d16adc7a0
> - v6.15-10958-gdf7b9b4f6bfeb1    <-- first parent, 5LEVEL doesn't exist
> - v6.15-rc4-00127-g4d62121ce9b5
> - v6.15-rc7-375-g61374cc145f4a5  <-- second parent, `X86_5LEVEL=y`
> - v6.15-rc7-375-g61374cc145f4a5  <-- second parent, `X86_5LEVEL=n`
> - v6.15-11061-g7f9039c524a351: "first bad", actually good. merge of df7b9b4f6bfeb1 61374cc145f4a5
> - v6.15-11093-g0fb34422b5c223
> - v6.15-rc1-7-g0c4f8ed498cea1 + merge = v6.15-11101-gaec20ffad33068
> 
> testing:
> - v6.18-rc7 + revert: doesn't apply
> 
> weird (ssh doesn't work):
> - v6.15-rc1-1-g0486b1832dc386
> - v6.15-rc1-10-g767c4b82715ad3
> - v6.15-rc1-13-g394244b24fdd09: folio stuff
> - v6.15-rc1-22-gf3cb8bd908c72e
> - v6.15-rc1-23-gc31f91c6af96a5
> - next-20251128
> 
> bad:
> - v6.15-rc1-8-g0c58a97f919c24 + merge = v6.15-11102-gdfc4869c8ef1f0  first bad commit
> - v6.15-rc1-9-g69efbff69f89c9 + merge = v6.15-11103-ga7b103c57680ce
> - v6.15-rc1-11-g18ee43c398af0b + merge = v6.15-11105-g4ad0d4fa61974c
> - v6.15-rc1-13-g394244b24fdd09 + merge = v6.15-11107-g37da056b3b873b
> - v6.15-11119-g2619a6d413f4c3: merge of 0fb34422b5c223 (last good) dabb9039102879 (fuse branch)
> - v6.15-11165-gfd1f8473503e5b: confirmed bad
> - v6.15-11401-g69352bd52b2667
> - v6.15-12422-g2c7e4a2663a1ab
> - regulator-fix-v6.16-rc2-372-g5c00eca95a9a20
> - v6.16.12
> - v6.16.12 again
> - v6.16.12+deb14+1-amd64
> - v6.18-rc7

Would that ring some bells to you which make this tackable?

Regards,
Salvatore

