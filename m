Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74B0493518
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 07:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351829AbiASGlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 01:41:10 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:42580 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351795AbiASGlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:41:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V2FvZDV_1642574459;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V2FvZDV_1642574459)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Jan 2022 14:41:01 +0800
Date:   Wed, 19 Jan 2022 14:40:59 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-cachefs] [PATCH v2 00/20] fscache,  erofs: fscache-based
 demand-read semantics
Message-ID: <Yeeye2AUZITDsdh8@B-P7TQMD6M-0146.local>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Tue, Jan 18, 2022 at 09:11:56PM +0800, Jeffle Xu wrote:
> changes since v1:
> - rebase to v5.17
> - erofs: In chunk based layout, since the logical file offset has the
>   same remainder over PAGE_SIZE with the corresponding physical address
>   inside the data blob file, the file page cache can be directly
>   transferred to netfs library to contain the data from data blob file.
>   (patch 15) (Gao Xiang)
> - netfs,cachefiles: manage logical/physical offset separately. (patch 2)
>   (It is used by erofs_begin_cache_operation() in patch 15.)
> - cachefiles: introduce a new devnode specificaly for on-demand reading.
>   (patch 6)
> - netfs,fscache,cachefiles: add new CONFIG_* for on-demand reading.
>   (patch 3/5)
> - You could start a quick test by
>   https://github.com/lostjeffle/demand-read-cachefilesd
> - add more background information (mainly introduction to nydus) in the
>   "Background" part of this cover letter
> 
> [Important Issues]
> The following issues still need further discussion. Thanks for your time
> and patience.
> 
> 1. I noticed that there's refactoring of netfs library[1], and patch 1
> is not needed since [2].
> 
> 2. The current implementation will severely conflict with the
> refactoring of netfs library[1][2]. The assumption of 'struct
> netfs_i_context' [2] is that, every file in the upper netfs will
> correspond to only one backing file. While in our scenario, one file in
> erofs can correspond to multiple backing files. That is, the content of
> one file can be divided into multiple chunks, and are distrubuted over
> multiple blob files, i.e. multiple backing files. Currently I have no
> good idea solving this conflic.
>

Would you mind give more hints on this? Personally, I still think fscache
is useful and clean way for image distribution on-demand load use cases
in addition to cache network fs data as a more generic in-kernel caching
framework. From the point view of current codestat, it has slight
modification of netfslib and cachefiles (except for a new daemon):
 fs/netfs/Kconfig         |   8 +
 fs/netfs/read_helper.c   |  65 ++++++--
 include/linux/netfs.h    |  10 ++

 fs/cachefiles/Kconfig    |   8 +
 fs/cachefiles/daemon.c   | 147 ++++++++++++++++-
 fs/cachefiles/internal.h |  23 +++
 fs/cachefiles/io.c       |  82 +++++++++-
 fs/cachefiles/main.c     |  27 ++++
 fs/cachefiles/namei.c    |  60 ++++++-

Besides, I think that cookies can be set according to data mapping
(instead of fixed per file) will benefit the following scenario in
addition to our on-demand load use cases:
  It will benefit file cache data deduplication. What I can see is that
netfslib may have some follow-on development in order to support
encryption and compression. However, I think cache data deduplication
is also potentially useful to minimize cache storage since many local
fses already support reflink. However, I'm not sure if it's a great
idea that cachefile relies on underlayfs abilities for cache deduplication.
So for cache deduplication scenarios, I'm not sure per-file cookie is
still a good idea for us (or alternatively, maintain more complicated
mapping per cookie inside fscache besides filesystem mapping, too
unnecessary IMO).
  
By the way, in general, I'm not sure if it's a great idea to cache in
per-file basis (especially for too many small files), that is why we
introduced data deduplicated blobs. At least, it's simpler for read-only
fses. Recently, I found another good article to summarize this:
http://0pointer.net/blog/casync-a-tool-for-distributing-file-system-images.html

Thanks,
Gao Xiang
