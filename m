Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88929177153
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 09:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgCCIey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 03:34:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:33414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgCCIey (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:34:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 58FC5AE79;
        Tue,  3 Mar 2020 08:34:52 +0000 (UTC)
Subject: Re: [PATCH 0/5] Simplify /proc/$pid/maps implementation
To:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20200229165910.24605-1-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <af45478c-4b7e-99fa-d623-db08ff47c405@suse.cz>
Date:   Tue, 3 Mar 2020 09:34:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200229165910.24605-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/29/20 5:59 PM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Re: subject, it's not only maps, but also smaps, smaps_rollu, numa_maps

> Back in 2005, we merged a patch from Akamai that sped up /proc/$pid/maps
> by using f_version to stash the user virtual address that we'd just
> displayed.  That wasn't necessary; we can just use the private *ppos for
> the same purpose.  There have also been some other odd choices made over
> the years that use the seq_file infrastructure in some non-idiomatic ways.
> 
> Tested by using 'dd' with various different 'bs=' parameters to check that
> calling ->start, ->stop and ->next at various offsets work as expected.
> 
> Matthew Wilcox (Oracle) (5):
>   proc: Inline vma_stop into m_stop
>   proc: remove m_cache_vma
>   proc: Use ppos instead of m->version
>   seq_file: Remove m->version
>   proc: Inline m_next_vma into m_next

For all of them:

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Thanks!

>  fs/proc/task_mmu.c       | 95 +++++++++++++---------------------------
>  fs/seq_file.c            | 28 ------------
>  include/linux/seq_file.h |  1 -
>  3 files changed, 31 insertions(+), 93 deletions(-)
> 
> base-commit: d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
> 

