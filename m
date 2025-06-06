Return-Path: <linux-fsdevel+bounces-50801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28653ACFBAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 05:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB491178190
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 03:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1678819D06A;
	Fri,  6 Jun 2025 03:34:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E124A0A
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749180896; cv=none; b=IFz8m6UUC4f/psWhrtgWvunF1soValS6gFb+XiTJvC8G4ZMvxUiyBnpBBrR6SIwlCXU7SwOe11N5AsVYPM24rFouvkBXT2c1/17VaZNl57UFiGbTb5H0pBXLwOtqsYHdyocXYSNag/J8e4CB7Dwt+Hhw/AkES5RCbGqMWdi6CQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749180896; c=relaxed/simple;
	bh=58n9a6aJHDN8zOGSa0IQHV3qICjp5tzJagKU5b2gMxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epqPk1sv+qsr2z2dHfnkSfs0LuJLKoWYcqNgpmmU0JeVVzaUWbp+N1WnrdCeEdO80OG/zba1n9T7Fy3YNhutUnoWe0hTtyhEj1FDnWwTo03T/6U9g8UjMHAWV0G2Fo9bvV+/8BAoXMrRIYxfws6f7ETYzNhkQuqVAYVJMiUMdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4bD6MN32v1zYl3QQ;
	Fri,  6 Jun 2025 11:32:32 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Jun
 2025 11:34:51 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Jun
 2025 11:34:50 +0800
From: wangzijie <wangzijie1@honor.com>
To: <viro@zeniv.linux.org.uk>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <ast@kernel.org>,
	<kirill.shutemov@linux.intel.com>, <linux-fsdevel@vger.kernel.org>,
	<rick.p.edgecombe@intel.com>, <wangzijie1@honor.com>
Subject: Re: [PATCH] proc: clear FMODE_LSEEK flag correctly for permanent pde
Date: Fri, 6 Jun 2025 11:34:50 +0800
Message-ID: <20250606033450.1014786-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250606015621.GO299672@ZenIV>
References: <20250606015621.GO299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a011.hihonor.com
 (10.68.31.243)

>On Thu, Jun 05, 2025 at 02:44:15PM -0700, Andrew Morton wrote:
>> On Thu, 5 Jun 2025 14:52:52 +0800 wangzijie <wangzijie1@honor.com> wrote:
>> 
>> > Clearing FMODE_LSEEK flag should not rely on whether proc_open ops exists,
>> 
>> Why is this?
>> 
>> > fix it.
>> 
>> What are the consequences of the fix?  Is there presently some kernel
>> misbehavior?
>
>At a guess, that would be an oops due to this:
>        if (pde_is_permanent(pde)) {
>		return pde->proc_ops->proc_lseek(file, offset, whence);
>	} else if (use_pde(pde)) {
>		rv = pde->proc_ops->proc_lseek(file, offset, whence);
>		unuse_pde(pde);
>	}
>in proc_reg_llseek().  No FMODE_LSEEK == "no seeks for that file, just
>return -ESPIPE".  It is set by do_dentry_open() if you have NULL
>->llseek() in ->f_op; the reason why procfs needs to adjust that is
>the it has uniform ->llseek, calling the underlying method for that 
>proc_dir_entry.  So if it's NULL, we need ->open() (also uniform,
>proc_reg_open() for all of those) to clear FMODE_LSEEK from ->f_mode.
>
>The thing I don't understand is where the hell had proc_reg_open()
>changed in that way - commit refered in the patch doesn't exist in
>mainline, doesn't seem to be in -next or -stable either.

I think maybe I misunderstand what you mean, this hell misbehavior(commit I refered)
is in mm-nonmm-unstable, so this fix is based on mm-nonmm-unstable.

