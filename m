Return-Path: <linux-fsdevel+bounces-48511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A08AB0454
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FD117EF91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51922333B;
	Thu,  8 May 2025 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QnbdvHuH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E029A0
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734666; cv=none; b=NE0CWCtQFZtp05aY3JsD06na24s2eNy3uozJXfLLf5Zk+wkwVYYe82/4SPYZmfoEE/UMwDMueYPDnCB2FgXtPUIm+nzoENcGQkj0xQnirEci+ft0M7vKXDmt+CqO/8PQuqKfeLNRiEQfZSo/+ZTjEcl27kCDXXs6Sb3J9CcggCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734666; c=relaxed/simple;
	bh=LsFPYe2SyXuDTYfHe2v6L9RuirU7it596E+E+nP6JHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRQ0AojkWluGh1/Ut3mQy4S07DuH1b0N8ETlYDv/S89ZYHX0GJ/SyjxLor9bUymiiYQ8ikXY8o8kfbOPRz+cgX3gJ6hLOIoVPUDEd6fH70CJVf/yjPIEMyBlXLk+aYsVghKEn974kaxX46vAQAsFXkKdau4e6nyJJIqikR1tHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QnbdvHuH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qlDS8tyzdfh3XZsPSi+v1T+n/t1GTW2MCGYXhwj3h3A=; b=QnbdvHuHjER3TQg+PBJinp6GPw
	9U/UqovTVcugT5TDIwd1FGsAjaqnDiSiiKmyqB3Rc2Dc16O8Tfhn3Xvt0ooVvrG2ZR+31zW7M1VCF
	l+ux022BZGqhIX88YTWmZATkewXrPppwHePhDeYnIW3UOmsuyBKxXfqYJdqrHKRReDzHRaMa/qPq+
	D/8ufDcVz0q4cLURYdPIXq/tuiGbX0huOXx1QdA25LLUtTh8pPyxhqKeV9vo8DbRjGeUTHWZkm8hi
	rka5WVZOQKZF+sG3eZkRB/xH9DqDzOrAug3fVZd13vZRukz2yv01kkmKGjt4oy7fhtxyEmhKnIxeQ
	EgpU4weQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD7Ti-00000007r28-2koK;
	Thu, 08 May 2025 20:04:22 +0000
Date: Thu, 8 May 2025 21:04:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: reproducer for "fix IS_MNT_PROPAGATING uses"
Message-ID: <20250508200422.GI2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
 <20250508200242.GG2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508200242.GG2023217@ZenIV>
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

int playground(void)
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

int setup(void)
{
	int fd;

	playground();

	mkdir("A", 0700);
	mkdir("B", 0700);
	mkdir("C", 0700);

	tmpfs("A");
	change("A", MS_SHARED);
	bind("A", "B");
	change("B", MS_SLAVE);
	change("B", MS_SHARED);
	bind("B", "C");
	change("C", MS_SLAVE);

	mkdir("A/foo", 0700);
	mkdir("A/subdir", 0700);
	fd = open_tree(AT_FDCWD, "B", OPEN_TREE_CLONE);
	change("B", MS_PRIVATE);
	return fd;
}

main()
{
	int fd;

	fd = setup();
	bind("B", "A/subdir");
	printf("bind propagated to C: %s\n",
		exists("C/subdir/foo") ? "yes" : "no");
	cleanup(fd);

	fd = setup();
	move_mount(AT_FDCWD, "B", AT_FDCWD, "A/subdir", MOVE_MOUNT_F_EMPTY_PATH);
	printf("move_mount propagated to C: %s\n",
		exists("C/subdir/foo") ? "yes" : "no");
	cleanup(fd);

	fd = setup();
	move_mount(fd, "", AT_FDCWD, "A/subdir", MOVE_MOUNT_F_EMPTY_PATH);
	printf("move_mount (fd) propagated to C: %s\n",
		exists("C/subdir/foo") ? "yes" : "no");
	cleanup(fd);

	return 0;
}

