Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE654EF8A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 10:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfKEJZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 04:25:54 -0500
Received: from relay.sw.ru ([185.231.240.75]:43296 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730666AbfKEJZy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:25:54 -0500
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iRv5z-0005iW-15; Tue, 05 Nov 2019 12:25:51 +0300
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
From:   Vasily Averin <vvs@virtuozzo.com>
Cc:     Alexey Kuznetsov <kuznet@virtuozzo.com>
Subject: performance degradation due to extra fuse_update_attributes() call in
 fuse_file_aio_write()
Message-ID: <e4f96f1e-c79e-7f04-5728-86e37e02b229@virtuozzo.com>
Date:   Tue, 5 Nov 2019 12:25:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Miklos,

could you please elaborate the reason of fuse_update_attributes() call in fuse_file_aio_write() ?

After rebase of openVz7 kernel to RHEL7.7 we have found significant performance degradation:
from 136 kiops to 75 kiops during first 10 second and down to 25 kiops later.

The reason of this was an extra fuse_update_attributes() call in fuse_file_aio_write().

Our old code was an equivalent of v6 patch version submitted by Maxim Patlasov
https://lkml.org/lkml/2013/10/10/281
 fuse_file_aio_write():

       if (get_fuse_conn(inode)->writeback_cache)
               return generic_file_aio_write(iocb, iov, nr_segs, pos);

However in final commit 4d99ff8f12eb "fuse: Turn writeback cache on" you have included an additional fuse_update_attributes() call

 fuse_file_aio_write():

       if (get_fuse_conn(inode)->writeback_cache) {
               /* Update size (EOF optimization) and mode (SUID clearing) */
               err = fuse_update_attributes(mapping->host, NULL, file, NULL);
               if (err)
                       return err;

               return generic_file_aio_write(iocb, iov, nr_segs, pos);
       }

Unfortunately we did not found any description related to this change.

Could you please elaborate which kind of the problem you have noticed in v6 patch version
and explain how fuse_update_attributes() call fixes it?

Thank you,
	Vasily Averin
