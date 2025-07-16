Return-Path: <linux-fsdevel+bounces-55083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB2B06C4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 05:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492DE1C203AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 03:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26F2279358;
	Wed, 16 Jul 2025 03:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Z+jouwOD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349311187;
	Wed, 16 Jul 2025 03:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636545; cv=none; b=iUAvgJKZaiwUo+7BHmbU8eYuYFMBZ+D2xKxAE+FRmUCBnXbPY/e6f5rzHjXV48SGs0fR48kQbNONIl1vj/80OaW67WhRqKBiiJZyeVQQygi2Not6xlid7Q6haBbwtZwrnvA1rphURFjAo9dQ1EHkfLXMR862tNKSHoI0UWZOZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636545; c=relaxed/simple;
	bh=9fVuKRupkpK0jeXpqHJzfBtwNx3YJfAqnBuOqi1+Yog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMneHEj80qEOyqeH91czQ8cBIke2LwH/xFc2RNKFUmv+xEvbexwylNad7JJtr1nS+hmJdN4oSJdBMFZo5swdY8dcCfEK265htOstoxqgPjvRa8h9eQTWiuaz31Gtk6keh7kfh0gepcXrAsprZLCCa+wqjo+KmoXqqpwCerDHoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Z+jouwOD; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752636224; bh=rVYXfJ28puNpDsYuCqlsBIEx1NeRES2IwwJ6mZh08HU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z+jouwODo5fKme7FRH/Ag79iESRnzlQ77J/b0EKsxfiRvcnvOoWGm58iPcQdgPioq
	 pXM5HsAae9UA2MnRyJ6vESygyrKS4ov2opGA/7WjvezxFIb5IPxnQmz1R+m1v1P3UA
	 uzDzQdbNrpAYYa3mQlHqMNBZ1NGRsCtnwR9fTEDg=
Received: from [172.25.20.187] ([111.202.154.66])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 5E88D015; Wed, 16 Jul 2025 11:23:40 +0800
X-QQ-mid: xmsmtpt1752636220tycb83gcn
Message-ID: <tencent_1C2FC8524B8F624445562817A2BE18E5700A@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPdKuf745NpqchrcYrT80cSkGsEezOdvuR17zHQEAfAqb15k9v58
	 e6/aINkDvUFB6XtpkSJZ5KY6+PyfVNNOTf8mD4q7weZ7nzy0eZssb4PasUrqSFHhZoxI2KFbfqsF
	 5uLIgB0jbNAWf+qPV0EYjIE56Ia5BU4l6fV2lfFV+vazL7cUVAqssEw6T5qWHQx5ezxPUFU+Ezpe
	 bZxOa+0uSgVLhYwFMiIaO8LTbBmE9vmzAs1jp/q4c/z9YCJW5yfAIC13ZXcN/pHnW4BAkbQcazmi
	 4yv9Bp5ceti/eLFLsHe5ClFNl0tWAWWkfOQkmtS7RQM49aSFxG1pwa3bMTWZc97UJFuus71FETLz
	 6vQXOTiDzKbl7pYAjYRiIvva3K+qDQINKquuXYbwpT3VwI2iRlb4gCmW94pnMtQJXCARi9G0GL9j
	 2R7D3ZKfqnz1biSCgdZAq0IfkFcoow7tReKz05Ol8TmGhiPqQbawgy1PpGHg8Di0Beoex1rurbnM
	 avA3ieh+UrpVV7cjuwRhxy5mDeGZIa19rJWmSnp6kvq1kfuZpHIbohexe2U8LFuCt8kcQiMH3n+y
	 83UmSX+1vH7z67biSLOGUXze5Pxx3D8huAF+HT4f8dzFfNZ6ziDC8kg8LBrdbd3qHtOHgpsSR8VG
	 Aid7treeFoiLHnqmd3raHkpQAe16YMDfGGb4IfN1W/5CL2CLgz6e3y8AinBfy9NX8uTxTtM0ujr1
	 ld4DTcuZWv52alaCQ56b+7JyGb48tm+52llAkbeKrkA6I06FBsFCrakEu0y+OO+Qu5gNpvrgnI6d
	 q+UVJNPSbVSxwv/6WLjRXqsFxzJ+te7n5AjtM2UCDJOnwn8rCF2+v7xLKkN7kmp+CkGm1nrmbN1R
	 u7etkw9ViyDwluV2oh312yNMag4FfzrZuZDx498iefnQ040V7R39wtKT2FZfzRzeYdgv3BN2IAlP
	 p7K4/7Dr3eD9QaPAihIasG/TqpR48mGdeu7F6TzZREX2lkb55/EkSpSNxm2Z/hD0kPBeK2KbPWGa
	 fo8o4tAV5gqaFp8WFGgHxzUB1lZCpXI4ZNTzhBoity48Yz8FYN
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-OQ-MSGID: <99f2ff09-6921-4c68-9783-c590ed4977f2@qq.com>
Date: Wed, 16 Jul 2025 11:23:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] fs: refactor write_begin/write_end and add ext4
 IOCB_DONTCACHE support
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, frank.li@vivo.com,
 tytso@mit.edu, hch@infradead.org, adilger.kernel@dilger.ca,
 willy@infradead.org, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, airlied@gmail.com
References: <20250710101404.362146-1-chentaotao@didiglobal.com>
 <20250714-tolerant-begreifbar-970f01d32a30@brauner>
From: Taotao Chen <chentao325@qq.com>
In-Reply-To: <20250714-tolerant-begreifbar-970f01d32a30@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/7/14 17:11, Christian Brauner 写道:
> On Thu, 10 Jul 2025 10:14:06 +0000, 陈涛涛 Taotao Chen wrote:
>> From: Taotao Chen <chentaotao@didiglobal.com>
>>
>> This patch series refactors the address_space_operations write_begin()
>> and write_end() callbacks to take const struct kiocb * as their first
>> argument, allowing IOCB flags such as IOCB_DONTCACHE to propagate to the
>> filesystem's buffered I/O path.
>>
>> [...]
> Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.17.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.17.misc
>
> [1/5] drm/i915: Use kernel_write() in shmem object create
>        https://git.kernel.org/vfs/vfs/c/110ae5fb48ed
> [2/5] drm/i915: Refactor shmem_pwrite() to use kiocb and write_iter
>        https://git.kernel.org/vfs/vfs/c/dd09194ff58c
> [3/5] fs: change write_begin/write_end interface to take struct kiocb *
>        https://git.kernel.org/vfs/vfs/c/254a06118b31
> [4/5] mm/pagemap: add write_begin_get_folio() helper function
>        https://git.kernel.org/vfs/vfs/c/ff2219c021c5
> [5/5] ext4: support uncached buffered I/O
>        https://git.kernel.org/vfs/vfs/c/2677497bc6f4
Hi Christian,

Kernel testing reported regression bugs in this patch series:
-  Reported-by: kernel test robot <lkp@intel.com>
    Closes: 
202507142128.Zr5StnYh-lkp@intel.com/">https://lore.kernel.org/oe-kbuild-all/202507142128.Zr5StnYh-lkp@intel.com/

- Reported-by: kernel test robot <lkp@intel.com>
   Closes: 
202507142040.wppyoX1s-lkp@intel.com/">https://lore.kernel.org/oe-kbuild-all/202507142040.wppyoX1s-lkp@intel.com/

I will send an updated version of the patch series shortly to address 
these issues.
Please consider dropping the original series from the vfs-6.17.misc 
branch once the new version is reviewed.

Thanks, and sorry for the trouble.

Taotao


