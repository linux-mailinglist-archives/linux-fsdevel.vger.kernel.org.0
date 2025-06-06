Return-Path: <linux-fsdevel+bounces-50802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C150ACFBB0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 05:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2950B1894FBB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 03:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178071AF0BB;
	Fri,  6 Jun 2025 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="s5/c576b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A144A0A
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 03:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749181484; cv=none; b=hnmXpWXlthIkK8XrU4z0DICf+j8lITPtsqHYvQawbMnlCGdvjfjzeI/pL5m/mUnsAqiAamOS7pWK/69kVmdNToVUgM1RcACOxAkY9v0Ih1c/iutg+Jump3AWQ0LRGAvHGMdZNFtOHK7MW664RXy7T2xZgAOaDEdUb1iGngzlpOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749181484; c=relaxed/simple;
	bh=7Gcyz4lcFxTKlo6zjl2FJukpdNtCdB1gv082wInIilc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kGh4uaAg6kQ8cX12UGdAgZDmZmnpshGIS0YlIcsBZEiJMebLVQLlghuO7LYvGMB9PhEY9/YFJThsEUpEPcuOZmnJp/FhqYFj7gtlIO/brao/JnGXXG1QFXPTzpmje5bsXnWoaToJJcMQv6PAl1HZhgiuFIBQvJCL4u9e3nIfOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=s5/c576b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCD5C4CEED;
	Fri,  6 Jun 2025 03:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749181483;
	bh=7Gcyz4lcFxTKlo6zjl2FJukpdNtCdB1gv082wInIilc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s5/c576bRJzYsDXXReflVW8+hvGEXNnWIqEtygmI6YIGk8U22b6RrfyxmreMkD1tQ
	 L3sKuRj39GVNSU9FvgjcFCtp2aodrPxjtdkBK6azpxX2N1dIqNuFrCV5GznHiPHlBf
	 KZENLzk32NIJY4s1tyyIZ+YLgOFvTpOLP/xa1m44=
Date: Thu, 5 Jun 2025 20:44:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: wangzijie <wangzijie1@honor.com>, rick.p.edgecombe@intel.com,
 ast@kernel.org, adobriyan@gmail.com, kirill.shutemov@linux.intel.com,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: clear FMODE_LSEEK flag correctly for permanent
 pde
Message-Id: <20250605204442.4a2e98b8feb6fc3603375b66@linux-foundation.org>
In-Reply-To: <20250606015621.GO299672@ZenIV>
References: <20250605065252.900317-1-wangzijie1@honor.com>
	<20250605144415.943b53ed88a4e0ba01bc5a56@linux-foundation.org>
	<20250606015621.GO299672@ZenIV>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Jun 2025 02:56:21 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Thu, Jun 05, 2025 at 02:44:15PM -0700, Andrew Morton wrote:
> > On Thu, 5 Jun 2025 14:52:52 +0800 wangzijie <wangzijie1@honor.com> wrote:
> > 
> > > Clearing FMODE_LSEEK flag should not rely on whether proc_open ops exists,
> > 
> > Why is this?
> > 
> > > fix it.
> > 
> > What are the consequences of the fix?  Is there presently some kernel
> > misbehavior?
> 
> At a guess, that would be an oops due to this:
>         if (pde_is_permanent(pde)) {
> 		return pde->proc_ops->proc_lseek(file, offset, whence);
> 	} else if (use_pde(pde)) {
> 		rv = pde->proc_ops->proc_lseek(file, offset, whence);
> 		unuse_pde(pde);
> 	}
> in proc_reg_llseek().  No FMODE_LSEEK == "no seeks for that file, just
> return -ESPIPE".  It is set by do_dentry_open() if you have NULL
> ->llseek() in ->f_op; the reason why procfs needs to adjust that is
> the it has uniform ->llseek, calling the underlying method for that 
> proc_dir_entry.  So if it's NULL, we need ->open() (also uniform,
> proc_reg_open() for all of those) to clear FMODE_LSEEK from ->f_mode.
> 
> The thing I don't understand is where the hell had proc_reg_open()
> changed in that way - commit refered in the patch doesn't exist in
> mainline, doesn't seem to be in -next or -stable either.

It's a fix against the very recently merged
https://lkml.kernel.org/r/20250528034756.4069180-1-wangzijie1@honor.com.

