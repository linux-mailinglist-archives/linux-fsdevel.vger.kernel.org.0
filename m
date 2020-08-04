Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AE123BC94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgHDOrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 10:47:42 -0400
Received: from relay.sw.ru ([185.231.240.75]:44750 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729287AbgHDOrh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:47:37 -0400
Received: from [192.168.15.159]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k2yDV-00067i-Pa; Tue, 04 Aug 2020 17:47:01 +0300
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
To:     Andrei Vagin <avagin@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <87k0yl5axy.fsf@x220.int.ebiederm.org>
 <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
 <20200804054313.GA100819@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5f040969-b3b6-8174-7f8e-c8f9db6b80ea@virtuozzo.com>
Date:   Tue, 4 Aug 2020 17:47:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804054313.GA100819@gmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.08.2020 08:43, Andrei Vagin wrote:
> On Thu, Jul 30, 2020 at 06:01:20PM +0300, Kirill Tkhai wrote:
>> On 30.07.2020 17:34, Eric W. Biederman wrote:
>>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
>>>
>>>> Currently, there is no a way to list or iterate all or subset of namespaces
>>>> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
>>>> but some also may be as open files, which are not attached to a process.
>>>> When a namespace open fd is sent over unix socket and then closed, it is
>>>> impossible to know whether the namespace exists or not.
>>>>
>>>> Also, even if namespace is exposed as attached to a process or as open file,
>>>> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
>>>> this multiplies at tasks and fds number.
> 
> Could you describe with more details when you need to iterate
> namespaces?
> 
> There are three ways to hold namespaces.
> 
> * processes
> * bind-mounts
> * file descriptors
> 
> When CRIU dumps a container, it enumirates all processes, collects file
> descriptors and mounts. This means that we will be able to collect all
> namespaces, doesn't it?

1)It's not only for CRIU. No one util can read content of another task unix socket like CRIU does.
  Sometimes we may just want to see all mount namespaces to found a mount, which owns a reference on
  a device.
2)In case of CRIU, recursive dump (when you iterate unix socket content, then you find another
  namespace and iterate another unix socket content, then you find one more namespace) is less
  effective and less fast, then dumping different types sequentially: first namespaces, second fds, etc.
3)It's still impossible to collect all namespaces like Pasha wrote.
