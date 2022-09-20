Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BCE5BE3C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 12:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiITKwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITKwG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:52:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A783B3A499;
        Tue, 20 Sep 2022 03:52:04 -0700 (PDT)
Date:   Tue, 20 Sep 2022 12:33:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1663670011; bh=wBP7/I9Gh6LWk47k8z87D5gzRBm0BSfiWpd0Ma9utdE=;
        h=Date:From:To:Cc:Subject:From;
        b=nUyYKSjI3iS9IXGjZj/OLgJTIQCdetbGNpieapZN+I5VPiv9ArpZght3a196ZH+Ly
         YfWrDd0968/2hvr1fx+gKfHPGgAWeGmnWhESC8nP7PA9uzeM2eO3T/0TevUQT6EMWP
         otF4DREf3RKRCHcbnAhvZ+DdZPxwqhY1zrGZ8QYA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-nfs@vger.kernel.org, thomas.weissschuh@amadeus.com
Subject: O_LARGEFILE / EOVERFLOW on tmpfs / NFS
Message-ID: <76bedae6-22ea-4abc-8c06-b424ceb39217@t-8ch.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lGPmldGHO6LcANo9"
Content-Disposition: inline
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--lGPmldGHO6LcANo9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi everybody,

it seems there is some inconsistency about how large files that are opened
*without* O_LARGEFILE on different filesystems.

On ext4/btrfs/xfs a large file openend without O_LARGEFILE results in an
EOVERFLOW error to be reported (as documented by open(2) and open(3p)).
On tmpfs/NFS the file is opened successfully but the values returned for
lseek() are bogus.
(See the reproducer attached to this mail.)

This has been reproduced on 5.19.8 but the sources look the same on current
torvalds/master.

Is this intentional? To me it seems this should fail with EOVERFLOW everywhere.
Looking at the sources, the O_LARGEFILE flag is checked in generic_file_open()
but not all filesystems call this function.

If this is a bug would it make sense to hoist this check into the VFS layer so
not all filesystems have to call this manually?
Another question would be about backwards-compatibility becaus fixing it would
prevent applications from opening files they could open before.
On the other hand they could have experienced silent data corruption before.

Thanks,
Thomas

--lGPmldGHO6LcANo9
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="test.c"

/*
 * Compile:
 *   cc -m32 test.c -o test
 *
 * Prepare testfile:
 *   fallocate -l 4294967297 large-file
 *
 * Test:
 *   ./test large-file
 *
 * Result:
 *   Correct: open() fails, exit code 2
 *   Incorrect: Prints an incorrect file size
 *
 * Observation:
 *   Correct on ext4/btrfs
 *   Incorrect on NFS/tmpfs
 */

#include <assert.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

static_assert(sizeof(void *) == 4, "This test only makes sense on 32bit");
static_assert(sizeof(off_t) == 4, "Large file support has to be disabled");

int main(int argc, char **argv)
{
	if (argc != 2)
		return 1;
	int fd = open(argv[1], O_RDONLY);
	if (fd == -1)
		return 2;
	off_t fsize = lseek(fd, 0, SEEK_END);
	printf("file size=%lu\n", fsize);
}

--lGPmldGHO6LcANo9--
