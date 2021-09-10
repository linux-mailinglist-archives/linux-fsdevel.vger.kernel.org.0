Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805C9406596
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 04:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhIJCPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 22:15:43 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50104 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhIJCPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 22:15:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=escape@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UnqXATB_1631240069;
Received: from B-W5MSML85-1937.local(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0UnqXATB_1631240069)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Sep 2021 10:14:29 +0800
From:   "taoyi.ty" <escape@linux.alibaba.com>
Subject: Re: [RFC PATCH 1/2] add pinned flags for kernfs node
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shanpeic@linux.alibaba.com
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <e753e449240bfc43fcb7aa26dca196e2f51e0836.1631102579.git.escape@linux.alibaba.com>
 <YTiuBaiVZhe3db9O@kroah.com>
Message-ID: <3d871bd0-dab5-c9ca-61b9-6aa137fa9fdf@linux.alibaba.com>
Date:   Fri, 10 Sep 2021 10:14:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTiuBaiVZhe3db9O@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2021/9/8 下午8:35, Greg KH wrote:
> Why are kernfs changes needed for this?  kernfs creation is not
> necessarily supposed to be "fast", what benchmark needs this type of
> change to require the addition of this complexity?

The implementation of the cgroup pool should have nothing

to do with kernfs, but during the development process,

I found that when there is a background cpu load, it takes

a very significant time for a process to get the mutex from

being awakened to starting execution.

To create 400 cgroups concurrently, if there is no background

cpu load, it takes about 80ms, but if the cpu usage rate is

40%, it takes about 700ms. If you reduce

sched_wakeup_granularity_ns, the time consumption will also

be reduced. If you change mutex to spinlock, the situation

will be very much improved.

So to solve this problem, mutex should not be used. The

cgroup pool relies on kernfs_rename which uses

kernfs_mutex, so I need to bypass kernfs_mutex and

add a pinned flag for this.

Because the lock mechanism of kernfs_rename has been

changed, in order to maintain data consistency, the creation

and deletion of kernfs have also been changed accordingly

I admit that this is really not a very elegant design, but I don’t

know how to make it better, so I throw out the problem and

try to seek help from the community.


thanks,


Yi Tao

