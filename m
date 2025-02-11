Return-Path: <linux-fsdevel+bounces-41543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 487B0A316F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 21:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED376168343
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 20:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66C72641E1;
	Tue, 11 Feb 2025 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BiA+qjSD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F81CA84;
	Tue, 11 Feb 2025 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307271; cv=none; b=km61gTznUmRRGbGaoZEIcabYRwW6qnLCfxN276ekHOlwwXWWsSFF4NNs/qig5rW9u9iypBvnFsqP9z0czHrhEwexc3CMSDScBnNLGcdVo3x4yzrga3kRwa8IAS4drGINT4RGVExubqjLneW4L2lASqLr3PTNZmA04129LR816II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307271; c=relaxed/simple;
	bh=YOdj3Ibcjs80c3SuLcD+Qwr+/jgda6an4ycWCDSIkxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbH1b+DVVsaBo7gvTbcX0cV9V4B8Lwrmlph16EBWvSOJgCTm94o7OYCZ6QiLqIIsoi9P8TFntuq7+qgmr+5YV5MfzqsM7c9xy3nHwkTfWZSahIJkY+HnMAxMtKfT3MMLuita2oMf62si8/Nxj+bqgf/FwCCnY+kDNSQz6kIit+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BiA+qjSD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1iJ8xpWA2sBU7gPbf/7jmmtf2ADvi1y7fZeAsq52FKE=; b=BiA+qjSDDrhzqu8WyRazJdREyv
	TTRJ9bo67PwyXjoW8WRk2wKH7q4oJLL4QDkdNLfxd0xStATm8o2jvhvsfKVsG9WveH49v420Yoan9
	zrw3szvDIXYnlD0/dxUDCV6GONU9I5dDNI5rL+mOp+LIsTC2iuaCK/NUDK/mnfvCY0ARVFdsCg1ZN
	JQd51sfc1AAZ+jd6o/+VcgfjFhSKIR4axpBoFiKh7CVnxEPaXuxiTuWq2RwB+QnPwSnvLuP1iMpaH
	qFqK144LG4OfpXjVEnbTAX+bD27vRYTUn7O/HIQYwVc4fRYajba45DBi/KnP3rzYNDFzKOVGckKdh
	on4LlfFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thxGs-0000000Axan-1W0F;
	Tue, 11 Feb 2025 20:54:18 +0000
Date: Tue, 11 Feb 2025 20:54:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Zicheng Qu <quzicheng@huawei.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, jlayton@kernel.org,
	axboe@kernel.dk, joel.granados@kernel.org, tglx@linutronix.de,
	hch@lst.de, len.brown@intel.com, pavel@ucw.cz, pengfei.xu@intel.com,
	rafael@kernel.org, tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] acct: block access to kernel internal filesystems
Message-ID: <20250211205418.GI1977892@ZenIV>
References: <20250211-work-acct-v1-0-1c16aecab8b3@kernel.org>
 <20250211-work-acct-v1-2-1c16aecab8b3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-work-acct-v1-2-1c16aecab8b3@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 11, 2025 at 06:16:00PM +0100, Christian Brauner wrote:
> There's no point in allowing anything kernel internal nor procfs or
> sysfs.

> +	/* Exclude kernel kernel internal filesystems. */
> +	if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT)) {
> +		kfree(acct);
> +		filp_close(file, NULL);
> +		return -EINVAL;
> +	}
> +
> +	/* Exclude procfs and sysfs. */
> +	if (file_inode(file)->i_sb->s_iflags & SB_I_USERNS_VISIBLE) {
> +		kfree(acct);
> +		filp_close(file, NULL);
> +		return -EINVAL;
> +	}

That looks like a really weird way to test it, especially the second
part...

