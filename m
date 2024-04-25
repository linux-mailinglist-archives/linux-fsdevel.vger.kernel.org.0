Return-Path: <linux-fsdevel+bounces-17829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB92F8B2973
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E12283251
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 20:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB900153801;
	Thu, 25 Apr 2024 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wuJqZWgH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E7152DE6;
	Thu, 25 Apr 2024 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075740; cv=none; b=A6Rp83oyHCMfE58S/8QPU6mbsSUTOPCieGjO3KplRknNP70NdWc4ha+FLwjyW1VNkhZk0Ma6Nq0JaPsv5wlbGZAzEnrkwXvUvC0qBhB/rgPIn+2TYlZtu+xiy1xZ05ZuT5oalLdEQTBIsbHuDDcUuYRMQSgKg4hPLiNr/YK2H3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075740; c=relaxed/simple;
	bh=n6yFCQAdvVFdFYqun0IqtnK8pMeNCDHRcHA69mU1tKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj2O6T8L3OO7UrDI0lB0Eyrd5LWO0HMDd5+3BqzmmwMpcyfzOuaCfOjbBHlbdhb9WgTOXImHGPKMSzdGbjT/FtFqVrMFrJVFV//fR6I/2zVG2Hx2NZFvdeRHB0gj70FQi7142RY1mzpGds7pEuqD+OYmjqTQpIceiQEcNKcOG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wuJqZWgH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=otjH85DWX6lZjb3XbEOKm2WlXnx7MR1VoidMLn6y4Io=; b=wuJqZWgH95H0LyZDA+Yy/2GphG
	ZfXoq3rt/KG+1+K2HprrzJzq2ptTVBheKXRA/Qgy4AqIqodGwGKYF/1oo/QecHs6VoRO35cXkJQw6
	GMVVmEFizpwCxGxcQeDUHKSEXa4mPU47YOJffYbb+3WB3I1u/WvhMEDJKz2dj1tACe0sEvK9Puz9F
	V+CdQvXAoIoPbm+EvNe198PeNH/AZK8XeU2N07SCfH4Od5wV6cGvMURUMp5n25feBScCXboCdzlOl
	x441rMTI8eYsijVjp5rua0ihRnV7ni/Mxagpz2kQtoSSYcb/Cm3uwBKNzJzIa494p7JAU419Fp9Ov
	N7eaRnNg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s05Og-004Ko5-0a;
	Thu, 25 Apr 2024 20:08:46 +0000
Date: Thu, 25 Apr 2024 21:08:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH vfs.all 08/26] erofs: prevent direct access of bd_inode
Message-ID: <20240425200846.GK2118490@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
 <20240425195641.GJ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425195641.GJ2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 25, 2024 at 08:56:41PM +0100, Al Viro wrote:

> FWIW, see #misc.erofs and #more.erofs in my tree; the former is the
> minimal conversion of erofs_read_buf() and switch from buf->inode
> to buf->mapping, the latter follows that up with massage for
> erofs_read_metabuf().

First two and last four patches resp.  BTW, what are the intended rules
for inline symlinks?  "Should fit within the same block as the last
byte of on-disk erofs_inode_{compact,extended}"?  Feels like
erofs_read_inode() might be better off if it did copying the symlink
body instead of leaving it to erofs_fill_symlink(), complete with
the sanity checks...  I'd left that logics alone, though - I'm nowhere
near familiar enough with erofs layout.

