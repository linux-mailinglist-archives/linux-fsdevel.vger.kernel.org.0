Return-Path: <linux-fsdevel+bounces-815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E38E7D0C98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 12:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 865C5B21579
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7193F15EA1;
	Fri, 20 Oct 2023 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ukw+27nf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC914018;
	Fri, 20 Oct 2023 10:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B358C433C7;
	Fri, 20 Oct 2023 10:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697796096;
	bh=lzHAk3dExR6FwsdPVTRy5vF1LS3VUKmX2W/bDr/QLoI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=Ukw+27nf/Tijp3Zq0ul5lRnbqUtAFqAtg7gINa2ZueIF8VfPgtXoJRXPOMGlA+FoF
	 b1zPl60AUrzHMljNOukoj6fjRA1Q1hKWRwEJR/6N4LSDkZOD5KRmHFVWxsHvPYilr0
	 VZQPeycZUgdsk7rPYT+uVXKbhUfj4/UzgtpIF5h9xTVSno4/SBUPgd7q11H8gyw+ju
	 Zs8tUWS92TYsG1zWu/YCb8fmPn1SHheBlow6SR0TjmqazyLKZqiFzvGiNUFqwrq9Cb
	 w9cPlWTpuBYioFlAzXz47nDOilJi/Ilz1a9wMmjnpBOQj9k1idf4TGMdlw6uDGPUZf
	 WN0YDjjnQp7YQ==
References: <20230828065744.1446462-1-ruansy.fnst@fujitsu.com>
 <20230928103227.250550-1-ruansy.fnst@fujitsu.com>
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: akpm@linux-foundation.org
Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
 djwong@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH v15] mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind
Date: Fri, 20 Oct 2023 15:26:32 +0530
In-reply-to: <20230928103227.250550-1-ruansy.fnst@fujitsu.com>
Message-ID: <875y31wr2d.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 28, 2023 at 06:32:27 PM +0800, Shiyang Ruan wrote:
> ====
> Changes since v14:
>  1. added/fixed code comments per Dan's comments
> ====
>
> Now, if we suddenly remove a PMEM device(by calling unbind) which
> contains FSDAX while programs are still accessing data in this device,
> e.g.:
> ```
>  $FSSTRESS_PROG -d $SCRATCH_MNT -n 99999 -p 4 &
>  # $FSX_PROG -N 1000000 -o 8192 -l 500000 $SCRATCH_MNT/t001 &
>  echo "pfn1.1" > /sys/bus/nd/drivers/nd_pmem/unbind
> ```
> it could come into an unacceptable state:
>   1. device has gone but mount point still exists, and umount will fail
>        with "target is busy"
>   2. programs will hang and cannot be killed
>   3. may crash with NULL pointer dereference
>
> To fix this, we introduce a MF_MEM_PRE_REMOVE flag to let it know that we
> are going to remove the whole device, and make sure all related processes
> could be notified so that they could end up gracefully.
>
> This patch is inspired by Dan's "mm, dax, pmem: Introduce
> dev_pagemap_failure()"[1].  With the help of dax_holder and
> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
> on it to unmap all files in use, and notify processes who are using
> those files.
>
> Call trace:
> trigger unbind
>  -> unbind_store()
>   -> ... (skip)
>    -> devres_release_all()
>     -> kill_dax()
>      -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
>       -> xfs_dax_notify_failure()
>       `-> freeze_super()             // freeze (kernel call)
>       `-> do xfs rmap
>       ` -> mf_dax_kill_procs()
>       `  -> collect_procs_fsdax()    // all associated processes
>       `  -> unmap_and_kill()
>       ` -> invalidate_inode_pages2_range() // drop file's cache
>       `-> thaw_super()               // thaw (both kernel & user call)
>
> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
> event.  Use the exclusive freeze/thaw[2] to lock the filesystem to prevent
> new dax mapping from being created.  Do not shutdown filesystem directly
> if configuration is not supported, or if failure range includes metadata
> area.  Make sure all files and processes(not only the current progress)
> are handled correctly.  Also drop the cache of associated files before
> pmem is removed.
>
> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> [2]: https://lore.kernel.org/linux-xfs/169116275623.3187159.16862410128731457358.stg-ugh@frogsfrogsfrogs/
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Acked-by: Dan Williams <dan.j.williams@intel.com>

Hi Andrew,

Shiyang had indicated that this patch has been added to
akpm/mm-hotfixes-unstable branch. However, I don't see the patch listed in
that branch.

I am about to start collecting XFS patches for v6.7 cycle. Please let me know
if you have any objections with me taking this patch via the XFS tree.

-- 
Chandan

