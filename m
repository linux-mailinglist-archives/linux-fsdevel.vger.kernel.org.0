Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F6019A153
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 23:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbgCaVxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 17:53:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57834 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731320AbgCaVxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585691582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7DWwbQKlPN0MbpVazTHqEZ9NSt8J5UXYVsBh1VrbJ7M=;
        b=CNpRPyHgijbI3X1++jbauyCMrEyIbeidZbml3Fv7PjDLmHmU1Wr+dQRlorMtgI3ZH53F9p
        NRppnXvOV5XAWqxkbjxORlaHhlta+nyWssaguFILSQ/l86IlGtKJaLvMkTfLt2jGCE75fT
        3cW6XPhOe/pzLKdFbLUWX5PD50ZWtCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-NtLnUT3pNoq8lBWy2Qte8A-1; Tue, 31 Mar 2020 17:53:01 -0400
X-MC-Unique: NtLnUT3pNoq8lBWy2Qte8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFDA68024DF;
        Tue, 31 Mar 2020 21:52:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 907CB101D480;
        Tue, 31 Mar 2020 21:52:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, dray@redhat.com, kzak@redhat.com,
        mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com,
        raven@themaw.net, andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lennart@poettering.net, cyphar@cyphar.com
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2418285.1585691572.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 31 Mar 2020 22:52:52 +0100
Message-ID: <2418286.1585691572@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> wrote:

> querying all properties of a mount atomically all-at-once,

I don't actually offer that, per se.

Having an atomic all-at-once query for a single mount is actually quite a
burden on the system.  There's potentially a lot of state involved, much o=
f
which you don't necessarily need.

I've tried to avoid the need to do that by adding change counters that can=
 be
queried cheaply.  You read the counters, then you check mounts and superbl=
ocks
for which the counters have changed, and then you re-read the counters.  I=
've
added multiple counters, assigned to different purposes, to make it easier=
 to
pin down what has changed - and so reduce the amount of checking required.

What I have added to fsinfo() is a way to atomically retrieve a list of al=
l
the children of a mount, including, for each mount, the mount ID (which ma=
y
have been reused), a uniquifier (which shouldn't wrap over the kernel
lifetime) and the sum of the mount object and superblock change counters.

This should allow you to quickly rescan the mount tree as fsinfo() can loo=
k up
mounts by mount ID instead of by path or fd.

Below is a sample file from the kernel that scans by this method, displayi=
ng
an ascii art tree of all the mounts under a path or mount.

David
---
// SPDX-License-Identifier: GPL-2.0-or-later
/* Test the fsinfo() system call
 *
 * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
 * Written by David Howells (dhowells@redhat.com)
 */

#define _GNU_SOURCE
#define _ATFILE_SOURCE
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>
#include <errno.h>
#include <time.h>
#include <math.h>
#include <sys/syscall.h>
#include <linux/fsinfo.h>
#include <linux/socket.h>
#include <linux/fcntl.h>
#include <sys/stat.h>
#include <arpa/inet.h>

#ifndef __NR_fsinfo
#define __NR_fsinfo -1
#endif

static __attribute__((unused))
ssize_t fsinfo(int dfd, const char *filename,
	       struct fsinfo_params *params, size_t params_size,
	       void *result_buffer, size_t result_buf_size)
{
	return syscall(__NR_fsinfo, dfd, filename,
		       params, params_size,
		       result_buffer, result_buf_size);
}

static char tree_buf[4096];
static char bar_buf[4096];
static unsigned int children_list_interval;

/*
 * Get an fsinfo attribute in a statically allocated buffer.
 */
static void get_attr(unsigned int mnt_id, unsigned int attr, unsigned int =
Nth,
		     void *buf, size_t buf_size)
{
	struct fsinfo_params params =3D {
		.flags		=3D FSINFO_FLAGS_QUERY_MOUNT,
		.request	=3D attr,
		.Nth		=3D Nth,
	};
	char file[32];
	long ret;

	sprintf(file, "%u", mnt_id);

	memset(buf, 0xbd, buf_size);

	ret =3D fsinfo(AT_FDCWD, file, &params, sizeof(params), buf, buf_size);
	if (ret =3D=3D -1) {
		fprintf(stderr, "mount-%s: %m\n", file);
		exit(1);
	}
}

/*
 * Get an fsinfo attribute in a dynamically allocated buffer.
 */
static void *get_attr_alloc(unsigned int mnt_id, unsigned int attr,
			    unsigned int Nth, size_t *_size)
{
	struct fsinfo_params params =3D {
		.flags		=3D FSINFO_FLAGS_QUERY_MOUNT,
		.request	=3D attr,
		.Nth		=3D Nth,
	};
	size_t buf_size =3D 4096;
	char file[32];
	void *r;
	long ret;

	sprintf(file, "%u", mnt_id);

	for (;;) {
		r =3D malloc(buf_size);
		if (!r) {
			perror("malloc");
			exit(1);
		}
		memset(r, 0xbd, buf_size);

		ret =3D fsinfo(AT_FDCWD, file, &params, sizeof(params), r, buf_size);
		if (ret =3D=3D -1) {
			fprintf(stderr, "mount-%s: %x,%x,%x %m\n",
				file, params.request, params.Nth, params.Mth);
			exit(1);
		}

		if (ret <=3D buf_size) {
			*_size =3D ret;
			break;
		}
		buf_size =3D (ret + 4096 - 1) & ~(4096 - 1);
	}

	return r;
}

