Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34F92F75A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 10:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbhAOJlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 04:41:22 -0500
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:33668 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAOJlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:41:21 -0500
Received: from mta03.sjtu.edu.cn (mta03.sjtu.edu.cn [202.121.179.7])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id A46401008D5CB;
        Fri, 15 Jan 2021 17:40:43 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mta03.sjtu.edu.cn (Postfix) with ESMTP id 9470F10DC2F;
        Fri, 15 Jan 2021 17:40:43 +0800 (CST)
X-Virus-Scanned: amavisd-new at mta03.sjtu.edu.cn
Received: from mta03.sjtu.edu.cn ([127.0.0.1])
        by localhost (mta03.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z5wh27GCjnkf; Fri, 15 Jan 2021 17:40:43 +0800 (CST)
Received: from mstore107.sjtu.edu.cn (unknown [10.118.0.107])
        by mta03.sjtu.edu.cn (Postfix) with ESMTP id 7040710DC2C;
        Fri, 15 Jan 2021 17:40:43 +0800 (CST)
Date:   Fri, 15 Jan 2021 17:40:43 +0800 (CST)
From:   Zhongwei Cai <sunrise_l@sjtu.edu.cn>
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     Mingkai Dong <mingkaidong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        Rajesh Tadakamadla <rajesh.tadakamadla@hpe.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Message-ID: <1224425872.715547.1610703643424.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210107151125.GB5270@casper.infradead.org> <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com> <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn> <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com>
Subject: Re: Expense of read_iter
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Originating-IP: [58.196.139.16]
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF84 (Win)/8.8.15_GA_3928)
Thread-Topic: Expense of read_iter
Thread-Index: 9NnrXaYD9vcYqWdfzl2jIg65GnvJ6A==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 14 Jan 2021, Mikulas wrote:

>> I'm working with Mingkai on optimizations for Ext4-dax.
>
> What specific patch are you working on? Please, post it somewhere.

Here is the work-in-progress patch: https://ipads.se.sjtu.edu.cn:1312/opensource/linux/-/tree/ext4-read
It only contains the "read" implementation for Ext4-dax now, though, we
will put other optimizations on it later.

> What happens if you use this trick ( https://lkml.org/lkml/2021/1/11/1612 )
> - detect in the "read_iter" method that there is just one segment and 
> treat it like a "read" method. I think that it should improve performance 
> for your case.

Note that the original Ext4-dax does not implement the "read" method. Instead, it
calls the "dax_iomap_rw" method provided by VFS. So we firstly rewrite
the "read-iter" method which iterates struct iov_iter and calls our
"read" method as a baseline for comparison.

Overall time of 2^26 4KB read:
"read-iter" method with dax-iomap-rw (original)              - 36.477s
"read_iter" method wraps our "read" method                   - 28.950s
"read_iter" method tests for one entry proposed by Mikulas   - 27.947s
"read" method                                                - 26.899s

As we mentioned in the previous email (https://lkml.org/lkml/2021/1/12/710),
the overhead mainly consists of two parts. The first is constructing
struct iov_iter and iterating it (i.e., new_sync, _copy_mc_to_iter and
iov_iter_init). The second is the dax io mechanism provided by VFS (i.e.,
dax_iomap_rw, iomap_apply and ext4_iomap_begin).

For Ext4-dax, the overhead of dax_iomap_rw is significant
compared to the overhead of struct iov_iter. Although methods
proposed by Mikulas can eliminate the overhead of iov_iter
well, they can not be applied in Ext4-dax unless we implement an
internal "read" method in Ext4-dax.

For Ext4-dax, there could be two approaches to optimizing:
1) implementing the internal "read" method without the complexity
of iterators and dax_iomap_rw; 2) optimizing how dax_iomap_rw works.
Since dax_iomap_rw requires ext4_iomap_begin, which further involves
the iomap structure and others (e.g., journaling status locks in Ext4),
we think implementing the internal "read" method would be easier.

As for whether the external .read interface in VFS should be reserved,
since there is still a performance gap (3.9%) between the "read" method
and the optimized "read_iter" method, we think reserving it is better.

Thanks,
Zhongwei
