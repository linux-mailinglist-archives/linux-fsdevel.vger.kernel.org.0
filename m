Return-Path: <linux-fsdevel+bounces-56249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B71DCB14F93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 16:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740CF7A040E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B37921C16D;
	Tue, 29 Jul 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rLQeBq3h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94900224AFE
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800823; cv=none; b=JoIbHpzpftRzuBPzx8JdnbZb0qCtB+2cO5TjOjOg/JKxXBGoYIR8elyg5DNbHjHSLKq6/Jdax/j2JTIgOTlTZdO5Aq/Ns07+/XvUPQ8+abdorP6evsvcMxNiNiw5D72ZGdd6P8ROyXriQhKExHQDOnuM1IvEoaG3CI+RwKFgllM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800823; c=relaxed/simple;
	bh=+7M8rXzY4+16SzboMc6aY9+0dHMT2VddmDaI4CFvnrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=REsibcV2JY9FNIkdzMF40IudTnaKyWDlGkedZLigWOorL4pie/Mq1BVYF5Uu6AU66gQya9vwMB/BLePlvnU7ueH8LOy6jkkAmvyQQbk6uRotxEYUKKxb/+ftLK3tVxKPBxOso4jyw0EmZTBtmDfhPSG4tboSZf7Tj+e7qXZsynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rLQeBq3h; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250729145333epoutp01c4cda3c27a40eeb5524fe6a78c7927c2~WwIxLsVuZ0218902189epoutp01C
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 14:53:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250729145333epoutp01c4cda3c27a40eeb5524fe6a78c7927c2~WwIxLsVuZ0218902189epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753800813;
	bh=PP+pElz2+RSofKFlT75ABJcN8YsXyQwIEv+IPUV95YA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=rLQeBq3h/6wnStJ2SQcIvE2zszquk9mUfllDhSV3YyHBXMzDZXNe8P9joITG38ABS
	 ACcgKwO4Cdbg9asul9WEQWv7MsVC0rv8MeBZbIaaovzhEIzKsoIAN9/XE2uT6VKipk
	 H0qAzInw6l2cuFHqQ8sEUGvMGLhrwr34nRWfdfN0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250729145332epcas5p180c684ef6be1ccbaba4309ff264a9731~WwIwbDcP02034720347epcas5p1m;
	Tue, 29 Jul 2025 14:53:32 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bryyh1Sdtz6B9m4; Tue, 29 Jul
	2025 14:53:32 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250729145331epcas5p4821f0ddedbbe425b733bf8330878cb3d~WwIvT3p4P0961609616epcas5p4v;
	Tue, 29 Jul 2025 14:53:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250729145330epsmtip2b14d9505165c46b5ad80306b1e008417~WwIt545I80475604756epsmtip2B;
	Tue, 29 Jul 2025 14:53:29 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, brauner@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 0/5] FDP file I/O
Date: Tue, 29 Jul 2025 20:21:30 +0530
Message-Id: <20250729145135.12463-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250729145331epcas5p4821f0ddedbbe425b733bf8330878cb3d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729145331epcas5p4821f0ddedbbe425b733bf8330878cb3d
References: <CGME20250729145331epcas5p4821f0ddedbbe425b733bf8330878cb3d@epcas5p4.samsung.com>

6.16 enables block I/O path for FDP, but file I/O needs further work.
This was covered in LSFMM [1]; among other things, we discussed
application and kernel-driven placement policies.

The series shows one of the ways to enable application-driven
placement, without resorting to per-FS plumbing.
But filesystem can control the number of streams that
applications get to use. This can be useful for fs-specific
policies or for metadata (placement) about which applications have no
knowledge.

Application interface involves three new fcntls:

- F_GET_MAX_WRITE_STREAMS: To query the number of streams that are
available.
- F_SET_WRITE_STREAM: To set a particular stream on a file.
- F_GET_WRITE_STREAM: To know what stream is set on the file.

An example program using these is attached below [2].

[1] https://lwn.net/Articles/1018642/

[2]
#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <linux/fcntl.h>

#define BUF_SIZE        (4096)

int write_fd(int fd, int st) {

        char buf[BUF_SIZE];
        int ret, set, get;

        if (fd < 0) {
                printf("[!]invalid fd\n");
                return fd;
        }

        ret = fcntl(fd, F_GET_MAX_WRITE_STREAMS);
        if (ret < 0) {
                printf("F_GET_MAX_WRITE_STREAMS: failed (%s)\n", strerror(errno));
                return ret;
        }
        if (st > ret) {
                printf("error in setting stream, available upto %d\n", ret);
                return -1;
        }

        ret = fcntl(fd, F_SET_WRITE_STREAM, st);
        if (ret < 0) {
                printf("F_SET_WRITE_STREAM: failed (%s)\n", strerror(errno));
                return ret;
        }
        set = st;

        ret = fcntl(fd, F_GET_WRITE_STREAM);
        if (ret < 0) {
                printf("F_GET_WRITE_STREAM: failed (%s)\n", strerror(errno));
                return ret;
        }
        get = ret;

        if (get != set)
                printf("unexpected, set %d but get %d\n", set, get);

        ret = write(fd, buf, BUF_SIZE);
        if (ret < BUF_SIZE) {
                printf("failed, wrote %d bytes (expected %d)\n", ret, BUF_SIZE);
                return ret;
        }
        return 0;
}

int main(int argc, char *argv[])
{
        int ret, regfd;

        /* two file writes, one buffered another direct */
        regfd = open("/mnt/f_buffered", O_CREAT | O_RDWR, 0644);
        ret = write_fd(regfd, 7);
        close(regfd);

        regfd = open("/mnt/f_direct", O_CREAT | O_RDWR| O_DIRECT, 0644);
        ret = write_fd(regfd, 6);
        close(regfd);
        return ret;
}


Kanchan Joshi (5):
  fs: add a new user_write_streams() callback
  fs: add the interface to query user write streams
  fs: add a write stream field to the inode
  fs: propagate write stream
  fs: add set and query write stream

 fs/btrfs/extent_io.c       |  1 +
 fs/buffer.c                | 14 ++++++---
 fs/direct-io.c             |  1 +
 fs/ext4/page-io.c          |  1 +
 fs/fcntl.c                 | 64 ++++++++++++++++++++++++++++++++++++++
 fs/inode.c                 |  1 +
 fs/iomap/direct-io.c       |  1 +
 fs/iomap/ioend.c           |  1 +
 fs/mpage.c                 |  1 +
 include/linux/fs.h         |  8 ++++-
 include/uapi/linux/fcntl.h |  7 +++++
 11 files changed, 94 insertions(+), 6 deletions(-)


base-commit: 66639db858112bf6b0f76677f7517643d586e575
-- 
2.25.1


