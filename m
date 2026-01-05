Return-Path: <linux-fsdevel+bounces-72398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65396CF4A15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 17:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F48E30FDB58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D045C31AA8E;
	Mon,  5 Jan 2026 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Xvq1TEAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCC314B8F;
	Mon,  5 Jan 2026 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629079; cv=none; b=FZr4k5lgMA2fNUsYMfZwxicHF4fIEe4ZMk0rY2Lg8b0p82fcO9siXYk3iy/67aUQSpsA/NYsw3dYkoDgMebQLcyHkaUVeLqUkBjbcTLRsRR5rbIwlbfHkyziDodWptNMM8EpCPcTXxmhzZPN9rrrpUJKij8wL9XYlTNsoZfINic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629079; c=relaxed/simple;
	bh=avDmqj0Lco3JGQLs3tHuVM0PfckzqYG9TePBrfi8KEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVf5hvSYm55MbH4uo2rBa0ypZgt3r9HGUegzHadgVwNSN5g+bcFT28zMb318ybgWzaJcJd8OmkA+aaNIlW+XM9z49Vd8tuiJiz/QxZ8NO5cBRcooj7BNbCoTKNdTaZtLT7ZaGmkwcj8M7sM7GNZEZwgPNUAwsuVgCXHx1p6Avmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Xvq1TEAI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PrABJijtZ3y0sa/vkUhEP8ljMvWwXW6J34TbGNqxZE8=; b=Xvq1TEAIRvKpXA12ZyFuTxX7QD
	fV6Hc0kk9NdaxxtG+DRD/5EuS9IaSIysdnm/lm5/S+APOxSOaNM8IyboioR2cnUMqRH1kJmGsFRkZ
	eRoQTUcMGVpFzzoTn9caxsPdSQavuT3mvSKvBT6EslCSyGRFcLa8oecqDyl498s117gy9z+MctSVZ
	E/SNyhpVIAOx8c024W7vuilf3feMFRRu9VjzVJp0bC9tesjsUnNHPWrTLJU4Bs0FUd5/PK/P5OCkD
	Vle/kK1seCmazAwMX4AqThpCfNMeAM8I2mG92psr9BtOX3PAJzw+xNXLGbjH0srznAPCQ/W1dzWsV
	5y2bZ3Wg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vcn5V-0000000DQlq-3wPc;
	Mon, 05 Jan 2026 16:05:46 +0000
Date: Mon, 5 Jan 2026 16:05:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Breno Leitao <leitao@debian.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	jlayton@kernel.org, rostedt@goodmis.org, kernel-team@meta.com
Subject: Re: [PATCH] fs/namei: Remove redundant DCACHE_MANAGED_DENTRY check
 in __follow_mount_rcu
Message-ID: <20260105160545.GK1712166@ZenIV>
References: <20260105-dcache-v1-1-f0d904b4a7c2@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-dcache-v1-1-f0d904b4a7c2@debian.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 05, 2026 at 07:10:27AM -0800, Breno Leitao wrote:
> The check for DCACHE_MANAGED_DENTRY at the start of __follow_mount_rcu()
> is redundant because the only caller (handle_mounts) already verifies
> d_managed(dentry) before calling this function, so, dentry in
> __follow_mount_rcu() has always DCACHE_MANAGED_DENTRY set.

... since 9d2a6211a7b9 "fs: tidy up step_into() & friends before inlining",
when the check got duplicated into the caller.

> This early-out optimization never fires in practice - but it is marking
> as likely().
> 
> This was detected with branch profiling, which shows 100% misprediction
> in this likely.
> 
> Remove the whole if clause instead of removing the likely, given we
> know for sure that dentry is not DCACHE_MANAGED_DENTRY.

AFAICS, that's OK, for the same reason why we didn't need barriers in
the original...

Acked-by: Al Viro <viro@zeniv.linux.org.uk>

