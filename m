Return-Path: <linux-fsdevel+bounces-20779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B9E8D7ABC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 06:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D1F281D5E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 04:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7E18E3F;
	Mon,  3 Jun 2024 04:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ILhwXv59"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11A22EF3;
	Mon,  3 Jun 2024 04:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717388542; cv=none; b=QRSepV0zOhBmIwt9YZtOm6ZCobUQn9pp8vDIb52HfkO5kGB3UhCRgxaax4evh6WNo8iSL4YTMpinkRhzwzQX5zp8hfCDFaRPTWsn359VSyzRXTYI5/8siq0r530y/3sZyYxBtCNmWv0Q4HynIxXMDzFlNG5srIjWzWU0ujEOqRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717388542; c=relaxed/simple;
	bh=wgWSawi6GZWqzc+lXIj+9IuBPtVgwv89a7ixklgwWeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVLLghgyP4JKyM5qnj9L6EGs0VLXCQkZcXYBNZjxvKYIR9YCRmca4bpQfS8HZmc0IoXTHkQ6VuQMksbnuPzokz7ybxyF5cFq2jL9xwQtIdXzif55aXbLaXXEqXC7sM0eUsrIZHuj1Cb+ZCvGLeEllkOp6dESaHoYIVIBljZEWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ILhwXv59; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8ZxYJOB8I/g2EW9YC3FY5qj4JtQHrj3cefvdsvrPlP8=; b=ILhwXv59gBAfZPDwPC5Xt7aZAg
	HNsoInMBcQaBdPhKXKiwegFbM1BA/xZkrDk/63obvMdvBcbx6rzlmcE3/uKLy6Tf9rYBqMhlZdCn8
	6R/tyk4/Iy+AxDjsw/PBFemP6fxAOF9tY/lGPvif46iEmO8xG+yGrHy7+FwYVZYn6ChfzNDKBso4u
	OziTYzXP5JqTOiql44sG5ZaQtpgqA3TNLVNluc/adKTLOk1vWPgyFATc5ztwP0QsifFpCjk5XVqsD
	R/l8pxCXmDFdiv+JP7WRQ+wtwp096xwyNVSObsz6aXSrSjj8K95dxo9MFr7sxfUGuK82NEbaUpHrD
	1vawaISA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sDzD8-00BNuF-05;
	Mon, 03 Jun 2024 04:22:18 +0000
Date: Mon, 3 Jun 2024 05:22:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] INFO: task hung in vfs_rmdir (2)
Message-ID: <20240603042217.GA2713366@ZenIV>
References: <00000000000054d8540619f43b86@google.com>
 <20240603035649.GK1629371@ZenIV>
 <20240603042116.GL1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603042116.GL1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 03, 2024 at 05:21:16AM +0100, Al Viro wrote:
> On Mon, Jun 03, 2024 at 04:56:49AM +0100, Al Viro wrote:
> > On Sun, Jun 02, 2024 at 08:50:18PM -0700, syzbot wrote:
> > 
> > > If you want syzbot to run the reproducer, reply with:
> > 
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 v5.0

[IOW, let's see how far back does that go]

