Return-Path: <linux-fsdevel+bounces-53476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30706AEF6A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1931C01CEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70719272813;
	Tue,  1 Jul 2025 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on5fa/N7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AD8821;
	Tue,  1 Jul 2025 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369694; cv=none; b=JDcX40NMtMHPgFgT7cvukmiGznVQzHWX8PlEDPTCqHM7OQysqfql/z+uNKSnieIGiOwWbmptTX76FRKcdwJtBlS/JOtf6jmy6YT9hwcCctNYrQq983RisfAz3T7eaz0e80fT2Nuv8QiotM5zhPtGa+iDjKoAXNfBUoRjPrdPA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369694; c=relaxed/simple;
	bh=ivvvymmSfinokPA9qi1LGV8jWib2h8DV4cJuLS0xY2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6poiBbmtdfzI0Hfb2P89bH+e94a6Ccts5EYpD4MpDUPfsCEz+urJQUVjo7I1DRLcOfegHt9pbq7N9XAuzSSecB0sOXLz2+O1VT3XgK5Wu0rb2zIUdOPrLsORvVOcvaIqb+uGLqrB25QRdq+RqeXkfl/hutwCAwUANtYnlwwUq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on5fa/N7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25244C4CEEB;
	Tue,  1 Jul 2025 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751369693;
	bh=ivvvymmSfinokPA9qi1LGV8jWib2h8DV4cJuLS0xY2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=on5fa/N7993Xiu8R8CmxLBfvJ25rLsGHcos0mtPx5h7O+Uf8PnRwRziavn1ZNk3qD
	 dTlslotJxMgwQgJdXVemlWpk547OoKF09nmdwOK8mjg9Dw3s1arKSEV7tTpFEdh6CL
	 NPKTxPzuKGG96E1Io5mCVhQJcuVdbIQr7g2WAtZWHqBLqFkVGUgpLGBnnyKZqHp0Vb
	 SyfLuqjRiNIcavAZo9eM7r4tSbw+tiGx6AdcIMvQ+ypA9/f+T8O/0PhvLXdKbUnh9n
	 wRC++Hv0QndQB4NIsjh8/mPRVtWo7RD9dV/TsgFK2FYIkOWjAQtc3iDsqfTq8TepTW
	 55NYlUn9KniJQ==
Date: Tue, 1 Jul 2025 13:34:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: kernel test robot <lkp@intel.com>, linux-fsdevel@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, hch@lst.de, miklos@szeredi.hu, djwong@kernel.org, 
	anuj20.g@samsung.com, linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 13/16] fuse: use iomap for writeback
Message-ID: <20250701-duktus-weitverbreitet-fb6b177ba0d8@brauner>
References: <20250624022135.832899-14-joannelkoong@gmail.com>
 <202506252117.9V3HTO0i-lkp@intel.com>
 <CAJnrk1Z5NZ0_f=OMMam9hf0xJwM=SsmgFpyfbnKE7MT_i_kZMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z5NZ0_f=OMMam9hf0xJwM=SsmgFpyfbnKE7MT_i_kZMQ@mail.gmail.com>

On Wed, Jun 25, 2025 at 09:48:15AM -0700, Joanne Koong wrote:
> On Wed, Jun 25, 2025 at 7:18 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Joanne,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on brauner-vfs/vfs.all]
> > [also build test ERROR on xfs-linux/for-next linus/master v6.16-rc3 next-20250625]
> > [cannot apply to gfs2/for-next mszeredi-fuse/for-next]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/iomap-pass-more-arguments-using-struct-iomap_writepage_ctx/20250624-102709
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
> > patch link:    https://lore.kernel.org/r/20250624022135.832899-14-joannelkoong%40gmail.com
> > patch subject: [PATCH v3 13/16] fuse: use iomap for writeback
> > config: arm64-randconfig-003-20250625 (https://download.01.org/0day-ci/archive/20250625/202506252117.9V3HTO0i-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 12.3.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250625/202506252117.9V3HTO0i-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202506252117.9V3HTO0i-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    aarch64-linux-ld: fs/fuse/file.o: in function `fuse_writepages':
> > >> file.c:(.text+0xa30): undefined reference to `iomap_writepages'
> > >> file.c:(.text+0xa30): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_writepages'
> >    aarch64-linux-ld: fs/fuse/file.o: in function `fuse_writepage_finish':
> > >> file.c:(.text+0x1fd8): undefined reference to `iomap_finish_folio_write'
> > >> file.c:(.text+0x1fd8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_finish_folio_write'
> >    aarch64-linux-ld: fs/fuse/file.o: in function `fuse_cache_write_iter':
> >    file.c:(.text+0x888c): undefined reference to `iomap_file_buffered_write'
> >    file.c:(.text+0x888c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_file_buffered_write'
> >    aarch64-linux-ld: fs/fuse/file.o: in function `fuse_iomap_writeback_range':
> > >> file.c:(.text+0x9258): undefined reference to `iomap_start_folio_write'
> > >> file.c:(.text+0x9258): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_start_folio_write'
> > >> aarch64-linux-ld: fs/fuse/file.o:(.rodata+0x370): undefined reference to `iomap_dirty_folio'
> >    aarch64-linux-ld: fs/fuse/file.o:(.rodata+0x3a0): undefined reference to `iomap_release_folio'
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> As noted in the cover letter [1]
> 
>    Please note the following:
>    * this patchset version temporarily drops the CONFIG_BLOCK iomap refactoring
>      patches that will be needed to merge in the series. As of now, this breaks
>      compilation for environments where CONFIG_BLOCK is not set, but the
>      CONFIG_BLOCK iomap changes will be re-added back in once the core changes
>      in this patchset are ready to go.
> 
> 
> These errors will be fixed in later versions when the CONFIG_BLOCK
> patches get added in.

Ok, sounds good. Main thing is I can merge it all in one go.

