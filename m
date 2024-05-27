Return-Path: <linux-fsdevel+bounces-20195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB638CF6F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 02:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B7B28174E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 00:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B21854;
	Mon, 27 May 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aYTWYQ64"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29C383;
	Mon, 27 May 2024 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716769129; cv=none; b=nVCD7/QuRsMODCZfqWkHcTIhnPrbfH4Ln+43EP9/b/DXZ/mbUn/3o+PDf9ulZhSX9qpJUPhGQrzzuy6SZRE1T54nnHQB9eH7Oh55GcE+X8pxnuqtp8Yb+6E1HduTOTfgCY7v7Z+fN9zwo59rKI26ZSlQvJOZ6yV/1qTLtOgLS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716769129; c=relaxed/simple;
	bh=vA/esm3vx9DjB/+4bmyzUK/8dGHT5plSst0DEDceYWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbtysuNYEboN7iD5D2vZdYAt0sH6ZbWmfgB08AAQEgFKoXZIAAYnPkS7ld4s13zs8EeiZsp/nZTlRCYkfJakGgPICEbBx1icjNBc71WtgZs0v3LjVF8caNMQu34w7jUg0ap4oXbOC8B7MZXxNvZzRf/VnMBfI1NDHQn5BtZFbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aYTWYQ64; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SSpieautrUSqs9mONDCwrtReKJojHL5RZY3gAQZjN2c=; b=aYTWYQ64nvIhMggYGMsmH/TLUC
	beOFEKGl3ToQrRnsqOtSFq9QD4nXDe1pt3QCQa6LcFWRTbbDGS1xxcIntHoZnUCPbNI7nKOM+3MXh
	d7NUUFQghblEbNgMdPoDhKp3NIynu15lHuZBkY15Jkw3L7lGrY9HV8nrmurKBKe9d8XqL6lR/nbBD
	0x4aUHHQ4cy4vbR2ADTRwOZT5AotEiecB7QrvIAf4x1L2R29Q2J/0USmVCiU/5sVVxxL2f5wb6u3K
	ue5oOZXS74+rUniQx3XFLKJ7UBKwQNWdetR/vseawVlzmArEWkkVv9xAJCO037S+DZ6rY31UwP9Zw
	JMNr/Btg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sBO4F-00BMEh-2P;
	Mon, 27 May 2024 00:18:23 +0000
Date: Mon, 27 May 2024 01:18:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Jinliang Zheng <alexjlzheng@gmail.com>, alexjlzheng@tencent.com,
	bfoster@redhat.com, david@fromorbit.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: About the conflict between XFS inode recycle and VFS rcu-walk
Message-ID: <20240527001823.GC2118490@ZenIV>
References: <20240515155441.2788093-1-alexjlzheng@tencent.com>
 <20240516045655.40122-1-alexjlzheng@tencent.com>
 <7f744bf5-5f6d-4031-8a4f-91be2cd45147@themaw.net>
 <3545f78c-5e1c-4328-8ab0-19227005f4b7@themaw.net>
 <20240520173638.GB25518@frogsfrogsfrogs>
 <9a123c02-f88d-47dd-b8ef-dea136b01dc1@themaw.net>
 <dd7cdc06-9829-4519-9873-ea9d661a8c45@themaw.net>
 <d2d010ce-51eb-4e99-b717-162e88f8d3fc@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2d010ce-51eb-4e99-b717-162e88f8d3fc@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 27, 2024 at 07:51:39AM +0800, Ian Kent wrote:

> Indeed, that's what I found when I had a quick look.
> 
> 
> Maybe a dentry (since that's part of the subject of the path walk and inode
> is readily
> 
> accessible) flag could be used since there's opportunity to set it in vfs
> callbacks that
> 
> are done as a matter of course.

You might recheck ->d_seq after fetching ->get_link there; with XFS
->get_link() unconditionlly failing in RCU mode that would prevent
this particular problem.  But it would obviously have to be done
in pick_link() itself (and I refuse to touch that area in 5.4 -
carrying those changes across the e.g. 5.6 changes in pathwalk
machinery is too much).

And it's really just the tip of the iceberg - e.g. I'd expect a massive
headache in ACL-related part of permission checks, etc.

