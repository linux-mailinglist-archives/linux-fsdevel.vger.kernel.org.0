Return-Path: <linux-fsdevel+bounces-34900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E799F9CDF93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EC41F230A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83EB1BD50C;
	Fri, 15 Nov 2024 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CWyYMyPC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F7D1B6CF9;
	Fri, 15 Nov 2024 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675984; cv=none; b=D+Kkwa0poWv4HA2sWl/aOTCTE2Mk+bL7tbqEZUzzHo8Tb+mvQT3M4bkKZB/qUffYO/dXIzXp3iQHIv00L4srHXwwL9NZlNz5UY+DZ/CxPdbtsrha/qUB2cD9hNUHRL3M4K6dCLSs/3r6okIebWqDyabkVS2iwyW4Zk06xRDsdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675984; c=relaxed/simple;
	bh=0eF0vOaGssguAoiMP21XSAJfT0Z42HQ/ac9qHzQxDVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY2qMzO5Z/0L+oISaaqYe+lltn29IK3HUU5UNHhTaSLHcUEHxFiE7ECFlGyS8zQAyzDtrHS28fS3OWinO6AT7MEKOyT1ecoql2qvJxif/pO1LjHX/hQN9tZkVrgUkMBdiJVXo3Z6Fp0Xs5AQp3VnKHm95wrSYB1bnI0nX76Engg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CWyYMyPC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vv0FLUCJEZyjB6cbqruzLtbW2MikMqFy044j2M/d6aU=; b=CWyYMyPCEcS1TpR6j4uVmAfJYy
	QGlk1K9V+JCR1c2LCqvwqBq1ybvkxd/fPnXNVFDTJpSj1ZNYZvY0WlMs7I7aaGi7Gj+GjwUgvNOnm
	r3VeSFom1sT9qJKCP3zDdsbyhcKCy8PiLMypcIqX/9A+BHM7/MGNpKzTPeLusH0Re8WyECUjIUF7g
	fmPufO1107YjyXiZtkE5UEwtX2gxyQW7VyJYWQnPtDhqIcZKihgs3iKxPdRtQ4wPzrPvXTnnXSccq
	QIVsK8bvP+w5k2OtEHORSbX5hXAyFKqoe4PbIKDfYvIoGrLBL6hcfcYp4xR4Dq9QnNF1xJqwrKCZv
	GQf+cTFA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBw1f-0000000FRQP-2Nbs;
	Fri, 15 Nov 2024 13:06:15 +0000
Date: Fri, 15 Nov 2024 13:06:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com,
	almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs: add check for symlink corrupted
Message-ID: <20241115130615.GR3387508@ZenIV>
References: <67363c96.050a0220.1324f8.009e.GAE@google.com>
 <20241115094908.3783952-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115094908.3783952-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 15, 2024 at 05:49:08PM +0800, Lizhi Xu wrote:
> syzbot reported a null-ptr-deref in pick_link. [1]
> When symlink's inode is corrupted, the value of the i_link is 2 in this case,
> it will trigger null pointer deref when accessing *res in pick_link(). 
> 
> To avoid this issue, add a check for inode mode, return -EINVAL when it's
> not symlink.

NAK.  Don't paper over filesystem bugs at pathwalk time - it's the wrong
place for that.  Fix it at in-core inode creation time.

