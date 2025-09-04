Return-Path: <linux-fsdevel+bounces-60313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA0DB449FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 00:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278503B52EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 22:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96FA2F4A1E;
	Thu,  4 Sep 2025 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DMHDWDXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9E42E8B87;
	Thu,  4 Sep 2025 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757026519; cv=none; b=Zq4oO8rXuoUvYhwdisrGoDGdHBp/uY+jj3EmeTaGX3zYzd7m4wjgsyf0AjEjfsZzahnqtI8wCyDYgJpkcYFvf7KgcZs6zn73KW3uJqgW2hcK/wvarALOZ5F19KgM54kHz/bx8/aT/aWTGJpwPRJZ5T3TTt7q/VPs2iV+Gx9fBDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757026519; c=relaxed/simple;
	bh=QO4RwRkXhrHS5NwMcdJkydHqPamAsGH4fQN6yhVT/hc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m3W5mFXBSKnq6tTTFTv8qorCIJ4LKBLqaUQmPAmfGOedicBijWEZAs6HBFH3vIOMJ3xmCgGIzNgr1XuqyZ57/DzTIZhmHkjOeHw/T/xOrwVAW18hfJmqAmMQKBHP9Ia2hqqjhVe/nB95hINLRFzj1+MM8bkf6eEFsHMpfHCl8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DMHDWDXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E92BC4CEF0;
	Thu,  4 Sep 2025 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757026518;
	bh=QO4RwRkXhrHS5NwMcdJkydHqPamAsGH4fQN6yhVT/hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DMHDWDXSll9gFxKCUy8pBUDwrnJ+TnOf6UwPdUDhv5Kwhyq05D/2tkBjyU2Xi7ObJ
	 4xKgcjNvFiy375wYMVGF6BQUNKS+GqJ3qHNDkFJa/bfuDRd1iKRpEPUiSVjItdTdr3
	 18DrmxdJ/iJYABmBeq6TjtK675PerUaHFV0BCerA=
Date: Thu, 4 Sep 2025 15:55:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: wangzijie <wangzijie1@honor.com>
Cc: <brauner@kernel.org>, <viro@zeniv.linux.org.uk>, <adobriyan@gmail.com>,
 <jirislaby@kernel.org>, <sbrivio@redhat.com>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Brad
 Spengler <spender@grsecurity.net>
Subject: Re: [PATCH] proc: fix type confusion in pde_set_flags()
Message-Id: <20250904155517.d623a254e8c25027c41e8e41@linux-foundation.org>
In-Reply-To: <20250904135715.3972782-1-wangzijie1@honor.com>
References: <20250904135715.3972782-1-wangzijie1@honor.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 21:57:15 +0800 wangzijie <wangzijie1@honor.com> wrote:

> Commit 2ce3d282bd50 ("proc: fix missing pde_set_flags() for net proc files")
> missed a key part in the definition of proc_dir_entry:
> 
> union {
> 	const struct proc_ops *proc_ops;
> 	const struct file_operations *proc_dir_ops;
> };
> 
> So dereference of ->proc_ops assumes it is a proc_ops structure results in
> type confusion and make NULL check for 'proc_ops' not work for proc dir.
> 
> Add !S_ISDIR(dp->mode) test before calling pde_set_flags() to fix it.
> 
> Fixes: 2ce3d282bd50 ("proc: fix missing pde_set_flags() for net proc files")

2ce3d282bd50 had cc:stable, so I added cc:stable to this patch.

> Reported-by: Brad Spengler <spender@grsecurity.net>
> Signed-off-by: wangzijie <wangzijie1@honor.com>

A link to Brad's report would be helpful please, if available.  We
typically use Closes: for such things.


