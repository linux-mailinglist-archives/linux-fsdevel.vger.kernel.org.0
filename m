Return-Path: <linux-fsdevel+bounces-32386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF689A49D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50701283A06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BEC191461;
	Fri, 18 Oct 2024 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jg8VXxR9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61ED1898FB
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293273; cv=none; b=GKacCbRzJOAOsgrljlv9eOM7t0XZTK8NY5pHFUHGoYHq7Ljv/dbn0YTzsqD0wJ/eJGkj+28jEQ/jYyEUztCbAfPNSdN3WJRioGnisRJKmwifsRqmKyKDvbCQzbkKLQbWqfyVCLsGHtdLVU2gixrG/LydnIw5RNDIybYJ4YUzvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293273; c=relaxed/simple;
	bh=xUAAuvejb8c+PQzA69wjqt1AwDJ3vOM3sn6BTfcrTfc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LawwuhI5ExLCpyY7JhZMPeuZ1gAQ2Vm8Ra5FrVs8kNl7imxyOHbZOPzJxPier3dXdGiByWAnyPObaH3tCOYbtkB5rQcnVHxfnNwQQQbMl7caec+Q0WbsKNWckILGSWsERBmJBU2dh3L9ypfR1Ro8IxiymHfaUmqKfXeHcHvu6ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jg8VXxR9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wuKOImxCnOxFfWaxu0Gye4wEqSoE9mgyO5UocjfWtFc=; b=jg8VXxR97aWj3Q+I74icEZSdhr
	UJlm1RfALIgd5KDVIssJ2+14U9t/lrA4HEdj29YFmhB+m6RangEWQd/P+Td66nTPNy3SaH4WUM2l0
	yxPoFyg0MDztUVMLnQWrq8+VTv8lxWJglqwKaFujPwtoEfzpBZdqhcDY7XdULqtdSswo2bo2wrAHw
	N2Dn+l2d1ON19x9soP9xQ8BFG5nXsp7dOOagKaY4yD8R7eA99nEuT/VCC2kqG6XlKw8D/AdLiU2Dd
	8miunF+16OAZi4HxWPDbv6an2yqi6vROZWAldHmwL9qLGLLtR8EaSXNC6Z4J9J1+U6Jp/KjD92NDg
	gn7f+oMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wAu-00000005DzO-0lwO;
	Fri, 18 Oct 2024 23:14:28 +0000
Date: Sat, 19 Oct 2024 00:14:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [RFC][CFT][PATCHES] fs/ufs cleanups and fixes
Message-ID: <20241018231428.GC1172273@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	A bunch of UFS patches of different age; most of that had
been sitting in my tree for quite a while.  This stuff survives
xfstests (with mkfs.ufs and fsck.ufs from old debian ufsutils
and
export FSTYP=ufs
export MOUNT_OPTIONS="-o ufstype=ufs2"
export SCRATCH_OPTIONS="-o ufstype=ufs2"
export TEST_FS_MOUNT_OPTS="-o ufstype=ufs2"
in local.config); review and more testing would be welcome.

It still has... interesting issues around block relocation we had
since 2.3.early, but to deal with that we'll need an iomap conversion
and that requires quite a bit of untangling of inode.c and balloc.c;
some of that is done in that pile, so hopefully we'll get there.

Branch is in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.ufs,
individual patches in followups.

If there's no objections, I'm going to put that into -next (either
via viro/vfs.git or vfs/vfs.git; AFAIK there's no dedicated UFS git
tree).

Shortlog:
Al Viro (12):
      ufs: fix handling of delete_entry and set_link failures
      ufs: missing ->splice_write()
      ufs: fix ufs_read_cylinder() failure handling
      ufs: untangle ubh_...block...() macros, part 1
      ufs: untangle ubh_...block...(), part 2
      ufs: untangle ubh_...block...(), part 3
      ufs_clusteracct(): switch to passing fragment number
      ufs_free_fragments(): fix the braino in sanity check
      ufs_inode_getfrag(): remove junk comment
      ufs: get rid of ubh_{ubhcpymem,memcpyubh}()
      clean ufs_trunc_direct() up a bit...
      ufs: take the handling of free block counters into a helper

Matthew Wilcox (Oracle) (5):
      ufs: Convert ufs_inode_getblock() to take a folio
      ufs: Convert ufs_extend_tail() to take a folio
      ufs: Convert ufs_inode_getfrag() to take a folio
      ufs: Pass a folio to ufs_new_fragments()
      ufs: Convert ufs_change_blocknr() to take a folio

Diffstat:
 fs/ufs/balloc.c   | 107 ++++++++++++++------------------
 fs/ufs/cylinder.c |  31 ++++++----
 fs/ufs/dir.c      |  29 +++++----
 fs/ufs/file.c     |   1 +
 fs/ufs/inode.c    | 179 +++++++++++++++++++++++-------------------------------
 fs/ufs/namei.c    |  39 ++++++------
 fs/ufs/super.c    |  45 ++++++--------
 fs/ufs/ufs.h      |  12 ++--
 fs/ufs/util.c     |  46 --------------
 fs/ufs/util.h     |  61 +++++++++----------
 10 files changed, 222 insertions(+), 328 deletions(-)

