Return-Path: <linux-fsdevel+bounces-60043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CA9B413BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427BC188ADB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC032D4819;
	Wed,  3 Sep 2025 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EWf+EWL0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E22D5406
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875277; cv=none; b=Zd3Il/9vXMQozSvXhpWyCdNjScjV82SN3dsRw0d8NJatNXj5iPqdpKdsBf9Bqb4Ix47RdCg6oWp+Mx9O6VlLGQbKEXHUMWIHmnmnCD/q9/pUo5a/Mxe7ZN7YiyTMIlgYricOX65FCRLgF6RDOHbuAnxDGI2wEraQCWLiFM+sLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875277; c=relaxed/simple;
	bh=xqAnTNAirBf+81/g4anN79HbpLRlgzOTpOAxT3PiK9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWd4xWCuZ/hNkxaVeR60cYMXAHmDNr47/AixtRSSrifcBUJ36CIBoRydzW1vpxoPj0KuIGQwN+vUVt0lpUICLxQG+j9y1TdWusI24KvICWp5l/Y7lFxiSY/cPmUW8dnJocuwainznEYVq8m1Sg89wr74DV9lE6ldDvuL59Nu5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EWf+EWL0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1xMdy2WwcaPPZYcmifyZiifz//dc8mpxmsdnEkOrAsg=; b=EWf+EWL0L8XarSADP5VePRPgqU
	M+TpYkt/MhqppbOoQDLdUxm5NT2kQ/f0rD2ZIs5X/XrittBISPEG1nVR9o0YR3grD1YT3HCT+KAQC
	PMixZnRfJ5ja6/fj147GOilpVqA9fKTe7CQM2Q0Yc+ePdFDQAv444EKGVI1dbRbszzHjew4zwP7jS
	BjPddsL5nIBIbfjrmkRb/jaDj2u4hMm/Zo+9IyoqrrVeBlL7mf9oSx11OgRyfXyE486J/m14zvq6O
	9Odsx8MKe8LL5AAVtKd/s520ej03+foZeXu5ashrLVVLPGWN8Inx/pUNKVpiJLhpI5/jeYmsYpKGs
	XuNRP4OA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfVw-0000000Ao1X-122f;
	Wed, 03 Sep 2025 04:54:32 +0000
Date: Wed, 3 Sep 2025 05:54:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCHES v3][RFC][CFT] mount-related stuff
Message-ID: <20250903045432.GH39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250828230706.GA3340273@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828230706.GA3340273@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Branch force-pushed into
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
(also visible as #v3.mount, #v[12].mount being the previous versions)
Individual patches in followups.

If nobody objects, this goes into #for-next.

Changes since v2 (other than applied r-b):

	#26: typo fix in description (do_new_mount_rc -> do_new_mount_fc)
	#33, #35: massage suggested by Linus
	#35: where_to_mount() massage, more or less along the lines of
Christian's suggestion.
	between #52 and #53: document locking in patch_check_mount() and use
guard() in its caller (path_has_submounts()).
	#56 (now #57): fixed editing braino in commit message
	#58 (now #59): restored lost mnt_ns_tree_add()
	#59..63 (now #60..64): rewritten (as posted last week)
	added in the end of the series: constify {__,}mnt_is_readonly()

Diffstat:
 fs/dcache.c                   |   4 +-
 fs/ecryptfs/dentry.c          |  14 +-
 fs/ecryptfs/ecryptfs_kernel.h |  27 +-
 fs/ecryptfs/file.c            |  15 +-
 fs/ecryptfs/inode.c           |  19 +-
 fs/ecryptfs/main.c            |  24 +-
 fs/internal.h                 |   4 +-
 fs/mount.h                    |  39 +-
 fs/namespace.c                | 992 ++++++++++++++++++++----------------------
 fs/pnode.c                    |  75 +++-
 fs/pnode.h                    |   1 +
 fs/super.c                    |   3 +-
 include/linux/fs.h            |   4 +-
 include/linux/mount.h         |   9 +-
 kernel/audit_tree.c           |  12 +-
 15 files changed, 603 insertions(+), 639 deletions(-)

