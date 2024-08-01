Return-Path: <linux-fsdevel+bounces-24726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1447094417B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 04:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F72B214ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 02:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF9513D246;
	Thu,  1 Aug 2024 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="it+OZJL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89613C8EC;
	Thu,  1 Aug 2024 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481129; cv=none; b=BFO+i52XmE7pw6cr85c8uypqhGeR0LiubWAH71YWggauF7urye3u0v0/LeCwItSHe6zcEnSP6457rQSEYdLBY9k5EnMPZyp/tWEMeV0iO4O9CTrLYvcLHVkNPpravraW+rAcc6JtfSqVk/i8EcLnshRrNTEio6y43cCiMXHEHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481129; c=relaxed/simple;
	bh=R/PbSfX22IlQq+rDZwAOGy1NlIgtMeekqzgTX2PrhDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/pWqVnr6vANMOFBlLx6SlF3ddRlGj5njYTpAV7ht6vYFoAPyxagdB7bJ0vdfZUnAFmGkg/AiTTwyxZfSruwILjlARtSvkp+UUE45LwBZJaDB+1ABiD7UfiXj/ushr6MZMWsTjwXmtzX5uxjDTB4+M3A9KI58+jzc98IJN+J8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=it+OZJL5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CufbBeCclyoLjGci2RYVjVV3/1sm4zO+QwPlTVVje8s=; b=it+OZJL5pOCL6lOQZdNvsq7ubr
	ylTkbH24A6AZm3lkLl1CDDDEa4DcghGdbi+poBj7QdB8LVUAr3lRNhcg+AQ/1X/DeuKoyYGGuTQUM
	iXEbBsPtH96xvVrLBh4e6bTGQVEkMAZcAkHU2All6M5IXu8TnyMqFWqfu5MHhVYybLIk8Uq9MrIKK
	S/WMFBlifqoqsN26meKv9yv8gEZul9Hh3pJiO9uBcRbzqncM9TbiL8n3mjR2YtWmM/Zc+MuIpkpbU
	6Lkwp+UrIdRAj2k7q1c3qssb9lVEtPzs8DBhl6HCk6UNzAOEgfOmHvYBhXgWkIykzmHOwJ28DUx6p
	Ym1BAbcg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sZM1a-00000000cX6-1nj5;
	Thu, 01 Aug 2024 02:58:42 +0000
Date: Thu, 1 Aug 2024 03:58:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] filemap: Init the newly allocated folio memory to 0 for
 the filemap
Message-ID: <20240801025842.GM5334@ZenIV>
References: <000000000000a90e8c061e86a76b@google.com>
 <20240801022739.1199700-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801022739.1199700-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 01, 2024 at 10:27:39AM +0800, Lizhi Xu wrote:
> syzbot report KMSAN: uninit-value in pick_link, this is because the
> corresponding folio was not found from the mapping, and the memory was
> not initialized when allocating a new folio for the filemap.
> 
> To avoid the occurrence of kmsan report uninit-value, initialize the
> newly allocated folio memory to 0.

NAK.

You are papering over the real bug here.

That page either
	* has been returned by find_get_page(), cached, uptodate and
with uninitialized contents or
	* has been returned by successful read_mapping_page() - and
left with uninitialized contents or
	* had inode->i_size in excess of initialized contents.

I'd suggest bisecting that.

