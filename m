Return-Path: <linux-fsdevel+bounces-50800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB05ACFB4F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 04:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC8C18985FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 02:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EF961FFE;
	Fri,  6 Jun 2025 02:37:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E117081E
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749177465; cv=none; b=tD1da+Xd+EXWbL+0XfM78YhWQw8o/vyXXNGa58ggoL6xFX1XBjM72E48S1GJt11HsYL/FJHzvhXAehdQ6CqqvNvMNOgS6kKAHIRmisQEMXLpDvICaI5djOWbRQtyvG8pgTUZtn1Z1uLSiV/WKnvIt9lrg80JtklHlIsnIXyzXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749177465; c=relaxed/simple;
	bh=Yees/gQs/LxS8fZ08n/bEUuoHrXNaxHThzMs/z0RjVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1t47LVAjAoZTDWAPbOwN2hcZ5v/xGpv5ghIlh+1o3snTzSYBYm5XqsBi2tgbtcb8yyCP8yydpKf7bsA0hPGDqocr5lGGAXTJfCPxhNA1L7bLZ7oKxO2UORsfWd4zUFssDid4fRmJ3VTF0T2LQKwn5dxMBL0I5OCDGX2cmWi92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4bD55b42vVzYkxww;
	Fri,  6 Jun 2025 10:35:31 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Jun
 2025 10:37:35 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Jun
 2025 10:37:35 +0800
From: wangzijie <wangzijie1@honor.com>
To: <viro@zeniv.linux.org.uk>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <ast@kernel.org>,
	<kirill.shutemov@linux.intel.com>, <linux-fsdevel@vger.kernel.org>,
	<rick.p.edgecombe@intel.com>, <wangzijie1@honor.com>
Subject: Re: [PATCH] proc: clear FMODE_LSEEK flag correctly for permanent pde
Date: Fri, 6 Jun 2025 10:37:35 +0800
Message-ID: <20250606023735.1009957-1-wangzijie1@honor.com>
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
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a011.hihonor.com
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

My bad for making this misbehavior, thank you for helping explain it.
commit 654b33ada4ab("proc: fix UAF in proc_get_inode()") is in -stable, 
I refered v1 just for showing race in rmmod scenario, it's my bad.

