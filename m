Return-Path: <linux-fsdevel+bounces-20977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191978FBAAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 19:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3CA1C20E1F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7A149E05;
	Tue,  4 Jun 2024 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JuvGPWf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE0B5F860
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522865; cv=none; b=oeRzbvFDO+E+ReEofuFPEXPqfkrygzXM1hItI6SUb+ObgiIqNrUivhB+ExHXdEoFbYL8j7p1WaOkzGwfQGqcVDYvPjBfGuafb7W0rDv37uZLQn8sYYoczIxkYGJnhBeg+CrlufZ5GKevqDM6a0deVWy6ts78/Uq5ldsTeStvCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522865; c=relaxed/simple;
	bh=09jmvBs7ku1ZjDa3UrjqrTduqmqPQ1TbAhHxnKpF0cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zq1W0/WfXkzNlgCuwhiaFg0mWmEj2ONYGrvapDGSLgkE42vOPJz47ojZU5qXwaguvk8QJ+iWLl7HbEJ+iq/3qxwCq/Gjeiau69kO/+WywFdl6ov3XINYi/gWH4riaFzBQHDFRvSTMrEguVnmxgeWmGpR0eb+xeQOfP1q6VgzBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JuvGPWf/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=MvxJDuV4+KB/aT56wJzry/Vmkf0kdHRXla3fO2taS8Q=; b=JuvGPWf/GxO9toiGc7HpRLlkml
	Cs/RCbzIBxM93qY7Tx0WLRE+bi5jJwbtkasGA7/vrUU3dtskhNj4PnV0Dj0FDsvqgeQIgXkrEFWeD
	1oaVKA3pbMR6FHw17YbUywoqbtkqqKsV8AeFfXvOKbZthzA5UddqerAyqqYAHjEZSVFneorhq9NaU
	LHr5jRBqd0/k73BHSleu+3OyPOBrytSa/xur/Hqe4luK9bIGM2ZAVqT+K9fHdlYzLQ8FphzJGPe91
	O2vzuBA8165yB8QXDlKuRRkKhqc1I5Ds6dxbyulmZTga/CXzH4C0PgF5+iWEE4HF3qnUhhOz66rly
	+2fhCpzA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sEY9b-00Dp56-2d;
	Tue, 04 Jun 2024 17:41:00 +0000
Date: Tue, 4 Jun 2024 18:40:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ivan Babrou <ivan@cloudflare.com>
Cc: linux-fsdevel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
Subject: Re: why does proc_fd_getattr() bother with S_ISDIR(inode->i_mode)?
Message-ID: <20240604174059.GQ1629371@ZenIV>
References: <20240604034051.GP1629371@ZenIV>
 <CABWYdi0KTJVsuEokmUF+fQ6w9orGNeaJLyjni0E8T+A0-FHe7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABWYdi0KTJVsuEokmUF+fQ6w9orGNeaJLyjni0E8T+A0-FHe7g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 04, 2024 at 10:35:43AM -0700, Ivan Babrou wrote:
> On Mon, Jun 3, 2024 at 8:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         ... when the only way to get to it is via ->getattr() in
> > proc_fd_inode_operations?  Note that proc_fd_inode_operations
> > has ->lookup() in it; it _can't_ be ->i_op of a non-directory.
> >
> >         Am I missing something here?
> 
> It's been two years, but I think I was just extra cautious.

Does anyone have objections against the following?

[PATCH] proc_fd_getattr(): don't bother with S_ISDIR() check
    
that thing is callable only as ->i_op->getattr() instance and only
for directory inodes (/proc/*/fd and /proc/*/task/*/fd)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 586bbc84ca04..bda7abcf29fa 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -357,18 +357,9 @@ static int proc_fd_getattr(struct mnt_idmap *idmap,
 			u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	int rv = 0;
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-
-	/* If it's a directory, put the number of open fds there */
-	if (S_ISDIR(inode->i_mode)) {
-		rv = proc_readfd_count(inode, &stat->size);
-		if (rv < 0)
-			return rv;
-	}
-
-	return rv;
+	return proc_readfd_count(inode, &stat->size);
 }
 
 const struct inode_operations proc_fd_inode_operations = {

