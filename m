Return-Path: <linux-fsdevel+bounces-50796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F87AACFAE8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 03:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3A8175D6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 01:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9C7194A67;
	Fri,  6 Jun 2025 01:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qYiiAoeh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F918DB35
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749174993; cv=none; b=TZC3nPamd9ggRhGr+kEO8Bww848oqYruxFTXAhoPHY8EWD+ILH6i8KvyQaLoMSubY6hVtqbdawhY3+LSmTtIlqHn4g4FyPG3eENM86u4f3dIWIdeQ0AUZrzlbi2uM5vGwlkX7ahkTQiw2WCH37DL+qTqn0GVpK3Ilzgm9JUTnHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749174993; c=relaxed/simple;
	bh=ZicqUsTP4CX8B80jc6S+MeJQQ2LyPyx1zVUJMDw3Pp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EO+TA4OpOrn6UdyHzaHRC3l4J7BTpRkIszrGP8TKVy/7mjA4y2OjQYfjU1ACQbXSO+g8aEKjk9W4c4kPnKwRCQYFN32EBisVcmTossulizOLw/N98vf2eBnA34I6qsowOQFcD1InrW6YCxw+XEE/XaZvI71+LlupD8Nc7Xmmkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qYiiAoeh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xhKeJLFtm8xKEFPiQTPE/vHq6X0F9VO73DrR/s9qNKk=; b=qYiiAoeh+6GcAYr6EgU/POXSyf
	pR3EHJzA4XfCm9jtcUu1cxxMhWQjb4vIte57XT1UN7EgFWfB3Ntvq8aVvf3WQgrqWFQsN88egHUl9
	mPdITe4kWmGCb6a2K68S1dE1/wV55TFfkoendImEW0bkgAfW0LDJ69YofXxjtKvQB6CVYncK11W0z
	Es3iSJO4YI7mPKkS5EJroBiwCPes8/2rq8tkl5q3deHt6wQA61EbuiOeL5WEEwr/GgBPYxJe7jhvC
	r6zW+DKS+vkq7f3RVBmoFTvknOHZE7FXjDtH/rXajJZlj+hgASSoMcr6xWhUpPCcY0R8Q5a71WduM
	RPiwQjuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNMJh-0000000AIDm-1P7D;
	Fri, 06 Jun 2025 01:56:21 +0000
Date: Fri, 6 Jun 2025 02:56:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: wangzijie <wangzijie1@honor.com>, rick.p.edgecombe@intel.com,
	ast@kernel.org, adobriyan@gmail.com,
	kirill.shutemov@linux.intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: clear FMODE_LSEEK flag correctly for permanent pde
Message-ID: <20250606015621.GO299672@ZenIV>
References: <20250605065252.900317-1-wangzijie1@honor.com>
 <20250605144415.943b53ed88a4e0ba01bc5a56@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605144415.943b53ed88a4e0ba01bc5a56@linux-foundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 05, 2025 at 02:44:15PM -0700, Andrew Morton wrote:
> On Thu, 5 Jun 2025 14:52:52 +0800 wangzijie <wangzijie1@honor.com> wrote:
> 
> > Clearing FMODE_LSEEK flag should not rely on whether proc_open ops exists,
> 
> Why is this?
> 
> > fix it.
> 
> What are the consequences of the fix?  Is there presently some kernel
> misbehavior?

At a guess, that would be an oops due to this:
        if (pde_is_permanent(pde)) {
		return pde->proc_ops->proc_lseek(file, offset, whence);
	} else if (use_pde(pde)) {
		rv = pde->proc_ops->proc_lseek(file, offset, whence);
		unuse_pde(pde);
	}
in proc_reg_llseek().  No FMODE_LSEEK == "no seeks for that file, just
return -ESPIPE".  It is set by do_dentry_open() if you have NULL
->llseek() in ->f_op; the reason why procfs needs to adjust that is
the it has uniform ->llseek, calling the underlying method for that 
proc_dir_entry.  So if it's NULL, we need ->open() (also uniform,
proc_reg_open() for all of those) to clear FMODE_LSEEK from ->f_mode.

The thing I don't understand is where the hell had proc_reg_open()
changed in that way - commit refered in the patch doesn't exist in
mainline, doesn't seem to be in -next or -stable either.

