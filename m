Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB3140658D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 04:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhIJCN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 22:13:56 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:46026 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhIJCNz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 22:13:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=escape@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Unqfudi_1631239952;
Received: from B-W5MSML85-1937.local(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0Unqfudi_1631239952)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Sep 2021 10:12:33 +0800
From:   "taoyi.ty" <escape@linux.alibaba.com>
Subject: Re: [RFC PATCH 0/2] support cgroup pool in v1
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        shanpeic@linux.alibaba.com
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <YTjmP0EGEWGYhroM@slm.duckdns.org>
Message-ID: <7b8d68c6-9a1c-dc19-e430-e044e4c4f210@linux.alibaba.com>
Date:   Fri, 10 Sep 2021 10:12:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTjmP0EGEWGYhroM@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am glad to receive your reply.

cgroup pool is a relatively simple solution that I think can

solve the problem.

I have tried making locking more granular, but in the end found

it too diffcult. cgroup_mutex protects almost all operation related

to cgroup. If not use cgroup_mutex, I have no idea how to design

lock mechanism to take both concurrent performance and

existing interfaces into account. Do you have any good advice?


thanks,


Yi Tao


On 2021/9/9 上午12:35, Tejun Heo wrote:
> Hello,
>
> On Wed, Sep 08, 2021 at 08:15:11PM +0800, Yi Tao wrote:
>> In order to solve this long-tail delay problem, we designed a cgroup
>> pool. The cgroup pool will create a certain number of cgroups in advance.
>> When a user creates a cgroup through the mkdir system call, a clean cgroup
>> can be quickly obtained from the pool. Cgroup pool draws on the idea of
>> cgroup rename. By creating pool and rename in advance, it reduces the
>> critical area of cgroup creation, and uses a spinlock different from
>> cgroup_mutex, which reduces scheduling overhead on the one hand, and eases
>> competition with attaching processes on the other hand.
> I'm not sure this is the right way to go about it. There are more
> conventional ways to improve scalability - making locking more granular and
> hunting down specific operations which take long time. I don't think cgroup
> management operations need the level of scalability which requires front
> caching.
>
> Thanks.
>
