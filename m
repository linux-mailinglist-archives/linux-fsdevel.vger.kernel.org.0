Return-Path: <linux-fsdevel+bounces-50809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB94DACFC22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 07:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8D73A1614
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 05:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5811E25E3;
	Fri,  6 Jun 2025 05:13:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63AA86347
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749186814; cv=none; b=RHvBazlVu4XMEWv0L0c7T4R2DXvZxf8n0KTyfLSgH8hEysZRzANBq4rUmXZX7sNHEfCF/s018jWKzJwlo9HBnoygxKrdl4MfPFxuDNQXU/2nzH9UuQ+/rzpzlF9kXZQ0NAQjGx7SgCdVPXwTYXp0JcEpgZ1vQ9eZ3Kvm/sPd6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749186814; c=relaxed/simple;
	bh=egXZbZkgRJqxwk/KhnTEeWKK/CfLJ3ZBeQd78FfxKAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K63LGs07Jji+ucnV+9MJVHhNcBomp7fSbuP71xb9LtP4ideO/agJ2iqSMaNOEyja9Tv6r9g41yad5pUZ1lU60o8dTTqgeI8AekxyzqVfEqDYlN5M9S6UfDN3yl1OAtlGYGMYswsmB8mIbxL193kot/UGAIYQfXnXzExgWqzsZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4bD8Y54WnBzYkxhF;
	Fri,  6 Jun 2025 13:11:05 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Jun
 2025 13:13:24 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Jun
 2025 13:13:24 +0800
From: wangzijie <wangzijie1@honor.com>
To: <viro@zeniv.linux.org.uk>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <ast@kernel.org>,
	<kirill.shutemov@linux.intel.com>, <linux-fsdevel@vger.kernel.org>,
	<rick.p.edgecombe@intel.com>, <wangzijie1@honor.com>
Subject: Re: [PATCH] proc: clear FMODE_LSEEK flag correctly for permanent pde
Date: Fri, 6 Jun 2025 13:13:23 +0800
Message-ID: <20250606051323.1022692-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250606035714.GP299672@ZenIV>
References: <20250606035714.GP299672@ZenIV>
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

>On Fri, Jun 06, 2025 at 10:37:35AM +0800, wangzijie wrote:
>
>> My bad for making this misbehavior, thank you for helping explain it.
>> commit 654b33ada4ab("proc: fix UAF in proc_get_inode()") is in -stable, 
>> I refered v1 just for showing race in rmmod scenario, it's my bad.
>
>I still don't understand what's going on.  654b33ada4ab is both in
>mainline and in stable, but proc_reg_open() is nowhere near the
>shape your patch would imply.
>
>The best reconstruction I can come up with is that an earlier patch
>in whatever tree you are talking about has moved
>
>        if (!pde->proc_ops->proc_lseek)
>		file->f_mode &= ~FMODE_LSEEK;
>
>down, separately into permanent and non-permanent cases, after use_pde()
>in the latter case.  And the author of that earlier patch has moved
>the check under if (open) in permanent case, which would warrant that
>kind of fixup.
>
>However,
>	* why is that earlier patch sitting someplace that is *NOT*
>in -next?
>	* why bother with those games at all?  Just nick another bit
>from pde->flags (let's call it PROC_ENTRY_proc_lseek for consistency
>sake), set it in same pde_set_flags() where other flags are dealt with
>and just turn that thing into
>        if (!pde_has_proc_lseek(pde))
>		file->f_mode &= ~FMODE_LSEEK;
>leaving it where it is.  Less intrusive and easier to follow...
>
>	Call it something like
>
>check proc_lseek needs the same treatment as ones for proc_read_iter et.al.
>
>and describe it as a gap in "proc: fix UAF in proc_get_inode()",
>fixed in exact same manner...

Thank you very much for your suggestion! I will follow that and submit patch later.

