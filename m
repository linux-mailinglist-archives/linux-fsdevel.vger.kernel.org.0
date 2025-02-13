Return-Path: <linux-fsdevel+bounces-41645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3444CA34028
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AD73A934C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 13:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C660227EA7;
	Thu, 13 Feb 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="T8BRTuYK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFE23F420;
	Thu, 13 Feb 2025 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452818; cv=none; b=CPt2b5QGB89UmH9SE0/Pbyri41iUoraFOqK94JFlE5yqrmkWXBMiR/6gvQ3pEmiexS8U1VLE7mxb1ZKc10xHzJ06uFN0CyxQmzaIvn6/MUu/DEMv22JLIy8QEtd2CPOh6RutcgX3NWbPxIe4B3KUFKDdrI5msIbpedJRdFi2VOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452818; c=relaxed/simple;
	bh=bFjz/8MKj1nHjIQ7WsIdLhSA+XQX+erWp7JBMI2ycZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSdL1WlRf6Ic9N7wKAPU+y0pcHIXDA3qERRSAqbJHVm43oX9sr+JEGS2HlM8y9t0geCiQJtDPXXvIaRNQmmUWP1PruV2/G97ltqI2Z1Je0PezLl/r4pXD0l2omh8Ve9yWJS3WPA+GWi4MrG63vXND9/W4gvE04oIZoplqcc3JPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=T8BRTuYK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O9/j/ctUg2mHVWHwpXKsXKlmyr6GshoziQPuOAsorqo=; b=T8BRTuYKDUOyNIb7Y61SzZJr9y
	+W6P2RVi4rPJj6Jb9eaTqDm/FQmL44WBwRa6LZlFN3O/RKGwkQWsdtI8oyRVdToEf6uafVm5oT/Zp
	bAP9okkmPyxB358L/vrDpsWpwlQ1QVaeREGsRNAwghQRmIvWmp045TpPbCl2mi+iXzXib/tOcorQ/
	/54r9ZYktFFQo9x1YSuO70JxY4CpuaVX6y1YLiqGfPlv3LUPs4ROiqocTBOd3SxwmiA41l6/0GCQe
	baqurdP4ybwvi7T4GF7PJX7LeGo+tbk/ofQyrCZhusSjobjUUwram6AfyXuPEIiz0RuXNm9IdZcIb
	bv9+0S1A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiZ8Q-0000000Cl36-1T6M;
	Thu, 13 Feb 2025 13:20:06 +0000
Date: Thu, 13 Feb 2025 13:20:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, alexjlzheng@tencent.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: remove useless d_unhashed() retry in
 d_alloc_parallel()
Message-ID: <20250213132006.GV1977892@ZenIV>
References: <20250213122137.11830-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213122137.11830-1-alexjlzheng@tencent.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 13, 2025 at 08:21:37PM +0800, Jinliang Zheng wrote:
> After commit 45f78b0a2743 ("fs/dcache: Move the wakeup from
> __d_lookup_done() to the caller."), we will only wake up
> d_wait_lookup() after adding dentry to dentry_hashtable.

Not true.  d_lookup_done() might be called without having
*ever* hashed the sucker.

Just think for a moment - what, for example, should happen
if ->lookup() fails?  Would you have d_alloc_parallel()
coming during that ->lookup() (while dentry is in in-lookup
hash) hang forever?

NAK.

