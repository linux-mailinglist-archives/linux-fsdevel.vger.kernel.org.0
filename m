Return-Path: <linux-fsdevel+bounces-21754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29E5909686
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 09:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7569D28275A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C539D17BA7;
	Sat, 15 Jun 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R8Yn75w8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A82114;
	Sat, 15 Jun 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718436714; cv=none; b=C39r1c1qT/bZCMs9lhE0ZvY8SX8mFe3troSpC1m4Y/lzK8+gkpeobGVYsSIXzBMamGvWSUQrOpbsx4p6nBt61LJHAyZrkuNp2EQyzi5FyaEgwz10/xeIDNJMOF7RX1xqNJT5mzv8RBy4hSKyisetiLkq9iuq2YgqGSr35PQTHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718436714; c=relaxed/simple;
	bh=XVXwc0l5UPJInr4sZlbCRa0RdxpAPhcE/yISR5ozFZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOJexyMsGnWXFMZX1VJBWG90Vs1fBoLufAbc7M7ssHjNGAy57XPMqcYpgLIVZWGpECWHO/tNjqLq+cjlz/huJNGmELPOqwSz702hIosRK8dz/tEKO/U8q2qPBBnWsEbchmeYXAcMAH5GZtHlW98uJlYSkrP9BL4CM8cKokg7GqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R8Yn75w8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XVXwc0l5UPJInr4sZlbCRa0RdxpAPhcE/yISR5ozFZA=; b=R8Yn75w8zZy+o8HTqOCKrkGKRB
	SrFn5mFQnmJa7MAP3MZxDmy/km8RQvv+wnKL2nYk7PXT4hk8C5ooZ3LI7R6k2q75yhpa+wgp12XU8
	YP+HDmDXlXz2n85GY30N45n0ncaTbOHNPBECTlT+q0FSqhVqldr6cXHt12kxPsVSH+Uvw371iofkQ
	HYkI9conE72TWwu0wfVN3TqhCQKY/QMrG1uW39C8Auc7pFwn68zhhb53CcWc+isjxJdeHhTgs6Xnz
	bk4JAeHP3nLW27R7uxFsig+HMR83Jkoy2bHs6yWeEILhNdgJHGh1jqMRROMhKVzjFwpTG6/T6SJCd
	isv6Az/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sINt8-00000004tfl-01bL;
	Sat, 15 Jun 2024 07:31:50 +0000
Date: Sat, 15 Jun 2024 00:31:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Congjie Zhou <zcjie0802@qq.com>,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: modify the annotation of vfs_mkdir() in fs/namei.c
Message-ID: <Zm1DZaaUF_tspmmQ@infradead.org>
References: <20240615030056.GO1629371@ZenIV>
 <tencent_63C013752AD7CA1A22E75CEF6166442E6D05@qq.com>
 <Zm000qL0N6XY7-4O@infradead.org>
 <20240615065528.GP1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615065528.GP1629371@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jun 15, 2024 at 07:55:28AM +0100, Al Viro wrote:
> It is an inode of _some_ dentry; it's most definitely not that
> of the argument named 'dentry'.

No need to explain it here, the point was that this belongs into a
useful commit message.


