Return-Path: <linux-fsdevel+bounces-72569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9E1CFBC43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 03:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16A0B30213D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 02:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C61519AC;
	Wed,  7 Jan 2026 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Bt1H9kXT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B170800
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767753978; cv=none; b=H+wTOPlcu9LUTMRwaBawseyDiSsAGPB/hQkrl+wkc2vdcM5XpCCDwcsyc5HKWzfDOVCiqR95QLha1v15V82e9GoO88K7G284ISQ4LKcP0MSS/D67hUG/HNvjingiDbTMfjSaNe8uORjPm3Lcw+FfkiIr8khJT+kScuyQmVjC3M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767753978; c=relaxed/simple;
	bh=SPPZzXp5AMcYw7vaROtFblCN4sqSlXiEZn8gNJxeVc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcpJc7LkPLzU8UHUgxr098ebgArwZtOhxZ8Ff1uImOANiv1V8EXTQoVC85k/yiNEOzbv5hET2Ojv9lfXEG2ODo6lwA00AyT/m+mJZhhfCaBCP0h+9L92ZgHYyRrpJrHS1FnqKqA3W0RQ6eVgZHhiuNEEsIvWohqB36MTGaEr7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Bt1H9kXT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0YvtHZA+FUTHSzBY85OojpBFOC6uOXVgu0PH2ziaiDQ=; b=Bt1H9kXTP4FG6zuTYAOQWDMzmv
	eZoGqeZWvVGtyeNvz2EpYvswfFnrb7/YWWovSpOfWltnDL7ZxzRl1p4nbfidPl5KRzfgul9yGKT5T
	+0g0/czdi6dGhjZHGmfFTAe2y1akEHof/2CaCLi984e22h7ySwd/HpWmxLlEUVKSlgn4xz2kDdT40
	UM9rUrQoLWt97Nsp7kwSul1HEKqmpZ7lqg22uhw3TKBJwFD71Ab+nr4fDqOq4YZqUIIApJIy5hwz8
	VB4F5JPGmtfihyvyp1I4sD86ojEKR1xL/KKJ1THHjN4ov/ec9AUKZ4WCm5E2rfGd32jJd0Bd2n9X1
	+McXm+xA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vdJa3-00000002fHF-2YT9;
	Wed, 07 Jan 2026 02:47:27 +0000
Date: Wed, 7 Jan 2026 02:47:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/3] fs: add immutable rootfs
Message-ID: <20260107024727.GM1712166@ZenIV>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
 <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
 <f6bef901-b9a6-4882-83d1-9c5c34402351@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6bef901-b9a6-4882-83d1-9c5c34402351@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 07, 2026 at 10:28:23AM +0800, Gao Xiang wrote:

> Just one random suggestion.  Regardless of Al's comments,
> if we really would like to expose a new visible type to
> userspace,   how about giving it a meaningful name like
> emptyfs or nullfs (I know it could have other meanings
> in other OSes) from its tree hierarchy to avoid the
> ambiguous "rootfs" naming, especially if it may be
> considered for mounting by users in future potential use
> cases?

*boggle*

_what_ potential use cases?  "This here directory is empty and
it'll stay empty and anyone trying to create stuff in it will
get an error; oh, and we want it to be a mount boundary, for
some reason"?

IDGI...

