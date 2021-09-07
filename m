Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A1940237B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 08:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhIGGex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 02:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhIGGex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 02:34:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67CDC061575
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Sep 2021 23:33:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 18so7334082pfh.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Sep 2021 23:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RZTJHIugRhZxZGxFAn4Kwu/l+z5R0P5fBB8NpVuWNBw=;
        b=bwreHUhH2IwN1A5GmLAxMJpLNlSm8SooUoLfErIqqIkeTTiAIaTfpQ7hsPmY5RFnvq
         g7ZwIYCPdazQqlW6RnLo5/+xnGYua1Nosbgeaa24wu9Z/1Q4jx9jpWydNfzh8VANTS1l
         uYgf86HhKlVB8sUdWGsekQCDGwzPm/4cMg60LY3GkDRDsF2aawi1oleDOcr+15cqV4YO
         iUTiPtqLIooA0DdAa0MtD0UJT9dpPQKTMk8HmODcUhZYjpxHGJjthaPQ2g71HqPMrr+X
         PToFx84R2R0q8LwzAM9rF5j4hgeXwbVwXvFzi3ynUcFvJBC5vCOgTyjtww4wjyD0XDjU
         uj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RZTJHIugRhZxZGxFAn4Kwu/l+z5R0P5fBB8NpVuWNBw=;
        b=O91MPPJTVkJsbHCO3u63ewubLuJSUFeEsT7+TszNF1x9CfQ4QMFpZ5ZQCGXPcdn08+
         9lqZuA67+RZYpxKu+RwqfTdf7aQLzhJZuLbkQl3L3wV0+xpz9uZUBLqSzt51SvBR2WD3
         JjivDVrTu6wJFjcx6gpLfOSatwnRhpwTcJQdIiLAsI+CpdRCaO2YlaT2lQUBj62W4Fmj
         MaOd0nO+4kp1JOibjJS6VmD43DVE6WBmhkUzWhg2kxthMYO+q1dFfHFA+26mwKvBruws
         dHXlmrb5lwqvKCivxfN2hMvcXB6rQ5Y0H+SWRuG5NANvMLhtGGzFthaKP8OmtGoizz4A
         VjyA==
X-Gm-Message-State: AOAM531ayDIRzJFslCtXXQ8EAdAMUxcjYOGpZamUIfGqFcxinjFTLofD
        qA1A3eGtc3xxIKxlPunZIA0dfp7Hxbk=
X-Google-Smtp-Source: ABdhPJzY6j1siO54ts+Dj/3UNHzQKbp8tCVibM9dq+mTz4oc2/VcoEO6veXUzajQW8XdOy7wuGkZOQ==
X-Received: by 2002:a63:65c5:: with SMTP id z188mr15515692pgb.35.1630996427017;
        Mon, 06 Sep 2021 23:33:47 -0700 (PDT)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p10sm11752358pge.38.2021.09.06.23.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 23:33:46 -0700 (PDT)
Date:   Tue, 7 Sep 2021 14:33:38 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>
Subject: [regression] fsnotify fails stress test since fsnotify_for_v5.15-rc1
 merged
Message-ID: <20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Since this commit:

commit ec44610fe2b86daef70f3f53f47d2a2542d7094f
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Tue Aug 10 18:12:19 2021 +0300

    fsnotify: count all objects with attached connectors




Kernel fsnotify can't finish a stress testcase that used to pass quickly.

Kernel hung at umount. Can not be killed but restarting the server.

Reproducer text is attached.

Thanks,
Murphy

--- reproducer test.sh start -------------------------------------

#!/bin/bash

cc fanotify_init_stress.c -o fanotify_init_stress || exit
cc fanotify_flush_stress.c -o fanotify_flush_stress || exit

export TIMEOUT=10s
STRESSES="fanotify_flush_stress fanotify_init_stress"

function cleanup_processes()
{
	while ps jf | egrep "fanotify_flush_stress|fanotify_init_stress" | grep -v grep ; do
		killall fanotify_init_stress > /dev/null 2>&1
		killall fanotify_flush_stress > /dev/null 2>&1
		sleep 1
	done
}

SCRATCH_MNT=/fsn

fallocate -l 1G fsn.img || exit
mkfs.xfs -f fsn.img || exit
mkdir -p $SCRATCH_MNT
mount -o loop fsn.img $SCRATCH_MNT || exit

touch $SCRATCH_MNT/testfile
for i in $STRESSES
do
for j in $STRESSES
do
	echo testing $i $j
	./$i $SCRATCH_MNT $TIMEOUT > /dev/null 2>&1 &
	./$i $SCRATCH_MNT/testfile $TIMEOUT > /dev/null 2>&1 &
	./$j $SCRATCH_MNT $TIMEOUT > /dev/null 2>&1 &
	./$j $SCRATCH_MNT/testfile $TIMEOUT > /dev/null 2>&1 &
	sleep $TIMEOUT
	cleanup_processes
done
done
sleep $TIMEOUT
sync
umount $SCRATCH_MNT
rm -rf fsn* tmp
--- reproducer test.sh end -------------------------------------

--- reproducer fanotify_flush_stress.c start----------------
#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <poll.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/fanotify.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char *argv[])
{
	char buf;
	int fd;

#if 0
	/* Check mount point is supplied */
	if (argc != 2) {
		fprintf(stderr, "Usage: %s MOUNT\n", argv[0]);
		exit(EXIT_FAILURE);
	}
#endif

	printf("%s on %s\n", argv[0], argv[1]);
	/* Create the file descriptor for accessing the fanotify API */
	fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
					   O_RDONLY | O_LARGEFILE);
	if (fd == -1) {
		perror("fanotify_init");
		exit(EXIT_FAILURE);
	}

	/* Loop marking all kinds of events and flush */
	while (1) {

		if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
			  FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
			  FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
			  FAN_EVENT_ON_CHILD, -1, argv[1]) == -1)

			perror("fanotify_mark add");

		if (fanotify_mark(fd, FAN_MARK_FLUSH | FAN_MARK_MOUNT,
						0, -1, argv[1]) == -1)
			perror("fanotify_mark flush mount");

		if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
			  FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
			  FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
			  FAN_EVENT_ON_CHILD, -1, argv[1]) == -1)

			perror("fanotify_mark add");

		if (fanotify_mark(fd, FAN_MARK_FLUSH, 0, -1, argv[1]) == -1)
			perror("fanotify_mark flush");
	}

	close(fd);
	exit(EXIT_SUCCESS);
}
--- reproducer fanotify_flush_stress.c end ----------------
--- reproducer fanotify_init_stress.c start -----------_
#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
#include <errno.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/fanotify.h>

int main(int argc, char *argv[])
{
	char buf;
	int fd;
#if 0
	/* Check mount point is supplied */
	if (argc != 2) {
		fprintf(stderr, "Usage: %s MOUNT\n", argv[0]);
		exit(EXIT_FAILURE);
	}
#endif
	printf("%s on %s\n", argv[0], argv[1]);
	while (1) {

		/* Create the file descriptor for accessing the fanotify API */
		fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT |
				FAN_NONBLOCK, O_RDONLY | O_LARGEFILE);
		if (fd == -1)
			perror("fanotify_init");

		if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
				FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM |
				FAN_CLOSE | FAN_OPEN | FAN_ACCESS_PERM |
				FAN_ONDIR | FAN_EVENT_ON_CHILD, -1,
				argv[1]) == -1)
			perror("fanotify_mark");

		close(fd);
	}

	exit(EXIT_SUCCESS);
}
--- reproducer fanotify_init_stress.c end -----------_
