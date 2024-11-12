Return-Path: <linux-fsdevel+bounces-34545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1489C6276
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DCF28364C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFF0219E29;
	Tue, 12 Nov 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WIBjj3hi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532220ADEC
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442885; cv=none; b=pZ4ej4WmNrmpDS2Cd5iuj4HAHWQtAy0j+M25Lmyp+bjKNtKV9Q5/YJgbXijFfLlLOzeX0d+nUdRKB48Jxhr6uRZuJsO9OlPp5MkxUzII+05v9FXwVVHRZH0/qPZhYrtBC38lWDciyc8PBx0n8IPl5LP2MkRrVoozAo9pPteKtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442885; c=relaxed/simple;
	bh=ZBjlyw9pQRaDQ8/3ZQcGftMDDBd47bnANrijBKvl96Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HjoVu3PRQhl1fClS5u7fhvMrzMFNs04mzVCK0CPygH0c6BZ1eZQ9CZoXeNQDT1wsFLLZ26jMheFyhksqnZ+7zTXEmSpMhRDraJgMeAUQkuC3vMcYxtjEo4P4cmO6jPoL2MKdwacX2brWGUaqLvqAAuuJXxZ/gPhMepgxgVhkwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WIBjj3hi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=diJNNhue438kwrNzJSY/A/o9+X7BJubYTIxQTLyV9YY=; b=WIBjj3hijiGHShesMx1Msxfx2+
	RNjXjizSEUQSxCSKCaPeSMO4G5Mfquyg+u9PHr0qjmIhOXAJg2SxgylfxKEGLNCAlLzdFCuiJxy18
	rx95wcRoaap7Y/EX3pd5r7DqJIsAarQ66+4FTNEcH46DnDqwJXSnYMLdZBWMCsaf/Y0nTKeUJzPvt
	BI1CQnwx8ovcXl8r+Otz7OEP+qFxI6dmqXUdDXKdQuSqt5EmG6Git94mO86eG5lY1Pb1EVV8D3dDj
	NrqXTVZufqiR/cOAId4JJ0ARm3TfltECHNlkPGj3SRXOvWVwGYKVZlTaIfT+7FSrw8YrkP7emD1YE
	FDedbgNQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAxO2-0000000EElN-3Jk3;
	Tue, 12 Nov 2024 20:21:18 +0000
Date: Tue, 12 Nov 2024 20:21:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCHES][RFC] statx-related stuff
Message-ID: <20241112202118.GA3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Assorted statx-related stuff; I hoped there would be more of that, but
the things got stalled.

Currently in there:
	* partial untangling of io_uring interactions (separating
the damn LOOKUP_EMPTY from the rest of flags, at least)
	* struct fd converions in the area (separated from #work.fd
to reduce conflicts)
	* getting rid of AT_GETATTR_NOSEC [Stefan Berger]; depending
upon the desired semantics for LSM shite around ->getattr() we might
want to pass some kind of flag to instances, but in the current form
it's been completely pointless - all calls ended up with that thing
passed to them.
	* getting rid of pointless empty_dir_getattr() - it's used
only as ->getattr() instance and it had been an equivalent of what
we do with NULL ->getattr all along.

Branch is on top of viro/vfs.git#base.getname-fixed; it lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.statx2
individual patches in followups.

Shortlog:
Al Viro (4):
      io_statx_prep(): use getname_uflags()
      kill getname_statx_lookup_flags()
      fs/stat.c: switch to CLASS(fd_raw)
      libfs: kill empty_dir_getattr()

Stefan Berger (1):
      fs: Simplify getattr interface function checking AT_GETATTR_NOSEC flag

Diffstat:
 fs/ecryptfs/inode.c        | 12 ++----------
 fs/internal.h              |  1 -
 fs/libfs.c                 | 11 -----------
 fs/overlayfs/inode.c       | 10 +++++-----
 fs/overlayfs/overlayfs.h   |  8 --------
 fs/stat.c                  | 24 +++++++-----------------
 include/uapi/linux/fcntl.h |  4 ----
 io_uring/statx.c           |  3 +--
 8 files changed, 15 insertions(+), 58 deletions(-)

