Return-Path: <linux-fsdevel+bounces-35003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E841E9CFBF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 02:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A371E1F22B0F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 01:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503E518FDD5;
	Sat, 16 Nov 2024 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G7i8ZLUa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F0802;
	Sat, 16 Nov 2024 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731720348; cv=none; b=kTOKoXvV9cJlhpqyHoz6qQPzO/LLiLQtDxJlkrq6orlj6mFihyqslQkfE8waQgTXxRgVpSROoWWtPexaIr4+MXxcDGsXs52iAjLbdTgWRPOmTlIXtxSWLw6nSNhLU9jaDA3uPB5pie53TvwvgZhX7Ka766mjqRVXNiXFqaebR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731720348; c=relaxed/simple;
	bh=g3sWJ+3WVpyFfzxFVEJhzmU65W+vVdP8n1eFoDQ2wUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c74nA3YZW1tkhxSvtgbPqY/B4VBivlB5yzh4NmoOrCngTqxhGx7Gt4qW/YqcdJFpgvpWC2tv5cJLMirqZLIIZ3VK09b3lL5xMAIANIXOcIZ7L39GpPEdEWUAM2GWnyef9ZqNlA1na0cafAlO/v5NmoBzVlWUbwR+vSGzKkvz018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=G7i8ZLUa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CCHKOc/BBFwZgjIYWbYw1MsKHpFSPyIimE4Hbxx8VXU=; b=G7i8ZLUad3q4dZH93OglA7WyL+
	WkjB7+B9UhrRE86hH9lfxiTz2KnxoaiIxmc0n9Lrwf0u7IE7kVlAEfjfEBE4hQXWO0s/x5orzYidI
	H63zHvfpedsUXeYYiLswo9adhujV52Yf8k/GuF5LFV7A+nd+JYMg8jBcESy0/vPX0cYxAA6bjuSSF
	25z1xCo4BOQJnKY4PjzmEjzz67VxYlgJRcQDeyKoerH3xmg5EFO5Aqi5a0KdXr092oGFW5Wh90CAT
	L3Yn8C2mVh2EzKCmUw4L2Rp1MYlF6R5HXzJNZXg0Fwxay3xw8+qE7a1a4jiK+FE67qgiGL1CLeOwx
	RLlWJHYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tC7ZE-0000000FdVe-1iyB;
	Sat, 16 Nov 2024 01:25:40 +0000
Date: Sat, 16 Nov 2024 01:25:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: jack@suse.cz, almaz.alexandrovich@paragon-software.com,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs: add check for symlink corrupted
Message-ID: <20241116012540.GY3387508@ZenIV>
References: <20241115114306.5sgqa3opc56rhu4x@quack3>
 <20241116010207.1484956-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116010207.1484956-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 16, 2024 at 09:02:07AM +0800, Lizhi Xu wrote:

> Our idea is the same. Because d_is_symlink() has confirmed the mode of
> symlink in step_into(), I will confirm whether the mode of symlink's inode
> has changed when the value of i_link is 2 in pick_link().
> > 	do something and return
> > 
> > so we are checking whether the inode is a symlink before calling
> > pick_link(). And yes, the d_is_symlink() is using cached type in
> > dentry->d_flags so they could mismatch. But inode is not supposed to change
> > its type during its lifetime so if there is a mismatch that is the problem
> > that needs to be fixed.
> I think syzbot executed the following two syscalls when triggering this problem:
> 
> link(&(0x7f0000000200)='./file0\x00', &(0x7f0000000240)='./bus\x00')
> mount$overlay(0x0, &(0x7f00000000c0)='./bus\x00', 0x0, 0x0, 0x0)
> 
> Obviously, this is to mount a link. Whether the mount operation itself will
> change or corrupt the i_link value and mode value of the symlink is not
> clear to me yet.

Odds are, it's not a valid struct inode instance in the first place.
It's not inode->i_link that is a problem (*nothing* should ever store
that value in there and ntfs doesn't even try that - grep and you'll see);
it's inode itself.

Have you tried KASAN-enabled build?  Might be interesting to see if
it catches anything...

