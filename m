Return-Path: <linux-fsdevel+bounces-67886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 883DFC4CCC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F18EA4F9BFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9584C2F261C;
	Tue, 11 Nov 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WXA69s3/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273E256C87;
	Tue, 11 Nov 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854603; cv=none; b=XEEvzNwvt7G1skMKwHDDzttBvBr1PAkLGKutrIZE9O5RhBGstNREAwaMjRdqk5Xjbm5GSCAcsF9zQUCK3cmbmxqCoTf/z46dr8aqrCiwz/bossJfSLnDZiZeqnXKuDRL6QjXRqfXNpHU42RBqM3C9nRaUiCT7mKii0YVl+qagZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854603; c=relaxed/simple;
	bh=D36LveqlJs6QkLgZQAhRPR+Lxgos/gtCjDPl8hDAgYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYPKS9dvpG1wsLawvEa11bgustnkaii0gykLIx3dymWAUt+CV59nDG0ENMWaYUZUDYwrpUpAJvKuyMNMGRoDlB7eo8Tt7qyayzM5lR0Q5ymmO6hysdjIHvAtqfWN50K8CyLALMBtkgNpAm3PkFDbsjIXdqBlQWRa5AkLLud8POQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WXA69s3/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6bsPdtBaqJ4UPF5R7K+ouK1dJ6DCyxBWv0w/QZnr7cE=; b=WXA69s3/ndSSCDKncRmaO/hjic
	O1y94fGm7YG4wpp1EnXG6yDbvuMjQmTNWvtrC7zZiZbJKSJQ3qPVVV+wFbvU9CFAsYmwuwFWd9TQz
	502RxsFSRuMlb+ZsoiAw/Eyy0gQ2krWPMw0fEZQ3Z1ZbYzdnWOQhbqHDcknhoQE/b6LUe5OiGj/uX
	ilItJNCZJAw3WeivKD5Fmg/6ibDscl4juFxBkBG0efupSFSIBUUIdS3DG4fn/rMt/0u9B5d/iqbE3
	VTHj0bLhd9xu7SVaxQVogoLmue/J7I9fcpgSO2MhCBANTrOxCwyy94lXIyVk5oV9wmikQTnsNUf6U
	oFmhH9OQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIl0f-0000000FPaa-0OxV;
	Tue, 11 Nov 2025 09:49:57 +0000
Date: Tue, 11 Nov 2025 09:49:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: bot+bpf-ci@kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v3 34/50] selinuxfs: new helper for attaching files to
 tree
Message-ID: <20251111094957.GT2441659@ZenIV>
References: <20251111065520.2847791-35-viro@zeniv.linux.org.uk>
 <70d825699c6e0a7e6cb978fdefba5935d5a515702e22e732d5c2ad919cfe010b@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70d825699c6e0a7e6cb978fdefba5935d5a515702e22e732d5c2ad919cfe010b@mail.kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 11, 2025 at 07:53:18AM +0000, bot+bpf-ci@kernel.org wrote:

> Can this leak the parent directory's reference count? The parent inode's
> link count is incremented with inc_nlink(d_inode(dir)) before calling
> sel_attach(). When sel_attach()->d_alloc_name() fails and returns NULL,
> sel_attach() correctly cleans up the child inode with iput() and returns
> ERR_PTR(-ENOMEM). However, the parent directory's link count has already
> been incremented and is never decremented on this error path.
> 
> In the original code, the parent link count increment happened after
> d_add() succeeded, ensuring it only occurred when the full operation
> completed successfully.

All callers of sel_make_dir() proceed to remove the parent in case of
failure.  All directories are created either at mount time or at
policy reload afterwards.  A failure in the former will have
sel_fill_super() return an error, with the entire filesystem instance
being torn apart by the cleanup path in its caller (get_tree_single()).
No directories survive that.  A failure in the latter (in something
called from sel_make_policy_nodes()) will be taken care of by the
call of simple_recursive_removal() in the end of sel_make_policy_nodes() -
there we
	1.  create a temporary directory ("/.swapover").  We do *NOT*
use sel_make_dir() for that - see sel_make_swapover_dir().  If that has
failed, we return an error.
	2.  create and populate two subtrees in it ("booleans" and "classes").
That's the step where we would create subdirectories and that's where
sel_make_dir() failures might occur.
	3.  if the subtree creation had been successful, swap "/.swapover/booleans"
with "/booleans" and "/.swapover/classes" with "/classes" respectively.
	4.  recursively remove "/.swapover", along with anything that might
be in it.  In case of success that would be the old "/classes" and "/booleans"
that got replaced, in case of failure - whatever we have partially created.

That's the same reason why we don't need to bother with failure cleanups in
the functions that populate directories - if they fail halfway through, the
entire (sub)tree is going to be wiped out in one pass.

