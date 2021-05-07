Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294763769D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 20:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhEGSGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 14:06:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53470 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhEGSGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 14:06:52 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lf4rH-0000TI-MY; Fri, 07 May 2021 18:05:51 +0000
From:   Colin Ian King <colin.king@canonical.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: splice() from /dev/zero to a pipe does not work (5.9+)
Message-ID: <2add1129-d42e-176d-353d-3aca21280ead@canonical.com>
Date:   Fri, 7 May 2021 19:05:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

While doing some micro benchmarking with stress-ng I discovered that
since linux 5.9 the splicing from /dev/zero to a pipe now fails with
-EINVAL.

I bisected this down to the following commit:

36e2c7421f02a22f71c9283e55fdb672a9eb58e7 is the first bad commit
commit 36e2c7421f02a22f71c9283e55fdb672a9eb58e7
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Sep 3 16:22:34 2020 +0200

    fs: don't allow splice read/write without explicit ops

I'm not sure if this has been reported before, or if it's intentional
behavior or not. As it stands, it's a regression in the stress-ng splice
test case.

Prior to that commit, splicing worked from /dev/zero to a pipe. Below is
an example of the reproducer:

--- reproducer below ---

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

#define FAIL(x) { perror(x); exit(1); }

int main(void)
{
        int fd_in, fd_out, fds[2];
        ssize_t ret;
        loff_t off_in, off_out;
        const size_t len = 4096;

        if ((fd_in = open("/dev/zero", O_RDONLY)) < 0)
                FAIL("open /dev/zero failed");

        /*
         *   /dev/zero -> pipe splice -> pipe splice -> /dev/null
         */
        if (pipe(fds) < 0)
                FAIL("pipe FAILed\n");

        if ((fd_out = open("/dev/null", O_WRONLY)) < 0)
                FAIL("open /dev/null failed");

        ret = splice(fd_in, NULL, fds[1], NULL, len, SPLICE_F_MOVE);
        if (ret < 0)
                FAIL("splice failed");

        ret = splice(fds[0], NULL, fd_out, NULL, len, SPLICE_F_MOVE);
        if (ret < 0)
                FAIL("splice failed");

        return 0;
}
