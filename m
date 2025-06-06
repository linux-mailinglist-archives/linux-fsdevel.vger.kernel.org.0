Return-Path: <linux-fsdevel+bounces-50805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4F3ACFBC9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 06:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDDFE7A11EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 04:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8C1DD0F6;
	Fri,  6 Jun 2025 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F4JAOzhf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FC125DF
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749182483; cv=none; b=LBljAIZ2QgvWqsUrOW4/sOmZ2YrXgtTKQQbgMzrqPJwvhUZT0ilNIF1rsCqm2X/zqQjhUui6xv1Yvkd66Uuh/mwFxMyVpQkE7qASux/Z6U/4cDbFcHAeFIaHh+uONra5ZhoVTezMEaB0K8eXzn/6BOc2OnqwEh3n6tyXXHo7gxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749182483; c=relaxed/simple;
	bh=TPbmAN74TRNf33b6zLM89ao8NUOZUmeQJeMMj4qtPSM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dZHkt24KiKEIUyOE/VM/6jGfr+FNxei7bXHOpGfhnqXhXCvwHZRSlWhc2OBEA/c9r9qCpSHuGXPdWPTgZzPfSXWtSvfZTxNL5O+naiceVceJ65JxPW4sjv0Kc158QUnjcDf3JG8JLkm5zuShD8Mw4Ojyo8+g8lFNtuSNv1BJVf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F4JAOzhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC40C4CEED;
	Fri,  6 Jun 2025 04:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749182482;
	bh=TPbmAN74TRNf33b6zLM89ao8NUOZUmeQJeMMj4qtPSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F4JAOzhf7CQN7HDmBEz+upbpratnJlKRg25QwgQpUJLmy8w4BSYozvzza+B97aUpW
	 fqWXsiiCJy3b5A6gJbDUuGHoGW4lWEqZenohqgAjmHiaIdGZGFkvOGUYQRB2hQB/YB
	 dOEGJTUGCvpLgPVimkjenAKd8qnVELUQIrSuBaig=
Date: Thu, 5 Jun 2025 21:01:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: wangzijie <wangzijie1@honor.com>, adobriyan@gmail.com, ast@kernel.org,
 kirill.shutemov@linux.intel.com, linux-fsdevel@vger.kernel.org,
 rick.p.edgecombe@intel.com
Subject: Re: [PATCH] proc: clear FMODE_LSEEK flag correctly for permanent
 pde
Message-Id: <20250605210121.5c5f53cbd4deb1df032e73cc@linux-foundation.org>
In-Reply-To: <20250606035714.GP299672@ZenIV>
References: <20250606015621.GO299672@ZenIV>
	<20250606023735.1009957-1-wangzijie1@honor.com>
	<20250606035714.GP299672@ZenIV>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Jun 2025 04:57:14 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:

> 	* why is that earlier patch sitting someplace that is *NOT*
> in -next?

I recently tenitatively added it to mm.git and haven't pushed that out
yet.

> 	* why bother with those games at all?  Just nick another bit
> from pde->flags (let's call it PROC_ENTRY_proc_lseek for consistency
> sake), set it in same pde_set_flags() where other flags are dealt with
> and just turn that thing into
>         if (!pde_has_proc_lseek(pde))
> 		file->f_mode &= ~FMODE_LSEEK;
> leaving it where it is.  Less intrusive and easier to follow...

Thanks, I'll drop both patches.

