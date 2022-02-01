Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E014A55C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 04:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiBAD6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 22:58:04 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:54879 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233378AbiBAD6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 22:58:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V3MGZMP_1643687876;
Received: from B-P7TQMD6M-0146(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V3MGZMP_1643687876)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Feb 2022 11:57:58 +0800
Date:   Tue, 1 Feb 2022 11:57:56 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     David Howells <dhowells@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Eryu Guan <eguan@linux.alibaba.com>
Subject: Re: [LSF/MM/BPF TOPIC] Netfs support library
Message-ID: <YfivxC9S52FlyKoL@B-P7TQMD6M-0146>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Eryu Guan <eguan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2571706.1643663173@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Mon, Jan 31, 2022 at 09:06:13PM +0000, David Howells wrote:
> I've been working on a library (in fs/netfs/) to provide network filesystem
> support services, with help particularly from Jeff Layton.  The idea is to
> move the common features of the VM interface, including request splitting,
> operation retrying, local caching, content encryption, bounce buffering and
> compression into one place so that various filesystems can share it.
> 
> This also intersects with the folios topic as one of the reasons for this now
> is to hide as much of the existence of folios/pages from the filesystem,
> instead giving it persistent iov iterators to describe the buffers available
> to it.
> 
> It could be useful to get various network filesystem maintainers together to
> discuss it and how to do parts of it and how to roll it out into more
> filesystems if it suits them.  This might qualify more for a BoF session than
> a full FS track session.

We are interested in fscache on-demand read use cases, assuming fscache
plans to be a generic filesystem caching framework besides just caching
network data [1] [2] [3].

So fscache is still preferred to us instead of re-inventing another
cache-managing wheel like this and the modification seems very limited.
We hope this feature could be upstreamed this year in order to benefit
the whole container image ecosystem. Jeffle will post v3 after lunar
new year holidays.

I also think more potential possibility, such as fscache over iomap
interface or similiar, since iomap is also another powerful I/O
framework. IMHO, at least having a unique interface in the long
term may be a good idea for all fses.

> 
> Further, discussion of designing a more effective cache backend could be
> useful.  I'm thinking along the lines of something that can store its data on
> a single file (or a raw blockdev) with indexing along the lines of what
> filesystem drivers such as openafs do.

With my own limited understanding, I'm not sure how one single huge
file works quite well (assuming appending write is needed comparing
with raw blockdev). Or you may need some fallocate() to allocate space
in bulk if there is not enough caching space, which is much like what
now databases do.

[1] https://lore.kernel.org/r/20220118131216.85338-1-jefflexu@linux.alibaba.com
[2] https://lore.kernel.org/r/Yeeye2AUZITDsdh8@B-P7TQMD6M-0146.local
[3] https://lore.kernel.org/r/8f73d28e-db30-f2e4-0143-9d75c4b13087@linux.alibaba.com

Thanks,
Gao Xiang

> 
> David
> 
