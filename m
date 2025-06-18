Return-Path: <linux-fsdevel+bounces-52004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C89ADE2C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 06:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA1B3B8289
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 04:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B6F1E572F;
	Wed, 18 Jun 2025 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aJtT/tv7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576C2F5335;
	Wed, 18 Jun 2025 04:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750222224; cv=none; b=adfQtik/w0OQG0+yjSLZF2/7VDWYGC3dsgPdiwhTtWBUW9IhDJoqbOX1Erv3i79H3K9HxxIB6qOfB+OV5xz6vA2luxPDPfX0Bjjlhjw7uLtWYtkZyt19es88TiQl0pLZxiHRmynEa//1ZENsC4nUieO8dLm21XA6tcvsk+GR4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750222224; c=relaxed/simple;
	bh=AmTtiMD6yE0jPOyHVPqZAQTx2+YEgvOS4EFS37eI394=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnRThTRA5vcNfHdHrlDmm/t5MTiDrQh89gPQWQ7uU2x2d0NdlTBMFiRDwix8+y6gb97unN8GYHlxjFNs8DA+3wtXavq7mMRs4hwWWBzAXAIRMeZULHrUAAfJHmC8cjr2CHQ3Iu6YnzgZFasr12pU/xpWUjr/JpLYs8ZoaVBdVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aJtT/tv7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ODPOLUlvf2qURExlUHFoxGYf/GepaVDBWLemGB5KzQg=; b=aJtT/tv7JViZp52Rwv4a57kxhj
	IZhAE0UDRokQSHEsrfFxw80TXhXU41gT5fbCw8fzsyJhE/k+BvJ7JKS0gwVhj/wimJtgLOTgzyH8Y
	xkPp/UXn+gGnpG9/R/dLka+cptbC/PDB7mBKyE7oWZFV1a84SfeO1mVNG8CmWewW3LITjxbr9URWC
	1kRR+uFxL76xsnLa4vZ+OksgUN+e2yIJo+hIcFXOjPKIYK7H3HmPBzxYoePxd1KGjjyTztGpNh2xP
	N/dBpN/4OF1ThQ/3jldFPSxnqPlPvmkBUBroCngQqmZ9g2ujc/JTw/HGEGHq9IQW4yPs3KZB47Slu
	j9xe7o1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRkka-00000005YCh-39gs;
	Wed, 18 Jun 2025 04:50:16 +0000
Date: Wed, 18 Jun 2025 05:50:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com,
	almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs: Prevent non-symlinks from entering pick link
Message-ID: <20250618045016.GO1880847@ZenIV>
References: <685120d8.a70a0220.395abc.0204.GAE@google.com>
 <tencent_7FB38DB725848DA99213DDB35DBF195FCF07@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7FB38DB725848DA99213DDB35DBF195FCF07@qq.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 18, 2025 at 11:30:48AM +0800, Edward Adam Davis wrote:
> The reproducer uses a file0 on a ntfs3 file system with a corrupted i_link.
> When renaming, the file0's inode is marked as a bad inode because the file
> name cannot be deleted. However, before renaming, file0 is a directory.
> After the renaming fails, it is marked as a bad inode, which makes it a
> regular file. In any case, when opening it after creating a hard link,
> pick_link() should not be entered because it is not a symbolic link from
> beginning to end.
> 
> Add a check on the symbolic link before entering pick_link() to avoid
> triggering unknown exceptions when performing the i_link acquisition
> operation on other types of files.
> 
> Reported-by: syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1aa90f0eb1fc3e77d969
> Tested-by: syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

NAK.  This is not the first time that garbage is suggested and no,
we are not going to paper over that shite in fs/namei.c.

Not going to happen.

You ARE NOT ALLOWED to call make_bad_inode() on a live inode, period.
Never, ever to be done.

There's a lot of assertions it violates and there's no chance in
hell to plaster each with that kind of checks.

Fix NTFS.  End of story.

