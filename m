Return-Path: <linux-fsdevel+bounces-57841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DD8B25B65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07C3564B5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 05:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051C22836C;
	Thu, 14 Aug 2025 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tYjAdP18"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77411FBEAC;
	Thu, 14 Aug 2025 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151025; cv=none; b=mp82ssLIydjciVLXwi9NIEC0mpzOKBVZ/ZHRVOzXMvTkj0qKR7KLOIMgE9yTtgYs+MxWiK3HwRfKiU4mhu2/wbbKgd2cb752ucp9KKyRznmElUFqfkClYn6mIbPKV7XsYQZtRk+rRyIEyY36CY/uQTR1M0/XE/oCkH5Dtu8Mi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151025; c=relaxed/simple;
	bh=n68HbMTB8C6ZGPu/7blBCLU0rCn7wQk93MW7Z3F5rxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhiJnlgMWLDnNaYVYrbkKE1r3DxEWDZasUHrdRTCQC/Nhw2ITPrvQigrINUs1DvR288uJwZZfJLvPgQOi+U57WVYjxFt4fNfAPWl1iUL+KtZhCx+NTq3Mwajt/OSSUdy4dUxkr/HNVRlda29orcURgs3nDxFchn4r/60xYBHB0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tYjAdP18; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DJJfzqEyiCj+MMKzXK28H85UE48D3pJGQJgzxb0UL4Y=; b=tYjAdP18FbxypqFtrgsjHfUmx/
	ybVu9oaxpcqw6zEy37EAh7d2I8UYLZxQOUoOWe4EOSxMBhmRqxVAiaxBOsFyxZmrQZDyRJ+BypAqH
	qJ5CUaAPnQ8s+VSuY80C+oC4023ZMm+YOEb4Ug98+au7z7UlbVcK6qroK3mxbw3KydXPwo4PfKTxN
	hZi7OnekxPua+GsgoLq5KT4dunxBs5i/QGBvRCu1a0E7WWifINGtTLgBUL8Q9smNNsOERhUooQNEP
	45gVUAPeqdv/IW6s0IaDl5A3uFQQrIBB0AvX7eRYQ8CR2yA6HadwYJIasxRmlE93QmrWxnDMuNP8E
	utIGRgLw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umQxS-0000000HQ2D-08mb;
	Thu, 14 Aug 2025 05:57:02 +0000
Date: Thu, 14 Aug 2025 06:57:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Tycho Andersen <tycho@tycho.pizza>, Andrei Vagin <avagin@google.com>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Pavel Tikhomirov <snorcht@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev,
	Linux API <linux-api@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: [RFC][CFT] selftest for permission checks in mount propagation
 changes
Message-ID: <20250814055702.GO222315@ZenIV>
References: <20250724230052.GW2580412@ZenIV>
 <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV>
 <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
 <20250813185601.GJ222315@ZenIV>
 <aJzi506tGJb8CzA3@tycho.pizza>
 <20250813194145.GK222315@ZenIV>
 <CAE1zp77jmFD=rySJVLf6yU+JKZnUpjkBagC3qQHrxPotrccEbQ@mail.gmail.com>
 <20250814044239.GM222315@ZenIV>
 <20250814055142.GN222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814055142.GN222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

// link with -lcap, can run both as root and as regular user
#define _GNU_SOURCE
#include <sched.h>
#include <sys/capability.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <stdbool.h>

_Bool drop_caps(void)
{
        cap_value_t cap_value[] = { CAP_SYS_ADMIN };
        cap_t cap = cap_get_proc();
        if (!cap) {
		perror("cap_get_proc");
		return false;
	}
	return true;
}

void do_unshare(void)
{
	FILE *f;
	uid_t uid = geteuid();
	gid_t gid = getegid();
	unshare(CLONE_NEWNS|CLONE_NEWUSER);
	f = fopen("/proc/self/uid_map", "w");
	fprintf(f, "0 %d 1", uid);
	fclose(f);
	f = fopen("/proc/self/setgroups", "w");
	fprintf(f, "deny");
	fclose(f);
	f = fopen("/proc/self/gid_map", "w");
	fprintf(f, "0 %d 1", gid);
	fclose(f);
	mount(NULL, "/", NULL, MS_REC|MS_PRIVATE, NULL);
}

void bind(char *p)
{
	mount(p, p, NULL, MS_BIND, NULL);
}

void change_type(char *p, int type)
{
	errno = 0;
	mount(NULL, p, NULL, type, NULL);
}

void set_group(int fd1, char *p1, int fd2, char *p2)
{
	int flags = MOVE_MOUNT_SET_GROUP;
	int n;

	if (!p1 || !*p1) {
		p1 = "";	// be kind to old kernels
		flags |= MOVE_MOUNT_F_EMPTY_PATH;
	}
	if (!p2 || !*p2) {
		p2 = "";	// be kind to old kernels
		flags |= MOVE_MOUNT_T_EMPTY_PATH;
	}
	errno = 0;
	move_mount(fd1, p1, fd2, p2, flags);
}

