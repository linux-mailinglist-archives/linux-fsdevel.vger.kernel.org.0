Return-Path: <linux-fsdevel+bounces-24957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82B59470A4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 23:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2BF281152
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FAF139D00;
	Sun,  4 Aug 2024 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UJ0k+Dtj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C0A2A;
	Sun,  4 Aug 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722806441; cv=none; b=VbTxNKvXKovPShBxO+IHJb5SZKRVVg0ZGFAIuwY/nXVzJUzgwggedBlKmsVzMMCCqPD3CRNT7xkhU9aoDwOyyCyyzbZ46XZs6P3R14DpyyGxJX/67KgDYvVt/i+5+pdWLwCXWKGIe36zAQoFTAznSrcvVt7AIU424Xz3FQQLApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722806441; c=relaxed/simple;
	bh=aPTaDxNybIUHkTdFDlbequzDizZglvsYGmVQr6fmGiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THXPmH7/ezRAOx+bKqy2Az0ncKFIOVQ+mFsghU17JTWIYERMvfZhR8f/ugqtikJ3oGqQR5gTh8ZxwbAZqMMvRnzFKhkoLKeRKklsTQ40VRyihLtg8OE008SKIHzSgxICVP5ipGysYjKk8dYgRCTjiPTSozvxm4LXV8ljImLGaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UJ0k+Dtj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SilnIHq1rXzSKSjdFmsxn3mGUgHCRMMxsB1dAgKhThw=; b=UJ0k+DtjrUVNK4PCBt/QxwwQ+j
	juiLDjpuaHRvJe00B54yXANoFeMryp9SDSlsJ56rHTTfsueCCaK/iAvv3RXSnAWwPK5vXp7YSJXqq
	YJ9jk7FnqMfnCDjv3C6hlNWWCEjg4mW/FZTkXVbgx8TaGpXj5j1FVVIlyJqLyw6ROyx6dJH0B+YS3
	coYdo7w4XBi8tp3kBHxpoNnPp3jCEbzn/N82PngqZq1OBmOVVochQaK4aD8fwn3810nLrCbgKfj5I
	9Fm61lci3709skrowVuRk/ptijBdSUC6zXkK06jFDCpw7fYdqUf52KuHMQBOrGciSmo/ekDgKM0fF
	wAi0Jjdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1saieY-00000001aqe-2LEL;
	Sun, 04 Aug 2024 21:20:34 +0000
Date: Sun, 4 Aug 2024 22:20:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Lizhi Xu <lizhi.xu@windriver.com>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	squashfs-devel@lists.sourceforge.net,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V7] squashfs: Add symlink size check in squash_read_inode
Message-ID: <20240804212034.GE5334@ZenIV>
References: <20240803040729.1677477-1-lizhi.xu@windriver.com>
 <20240803074349.3599957-1-lizhi.xu@windriver.com>
 <ee839d00-fd42-4b69-951d-8571140c077b@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee839d00-fd42-4b69-951d-8571140c077b@squashfs.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 04, 2024 at 10:16:05PM +0100, Phillip Lougher wrote:

> NACK. I see no reason to introduce an intermediate variable here.
> 
> Please do what Al Viro suggested.

Alternatively, just check ->i_size after assignment.  loff_t is
always a 64bit signed; le32_to_cpu() returns 32bit unsigned.
Conversion from u32 to s64 is always going to yield a non-negative
result; comparison with PAGE_SIZE is all you need there.

