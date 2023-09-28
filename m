Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4857B1D33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjI1NCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 09:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjI1NCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003501A2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 06:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695906115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SAsGsjUp2akFOXe3NzL6P0KjpNsT5cDYxfpTwl+LFa4=;
        b=XQVJQhVohpfhQ5fI/iDUKOAmbrMY5HcK9rtCinfOJ6YX33lDERels137CZ35fKVjurIALN
        2F4m4PWMRotks6TdNreldwPaQRj2WpjlypEHiSWGlnZjNIv2nS9Pdi+6DlX+tB2cfZM//w
        Vg0bZPj2toGOCHGThqECy7/sIH4nqow=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-hBWdQdNEPsyh2L20HTTogg-1; Thu, 28 Sep 2023 09:01:53 -0400
X-MC-Unique: hBWdQdNEPsyh2L20HTTogg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae686dafedso1100619066b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 06:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695906111; x=1696510911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAsGsjUp2akFOXe3NzL6P0KjpNsT5cDYxfpTwl+LFa4=;
        b=EiMgQpbiiopGwv7ohmsNNp8t/PjmxP1x4A/VN8jT8rczBU/XHyq9+W4FDdKBXkC4dr
         tRbMrLY8HQkqTBbg6WJZhVMQjWZHssR9iutNpgKJ7ivlkP2sC7i1DU10i4DwLlbRg1wT
         Z1DFZ9TlAUPHUoqQd9l7NgDC89PDjcLpZbipq0cI9e9EBD705xryCKE74vt68SZPBNjQ
         g+obDeBSVb05SwxPTEslRSbo9VZtPZ27I+AMfxjnWS2qbBkhK4+da11Hmd86HHsO+Is/
         tcElx4MJtD85bZpirz6HYBrU4JkSmwIydeDRv30UQv2T1Adx6dQkMQEtToihVlySYUco
         096g==
X-Gm-Message-State: AOJu0YyQ+JBmqXyCGySrSwrJVPg6Trxdz7AO8VMBcE0kHEpgskmAcS9i
        HDv8KI/41rStX7FKuhNUuvvSvuP0GER23SWJ4W8fyI0YUMANMYskLeHfuPLnoS5lKyuQuz0KAwp
        FYHG9QLUlaUSE2QSZAM4zUTatMHc25d0Qe5zIXUpWBPAQnbzm/FGVSbsyZBdPs1/qTDhJtDr1rd
        5JMuJ5I0ZiFw==
X-Received: by 2002:a17:906:4d2:b0:9a2:1e03:1572 with SMTP id g18-20020a17090604d200b009a21e031572mr1101954eja.19.1695906110863;
        Thu, 28 Sep 2023 06:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbkaqxJ9P/J0/LxrJDvMMLHi+yyUi9xLnBaJSvjWu4NDQEasTuE+Qb7BbbAr66wxOa1CBnPA==
X-Received: by 2002:a17:906:4d2:b0:9a2:1e03:1572 with SMTP id g18-20020a17090604d200b009a21e031572mr1101898eja.19.1695906110228;
        Thu, 28 Sep 2023 06:01:50 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (94-21-53-31.pool.digikabel.hu. [94.21.53.31])
        by smtp.gmail.com with ESMTPSA id v6-20020a170906380600b0099c53c4407dsm10784863ejc.78.2023.09.28.06.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 06:01:49 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 0/4] querying mount attributes
Date:   Thu, 28 Sep 2023 15:01:42 +0200
Message-ID: <20230928130147.564503-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement mount querying syscalls agreed on at LSF/MM 2023.

Features:

 - statx-like want/got mask

 - allows returning ascii strings (fs type, root, mount point)

 - returned buffer is relocatable (no pointers)


Still missing:

 - man pages

 - kselftest

 - syscalls on non-x86 archs


Please find the test utility at the end of this mail.

  Usage: statmnt [-l] (mnt_id|path)


Git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#statmount-v3


Changes v1..v3:

 - rename statmnt(2) -> statmount(2)

 - rename listmnt(2) -> listmount(2)

 - make ABI 32bit compatible by passing 64bit args in a struct (tested on
   i386 and x32)

 - only accept new 64bit mount IDs

 - fix compile on !CONFIG_PROC_FS

 - call security_sb_statfs() in both syscalls

 - make lookup_mnt_in_ns() static

 - add LISTMOUNT_UNREACHABLE flag to listmnt() to explicitly ask for
   listing unreachable mounts

 - remove .sb_opts

 - remove subtype from .fs_type

 - return the number of bytes used (including strings) in .size

 - rename .mountpoint -> .mnt_point

 - point strings by an offset against char[] VLA at the end of the struct.
   E.g. printf("fs_type: %s\n", st->str + st->fs_type);

 - don't save string lengths

 - extend spare space in struct statmnt (complete size is now 512 bytes)


