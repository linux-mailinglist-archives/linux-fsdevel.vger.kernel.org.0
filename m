Return-Path: <linux-fsdevel+bounces-52014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2E1ADE387
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 08:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB9D3B0D16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 06:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AFD202965;
	Wed, 18 Jun 2025 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gU6ejNv1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965FD1DC9B5;
	Wed, 18 Jun 2025 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750227502; cv=none; b=f3sI2eAQ9CDzOFcIPUe7L3yFKnByvJN4wfJczoMhDJMwruatNdWbZ3DDD1twlwWWuD9I1kOXCqL2eKXlcZ3kw2a9BOm/pPwLNlx7iruODulPAAdaaF82DT+wiPlibJM1qJ/9HrwzCzfPj3PsI49jLd4TJydX93IHS7vUzIwqzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750227502; c=relaxed/simple;
	bh=DsN3Y1NEObF13uTLnQxZH332yoT2Jif15MR4umC2F7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVQWDdhUa+qqcvJosqhUxZPAakfSCPJWpy36WdRrLiW5xUVNvfohdzd2u2PHMzc5EaqXmCxdaobs3IAC3QsOJa98Pf8uwjwXkqOk/xvpA8Ac4AYfRyte3MlHShZmOmogWPOwiHpU4pwMRMbftT8ZXQIC8Go5G9ac9W++PH4VJT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gU6ejNv1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vE//73FluqQHJWQMwgupyqLu7SUx6i860ffNcOAxUhQ=; b=gU6ejNv1Lm9FggFx9oweTn3x6m
	KC3CgCh0N5Ehe0Amk7bkq2EJk5pOnKtFKsVC47WdVDo7t4wIoUEMig/nvGtVEQk4/ihfq4sgKhktg
	GrmSgCX9OlYq7E2cucM2ZugXUb1ORrfcpMvpoofhzVgQnUtGG7LlY73Jos0x7xKZ7ewl5C49mN//4
	ToiJE8tY7Vrrf283uK7odF4UO5BrhCAiSrqI3LWG5MYmunJGdxJIAFlg5e0/wc+LdOE0cD5obBzSH
	LSLmt7WGpLtD4Jeqi0aWlgbKHzEXu6mn+C4WBbFkOZUBhOBe1ubGM5Tf7lzd5NIXls8P/2HfxMKh/
	0Ae/COQg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRm7j-00000006OSy-1ASP;
	Wed, 18 Jun 2025 06:18:15 +0000
Date: Wed, 18 Jun 2025 07:18:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs: Prevent non-symlinks from entering pick link
Message-ID: <20250618061815.GR1880847@ZenIV>
References: <20250618052747.GQ1880847@ZenIV>
 <tencent_9DDC9378E363A961A3BEA440376237718605@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_9DDC9378E363A961A3BEA440376237718605@qq.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 18, 2025 at 01:34:18PM +0800, Edward Adam Davis wrote:
> On Wed, 18 Jun 2025 06:27:47 +0100, Al Viro wrote:
> > Note that anything that calls __d_add(dentry, inode) with is_bad_inode(inode)
> > (or d_add(), or d_instantiate(), or d_splice_alias() under the same conditions)
> > is also FUBAR.
> > 
> > So's anything that calls make_bad_inode() on a struct inode that might be
> > in process of being passed to one of those functions by another thread.
> > 
> > This is fundamentally wrong; bad inodes are not supposed to end up attached
> > to dentries.
> As far as I know, pick_link() is used to resolve the target path of a
> symbolic link (symlink). Can you explain why pick_link() is executed on
> a directory or a regular file?

Because the inode_operations of that thing contains ->get_link().  Which means
"symlink" to dcache.  Again, there is code all over the place written in
assumption that no dentry will ever have ->d_inode pointing to any of those.

No, we are not going to paper over that in __d_add() or __d_instantiate() either;
it's fundamentally a losing game.  _Maybe_ a couple of WARN_ON() when built with
CONFIG_DEBUG_VFS or something similar, but that would only make for slightly
more specific diagnostics; not all that useful, since you can literally grep for
_ntfs_bad_inode to pick the location of actual underlying bugs.

Again, the underlying bug is that make_bad_inode() is called on a live inode.
In some cases it's "icache lookup finds a normal inode, d_splice_alias() is called
to attach it to dentry, while another thread decides to call make_bad_inode() on
it - that would evict it from icache, but we'd already found it there earlier".
In some it's outright "we have an inode attached to dentry - that's how we got
it in the first place; let's call make_bad_inode() on it just for shits and giggles".
Either is a bug.

_ntfs_bad_inode() uses are completely broken.  Matter of fact, we probably ought to
retire make_bad_inode() - there are few callers and most of them don't actually
need anything other than remove_inode_hash() (e.g. iget_failed()).  In any case,
whether there is a case for several new helpers or not, the kind of use
_ntfs_bad_inode() gets is right out.

