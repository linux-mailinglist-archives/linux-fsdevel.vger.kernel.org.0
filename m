Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B643342B266
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 03:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhJMBuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 21:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbhJMBuc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 21:50:32 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6AFC061570;
        Tue, 12 Oct 2021 18:48:28 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id x1so997551iof.7;
        Tue, 12 Oct 2021 18:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FBxwHwk0X+rOYnO9GmJcwxmQ+H/dHZFzpYpSSxOsQlE=;
        b=EiJehrHGbGuNa0m2kRByW7VYY1r3nUsGqr1LCl+pPIvBQa3nfUI/1ACJtoTF6VIWol
         jUqCuKAXbqIGvHtoT+tJEf0KbXINj+KBddNSg72CDpX25d/DgI/Y5SWjjBoJVvSDmuwA
         fazDfQ+DpKtgbs/XXbfQ+Vs1niQ2eq4515nbRbtMbBV2JXGBohWDAz3LOx2jZw6+yB+R
         jIQ7o6BPcUKJSwTy2TQWMa3PjRUuGK0lVLCrOKJ7tT497TAk6+KJd2Q6rPKaK351zAmO
         /lguqa9foooRmchrBThpd28ZEnLsW/PHL/ES3gNB9oKti+GtyNTc+YhdHR17xvaiz5SV
         B1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FBxwHwk0X+rOYnO9GmJcwxmQ+H/dHZFzpYpSSxOsQlE=;
        b=yhO0ikMDJOiaS9qaoBq9QnWZ3Hq49BGfKCXkKBMzp8OWUqnNhtBh6WmYNpx6TcNLJo
         HSxHqXboOqJqtz+WVfpDXfltlFhxTcOu2s62kQMBybOx2c1Wck6FeW3SbJ71VZpuLt6J
         vNeCHrXSUEp1Xzyhd8jbhchcEzbeVUEPeH2H7pWlbD4fALaV00zmCpiYWxvW8yZ8bAE4
         5mUVT3iWiaJUthLs7iiUEHPcZWYLek/NRHoejOAq6gXG7w2fBBAYXZaiG3Ruji2QsMUn
         BKsCW8obrGALYYjw2cK2hRM5HXP9Ftg0xlfTXL1gmDhwkMix0uz9W1AXadlL6uxXcap+
         5fzA==
X-Gm-Message-State: AOAM530ug38CUrNwD4prWTGCumT0N14ay3Kir/A88l4VZPAh5IGxBS8c
        uZypRnb2JKLHRxMKX5kz8wsdBE6+cn8fJ94KCC8=
X-Google-Smtp-Source: ABdhPJzAx0KZf8Scqwt+AFfO79rxNTLWd7BGbokaPTfJl1+YaRp7NguEHUVCYCjezYdVmGKsSR9y29Zqwwlxp9KlqRU=
X-Received: by 2002:a05:6602:2c88:: with SMTP id i8mr18638993iow.48.1634089708166;
 Tue, 12 Oct 2021 18:48:28 -0700 (PDT)
MIME-Version: 1.0
From:   Zhengyuan Liu <liuzhengyuang521@gmail.com>
Date:   Wed, 13 Oct 2021 09:46:46 +0800
Message-ID: <CAOOPZo52azGXN-BzWamA38Gu=EkqZScLufM1VEgDuosPoH6TWA@mail.gmail.com>
Subject: Problem with direct IO
To:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        mysql@lists.mysql.com, linux-ext4@vger.kernel.org,
        =?UTF-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, all

we are encounting following Mysql crash problem while importing tables :

    2021-09-26T11:22:17.825250Z 0 [ERROR] [MY-013622] [InnoDB] [FATAL]
    fsync() returned EIO, aborting.
    2021-09-26T11:22:17.825315Z 0 [ERROR] [MY-013183] [InnoDB]
    Assertion failure: ut0ut.cc:555 thread 281472996733168

At the same time , we found dmesg had following message:

    [ 4328.838972] Page cache invalidation failure on direct I/O.
    Possible data corruption due to collision with buffered I/O!
    [ 4328.850234] File: /data/mysql/data/sysbench/sbtest53.ibd PID:
    625 Comm: kworker/42:1

Firstly, we doubled Mysql has operating the file with direct IO and
buffered IO interlaced, but after some checking we found it did only
do direct IO using aio. The problem is exactly from direct-io
interface (__generic_file_write_iter) itself.

ssize_t __generic_file_write_iter()
{
...
        if (iocb->ki_flags & IOCB_DIRECT) {
                loff_t pos, endbyte;

                written = generic_file_direct_write(iocb, from);
                /*
                 * If the write stopped short of completing, fall back to
                 * buffered writes.  Some filesystems do this for writes to
                 * holes, for example.  For DAX files, a buffered write will
                 * not succeed (even if it did, DAX does not handle dirty
                 * page-cache pages correctly).
                 */
                if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
                        goto out;

                status = generic_perform_write(file, from, pos = iocb->ki_pos);
...
}

From above code snippet we can see that direct io could fall back to
buffered IO under certain conditions, so even Mysql only did direct IO
it could interleave with buffered IO when fall back occurred. I have
no idea why FS(ext3) failed the direct IO currently, but it is strange
__generic_file_write_iter make direct IO fall back to buffered IO, it
seems  breaking the semantics of direct IO.

The reproduced  environment is:
Platform:  Kunpeng 920 (arm64)
Kernel: V5.15-rc
PAGESIZE: 64K
Mysql:  V8.0
Innodb_page_size: default(16K)

Thanks,