---
Miklos Szeredi (4):
  add unique mount ID
  namespace: extract show_path() helper
  add statmount(2) syscall
  add listmount(2) syscall

 arch/x86/entry/syscalls/syscall_32.tbl |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 fs/internal.h                          |   2 +
 fs/mount.h                             |   3 +-
 fs/namespace.c                         | 365 +++++++++++++++++++++++++
 fs/proc_namespace.c                    |  10 +-
 fs/stat.c                              |   9 +-
 fs/statfs.c                            |   1 +
 include/linux/syscalls.h               |   8 +
 include/uapi/asm-generic/unistd.h      |   8 +-
 include/uapi/linux/mount.h             |  59 ++++
 include/uapi/linux/stat.h              |   1 +
 12 files changed, 459 insertions(+), 11 deletions(-)

-- 
2.41.0

=== statmnt.c ===
#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <err.h>

/*
 * Structure for getting mount/superblock/filesystem info with statmount(2).
 *
 * The interface is similar to statx(2): individual fields or groups can be
 * selected with the @mask argument of statmount().  Kernel will set the @mask
 * field according to the supported fields.
 *
 * If string fields are selected, then the caller needs to pass a buffer that
 * has space after the fixed part of the structure.  Nul terminated strings are
 * copied there and offsets relative to @str are stored in the relevant fields.
 * If the buffer is too small, then EOVERFLOW is returned.  The actually used
 * size is returned in @size.
 */
struct statmnt {
	__u32 size;		/* Total size, including strings */
	__u32 __spare1;
	__u64 mask;		/* What results were written */
	__u32 sb_dev_major;	/* Device ID */
	__u32 sb_dev_minor;
	__u64 sb_magic;		/* ..._SUPER_MAGIC */
	__u32 sb_flags;		/* MS_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
	__u32 fs_type;		/* [str] Filesystem type */
	__u64 mnt_id;		/* Unique ID of mount */
	__u64 mnt_parent_id;	/* Unique ID of parent (for root == mnt_id) */
	__u32 mnt_id_old;	/* Reused IDs used in proc/.../mountinfo */
	__u32 mnt_parent_id_old;
	__u64 mnt_attr;		/* MOUNT_ATTR_... */
	__u64 mnt_propagation;	/* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
	__u64 mnt_peer_group;	/* ID of shared peer group */
	__u64 mnt_master;	/* Mount receives propagation from this ID */
	__u64 propagate_from;	/* Propagation from in current namespace */
	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
	__u64 __spare2[50];
	char str[];		/* Variable size part containing strings */
};

/*
 * To be used on the kernel ABI only for passing 64bit arguments to statmount(2)
 */
struct __mount_arg {
	__u64 mnt_id;
	__u64 request_mask;
};

/*
 * @mask bits for statmount(2)
 */
#define STMT_SB_BASIC		0x00000001U     /* Want/got sb_... */
#define STMT_MNT_BASIC		0x00000002U	/* Want/got mnt_... */
#define STMT_PROPAGATE_FROM	0x00000004U	/* Want/got propagate_from */
#define STMT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
#define STMT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
#define STMT_FS_TYPE		0x00000020U	/* Want/got fs_type */

/* listmount(2) flags */
#define LISTMOUNT_UNREACHABLE	0x01	/* List unreachable mounts too */

#define __NR_statmount   454
#define __NR_listmount   455

#define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */


static void free_if_neq(void *p, const void *q)
{
	if (p != q)
		free(p);
}

static struct statmnt *statmount(uint64_t mnt_id, uint64_t mask, unsigned int flags)
{
	struct __mount_arg arg = {
		.mnt_id = mnt_id,
		.request_mask = mask,
	};
	union {
		struct statmnt m;
		char s[4096];
	} buf;
	struct statmnt *ret, *mm = &buf.m;
	size_t bufsize = sizeof(buf);

	while (syscall(__NR_statmount, &arg, mm, bufsize, flags) == -1) {
		free_if_neq(mm, &buf.m);
		if (errno != EOVERFLOW)
			return NULL;
		bufsize = MAX(1 << 15, bufsize << 1);
		mm = malloc(bufsize);
		if (!mm)
			return NULL;
	}
	ret = malloc(mm->size);
	if (ret)
		memcpy(ret, mm, mm->size);
	free_if_neq(mm, &buf.m);

	return ret;
}

