Return-Path: <linux-fsdevel+bounces-34901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113CB9CDFD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB59A283E38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 13:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36811BDAA1;
	Fri, 15 Nov 2024 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YLN6x8dF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880F1BC9EB;
	Fri, 15 Nov 2024 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677101; cv=none; b=YLEZbp0l7i3dMKn/PvhrgtHIwvvIBQmi90S7hu1SnLUZeLGo6kknZLvo2Ssafpgg9Fjq4jJlurDIfV6OT/swcJirQV5HnXlfUkpIOThq3RujD37LEnPHmofT29BBuBAPTKGRz/KwVGj/x6NL2nta8c9MtUZGC3YzKnptMXwMBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677101; c=relaxed/simple;
	bh=1sC65UPckwoGdZANOi4eNDL7lWUJjWMV59vad2f5J1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiXDeEmPTuq3ZTmJQA0PnkyHv4bkwX0ODS5Oio9cb6DHe0ClEdCtSv9qy8iXSc7u9x+77Dzdu2E6bLxWuTL1BAuW0fJFTgqDWUVtruqqmRvTs5ev9MzQYoEBYwhnPFzzdX0I5DPSJmHmXF9HnhmTsQwfqMkPoEUZDEVhT8iHeVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YLN6x8dF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hNqKvJTpie3Ajr77T+vAD+bCkr/nJuJuP6IDC3W+j+8=; b=YLN6x8dF3jFtJf5j3Q3nP4MZql
	Tqw65qjJAcxcyODHcBoIly0VawxXU9ImKoM0w8G76SQFYvGK5CoJAgk4GkFwXUSlsluMhsfvAxbbV
	9w7cjj6ESK0SWUWSqesR68NYWTYikjKrXPvVXKdeDas8648q99M6x2VUAya2OipwdwMsA4bQXB9ui
	y7MH7zZrH0NlKlOVrXdizp9YqHbmioRWBUz1eODFUsF1XKhFTWDQMrXqUM0jDu3s5V7S7mXJyjjRM
	JNHibU1rbB1zeHpMc8J/XJaWJaU0fe1qPSkchDL5uSG8Cdtvz4++/IptOUIKiZ52cBy+goEXHn/sn
	7RPd9yWA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBwJj-0000000FRfO-2G61;
	Fri, 15 Nov 2024 13:24:55 +0000
Date: Fri, 15 Nov 2024 13:24:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com,
	almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs: add check for symlink corrupted
Message-ID: <20241115132455.GS3387508@ZenIV>
References: <67363c96.050a0220.1324f8.009e.GAE@google.com>
 <20241115094908.3783952-1-lizhi.xu@windriver.com>
 <20241115130615.GR3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115130615.GR3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 15, 2024 at 01:06:15PM +0000, Al Viro wrote:
> On Fri, Nov 15, 2024 at 05:49:08PM +0800, Lizhi Xu wrote:
> > syzbot reported a null-ptr-deref in pick_link. [1]
> > When symlink's inode is corrupted, the value of the i_link is 2 in this case,
> > it will trigger null pointer deref when accessing *res in pick_link(). 
> > 
> > To avoid this issue, add a check for inode mode, return -EINVAL when it's
> > not symlink.
> 
> NAK.  Don't paper over filesystem bugs at pathwalk time - it's the wrong
> place for that.  Fix it at in-core inode creation time.

BTW, seeing that ntfs doesn't even touch ->i_link, you are dealing
with aftermath of memory corruption, so it's definitely papering over
the actual bug here.

