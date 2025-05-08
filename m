Return-Path: <linux-fsdevel+bounces-48510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4232AB0452
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D907B61AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D703220F3B;
	Thu,  8 May 2025 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eg6+/Nws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8F35976
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734615; cv=none; b=gpBUVhPiQ7BmMkye2uZEn3BExJX5W+YtpqjvDLc2XwFKvXDwp3qL2/LBf55cI5Oi76tpSGR6BIJvqfaxTc3fCyDom5LqmI6pQMG935gX/zqVFDb3atM9qy4dYn16jYuf/uo8bxvLkAMgDzkzxclq88n6j/iqB8KhYdBZJGrsjoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734615; c=relaxed/simple;
	bh=Kz5/Rsa3XBT+qqkfctZfkTZGb+zV3QgM//pxWVxt6PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH0g3fps3DbB3QW8aJAZXTqCAv79s94t5e8Jyi/awV7LV0uVu+lWLO7Fh3m/hY2Ez34ew0C6ksRlMALDlWuRtffz6/eEbrigyMR4lAFz6zu7Byb8j5QunQMzH1k3SzFsTIIkOxfyeuBq3oGzr24L0Jpyif/72hG+SEk6tqqcd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eg6+/Nws; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UDmfmhsGDFKPaeHbvT3PVjFYLnXKXd5xv2e5LH3NjuU=; b=eg6+/Nwsn/yQ2m6j9X6lTxL+2z
	/kpG8Lv//l33pTewHOhl0OVypMf09nzK3vouJqAi/OGtglctmahXGoe5VZyBcKIp60afyJokTm30r
	H651Lrx1asVpHBRtxrCqpjcBzx5tqduznXkDuV5Gqld8rqIo+2KpJa5FsnVwmuHyEQ33dxC07a23/
	9LMgMknuvsvjFw/wpXzGbJpAZx/ZN0LsGEyR9AHkIxuSW85uSnGxA9ugY0qP4OTqC1UycN72FUi/9
	SniDPwQL4gkIu+s8coOPEEaOhwGwDqTcMDCfNGvXGnZ9iH5e3iaKUPJG7eZtXRBm7OdFBeOSnOTj0
	46mKDB+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD7Su-00000007qpw-3Whz;
	Thu, 08 May 2025 20:03:32 +0000
Date: Thu, 8 May 2025 21:03:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: reproducer for "do_move_mount(): don't leak MNTNS_PROPAGATING on
 failures"
Message-ID: <20250508200332.GH2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
 <20250508200211.GF2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508200211.GF2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

#include <string.h>
#include <unistd.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <stdio.h>

static int tmpfs(const char *name)
{
	return mount("none", name, "tmpfs", 0, NULL);
}
static int change(const char *name, int how)
{
	return mount(NULL, name, NULL, how, NULL);
}
static int bind(const char *from, const char *to)
{
	return mount(from, to, NULL, MS_BIND, NULL);
}
static _Bool exists(const char *name)
{
	return access(name, F_OK) != -1;
}

void playground(void)
{
	mkdir("/tmp/foo", 0700);
	tmpfs("/tmp/foo");
	change("/tmp/foo", MS_PRIVATE);
	chdir("/tmp/foo");
}

void cleanup(int fd)
{
	close(fd);
	chdir("/tmp");
	umount2("/tmp/foo", MNT_DETACH);
	rmdir("/tmp/foo");
}

main()
{
	playground();

	mkdir("A", 0700);
        mkdir("A/subdir", 0700);
	mkdir("B", 0700);
	bind("A", "A");
	change("A", MS_SHARED);

        int fd = open_tree(AT_FDCWD, "A", OPEN_TREE_CLONE);

	// this move_mount should fail (directory on top of non-directory)
        if (move_mount(fd, "", AT_FDCWD, "/dev/null", MOVE_MOUNT_F_EMPTY_PATH) == 0) {
		printf("unexpected success of first move_mount()\n");
		cleanup(fd);
		return -1;
	}
	// this should propagate into detached tree
	tmpfs("A/subdir");
	mkdir("A/subdir/foo", 0700);
	// move detached tree in, so we could check it
	if (move_mount(fd, "", AT_FDCWD, "B", MOVE_MOUNT_F_EMPTY_PATH) != 0) {
		printf("unexpected failure of the second move_mount()\n");
		cleanup(fd);
	}
	if (!exists("B/subdir/foo")) {
		printf("failed to propagate into detached tree\n");
		cleanup(fd);
		return -1;
	}

	printf("success\n");
	cleanup(fd);
	return 0;
}