static int listmount(uint64_t mnt_id, uint64_t **listp, unsigned int flags)
{
	struct __mount_arg arg = {
		.mnt_id = mnt_id,
	};
	uint64_t buf[512];
	size_t bufsize = sizeof(buf);
	uint64_t *ret, *ll = buf;
	long len;

	while ((len = syscall(__NR_listmount, &arg, ll, bufsize / sizeof(buf[0]), flags)) == -1) {
		free_if_neq(ll, buf);
		if (errno != EOVERFLOW)
			return -1;
		bufsize = MAX(1 << 15, bufsize << 1);
		ll = malloc(bufsize);
		if (!ll)
			return -1;
	}
	bufsize = len * sizeof(buf[0]);
	ret = malloc(bufsize);
	if (!ret)
		return -1;

	*listp = ret;
	memcpy(ret, ll, bufsize);
	free_if_neq(ll, buf);

	return len;
}


int main(int argc, char *argv[])
{
	struct statmnt *st;
	char *end;
	const char *arg = argv[1];
	int res;
	int list = 0;
	uint64_t mask = STMT_SB_BASIC | STMT_MNT_BASIC | STMT_PROPAGATE_FROM | STMT_MNT_ROOT | STMT_MNT_POINT | STMT_FS_TYPE;
	uint64_t mnt_id;

	if (arg && strcmp(arg, "-l") == 0) {
		list = 1;
		arg = argv[2];
	}
	if (argc != list + 2)
		errx(1, "usage: %s [-l] (mnt_id|path)", argv[0]);

	mnt_id = strtoll(arg, &end, 0);
	if (!mnt_id || *end != '\0') {
		struct statx sx;

		res = statx(AT_FDCWD, arg, 0, STATX_MNT_ID_UNIQUE, &sx);
		if (res == -1)
			err(1, "%s", arg);

		if (!(sx.stx_mask & (STATX_MNT_ID | STATX_MNT_ID_UNIQUE)))
			errx(1, "Sorry, no mount ID");

		mnt_id = sx.stx_mnt_id;
	}

	if (list) {
		uint64_t *list;
		int num, i;

		res = listmount(mnt_id, &list, LISTMOUNT_UNREACHABLE);
		if (res == -1)
			err(1, "listmnt(%llu)", mnt_id);

		num = res;
		for (i = 0; i < num; i++) {
			printf("0x%llx", list[i]);

			st = statmount(list[i], STMT_MNT_POINT, 0);
			if (!st) {
				printf("\t[%s]\n", strerror(errno));
			} else {
				printf("\t%s\n", (st->mask & STMT_MNT_POINT) ? st->str + st->mnt_point : "???");
			}
			free(st);
		}
		free(list);

		return 0;
	}

	st = statmount(mnt_id, mask, 0);
	if (!st)
		err(1, "statmnt(%llu)", mnt_id);

	printf("size: %u\n", st->size);
	printf("mask: 0x%llx\n", st->mask);
	if (st->mask & STMT_SB_BASIC) {
		printf("sb_dev_major: %u\n", st->sb_dev_major);
		printf("sb_dev_minor: %u\n", st->sb_dev_minor);
		printf("sb_magic: 0x%llx\n", st->sb_magic);
		printf("sb_flags: 0x%08x\n", st->sb_flags);
	}
	if (st->mask & STMT_MNT_BASIC) {
		printf("mnt_id: 0x%llx\n", st->mnt_id);
		printf("mnt_parent_id: 0x%llx\n", st->mnt_parent_id);
		printf("mnt_id_old: %u\n", st->mnt_id_old);
		printf("mnt_parent_id_old: %u\n", st->mnt_parent_id_old);
		printf("mnt_attr: 0x%08llx\n", st->mnt_attr);
		printf("mnt_propagation: %s%s%s%s\n",
		       st->mnt_propagation & MS_SHARED ? "shared," : "",
		       st->mnt_propagation & MS_SLAVE ? "slave," : "",
		       st->mnt_propagation & MS_UNBINDABLE ? "unbindable," : "",
		       st->mnt_propagation & MS_PRIVATE ? "private" : "");
		printf("mnt_peer_group: %llu\n", st->mnt_peer_group);
		printf("mnt_master: %llu\n", st->mnt_master);
	}
	if (st->mask & STMT_PROPAGATE_FROM)
		printf("propagate_from: %llu\n", st->propagate_from);
	if (st->mask & STMT_MNT_ROOT)
		printf("mnt_root: %u <%s>\n", st->mnt_root, st->str + st->mnt_root);
	if (st->mask & STMT_MNT_POINT)
		printf("mnt_point: %u <%s>\n", st->mnt_point, st->str + st->mnt_point);
	if (st->mask & STMT_FS_TYPE)
		printf("fs_type: %u <%s>\n", st->fs_type, st->str + st->fs_type);
	free(st);

	return 0;
}

