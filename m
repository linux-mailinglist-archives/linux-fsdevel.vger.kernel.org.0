Return-Path: <linux-fsdevel+bounces-57831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF88AB25A93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 06:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6093B77D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 04:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D7521882F;
	Thu, 14 Aug 2025 04:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u3MeubJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD837494;
	Thu, 14 Aug 2025 04:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755146565; cv=none; b=D+ZTaoI7G0etm2RvYzoC7XVM1qm/2TbSShEfFfuZI8nHhHTVe889CntttnyUdzCR23b+X0av0K59q6+RR2BrQ7g0oJbP6iYwFDPnTIPbYMLRGaoUz7hoFcwZQpciOhpuNjZsq2WlJCdyyrMkgsX8ZPD+11irWeGAUEqOzHdECHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755146565; c=relaxed/simple;
	bh=8bGvyJez29D5/+dl9A7lkVikC3UeTSga4AX5AJcUFtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+TmxikuoDB1QcY1b1dC4fQQC7hoZYYkR/IpAOKvJlgsTPLGiX95KDtXKiI+S2d1QQOYEtA3c+Sv919VQ9xUUFfsTe4YbrhPcJ+QkMib4f6yew2nKpVWhWL51XzYY5eYGrIYXBBXB/dnI4kUFXa8l8aRTDxnOArckrxg1m82BZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u3MeubJW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CVh0gNUtaEDykFgk/fGYdcYR50NdmbICisfayu+CMAI=; b=u3MeubJWKxiR3WInUk+ppBdHiI
	vhJb9I4AwPyREAN6abS7HBO7s7ESRKkkK66upjj6v+GB+vSoPijhMSwAOAfo/uEP95iMFp3D6/i2A
	CNowo1++qzZIwqOH/rs4acbm5GmuJ3XE143F7m9e90B0HZf3Lfe3z81jN6dC3xR8FQPjuvMySZepN
	sA/jyQBFluVQOf1mQOzccLz8MfJyeV0dal/zA+wg15bPJsN5KkJgTSHqsof0pyryys6eOZKF+AGv0
	So/A6PtPm7H6rYs9iHxO6zcs++0LSfVzujb24zTzsJh4psdurs2s0xBnSXd8ZQmw84j1l+FHNfKa7
	N+0FhGDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umPnT-0000000Goq7-1VdU;
	Thu, 14 Aug 2025 04:42:39 +0000
Date: Thu, 14 Aug 2025 05:42:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Pavel Tikhomirov <snorcht@gmail.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, Andrei Vagin <avagin@google.com>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev,
	Linux API <linux-api@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
Message-ID: <20250814044239.GM222315@ZenIV>
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV>
 <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV>
 <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
 <20250813185601.GJ222315@ZenIV>
 <aJzi506tGJb8CzA3@tycho.pizza>
 <20250813194145.GK222315@ZenIV>
 <CAE1zp77jmFD=rySJVLf6yU+JKZnUpjkBagC3qQHrxPotrccEbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1zp77jmFD=rySJVLf6yU+JKZnUpjkBagC3qQHrxPotrccEbQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 14, 2025 at 12:08:49PM +0800, Pavel Tikhomirov wrote:

> Yes, selftest is very simple and is not covering userns checks.

FWIW, see below for what I've got here at the moment for MOVE_MOUNT_SET_GROUP;
no tests for cross-filesystem and not-a-subtree yet.  At least it does catch
that braino when run on a kernel that doesn't have it fixed ;-)
No do_change_type() tests either yet...

// link with -lcap, assumes userns enabled
// can run both as root and as regular user
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

void test_it(int fd1, char *p1, int fd2, char *p2, int expected)
{
	int flags = MOVE_MOUNT_SET_GROUP;
	int n;

	if (!p1) {
		p1 = "";
		flags |= MOVE_MOUNT_F_EMPTY_PATH;
	}
	if (!p2) {
		p2 = "";
		flags |= MOVE_MOUNT_T_EMPTY_PATH;
	}
	n = move_mount(fd1, p1, fd2, p2, flags);
	if (!n)
		errno = 0;
	if (expected != errno)
		printf(" failed: %d != %d\n", expected, errno);
	else
		printf(" OK\n");
}

int main()
{
	int pipe1[2], pipe2[2];
	char path[40];
	pid_t child;
	int root_fd;
	char c;

	if (pipe(pipe1) < 0 || pipe(pipe2) < 0) {
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
		mount(NULL, "/mnt/", NULL, MS_SHARED, NULL);
		bind("/mnt/a");
		write(pipe1[1], &c, 1);
		fchdir(root_fd);
		read(pipe2[0], &c, 1);
		printf("from should be someplace we have permissions for");
		test_it(AT_FDCWD, "mnt/a", AT_FDCWD, "/mnt/a/private", EPERM);
		printf("to should be someplace we have permissions for");
		test_it(AT_FDCWD, "/mnt/a", AT_FDCWD, "mnt/a/private", EPERM);
		write(pipe1[1], &c, 1);
		return 0;
	}
	read(pipe1[0], &c, 1);
	sprintf(path, "/proc/%d/root", child);
	chdir(path);

	mount(NULL, "/mnt", NULL, MS_SHARED, NULL);
	bind("/mnt/a/private");
	bind("/mnt/a/shared");
	bind("/mnt/a/slave");
	bind("/mnt/a/slave-shared");
	bind("/mnt/no-locked");
	mount(NULL, "/mnt/a/private", NULL, MS_PRIVATE, NULL);
	mount(NULL, "/mnt/a/slave", NULL, MS_SLAVE, NULL);
	mount(NULL, "/mnt/a/shared-slave", NULL, MS_SLAVE, NULL);
	mount(NULL, "/mnt/a/shared-slave", NULL, MS_SHARED, NULL);
	mount(NULL, "/mnt/no-locked", NULL, MS_PRIVATE, NULL);

	printf("from should be mounted (pipes are not)");
	test_it(pipe1[0], NULL, AT_FDCWD, "/mnt/a/private", EINVAL);

	printf("to should be mounted (pipes are not)");
	test_it(AT_FDCWD, "/mnt", pipe1[0], NULL, EINVAL);

	printf("from should be someplace we have permissions for");
	test_it(AT_FDCWD, "mnt/a", AT_FDCWD, "/mnt/a/private", 0);
	mount(NULL, "/mnt/a/private", NULL, MS_PRIVATE, NULL);

	printf("from should be mountpoint");
	test_it(AT_FDCWD, "/mnt/a", AT_FDCWD, "/mnt/a/private", EINVAL);

	printf("to should be mountpoint");
	test_it(AT_FDCWD, "/mnt/a", AT_FDCWD, "/mnt/a/private/b", EINVAL);

	printf("from should not have anything locked in counterpart of to");
	test_it(AT_FDCWD, "mnt", AT_FDCWD, "/mnt/locked", EINVAL);

	printf("from should not have anything locked in counterpart of to");
	test_it(AT_FDCWD, "mnt", AT_FDCWD, "/mnt/no-locked", 0);
	mount(NULL, "/mnt/no-locked", NULL, MS_PRIVATE, NULL);

	fflush(stdout);
	write(pipe2[1], &c, 1);
	read(pipe1[0], &c, 1);
	return 0;
}

