Return-Path: <linux-fsdevel+bounces-28234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EFF9685FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 13:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42881C208FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA83C184554;
	Mon,  2 Sep 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa2OVFDE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EC5175A5;
	Mon,  2 Sep 2024 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275837; cv=none; b=uvMvtEii36tBGGF9aafbyhDye1nX/nHAjUaySoZSsaeIlOpYgRpuerAKhqRWqkV6fo+DVvPgxngsGGSgc3q5at/ABHFDrkJQCSPxMVd/YaL2mkjysdX5zEc5TRTxKd20M+dQpA1IhUEd6HFuhLuNy4WEjE0MUW/N8MHcK0wxl2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275837; c=relaxed/simple;
	bh=wvzCQzSMfpZbVTjDOjDI58dr9I+13/EP2jjJQtbCpbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7Auwty0o/0ndTjweHvgYJ27ehMatNqSZI5BfcLKfLeThfYYQ2ClHNQ+6hVH9gwOd4ANkU6cOuPE7jLD9NcHq7P9VZnEIqyRqIEMOwkijQdwPOlukybsIR5aGpDr21aX+FyHqTAS1JfyCCY3gqRzSNqUv7QPLNKKt+w75nZOcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa2OVFDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8FFC4CEC2;
	Mon,  2 Sep 2024 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725275836;
	bh=wvzCQzSMfpZbVTjDOjDI58dr9I+13/EP2jjJQtbCpbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oa2OVFDEmQ8slnIh2J9t1nbdAZtj/jaNpeRqN3adjCVUCV3T6V/uaPIDmhZgUrwB8
	 MB3FRYqqbg61MJJx7GlSM7kpPcQEiw5H9LuvvSWzpIAgYfCqjI0t/orYLvZc46S9LE
	 Q3UOQGd7QnKGVyF7l1ZRvIQid57rRSw2XDZWzF2jLHVttAyz0JkSzMjAwDyzmnBAty
	 fCMW5ZeQzSpNzcG9wIA4VymXSquTCBhEqfJcmXGZ/0BMnX5kN+l3mdJn3gyudBURAn
	 Xe896b74pRHiYGt5Fop6S/z9uYWqk9giPcrO3WisOsf4LTqqV4DBsM1D3/MUstgbrv
	 hdYqne0LiItig==
Date: Mon, 2 Sep 2024 13:17:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, kees@kernel.org, j.granados@samsung.com, 
	willy@infradead.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, paul@paul-moore.com, jmorris@namei.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH -next 12/15] fs: dcache: move the sysctl into its own file
Message-ID: <20240902-kumpan-phosphor-439fd7ceecda@brauner>
References: <20240826120449.1666461-1-yukaixiong@huawei.com>
 <20240826120449.1666461-13-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826120449.1666461-13-yukaixiong@huawei.com>

On Mon, Aug 26, 2024 at 08:04:46PM GMT, Kaixiong Yu wrote:
> The sysctl_vfs_cache_pressure belongs to fs/dcache.c, move it to
> its own file from kernel/sysctl.c. As a part of fs/dcache.c cleaning,
> sysctl_vfs_cache_pressure is changed to a static variable, and export
> vfs_pressure_ratio with EXPORT_SYMBOL_GPL to be used by other files.
> And move the unneeded include(linux/dcache.h).
> 
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

