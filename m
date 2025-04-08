Return-Path: <linux-fsdevel+bounces-45925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DECA7F4F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 08:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E953D3AD89D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 06:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7135625F7B6;
	Tue,  8 Apr 2025 06:26:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CB25F7B8
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093595; cv=none; b=jeUsD5TmGcQs6hBenfyyaht/FVMpWY03DKxPUZY/67saUhAKEl43vwRluTMOxAq3/JUjdWHVphvcsvBCYvKGDXoKRf8THDKgrwH8KfilXErj+prsIgYu7ObLgmsTj/fVlXtXEfv+ny75coFDVvL8x2jkiJtnDu3P56StiWw8rS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093595; c=relaxed/simple;
	bh=mdsUO+wiD1tSOqMNmT6J3QbuNrAFEr/lmpeAo0DkLMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWyWhfMcUzO1QfC+grB+7HDsrVYhid6zJgxFjutceg/HZovc8UGvf70icGviuS6F7PlGgHW4Hr0HcseQrTC9zjK4mWtH4n77PG9iOp1dCQSfdADSV336+paqFJLBs3CRXomEsSxDRs0h9KGOEZjZhv6LVwpa0Tc2ZIerUec6vn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBFC567373; Tue,  8 Apr 2025 08:26:28 +0200 (CEST)
Date: Tue, 8 Apr 2025 08:26:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] weird use of dget_parent() in xfs_filestream_get_parent()
Message-ID: <20250408062628.GA1361@lst.de>
References: <20250324215215.GJ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324215215.GJ2023217@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 24, 2025 at 09:52:15PM +0000, Al Viro wrote:
> 1) dget_parent(dentry) never returns NULL; if you have IS_ROOT(dentry) you
> get an equivalent of dget(dentry).  What do you want returned in that
> case?

xfs_filestream_get_parent is only called for regular files.  IS_ROOT can
probably only happen for partially connected trees on nfs exports, in which
case we'd want NULL;

> 
> 2) why bother with dget_parent() in the first place?  What's wrong with
> 	spin_lock(&dentry->d_lock); // stabilizes ->d_parent
>         dir = igrab(dentry->d_parent->d_inode);
> 	spin_unlock(&dentry->d_lock);
> 
> or, if you intended NULL for root, 
> 	spin_lock(&dentry->d_lock); // stabilizes ->d_parent
> 	if (!IS_ROOT(dentry))
> 		dir = igrab(dentry->d_parent->d_inode);
> 	spin_unlock(&dentry->d_lock);
> 
> 
> Is there anything subtle I'm missing here?

Nothing really, except that this probably feelt like poking a bit too
much into internals.

