Return-Path: <linux-fsdevel+bounces-63517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E746BBFA7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 00:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8515A3BB312
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 22:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AE619DF5F;
	Mon,  6 Oct 2025 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Aub2Epa5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B92B9A7
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789113; cv=none; b=hw9YbAlklYAxEKnfc1La6biuHnej17O6+b1QVH8lHIHGs9k6Au4/qY3Q7QH8RMZjX9WlpFi9nEWM9zgXau84J7GV06cn4P3gpKogH8Mmbffoi+QrHm+sACo9PwRIuaR9aobLklJ1cENT2Q7ozuubqDuDgaaFO3tLBu5n5526f1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789113; c=relaxed/simple;
	bh=xNSpFwn82p2vfsCfdc33EYDEn+edwJZkDSdDv391nGk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QGvHSTAeh7UmEQbjghz1zwzvXt3KC0I1+Xd9vGoZ2e9bEXJlCfTHcobwMWnzd0wGUcSBi1eRQyI1JMsHILPhIFgoJyhGRhcmaxX/59SkVIoUqv0racrrXeNTUE1HWmVTgHwmmECOlPsxQymHUk4J/5qTMcY9cPr6tgtp7s1w7fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Aub2Epa5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PsJm+CA8Lls4/b6Li3a+z1Blp+ZlQnLjJSYZ1Wlasjg=; b=Aub2Epa5HmH7hrm2gFwaMZYCi5
	gGCufNp0V6Ta5kGfvRgVI8azaICCVLakcxtBfyubOL8QfxBGcSKZibjSe19EQiqZ5lT5BARGDBBC9
	Hmkzf/UMLdW3/+pYs0zTFyMI9jpUQnydh3sMcY5tHZtFsy3wPoYt/BCLmdCm+JiAfsjnrirZwhmm1
	Iz2TxrTAAu3Y4l+b8EEI6pAjgE7hsP+zXy366NobAJYKPK17WUMln2PuOEnj7pDBPMvLjMKUTFNR2
	PyBzVEVMsf74TEkww0+e4GWWQKSiMW0sNXB/9Wo1/ItkiLb/TyCOKKmpXCp/df32pYimAqB+hS/7I
	XEplypog==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5tXI-0000000Dipj-1vCq;
	Mon, 06 Oct 2025 22:18:28 +0000
Date: Mon, 6 Oct 2025 23:18:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [RFC] what's the reason to delay switching current->files in
 close_range(2)?
Message-ID: <20251006221828.GH2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

In 60997c3d45d9 "close_range: add CLOSE_RANGE_UNSHARE":
    The patch makes it so that if CLOSE_RANGE_UNSHARE is requested and we do in
    fact currently share our file descriptor table we create a new private copy.
    We then close all fds in the requested range and finally after we're done we
    install the new fd table.

Is there any reason to do things in that order?  IOW, what's wrong with
replacing the descriptor table as soon as we'd done dup_fd() (unshared_fd()
in your original version) and doing the closing after that?

I'm trying to come up with reasons for that, and I don't see any, TBH...

The reason I'm asking is that doing it your way complicates the analysis
in there - e.g. __put_unused_fd(files, _) almost always has files equal to
current->files with files->file_lock held by caller; the sole exception
is __put_unused_fd() called from file_close_fd_locked(), called from
__range_close(), called from close_range(2) with CLOSE_RANGE_UNSHARE
with current->files->count greater than 1.  On that call chain and on that
call chain alone it is given the result of dup_fd() that will shortly
(and unconditionally) be installed as current->files.  ->file_lock
is, thankfully, held.

Sure, it's visible only to the caller, so we can simply adjust the
predicate to "equal to current->files or not visible in any shared
data structures", but... what's the point?

Note that delayed replacement of descriptor table does not buy us
anything in terms of concurrent modifications - another thread could
modify our descriptor table only if they had their ->files pointing
to it, which obviously won't be possible until our thread spawns
a new child with CLONE_FILES.

Am I missing something subtle here?

