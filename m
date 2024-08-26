Return-Path: <linux-fsdevel+bounces-27258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEA195FDBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 01:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DDB1C226CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4A419D093;
	Mon, 26 Aug 2024 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqYf0des"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC413DB90;
	Mon, 26 Aug 2024 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724714297; cv=none; b=syjeiaxAR0WrJw4H7LN8nKsXFCGL5vUXcVq6DeRxkg6I5WErKBNN/C24pkyohvYTYlUvhFFSXVJ2a9E1I2OL0M+mEq2aqdpmnkN1iRRe1i5FhHowuOPeguNg6Y/hy+3n4CMRhwJxwb2G7PSJHwaz7msTCgzyG1461tsnsbFO8rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724714297; c=relaxed/simple;
	bh=1dpNJlo6lGijOrGFGNCx0R1fCSCkUOR4V6uR9R3YQf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sdZ904gPbRzv7WuQYPoCu0NUh8tkCcgsugBBdwPnht3gqx0pwFzzIVvPzekNKPQlMHcgmr4PpcyEJGuPQpc1GJ3kAd/4EXlMcoRIxJ+3r3Hu91ebhY9UK3M7OM/kOxjY4whCYG2OkzfbqqT8PaxyQEo0/5AWbyVPAO5vcLFwt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqYf0des; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724714294; x=1756250294;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=1dpNJlo6lGijOrGFGNCx0R1fCSCkUOR4V6uR9R3YQf8=;
  b=HqYf0deszrMq8UoxHlFgVdeYHPUcvEhWuO9sL3XAkQHC8ZV7n62OGrVm
   JSsgVclg7zuqRlzGM1QKsYyic5knpO6gipGhi0RbMZIdYkxc/O0rj0rH/
   JoBfuTTuDfgYe9CEyDAIrXpoCKmFcP3H41TvCHBOSSG/h3s7dX9jLM7xD
   WGt8DXcVHvcKcqCgffVoH7KHfmuzpvs7calSX/g2t3WWKsZ9lXohalWY5
   AL/NbhIWGDJuAoTg6FBU2cW8O2P9HSnpXoUDRhBsEJNlRwNY6nAiaCu7i
   MPFjCuGJUTN6xYmssQoXL3JAciG4/kWPIT5D1bvrebMMruMrSWSKIUXRJ
   g==;
X-CSE-ConnectionGUID: M5xCa3DyT9GDPlpHbbcnhA==
X-CSE-MsgGUID: hJY/hrHwQ8iISkXTHMID9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="22759264"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="22759264"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 16:18:13 -0700
X-CSE-ConnectionGUID: mpYXIYZNSX+bE/KdPiZ84A==
X-CSE-MsgGUID: AUU4DNqxTS6H6CUNTg1BMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62623183"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.223.39])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 16:18:10 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/16] overlayfs/file: Convert to cred_guard()
In-Reply-To: <CAOQ4uxizZ0wM4LPUkAnpJT7ouJGeEa7FPUZqe9M17xL1w_gddQ@mail.gmail.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
 <20240822012523.141846-11-vinicius.gomes@intel.com>
 <CAOQ4uxizZ0wM4LPUkAnpJT7ouJGeEa7FPUZqe9M17xL1w_gddQ@mail.gmail.com>
Date: Mon, 26 Aug 2024 16:18:07 -0700
Message-ID: <87plpukh5c.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amir Goldstein <amir73il@gmail.com> writes:
>> -       old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
>> -       ret = vfs_fallocate(real.file, mode, offset, len);
>> -       revert_creds_light(old_cred);
>> +       cred_scoped_guard(ovl_creds(file_inode(file)->i_sb))
>> +               ret = vfs_fallocate(real.file, mode, offset, len);
>>
>
> I find this syntax confusing. Even though it is a valid syntax,
> I prefer that if there is a scope we use explicit brackets for it even
> if the scope is
> a single line.
>

Will add the brackets.

> How about using:
>        {
>                cred_guard(ovl_creds(file_inode(file)->i_sb));
>                ret = vfs_fallocate(real.file, mode, offset, len);
>        }
>
> It is more clear and helps averting the compiler bug(?).

I prefer the scoped_cred_guard() idiom, having it spelled out sounds
better to me. But a new block should avoid the bug as well.

>
> Maybe we should just place cred_guard(ovl_creds(file_inode(file_out)->i_sb))
> in ovl_copy_file_range()?
>
> I don't think that the order of ovl_override_creds() vs. inode_lock()
> really matters?
>

Most probably the order should not matter. Will change this.

> Thanks,
> Amir.


Cheers,
-- 
Vinicius