_Bool result(int expected)
{
	if (expected != errno) {
		printf(" failed: %d != %d\n", expected, errno);
		return false;
	}
	printf(" OK\n");
	return true;
}

int fd1[2], fd2[2];

void in_child(void)
{
	printf("from should be someplace we have permissions for");
	set_group(AT_FDCWD, "mnt/a", AT_FDCWD, "/mnt/a/private");
	result(EPERM);
	printf("to should be someplace we have permissions for");
	set_group(AT_FDCWD, "/mnt/a", AT_FDCWD, "mnt/a/private");
	result(EPERM);
	printf("change_type: should have permissions for target");
	change_type("mnt/locked", MS_PRIVATE);
	result(EPERM);
}

void in_parent(void)
{
	printf("from should be mounted (pipes are not)");
	set_group(fd1[0], NULL, AT_FDCWD, "/mnt/a/private");
	result(EINVAL);

	printf("to should be mounted (pipes are not)");
	set_group(AT_FDCWD, "/mnt", fd1[0], NULL);
	result(EINVAL);

	printf("from should be someplace we have permissions for");
	set_group(AT_FDCWD, "mnt/a", AT_FDCWD, "/mnt/a/private");
	if (result(0))
		change_type("/mnt/a/private", MS_PRIVATE);

	printf("to should be someplace we have permissions for");
	set_group(AT_FDCWD, "/mnt", AT_FDCWD, "mnt/a/private");
	if (result(0))
		change_type("mnt/a/private", MS_PRIVATE);

	printf("from should be mountpoint");
	set_group(AT_FDCWD, "/mnt/a", AT_FDCWD, "/mnt/a/private");
	result(EINVAL);

	printf("to should be mountpoint");
	set_group(AT_FDCWD, "/mnt/a", AT_FDCWD, "/mnt/a/private/b");
	result(EINVAL);

	printf("to and from should be on the same filesystem");
	mount("none", "/mnt/no-locked", "tmpfs", 0, NULL);
	set_group(AT_FDCWD, "/mnt/a/shared", AT_FDCWD, "/mnt/no-locked");
	result(EINVAL);
	umount("/mnt/no-locked");

	printf("from should contain the counterpart of to");
	set_group(AT_FDCWD, "/mnt/a/shared", AT_FDCWD, "/mnt/no-locked");
	result(EINVAL);

	printf("from should not have anything locked in counterpart of to");
	set_group(AT_FDCWD, "mnt", AT_FDCWD, "/mnt/no-locked");
	if (result(0))
		change_type("/mnt/no-locked", MS_PRIVATE);

	printf("change_type: should have permissions for target");
	change_type("mnt/a/private", MS_PRIVATE);
	result(0);

	printf("change_type: target should be a mountpoint");
	change_type("/mnt/a", MS_PRIVATE);
	result(EINVAL);

	chdir("/mnt/a/private");
	umount2("/mnt/a/private", MNT_DETACH);
	printf("change_type: target should be mounted");
	change_type(".", MS_PRIVATE);
	result(EINVAL);
}

int main()
{
	char path[40];
	pid_t child;
	int root_fd;
	char c;

	if (pipe(fd1) < 0 || pipe(fd2) < 0) {
		perror("pipe");
		return -1;
	}
	if (!drop_caps())
		return -1;
	do_unshare();

	root_fd = open("/", O_PATH);

	errno = 0;
	mount("none", "/mnt", "tmpfs", 0, NULL);
	mkdir("/mnt/a", 0777);
	mkdir("/mnt/a/private", 0777);
	mkdir("/mnt/a/private/b", 0777);
	mkdir("/mnt/a/shared", 0777);
	mkdir("/mnt/a/slave", 0777);
	mkdir("/mnt/a/shared-slave", 0777);
	mkdir("/mnt/locked", 0777);
	mkdir("/mnt/no-locked", 0777);
	bind("/mnt/locked");

	child = fork();
	if (child < 0) {
		perror("fork");
		return -1;
	} else if (child == 0) {
		do_unshare();
		change_type("/mnt/", MS_SHARED);
		bind("/mnt/a");
		bind("/mnt/a/private");
		change_type("/mnt/a/private", MS_PRIVATE);
		write(fd1[1], &c, 1);
		read(fd2[0], &c, 1);

		fchdir(root_fd);
		in_child();

		write(fd1[1], &c, 1);
		return 0;
	}
	read(fd1[0], &c, 1);
	sprintf(path, "/proc/%d/root", child);
	chdir(path);

	change_type("/mnt", MS_SHARED);
	bind("/mnt/a/private");
	bind("/mnt/a/shared");
	bind("/mnt/a/slave");
	bind("/mnt/a/slave-shared");
	bind("/mnt/no-locked");
	change_type("/mnt/a/private", MS_PRIVATE);
	change_type("/mnt/a/slave", MS_SLAVE);
	change_type("/mnt/a/shared-slave", MS_SLAVE);
	change_type("/mnt/a/shared-slave", MS_SHARED);
	change_type("/mnt/no-locked", MS_PRIVATE);

	in_parent();

	fflush(stdout);
	write(fd2[1], &c, 1);
	read(fd1[0], &c, 1);
	return 0;
}