/*
 * Display a mount and then recurse through its children.
 */
static void display_mount(unsigned int mnt_id, unsigned int depth, char *p=
ath)
{
	struct fsinfo_mount_topology top;
	struct fsinfo_mount_child child;
	struct fsinfo_mount_info info;
	struct fsinfo_ids ids;
	void *children;
	unsigned int d;
	size_t ch_size, p_size;
	char dev[64];
	int i, n, s;

	get_attr(mnt_id, FSINFO_ATTR_MOUNT_TOPOLOGY, 0, &top, sizeof(top));
	get_attr(mnt_id, FSINFO_ATTR_MOUNT_INFO, 0, &info, sizeof(info));
	get_attr(mnt_id, FSINFO_ATTR_IDS, 0, &ids, sizeof(ids));
	if (depth > 0)
		printf("%s", tree_buf);

	s =3D strlen(path);
	printf("%s", !s ? "\"\"" : path);
	if (!s)
		s +=3D 2;
	s +=3D depth;
	if (s < 38)
		s =3D 38 - s;
	else
		s =3D 1;
	printf("%*.*s", s, s, "");

	sprintf(dev, "%x:%x", ids.f_dev_major, ids.f_dev_minor);
	printf("%10u %8x %2x %x %5s %s",
	       info.mnt_id,
	       (info.sb_changes +
		info.sb_notifications +
		info.mnt_attr_changes +
		info.mnt_topology_changes +
		info.mnt_subtree_notifications),
	       info.attr, top.propagation,
	       dev, ids.f_fs_name);
	putchar('\n');

	children =3D get_attr_alloc(mnt_id, FSINFO_ATTR_MOUNT_CHILDREN, 0, &ch_si=
ze);
	n =3D ch_size / children_list_interval - 1;

	bar_buf[depth + 1] =3D '|';
	if (depth > 0) {
		tree_buf[depth - 4 + 1] =3D bar_buf[depth - 4 + 1];
		tree_buf[depth - 4 + 2] =3D ' ';
	}

	tree_buf[depth + 0] =3D ' ';
	tree_buf[depth + 1] =3D '\\';
	tree_buf[depth + 2] =3D '_';
	tree_buf[depth + 3] =3D ' ';
	tree_buf[depth + 4] =3D 0;
	d =3D depth + 4;

	memset(&child, 0, sizeof(child));
	for (i =3D 0; i < n; i++) {
		void *p =3D children + i * children_list_interval;

		if (sizeof(child) >=3D children_list_interval)
			memcpy(&child, p, children_list_interval);
		else
			memcpy(&child, p, sizeof(child));

		if (i =3D=3D n - 1)
			bar_buf[depth + 1] =3D ' ';
		path =3D get_attr_alloc(child.mnt_id, FSINFO_ATTR_MOUNT_POINT,
				      0, &p_size);
		display_mount(child.mnt_id, d, path + 1);
		free(path);
	}

	free(children);
	if (depth > 0) {
		tree_buf[depth - 4 + 1] =3D '\\';
		tree_buf[depth - 4 + 2] =3D '_';
	}
	tree_buf[depth] =3D 0;
}

/*
 * Find the ID of whatever is at the nominated path.
 */
static unsigned int lookup_mnt_by_path(const char *path)
{
	struct fsinfo_mount_info mnt;
	struct fsinfo_params params =3D {
		.flags		=3D FSINFO_FLAGS_QUERY_PATH,
		.request	=3D FSINFO_ATTR_MOUNT_INFO,
	};

	if (fsinfo(AT_FDCWD, path, &params, sizeof(params), &mnt, sizeof(mnt)) =3D=
=3D -1) {
		perror(path);
		exit(1);
	}

	return mnt.mnt_id;
}

/*
 * Determine the element size for the mount child list.
 */
static unsigned int query_list_element_size(int mnt_id, unsigned int attr)
{
	struct fsinfo_attribute_info attr_info;

	get_attr(mnt_id, FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, attr,
		 &attr_info, sizeof(attr_info));
	return attr_info.size;
}

/*
 *
 */
int main(int argc, char **argv)
{
	unsigned int mnt_id;
	char *path;
	bool use_mnt_id =3D false;
	int opt;

	while ((opt =3D getopt(argc, argv, "m"))) {
		switch (opt) {
		case 'm':
			use_mnt_id =3D true;
			continue;
		}
		break;
	}

	argc -=3D optind;
	argv +=3D optind;

	switch (argc) {
	case 0:
		mnt_id =3D lookup_mnt_by_path("/");
		path =3D "ROOT";
		break;
	case 1:
		path =3D argv[0];
		if (use_mnt_id) {
			mnt_id =3D strtoul(argv[0], NULL, 0);
			break;
		}

		mnt_id =3D lookup_mnt_by_path(argv[0]);
		break;
	default:
		printf("Format: test-mntinfo\n");
		printf("Format: test-mntinfo <path>\n");
		printf("Format: test-mntinfo -m <mnt_id>\n");
		exit(2);
	}

	children_list_interval =3D
		query_list_element_size(mnt_id, FSINFO_ATTR_MOUNT_CHILDREN);

	printf("MOUNT                                 MOUNT ID   CHANGE#  AT P DE=
V   TYPE\n");
	printf("------------------------------------- ---------- -------- -- - --=
--- --------\n");
	display_mount(mnt_id, 0, path);
	return 0;
}

