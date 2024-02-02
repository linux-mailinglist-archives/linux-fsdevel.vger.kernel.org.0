Return-Path: <linux-fsdevel+bounces-10044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F4F847492
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D681C25005
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9511474CC;
	Fri,  2 Feb 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HSSxym0H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4012FB39;
	Fri,  2 Feb 2024 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890856; cv=none; b=XqcZ1hYFdSXzTIphTN1tpg55VG+vrzjYrBD8fdqE5j0CFVmULB3GjrgVnfq75BFhn6hj2ejCy3I3vBYM7sIKB5JOCTnEUEa17vfJAFxijoR9frHTr2TkuPbjiiHVL7PTTgxulwu40/X5MOT6GFjPqU2HwmdvcQXwWyE2QGNnkl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890856; c=relaxed/simple;
	bh=bD0ZkyUPj4iXgoL5OqwiOH9PZ+s/La4JiuOzI4zjCxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVOKtxRSwz6tbIcqwEB+W/BEvSOmBey5ejGvl6POwGHI6HfWzlj/3C4tRU5nDT67IEBUaE1hmpJYRiDS7kVde8G9TQcEYb7g8wUX6fkMyRJJ1XiGwlwclH74SM+Ml9+codRpk6mfkmpilb9VvFpoNxytoXSdEAEA0/UL4N1VMPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HSSxym0H; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KxD8XMUWv3jmH/Fq+OV07yoiBGbX4tsjozHqY2oaW+E=; b=HSSxym0HFmE0Fg+8B1IvLzYkYo
	1xehZhCG+uo51qjW88cX4HimzGzUigrm7mIf5oTO3X+jy4lxQ5WkmMd8lYlpPwwvXNSkiuXKyOfDb
	KuLlsLLFHOz/WACGtGG1w6Ebv23C5Y32DV9F04GyxenoGfuh35g7Rk9nDgLi1fMs/v8LdNJ6TranQ
	CafnahP1GOu2bEYv3LBAISYM51j2M54ozKWek0sGTcmEiXLUq87AyzHO6WtCfCNMqRZwlaHTrgjKK
	q9BU6KAYZRxY9rRB6NxE+VH2UHsXeO8Gy8gCshcBQ/WmOF4vjrOA8tlBD8Gd99fg2SHDcwVzQyx/A
	pfySrV4g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVwHQ-0046bO-2G;
	Fri, 02 Feb 2024 16:20:40 +0000
Date: Fri, 2 Feb 2024 16:20:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	LouisQi@zhaoxin.com, JonasZhou@zhaoxin.com
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false
 sharing with i_mmap.
Message-ID: <20240202162040.GA2087318@ZenIV>
References: <20240202083304.10995-1-JonasZhou-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202083304.10995-1-JonasZhou-oc@zhaoxin.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 04:33:04PM +0800, JonasZhou-oc wrote:
> From: JonasZhou <JonasZhou@zhaoxin.com>
> 
> In the struct address_space, there is a 32-byte gap between i_mmap
> and i_mmap_rwsem. Due to the alignment of struct address_space
> variables to 8 bytes, in certain situations, i_mmap and i_mmap_rwsem
> may end up in the same CACHE line.
> 
> While running Unixbench/execl, we observe high false sharing issues
> when accessing i_mmap against i_mmap_rwsem. We move i_mmap_rwsem
> after i_private_list, ensuring a 64-byte gap between i_mmap and
> i_mmap_rwsem.
> 
> For Intel Silver machines (2 sockets) using kernel v6.8 rc-2, the score
> of Unixbench/execl improves by ~3.94%, and the score of Unixbench/shell
> improves by ~3.26%.

Looks sane.

