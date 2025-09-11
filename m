Return-Path: <linux-fsdevel+bounces-60880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E530FB527F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 07:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0741B2372B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 05:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501471C54A9;
	Thu, 11 Sep 2025 05:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Kwluv65J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC419329F25;
	Thu, 11 Sep 2025 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757566914; cv=none; b=HcKrXrvYKbB4b+OvwPBywDw3v8Zk8kCQgF6qmtp2hmuPvlUElCOfvgljUg/LofrE6FnQMC3epm1CDxV2nn0e3SQdtvqEkNi5sMcv5tJh/TUlXIITUgTDGxkqTnorqlnkZpEuNcE+1GehGKl9BH2IXn51FQopCexVvnlRcdG0qeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757566914; c=relaxed/simple;
	bh=iy4MEdMWil0xIpsLLrVmQ+PiVT0bl2tQP4V8ZVQaITM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sZgBpNS6+vYcFDfcsS2HZz75Z8P2r64X9ZfUrYGsRRPhL101zXbacMvf9M4isybffUSIF82zm4Uu2SKDCzA2X8EUmrDHNL3JFB1W4OUjllIbAEoy6ImlP1JOpM9w626V95F0tpojV86yRoq2snfISXnJu/FXpIQMzafIQmVQtwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Kwluv65J; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VA1+d3DsRywS83UPZ5d63teV8/2PJi3dx7q5+vckWh4=; b=Kwluv65JHKHEOnjIt00+ZugAcN
	fC0gj83R1oSV2e2bWA25DqJnGwhKoyfTvZmIqFzPW0IE5VgV97qRENiUuhYJTqlLJvgTsxZ6Gu743
	RLhNqEVB20pNSw8Wdj7pkvAcGx8H8ARvunBrJwX+5jKr7on78KbN9qX42gZYy99fRjJFFNy+yhBCM
	d7+Q5xvk9R4OaENWMC4HooG9mIqccofIEsqZmjqSWuc7Ok+WxlIULth9V2On0iZ7BretwBA+ybxRu
	91zKRbfvh9endVd7LeEFKhkN/D+PF7ODqi+Uf+82HVo+stVtWqba44gle4l7QugbkG6hFAI6mpbjm
	9LCzK4eg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwZRN-0000000D2AV-0RKR;
	Thu, 11 Sep 2025 05:01:49 +0000
Date: Thu, 11 Sep 2025 06:01:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCHES] simple part of ->d_name stuff
Message-ID: <20250911050149.GW31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Rules for ->d_name access are rather unpleasant and so's
verifying that they are followed.  There is a relatively simple part,
though - nobody outside of fs/dcache.c has any business modifying
that thing.

	So let's make sure that all functions we are passing
&dentry->d_name are taking const struct qstr * and replace
->d_name with an anon union of struct qstr *__d_name and
const struct qstr *d_name.

	It is *not* enough to guarantee that another thread will
not call __d_move() right under you - checking the requirements
for that is the hard part.  It does make it easy to verify that
nothing else accidentally starts changing it.

	This stuff lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.qstr
Branch is -rc4-based, individual patches in followups.

	Please, review.  If nobody objects, I'll put that in #for-next.

Shortlog:
      security_dentry_init_security(): constify qstr argument
      exfat_find(): constify qstr argument
      afs_edit_dir_{add,remove}(): constify qstr argument
      afs_dir_search: constify qstr argument
      generic_ci_validate_strict_name(): constify name argument
      make it easier to catch those who try to modify ->d_name

Diffstat:
 fs/afs/dir_edit.c             |  4 ++--
 fs/afs/dir_search.c           |  2 +-
 fs/afs/internal.h             |  6 +++---
 fs/dcache.c                   | 26 +++++++++++++-------------
 fs/exfat/namei.c              |  2 +-
 include/linux/dcache.h        |  5 ++++-
 include/linux/fs.h            |  6 ++++--
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      |  4 ++--
 security/security.c           |  2 +-
 security/selinux/hooks.c      |  2 +-
 security/smack/smack_lsm.c    |  2 +-
 12 files changed, 34 insertions(+), 29 deletions(-)

